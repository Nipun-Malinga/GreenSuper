package org.example.greensuper.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.Bill_InfoDao;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Customer;
import org.example.greensuper.models.Feedback;

import java.io.IOException;

/**
 * Receives feedback from feedback.jsp (AJAX, see feedbackSubmit in js/main.js).
 * Responds with a plain-text result code that the page maps to a message; it never redirects,
 * because the AJAX call would follow the redirect and get a page instead of the code.
 */
@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {
    static final int MAX_FEEDBACK_LENGTH = 1000;

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession(false);
        Customer customer = session == null ? null : (Customer) session.getAttribute("userCredentials");
        if (customer == null) {
            respond(resp, HttpServletResponse.SC_UNAUTHORIZED, "notLoggedIn");
            return;
        }

        String billIdParam = trim(req.getParameter("billId"));
        String feedbackText = trim(req.getParameter("feedback"));

        if (billIdParam.isEmpty()) {
            respond(resp, HttpServletResponse.SC_BAD_REQUEST, "billIdEmpty");
            return;
        }
        int billId;
        try {
            billId = Integer.parseInt(billIdParam);
        } catch (NumberFormatException e) {
            billId = -1;
        }
        if (billId <= 0) {
            respond(resp, HttpServletResponse.SC_BAD_REQUEST, "billIdInvalid");
            return;
        }
        if (feedbackText.isEmpty()) {
            respond(resp, HttpServletResponse.SC_BAD_REQUEST, "feedbackEmpty");
            return;
        }
        if (feedbackText.length() > MAX_FEEDBACK_LENGTH) {
            respond(resp, HttpServletResponse.SC_BAD_REQUEST, "feedbackTooLong");
            return;
        }

        try {
            // Same answer for "no such bill" and "someone else's bill", so bill IDs can't be probed.
            if (!new Bill_InfoDao().isBillOwnedByCustomer(billId, customer.getCustomerId())) {
                respond(resp, HttpServletResponse.SC_NOT_FOUND, "billNotFound");
                return;
            }

            UserDao userDao = new UserDao();
            if (userDao.hasFeedbackForBill(billId)) {
                respond(resp, HttpServletResponse.SC_CONFLICT, "alreadySubmitted");
                return;
            }

            Feedback feedback = new Feedback();
            feedback.setCustomer_id(customer.getCustomerId());
            feedback.setBill_id(billId);
            feedback.setFeedback(feedbackText);

            if (userDao.addCustomerFeedback(feedback)) {
                respond(resp, HttpServletResponse.SC_OK, "success");
            } else {
                respond(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "serverError");
            }
        } catch (RuntimeException e) {
            log("Saving feedback for bill " + billId + " failed", e);
            respond(resp, HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "serverError");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("feedback.jsp");
    }

    private static void respond(HttpServletResponse resp, int status, String code) throws IOException {
        resp.setStatus(status);
        resp.setContentType("text/plain");
        resp.setCharacterEncoding("UTF-8");
        resp.getWriter().write(code);
    }

    private static String trim(String value) {
        return value == null ? "" : value.trim();
    }
}
