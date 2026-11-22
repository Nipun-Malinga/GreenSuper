<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page import="org.example.greensuper.dao.CategoryDao" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    // Always read categories from the database so newly added ones show up immediately.
    List<Category> categoryList = new CategoryDao().getAllCategories();
%>

<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>
<main>
    <section class="container-page py-10">
        <div class="flex items-end justify-between">
            <h1 class="text-3xl font-bold">Categories</h1>
        </div>
        <% if (categoryList.isEmpty()) { %>
        <p class="mt-6 text-slate-500">No categories yet. Check back soon!</p>
        <% } else { %>
        <div class="mt-6 grid grid-cols-2 gap-4 sm:grid-cols-3 lg:grid-cols-5">
        <% for (var category : categoryList) { %>
            <a href="product.jsp?categoryId=<%=category.getCategoryId()%>" class="group card overflow-hidden transition hover:-translate-y-1 hover:shadow-md">
                <div class="aspect-square overflow-hidden bg-slate-100">
                    <img src="./uploadedImages/category/<%=category.getImageName()%>" class="size-full object-cover transition duration-300 group-hover:scale-105" alt="" />
                </div>
                <p class="p-3 text-center font-semibold text-slate-800 group-hover:text-brand-700"><%=category.getCategoryType()%></p>
            </a>
        <%  }  %>
        </div>
        <% } %>
    </section>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
