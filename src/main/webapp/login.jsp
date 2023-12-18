<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Login</title>
</head>
<body>
    <form action="login" method="post">
        <label>
            <input type="email" name="userEmail" placeholder="email">
        </label>
        <label>
            <input type="password" name="password" placeholder="password">
        </label>
        <input type="submit">
    </form>
    <p>Don't have an account. Click <a href="./registration.jsp">here</a> to register.</p>
</body>
</html>
