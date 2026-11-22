<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("categories") == null) {
        response.sendRedirect("mainView");
    } else {
        @SuppressWarnings("unchecked")
        List<Category> categoryList = (List<Category>) session.getAttribute("categories");
%>

<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
<main>
    <!-- Hero: CSS scroll-snap slider (no JS) -->
    <section class="container-page pt-6">
        <div class="relative overflow-hidden rounded-3xl shadow-lg">
            <div class="flex snap-x snap-mandatory overflow-x-auto scroll-smooth [scrollbar-width:none] [&::-webkit-scrollbar]:hidden">
                <img src="./images/main/carousel/family.jpg" class="aspect-[21/9] w-full shrink-0 snap-center object-cover" alt="Family shopping for fresh groceries">
                <img src="./images/main/carousel/namki.jpg" class="aspect-[21/9] w-full shrink-0 snap-center object-cover" alt="Fresh produce">
                <img src="./images/main/carousel/orange.jpg" class="aspect-[21/9] w-full shrink-0 snap-center object-cover" alt="Fresh oranges">
            </div>
            <div class="pointer-events-none absolute inset-0 flex items-end bg-gradient-to-t from-slate-900/70 via-slate-900/10 to-transparent p-6 sm:p-10">
                <div class="pointer-events-auto max-w-lg">
                    <h1 class="text-2xl font-bold text-white sm:text-4xl">Fresh groceries, delivered.</h1>
                    <p class="mt-2 hidden text-sm text-slate-200 sm:block">Farm-fresh produce and everyday essentials, responsibly sourced.</p>
                    <a href="#categories" class="btn btn-primary mt-4">Shop now <i class="fa fa-arrow-right"></i></a>
                </div>
            </div>
        </div>
    </section>

    <!-- Services -->
    <section class="container-page mt-10">
        <div class="grid gap-4 sm:grid-cols-2 lg:grid-cols-4">
            <div class="card flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-truck"></i></span>
                <div><h4 class="font-semibold">Fresh Products</h4><p class="text-sm text-slate-500">Freshness from farm to store</p></div>
            </div>
            <div class="card flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-headset"></i></span>
                <div><h4 class="font-semibold">Customer Support 24/7</h4><p class="text-sm text-slate-500">24/7 Customer care support</p></div>
            </div>
            <div class="card flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-circle-check"></i></span>
                <div><h4 class="font-semibold">100% Secure Payment</h4><p class="text-sm text-slate-500">We ensure your money is safe</p></div>
            </div>
            <div class="card flex items-center gap-4 p-5">
                <span class="grid size-12 shrink-0 place-items-center rounded-xl bg-brand-50 text-xl text-brand-600"><i class="fa fa-clock"></i></span>
                <div><h4 class="font-semibold">Fast Delivery</h4><p class="text-sm text-slate-500">Freshly Delivered to your doorstep</p></div>
            </div>
        </div>
    </section>

    <!-- Categories -->
    <section class="container-page mt-14 scroll-mt-24" id="categories">
        <div class="flex items-end justify-between">
            <h2 class="text-2xl font-bold sm:text-3xl">Categories</h2>
        </div>
        <div class="mt-6 grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
        <% for (var category : categoryList) { %>
            <a href="product?categoryId=<%=category.getCategoryId()%>" class="group card overflow-hidden transition hover:-translate-y-1 hover:shadow-md">
                <div class="aspect-square overflow-hidden bg-slate-100">
                    <img src="./uploadedImages/category/<%=category.getImageName()%>" class="size-full object-cover transition duration-300 group-hover:scale-105" alt="" />
                </div>
                <p class="p-3 text-center font-semibold text-slate-800 group-hover:text-brand-700"><%=category.getCategoryType()%></p>
            </a>
        <%  }  %>
        </div>
    </section>

    <!-- Promo tiles -->
    <section class="container-page my-14 grid gap-4 md:grid-cols-2">
        <img id="promo_cart" src="images/main/promoCard/promo1.png" alt="Cart" class="w-full cursor-pointer rounded-2xl shadow-sm transition hover:shadow-md">
        <img id="promo_contact" src="images/main/promoCard/promo2.png" alt="Contact Us" class="w-full cursor-pointer rounded-2xl shadow-sm transition hover:shadow-md">
    </section>
</main>
<%@ include file="includes/footer.jsp"%>
<%
    }
%>
