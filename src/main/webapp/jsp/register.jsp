<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html lang="de">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet"
          integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
</head>

<body>

    <div class="rounded-3 container-sm bg-primary">
        <h1>Register</h1>
        <form action="${pageContext.request.contextPath}/registerServlet" method="post">
            <div class="row mb-3">
                <label for="registerUsername" class="col-sm-2 col-form-label">Username</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="registerUsername" name="registerUsername">
                </div>
            </div>
            <div class="row mb-3">
                <label for="registerEmail" class="col-sm-2 col-form-label">E-Mail</label>
                <div class="col-sm-10">
                    <input type="text" class="form-control" id="registerEmail" name="registerEmail">
                </div>
            </div>
            <div class="row mb-3">
                <label for="registerPassword" class="col-sm-2 col-form-label">Password</label>
                <div class="col-sm-10">
                    <input type="password" class="form-control" id="registerPassword" name="registerPassword">
                </div>
            </div>
            <button type="submit" class="btn btn-secondary">Register</button>
        </form>
    </div>

</body>

</html>

