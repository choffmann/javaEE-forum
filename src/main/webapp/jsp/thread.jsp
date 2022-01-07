<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javaeeforum.UserData"/>
<jsp:useBean id="thread" scope="request" type="de.hsfl.group.e.javaeeforum.dto.ThreadDto"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <title>Homepage</title>
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

    <!-- table für die Threads -->
    <div id="thread" class="p-2 border border-primary rounded">
        <h1><c:out value="${thread.title}"/></h1>
        <c:choose>
            <c:when test="${thread.creator.deleted}">
                <b class="m-1">Beitrag von [deleted_user], erstellt
                    am <c:out value="${thread.createdAt}"/></b>
            </c:when>
            <c:otherwise>
                <b class="m-1">Beitrag von <a
                        href="threadServlet?creatorid=<c:out value="${thread.creator.id}"/>"><c:out value="${thread.creator.username}"/></a>, erstellt
                    am <c:out value="${thread.createdAt}"/></b>
            </c:otherwise>
        </c:choose>
        <div id="categoryAndTagList">
            <b><a class="px-1 border border-warning rounded highlight text-dark"
                  href="categoryServlet?categoryid=<c:out value="${thread.category.id}"/>"><c:out value="${thread.category.text}"/></a></b>
            <c:forEach items="${thread.tags}" var="tag">
                <a class="m-1 mr-0 border border-info rounded highlight text-info" href="threadServlet?searchrequest=<c:out value="${tag}"/>"><c:out value="${tag}"/></a>
            </c:forEach>
        </div>
        <div class="p-2 d-flex justify-content-between rounded">
            <c:out value="${thread.text}"/>
        </div>
    </div>
    <br>
    <div class="p-2" id="createAnswer">
        <form id="createAnswerForm" name="createAnswerForm" method="post" action="answerServlet">
            <input type="hidden" value="${thread.id}" name="threadid"/>
            <div class="form-group">
                <label for="answerTextarea">Verfasse eine Antwort:</label>
                <textarea class="form-control" id="answerTextarea" placeholder="..." name="answertext"
                          rows="4" required></textarea>
            </div>
            <input class="btn btn-success float-right" type="submit" value="Antwort absenden"/>
        </form>
    </div>
    <br>
    <div id="answers" class="p-1">
        <h4><c:out value="${thread.answers.size()}"/> Antworten</h4>
        <hr>
        <c:if test="${thread.answers.size() > 0}">
            <jsp:useBean id="answers" scope="request" type="java.util.List"/>
            <c:forEach items="${answers}" var="answer">
                <div class="border border-info rounded p-1">
                    <c:choose>
                        <c:when test="${answer.creator.deleted}">
                            <b>Antwort von [deleted_user], <c:out value="${answer.createdAt}"/></b>
                        </c:when>
                        <c:otherwise>
                            <b>Antwort von <a href="threadServlet?creatorid=<c:out value="${answer.creator.id}"/>"><c:out value="${answer.creator.username}"/></a>, <c:out value="${answer.createdAt}"/></b>
                        </c:otherwise>
                    </c:choose>
                    <p><c:out value="${answer.text}"/></p>
                    <div class="p-2" id="createComment">
                        <form id="createCommentForm" name="createCommentForm" method="post" action="commentServlet">
                            <input type="hidden" value="${thread.id}" name="threadid"/>
                            <input type="hidden" value="${answer.id}" name="answerid"/>
                            <div class="form-group">
                                <label for="commentTextarea">Kommentiere die Antwort:</label>
                                <textarea class="form-control" id="commentTextarea" placeholder="..." name="commenttext"
                                          rows="1" required></textarea>
                                <div class="text-right">
                                    <input class="btn btn-success mt-1 p-1>" type="submit" value="Kommentar absenden"/>
                                </div>
                            </div>
                        </form>
                    </div>
                    <c:if test="${answer.comments.size() > 0}">
                        <c:forEach items="${answer.comments}" var="comment">
                            <div class="border border-secondary rounded p-1 my-1">
                                <c:choose>
                                    <c:when test="${comment.creatorDto.deleted}">
                                        <b>Kommentar von [deleted_user], <c:out value="${comment.createdAt}"/></b>
                                    </c:when>
                                    <c:otherwise>
                                        <b>Kommentar von <a
                                                href="threadServlet?creatorid=<c:out value="${comment.creatorDto.id}"/>"><c:out value="${comment.creatorDto.username}"/></a>, <c:out value="${comment.createdAt}"/></b>
                                    </c:otherwise>
                                </c:choose>
                                <p><c:out value="${comment.text}"/></p>
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