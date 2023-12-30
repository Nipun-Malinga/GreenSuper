<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%
    CategoryDao categoryDao = new CategoryDao();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Update Form</title>
    <link rel="stylesheet" href="./css/admin/addproduct.css">
</head>
<body>
<%
    if(request.getParameter("categoryId") != null) {
    int categoryId = Integer.parseInt(request.getParameter("categoryId"));
    Category category = categoryDao.getCategory(categoryId);
    System.out.println(category.getCategoryId());
%>
<form class="product-form">
    <h1> Update Category</h1>
    <label for="product-name">Category Name</label>
    <input type="text" id="product-name" name="product-name" value="<%=category.getCategoryType()%>" required>

    <label for="product-image">Category Image</label>
    <input type="file" id="product-image" name="product-image" required><br><br>

    <button type="submit">Update</button>
    <button type="reset">Cancel</button>
</form>
    <form class="product-form" action="categoryManagement" method="post">
        <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
        <input type="hidden" name="operation" value="delete">
        <button type="submit"><i class="uil uil-trash-alt"></i>
        <span class="link-name">Delete</span></button>
    </form>
</body>
</html>

<%
    }else {
        response.sendRedirect("admin_categories.jsp");
    }
%>