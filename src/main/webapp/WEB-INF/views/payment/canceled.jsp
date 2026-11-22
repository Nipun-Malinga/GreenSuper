
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/WEB-INF/views/includes/css.jsp" %>
    <title>Payment Canceled</title>
</head>
<body class="grid min-h-screen place-items-center bg-slate-50 p-4">
<div class="card w-full max-w-md p-8 text-center">
    <img src="./images/main/OIP.jpeg" alt="" class="mx-auto size-24 rounded-full object-cover">
    <h2 class="mt-6 text-2xl font-bold">Payment canceled</h2>
    <p class="mt-2 text-slate-600">Your payment process is successfully canceled</p>
    <p class="mt-1 text-sm text-slate-500">You will be redirected to the cart page in 10 seconds.</p>
    <a href="cart.jsp" class="btn btn-primary mt-6 w-full" id="continue">Go Back To Cart</a>
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
