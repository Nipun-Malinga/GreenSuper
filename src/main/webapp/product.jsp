<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<%
    ProductDao productDao = new ProductDao();
    Category category = new Category();
    CategoryDao categoryDao = new CategoryDao();

    if(request.getParameter("categoryId") != null) {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        category.setCategoryId(categoryId);
        List<Product> productList = productDao.getProducts(category);
        category = categoryDao.getCategory(categoryId);
%>
<h1 class="product-title"><%=category.getCategoryType()%></h1>
<div class="product-grid grid grid--product container">
    <%for(var product : productList) {%>
    <div class="product-card" >
        <img src="./uploadedImages/product/<%=product.getImageName()%>" alt="" />
        <h3><%=product.getProductName()%></h3>
        <p>Rs.<%=product.getPrice()%></p>
        <button class="buy-1" onclick="AddToCart(<%=product.getProductId()%>)">Add to Cart</button>
        <span id="product<%=product.getProductId()%>"></span>
    </div>
    <%}%>
</div>

<%
    } else {

    }
%>

<%@ include file="includes/footer.jsp"%>


<%--<h1>Vegetables</h1>--%>
<%--<div class="gallery">--%>
<%--    <div class="content">--%>
<%--        <img src="brinjal.png" alt="brinjal" />--%>
<%--        <h3>Wambatu</h3>--%>
<%--        <p>Ane Ayye eeka digaine</p>--%>
<%--        <h6>Rs.100/KG</h6>--%>
<%--        <button class="buy-1">Add to Cart</button>--%>
<%--    </div>--%>
<%--</div>--%>

