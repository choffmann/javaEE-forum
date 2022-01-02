package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import jersey.repackaged.com.google.common.collect.Lists;
import org.glassfish.jersey.client.ClientConfig;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "categoryServlet", value = "/categoryServlet")
public class CategoryServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgl;
    //Antwort senden
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgl.isLoggedIn(request,response);
        WebTarget target = sgl.startConnection();
        String categoryId = request.getParameter("categoryid");
        if (categoryId == null) {
            List<CategoryDto> categories = target.path("categories").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<CategoryDto>>() {
                    });
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("jsp/categories.jsp").forward(request, response);
        }
        else{
            List<ThreadDto> threads = target.queryParam("category",categoryId).path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<ThreadDto>>() {
                    });
            threads= Lists.reverse(threads);
            request.setAttribute("title", "Threads der Kategorie mit der ID: "+categoryId); //Kann man auch schöner machen mit extra request an categories/{id}.text für den Namen
            request.setAttribute("threads", threads);
            request.getRequestDispatcher("jsp/threadList.jsp").forward(request, response);
        }


    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
    private void isLoggedIn(HttpServletRequest request,HttpServletResponse response) throws ServletException, IOException {
        if (userData.getCreatorDto() == null){
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
        request.setAttribute("userData", userData);
    }
}