<%
    // Highlight the link for the current page. Product pages belong to "Categories".
    String navPath = request.getServletPath();
    if ("/product.jsp".equals(navPath)) navPath = "/categories.jsp";
    String[][] navLinks = {
            {"index.jsp", "Home"},
            {"categories.jsp", "Categories"},
            {"about.jsp", "About Us"},
            {"contact.jsp", "Contact"},
            {"feedback.jsp", "Feedback"},
    };
    Object navUser = session.getAttribute("auth");
    Object navCart = session.getAttribute("cart_item");
    int navCartCount = navCart instanceof java.util.List ? ((java.util.List<?>) navCart).size() : 0;
    String navCartCurrent = "/cart.jsp".equals(navPath) ? "aria-current=\"page\"" : "";
%>
<header class="sticky top-0 z-30 border-b border-slate-200/80 bg-white/85 backdrop-blur-md">
    <nav class="container-page flex h-16 items-center gap-4 lg:h-[4.5rem]" aria-label="Main">
        <a href="index.jsp" class="flex shrink-0 items-center" aria-label="Green Super home">
            <img id="logo" class="h-10 w-auto lg:h-11" src="./images/main/logo/logo.png" alt="Green Super">
        </a>

        <%-- Desktop links --%>
        <ul class="mx-auto hidden items-center gap-1 rounded-full bg-slate-50 p-1 ring-1 ring-slate-200/70 lg:flex">
            <% for (String[] link : navLinks) { %>
            <li><a href="<%= link[0] %>" class="nav-link" <%= ("/" + link[0]).equals(navPath) ? "aria-current=\"page\"" : "" %>><%= link[1] %></a></li>
            <% } %>
        </ul>

        <div class="ml-auto flex items-center gap-2 lg:ml-0">
            <a href="cart.jsp" class="icon-btn" aria-label="Cart (<%= navCartCount %> items)" <%= navCartCurrent %>>
                <i class="fa fa-cart-shopping text-lg"></i>
                <% if (navCartCount > 0) { %>
                <span class="absolute -top-0.5 -right-0.5 grid h-5 min-w-5 place-items-center rounded-full bg-brand-600 px-1 text-[0.65rem] leading-none font-bold text-white ring-2 ring-white"><%= navCartCount %></span>
                <% } %>
            </a>

            <% if (navUser == null) { %>
            <a href="login.jsp" class="btn btn-primary hidden rounded-full px-5 sm:inline-flex">Login / Register</a>
            <% } else { %>
            <div class="hidden items-center gap-1 rounded-full bg-slate-50 py-1 pr-1 pl-1 ring-1 ring-slate-200/70 sm:flex">
                <span class="grid size-8 place-items-center rounded-full bg-brand-600 text-sm font-semibold text-white uppercase" aria-hidden="true"><%= String.valueOf(navUser).isEmpty() ? "?" : String.valueOf(navUser).substring(0, 1) %></span>
                <span class="max-w-32 truncate px-2 text-sm font-medium text-slate-800"><%= navUser %></span>
                <a href="logout" class="icon-btn size-8 text-slate-500 hover:text-red-600" title="Log out" aria-label="Log out"><i class="fa fa-arrow-right-from-bracket"></i></a>
            </div>
            <% } %>

            <%-- Mobile menu: CSS-only toggle driven by this checkbox --%>
            <input type="checkbox" id="chk1" class="peer hidden">
            <label for="chk1" class="icon-btn lg:hidden" aria-label="Toggle menu">
                <i class="fa fa-bars text-lg"></i>
            </label>

            <div class="absolute inset-x-0 top-full hidden border-b border-slate-200 bg-white shadow-lg peer-checked:block lg:hidden">
                <ul class="container-page flex flex-col gap-1 py-3">
                    <% for (String[] link : navLinks) { %>
                    <li><a href="<%= link[0] %>" class="nav-link rounded-lg" <%= ("/" + link[0]).equals(navPath) ? "aria-current=\"page\"" : "" %>><%= link[1] %></a></li>
                    <% } %>
                    <li class="mt-2 border-t border-slate-100 pt-3">
                        <% if (navUser == null) { %>
                        <a href="login.jsp" class="btn btn-primary w-full">Login / Register</a>
                        <% } else { %>
                        <a href="logout" class="btn btn-outline w-full"><i class="fa fa-arrow-right-from-bracket"></i> Log out (<%= navUser %>)</a>
                        <% } %>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
</header>
