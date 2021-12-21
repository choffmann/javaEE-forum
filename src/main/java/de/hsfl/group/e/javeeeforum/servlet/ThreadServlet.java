package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.dto.ThreadDto;

import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.*;
import org.glassfish.jersey.client.ClientConfig;

@WebServlet(name = "threadServlet", value = "/threadServlet")
public class ThreadServlet extends HttpServlet {
    private List<ThreadDto> threads;


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //TODO: Abfrage an den Endpunkt
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        WebTarget target = client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());

        threads = target.path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<ThreadDto>>() {});

        request.setAttribute("threads", threads);
        request.getRequestDispatcher("/index.jsp").forward(request, response);

    }
}