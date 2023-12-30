<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%--    <form action="login" method="post">--%>
<%--        <label>--%>
<%--            <input type="email" name="userEmail" placeholder="email">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="password" name="password" placeholder="password">--%>
<%--        </label>--%>
<%--        <input type="submit">--%>
<%--    </form>--%>
<%--    <p>Don't have an account. Click <a href="./registration.jsp">here</a> to register.</p>--%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="./css/login_Style.css">
    <title>Login Page</title>
</head>
<body>
<div class="container" id="container">

    <div class="form-container sign-up">
        <form name="signinform" action="login" onsubmit="return validateSignInForm()" method="post">
            <h1>Log In</h1>
            <label>
                <input type="email" name="userEmail" placeholder="Email">
            </label>
            <label>
                <input type="password" name="password" placeholder="Password">
            </label>
            <button type="submit">Sign In</button>
        </form>
    </div>
    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-right">
                <h1>Hello, Friend!</h1>
                <p>New to Green Super?</p>
                <a href="registration.jsp" class="hidden" id="login">Sign Up</a>
            </div>
        </div>
    </div>
</div>
<script src="login.js"></script>
</body>
</html>