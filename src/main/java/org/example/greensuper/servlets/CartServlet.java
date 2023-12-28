package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.CartItem;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
@SuppressWarnings("unchecked")
public class CartServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws IOException {
        String productIdParam = req.getParameter("productId");
        String quantityParam = req.getParameter("quantity");

        HttpSession session = req.getSession();
        ProductDao productDao = new ProductDao();

        PrintWriter writer = resp.getWriter();

        List<CartItem> cartItemList = (List<CartItem>) session.getAttribute("cart_item");
        if (cartItemList == null) {
            cartItemList = new ArrayList<>();
        }

        if ((productIdParam != null && !productIdParam.isEmpty()) && quantityParam == null) {
            CartItem cartItem = new CartItem();
            int productID = Integer.parseInt(productIdParam);

            cartItem.setProductId(productID);
            cartItem.setBoughtQuantity(1);

            if (session.getAttribute("cart_item") == null) {
                cartItemList.add(cartItem);
                writer.write("productAdded");
                System.out.println("Product Added");
            } else {
                boolean isExist = false;

                for (var item : cartItemList) {
                    if (item.getProductId() == productID) {
                        isExist = true;
                        writer.write("productExists");
                        System.out.println("Product Exists");
                        break;
                    }
                }
                if (!isExist) {
                    cartItemList.add(cartItem);
                    writer.write("productAdded");
                    System.out.println("Product Added");
                }
            }
        }
        session.setAttribute("cartPrice", productDao.fetchCartAmount(cartItemList));
        session.setAttribute("cart_item", productDao.fetchForCart(cartItemList));
    }

}
