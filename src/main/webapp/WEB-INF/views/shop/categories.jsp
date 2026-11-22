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
    <section class="border-b border-slate-200 bg-gradient-to-b from-brand-50 to-slate-50">
        <div class="container-page py-10 sm:py-14">
            <span class="eyebrow"><i class="fa fa-leaf"></i> Shop by category</span>
            <h1 class="page-title mt-2">Browse our aisles</h1>
            <p class="lead mt-2 max-w-xl">From farm-fresh produce to pantry staples, pick a category to see what's in store.</p>
        </div>
    </section>

    <section class="container-page py-10">
        <% if (categoryList.isEmpty()) { %>
        <p class="text-slate-500">No categories yet. Check back soon!</p>
        <% } else { %>
        <div class="grid grid-cols-2 gap-4 sm:grid-cols-3 sm:gap-6 lg:grid-cols-4 xl:grid-cols-5">
        <% for (var category : categoryList) { %>
            <a href="product.jsp?categoryId=<%=category.getCategoryId()%>"
               class="group card card-hover relative block aspect-[4/5] overflow-hidden focus-visible:outline-2 focus-visible:outline-offset-2 focus-visible:outline-brand-600">
                <img src="./uploadedImages/category/<%=category.getImageName()%>" alt="" loading="lazy"
                     class="absolute inset-0 size-full object-cover transition duration-500 group-hover:scale-105" />
                <div class="absolute inset-0 bg-gradient-to-t from-slate-900/80 via-slate-900/10 to-transparent"></div>
                <div class="absolute inset-x-0 bottom-0 flex items-end justify-between gap-2 p-4">
                    <h2 class="text-base font-semibold text-white sm:text-lg"><%=category.getCategoryType()%></h2>
                    <span class="grid size-8 shrink-0 place-items-center rounded-full bg-white/90 text-xs text-brand-700 transition group-hover:bg-brand-600 group-hover:text-white" aria-hidden="true">
                        <i class="fa fa-arrow-right"></i>
                    </span>
                </div>
            </a>
        <%  }  %>
        </div>
        <% } %>
    </section>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
