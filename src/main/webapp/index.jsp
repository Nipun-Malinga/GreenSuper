<%@ page import="java.util.List" %>
<%@ page import="org.example.greensuper.models.Category" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<%
    if (session.getAttribute("categories") == null) {
        response.sendRedirect("mainView");
    } else {
        @SuppressWarnings("unchecked")
        List<Category> categoryList = (List<Category>) session.getAttribute("categories");
%>

<%@ include file="./includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>
<section>
    <div id="carouselExampleCaptions" class="carousel slide overflow-hidden" data-bs-ride="carousel">
        <div class="carousel-indicators">
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="1" aria-label="Slide 2"></button>
            <button type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide-to="2" aria-label="Slide 3"></button>
        </div>
        <div class="carousel-inner">
            <div class="carousel-item active">
                <img src="./images/main/carousel/family.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="./images/main/carousel/namki.jpg" class="d-block w-100" alt="...">
            </div>
            <div class="carousel-item">
                <img src="./images/main/carousel/orange.jpg" class="d-block w-100" alt="...">
            </div>
        </div>
        <button class="carousel-control-prev visually-hidden" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="prev">
            <span class="carousel-control-prev-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Previous</span>
        </button>
        <button class="carousel-control-next visually-hidden" type="button" data-bs-target="#carouselExampleCaptions" data-bs-slide="next">
            <span class="carousel-control-next-icon" aria-hidden="true"></span>
            <span class="visually-hidden">Next</span>
        </button>
    </div>
</section>

<!--Services-->
<section class="services--container container shadow">
    <div class="service">
          <span class="icon-container">
            <svg class="icon icon--primary">
              <use xlink:href="./images/icons/sprite.svg#truck"></use>
            </svg>
          </span>
        <h4 class="service__heading">Fresh Products</h4>
        <p class="service__text">Freshness from farm to store</p>
    </div>
    <div class="service">
          <span class="icon-container">
            <svg class="icon icon--primary">
              <use xlink:href="./images/icons/sprite.svg#headset"></use>
            </svg>
          </span>
        <h4 class="service__heading">Customer Support 24/7</h4>
        <p class="service__text"> 24/7 Customer care support</p>
    </div>
    <div class="service">
          <span class="icon-container">
            <svg class="icon icon--primary">
              <use xlink:href="./images/icons/sprite.svg#check-circle"></use>
            </svg>
          </span>
        <h4 class="service__heading">100% Secure Payment</h4>
        <p class="service__text">We ensure your money is safe</p>
    </div>
    <div class="service">
          <span class="icon-container">
            <svg class="icon icon--primary">
              <use xlink:href="./images/icons/sprite.svg#clock"></use>
            </svg>
          </span>
        <h4 class="service__heading">Fast Delivery</h4>
        <p class="service__text">Freshly Delivered to your doorstep</p>
    </div>
</section>

        <section class="top__categories container" id="categories">
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

<%--<section class="best__deals__container container">--%>
<%--    <!----%>
<%--      Card 01--%>
<%--    -->--%>
<%--    <div class="best__deals meat">--%>
<%--        <img--%>
<%--                src="./images/main/best__deals/healthy-food-dish-blue-background-healthful-set-including-vegetables-fruits-grape-apple-kiwi-pepper-lime-cabbage-zucchini-grapefruit-avocado-proper-nutrition-vegetarian-menu.jpg"--%>
<%--                alt=""--%>
<%--                class="background"--%>
<%--        />--%>
<%--        <p>85% FAT FREE</p>--%>
<%--        <h2>Low-Fat Meat</h2>--%>
<%--        <p>Started at <span class="highlight">$79.99</span></p>--%>
<%--        <button class="btn btn-white">Shop now</button>--%>
<%--    </div>--%>
<%--    <!----%>
<%--      Card 02--%>
<%--    -->--%>
<%--    <div class="best__deals sales_of_the_month">--%>
<%--        <img--%>
<%--                src="./images/main/best__deals/healthy-food-dish-blue-background-healthful-set-including-vegetables-fruits-grape-apple-kiwi-pepper-lime-cabbage-zucchini-grapefruit-avocado-proper-nutrition-vegetarian-menu.jpg"--%>
<%--                alt=""--%>
<%--                class="background"--%>
<%--        />--%>
<%--        <p>BEST DEALS</p>--%>
<%--        <h2>Sale of the Month</h2>--%>

<%--        <button class="btn btn-white">Shop now</button>--%>
<%--    </div>--%>
<%--    <!----%>
<%--      Card 03--%>
<%--    -->--%>
<%--    <div class="best__deals fruit">--%>
<%--        <img--%>
<%--                src="./images/main/best__deals/healthy-food-dish-blue-background-healthful-set-including-vegetables-fruits-grape-apple-kiwi-pepper-lime-cabbage-zucchini-grapefruit-avocado-proper-nutrition-vegetarian-menu.jpg"--%>
<%--                alt=""--%>
<%--                class="background"--%>
<%--        />--%>
<%--        <p>SUMMER SALE</p>--%>
<%--        <h2>100% Fresh Fruit</h2>--%>
<%--        <p>Up to <span class="black_highlight">64% OFF</span></p>--%>
<%--        <button class="btn btn-white">Shop now</button>--%>
<%--    </div>--%>
<%--</section>--%>
<section>
    <div class="promo">
        <img id="promo_cart" src="images/main/promoCard/promo1.png"  alt="Cart">
        <img id="promo_contact" src="images/main/promoCard/promo2.png"  alt="Contact Us">
    </div>
</section>
<%@ include file="includes/footer.jsp"%>
<%
    }
%>