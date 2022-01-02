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
            <p class="loggedIn text-white text-justify m-2 mr-4">Eingeloggt als:
                <b class="text-white" id="loggedUser">${username}</b></p>
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

    <!-- table für die Threads -->
    <div id="thread" class="p-2 border border-primary rounded">
        <h1>${thread.title}</h1>
        <b class="mb-1">Beitrag von ${thread.creator.getUsername()}, erstellt am ${thread.createdAt}</b>
        <div class="p-2 d-flex justify-content-between rounded">
            ${thread.text}
        </div>
    </div>
    <br>
    <div class="p-2" id="createAnswer">
        <form id="createAnswerForm" name="createAnswerForm" method="post" action="answerServlet">
            <input type="hidden" value="${thread.id}" name="threadid"/>
            <div class="form-group">
                <label for="answerTextarea">Verfasse eine Antwort:</label>
                <textarea class="form-control" id="answerTextarea" placeholder="..." name="answertext"
                          rows="4"></textarea>
            </div>
            <input class="btn btn-success float-right" type="submit" value="Antwort absenden"/>
        </form>
    </div>
    <br>
    <div id="answers" class="p-1">
        <h4>${thread.answers.size()} Antworten</h4>
        <hr>
        <c:if test="${thread.answers.size() > 0}">
            <c:forEach items="${answers}" var="answer">
                <div class="border border-info rounded p-1">
                    <b>Antwort von ${answer.creator.username} </b>
                    <p>${answer.text}</p>
                    <div class="p-2" id="createComment">
                        <form id="createCommentForm" name="createCommentForm" method="post" action="commentServlet">
                            <input type="hidden" value="${thread.id}" name="threadid"/>
                            <input type="hidden" value="${answer.id}" name="answerid"/>
                            <div class="form-group">
                                <label for="commentTextarea">Kommentiere die Antwort:</label>
                                <textarea class="form-control" id="commentTextarea" placeholder="..." name="commenttext"
                                          rows="1"></textarea>
                                <div class="text-right">
                                <input class="btn btn-success mt-1 p-1>" type="submit" value="Kommentar absenden"/>
                                </div>
                            </div>
                        </form>
                    </div>
                    <c:if test="${answer.comments.size() > 0}">
                        <c:forEach items="${answer.comments}" var="comment">
                            <div class="border border-secondary rounded p-1">
                                <b>Kommentar von ${comment.creatorDto.username} </b>
                                <p>${comment.text}</p>
                            </div>
                        </c:forEach>
                    </c:if>
                </div>
                <hr>
            </c:forEach>
        </c:if>
    </div>
</div>
</body>
</html>