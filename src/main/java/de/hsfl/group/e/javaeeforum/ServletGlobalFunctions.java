package de.hsfl.group.e.javaeeforum;

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
                .fromUri("http://localhost:8080/javaEE-forum-1.0-SNAPSHOT/api/").build());
    }

    public boolean isLoggedIn(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        if (userData.getCreatorDto() == null) {
            response.sendRedirect(request.getContextPath() + "/jsp/login.jsp");
            return false;
        }
        request.setAttribute("userData", userData);
        return true;
    }
}
