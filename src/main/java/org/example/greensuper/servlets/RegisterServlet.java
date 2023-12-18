package org.example.greensuper.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Customer;
import org.example.greensuper.utils.EncryptionUtil;

import java.io.IOException;
import java.io.PrintWriter;

@WebServlet("/register")
public class RegisterServlet extends HttpServlet {
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        String phoneNumber = req.getParameter("phoneNumber");
        String homeNumber = req.getParameter("homeNumber");
        String streetName = req.getParameter("streetName");
        String city = req.getParameter("city");

        EncryptionUtil encryption = new EncryptionUtil();

        Customer customer = new Customer(
                firstName, lastName ,
                email ,  encryption.hashingPassword(password),
                phoneNumber, homeNumber ,
                streetName, city
        );

        PrintWriter writer = resp.getWriter();

        UserDao userDao = new UserDao();
        //Front end response.
        if (userDao.registerUser(customer)) {
            writer.write("userRegistrationSuccess");
        } else {
            writer.write("userRegistrationFailed");
        }
    }
}
