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
                                                                                    id="loggedUser"></b></p>
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
    <form class="form-inline">
        <input class="form-control my-2 mr-sm-2" type="search" id="searchInput" placeholder="Suche">
        <button class="btn btn-primary mr-sm-2" type="button"
                onclick="loadData('search',document.getElementById('searchInput').value)">Suchen
            <!-- TODO: Threadsuche -->
        </button> <!-- wichtig! type=button damit er die seite nicht submittet/refreshed -->
    </form>
</nav>

<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <h1>Threads der Kategorie ${category.text}</h1>
    <!-- table für die Threads -->
    <div id="threads">
        <c:forEach items="${category.threads}" var="thread">
            <div class="column p-2 border border-primary rounded highlight">
                <h4 class="mb-0 mt-0">${thread.title}</h4>
                <p class="pl-4 pt-1 mb-1">Beitrag von ${thread.creator.getUsername()}, erstellt am ${thread.createdAt}</p>
                <div class="p-2 d-flex justify-content-between rounded">
                        ${thread.text}
                </div>
                <div>${thread.answers.size()} Antworten</div>
                <a class="btn btn-primary" href="threadServlet?threadid=${thread.id}">Öffne den Thread</a>
            </div>
            <hr>
        </c:forEach>
    </div>
</div>
</body>
</html>