package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.ServletGlobalFunctions;
import de.hsfl.group.e.javeeeforum.UserData;
import de.hsfl.group.e.javeeeforum.dto.AnswerDto;
import de.hsfl.group.e.javeeeforum.dto.CreatorDto;
import de.hsfl.group.e.javeeeforum.dto.ThreadDto;
import jersey.repackaged.com.google.common.collect.Lists;

import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.NotAuthorizedException;
import javax.ws.rs.NotFoundException;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "threadServlet", value = "/threadServlet")
public class ThreadServlet extends HttpServlet {
    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    //Alle Abfragen von Threads kommen hier rein
    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        if (!sgf.isLoggedIn(request, response))
            return;
        WebTarget target = sgf.startConnection();
        request.setCharacterEncoding("UTF-8");
        String threadId = request.getParameter("threadid");
        String searchRequest = request.getParameter("searchrequest");
        String creatorId = request.getParameter("creatorid");
        request.setAttribute("userData", userData);

        try {
            if (threadId != null) {
                //Abfrage eines spezifischen Posts
                ThreadDto thread = target.path("threads/" + threadId).request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<ThreadDto>() {
                        });
                List<AnswerDto> answers = target.path("threads/" + threadId + "/answers").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<AnswerDto>>() {
                        });
                request.setAttribute("thread", thread);
                request.setAttribute("answers", answers);
                //Comments sind schon unter den answers in ner Liste gespeichert.
                request.getRequestDispatcher("/jsp/thread.jsp").forward(request, response);
            } else if (searchRequest != null) {
                //Abfrage von Threads nach Suchkriterium
                List<ThreadDto> threads = target.queryParam("searchText", searchRequest).path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<ThreadDto>>() {
                        });
                threads = Lists.reverse(threads); //Eigentlich sollten sie schon direkt richtig ankommen, da sie es aber nicht tun, wird hier quasi "sortiert"
                request.setAttribute("title", "Threads mit dem Suchbegriff: '" + searchRequest + "'");
                request.setAttribute("threads", threads);
                request.getRequestDispatcher("/jsp/threadList.jsp").forward(request, response);
            } else if (creatorId != null) {
                //Abfrage von Threads vom Creator mit CreatorId
                List<ThreadDto> threads = Lists.reverse(target.queryParam("creatorid", creatorId).path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<ThreadDto>>() {
                        }));
                //Abfrage des Nutzernamens, da wir anzeigen wollen, von welchem Nutzer die Threads sind
                String creatorName = target.path("users/" + creatorId).request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<CreatorDto>() {
                        }).getUsername();
                request.setAttribute("title", "Threads vom User: " + creatorName);
                request.setAttribute("threads", threads);
                request.getRequestDispatcher("/jsp/threadList.jsp").forward(request, response);
            } else {
                //Abfrage aller Threads, homepage Seite
                List<ThreadDto> threads = Lists.reverse(target.path("threads").request().accept(MediaType.APPLICATION_JSON).get(
                        new GenericType<List<ThreadDto>>() {
                        }));
                request.setAttribute("title", "Die neusten Threads");
                request.setAttribute("threads", threads);
                request.getRequestDispatcher("/jsp/threadList.jsp").forward(request, response);
            }
        } catch (NotFoundException | NotAuthorizedException e) {
            request.setAttribute("errorStatus", e.getResponse().getStatus());
            request.setAttribute("errorMessage", e.getResponse().readEntity(String.class));
            request.getRequestDispatcher("/jsp/error.jsp").forward(request, response);
        }

    }
}
