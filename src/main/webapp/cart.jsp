<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<%
    if (session.getAttribute("cart_item") != null && session.getAttribute("cartPrice") != null) {
        double cartPrice;
        @SuppressWarnings("unchecked")
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
        cartPrice = (double) session.getAttribute("cartPrice");
%>

<div class="container padding-bottom-3x mb-1">
    <div><h2>My Shopping Cart</h2></div>

    <div class="table-responsive shopping-cart">
        <table class="table">
            <thead>
            <tr>
                <th>Product Name</th>
                <th class="text-center">Quantity</th>
                <th class="text-center">Price</th>
                <th class="text-center">Subtotal</th>
                <th class="text-center"><a class="btn btn-sm btn-outline" href="#" style="color: #0dec2b">Clear Cart</a></th>
            </tr>
            </thead>
            <tbody>
            <%
                for (var item : cartItemList) {
            %>
            <tr>
                <td>
                    <div class="product-item">
                        <a class="product-thumb" href="#"><img src="./uploadedImages/product/<%=item.getImageName()%>" alt="Avocado" width="90px" height="90px" /></a>
                        <p class="item-name" style="font-weight: lighter"><%=item.getProductName()%></p>
                    </div>
                </td>
                <td class="text-center">
                    <div class="count-input">
                        <a href="quantity-inc-dec?action=inc&productId=<%=item.getProductId()%>"> + </a>
                        <input type="text" readonly value="<%=item.getBoughtQuantity()%>" />
                        <a href="quantity-inc-dec?action=dec&productId=<%=item.getProductId()%>"> - </a>
                    </div>
                </td>
                <td class="text-center text-lg text-medium">Rs.<%=item.getPrice()%></td>
                <td class="text-center text-lg text-medium">Rs.<%=item.getPrice() * item.getBoughtQuantity()%></td>
                <td class="text-center">
                    <a class="remove-from-cart" href="remove-Cart-Item?productId=<%=item.getProductId()%>" data-toggle="tooltip" title data-original-title="Remove item">
                        <i class="fa fa-trash"></i>
                    </a>
                </td>
            </tr>
            <%
                }
            %>
            </tbody>
        </table>
    </div>

    <div class="shopping-cart-footer">
        <div class="column text-lg">Subtotal: <span class="text-medium"><%=cartPrice > 0 ? cartPrice :  0%></span></div>
    </div>

    <div class="shopping-cart-footer">
        <div class="column">
            <a class="btn btn-outline-secondary" href="index.jsp"><i class="icon-arrow-left"></i>&nbsp;Back to Shopping</a>
        </div>
        <div class="column">
            <form action="payment" method="post">
                <input type="hidden" name="action" value="checkout">
                <button class="btn btn-success" type="submit">Checkout</button>
            </form>
        </div>
    </div>
</div>

<%
    } else {
%>
<div class="empty_cart">
    <img src="images/main/empty_cart.png" alt="">
    <h2>Oops! Looks like your cart is empty</h2>
</div>
<%
    }
%>

<%@ include file="includes/footer.jsp"%>




<%--        <h1><%=cartPrice > 0 ? cartPrice : 0%></h1>--%>

<%--    <%--%>
<%--        for (var cartItem : cartItemList) {--%>
<%--    %>--%>

<%--        <h1><%=cartItem.getProductId()%></h1>--%>
<%--        <h2><%=cartItem.getPrice()%></h2>--%>
<%--        <a href="quantity-inc-dec?action=inc&productId=<%=cartItem.getProductId()%>"> + </a>--%>
<%--        <label>--%>
<%--            <input type="text" value="<%=cartItem.getBoughtQuantity()%>">--%>
<%--        </label>--%>
<%--    <a href="quantity-inc-dec?action=dec&productId=<%=cartItem.getProductId()%>"> - </a>--%>
<%--        <a href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>">removeFromCart</a>--%>