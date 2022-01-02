<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>

<!-- Navigationsleiste -->
<nav class="navbar fixed-top navbar-dark bg-dark container-fluid pl-20 pr-20">
    <div class="row pl-3">
        <button class="loggedIn btn btn-light mr-sm-2" type="button" data-toggle="modal"
                data-target="#listModal" onclick="window.location.href = 'index.jsp'">Startseite <!-- TODO Startseite aufrufen -->
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
    <tbody>
    <c:forEach items="${users}" var="users">
        <tr>
            <td>${users.id}</td>
            <td>${users.username}</td>
            <td>${users.email}</td>
            <td>${users.isAdmin}</td>
            <td><button type="button" class="btn btn-danger">Löschen</button></td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</div>

</body>
