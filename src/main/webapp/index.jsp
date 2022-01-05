<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<head>
    <meta charset="UTF-8">
    <title>Auswahlseite</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
    <meta charset="utf-8">

    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
    <!-- Wird für JS Bootstrap benötigt, was ich für die Bootstrap Modal benötige -->
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/js/bootstrap.min.js"></script>
    <!--<script type="text/javascript" src="js/load.js"></script>-->

</head>
<body>
<!-- Seiteninhalt -->
<div class="container mt-5">
    <!-- Normaler Content -->
    <a class="btn btn-primary" href="jsp/register.jsp">Register</a>
    <a class="btn btn-primary" href="jsp/login.jsp">Login</a>
    <a class="btn btn-primary" href="threadServlet">Homepage (threadServlet)</a>
    <a class="btn btn-primary" href="categoryServlet">Kategorienliste</a>
    <a class="btn btn-primary" href="threadServlet?threadid=12">Thread 1</a>
    <a class="btn btn-primary" href="threadServlet?creatorid=5">Userthreads 1</a>
    <a class="btn btn-primary" href="threadServlet?searchrequest=Tag #0">Suche nach 'Tag #0'</a>
</div>
</body>
</html>