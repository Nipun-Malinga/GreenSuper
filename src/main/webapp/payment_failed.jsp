<!-- error.jsp -->
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <%@ include file="/includes/css.jsp" %>
    <title>Payment Failed</title>
</head>
<body class="grid min-h-screen place-items-center bg-slate-50 p-4">
<div class="card w-full max-w-md p-8 text-center">
    <span class="mx-auto grid size-20 place-items-center rounded-full bg-red-50 text-3xl text-red-600"><i class="fa fa-circle-exclamation"></i></span>
    <h1 class="mt-6 text-2xl font-bold">Sorry, we encountered an issue while processing your payment.</h1>
    <p class="mt-2 text-slate-600">Please try again later or contact support.</p>
    <div class="mt-6 flex flex-col gap-3 sm:flex-row">
        <a href="cart.jsp" class="btn btn-primary flex-1">Back to Cart</a>
        <a href="contact.jsp" class="btn btn-outline flex-1">Contact Support</a>
    </div>
</div>
</body>
</html>
