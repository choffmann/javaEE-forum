<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Auswahlseite</title>
    <meta charset="utf-8">

    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>

</head>
<body>
<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <a class="btn btn-primary" href="jsp/register.jsp">Register</a>
    <a class="btn btn-primary" href="jsp/login.jsp">Login</a>
    <a class="btn btn-primary" href="userListServlet">User List</a>
    <a class="btn btn-primary" href="createThreadServlet">Create Thread</a>
    <a class="btn btn-primary" href="threadServlet">Homepage (threadServlet)</a>
    <a class="btn btn-primary" href="categoryServlet">Kategorienliste</a>
    <a class="btn btn-primary" href="threadServlet?threadid=12">Thread 1</a>
    <a class="btn btn-primary" href="threadServlet?creatorid=5">Userthreads 1</a>
</div>
</body>