package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
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

@WebServlet(name = "loginServlet", value = "/loginServlet")
public class LoginServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgl;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        WebTarget target = sgl.startConnection();
        CreatorDto creatorDto = new CreatorDto();
        creatorDto.setUsername(request.getParameter("loginUsername"));
        creatorDto.setPassword(request.getParameter("loginPassword"));
        CreatorDto logedinUser = target.path("users/login")
                .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(creatorDto), CreatorDto.class);
        userData.setCreatorDto(logedinUser);
        response.sendRedirect(request.getContextPath() + "/threadServlet");
    }

}
