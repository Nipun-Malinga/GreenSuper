package org.example.greensuper.filter;

import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import org.example.greensuper.dao.AdminDao;
import org.example.greensuper.models.Admin;

import java.io.IOException;

@WebFilter("/adminLogin")
public class AdminLoginFilter implements Filter {
    @Override
    public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
        String email = request.getParameter("adminEmail");
        String password = request.getParameter("adminPassword");

        if(isEmpty(email) || isEmpty(password)) {
            response.getWriter().write("emptyParameters");
        } else {
            Admin admin = new Admin(email, password);
            AdminDao adminDao = new AdminDao();

            if(adminDao.isValidAdmin(admin)) {
                chain.doFilter(request, response);
            } else {
                response.getWriter().write("invalidAdminLogin");
            }
        }

    }

    private boolean isEmpty(String value) {
        return value == null || value.isEmpty();
    }
}
