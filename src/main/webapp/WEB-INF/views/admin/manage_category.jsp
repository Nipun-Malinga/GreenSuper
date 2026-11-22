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
<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>
<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>
    <main class="p-4 sm:p-8">
        <a href="admin_categories.jsp" class="text-sm text-slate-500 hover:text-brand-700"><i class="uil uil-arrow-left"></i> Back to categories</a>
        <section class="product-form card mt-4 max-w-2xl p-6 sm:p-8">
            <form action="categoryManagement" method="post" enctype="multipart/form-data" class="space-y-5"
                  data-async-form data-success-url="admin_categories.jsp" data-failure-event="failedToUpdateCategory">
                <h1 class="text-2xl font-bold">Update Category</h1>
                <div class="flex items-center gap-4">
                    <img src="uploadedImages/category/<%=category.getImageName()%>" alt="" class="size-20 rounded-xl object-cover ring-1 ring-slate-200">
                    <p class="text-sm text-slate-500">Current image. Leave the file field empty to keep it.</p>
                </div>
                <div>
                    <label for="product-name" class="label">Category Name</label>
                    <input type="text" id="product-name" name="categoryName" class="input" value="<%=category.getCategoryType()%>" >
                </div>
                <div>
                    <label for="image" class="label">Category Image</label>
                    <input type="file" id="image" name="category-image" class="input" >
                </div>

                <input type="hidden" name="operation" value="update">
                <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
                <!-- Sending the image name to the server
                so the ado can update the existing image name if the user doesn't change the image.  -->
                <input type="hidden" name="category_imageName" value="<%=category.getImageName()%>">
                <div class="flex gap-3 pt-2">
                    <button type="submit" class="btn btn-primary">Update</button>
                    <button type="reset" class="btn btn-outline">Reset</button>
                </div>
            </form>

            <!--Delete Category-->
            <form action="categoryManagement" method="post" data-async-form data-success-url="admin_categories.jsp" data-failure-event="failedToDeleteCategory"
                  data-confirm="Delete this category and all of its products permanently?" class="mt-8 flex items-center justify-between gap-4 rounded-xl border border-red-200 bg-red-50 p-4">
                <p class="text-sm text-red-700">Delete this category permanently.</p>
                <input type="hidden" name="categoryId" value="<%=category.getCategoryId()%>">
                <input type="hidden" name="operation" value="delete">
                <button class="danger_btn btn btn-danger" type="submit"><i class="uil uil-trash-alt"></i> Delete</button>
            </form>
        </section>
    </main>
</section>
<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>

<%
        }else {
        response.sendRedirect("admin_categories.jsp");
        }
    }
%>
