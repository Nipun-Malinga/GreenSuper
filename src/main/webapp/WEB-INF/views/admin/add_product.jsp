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
<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>
<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>
    <main class="p-4 sm:p-8">
        <a href="admin_products.jsp" class="text-sm text-slate-500 hover:text-brand-700"><i class="uil uil-arrow-left"></i> Back to products</a>
        <form class="product-form card mt-4 max-w-2xl space-y-5 p-6 sm:p-8" action="productManagement" method="post" enctype="multipart/form-data"
              data-async-form data-success-url="admin_products.jsp" data-failure-event="failedToAddProduct">
            <h1 class="text-2xl font-bold">New Product</h1>
            <div>
                <label for="product-name" class="label">Product Name</label>
                <input type="text" id="product-name" name="product" class="input" required>
            </div>

            <div class="grid gap-5 sm:grid-cols-2">
                <div>
                    <label for="product-price" class="label">Product Price</label>
                    <input type="number" id="product-price" name="price" class="input" step="0.01" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>
                </div>
                <div>
                    <label for="product-quantity" class="label">Product Quantity</label>
                    <input type="number" id="product-quantity" name="quantity" class="input" onkeypress="return event.charCode >= 48 && event.charCode <= 57" required>
                </div>
            </div>

            <div>
                <label for="product-image" class="label">Product Image</label>
                <input type="file" id="product-image" name="image" class="input" accept="image/jpeg, image/png" required>
            </div>

            <div>
                <label for="category" class="label">Category</label>
                <select id="category" name="category" class="input" required>
                    <option value="" selected disabled>Select Category</option>
                    <% for (var category : categoryList) { %>
                    <option value="<%=category.getCategoryId()%>"><%=category.getCategoryType()%></option>
                    <% } %>
                </select>
            </div>

            <div>
                <label for="description" class="label">Description</label>
                <textarea id="description" required name="description" class="input" rows="4" cols="50"></textarea>
            </div>

            <input type="hidden" name="operation" value="add">

            <div class="flex gap-3 pt-2">
                <button type="submit" class="btn btn-primary">Submit</button>
                <button type="reset" class="btn btn-outline">Reset</button>
            </div>
        </form>
    </main>
</section>
<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>
<%
    }
%>
