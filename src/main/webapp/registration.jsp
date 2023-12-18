<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Registration</title>
</head>
<body>
    <form action="register" method="post">
        <label>
            <input type="text" name="firstName" placeholder="Last Name">
        </label>
        <label>
            <input type="text" name="lastName" placeholder="Last Name">
        </label>
        <label>
            <input type="email" name="email" placeholder="Email">
        </label>
        <label>
            <input type="password" name="password" placeholder="Password">
        </label>
        <label>
            <input type="tel" name="phoneNumber" placeholder="Phone Number">
        </label>
        <label>
            <input type="text" name="homeNumber" placeholder="Home Number">
        </label>
        <label>
            <input type="text" name="streetName" placeholder="Street Name">
        </label>
        <label>
            <input type="text" name="city" placeholder="City">
        </label>

        <input type="submit">
        <input type="reset">
    </form>
</body>
</html>
