<%@ include file="includes/login_register_header.jsp"%>

<div class="container" id="container">
    <div class="form-container sign-up">
    </div>
    <div class="form-container sign-up">
        <form onsubmit="validateAdminLogin(event)">
            <h1>Log In</h1>
            <label for="adminEmail"></label>
            <input type="email" id="adminEmail" placeholder="Email" name="adminEmail">
            <label for="adminPassword"></label>
            <input type="password" id="adminPassword" placeholder="Password" name="adminPassword">
            <p class="error" id="error"></p>
            <button type="submit">Sign In</button>
        </form>
    </div>
    <div class="toggle-container admin-login-page">
        <div class="toggle">
            <div class="toggle-panel toggle-right">
                <h1>Admin Login</h1>
                <p>Green Super Management</p>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/login_register_footer.jsp"%>