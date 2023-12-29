<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Admin Panel (Add Product) - Green Super</title>
</head>
<body>
    <%
        if(session.getAttribute("category") == null) {
            response.sendRedirect("productManagement");
        }
        else {
        @SuppressWarnings("unchecked")
        List<Category> categoryList = (List<Category>) session.getAttribute("category");
    %>
    <form action="productManagement" method="post" enctype="multipart/form-data">
        <label>
            <input type="text" name="product" placeholder="Product Name">
        </label>
        <label>
            <input type="text" name="price" placeholder="Price">
        </label>
        <label>
            <select name="category">
                <option selected>Select Category</option>
                <%
                    for (var category : categoryList) {
                %>
                <option value="<%=category.getCategoryId()%>"><%=category.getCategoryType()%></option>
                <%
                    }
                %>
            </select>
        </label>
        <label>
            <input type="text" name="quantity" placeholder="Quantity">
        </label>
        <label>
            <input type="file" name="image" accept="image/jpeg, image/png">
        </label>
        <label>
            <textarea name="description"></textarea>
        </label>
        <label>
            <input type="hidden" name="operation" value="add" hidden="hidden">
        </label>
        <input type="reset">
        <input type="submit">
    </form>
    <%
        }
    %>
</body>
</html>
