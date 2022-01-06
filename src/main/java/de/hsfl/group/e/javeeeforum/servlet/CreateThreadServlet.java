package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.*;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

@WebServlet(name = "createThreadServlet", value = "/createThreadServlet")
public class CreateThreadServlet extends HttpServlet {

    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgf.isLoggedIn(request, response);
        WebTarget target = sgf.startConnection();
        request.setAttribute("userData", userData);
        try {
            List<CategoryDto> categories = target.path("categories").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<CategoryDto>>() {
                    });
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("/jsp/createThread.jsp").forward(request, response);
        } catch (NotFoundException | NotAuthorizedException e) {
            request.setAttribute("errorStatus", e.getResponse().getStatus());
            request.setAttribute("errorMessage", e.getResponse().readEntity(String.class));
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        WebTarget target = sgf.startConnection();
        Long categoryId = Long.valueOf(request.getParameter("categoryid"));

        String tags = request.getParameter("tag").replaceAll(" ", "");
        List<String> tagsList = Arrays.asList(tags.split(","));

        ThreadDto threadDto = new ThreadDto();
        threadDto.setTitle(request.getParameter("title"));
        threadDto.setText(request.getParameter("text"));
        threadDto.setTags(tagsList);
        CategoryDto categoryDto = new CategoryDto();
        categoryDto.setId(categoryId);
        threadDto.setCategory(categoryDto);

        try {
            target.queryParam("creatorid", userData.getCreatorDto().getId()).path("threads")
                    .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(threadDto));

            response.sendRedirect(request.getContextPath() + "/threadServlet");
        } catch (NotFoundException | NotAuthorizedException e) {
            request.setAttribute("errorStatus", e.getResponse().getStatus());
            request.setAttribute("errorMessage", e.getResponse().readEntity(String.class));
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }
}
