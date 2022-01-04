package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.*;
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
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        WebTarget target = startConnection();
        ThreadDto threadDto = new ThreadDto();
        threadDto.setTitle(request.getParameter("title"));
        threadDto.setTitle(request.getParameter("text"));
        threadDto.setCreator(userData.getCreatorDto());
        Response response1 = target.path("threads")
                .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(threadDto));
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}
