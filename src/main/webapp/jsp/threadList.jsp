<jsp:useBean id="title" scope="request" type="java.lang.String"/>
<jsp:useBean id="userData" scope="request" type="de.hsfl.group.e.javaeeforum.UserData"/>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<head>
    <meta charset="UTF-8">
    <title>Threads</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <meta charset="utf-8">

</head>
<body>
<!-- Navigationsleiste -->
<nav class="navbar navbar-dark bg-dark container-fluid pl-20 pr-20">
    <!-- Startseite -->
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
    <div>
        <!-- Threaderstellung-->
        <a class="btn btn-secondary mr-sm-2" href="createThreadServlet">Thread erstellen</a>
        <!-- Kategorien-->
        <a class="btn btn-warning mr-sm-2" href="categoryServlet">Kategorien</a>
        <!-- Userliste [Admin Knopf] -->
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

<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <h1>${title}</h1>
    <!-- table für die Threads -->
    <div id="threads">
        <jsp:useBean id="threads" scope="request" type="java.util.List"/>
        <c:forEach items="${threads}" var="thread">

            <div class="column p-2 border border-primary rounded highlight">
                <h4 class="mb-0 mt-0"><c:out value="${thread.title}"/></h4>
                <c:choose>
                    <c:when test="${thread.creator.deleted}">
                        <b class="m-1">Beitrag von [deleted_user], erstellt
                            am <c:out value="${thread.createdAt}"/></b>
                    </c:when>
                    <c:otherwise>
                        <b class="m-1">Beitrag von <a
                                href="threadServlet?creatorid=<c:out value="${thread.creator.id}"/>"><c:out
                                value="${thread.creator.username}"/></a>, erstellt
                            am <c:out value="${thread.createdAt}"/></b>
                    </c:otherwise>
                </c:choose>
                <div id="categoryAndTagList">
                    <b><a class="px-1 border border-warning rounded highlight text-dark"
                          href="categoryServlet?categoryid=<c:out value="${thread.category.id}"/>"><c:out
                            value="${thread.category.text}"/></a></b>
                    <c:forEach items="${thread.tags}" var="tag">
                        <a class="m-1 mr-0 px-1 border border-info rounded highlight text-info"
                           href="threadServlet?searchrequest=<c:out value="${tag}"/>"><c:out value="${tag}"/></a>
                    </c:forEach>
                </div>
                <div class="p-2 d-flex justify-content-between rounded">
                    <p style="white-space: pre-line"><c:out value="${thread.text}"/></p>
                </div>
                <div><c:out value="${thread.answers.size()}"/> Antworten</div>
                <a class="btn btn-primary" href="threadServlet?threadid=<c:out value="${thread.id}"/>">Öffne den
                    Thread</a>
            </div>
            <hr>
        </c:forEach>
        <c:if test="${threads.isEmpty()}">
            <p>Leider konnten keine Threads gefunden werden!</p>
        </c:if>
    </div>
</div>
</body>