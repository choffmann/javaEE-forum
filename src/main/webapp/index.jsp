<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <meta charset="utf-8">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Wird für JS Bootstrap benötigt, was ich für die Bootstrap Modal benötige -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!--<script type="text/javascript" src="js/load.js"></script>-->
</head>
<!-- TODO: Bei nicht eingeloggtem Zustand soll zu login.jsp gewechselt werden -->
<!-- Navigationsleiste -->
<nav class="navbar fixed-top navbar-dark bg-dark container-fluid pl-20 pr-20">
    <div class="row pl-3">
        <button class="loggedIn btn btn-light mr-sm-2" type="button" data-toggle="modal"
                data-target="#listModal">Startseite <!-- TODO Startseite aufrufen -->
        </button>
        <div>
            <p class="loggedIn text-white text-justify m-2 mr-4">Eingeloggt als: <b class="text-white"
                                                                                    id="loggedUser"></b></p>
        </div>
    </div>
    <div>
        <!-- Kategorien-->
        <button class="loggedIn btn btn-warning mr-sm-2" type="button" data-toggle="modal"
                data-target="#listModal">Kategorien
        </button>
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
<!-- Kategorien Modalfenster -->
<div id="listModal" class="modal fade" role="dialog">
    <div class="modal-dialog modal-dialog-scrollable">
        <div class="modal-content">
            <div class="modal-header">
                <h4 class="modal-title">Kategorien</h4>
                <button type="button" class="close" data-dismiss="modal">&times;</button>
            </div>
            <div class="modal-body">
                <div id="catAlert" class="alert alert-danger" style="display: none" role="alert"></div>
                <div class="list-group" id="categories" role="tablist"> <!--Wird über die js eingefügt-->
                    <!-- TODO: Abfrage der Kategorien-->
                </div>
            </div>
            <div class="modal-footer justify-content-between">
                <!-- j-c-b macht, dass die eine Gruppe links und die andere rechts ist,deshalb leerer container zum start-->
                <div></div>
                <div>
                    <button id="searchCategory" class="btn btn-primary mr-sm-2" type="button"
                            onclick="loadFromFavorite('search')"> <!-- TODO: Suche der Kategorie-->
                        Suchen
                    </button>
                </div>
            </div>
        </div>

    </div>
</div>
<br/>

<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <div class="row pt-5">
        <h1>Die letzten Threads</h1>
    </div>
    <!-- table für die Threads -->
    <div id="threads">
    <!-- Beispieldaten -->
    <div class="row p-2 border border-primary rounded highlight">
        <h4 class="mb-0 mt-0">[Titel] Beispieltitel der dazu da ist zu gucken, wie das ganze dann aussehen wird!</h4>
        <p class="pl-4 pt-1">Beitrag von [NAME], erstellt am [DATUM]</p>
        <div class="p-2 d-flex justify-content-between rounded">
            Hier kommt dann der Text rein, der toll gemacht ist und so.Hier kommt dann der Text rein, der toll gemacht
            ist und so.Hier kommt dann der Text rein, der toll gemacht ist und so.
        </div>
        <div>17 Kommentare</div>
    </div>
    <hr>
    <div class="row p-2 border border-primary rounded highlight">
        <h4 class="mb-0 mt-0">[Titel] Beispieltitel der dazu da ist zu gucken, wie das ganze dann aussehen wird!</h4>
        <p class="pl-4 pt-1">Beitrag von [NAME], erstellt am [DATUM]</p>
        <div class="p-2 d-flex justify-content-between rounded">
            Hier kommt dann der Text rein, der toll gemacht ist und so.Hier kommt dann der Text rein, der toll gemacht
            ist und so.Hier kommt dann der Text rein, der toll gemacht ist und so.
        </div>
        <div>17 Kommentare</div>
    </div>
    </div>
    <a href="hello-servlet">Hello Servlet</a>
</div>
</body>
</html>