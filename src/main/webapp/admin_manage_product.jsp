<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    ProductDao productDao = new ProductDao();
    CategoryDao categoryDao = new CategoryDao();

    List<Category> categoryList = categoryDao.getAllCategories();

    if(request.getParameter("productId") != null) {
    int productId = Integer.parseInt(request.getParameter("productId"));
    Product product = productDao.getSingleProduct(productId);

%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Product Form</title>
    <link rel="stylesheet" href="./css/admin/addproduct.css">
</head>
<body>
<form class="product-form" action="productManagement" method="post" enctype="multipart/form-data">
    <h1> Update Product</h1>
    <label for="product-name">Product Name</label>
    <input type="text" id="product-name" name="productName" value="<%=product.getProductName()%>" required>

    <label for="product-price">Product Price</label>
    <input type="number" id="product-price" name="price" step="0.01" value="<%=product.getPrice()%>" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>

    <label for="product-quantity">Product Quantity</label>
    <input type="number" id="product-quantity" name="quantity" value="<%=product.getQuantity()%>" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>

    <label for="product-image">Product Image</label>
    <input type="file" id="product-image" name="image" accept="image/jpeg, image/png" required><br><br>

    <label for="category">Category</label>
    <select id="category" name="category" required>
        <option value="<%=product.getCategoryId()%>" selected>Current Category: <%=product.getCategoryName()%></option>
        <% for (var category : categoryList) { %>
        <option value="<%=category.getCategoryId()%>"><%=category.getCategoryType()%></option>
        <% } %>
    </select>

    <label for="description">Description</label>
    <textarea id="description" name="description"  rows="4" cols="50"><%=product.getDescription()%></textarea>

    <input type="hidden" value="update" name="operation">
    <input type="hidden" value="<%=product.getProductId()%>" name="productId">
    <button type="submit">Update</button>
    <button type="reset">Cancel</button>
</form>
<form class="product-form" action="productManagement" method="post">
    <input type="hidden" name="productId" value="<%=product.getProductId()%>">
    <input type="hidden" name="operation" value="delete">
    <button type="submit"><i class="uil uil-trash-alt"></i>
        <span class="link-name">Delete</span></button>
</form>
</body>
</html>

<%
    } else {
        response.sendRedirect("./admin_products.jsp");
    }
%>