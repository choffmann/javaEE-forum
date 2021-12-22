package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import org.glassfish.jersey.client.ClientConfig;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "threadServlet", value = "/threadServlet")
public class ThreadServlet extends HttpServlet {

    //Normale Homepage Abfrage;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // TODO: Falls nicht eingeloggt zu login redirecten
        WebTarget target = startConnection();

        //TODO: Query an die request, falls nach threads gesucht wurde
        List<ThreadDto> threads = target.path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<ThreadDto>>() {
                });
        request.setAttribute("threads", threads);
        request.getRequestDispatcher("/jsp/homepage.jsp").forward(request, response);
    }
    //Abfrage
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        String threadId = request.getParameter("threadid");
        //Request die Threaddaten zu bekommen über queryparameter id
        WebTarget target = startConnection();
        //Unnötig, wird aber für creator wieder gebraucht: target.queryParam("id",threadId);
        ThreadDto thread = target.path("threads/"+threadId).request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<ThreadDto>() {
                });
        List<AnswerDto> answers = target.path("threads/"+threadId+"/answers").request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<AnswerDto>>() {
                });
        request.setAttribute("thread", thread);
        request.setAttribute("answers", answers);
        //Comments sind schon unter den answers in ner Liste gespeichert.
        request.getRequestDispatcher("/jsp/thread.jsp").forward(request, response);
    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}