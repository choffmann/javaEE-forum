package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
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
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;

@WebServlet(name = "commentServlet", value = "/commentServlet")
public class CommentServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgl;
    //Antwort senden
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgl.isLoggedIn(request,response);
        WebTarget target = sgl.startConnection();
        String threadId = request.getParameter("threadid");
        String answerId = request.getParameter("answerid");
        String text = request.getParameter("commenttext");
        System.out.println("threadid:"+threadId+"; AnswerId: "+answerId+"; text= "+text);
        //Sendet die Antwort an den Server
        Response serverResponse = target.queryParam("creatorid",userData.getCreatorDto().getId()).path("threads/"+threadId+"/answers/"+answerId+"/comments").request().accept(MediaType.APPLICATION_JSON).post(Entity.json(text));
        //Fragt die Seite neu ab, ggf. später mit der serverResponse URL umändern
        response.sendRedirect(request.getContextPath() + "/threadServlet?threadid="+threadId);
    }
}