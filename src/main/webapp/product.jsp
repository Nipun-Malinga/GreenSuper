<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(session.getAttribute("product") == null) {
    response.sendRedirect("index.jsp");
} else {
    @SuppressWarnings("unchecked")
    List<Product> productList = (List<Product>) session.getAttribute("product");
    Category category = (Category) session.getAttribute("categoryName");
%>
<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
<h1><%=category.getCategoryType()%></h1>
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

<%@ include file="includes/footer.jsp"%>
<%
    }
%>