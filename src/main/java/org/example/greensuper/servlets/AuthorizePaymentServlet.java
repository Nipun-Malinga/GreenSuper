package org.example.greensuper.servlets;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.CartDao;
import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Customer;
import org.example.greensuper.services.PaymentService;
import org.example.greensuper.utils.EmailSender;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

@WebServlet("/payment")
@SuppressWarnings("unchecked")
public class AuthorizePaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        String action = req.getParameter("action");

        double cartPrice = (double) session.getAttribute("cartPrice");
        if (session.getAttribute("auth") != null) {
            if ("checkout".equals(action)) {
                System.out.println(cartPrice);
                String cancelUrl = "http://localhost:8080/GreenSuper_war_exploded/cancel_payment.jsp";
                String successUrl = "http://localhost:8080/GreenSuper_war_exploded/payment_approve.jsp";

                System.out.println(action);
                try {
                    Payment payment = PaymentService.createPayment(cartPrice, "USD", "paypal", "sale", "Cart Payment",
                            cancelUrl, successUrl);

                    List<Links> links = payment.getLinks();
                    for (Links link : links) {
                        if (link.getRel().equals("approval_url")) {
                            resp.sendRedirect(link.getHref());
                            break;
                        }
                    }
                } catch (PayPalRESTException e) {
                    resp.sendRedirect("error.jsp");
                    throw new RuntimeException("An error accorded while checkout the payment.");
                }
            } else if ("execute_payment".equals(action)) {
                String paymentId = req.getParameter("paymentId");
                String payerId = req.getParameter("PayerId");

                System.out.println(paymentId + payerId);

                try {
                    Payment executedPayment = PaymentService.executePayment(paymentId, payerId);

                    if ("approved".equalsIgnoreCase(executedPayment.getState())) {
                        Customer customer = (Customer) session.getAttribute("userCredentials");
                        EmailSender emailSender = new EmailSender();
                        CartDao cartDao = new CartDao();
                        cartDao.addTocCart(customer, (List<CartItem>) session.getAttribute("cart_item"), cartPrice);
                        emailSender.sendEmail(customer.getEmail(), (List<CartItem>) session.getAttribute("cart_item"), cartPrice);

                        resp.sendRedirect("payment_success.jsp");
                    } else {
                        resp.sendRedirect("payment_failed.jsp");
                    }
                } catch (PayPalRESTException e) {
                    resp.sendRedirect("error.jsp");
                    throw new RuntimeException("An error accorded while executing payment.");
                }
            } else {
                resp.getWriter().print("Invalid action");
            }
        } else {
            PrintWriter writer = resp.getWriter();
            writer.write("loginFailed");
        }
    }
}
