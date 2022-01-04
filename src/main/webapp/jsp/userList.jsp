<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javeeeforum.UserData"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
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
                                                                                    id="loggedUser">${userData.creatorDto.username}</b>
            </p>
        </div>
    </div>
    <!-- Mittlere Knöpfe: Kategorien & Userliste [Admin Knopf] -->
    <div>
        <a class="btn btn-secondary mr-sm-2" href="createThreadServlet">Thread erstellen</a>
        <a class="btn btn-warning mr-sm-2" href="categoryServlet">Kategorien</a>
        <a class="loggedIn isAdmin btn btn-info mr-sm-2" href="userListServlet">Users</a>
    </div>
    <!-- Suchleiste -->
    <div>
        <form class="form-inline" method="get" action="threadServlet">
            <input class="form-control my-2 mr-sm-2" type="search" id="searchrequest" placeholder="Suche"/>
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
        <th scope="col">Is Admin</th>
        <th scope="col"></th>
    </tr>
    </thead>
    <tbody id="userList">
    <c:forEach items="${userList}" var="user">
        <tr>
            <td>${user.id}</td>
            <td>${user.username}</td>
            <td>${user.email}</td>
            <td>${user.isAdmin()}</td>
            <td><button type="button" class="btn btn-danger">Löschen</button></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

</body>
