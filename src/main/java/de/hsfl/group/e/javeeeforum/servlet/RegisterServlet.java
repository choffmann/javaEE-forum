package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;

import javax.inject.Inject;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.BadRequestException;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.client.Entity;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.MediaType;
import java.io.IOException;

@WebServlet(name = "registerServlet", value = "/registerServlet")
public class RegisterServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        WebTarget target = sgf.startConnection();
        request.setCharacterEncoding("UTF-8");
        CreatorDto creatorDto = new CreatorDto();
        creatorDto.setUsername(request.getParameter("registerUsername"));
        creatorDto.setEmail(request.getParameter("registerEmail"));
        creatorDto.setPassword(request.getParameter("registerPassword"));
        try {
            CreatorDto registeredUser = target.path("users/register")
                    .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(creatorDto), CreatorDto.class);
            userData.setCreatorDto(registeredUser);
            response.sendRedirect(request.getContextPath() + "/threadServlet");
        } catch (NotFoundException | NotAuthorizedException | BadRequestException e) {
            response.sendRedirect(request.getContextPath() + "/jsp/register.jsp?error=" +
                    e.getResponse().readEntity(String.class));
        }
    }
}
