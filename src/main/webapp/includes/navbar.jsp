<header>
    <nav class="nav collapsible">
        <a aria-label="Green Super Logo" class="nav__brand" href="index.jsp"><img src="images/main/logo/logo.png" alt="" /></a>
        <svg class="icon icon--white nav__toggler">
            <use href="./images/icons/sprite.svg#list"></use>
        </svg>
        <ul class="list nav__list collapsible__content">
            <li class="nav__item">
                <a target="_blank" href="index.jsp">Home</a>
            </li>
            <li class="nav__item">
                <a target="_blank" href="#categories">Categories</a>
            </li>
            <li class="nav__item">
                <a target="_blank" href="cart.jsp">Cart</a>
            </li>
            <li class="nav__item">
                <a target="_blank" href="#">About Us</a>
            </li>
            <li class="search">
                <input class="input input--dark" type="text" placeholder="Search Products" />
                <button class="input input-search input--dark">Search</button>
            </li>
            <li class="nav__item">
                <%
                    if(session.getAttribute("auth") == null) {
                %>
                <a target="_blank" href="login.jsp">Login | Register</a>
                <%
                    } else {
                        String auth = (String) session.getAttribute("auth");
                %>
                    <span><%=auth%><span>
                    <a href="logout">Logout</a>
                <%
                    }
                %>
            </li>
        </ul>
    </nav>
</header>