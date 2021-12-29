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

@WebServlet(name = "answerServlet", value = "/answerServlet")
public class AnswerServlet extends HttpServlet {

    //Antwort senden
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String threadId = request.getParameter("threadid");
        String answerText = request.getParameter("answertext");
        //String creator = request.getParameter("creator");
        String creator = "Pascal";
        System.out.println(threadId+" "+creator+" "+answerText);
        //TODO: Antwort posten
        WebTarget target = startConnection();
        target.queryParam("creator",creator);
        //Sendet die Antwort an den Server
        Response serverResponse = target.path("threads/"+threadId+"/answers").request().accept(MediaType.APPLICATION_JSON).post(Entity.entity(answerText,MediaType.APPLICATION_JSON));
        //Fragt die Seite neu ab, ggf. später mit der serverResponse URL umändern
        request.setAttribute("threadid",threadId);
        request.getRequestDispatcher("java/de/hsfl/group/e/javeeeforum/servlet/ThreadServlet.java").forward(request, response);
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}