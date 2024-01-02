<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>
<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<%
    if (session.getAttribute("cart_item") != null && session.getAttribute("cartPrice") != null) {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        double cartPrice;
        @SuppressWarnings("unchecked")
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
        cartPrice = (double) session.getAttribute("cartPrice");
%>

<div class="container padding-bottom-3x mb-1">
    <div><h2>Confirm before proceeding with the payment.</h2></div>

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
                for(var cartItem : cartItemList) {
            %>
            <tr>
                <td>
                    <div class="product-item">
                        <img class="rounded" src="./uploadedImages/product/<%=cartItem.getImageName()%>" alt="Avocado" width="80px" height="80px" />
                        <p class="item-name"><%=cartItem.getProductName()%></p>
                    </div>
                </td>
                <td class="text-center">
                    <div class="count-input">
                        <a href="quantity-inc-dec?action=inc&productId=<%=cartItem.getProductId()%>"> + </a>
                        <label>
                            <input type="text" class="form-control" readonly value="<%=cartItem.getBoughtQuantity()%>" />
                        </label>
                        <a href="quantity-inc-dec?action=dec&productId=<%=cartItem.getProductId()%>"> - </a>
                    </div>
                </td>
                <td class="text-center text-lg text-medium"><%=cartItem.getPrice()%></td>
                <td class="text-center text-lg text-medium"><%=cartItem.getPrice() * cartItem.getBoughtQuantity()%></td>
                <td class="text-center">
                    <a class="remove-from-cart" href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>" data-toggle="tooltip" title data-original-title="Remove item">
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
        <div class="column text-lg">Subtotal: &nbsp;Rs.<span class="text-medium"><%=cartPrice > 0 ? cartPrice :  0%></span></div>
        <div class="column">
            <a class="btn btn-warning" href="./index.jsp">&nbsp;Back to Shopping</a>
            <form action="payment" method="post">
                <input type="hidden" name="paymentId" value="<%=paymentId%>">
                <input type="hidden" name="PayerId" value="<%=payerId%>">
                <input type="hidden" name="action" value="execute_payment">
                <button class="btn btn-success" type="submit">Execute Payment</button>
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

<%@ include file="includes/footer.jsp"%>





