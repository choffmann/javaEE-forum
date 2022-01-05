<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Auswahlseite</title>
    <meta charset="utf-8">
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">

</head>
<body>
<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <a class="btn btn-primary mt-1" href="jsp/register.jsp">Register</a>
    <a class="btn btn-primary mt-1" href="jsp/login.jsp">Login</a>
    <a class="btn btn-primary mt-1" href="userListServlet">User List</a>
    <a class="btn btn-primary mt-1" href="createThreadServlet">Create Thread</a>
    <a class="btn btn-primary mt-1" href="threadServlet">Homepage (threadServlet)</a>
    <a class="btn btn-primary mt-1" href="categoryServlet">Kategorienliste</a>
    <a class="btn btn-primary mt-1" href="threadServlet?threadid=12">Thread 1</a>
    <a class="btn btn-primary mt-1" href="threadServlet?creatorid=5">Userthreads 1</a>
    <a class="btn btn-primary mt-1" href="threadServlet?searchrequest=Tag #0">Suche nach 'Tag #0'</a>
</div>
</body>