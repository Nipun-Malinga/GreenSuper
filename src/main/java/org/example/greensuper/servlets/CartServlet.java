package org.example.greensuper.servlets;

import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.CartItem;

import java.util.ArrayList;
import java.util.List;

@WebServlet("/cart")
public class CartServlet extends HttpServlet {
    List<CartItem> cartItemList = new ArrayList<>();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) {
        String productIdParam = req.getParameter("productId");
        String quantityParam = req.getParameter("quantity");

        HttpSession session = req.getSession();
        ProductDao productDao = new ProductDao();

        if((productIdParam != null && !productIdParam.isEmpty()) && quantityParam == null) {
            CartItem cartItem = new CartItem();
            int productID = Integer.parseInt(productIdParam);

            cartItem.setProductId(productID);
            cartItem.setBoughtQuantity(1);

            if(session.getAttribute("cart_item") == null) {
                cartItemList.add(cartItem);
                System.out.println("Product Added");
            }
            else {
                boolean isExist = false;

                for (var item : cartItemList) {
                    if(item.getProductId() == productID) {
                        isExist = true;
                        System.out.println("Product Exists");
                        break;
                    }
                }
                if(!isExist) {
                    cartItemList.add(cartItem);
                    System.out.println("Product Added");
                }
            }
        }
        session.setAttribute("cartPrice", productDao.fetchCartAmount(cartItemList));
        session.setAttribute("cart_item", productDao.fetchForCart(cartItemList));
    }
}