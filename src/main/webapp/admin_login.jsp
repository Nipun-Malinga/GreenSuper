<%@ include file="includes/login_register_header.jsp"%>

<div class="card grid w-full max-w-4xl overflow-hidden md:grid-cols-2" id="container">
    <div class="hidden flex-col items-center justify-center gap-3 bg-gradient-to-br from-slate-800 to-slate-950 p-12 text-center text-white md:flex">
        <img src="./images/main/logo/logo.png" alt="" class="h-14 w-auto">
        <h2 class="text-3xl font-bold text-white">Admin Login</h2>
        <p class="text-slate-300">Green Super Management</p>
    </div>
    <div class="p-8 sm:p-12">
        <form onsubmit="validateAdminLogin(event)" class="space-y-4">
            <h1 class="text-2xl font-bold">Log In</h1>
            <p class="text-sm text-slate-500 md:hidden">Green Super Management</p>
            <div>
                <label for="adminEmail" class="label">Email</label>
                <input type="email" id="adminEmail" class="input" placeholder="admin@example.com" name="adminEmail" autocomplete="username">
            </div>
            <div>
                <label for="adminPassword" class="label">Password</label>
                <input type="password" id="adminPassword" class="input" placeholder="Password" name="adminPassword" autocomplete="current-password">
            </div>
            <p class="form-error" id="error"></p>
            <button type="submit" class="btn btn-dark w-full">Sign In</button>
        </form>
    </div>
</div>

<%@ include file="includes/login_register_footer.jsp"%>
