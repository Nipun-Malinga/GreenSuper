<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if(session.getAttribute("categories") == null) {
        response.sendRedirect("mainView");
    } else {
        @SuppressWarnings("unchecked")
        List<Category> categoryList = (List<Category>) session.getAttribute("categories");
%>

<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
        <section class="top__categories container" id="#categories">
            <h1 class="categories__topic">Categories</h1>
            <div class="categories">
            <% for (var category : categoryList) { %>
                <div class="item">
                        <a href="product?categoryId=<%=category.getCategoryId()%>">
                            <img src="./uploadedImages/category/<%=category.getImageName()%>" class="item__img" alt="" />
                        </a>
                        <p><%=category.getCategoryType()%></p>
                </div>
            <%  }  %>
            </div>
        </section>
<%@ include file="includes/footer.jsp"%>
<%
    }
%>