<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
    <%
        double cartPrice;
        if(session.getAttribute("cart_item") == null && session.getAttribute("cartPrice") == null) {
            
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
        <label>
            <input type="text" value="<%=item.getBoughtQuantity()%>">
        </label>
    <a href="quantity-inc-dec?action=dec&productId=<%=item.getProductId()%>"> - </a>
        <a href="remove-Cart-Item?productId=<%=item.getProductId()%>">removeFromCart</a>

    <%
            }
        }
    %>
<form action="payment" method="post">
    <input type="hidden" name="action" value="checkout">
    <button type="submit">Checkout with PayPal</button>
</form>
<%@ include file="includes/footer.jsp"%>