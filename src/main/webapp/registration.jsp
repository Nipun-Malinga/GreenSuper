<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.1/css/all.min.css">
    <link rel="stylesheet" href="./css/registration.css">
    <title>Login Page</title>
</head>
<body>
<div class="container" id="container">
    <div class="form-container sign-up">
        <form action="register" onsubmit=""  method="post">
            <h1>Create Account</h1>
            <div class="name-container">
                <input type="text" id="first_name" placeholder="First Name" name="firstName">
                <input type="text" id="last_name" placeholder="Last Name" name="lastName">
            </div>
            <input type="email" id="email" placeholder="Email" name="email">
            <input type="password" id="password" placeholder="Password" name="password">
            <input type="password" id="re_typed_password" placeholder="Re-enter Password">
            <input type="text" id="phone_number" placeholder="Phone Number" name="phoneNumber">
            <div class="address-container">
                <input type="text" id="home_number" placeholder="House Number" name="homeNumber">
                <input type="text" id="street_name" placeholder="Street Name" name="streetName">
            </div>
            <input type="text" id="ciry" placeholder="City" name="city">
            <button type="submit">Sign Up</button>
        </form>
    </div>
    <div class="toggle-container">
        <div class="toggle">
            <div class="toggle-panel toggle-right">
                <h1>Welcome!</h1>
                <p>You got an account already?</p>
                <button class="hidden" id="login">Sign In</button>
            </div>
        </div>
    </div>
</div>
<script src="./js/validation.js"></script>
</body>
</html>


<%--<html>--%>
<%--<head>--%>
<%--    <title>Registration</title>--%>
<%--</head>--%>
<%--<body>--%>
<%--    <form action="register" method="post">--%>
<%--        <label>--%>
<%--            <input type="text" name="firstName" placeholder="Last Name">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="text" name="lastName" placeholder="Last Name">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="email" name="email" placeholder="Email">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="password" name="password" placeholder="Password">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="tel" name="phoneNumber" placeholder="Phone Number">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="text" name="homeNumber" placeholder="Home Number">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="text" name="streetName" placeholder="Street Name">--%>
<%--        </label>--%>
<%--        <label>--%>
<%--            <input type="text" name="city" placeholder="City">--%>
<%--        </label>--%>

<%--        <input type="submit">--%>
<%--        <input type="reset">--%>
<%--    </form>--%>
<%--</body>--%>
<%--</html>--%>

