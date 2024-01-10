<%@ include file="includes/header.jsp"%>
<%@ include file="includes/navbar.jsp"%>

<div class="container feedback-form">
    <form onsubmit="feedbackSubmit(event)">
    <h2>Give Us Your Feedback</h2>
        <div class="row">
            <div class="form-group col">
                <input type="text" id="billId" class="form-control" placeholder="Enter your Bill ID">
                <p id="error-billId"></p>
            </div>
            <div class="form-group col-md-12">
                <textarea name="txtmsg" id="feedback" class="form-control" placeholder="Your Feedback"></textarea>
                <p id="error_feedback"></p>
                <br>
            </div>
            <div class="form-group d-flex justify-content-center col">
                <h5 id="response"></h5>
            </div>
            <div class="form-group d-flex justify-content-center col-md-12">
                <% if(session.getAttribute("auth") != null) {%>
                    <input type="submit" name="btnSubmit" class="btnfeedback" value="Send Feedback">
                <% } else {%>
                <input type="submit" name="btnSubmit" onclick="popup.showModal()" class="btnfeedback" value="Send Feedback">
                <dialog class="popup" id="popup">
                    <h2>Oops!</h2>
                    <p>Looks like you are not logged in, Please log in to continue with the purchase. Click <a href="./login.jsp">here</a> to log in.</p>
                    <button type="button" class="btn btn-success" onclick="popup.close()"  style="background-color: #050505">Close</button>
                </dialog>
                <% } %>
            </div>
        </div>
    </form>
</div>
<%@ include file="includes/footer.jsp"%>




