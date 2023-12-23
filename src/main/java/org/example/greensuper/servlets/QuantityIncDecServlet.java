package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.CartItem;

import java.io.IOException;
import java.util.List;

@WebServlet("/quantity-inc-dec")
public class QuantityIncDecServlet extends HttpServlet {
    ProductDao productDao = new ProductDao();
    @Override
    @SuppressWarnings("unchecked")
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productIdParam = req.getParameter("productId");
        String action = req.getParameter("action");

        System.out.println(productIdParam + action);

        HttpSession session = req.getSession();
        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");

        session = req.getSession();

        if (productIdParam != null && action != null) {
            int productID = Integer.parseInt(productIdParam);

            for (var item : cartItemList) {

                int quantity = item.getBoughtQuantity();

                if (item.getProductId() == productID) {
                    if (action.equals("inc")) {
                        quantity++;
                        item.setBoughtQuantity(quantity);
                        resp.sendRedirect("cart.jsp");
                    } else if (action.equals("dec")) {
                        if (quantity > 1) {
                            quantity--;
                            item.setBoughtQuantity(quantity);
                            resp.sendRedirect("cart.jsp");
                        } else {
                            resp.sendRedirect("cart.jsp");
                        }
                    }
                }
            }
        }
        session.setAttribute("cartPrice", productDao.fetchCartAmount(cartItemList));

    }
}
