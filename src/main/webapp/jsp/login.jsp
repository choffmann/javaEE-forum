<%@ page contentType="text/html;charset=UTF-8" %>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet"
          href="https://maxcdn.bootstrapcdn.com/bootstrap/4.4.1/css/bootstrap.min.css">
</head>

<body>

<!-- Navigationsleiste -->
<nav class="navbar navbar-dark bg-dark container-fluid pl-20 pr-20">
    <!-- Startseite & Logindaten -->
    <div class="row pl-3">
        <a class="loggedIn btn btn-light mr-sm-2" href="register.jsp">Register</a>
    </div>
</nav>

<div class="container mt-5">
    <div class="rounded-3 container-sm bg-primary">
        <h1>Login</h1>
        <form action="${pageContext.request.contextPath}/loginServlet" method="post">
            <div class="row mb-3">
                <label for="loginUsername" class="col-sm-2 col-form-label">Username</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="loginUsername" name=loginUsername required>
                </div>
            </div>
            <div class="row mb-3">
                <label for="loginPassword" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="loginPassword" name=loginPassword required>
                </div>
            </div>
            <button type="submit" class="btn btn-secondary">Login</button>
        </form>
    </div>
</div>
</body>