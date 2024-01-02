<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    } else {
        CategoryDao categoryDao = new CategoryDao();
        List<Category> categoryList = categoryDao.getAllCategories();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Product Form</title>
    <link rel="stylesheet" href="./css/admin/addProduct.css">
</head>
<body>

<form class="product-form" action="productManagement" method="post" enctype="multipart/form-data">
    <h1>New Product</h1>
    <label for="product-name">Product Name</label>
    <input type="text" id="product-name" name="product" required>

    <label for="product-price">Product Price</label>
    <input type="number" id="product-price" name="price" step="0.01" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>

    <label for="product-quantity">Product Quantity</label>
    <input type="number" id="product-quantity" name="quantity" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>

    <label for="product-image">Product Image</label>
    <input type="file" id="product-image" name="image" accept="image/jpeg, image/png" required><br><br>

    <label for="category">Category</label>
        <select id="category" name="category" required>
            <option selected>Select Category</option>
            <% for (var category : categoryList) { %>
            <option value="<%=category.getCategoryId()%>"><%=category.getCategoryType()%></option>
            <% } %>
        </select>

    <label for="description">Description</label>
    <textarea id="description" required name="description" rows="4" cols="50"></textarea>

    <input type="hidden" name="operation" value="add">

    <button type="submit">Submit</button>
    <button type="reset">Reset</button>
</form>
</body>
</html>
<%
    }
%>
