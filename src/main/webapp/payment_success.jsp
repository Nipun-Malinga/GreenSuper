<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if(session.getAttribute("auth") != null) {
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">

    <title>Document</title>
    <link rel="stylesheet" href="./css/cart_style.css">
</head>
<body>
<div class="container">

    <div class="popup">
        <img src="images/main/404-tick.png" alt="">
        <h2>Thank You!</h2>
        <p>Your payment has successfully received. The Bill is sent to you via an email.</p>
        <p>"You will be redirected to the cart page in 10 seconds.</p>
    </div>
</div>

</body>

<script type="text/javascript">
    function delayedRedirect() {
        setTimeout(function() {
            window.location.href = "<%= response.encodeRedirectURL("cart.jsp") %>";
        }, 10000);
    }
    window.onload = delayedRedirect;
</script>
</html>

<%
    }else {
        response.sendRedirect("index.jsp");
    }
%>