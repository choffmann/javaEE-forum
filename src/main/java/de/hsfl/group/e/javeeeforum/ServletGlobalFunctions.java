package de.hsfl.group.e.javeeeforum;

import org.glassfish.jersey.client.ClientConfig;

import javax.enterprise.context.ApplicationScoped;
import javax.inject.Inject;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.ws.rs.client.Client;
import javax.ws.rs.client.ClientBuilder;
import javax.ws.rs.client.WebTarget;
import javax.ws.rs.core.UriBuilder;
import java.io.IOException;
import java.io.Serializable;

@ApplicationScoped
public class ServletGlobalFunctions implements Serializable {
    @Inject
    UserData userData;

    public ServletGlobalFunctions() {
    }

    public WebTarget startConnection() {
        ClientConfig clientconfig = new ClientConfig();
        Client client = ClientBuilder.newClient(clientconfig);
        return client.target(UriBuilder
                .fromUri("http://localhost:8080/javeEE-forum-1.0-SNAPSHOT/api/").build());
    }

    public void isLoggedIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (userData.getCreatorDto() == null) {
            request.getRequestDispatcher("/jsp/login.jsp").forward(request, response);
        }
        request.setAttribute("userData", userData);
    }
}
