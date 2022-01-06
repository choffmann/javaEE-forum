package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;

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
import javax.ws.rs.core.MediaType;
import java.io.IOException;

@WebServlet(name = "loginServlet", value = "/loginServlet")
public class LoginServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //Beim Aufruf wird man immer ausgelogged und zum Login.jsp gebracht
        userData.setCreatorDto(null);
        request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        WebTarget target = sgf.startConnection();
        CreatorDto creatorDto = new CreatorDto();
        creatorDto.setUsername(request.getParameter("loginUsername"));
        creatorDto.setPassword(request.getParameter("loginPassword"));
        try {
            CreatorDto logedinUser = target.path("users/login")
                    .request().accept(MediaType.APPLICATION_JSON).post(Entity.json(creatorDto), CreatorDto.class);
            userData.setCreatorDto(logedinUser);
            response.sendRedirect(request.getContextPath() + "/threadServlet");
        } catch (NotFoundException | NotAuthorizedException e){
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp?error=" +
                    e.getResponse().readEntity(String.class));
        }
    }

}
