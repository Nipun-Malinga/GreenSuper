<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%

    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    } else {

    if(request.getParameter("categoryId") != null) {
        int categoryId = Integer.parseInt(request.getParameter("categoryId"));
        CategoryDao categoryDao = new CategoryDao();

        Category category = categoryDao.getCategory(categoryId);
        System.out.println(category.getCategoryId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Update Form</title>
    <link rel="stylesheet" href="css/admin/addProduct.css">
</head>
<body>
<form class="product-form" action="categoryManagement" method="post" enctype="multipart/form-data">
    <h1> Update Category</h1>
    <label for="product-name">Category Name</label>
    <input type="text" id="product-name" name="categoryName" value="<%=category.getCategoryType()%>" >

    <label for="image">Category Image</label>
    <input type="file" id="image" name="category-image" ><br><br>

    <input type="hidden" name="operation" value="update">
    <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
    <button type="submit">Update</button>
    <button type="reset">Reset</button>
</form>
    <form class="product-form" action="categoryManagement" method="post">
        <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
        <input type="hidden" name="category_imageName" value="<%=category.getImageName()%>">
        <input type="hidden" name="operation" value="delete">
        <button class="danger_btn" type="submit">Delete</button>
    </form>
</body>
</html>

<%
        }else {
        response.sendRedirect("admin_categories.jsp");
        }
    }
%>