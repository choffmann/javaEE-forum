package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import jersey.repackaged.com.google.common.collect.Lists;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "categoryServlet", value = "/categoryServlet")
public class CategoryServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    //Antwort senden
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgf.isLoggedIn(request, response);
        WebTarget target = sgf.startConnection();
        request.setCharacterEncoding("UTF-8");
        String categoryId = request.getParameter("categoryid");
        request.setAttribute("userData", userData);
        try {
            if (categoryId == null) {
                List<CategoryDto> categories = target.path("categories").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<CategoryDto>>() {
                        });
                request.setAttribute("categories", categories);
                request.getRequestDispatcher("jsp/categories.jsp").forward(request, response);
            } else {
                List<ThreadDto> threads = Lists.reverse(target.queryParam("category", categoryId).path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<ThreadDto>>() {
                        }));
                request.setAttribute("title", "Threads der Kategorie mit der ID: " + categoryId); //Kann man auch schöner machen mit extra request an categories/{id}.text für den Namen
                String categoryName = target.path("categories/" + categoryId).request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<CategoryDto>() {
                        }).getText();
                request.setAttribute("title", "Threads der Kategorie: " + categoryName); //Kann man auch schöner machen mit extra request an categories/{id}.text für den Namen
                request.setAttribute("threads", threads);
                request.getRequestDispatcher("jsp/threadList.jsp").forward(request, response);
            }
        } catch (NotFoundException | NotAuthorizedException e) {
            request.setAttribute("errorStatus", e.getResponse().getStatus());
            request.setAttribute("errorMessage", e.getResponse().readEntity(String.class));
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}