package org.example.greensuper.dao;

import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Customer;

import java.sql.*;
import java.util.List;

public class CartDao {
    public void addTocCart(Customer customer, List<CartItem> cartItemList, double cartPrice) {
        Connection connection = DBConnection.getConnection();

        String SQL = "INSERT INTO cart (customer_id, total_price) VALUES (?, ?)";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, customer.getCustomerId());
            preparedStatement.setDouble(2, cartPrice);

            if(preparedStatement.executeUpdate() > 0) {
                try(ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if(generatedKeys.next()) {
                        int cart_id = generatedKeys.getInt(1);

                        String SQL_CartItem = "INSERT INTO cart_item (cart_id, product_id, bought_quantity) VALUES (?, ?, ?)";

                        for(var cartItem : cartItemList) {
                        try(PreparedStatement cart_item  = connection.prepareStatement(SQL_CartItem)) {
                                cart_item.setInt(1, cart_id);
                                cart_item.setInt(2, cartItem.getProductId());
                                cart_item.setInt(3, cartItem.getBoughtQuantity());
                            if(cart_item.executeUpdate() > 0) {
                            }
                                System.out.println("Cart, Cart_Item Tables Updated");
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
