package org.example.greensuper.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import org.example.greensuper.dao.UserDao;
import org.example.greensuper.models.Customer;

import java.io.IOException;

@WebFilter("/login")
public class LoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String email = request.getParameter("userEmail");
        String password = request.getParameter("password");

        UserDao userDao = new UserDao();

        System.out.println(email + password);
        if(isEmpty(email) || isEmpty(password)) {
            response.getWriter().write("emptyParameters");
        } else {

            Customer customer = new Customer();
            customer.setEmail(email);
            customer.setPassword(password);

            if (userDao.userLogin(customer)) {
                chain.doFilter(request, response);
            } else {
                response.getWriter().write("loginFailed");
            }
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.isEmpty();
    }
}

