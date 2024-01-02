package org.example.greensuper.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;

import java.io.IOException;

@WebFilter("/register")
public class registrationFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String firstName = request.getParameter("firstName");
        String lastName = request.getParameter("lastName");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String phoneNumber = request.getParameter("phoneNumber");
        String homeNumber = request.getParameter("homeNumber");
        String streetName = request.getParameter("streetName");
        String city = request.getParameter("city");

        System.out.println(firstName + lastName + email + password + phoneNumber +homeNumber + streetName +city);

        if(isEmpty(firstName) || isEmpty(lastName) || isEmpty(email) || isEmpty(password) || isEmpty(phoneNumber) || isEmpty(homeNumber) || isEmpty(streetName) || isEmpty(city)) {
            response.getWriter().write("emptyParameters");
        } else {
            chain.doFilter(request, response);
        }
    }

    private boolean isEmpty(String value) {
        return value == null || value.isEmpty();
    }
}
