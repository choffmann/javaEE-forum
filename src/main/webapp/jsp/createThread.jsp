<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javaeeforum.UserData"/>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Thread erstellen</title>
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


<br/>
<div class="container mt-5">
    <div class="rounded-3 container-sm bg-primary">
        <h1>Erstelle einen Thread</h1>
        <form action="${pageContext.request.contextPath}/createThreadServlet" method="post" id="createThread">
            <div class="row mb-3">
                <label for="title" class="col-sm-2 col-form-label">Titel</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="title" name=title required>
                </div>
            </div>
            <div class="row mb-3">
                <label for="text" class="col-sm-2 col-form-label">Text</label>
                <div class="col-sm-10">
                    <textarea class="form-control" id="text" name=text required></textarea>
                </div>
            </div>
            <div class="row mb-3">
                <label for="category" class="col-sm-2 col-form-label">Kategorie</label>
                <div class="col-sm-10">
                    <select name="categoryid" class="form-control" id="category">
                        <jsp:useBean id="categories" scope="request" type="java.util.List"/>
                        <c:forEach items="${categories}" var="category">
                            <option value=${category.id}><c:out value="${category.text}"/></option>
                        </c:forEach>
                    </select>
                </div>
            </div>
            <div class="row mb-3">
                <label for="tag" class="col-sm-2 col-form-label">Tags</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="tag" name=tag placeholder="Tags durch Komma trennen">
                </div>
            </div>
            <div class="row mb-3">
                <button type="submit" class="btn btn-secondary">Erstellen</button>
            </div>
        </form>
    </div>
</div>
</body>
