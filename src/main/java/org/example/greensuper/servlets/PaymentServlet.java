package org.example.greensuper.servlets;

import com.paypal.api.payments.Links;
import com.paypal.api.payments.Payment;
import com.paypal.base.rest.PayPalRESTException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.CartDao;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Customer;
import org.example.greensuper.services.PaymentService;
import org.example.greensuper.utils.EmailSender;

import java.io.IOException;
import java.util.List;

@WebServlet("/payment")
@SuppressWarnings("unchecked")
public class PaymentServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession();
        if (session.getAttribute("auth") != null) {
            String action = req.getParameter("action");
            double cartPrice = (double) session.getAttribute("cartPrice") / 325;
            if ("checkout".equals(action)) {
                System.out.println(cartPrice);
                String cancelUrl = "http://localhost:8080/GreenSuper_war_exploded/payment_canceled.jsp";
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
                String transaction_id = req.getParameter("paymentId");
                String payerId = req.getParameter("PayerId");

                try {
                    Payment executedPayment = PaymentService.executePayment(transaction_id, payerId);

                    String paymentStatus;

                    if ("approved".equalsIgnoreCase(executedPayment.getState())) {
                        Customer customer = (Customer) session.getAttribute("userCredentials");
                        EmailSender emailSender = new EmailSender();
                        CartDao cartDao = new CartDao();
                        ProductDao productDao = new ProductDao();

                        int previousBillId = cartDao.getBillId();
                        int nextBillId = previousBillId + 1;

                        paymentStatus = "paid";
                        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");

                        cartDao.storingSalesInfo(transaction_id, customer, cartItemList, cartPrice, paymentStatus);
                        emailSender.sendEmail(customer.getEmail(), cartItemList, cartPrice, nextBillId);

                        productDao.updateQuantity(cartItemList);

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
            resp.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect("index.jsp");
    }
}
