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
        <header>
            <nav class="nav collapsible">
                <a aria-label="Green Super Logo" class="nav__brand" href="#"><img src="images/main/logo/logo.png" alt="" /></a>
                <svg class="icon icon--white nav__toggler">
                    <use href="./images/icons/sprite.svg#list"></use>
                </svg>
                <ul class="list nav__list collapsible__content">
                    <li class="nav__item">
                        <a target="_blank" href="#">Home</a>
                    </li>
                    <li class="nav__item">
                        <a target="_blank" href="#">Categories</a>
                    </li>
                    <li class="nav__item">
                        <a target="_blank" href="#">About Us</a>
                    </li>
                    <li class="search">
                        <input class="input input--dark" type="text" placeholder="Search Products" />
                        <button class="input input-search input--dark">Search</button>
                    </li>
                    <li class="nav__item">
                        <a target="_blank" href="#">Login | Register</a>
                    </li>
                </ul>
            </nav>
        </header>

<!--Categories-->
        <section class="top__categories container" id="#categories">
            <h1 class="categories__topic">Categories</h1>
            <div class="categories">
            <% for (var category : categoryList) { %>
                <div class="item" onclick="getCategoryID(<%=category.getCategoryId()%>)">
                        <img src="./uploadedImages/category/<%=category.getImageName()%>" class="item__img" alt="" />
                        <p><%=category.getCategoryType()%></p>
                </div>
            <%  }  %>
            </div>
        </section>
<%@ include file="includes/footer.jsp"%>

<%
    }
%>