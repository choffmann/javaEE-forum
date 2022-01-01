<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <meta charset="utf-8">
</head>
<body>
<!-- TODO: Bei nicht eingeloggtem Zustand soll zu login.jsp gewechselt werden -->
<!-- Navigationsleiste -->
<nav class="navbar navbar-dark bg-dark container-fluid pl-20 pr-20">
    <!-- Startseite -->
    <div class="row pl-3">
        <a class="loggedIn btn btn-light mr-sm-2" href="threadServlet">Startseite</a>
        <div>
            <p class="loggedIn text-white text-justify m-2 mr-4">Eingeloggt als: <b class="text-white"
                                                                                    id="loggedUser">${username}</b></p>
        </div>
    </div>
    <div>
        <!-- Kategorien-->
        <a class="btn btn-warning mr-sm-2" href="categoryServlet">Kategorien</a>
        <!-- Userliste [Admin Knopf] -->
        <button class="loggedIn isAdmin btn btn-danger mr-sm-2" type="button" data-toggle="modal"
                data-target="#listModal">Users <!-- TODO Userliste aufrufen -->
        </button>
    </div>
    <!-- Suchleiste -->
    <div>
        <form class="form-inline" method="get" action="threadServlet">
            <input class="form-control my-2 mr-sm-2" type="search" id="searchrequest" placeholder="Suche"/>
            <input class="btn btn-primary mr-sm-2" type="submit" value="Suchen"/>
        </form>
    </div>
</nav>

<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <h1>Kategorien</h1>
    <!-- table für die Threads -->
    <div id="categories">
            <c:forEach items="${categories}" var="category">
                <a class="btn btn-primary" href="categoryServlet?categoryid=${category.id}">${category.text}</a>
            </c:forEach>
    </div>
</div>
</body>
</html>