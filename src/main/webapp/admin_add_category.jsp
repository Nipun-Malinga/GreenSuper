<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Category Form</title>
    <link rel="stylesheet" href="./css/admin/addproduct.css">
</head>
<body>
<form class="product-form" method="post" action="categoryManagement" enctype="multipart/form-data">
    <h1>New Category</h1>

    <label>
        <input type="hidden" name="operation" value="add" readonly>
    </label>

    <label for="product-name">Category Name</label>
    <input type="text" id="product-name" name="category" required>

    <label for="product-image">Category Image</label>
    <input type="file" id="product-image" name="image" required accept="image/jpeg, image/png"><br><br>

    <button type="submit">Submit</button>
</form>
</body>
</html>
