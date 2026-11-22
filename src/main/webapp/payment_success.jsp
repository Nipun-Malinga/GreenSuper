<%@ page contentType="text/html;charset=UTF-8" %>

<%
    if(session.getAttribute("auth") != null) {
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/css.jsp" %>
    <title>Payment Successful</title>
</head>
<body class="grid min-h-screen place-items-center bg-slate-50 p-4">
<div class="card w-full max-w-md p-8 text-center">
    <img src="images/main/404-tick.png" alt="" class="mx-auto size-24 object-contain">
    <h2 class="mt-6 text-2xl font-bold">Thank You!</h2>
    <p class="mt-2 text-slate-600">Your payment has successfully received. The Bill is sent to you via an email.</p>
    <p class="mt-1 text-sm text-slate-500">You will be redirected to the cart page in 10 seconds.</p>
    <button id="continue" type="button" class="btn btn-primary mt-6 w-full">Continue Browsing</button>
</div>

<script type="text/javascript">
    document.getElementById('continue').addEventListener('click', () => {
        window.location.href = "<%=response.encodeRedirectURL("index.jsp")%>"
    })

    function delayedRedirect() {
        setTimeout(function() {
            window.location.href = "<%= response.encodeRedirectURL("cart.jsp") %>";
        }, 10000);
    }
    window.onload = delayedRedirect;
</script>

</body>
</html>

<%
    }else {
        response.sendRedirect("index.jsp");
    }
%>
