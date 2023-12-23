<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<% if(session.getAttribute("product") == null) {
    response.sendRedirect("index.jsp");
} else {
    @SuppressWarnings("unchecked")
    List<Product> productList = (List<Product>) session.getAttribute("product");
%>
<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<div class="product-grid grid grid--product">
    <%for(var product : productList) {%>
    <div class="product-card" >
            <img src="./uploadedImages/product/<%=product.getImageName()%>" alt="" />
            <h3><%=product.getProductName()%></h3>
            <p><%=product.getDescription()%></p>
            <p><%=product.getPrice()%></p>
            <button class="buy-1" onclick="cart(<%=product.getProductId()%>)">Add to Cart</button>
    </div>
    <%}%>
</div>

<%@ include file="includes/footer.jsp"%>
<%
    }
%>