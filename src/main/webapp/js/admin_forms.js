/*
 * Submits the admin product/category forms in the background so that failures
 * show a proper page instead of the servlet's raw text response.
 *
 * The servlets reply with plain-text tokens (e.g. "productAddedSuccessfully",
 * "failedToAddProduct"); delete success redirects to the list page.
 *
 * Opt a form in with:
 *   data-async-form
 *   data-success-url="admin_products.jsp"   where to go on success
 *   data-failure-event="failedToAddProduct" token used when the server errors out
 */
(function () {
    const SUCCESS_TOKENS = [
        'productAddedSuccessfully', 'productUpdated', 'productDeleted',
        'categoryAddedSuccessfully', 'categoryUpdated', 'categoryDeleted'
    ];
    const FAILURE_TOKENS = [
        'failedToAddProduct', 'productFailedToUpdate', 'failedToDeleteProduct',
        'failedToAddCategory', 'failedToUpdateCategory', 'failedToDeleteCategory',
        'productAlreadyExists', 'categoryAlreadyExists'
    ];

    // Keeps the sidebar on screen when js/admin_nav.js is loaded; falls back to a full load.
    function go(url) {
        if (window.adminNavigate) return window.adminNavigate(url);
        window.location.href = url;
    }

    function failurePage(event, serverError) {
        let url = 'admin_failed.jsp?event=' + encodeURIComponent(event);
        if (serverError) url += '&error=server';
        return url;
    }

    function setBusy(form, busy) {
        form.querySelectorAll('button, input[type="submit"]').forEach(function (btn) {
            btn.disabled = busy;
        });
        const submit = form.querySelector('button[type="submit"]');
        if (submit) {
            if (busy) {
                submit.dataset.label = submit.innerHTML;
                submit.innerHTML = '<i class="uil uil-spinner animate-spin"></i> Please wait...';
            } else if (submit.dataset.label) {
                submit.innerHTML = submit.dataset.label;
            }
        }
    }

    async function submitForm(event) {
        event.preventDefault();
        const form = event.currentTarget;

        if (form.dataset.confirm && !window.confirm(form.dataset.confirm)) {
            return;
        }

        const successUrl = form.dataset.successUrl;
        const failureEvent = form.dataset.failureEvent;
        const data = new FormData(form);
        const isMultipart = form.enctype === 'multipart/form-data';

        setBusy(form, true);
        try {
            const res = await fetch(form.action, {
                method: 'POST',
                credentials: 'same-origin',
                body: isMultipart ? data : new URLSearchParams(data)
            });

            // Session expired: the servlet redirects to the login page.
            if (res.redirected && res.url.indexOf('admin_login.jsp') !== -1) {
                window.location.href = 'admin_login.jsp';
                return;
            }

            if (!res.ok) {
                await go(failurePage(failureEvent, true));
                return;
            }

            // Delete success writes a token and then redirects to the list page.
            if (res.redirected) {
                await go(successUrl);
                return;
            }

            const token = (await res.text()).trim();
            if (SUCCESS_TOKENS.indexOf(token) !== -1) {
                await go(successUrl);
            } else if (FAILURE_TOKENS.indexOf(token) !== -1) {
                await go(failurePage(token, false));
            } else {
                await go(failurePage(failureEvent, true));
            }
        } catch (err) {
            // Network failure or server unreachable.
            console.error(err);
            await go(failurePage(failureEvent, true));
        } finally {
            setBusy(form, false);
        }
    }

    // Exposed so js/admin_nav.js can wire up forms in content it swaps in.
    window.initAdminForms = function (root) {
        (root || document).querySelectorAll('form[data-async-form]:not([data-async-bound])').forEach(function (form) {
            form.setAttribute('data-async-bound', '');
            form.addEventListener('submit', submitForm);
        });
    };
    window.initAdminForms(document);

    // Re-enable buttons when the user comes back with "Try again" (bfcache restore).
    window.addEventListener('pageshow', function () {
        document.querySelectorAll('form[data-async-form]').forEach(function (form) {
            setBusy(form, false);
        });
    });
})();
