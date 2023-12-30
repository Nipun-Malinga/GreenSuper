<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ include file="admin/admin_includes/header.jsp"%>
<%@ include file="admin/admin_includes/navbar.jsp"%>

<%
    CategoryDao categoryDao = new CategoryDao();
    List<Category> categoryList = categoryDao.fetchAllCategories();
%>

<section class="dashboard">
    <div class="top">
        <i class="uil uil-bars sidebar-toggle"></i>

        <div class="search-box">
            <i class="uil uil-search"></i>
            <input type="text" placeholder="Search here...">
        </div>
    </div><br><br><br><br>

    <main class="table">
        <section class="table__header">
            <h1>Categories</h1>
            <ul class="nav-links">
                <a href="admin_add_category.jsp">
                    <i class="uil uil-plus-circle"></i>
                    <span class="link-name">Add Category</span>
                </a></ul>
        </section>
        <section class="table__body">
            <table>
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
                    <td><%=category.getCategoryId()%></td>
                    <td><%=category.getCategoryType()%></td>
                    <td><img src="uploadedImages/category/<%=category.getImageName()%>" alt=""></td>
                    <td><a href="admin_manage_category.jsp?categoryId=<%=category.getCategoryId()%>">Manage</a></td>
                </tr>
                <%
                        }
                    }
                %>
                </tbody>

            </table>
        </section>
    </main>
</section>

<%@ include file="admin/admin_includes/end.jsp"%>