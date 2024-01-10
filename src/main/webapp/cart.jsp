<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>

<%@ include file="includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<%
    if (session.getAttribute("cart_item") != null && session.getAttribute("cartPrice") != null) {
        double cartPrice;
        @SuppressWarnings("unchecked")
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
        cartPrice = (double) session.getAttribute("cartPrice");
%>
<section class="cart">
    <div class="container padding-bottom-3x mb-1">
        <div>
            <h2>My Shopping Cart</h2>
        </div>

        <div class="table-responsive shopping-cart">
            <table class="table">
                <thead>
                <tr>
                    <th>Product Name</th>
                    <th class="text-center">Quantity</th>
                    <th class="text-center">Price</th>
                    <th class="text-center">Subtotal</th>
                    <th class="text-center">
                        <a class="btn btn-sm btn-outline" href="#" style="color: #0dec2b">Clear Cart</a>
                    </th>
                </tr>
                </thead>
                <tbody>
                <%
                    for (var cartItem : cartItemList) {
                %>
                <tr>
                    <td>
                        <div class="cart-table-row">
                            <img class="rounded" src="./uploadedImages/product/<%=cartItem.getImageName()%>"
                                 alt="Avocado" width="80px" height="80px" />
                            <p class="item-name"><%=cartItem.getProductName()%></p>
                        </div>
                    </td>
                    <td class="text-center">
                        <div class="cart-table-row">
                            <a href="quantity-inc-dec?action=inc&productId=<%=cartItem.getProductId()%>"> + </a>
                            <label>
                                <input type="text" class="form-control"
                                       readonly value="<%=cartItem.getBoughtQuantity()%>" />
                            </label>
                            <a href="quantity-inc-dec?action=dec&productId=<%=cartItem.getProductId()%>"> - </a>
                        </div>
                    </td>
                    <td class="text-center text-lg text-medium">
                        <div class="cart-table-row"><%=cartItem.getPrice()%></div>
                    </td>
                    <td class="text-center text-lg text-medium">
                        <div class="cart-table-row"><%=cartItem.getPrice() * cartItem.getBoughtQuantity()%></div>
                    </td>
                    <td class="text-center">
                        <div class="cart-table-row">
                            <a class="remove-from-cart"
                               href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>"
                               data-toggle="tooltip" title data-original-title="Remove item">
                                <i class="fa fa-trash"></i>
                            </a>
                        </div>
                    </td>
                </tr>
                <%
                    }
                %>
                </tbody>
            </table>
        </div>

        <div class="shopping-cart-footer">
            <div class="column text-lg">Subtotal: &nbsp;Rs.<span
                    class="text-medium"><%=cartPrice > 0 ? cartPrice :  0%></span></div>
            <div class="column">
                <a class="btn btn-warning" href="./index.jsp"><i class="icon-arrow-left"></i>&nbsp;Back to Shopping</a>
                <form action="payment" method="post">
                    <input type="hidden" name="action" value="checkout">
                    <%
                        if (session.getAttribute("auth") == null) {
                    %>
                    <button class="btn btn-success" type="button" onclick="popup.showModal()"
                            style="background-color: #0dec2b">Checkout</button>
                    <dialog class="popup" id="popup">
                        <h2>Oops!</h2>
                        <p>It looks like you are not logged in, Please log in to continue with the purchase. Click <a
                                href="./login.jsp">here</a> to log in.</p>
                        <button type="button" class="btn btn-success" onclick="popup.close()"
                                style="background-color: #050505">Close</button>
                    </dialog>

                    <%} else {%>
                    <button class="btn btn-success" type="submit" style="background-color: #0dec2b">Checkout</button>
                    <%
                        }
                    %>
                </form>
            </div>
        </div>
    </div>

    <%
    } else {
    %>
    <div class="empty_cart">
        <img src="images/main/empty_cart.png" alt="">
        <h2>Oops! It looks like your cart is empty</h2>
    </div>
    <%
        }
    %>
</section>
<%@ include file="includes/footer.jsp" %>
