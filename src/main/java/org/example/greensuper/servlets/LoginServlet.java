package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Customer;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userEmail = req.getParameter("userEmail");
        String password = req.getParameter("password");

        Customer customer = new Customer();

        customer.setEmail(userEmail);
        customer.setPassword(password);

        HttpSession session = req.getSession();

        UserDao userDao = new UserDao();
        if (userDao.userLogin(customer)) {
            customer = userDao.getCustomerDetails(userEmail);

            session.setAttribute("auth", customer.getFirstName() + " " + customer.getLastName());
            session.setAttribute("userCredentials", customer);
            resp.sendRedirect("index.jsp");
        } else {
            resp.sendRedirect("login.jsp");
        }
    }

}
