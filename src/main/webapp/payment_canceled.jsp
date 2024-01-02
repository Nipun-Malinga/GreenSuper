
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="icon" href="./images/main/logo/logo.png" type="image/x-icon">
    <title>Payment Canceled</title>
    <link rel="stylesheet" href="css/payment_massage_style.css">
</head>
<body>
<div class="container">

    <div class="popup">
        <img src="./images/main/OIP.jpeg" alt="">
        <h2>Payment canceled</h2>
        <p>Your payment process is successfully canceled</p>
        <p>"You will be redirected to the cart page in 10 seconds.</p>
        <a href="cart.jsp">Go Back TO Cart</a>
    </div>
</div>

<script type="text/javascript">
    function delayedRedirect() {
        setTimeout(function() {
            window.location.href = "<%= response.encodeRedirectURL("cart.jsp") %>";
        }, 10000);
    }
    window.onload = delayedRedirect;
</script>
</body>
</html>