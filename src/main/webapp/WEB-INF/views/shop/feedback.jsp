<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>
<% boolean feedbackLoggedIn = session.getAttribute("userCredentials") != null; %>

<main class="container-page flex flex-1 items-center py-10">
    <div class="card mx-auto w-full max-w-xl p-6 sm:p-8">
        <span class="eyebrow"><i class="fa fa-comment-dots"></i> Feedback</span>
        <h1 class="mt-2 text-2xl font-bold sm:text-3xl">How did we do?</h1>
        <p class="mt-1 text-sm text-slate-500">Tell us about your order. You'll find the Bill ID in your receipt email.</p>

        <%-- Filled by feedbackSubmit() in js/main.js --%>
        <div id="feedback-alert" class="mt-5 empty:hidden" role="status" aria-live="polite"><% if (!feedbackLoggedIn) { %><div class="alert alert-info"><i class="fa fa-circle-info"></i><p>Please <a href="./login.jsp">log in</a> to share feedback about your order.</p></div><% } %></div>

        <form id="feedback-form" onsubmit="feedbackSubmit(event)" class="mt-5 space-y-5" novalidate>
            <fieldset class="space-y-5 disabled:opacity-60" <%= feedbackLoggedIn ? "" : "disabled" %>>
                <div>
                    <label for="billId" class="label">Bill ID</label>
                    <input type="text" id="billId" name="billId" class="input" placeholder="e.g. 1024"
                           inputmode="numeric" autocomplete="off" aria-describedby="error-billId">
                    <p id="error-billId" class="form-error mt-1.5"></p>
                </div>
                <div>
                    <div class="flex items-baseline justify-between">
                        <label for="feedback" class="label">Your feedback</label>
                        <span id="feedback-count" class="text-xs text-slate-400 tabular-nums">0 / 1000</span>
                    </div>
                    <textarea id="feedback" name="feedback" rows="5" class="input" maxlength="1000"
                              placeholder="What did you like? What could we do better?" aria-describedby="error-feedback"></textarea>
                    <p id="error-feedback" class="form-error mt-1.5"></p>
                </div>
                <button type="submit" id="feedback-submit" class="btn btn-primary w-full rounded-full">
                    <i class="fa fa-paper-plane"></i> <span>Send Feedback</span>
                </button>
            </fieldset>
        </form>
    </div>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
