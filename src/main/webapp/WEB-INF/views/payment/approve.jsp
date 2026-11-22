<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.CartItem" %>
<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>

<%
    if (session.getAttribute("cart_item") != null && session.getAttribute("cartPrice") != null) {
        String paymentId = request.getParameter("paymentId");
        String payerId = request.getParameter("PayerID");

        double cartPrice;
        @SuppressWarnings("unchecked")
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
        cartPrice = (double) session.getAttribute("cartPrice");
%>

<section class="container-page py-10">
    <h1 class="text-3xl font-bold">Confirm before proceeding with the payment.</h1>
    <p class="mt-1 text-slate-500">Review your items, then execute the PayPal payment.</p>

    <div class="mt-8 grid gap-8 lg:grid-cols-3">
        <div class="card overflow-x-auto lg:col-span-2">
            <table class="table-base">
                <thead>
                <tr>
                    <th>Product Name</th>
                    <th class="text-center">Quantity</th>
                    <th class="text-right">Price</th>
                    <th class="text-right">Subtotal</th>
                    <th></th>
                </tr>
                </thead>
                <tbody>
                <%
                    for(var cartItem : cartItemList) {
                %>
                <tr>
                    <td>
                        <div class="flex items-center gap-3">
                            <img class="size-14 rounded-lg object-cover" src="./uploadedImages/product/<%=cartItem.getImageName()%>" alt="" />
                            <p class="font-semibold text-slate-900"><%=cartItem.getProductName()%></p>
                        </div>
                    </td>
                    <td class="text-center">
                        <div class="inline-flex items-center rounded-lg border border-slate-300">
                            <a class="grid size-8 place-items-center hover:bg-slate-100" href="quantity-inc-dec?action=dec&productId=<%=cartItem.getProductId()%>" aria-label="Decrease quantity"> - </a>
                            <label>
                                <input type="text" class="w-10 border-x border-slate-300 py-1 text-center" aria-label="Quantity" readonly value="<%=cartItem.getBoughtQuantity()%>" />
                            </label>
                            <a class="grid size-8 place-items-center hover:bg-slate-100" href="quantity-inc-dec?action=inc&productId=<%=cartItem.getProductId()%>" aria-label="Increase quantity"> + </a>
                        </div>
                    </td>
                    <td class="text-right">Rs.<%=cartItem.getPrice()%></td>
                    <td class="text-right font-semibold">Rs.<%=cartItem.getPrice() * cartItem.getBoughtQuantity()%></td>
                    <td class="text-center">
                        <a class="text-slate-400 hover:text-red-600" href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>" title="Remove item" aria-label="Remove item">
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

        <aside class="card h-fit p-6">
            <h2 class="text-lg font-semibold">Payment</h2>
            <div class="mt-4 flex items-center justify-between border-t border-slate-100 pt-4">
                <span class="text-slate-600">Subtotal</span>
                <span class="text-xl font-bold text-slate-900">Rs.<%=cartPrice > 0 ? cartPrice :  0%></span>
            </div>
            <form action="payment" method="post" class="mt-6">
                <input type="hidden" name="paymentId" value="<%=paymentId%>">
                <input type="hidden" name="PayerId" value="<%=payerId%>">
                <input type="hidden" name="action" value="execute_payment">
                <button class="btn btn-primary w-full" type="submit"><i class="fab fa-paypal"></i> Execute Payment</button>
            </form>
            <a class="btn btn-outline mt-3 w-full" href="./index.jsp"><i class="fa fa-arrow-left"></i> Back to Shopping</a>
        </aside>
    </div>
</section>

<%
} else {
%>
<section class="container-page py-20">
    <div class="mx-auto max-w-md text-center">
        <img src="images/main/empty_cart.svg" alt="" class="mx-auto w-64">
        <h2 class="mt-6 text-xl font-semibold">Oops! It looks like your cart is empty</h2>
    </div>
</section>
<%
    }
%>

<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
