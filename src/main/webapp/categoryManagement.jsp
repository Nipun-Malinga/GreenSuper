<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<html>
<head>
    <title>Admin Panel - Green Super</title>
</head>
<body>
    <form method="post" action="categoryManagement" enctype="multipart/form-data">
        <label>
            <input type="hidden" name="operation" value="add" readonly>
        </label>
        <label>
            <input type="text" name="category" placeholder="Enter new category.">
        </label>
        <label>
            <input type="file" name="image">
        </label>
        <input type="submit">
    </form>
</body>
</html>
