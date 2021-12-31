package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.dto.CategoryDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import org.glassfish.jersey.client.ClientConfig;

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

    //Antwort senden
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String categoryId = request.getParameter("categoryid");
        WebTarget target = startConnection();
        if (categoryId == null) {
            List<CategoryDto> categories = target.path("categories").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<CategoryDto>>() {
                    });
            request.setAttribute("categories", categories);
            request.getRequestDispatcher("jsp/categories.jsp").forward(request, response);
        }
        else{
            CategoryDto category = target.path("categories/"+categoryId).request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<CategoryDto>() {
                    });
            request.setAttribute("category", category);
            request.getRequestDispatcher("jsp/search.jsp").forward(request, response);
        }


    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}