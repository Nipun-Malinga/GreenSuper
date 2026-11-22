<header class="sticky top-0 z-30 border-b border-slate-200 bg-white/90 backdrop-blur">
    <nav class="container-page flex flex-wrap items-center justify-between gap-y-3 py-3" aria-label="Main">
        <a href="index.jsp" class="flex items-center">
            <img id="logo" class="h-11 w-auto" src="./images/main/logo/logo.png" alt="Green Super">
        </a>

        <%-- Mobile menu: CSS-only toggle driven by this checkbox --%>
        <input type="checkbox" id="chk1" class="peer hidden">
        <label for="chk1" class="cursor-pointer rounded-lg p-2 text-xl text-slate-700 hover:bg-slate-100 lg:hidden" aria-label="Toggle menu">
            <i class="fa fa-bars"></i>
        </label>

        <ul class="hidden w-full flex-col gap-1 text-sm font-medium peer-checked:flex lg:flex lg:w-auto lg:flex-row lg:items-center lg:gap-1">
            <li><a href="index.jsp" class="block rounded-lg px-3 py-2 text-slate-700 hover:bg-brand-50 hover:text-brand-700">Home</a></li>
            <li><a href="index.jsp#categories" class="block rounded-lg px-3 py-2 text-slate-700 hover:bg-brand-50 hover:text-brand-700">Shop</a></li>
            <li><a href="cart.jsp" class="flex items-center gap-2 rounded-lg px-3 py-2 text-slate-700 hover:bg-brand-50 hover:text-brand-700"><i class="fa fa-cart-shopping"></i> Cart</a></li>
            <li><a href="about.jsp" class="block rounded-lg px-3 py-2 text-slate-700 hover:bg-brand-50 hover:text-brand-700">About Us</a></li>
            <li><a href="contact.jsp" class="block rounded-lg px-3 py-2 text-slate-700 hover:bg-brand-50 hover:text-brand-700">Contact</a></li>
            <li class="lg:ml-2">
                <% if(session.getAttribute("auth") == null) {%>
                <a href="login.jsp" class="btn btn-primary w-full lg:w-auto">Login / Register</a>
                <% }else {%>
                <a href="logout" class="btn btn-outline w-full lg:w-auto"><i class="fa fa-user"></i> <%=session.getAttribute("auth")%> (Log Out)</a>
                <% }%>
            </li>
        </ul>
    </nav>
</header>
