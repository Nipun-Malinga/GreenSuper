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
<section class="container-page py-10">
    <div class="flex items-center justify-between">
        <h1 class="text-3xl font-bold">My Shopping Cart</h1>
        <a class="text-sm font-medium text-brand-700 hover:underline" href="#">Clear Cart</a>
    </div>

    <div class="mt-8 grid gap-8 lg:grid-cols-3">
        <div class="card divide-y divide-slate-100 lg:col-span-2">
            <div class="hidden grid-cols-12 gap-4 px-5 py-3 text-xs font-semibold tracking-wide text-slate-500 uppercase md:grid">
                <span class="col-span-5">Product</span>
                <span class="col-span-3 text-center">Quantity</span>
                <span class="col-span-2 text-right">Price</span>
                <span class="col-span-2 text-right">Subtotal</span>
            </div>
            <%
                for (var cartItem : cartItemList) {
            %>
            <div class="grid grid-cols-12 items-center gap-4 px-5 py-4">
                <div class="col-span-12 flex items-center gap-4 md:col-span-5">
                    <img class="size-20 rounded-xl object-cover" src="./uploadedImages/product/<%=cartItem.getImageName()%>" alt="" />
                    <div class="min-w-0">
                        <p class="font-semibold text-slate-900"><%=cartItem.getProductName()%></p>
                        <p class="text-sm text-slate-500 md:hidden">Rs.<%=cartItem.getPrice()%> each</p>
                    </div>
                    <a class="ml-auto grid size-9 place-items-center rounded-lg text-slate-400 hover:bg-red-50 hover:text-red-600 md:hidden"
                       href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>" title="Remove item" aria-label="Remove item">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
                <div class="col-span-6 flex justify-start md:col-span-3 md:justify-center">
                    <div class="inline-flex items-center rounded-lg border border-slate-300">
                        <a class="grid size-9 place-items-center text-slate-600 hover:bg-slate-100" href="quantity-inc-dec?action=dec&productId=<%=cartItem.getProductId()%>" aria-label="Decrease quantity"> - </a>
                        <label>
                            <input type="text" class="w-10 border-x border-slate-300 py-1.5 text-center text-sm" aria-label="Quantity"
                                   readonly value="<%=cartItem.getBoughtQuantity()%>" />
                        </label>
                        <a class="grid size-9 place-items-center text-slate-600 hover:bg-slate-100" href="quantity-inc-dec?action=inc&productId=<%=cartItem.getProductId()%>" aria-label="Increase quantity"> + </a>
                    </div>
                </div>
                <div class="hidden text-right text-slate-600 md:col-span-2 md:block">Rs.<%=cartItem.getPrice()%></div>
                <div class="col-span-6 flex items-center justify-end gap-3 md:col-span-2">
                    <span class="font-semibold text-slate-900">Rs.<%=cartItem.getPrice() * cartItem.getBoughtQuantity()%></span>
                    <a class="hidden size-9 place-items-center rounded-lg text-slate-400 hover:bg-red-50 hover:text-red-600 md:grid"
                       href="remove-Cart-Item?productId=<%=cartItem.getProductId()%>" title="Remove item" aria-label="Remove item">
                        <i class="fa fa-trash"></i>
                    </a>
                </div>
            </div>
            <%
                }
            %>
        </div>

        <aside class="card h-fit p-6">
            <h2 class="text-lg font-semibold">Order summary</h2>
            <div class="mt-4 flex items-center justify-between border-t border-slate-100 pt-4">
                <span class="text-slate-600">Subtotal</span>
                <span class="text-xl font-bold text-slate-900">Rs.<%=cartPrice > 0 ? cartPrice :  0%></span>
            </div>
            <form action="payment" method="post" class="mt-6">
                <input type="hidden" name="action" value="checkout">
                <%
                    if (session.getAttribute("auth") == null) {
                %>
                <button class="btn btn-primary w-full" type="button" onclick="popup.showModal()">Checkout</button>
                <dialog class="modal" id="popup">
                    <h2 class="text-xl font-bold">Oops!</h2>
                    <p class="mt-2">It looks like you are not logged in, Please log in to continue with the purchase. Click <a
                            class="font-semibold text-brand-700 underline" href="./login.jsp">here</a> to log in.</p>
                    <div class="mt-6 flex justify-end">
                        <button type="button" class="btn btn-dark" onclick="popup.close()">Close</button>
                    </div>
                </dialog>

                <%} else {%>
                <button class="btn btn-primary w-full" type="submit"><i class="fab fa-paypal"></i> Checkout</button>
                <%
                    }
                %>
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
        <a href="index.jsp#categories" class="btn btn-primary mt-6">Start shopping</a>
    </div>
</section>
    <%
        }
    %>
<%@ include file="includes/footer.jsp" %>
