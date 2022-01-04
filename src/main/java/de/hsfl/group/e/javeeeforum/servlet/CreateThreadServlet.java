package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.*;
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
import java.util.Arrays;
import java.util.Collections;
import java.util.List;

@WebServlet(name = "createThreadServlet", value = "/createThreadServlet")
public class CreateThreadServlet extends HttpServlet {

    @Inject
    UserData userData;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // TODO: Falls nicht eingeloggt zu login redirecten
        WebTarget target = startConnection();
        request.setAttribute("userData", userData);

        List<CategoryDto> categories = target.path("categories").request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<CategoryDto>>() {
                });
        request.setAttribute("categories", categories);
        /*
        List<TagDto> tags = target.path("tags").request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<TagDto>>() {
                });
        request.setAttribute("tags", tags);
        */
        request.getRequestDispatcher("/jsp/createThread.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        WebTarget target = startConnection();
        Long categoryId = Long.valueOf(request.getParameter("categoryid"));

        String tags = request.getParameter("tag");
        List<String> tagsList = Arrays.asList(tags.split(", "));

        ThreadDto threadDto = new ThreadDto();
        threadDto.setTitle(request.getParameter("title"));
        threadDto.setText(request.getParameter("text"));
        threadDto.setTags(tagsList);
        // threadDto.setCategory(Collections.singletonList(categoryId));
        threadDto.setCategory(categoryId);

        Response response1 = target.queryParam("creatorid", userData.getCreatorDto().getId()).path("threads")
                .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(threadDto));

        response.sendRedirect(request.getContextPath() + "/threadServlet");
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}
