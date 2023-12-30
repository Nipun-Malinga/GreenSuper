<%--<header>--%>
<%--    <nav class="nav collapsible">--%>
<%--        <a aria-label="Green Super Logo" class="nav__brand" href="index.jsp"><img src="images/main/logo/logo.png" alt="" /></a>--%>
<%--        <svg class="icon icon--white nav__toggler">--%>
<%--            <use href="./images/icons/sprite.svg#list"></use>--%>
<%--        </svg>--%>
<%--        <ul class="list nav__list collapsible__content">--%>
<%--            <li class="nav__item">--%>
<%--                <a target="_blank" href="index.jsp">Home</a>--%>
<%--            </li>--%>
<%--            <li class="nav__item">--%>
<%--                <a target="_blank" href="#categories">Categories</a>--%>
<%--            </li>--%>
<%--            <li class="nav__item">--%>
<%--                <a target="_blank" href="cart.jsp">Cart</a>--%>
<%--            </li>--%>
<%--            <li class="nav__item">--%>
<%--                <a target="_blank" href="#">About Us</a>--%>
<%--            </li>--%>
<%--            <li class="search">--%>
<%--                <input class="input input--dark" type="text" placeholder="Search Products" />--%>
<%--                <button class="input input-search input--dark">Search</button>--%>
<%--            </li>--%>
<%--            <li class="nav__item">--%>
<%--                <%--%>
<%--                    if(session.getAttribute("auth") == null) {--%>
<%--                %>--%>
<%--                <a target="_blank" href="login.jsp">Login | Register</a>--%>
<%--                <%--%>
<%--                    } else {--%>
<%--                        String auth = (String) session.getAttribute("auth");--%>
<%--                %>--%>
<%--                    <span><%=auth%><span>--%>
<%--                    <a href="logout">Logout</a>--%>
<%--                <%--%>
<%--                    }--%>
<%--                %>--%>
<%--            </li>--%>
<%--        </ul>--%>
<%--    </nav>--%>
<%--</header>--%>


<header class="navbar">
    <input type ="checkbox" name ="" id ="chk1">
    <div class="logo"><img class="nav__img" src="./images/main/logo/logo.png" alt=""></div>
    <ul>
        <li></li>
        <li></li>
        <li><a href="index.jsp" class="active">Home</a></li>
        <li><a href="#categories">Shop</a></li>
        <li><a href="#">About Us</a></li>
        <li><a href="cart.jsp">Cart</a></li>
        <li><a href="#">Contact</a></li>
        <li>
            <% if(session.getAttribute("auth") == null) {%>
            <a href="login.jsp"> Login / Register</a>
            <% }else {%>
            <a href="logout"><i class="fa fa-user"></i> <%=session.getAttribute("auth")%>(Log Out)</li></a>
            <% }%>
        </li>
    </ul>
    <div class="menu">
        <label for="chk1">
            <i class="fa fa-bars"></i>
        </label>
    </div>
</header>