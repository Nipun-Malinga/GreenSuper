<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>

<%@ include file="./includes/header.jsp" %>
<%@ include file="includes/navbar.jsp" %>

<%
    ProductDao productDao = new ProductDao();
    CategoryDao categoryDao = new CategoryDao();

    if (request.getParameter("categoryId") != null) {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        Category category = categoryDao.getCategory(categoryId);
        List<Product> productList = productDao.getProducts(category);

        if (productList.isEmpty()) {
%>
    <section class="product-page">
        <div class="empty_cart">
            <img src="images/main/empty_category.png" alt="">
            <h2 class="no-product-heading">Sorry! There is no item in this category right now.</h2>
        </div>
<%
} else {
%>
    <h1 class="product-title"><%= category.getCategoryType() %></h1>
    <div class="product-grid grid grid--product container">
        <% for (var product : productList) { %>
        <div class="product-card">
            <img src="./uploadedImages/product/<%= product.getImageName() %>" alt="" />
            <h3><%= product.getProductName() %></h3>
            <p>Rs.<%= product.getPrice() %></p>
            <button class="buy-1" onclick="AddToCart(<%= product.getProductId() %>)">Add to Cart</button>
            <span id="product<%= product.getProductId() %>"></span>
        </div>
        <% } %>
    </div>
</section>
<%
        }
    } else {
        response.sendRedirect("index.jsp");
    }
%>

<%@ include file="includes/footer.jsp" %>
