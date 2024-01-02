package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Customer;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String userEmail = req.getParameter("userEmail");

        Customer customer = new Customer();
        UserDao userDao = new UserDao();
        HttpSession session = req.getSession();

        customer.setEmail(userEmail);
        customer = userDao.getUserDetails(userEmail);

        session.setAttribute("auth", customer.getFirstName() + " " + customer.getLastName());
        session.setAttribute("userCredentials", customer);

        PrintWriter writer = resp.getWriter();
        writer.write("./index.jsp");
    }

}
