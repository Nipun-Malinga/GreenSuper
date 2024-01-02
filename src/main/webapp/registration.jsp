<%@ include file="includes/login_register_header.jsp"%>

<div class="container" id="container">
    <div class="form-container sign-up">
        <form onsubmit="validateRegistration(event)"  method="post">
            <h1>Create Account</h1>
            <div class="name-container">
                <input type="text" id="first_name" placeholder="First Name" name="firstName">
                <input type="text" id="last_name" placeholder="Last Name" name="lastName">
            </div>
            <input type="email" id="email" placeholder="Email" name="email">
            <input type="password" id="password" placeholder="Password" name="password">
            <input type="password" id="confirm_password" placeholder="Re-enter Password">
            <input type="text" id="phone_number" placeholder="Phone Number" name="phoneNumber">
            <div class="address-container">
                <input type="text" id="home_number" placeholder="House Number" name="homeNumber">
                <input type="text" id="street_name" placeholder="Street Name" name="streetName">
            </div>
            <input type="text" id="city" placeholder="City" name="city">
            <button type="submit">Sign Up</button>
            <p id="error"></p>
        </form>
    </div>
    <div class="toggle-container register-page">
        <div class="toggle">
            <div class="toggle-panel toggle-right">
                <h1>Welcome!</h1>
                <p>You got an account already?</p>
                <a href="./login.jsp"><button class="hidden">Sign In</button></a>
            </div>
        </div>
    </div>
</div>

<%@ include file="includes/login_register_footer.jsp"%>
