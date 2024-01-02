<%@ include file="includes/login_register_header.jsp"%>

<div class="container" id="container ">
    <div class="form-container ">
        <form onsubmit="validateUserLogin(event)">
            <h1>Log In</h1>
            <input type="email" placeholder="Email" id="userEmail" />
            <input type="password" placeholder="Password" id="userPassword" />
            <button type="submit">Sign In</button>
            <p class="error" id="error"></p>
            <p class="sign-up-mobile">Don't have an account? <a class="link" href="">Register</a> </p>
        </form>
    </div>
    <div class="toggle-container login-page">
        <div class="toggle">
            <div class="toggle-panel toggle-right">
                <h1>Hello, Friend!</h1>
                <p>New to Green Super?</p>
                <a href="./registration.jsp"><button class="hidden" id="login">Sign Up</button></a>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/login_register_footer.jsp"%>
