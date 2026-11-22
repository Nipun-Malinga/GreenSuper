<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ include file="/WEB-INF/views/includes/admin/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/admin/navbar.jsp"%>

<%
    response.setHeader("Cache-Control", "no-cache, no-store, must-revalidate");
    if(session.getAttribute("adminAuth") == null) {
        response.sendRedirect("./admin_login.jsp");
    }

    CategoryDao categoryDao = new CategoryDao();
    List<Category> categoryList = categoryDao.getAllCategories();
%>

<section class="dashboard">
    <%@ include file="/WEB-INF/views/includes/admin/topbar.jsp"%>

    <main class="p-4 sm:p-8">
        <div class="flex flex-wrap items-center justify-between gap-4">
            <h1 class="text-2xl font-bold">Categories</h1>
            <a href="admin_add_category.jsp" class="btn btn-primary"><i class="uil uil-plus-circle text-lg"></i> Add Category</a>
        </div>
        <div class="card mt-6 overflow-x-auto">
            <table class="table-base">
                <thead>
                <tr>
                    <th>Category ID</th>
                    <th>Category Name</th>
                    <th>Category Image</th>
                    <th>Action</th>
                </tr>
                </thead>
                <tbody>

                <%
                    if(categoryList != null) {
                        for(var category : categoryList ) {
                %>
                <tr>
                    <td class="text-slate-500">#<%=category.getCategoryId()%></td>
                    <td class="font-medium text-slate-900"><%=category.getCategoryType()%></td>
                    <td><img src="uploadedImages/category/<%=category.getImageName()%>" alt="" class="size-12 rounded-lg object-cover"></td>
                    <td><a href="admin_manage_category.jsp?categoryId=<%=category.getCategoryId()%>" class="btn btn-outline px-3 py-1.5">Manage</a></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>

            </table>
        </div>
    </main>
</section>

<%@ include file="/WEB-INF/views/includes/admin/end.jsp"%>
