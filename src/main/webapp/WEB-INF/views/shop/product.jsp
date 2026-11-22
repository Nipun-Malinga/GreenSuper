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
%>
<main>
    <%-- Same header band and grid as categories.jsp --%>
    <section class="border-b border-slate-200 bg-gradient-to-b from-brand-50 to-slate-50">
        <div class="container-page flex items-center justify-between gap-6 py-10 sm:py-14">
            <div>
                <nav class="eyebrow flex-wrap" aria-label="Breadcrumb">
                    <a href="categories.jsp" class="hover:text-brand-900"><i class="fa fa-leaf"></i> Categories</a>
                    <i class="fa fa-chevron-right text-[0.55rem] text-brand-400"></i>
                    <span aria-current="page"><%= category.getCategoryType() %></span>
                </nav>
                <h1 class="page-title mt-2"><%= category.getCategoryType() %></h1>
                <p class="lead mt-2"><%= productList.size() %> <%= productList.size() == 1 ? "product" : "products" %> in this aisle.</p>
            </div>
            <img src="./uploadedImages/category/<%= category.getImageName() %>" alt=""
                 class="hidden size-28 shrink-0 rounded-2xl object-cover shadow-sm ring-1 ring-slate-200 sm:block lg:size-32" />
        </div>
    </section>

    <section class="container-page py-10">
        <% if (productList.isEmpty()) { %>
        <div class="card mx-auto max-w-md p-10 text-center">
            <span class="mx-auto grid size-16 place-items-center rounded-2xl bg-brand-50 text-2xl text-brand-600"><i class="fa fa-basket-shopping"></i></span>
            <h2 class="mt-5 text-xl font-semibold">Nothing in this aisle yet</h2>
            <p class="mt-2 text-sm text-slate-500">Sorry! There is no item in this category right now.</p>
            <a href="categories.jsp" class="btn btn-primary mt-6 rounded-full px-6">Browse other categories</a>
        </div>
        <% } else { %>
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 sm:gap-6 lg:grid-cols-4 xl:grid-cols-5">
            <% for (var product : productList) { %>
            <%@ include file="/WEB-INF/views/includes/product_card.jsp" %>
            <% } %>
        </div>
        <% } %>
    </section>
</main>
<%
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<%@ include file="/WEB-INF/views/includes/footer.jsp" %>
