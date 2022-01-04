<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="de">

<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thread erstellen</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>
<body>

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
<div class="container mt-5">
<div class="row pt-5">
    <h1>Erstelle einen Thread</h1>
</div>
    <div class="rounded-3 container-sm bg-primary">
        <form action="" method="post" id="createThread">
            <div class="row mb-3">
                <label for="titel" class="col-sm-2 col-form-label">Titel</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="titel" name=titel>
                </div>
            </div>
            <div class="row mb-3">
                <label for="text" class="col-sm-2 col-form-label">Text</label>
                <div class="col-sm-10">
                    <textarea type="text" class="form-control" id="text" name=text></textarea>
                </div>
            </div>
            <div class="row mb-3">
                <label for="category" class="col-sm-2 col-form-label">Category</label>
                <div class="col-sm-10">
                    <select name="Category" class="form-control" id="category">
                        <c:forEach items="${categories}" var="category">
                            <option>${category.text}</option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="tag" class="col-sm-2 col-form-label">Tag</label>
                <div class="col-sm-10">
                    <select name="Tag" class="form-control" id="tag">
                        <option>Tag 1</option>
                        <option>Tag 2</option>
                        <option>Tag 3</option>
                        <option>Tag 4</option>
                        <option>Tag 5</option>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <button type="submit" class="btn btn-secondary">Erstellen</button>
            </div>
        </form>
    </div>
</div>
</body>
</html>
