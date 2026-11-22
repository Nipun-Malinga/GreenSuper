<%@ include file="/WEB-INF/views/includes/auth_header.jsp"%>

<div class="card grid w-full max-w-5xl overflow-hidden md:grid-cols-5" id="container">
    <div class="p-8 sm:p-10 md:col-span-3">
        <form onsubmit="validateRegistration(event)" method="post" class="space-y-4">
            <h1 class="text-2xl font-bold">Create Account</h1>
            <div class="grid gap-4 sm:grid-cols-2">
                <div><label for="first_name" class="label">First Name</label><input type="text" id="first_name" class="input" placeholder="First Name" name="firstName" autocomplete="given-name"></div>
                <div><label for="last_name" class="label">Last Name</label><input type="text" id="last_name" class="input" placeholder="Last Name" name="lastName" autocomplete="family-name"></div>
            </div>
            <div><label for="email" class="label">Email</label><input type="email" id="email" class="input" placeholder="you@example.com" name="email" autocomplete="email"></div>
            <div class="grid gap-4 sm:grid-cols-2">
                <div><label for="password" class="label">Password</label><input type="password" id="password" class="input" placeholder="Password" name="password" autocomplete="new-password"></div>
                <div><label for="confirm_password" class="label">Confirm Password</label><input type="password" id="confirm_password" class="input" placeholder="Re-enter Password" autocomplete="new-password"></div>
            </div>
            <div><label for="phone_number" class="label">Phone Number</label><input type="text" id="phone_number" class="input" placeholder="Phone Number" name="phoneNumber" autocomplete="tel"></div>
            <div class="grid gap-4 sm:grid-cols-3">
                <div><label for="home_number" class="label">House No.</label><input type="text" id="home_number" class="input" placeholder="House Number" name="homeNumber"></div>
                <div><label for="street_name" class="label">Street</label><input type="text" id="street_name" class="input" placeholder="Street Name" name="streetName"></div>
                <div><label for="city" class="label">City</label><input type="text" id="city" class="input" placeholder="City" name="city"></div>
            </div>
            <p class="form-error" id="error"></p>
            <button type="submit" class="btn btn-primary w-full">Sign Up</button>
            <p class="text-center text-sm text-slate-500 md:hidden">Already have an account? <a class="font-semibold text-brand-700 hover:underline" href="./login.jsp">Sign In</a></p>
        </form>
    </div>
    <div class="hidden flex-col items-center justify-center gap-4 bg-gradient-to-br from-brand-600 to-brand-800 p-10 text-center text-white md:col-span-2 md:flex">
        <h2 class="text-3xl font-bold text-white">Welcome!</h2>
        <p class="text-brand-100">You got an account already?</p>
        <a href="./login.jsp" class="btn mt-2 border border-white/70 px-8 text-white hover:bg-white hover:text-brand-700">Sign In</a>
    </div>
</div>

<%@ include file="/WEB-INF/views/includes/auth_footer.jsp"%>
