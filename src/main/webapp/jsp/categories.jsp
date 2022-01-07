<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javaeeforum.UserData"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <title>Kategorien</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <meta charset="utf-8">
</head>
<body>
<!-- Navigationsleiste -->
<nav class="navbar navbar-dark bg-dark container-fluid pl-20 pr-20">
    <!-- Startseite & Logindaten -->
    <div class="row pl-3">
        <a class="loggedIn btn btn-light mr-sm-2" href="threadServlet">Startseite</a>
        <a class="loggedIn btn btn-danger mr-sm-2" href="loginServlet">Ausloggen</a>
        <div>
            <p class="loggedIn text-white text-justify m-2 mr-4">Eingeloggt als: <b class="text-white"
                                                                                    id="loggedUser"><c:out value="${userData.creatorDto.username}"/></b>
            </p>
        </div>
    </div>
    <!-- Mittlere Knöpfe: Kategorien & Userliste [Admin Knopf] -->
    <div>
        <a class="btn btn-secondary mr-sm-2" href="createThreadServlet">Thread erstellen</a>
        <a class="btn btn-warning mr-sm-2" href="categoryServlet">Kategorien</a>
        <c:if test="${userData.creatorDto.admin}">
            <a class="loggedIn isAdmin btn btn-info mr-sm-2" href="userListServlet">Users</a>
        </c:if>
    </div>
    <!-- Suchleiste -->
    <div>
        <form class="form-inline m-0" method="get" action="threadServlet">
            <label for="searchrequest"></label>
            <input class="form-control mr-sm-2" type="search" id="searchrequest" name="searchrequest"
                   placeholder="Suche"/>
            <input class="btn btn-primary mr-sm-2" type="submit" value="Suchen"/>
        </form>
    </div>
</nav>

<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <h1>Kategorien</h1>
    <c:if test="${userData.creatorDto.admin}">
        <% String error = request.getParameter("error");
            if (error != null)
                out.print("<div class='text-danger font-weight-bold'>" + error + "</div>");
        %>
        <form class="form-inline m-0" action="${pageContext.request.contextPath}/categoryServlet" method="post">
            <label for="createCategory"></label>
                <input type="text" class="form-control mr-sm-2" id="createCategory" name=createCategory
                       placeholder="Kategorie" required>
                <button type="submit" class="btn btn-secondary mr-sm-2">Erstellen</button>
        </form>
    </c:if>
    <br>
    <!-- table für die Threads -->
    <div id="categories">
        <jsp:useBean id="categories" scope="request" type="java.util.List"/>
        <c:forEach items="${categories}" var="category">
            <a class="btn btn-primary" href="categoryServlet?categoryid=<c:out value="${category.id}"/>"><c:out value="${category.text}"/></a>
        </c:forEach>
    </div>
</div>
</body>