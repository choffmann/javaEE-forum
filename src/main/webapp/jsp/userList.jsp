<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javaeeforum.UserData"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
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
                                                                                    id="loggedUser"><c:out
                    value="${userData.creatorDto.username}"/></b>
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
                   placeholder="Suche" required/>
            <input class="btn btn-primary mr-sm-2" type="submit" value="Suchen"/>
        </form>
    </div>
</nav>


<div class="container mt-5">
    <div class="row pt-5">
        <h1>User List</h1>
    </div>
    <table class="table">
        <thead>
        <tr>
            <th scope="col">ID</th>
            <th scope="col">Username</th>
            <th scope="col">E-Mail</th>
            <th scope="col">Admin</th>
            <th scope="col">Gelöscht</th>
            <th scope="col"></th>
        </tr>
        </thead>
        <tbody id="userList">
        <jsp:useBean id="userList" scope="request" type="java.util.List"/>
        <c:forEach items="${userList}" var="user">
            <tr>
                <td><c:out value="${user.id}"/></td>
                <td><c:out value="${user.username}"/></td>
                <td><c:out value="${user.email}"/></td>
                <td><c:out value="${user.isAdmin()}"/></td>
                <td><c:out value="${user.isDeleted()}"/></td>
                <td>
                    <c:if test="${!user.isAdmin()}">
                        <form action="userListServlet" method="post">
                            <button name=userid type="submit" class="btn btn-danger mt-1"
                                    value="<c:out value="${user.id}"/>">Löschen
                            </button>
                        </form>
                    </c:if>
                </td>
            </tr>
        </c:forEach>
        </tbody>
    </table>
</div>

</body>
