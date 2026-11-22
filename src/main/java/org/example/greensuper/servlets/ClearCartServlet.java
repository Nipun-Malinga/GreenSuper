package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/clear-cart")
public class ClearCartServlet extends HttpServlet {

    // POST so a link prefetch or crawler can never empty someone's cart.
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        HttpSession session = req.getSession(false);
        if (session != null) {
            session.removeAttribute("cart_item");
            session.removeAttribute("cartPrice");
        }
        resp.sendRedirect("cart.jsp");
    }
}
