<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Read from the database on every request so new products show up immediately.
    List<Product> latestProducts = new ProductDao().getLatestProducts(8);
%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>
<main>
    <!-- Hero: CSS scroll-snap slider (no JS). Banners are 3:1 with their own headlines, so show them uncropped. -->
    <section class="container-page pt-6">
        <h1 class="sr-only">Green Super: fresh groceries, delivered</h1>
        <div class="overflow-hidden rounded-2xl shadow-lg sm:rounded-3xl">
            <div class="flex snap-x snap-mandatory overflow-x-auto scroll-smooth [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
                <a href="categories.jsp" class="w-full shrink-0 snap-center"><img src="./images/main/carousel/family.jpg" class="aspect-[3/1] w-full object-cover" alt="More than a store, it's your family's shopping paradise"></a>
                <a href="categories.jsp" class="w-full shrink-0 snap-center"><img src="./images/main/carousel/namki.jpg" class="aspect-[3/1] w-full object-cover" alt="Garden-fresh goodness just a click away"></a>
                <a href="categories.jsp" class="w-full shrink-0 snap-center"><img src="./images/main/carousel/orange.jpg" class="aspect-[3/1] w-full object-cover" alt="Shop smart, live well"></a>
            </div>
        </div>
    </section>

    <!-- Services -->
    <section class="container-page mt-10">
        <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <div class="card card-hover flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-truck"></i></span>
                <div><h4 class="text-sm font-semibold sm:text-base">Fresh Products</h4><p class="text-sm text-slate-500">Freshness from farm to store</p></div>
            </div>
            <div class="card card-hover flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-headset"></i></span>
                <div><h4 class="text-sm font-semibold sm:text-base">Customer Support 24/7</h4><p class="text-sm text-slate-500">24/7 Customer care support</p></div>
            </div>
            <div class="card card-hover flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-circle-check"></i></span>
                <div><h4 class="text-sm font-semibold sm:text-base">100% Secure Payment</h4><p class="text-sm text-slate-500">We ensure your money is safe</p></div>
            </div>
            <div class="card card-hover flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-clock"></i></span>
                <div><h4 class="text-sm font-semibold sm:text-base">Fast Delivery</h4><p class="text-sm text-slate-500">Freshly Delivered to your doorstep</p></div>
            </div>
        </div>
    </section>

    <!-- Latest products -->
    <section class="container-page mt-14">
        <div class="flex items-end justify-between gap-4">
            <div>
                <span class="eyebrow">Just in</span>
                <h2 class="section-title mt-1">Fresh Arrivals</h2>
                <p class="mt-1 text-sm text-slate-500">The newest products in our store.</p>
            </div>
            <a href="categories.jsp" class="group shrink-0 text-sm font-semibold text-brand-700">Browse categories <i class="fa fa-arrow-right transition-transform group-hover:translate-x-0.5"></i></a>
        </div>
        <% if (latestProducts.isEmpty()) { %>
        <p class="mt-6 text-slate-500">New products are on the way. Check back soon!</p>
        <% } else { %>
        <div class="mt-6 grid grid-cols-2 gap-4 sm:gap-6 md:grid-cols-3 lg:grid-cols-4">
            <% for (var product : latestProducts) { %>
            <%@ include file="/WEB-INF/views/includes/product_card.jsp" %>
            <% } %>
        </div>
        <% } %>
    </section>

    <!-- Promo tiles -->
    <section class="container-page my-14 grid gap-4 md:grid-cols-2">
        <img id="promo_cart" src="images/main/promoCard/promo1.png" alt="Cart" class="w-full cursor-pointer rounded-2xl shadow-sm transition hover:shadow-md">
        <img id="promo_contact" src="images/main/promoCard/promo2.png" alt="Contact Us" class="w-full cursor-pointer rounded-2xl shadow-sm transition hover:shadow-md">
    </section>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
