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

// ---------- Feedback (feedback.jsp -> FeedbackServlet) ----------

const FEEDBACK_MAX_LENGTH = 1000;

// Result codes from FeedbackServlet. `field` puts the message under that input; otherwise it shows as a banner.
const FEEDBACK_MESSAGES = {
    success:          { type: 'success', icon: 'fa-circle-check', text: 'Thank you! Your feedback has been received. It really helps us improve.' },
    alreadySubmitted: { type: 'info', icon: 'fa-circle-info', text: "You've already shared feedback for this order. Thanks again!" },
    notLoggedIn:      { type: 'warning', icon: 'fa-lock', html: 'Your session has expired. Please <a href="./login.jsp">log in again</a> to send feedback.' },
    serverError:      { type: 'error', icon: 'fa-triangle-exclamation', text: 'Something went wrong on our side and your feedback was not saved. Please try again in a moment.' },
    networkError:     { type: 'error', icon: 'fa-wifi', text: "We couldn't reach the server. Check your internet connection and try again." },
    billIdEmpty:      { field: 'billId', text: 'Please enter the Bill ID from your receipt email.' },
    billIdInvalid:    { field: 'billId', text: 'A Bill ID contains numbers only, for example 1024.' },
    billNotFound:     { field: 'billId', text: "We couldn't find this bill on your account. Please check the Bill ID in your receipt email." },
    feedbackEmpty:    { field: 'feedback', text: 'Please tell us a little about your experience.' },
    feedbackTooLong:  { field: 'feedback', text: 'Please keep your feedback under ' + FEEDBACK_MAX_LENGTH.toLocaleString() + ' characters.' },
};

function setFieldError(fieldId, message) {
    const input = document.getElementById(fieldId);
    const error = document.getElementById('error-' + fieldId);
    input.classList.toggle('is-invalid', Boolean(message));
    input.setAttribute('aria-invalid', message ? 'true' : 'false');
    error.textContent = message || '';
}

function showFeedbackAlert(message) {
    const box = document.getElementById('feedback-alert');
    box.innerHTML = '';
    if (!message) return;

    const alert = document.createElement('div');
    alert.className = 'alert alert-' + message.type;
    const icon = document.createElement('i');
    icon.className = 'fa ' + message.icon;
    const text = document.createElement('p');
    if (message.html) text.innerHTML = message.html; else text.textContent = message.text;
    alert.append(icon, text);
    box.append(alert);
}

function showFeedbackResult(code) {
    const message = FEEDBACK_MESSAGES[code] || FEEDBACK_MESSAGES.serverError;
    if (message.field) {
        setFieldError(message.field, message.text);
        document.getElementById(message.field).focus();
    } else {
        showFeedbackAlert(message);
    }
}

// Same checks as the servlet, so most mistakes are caught without a round trip.
function validateFeedback(billId, feedback) {
    if (billId === '') return 'billIdEmpty';
    if (!/^[0-9]+$/.test(billId) || Number(billId) <= 0) return 'billIdInvalid';
    if (feedback === '') return 'feedbackEmpty';
    if (feedback.length > FEEDBACK_MAX_LENGTH) return 'feedbackTooLong';
    return null;
}

function feedbackSubmit(event) {
    event.preventDefault();
    const form = document.getElementById('feedback-form');
    const button = document.getElementById('feedback-submit');
    const billId = document.getElementById('billId').value.trim();
    const feedback = document.getElementById('feedback').value.trim();

    setFieldError('billId', '');
    setFieldError('feedback', '');
    showFeedbackAlert(null);

    const problem = validateFeedback(billId, feedback);
    if (problem) {
        showFeedbackResult(problem);
        return;
    }

    button.disabled = true;
    button.querySelector('span').textContent = 'Sending...';

    $.ajax({ url: 'feedback', method: 'POST', data: { billId: billId, feedback: feedback }, dataType: 'text' })
        .done(function (code) {
            showFeedbackResult(code.trim());
            if (code.trim() === 'success') {
                form.reset();
                updateFeedbackCount();
            }
        })
        .fail(function (xhr) {
            // Error statuses still carry a result code in the body.
            const code = (xhr.responseText || '').trim();
            showFeedbackResult(FEEDBACK_MESSAGES[code] ? code : (xhr.status === 0 ? 'networkError' : 'serverError'));
        })
        .always(function () {
            button.disabled = false;
            button.querySelector('span').textContent = 'Send Feedback';
        });
}

function updateFeedbackCount() {
    const textarea = document.getElementById('feedback');
    const counter = document.getElementById('feedback-count');
    if (!textarea || !counter) return;
    counter.textContent = textarea.value.length + ' / ' + FEEDBACK_MAX_LENGTH;
}

const feedbackTextarea = document.getElementById('feedback');
if (feedbackTextarea) {
    feedbackTextarea.addEventListener('input', function () {
        updateFeedbackCount();
        setFieldError('feedback', '');
    });
    document.getElementById('billId').addEventListener('input', function () {
        setFieldError('billId', '');
    });
}
