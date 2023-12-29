package org.example.greensuper.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.Bill_InfoDao;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Bill;
import org.example.greensuper.models.Customer;
import org.example.greensuper.models.Feedback;

import java.io.IOException;
import java.io.PrintWriter;
import java.sql.Date;
import java.time.LocalDate;

@WebServlet("/feedback")
public class FeedbackServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String billIdParam = req.getParameter("billId");
        HttpSession session = req.getSession();
        PrintWriter writer = resp.getWriter();
        Customer customer = (Customer) session.getAttribute("userCredentials");


        if(billIdParam != null && !billIdParam.isEmpty() && customer != null) {
            int billID = Integer.parseInt(billIdParam);
            String feedback = req.getParameter("feedback");

            Bill_InfoDao billInfoDao = new Bill_InfoDao();
            Bill bill = new Bill();
            bill.setBillId(billID);

            if(!billInfoDao.isBillValid(bill)) {
                writer.write("invalidBillId");
                System.out.println("invalidBillId");
            } else {
                Feedback customerFeedback = new Feedback();
                UserDao userDao = new UserDao();

                customerFeedback.setCustomer_id(customer.getCustomerId());
                customerFeedback.setBill_id(billID);
                customerFeedback.setFeedback(feedback);

                if(userDao.addCustomerFeedback(customerFeedback)) {
                    System.out.println("FeedbackSuccess");
                    writer.write("FeedbackSuccess");
                } else {
                    writer.write("FeedbackFailed");
                    System.out.println("FeedbackFailed");

                }
            }
            resp.sendRedirect("feedback.jsp");
        }
        else {
            writer.write("loginFailed");
        }
    }
}
