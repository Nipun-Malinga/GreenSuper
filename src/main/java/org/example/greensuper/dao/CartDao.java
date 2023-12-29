package org.example.greensuper.dao;

import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Customer;

import java.sql.*;
import java.time.LocalDate;
import java.util.List;

public class CartDao {
    Connection connection = DBConnection.getConnection();

    public void addTocCart(String paymentId, Customer customer, List<CartItem> cartItemList, double cartPrice) {
        LocalDate date = LocalDate.now();

        //Inserting data into cart table.
        String SQL = "INSERT INTO cart (customer_id, total_price) VALUES (?, ?)";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setInt(1, customer.getCustomerId());
            preparedStatement.setDouble(2, cartPrice);

            if(preparedStatement.executeUpdate() > 0) {
                //Generating cart_Id key
                try(ResultSet cart_id_key = preparedStatement.getGeneratedKeys()) {
                    if(cart_id_key.next()) {
                        int cart_id = cart_id_key.getInt(1);
                        System.out.println("Cart table updated");

                        //Inserting data into cart_item table.
                        String SQL_CartItem = "INSERT INTO cart_item (cart_id, product_id, bought_quantity) VALUES (?, ?, ?)";
                        for(var cartItem : cartItemList) {
                            try(PreparedStatement cart_item  = connection.prepareStatement(SQL_CartItem)) {
                                    cart_item.setInt(1, cart_id);
                                    cart_item.setInt(2, cartItem.getProductId());
                                    cart_item.setInt(3, cartItem.getBoughtQuantity());
                                if(cart_item.executeUpdate() > 0) {
                                    System.out.println("Cart_Item table updated");

                                    //Inserting data into bill table.
                                    String SQL_Bill = "INSERT INTO bill (cart_id) VALUES (?)";
                                    try(PreparedStatement inserting_to_bill = connection.prepareStatement(SQL_Bill, Statement.RETURN_GENERATED_KEYS)) {
                                        inserting_to_bill.setInt(1, cart_id);
                                        if(inserting_to_bill.executeUpdate() > 0) {
                                            System.out.println("Bill table updated.");

                                            //Generating bill_Id key
                                            try(ResultSet bill_id_key = inserting_to_bill.getGeneratedKeys()){
                                                if(bill_id_key.next()) {
                                                    int bill_Id = bill_id_key.getInt(1);

                                                    //Inserting data into payment table.
                                                    String SQL_Payment = "INSERT INTO payment (payment_id, bill_id, payment_date, amount) VALUES (?, ?, ?, ?)";
                                                    try(PreparedStatement inserting_to_payment = connection.prepareStatement(SQL_Payment)) {
                                                        inserting_to_payment.setString(1, paymentId);
                                                        inserting_to_payment.setInt(2, bill_Id);
                                                        inserting_to_payment.setDate(3, Date.valueOf(date));
                                                        inserting_to_payment.setDouble(4, cartPrice);

                                                        if(inserting_to_payment.executeUpdate() > 0) {
                                                            System.out.println("Payment table updated.");
                                                        }
                                                    }
                                                }
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while inserting data in to database after making the payment.....");
        }
    }

    public int getBillId() {

        int lastBillID = 0;
        String SQL = "SELECT bill_id FROM bill ORDER BY bill_id DESC LIMIT 1";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next())
                lastBillID =  resultSet.getInt(1);
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return lastBillID;
    }

    public double getAllSalesAmount() {

        String SQL = "SELECT SUM(amount) FROM payment";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                return resultSet.getDouble(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while calculating sales data in the payment database...");
        }
        return 0;
    }

    public int getAllCompletedOrders() {

        String SQL = "SELECT COUNT(*) FROM bill";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while fetching all completed orders from the database...");
        }
        return 0;
    }
}
