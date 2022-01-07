<%@ page contentType="text/html;charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>

<body>

<!-- Navigationsleiste -->
<nav class="navbar navbar-dark bg-dark container-fluid pl-20 pr-20">
    <!-- Startseite & Logindaten -->
    <div class="row pl-3">
        <a class="loggedIn btn btn-light mr-sm-2" href="${pageContext.request.contextPath}/jsp/login.jsp">Login</a>
    </div>
</nav>

<div class="container mt-5">
    <% String error = request.getParameter("error");
        if (error != null)
            out.print("<div class='text-danger font-weight-bold'>" + error + "</div>");
    %>
    <div class="border rounded p-2 container-sm bg-primary">
        <h1 class="text-white">Register</h1>
        <form class="m-0" action="${pageContext.request.contextPath}/registerServlet" method="post">
            <div class="row mb-3">
                <label for="registerUsername" class="col-sm-2 col-form-label text-white">Username</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="registerUsername" name="registerUsername" required>
                </div>
            </div>
            <div class="row mb-3">
                <label for="registerEmail" class="col-sm-2 col-form-label text-white">E-Mail</label>
                <div class="col-sm-10">
                    <input type="email" class="form-control" id="registerEmail" name="registerEmail" required>
                </div>
            </div>
            <div class="row mb-3">
                <label for="registerPassword" class="col-sm-2 col-form-label text-white">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="registerPassword" name="registerPassword" required>
                </div>
            </div>
            <button type="submit" class="btn btn-secondary">Register</button>
        </form>
    </div>

</div>
</body>