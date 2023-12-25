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
import java.util.function.Predicate;

@WebServlet("/remove-Cart-Item")
@SuppressWarnings("unchecked")
public class RemoveFromCartServlet extends HttpServlet {
    ProductDao productDao = new ProductDao();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productIdParam = req.getParameter("productId");
        HttpSession session = req.getSession();

        if(!productIdParam.isEmpty()) {
            int productId = Integer.parseInt(productIdParam);
            List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
            Predicate<CartItem> predicate = item -> item.getProductId() == productId;
            cartItemList.removeIf(predicate);
            session.setAttribute("cartPrice", productDao.fetchCartAmount(cartItemList));
            resp.sendRedirect("cart.jsp");
        }
    }
}
