<%@ page import="org.example.greensuper.dao.ProductDao" %>
<%@ page import="org.example.greensuper.models.Product" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    } else {


    ProductDao productDao = new ProductDao();
    CategoryDao categoryDao = new CategoryDao();

    List<Category> categoryList = categoryDao.getAllCategories();

    if(request.getParameter("productId") != null) {
    int productId = Integer.parseInt(request.getParameter("productId"));
    Product product = productDao.getSingleProduct(productId);

%>
<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>
<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>
    <main class="p-4 sm:p-8">
        <a href="admin_products.jsp" class="text-sm text-slate-500 hover:text-brand-700"><i class="uil uil-arrow-left"></i> Back to products</a>
        <section class="product-form card mt-4 max-w-2xl p-6 sm:p-8">
            <form action="productManagement" method="post" enctype="multipart/form-data" class="space-y-5"
                  data-async-form data-success-url="admin_products.jsp" data-failure-event="productFailedToUpdate">
                <h1 class="text-2xl font-bold">Update Product</h1>
                <div class="flex items-center gap-4">
                    <img src="./uploadedImages/product/<%=product.getImageName()%>" alt="" class="size-20 rounded-xl object-cover ring-1 ring-slate-200">
                    <p class="text-sm text-slate-500">Current image. Leave the file field empty to keep it.</p>
                </div>
                <div>
                    <label for="product-name" class="label">Product Name</label>
                    <input type="text" id="product-name" name="productName" class="input" value="<%=product.getProductName()%>">
                </div>

                <div class="grid gap-5 sm:grid-cols-2">
                    <div>
                        <label for="product-price" class="label">Product Price</label>
                        <input type="number" id="product-price" name="price" class="input" step="0.01" value="<%=product.getPrice()%>" onkeypress="return event.charCode >= 48 && event.charCode <= 57" >
                    </div>
                    <div>
                        <label for="product-quantity" class="label">Product Quantity</label>
                        <input type="number" id="product-quantity" name="quantity" class="input" value="<%=product.getQuantity()%>" onkeypress="return event.charCode >= 48 && event.charCode <= 57" >
                    </div>
                </div>

                <div>
                    <label for="product-image" class="label">Product Image</label>
                    <input type="file" id="product-image" name="image" class="input" accept="image/jpeg, image/png" >
                </div>

                <div>
                    <label for="category" class="label">Category</label>
                    <select id="category" name="category" class="input">
                        <option value="<%=product.getCategoryId()%>" selected>Current Category: <%=product.getCategoryName()%></option>
                        <% for (var category : categoryList) { %>
                        <option value="<%=category.getCategoryId()%>"><%=category.getCategoryType()%></option>
                        <% } %>
                    </select>
                </div>

                <div>
                    <label for="description" class="label">Description</label>
                    <textarea id="description" name="description" class="input" rows="4" cols="50"><%=product.getDescription()%></textarea>
                </div>

                <input type="hidden" value="update" name="operation">
                <input type="hidden" value="<%=product.getProductId()%>" name="productId">
                <input type="hidden" value="<%=product.getImageName()%>" name="productImageName">
                <div class="flex gap-3 pt-2">
                    <button type="submit" class="btn btn-primary">Update</button>
                    <button type="reset" class="btn btn-outline">Cancel</button>
                </div>
            </form>
            <form action="productManagement" method="post" data-async-form data-success-url="admin_products.jsp" data-failure-event="failedToDeleteProduct"
                  data-confirm="Delete this product permanently?" class="mt-8 flex items-center justify-between gap-4 rounded-xl border border-red-200 bg-red-50 p-4">
                <p class="text-sm text-red-700">Delete this product permanently.</p>
                <input type="hidden" name="productId" value="<%=product.getProductId()%>">
                <input type="hidden" name="operation" value="delete">
                <button type="submit" class="btn btn-danger"><i class="uil uil-trash-alt"></i>
                    <span class="link-name">Delete</span></button>
            </form>
        </section>
    </main>
</section>
<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>

<%
        } else {
            response.sendRedirect("./admin_products.jsp");
        }
    }
%>
