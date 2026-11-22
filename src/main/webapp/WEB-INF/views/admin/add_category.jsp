<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");

    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    }
%>

<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>
<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>
    <main class="p-4 sm:p-8">
        <a href="admin_categories.jsp" class="text-sm text-slate-500 hover:text-brand-700"><i class="uil uil-arrow-left"></i> Back to categories</a>
        <form class="product-form card mt-4 max-w-2xl space-y-5 p-6 sm:p-8" method="post" action="categoryManagement" enctype="multipart/form-data"
              data-async-form data-success-url="admin_categories.jsp" data-failure-event="failedToAddCategory">
            <h1 class="text-2xl font-bold">New Category</h1>

            <input type="hidden" name="operation" value="add" readonly>

            <div>
                <label for="product-name" class="label">Category Name</label>
                <input type="text" id="product-name" name="category" class="input" required>
            </div>

            <div>
                <label for="product-image" class="label">Category Image</label>
                <input type="file" id="product-image" name="image" class="input" required accept="image/jpeg, image/png">
            </div>

            <div class="flex gap-3 pt-2">
                <button type="submit" class="btn btn-primary">Submit</button>
            </div>
        </form>
    </main>
</section>
<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>
