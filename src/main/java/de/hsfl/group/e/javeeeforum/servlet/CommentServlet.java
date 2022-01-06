package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;

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

@WebServlet(name = "commentServlet", value = "/commentServlet")
public class CommentServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    //Antwort senden
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgf.isLoggedIn(request, response);
        WebTarget target = sgf.startConnection();
        request.setCharacterEncoding("UTF-8");
        String threadId = request.getParameter("threadid");
        String answerId = request.getParameter("answerid");
        String text = request.getParameter("commenttext");
        try {
            //Sendet die Antwort an den Server
            target.queryParam("creatorid", userData.getCreatorDto().getId()).path("threads/" + threadId + "/answers/" + answerId + "/comments").request().accept(MediaType.APPLICATION_JSON).post(Entity.json(text));
            //Fragt die Seite neu ab, ggf. später mit der serverResponse URL umändern
            response.sendRedirect(request.getContextPath() + "/threadServlet?threadid=" + threadId);
        } catch (NotFoundException | NotAuthorizedException e) {
            request.setAttribute("errorStatus", e.getResponse().getStatus());
            request.setAttribute("errorMessage", e.getResponse().readEntity(String.class));
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }
    }

}