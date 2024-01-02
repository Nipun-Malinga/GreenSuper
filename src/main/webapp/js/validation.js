function validateRegistration(event) {
    event.preventDefault();

    let firstName = document.getElementById('first_name').value;
    let lastName = document.getElementById('last_name').value;
    let email = document.getElementById('email').value;
    let password = document.getElementById('password').value;
    let confirm_password = document.getElementById('confirm_password').value;
    let phoneNumber = document.getElementById('phone_number').value;
    let homeNumber = document.getElementById('home_number').value;
    let streetName = document.getElementById('street_name').value;
    let city = document.getElementById('city').value;

    let allFields = document.querySelectorAll('input');

    let valid = false;
    allFields.forEach(function (input) {
        if(input.value.trim() === '') {
            input.style.border = "1px solid red";
            valid = false;
        } else {
            input.style.border = "1px solid green";
            valid = true;
        }
    })

    if(valid) {
        $.ajax({
            url: 'register',
            method: 'post',
            data: {
                firstName : firstName,
                lastName : lastName,
                email : email,
                password : password,
                phoneNumber : phoneNumber,
                homeNumber : homeNumber,
                streetName : streetName,
                city : city
            },
            success: function (response) {
                if(response === 'userRegistrationFailed') {
                    console.log("ola")
                } else if (response === 'emptyParameters') {
                    allFields.forEach(function (input) {
                        if(input.value.trim() === '') {
                            input.style.border = "1px solid red";
                            valid = false;
                        }
                    })
                } else {
                    window.location.href = response;
                }
            }
        })
    }
}

function validateAdminLogin(event) {
    event.preventDefault();
    let adminEmail = document.getElementById('adminEmail').value;
    let adminPassword = document.getElementById('adminPassword').value;

    let allFields = document.querySelectorAll('input');
    let valid;

    allFields.forEach(function (input) {
        if(input.value.trim() === '') {
            if(input.value.trim() === '') {
                input.style.border = "1px solid red";
                valid = false;
            } else {
                input.style.border = "1px solid green";
                valid = true;
            }
        }
    })

    $.ajax({
        url: 'adminLogin',
        method: 'post',
        data: {
            adminEmail : adminEmail,
            adminPassword : adminPassword,
        },
        success : function (response) {
            if(response === 'invalidAdminLogin') {
                document.getElementById('error').innerText = 'Invalid email or password';
            } else if(response === 'emptyParameters') {
                allFields.forEach(function (input) {
                    if(input.value.trim() === '') {
                        input.style.border = "1px solid red";
                        valid = false;
                    }
                })
            } else {
                window.location.href = response;
            }
        }
    })
}

function validateUserLogin(event) {
    event.preventDefault();
    let userEmail= document.getElementById('userEmail').value;
    let password = document.getElementById('userPassword').value;

    let allFields = document.querySelectorAll('input');

    let valid;
    allFields.forEach(function (input) {
        if(input.value.trim() === '') {
            if(input.value.trim() === '') {
                input.style.border = "1px solid red";
                valid = false;
            } else {
                input.style.border = "1px solid green";
                valid = true;
            }
        }
    })

    $.ajax({
        url: 'login',
        method: 'post',
        data: {
            userEmail : userEmail,
            password : password,
        },
        success : function (response) {
            console.log(response)
            if(response === 'loginFailed') {
                document.getElementById('error').innerText = 'Invalid email or password';
            } else if(response === 'emptyParameters') {
                allFields.forEach(function (input) {
                    if(input.value.trim() === '') {
                        input.style.border = "1px solid red";
                        valid = false;
                    }
                })
            } else {
                window.location.href = response;
            }
        }
    })
}

