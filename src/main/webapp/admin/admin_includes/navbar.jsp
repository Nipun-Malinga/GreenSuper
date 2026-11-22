<%-- Sidebar. js/script.js toggles the "close" class on this <nav>. --%>
<nav class="sidebar">
    <a href="admin.jsp" class="logo-name flex items-center gap-3 px-2">
        <img src="images/main/logo/logo.png" alt="Green Super Logo" class="size-10 shrink-0 object-contain">
        <span class="logo_name text-lg font-bold text-brand-800">Green Super</span>
    </a>

    <div class="menu-items mt-8 flex flex-1 flex-col justify-between">
        <ul class="nav-links space-y-1">
            <li><a href="admin.jsp" class="admin-link" title="Dashboard"><i class="uil uil-estate"></i><span class="link-name">Dashboard</span></a></li>
            <li><a href="./admin_categories.jsp" class="admin-link" title="Categories"><i class="uil uil-box"></i><span class="link-name">Categories</span></a></li>
            <li><a href="./admin_products.jsp" class="admin-link" title="Products"><i class="uil uil-pizza-slice"></i><span class="link-name">Products</span></a></li>
            <li><a href="./admin_customers.jsp" class="admin-link" title="Customers"><i class="uil uil-user"></i><span class="link-name">Customers</span></a></li>
            <li><a href="./admin_orders.jsp" class="admin-link" title="Orders"><i class="uil uil-transaction"></i><span class="link-name">Orders</span></a></li>
        </ul>

        <ul class="logout-mode border-t border-slate-200 pt-4">
            <li><a href="adminLogout" class="admin-link hover:bg-red-50 hover:text-red-600" title="Logout"><i class="uil uil-signout"></i><span class="link-name">Logout</span></a></li>
        </ul>
    </div>
</nav>
