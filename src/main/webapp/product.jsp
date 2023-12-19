<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    if(session.getAttribute("product") == null) {
        response.sendRedirect("productView");
    } else {
    @SuppressWarnings("unchecked")
    List<Product> products = (List<Product>) session.getAttribute("product");
    int categoryID = Integer.parseInt(request.getParameter("categoryId"));
%>
<%@ include file="./includes/header.jsp"%>
<div class="product-grid grid grid--product">
    <% for(var product : products) { %>
    <div class="product-card">
        <img src="./uploadedImages/category/<%=product.getImageName()%>" alt="brinjal" />
        <h3><%=product.getProductName()%>></h3>
        <p><%=product.getDescription()%></p>
        <h6><%=product.getPrice()%>></h6>
        <button class="buy-1" onclick="options.showModal()">Add to Cart</button>

        <!--TODO: Complete the popup card-->
        <dialog id="options" class="popup">
            <img src="./images/main/categories/meat.png" class="card--img" alt="" />
            <h3>name</h3>

            <button class="btn btn-primary">Add to cart</button>
            <button onclick="options.close()">
                <svg class="icon icon--primary">
                    <use xlink:href="./images/icons/sprite.svg#cancel"></use>
                </svg>
            </button>
        </dialog>
    </div>
    <% } %>
</div>
<%@ include file="includes/footer.jsp"%>

<% } %>