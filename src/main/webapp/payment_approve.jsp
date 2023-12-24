<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Payment Approval</title>
</head>
<body>

<%
    // Retrieve paymentId and PayerID from the request parameters
    String paymentId = request.getParameter("paymentId");
    String payerId = request.getParameter("PayerID");

    // You may want to perform additional processing here, e.g., update order status, log the transaction, etc.
%>

    <form action="payment" method="post">
        <input type="hidden" name="paymentId" value="<%=paymentId%>">
        <input type="hidden" name="PayerId" value="<%=payerId%>">
        <input type="hidden" name="action" value="execute_payment">
        <button type="submit">Execute Payment</button>
    </form>

<!-- Add additional content or redirection logic as needed -->

</body>
</html>
