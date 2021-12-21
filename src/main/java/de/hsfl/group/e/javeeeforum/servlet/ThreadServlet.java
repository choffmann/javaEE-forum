package de.hsfl.group.e.javeeeforum.servlet;

import de.hsfl.group.e.javeeeforum.dto.ThreadDto;

import java.io.*;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.*;
import javax.servlet.annotation.*;

@WebServlet(name = "threadServlet", value = "/threadServlet")
public class ThreadServlet extends HttpServlet {
    private List<ThreadDto> threads;


    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        //TODO: Abfrage an den Endpunkt
        request.setAttribute("threads", threads);
        request.getRequestDispatcher("/index.jsp").forward(request, response);

    }
}