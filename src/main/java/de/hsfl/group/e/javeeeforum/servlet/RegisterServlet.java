package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;
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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;

@WebServlet(name = "registerServlet", value = "/registerServlet")
public class RegisterServlet extends HttpServlet {
    @Inject
    UserData userData;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        WebTarget target = startConnection();
        CreatorDto creatorDto = new CreatorDto();
        creatorDto.setUsername(request.getParameter("registerUsername"));
        creatorDto.setEmail(request.getParameter("registerEmail"));
        creatorDto.setPassword(request.getParameter("registerPassword"));
        CreatorDto registeredUser = target.path("users/register")
                .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(creatorDto), CreatorDto.class);
        userData.setCreatorDto(registeredUser);
        response.sendRedirect(request.getContextPath() + "/threadServlet");
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}