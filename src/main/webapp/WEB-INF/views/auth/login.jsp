
<%@ include file="/WEB-INF/views/includes/auth_header.jsp"%>

<div class="card grid w-full max-w-4xl overflow-hidden md:grid-cols-2" id="container">
    <div class="p-8 sm:p-12">
        <a href="index.jsp" class="inline-flex items-center">
            <img src="./images/main/logo/logo.png" alt="Green Super" class="h-11 w-auto">
        </a>
        <form onsubmit="validateUserLogin(event)" class="mt-8 space-y-4">
            <h1 class="text-2xl font-bold">Log In</h1>
            <div>
                <label for="userEmail" class="label">Email</label>
                <input type="email" placeholder="you@example.com" id="userEmail" class="input" autocomplete="email" />
            </div>
            <div>
                <label for="userPassword" class="label">Password</label>
                <input type="password" placeholder="Password" id="userPassword" class="input" autocomplete="current-password" />
            </div>
            <p class="form-error" id="error"></p>
            <button type="submit" class="btn btn-primary w-full">Sign In</button>
            <p class="text-center text-sm text-slate-500 md:hidden">Don't have an account? <a class="font-semibold text-brand-700 hover:underline" href="./registration.jsp">Register</a></p>
        </form>
    </div>
    <div class="hidden flex-col items-center justify-center gap-4 bg-gradient-to-br from-brand-600 to-brand-800 p-12 text-center text-white md:flex">
        <h2 class="text-3xl font-bold text-white">Hello, Friend!</h2>
        <p class="text-brand-100">New to Green Super?</p>
        <a href="./registration.jsp" id="login" class="btn mt-2 border border-white/70 px-8 text-white hover:bg-white hover:text-brand-700">Sign Up</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/auth_footer.jsp"%>
