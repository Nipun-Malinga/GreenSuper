<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>

<%@ include file="/WEB-INF/views/includes/header.jsp" %>
<%@ include file="/WEB-INF/views/includes/navbar.jsp" %>

<%
    ProductDao productDao = new ProductDao();
    CategoryDao categoryDao = new CategoryDao();

    if (request.getParameter("categoryId") != null) {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category category = categoryDao.getCategory(categoryId);
        List<Product> productList = productDao.getProducts(category);

        if (productList.isEmpty()) {
%>
    <section class="container-page py-20">
        <div class="mx-auto max-w-md text-center">
            <img src="images/main/empty_category.png" alt="" class="mx-auto w-56">
            <h2 class="mt-6 text-xl font-semibold">Sorry! There is no item in this category right now.</h2>
            <a href="categories.jsp" class="btn btn-primary mt-6">Browse other categories</a>
        </div>
<%
} else {
%>
    <section class="container-page py-10">
    <nav class="text-sm text-slate-500"><a href="index.jsp" class="hover:text-brand-700">Home</a> <span class="mx-1">/</span> <a href="categories.jsp" class="hover:text-brand-700">Categories</a> <span class="mx-1">/</span> <span class="text-slate-700"><%= category.getCategoryType() %></span></nav>
    <h1 class="mt-2 text-3xl font-bold"><%= category.getCategoryType() %></h1>
    <div class="mt-8 grid grid-cols-2 gap-4 sm:gap-6 md:grid-cols-3 lg:grid-cols-4">
        <% for (var product : productList) { %>
        <div class="card flex flex-col overflow-hidden">
            <div class="aspect-square bg-slate-100">
                <img src="./uploadedImages/product/<%= product.getImageName() %>" alt="" class="size-full object-cover" />
            </div>
            <div class="flex flex-1 flex-col p-4">
                <h3 class="font-semibold text-slate-900"><%= product.getProductName() %></h3>
                <p class="mt-1 text-lg font-bold text-brand-700">Rs.<%= product.getPrice() %></p>
                <button class="btn btn-primary mt-auto w-full" onclick="AddToCart(<%= product.getProductId() %>)"><i class="fa fa-cart-plus"></i> Add to Cart</button>
                <span id="product<%= product.getProductId() %>" class="mt-2 text-center text-sm font-medium text-brand-700 empty:hidden"></span>
            </div>
        </div>
        <% } %>
    </div>
<%
        }
%>
    </section>
<%
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
