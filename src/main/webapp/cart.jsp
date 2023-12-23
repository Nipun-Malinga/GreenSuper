<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
    <%
        double cartPrice;
        if(session.getAttribute("cart_item") == null && session.getAttribute("cartPrice") == null) {
            response.sendRedirect("index.jsp");
        } else {
            @SuppressWarnings("unchecked")
            List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
            cartPrice = (double) session.getAttribute("cartPrice");
    %>

        <h1><%=cartPrice > 0 ? cartPrice : 0%></h1>

    <%
        for (var item : cartItemList) {
    %>

        <h1><%=item.getProductId()%></h1>
        <h2><%=item.getPrice()%></h2>
        <a href="quantity-inc-dec?action=inc&productId=<%=item.getProductId()%>"> + </a>
        <input type="text" value="<%=item.getBoughtQuantity()%>">
        <a href="quantity-inc-dec?action=dec&productId=<%=item.getProductId()%>"> - </a>
        <a href="remove-Cart-Item?productId=<%=item.getProductId()%>">removeFromCart</a>

    <%
            }
        }
    %>
</body>
</html>
