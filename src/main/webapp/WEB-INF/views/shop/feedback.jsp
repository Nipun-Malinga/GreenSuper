<%@ include file="/WEB-INF/views/includes/header.jsp"%>
<%@ include file="/WEB-INF/views/includes/navbar.jsp"%>

<main class="container-page py-12">
    <div class="card mx-auto max-w-xl p-8">
        <form onsubmit="feedbackSubmit(event)" class="space-y-5">
            <div>
                <h1 class="text-2xl font-bold">Give Us Your Feedback</h1>
                <p class="mt-1 text-sm text-slate-500">Tell us how we did. You'll find the Bill ID in your receipt email.</p>
            </div>
            <div>
                <label for="billId" class="label">Bill ID</label>
                <input type="text" id="billId" class="input" placeholder="Enter your Bill ID">
                <p id="error-billId" class="mt-1 text-sm"></p>
            </div>
            <div>
                <label for="feedback" class="label">Feedback</label>
                <textarea name="txtmsg" id="feedback" rows="5" class="input" placeholder="Your Feedback"></textarea>
                <p id="error_feedback" class="mt-1 text-sm"></p>
            </div>
            <h5 id="response"></h5>
            <p id="massage" class="text-sm font-medium"></p>
            <div>
                <% if(session.getAttribute("auth") != null) {%>
                    <input type="submit" name="btnSubmit" class="btn btn-primary w-full" value="Send Feedback">
                <% } else {%>
                <input type="submit" name="btnSubmit" onclick="popup.showModal()" class="btn btn-primary w-full" value="Send Feedback">
                <dialog class="modal" id="popup">
                    <h2 class="text-xl font-bold">Oops!</h2>
                    <p class="mt-2">Looks like you are not logged in, Please log in to continue with the purchase. Click <a class="font-semibold text-brand-700 underline" href="./login.jsp">here</a> to log in.</p>
                    <div class="mt-6 flex justify-end">
                        <button type="button" class="btn btn-dark" onclick="popup.close()">Close</button>
                    </div>
                </dialog>
                <% } %>
            </div>
        </form>
    </div>
</main>
<%@ include file="/WEB-INF/views/includes/footer.jsp"%>
