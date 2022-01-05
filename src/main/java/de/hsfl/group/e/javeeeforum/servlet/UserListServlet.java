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

import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.GenericType;
import javax.ws.rs.core.MediaType;
import javax.ws.rs.core.Response;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "userListServlet", value = "/userListServlet")
public class UserListServlet extends HttpServlet {

    @Inject
    UserData userData;
    @Inject
    ServletGlobalFunctions sgf;

    public void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgf.isLoggedIn(request, response);
        WebTarget target = sgf.startConnection();
        request.setAttribute("userData", userData);

        List<CreatorDto> userList = target.queryParam("creatorid", userData.getCreatorDto().getId()).path("users")
                .request().accept(MediaType.APPLICATION_JSON).get(
                new GenericType<List<CreatorDto>>() {
                });
        request.setAttribute("userList", userList);

        request.getRequestDispatcher("/jsp/userList.jsp").forward(request, response);
    }
    public void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException {
        sgf.isLoggedIn(request, response);
        WebTarget target = sgf.startConnection();
        String userID = request.getParameter("userid");
        target.queryParam("creatorid", userData.getCreatorDto().getId()).path("users/" + userID)
                .request().accept(MediaType.APPLICATION_JSON).delete();
        response.sendRedirect(request.getContextPath() + "/userListServlet");
    }
}
