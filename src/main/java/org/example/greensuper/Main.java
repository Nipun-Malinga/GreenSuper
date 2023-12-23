package org.example.greensuper;

import org.example.greensuper.dao.ProductDao;
import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Category;

import java.util.ArrayList;
import java.util.List;


public class Main {
    public static void main(String[] args) {
        List<CartItem> cartItemList = new ArrayList<>();
        CartItem cartItem = new CartItem();
        cartItem.setProductId(1);
        cartItem.setCartItemId(1);

        cartItemList.add(cartItem);

        ProductDao productDao = new ProductDao();

        for(var item : productDao.fetchForCart(cartItemList)) {
            System.out.println(item.getProductName());
        }
    }
}