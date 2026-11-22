// These elements only exist on some pages, so guard each lookup.
const promoCart = document.getElementById('promo_cart');
if (promoCart) {
    promoCart.addEventListener('click', () => {
        window.location.href = './cart.jsp';
    })
}

const promoContact = document.getElementById('promo_contact');
if (promoContact) {
    promoContact.addEventListener('click', () => {
        window.location.href = './contact.jsp';
    })
}

const logo = document.getElementById('logo');
if (logo) {
    logo.addEventListener('click', ()=> {
        window.location.href = './index.jsp';
    })
}


function AddToCart(productId) {
    $.ajax({
        method: 'GET',
        url: 'cart',
        data: {
            productId: productId
        },
        success: function (response) {
            if(response === "productAdded") {
                document.getElementById("product" + productId).innerHTML = "<span> Product Added </span>";

            } else if (response === "productExists") {
                document.getElementById("product" + productId).innerHTML = "<span> Product Exist </span>";
            }
        }
    })
}

function feedbackSubmit(event) {
    event.preventDefault();
    let billId = document.getElementById('billId').value;
    let feedback = document.getElementById('feedback').value;

    let valid = true;
    let fields = document.querySelectorAll('input, textarea');
    fields.forEach(function (input) {
        if(input.value.trim() === '') {
            document.getElementById('error-billId').style.color = '#dc2626';
            document.getElementById('error-billId').innerText = 'Bill ID cannot be empty';
            document.getElementById('error_feedback').innerText = 'Feedback cannot be empty';
            valid = false;
        } else {
            valid = true;
        }
    })

    console.log(billId, feedback)

    if(valid) {
        $.ajax({
            url: 'feedback',
            method: 'post',
            data: {
                billId : billId,
                feedback : feedback,
            },
            success: function (response) {
                if(response === 'invalidBillId') {
                    document.getElementById('error-billId').innerText = 'Invalid Bill ID';
                    document.getElementById('error-billId').style.color = '#dc2626';
                } else if (response === 'FeedbackFailed') {
                    document.getElementById('error_feedback').innerText = 'Feedback Submission Failed!';
                    document.getElementById('error_feedback').style.color = '#dc2626';
                } else if (response === 'FeedbackSuccess') {
                    document.getElementById('massage').innerText = 'Your feedback successfully received. Thank You For Your Feedback. ';
                    document.getElementById('massage').style.color = '#0d7b27';
                } else {
                    document.getElementById('error_feedback').innerText = 'Feedback Submission Failed!';
                    document.getElementById('error_feedback').style.color = '#dc2626';
                }
            }
        })
    }
}