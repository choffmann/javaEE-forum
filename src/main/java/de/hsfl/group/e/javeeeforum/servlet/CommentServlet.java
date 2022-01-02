package de.hsfl.group.e.javeeeforum.servlet;

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
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;

@WebServlet(name = "commentServlet", value = "/commentServlet")
public class CommentServlet extends HttpServlet {

    //Antwort senden
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String threadId = request.getParameter("threadid");
        String answerId = request.getParameter("answerid");
        String text = request.getParameter("commenttext");
        System.out.println("threadid:"+threadId+"; AnswerId: "+answerId+"; text= "+text);
        long creatorId = 5L; //Queryparameter muss CreatorID in Long sein //TODO: Richtigen User einbinden
        WebTarget target = startConnection();
        //Sendet die Antwort an den Server
        Response serverResponse = target.queryParam("creatorid",creatorId).path("threads/"+threadId+"/answers/"+answerId+"/comments").request().accept(MediaType.APPLICATION_JSON).post(Entity.json(text));
        //Fragt die Seite neu ab, ggf. später mit der serverResponse URL umändern
        new ThreadServlet().doGet(request,response);
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}