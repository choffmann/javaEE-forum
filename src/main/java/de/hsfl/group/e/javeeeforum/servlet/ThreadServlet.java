package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import jersey.repackaged.com.google.common.collect.Lists;
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
import java.util.Comparator;
import java.util.List;
import java.util.stream.Collectors;

@WebServlet(name = "threadServlet", value = "/threadServlet")
public class ThreadServlet extends HttpServlet {

    //Normale Homepage Abfrage;
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        // TODO: Falls nicht eingeloggt zu login redirecten
        String threadId = request.getParameter("threadid");
        String searchRequest = request.getParameter("searchrequest");
        WebTarget target = startConnection();
        if(threadId != null){
            //Abfrage eines spezifischen Posts
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
        }else if (searchRequest != null){
            //Abfrage von Threads nach Suchkriterium
            //TODO: Richtige Abfrage, aber ThreadService.java hat keinen Endpunkt zur Suche
            List<ThreadDto> threads = target.path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<ThreadDto>>() {
                    });
            threads= Lists.reverse(threads); //Eigentlich sollten sie schon direkt richtig ankommen, da sie es aber nicht tun, wird hier quasi "sortiert"
            request.setAttribute("title", "Die neusten Threads");
            request.setAttribute("threads", threads);
            request.getRequestDispatcher("/jsp/threadList.jsp").forward(request, response);
        }else{
            //Abfrage aller Threads, homepage Seite
            List<ThreadDto> threads = target.path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                    new GenericType<List<ThreadDto>>() {
                    });
            threads= Lists.reverse(threads); //Eigentlich sollten sie schon direkt richtig ankommen, da sie es aber nicht tun, wird hier quasi "sortiert"
            request.setAttribute("title", "Die neusten Threads");
            request.setAttribute("threads", threads);
            request.getRequestDispatcher("/jsp/threadList.jsp").forward(request, response);
        }
    }

    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {

    }
    private WebTarget startConnection(){
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }
}