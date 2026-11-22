package org.example.greensuper.dao;

import org.example.greensuper.models.Bill;
import org.example.greensuper.models.Order;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class Bill_InfoDao {
    // True when the bill exists and was created from this customer's cart. Used by FeedbackServlet.
    public boolean isBillOwnedByCustomer(int billId, int customerId) {
        String SQL = """
                SELECT 1
                FROM bills b
                JOIN carts c ON b.cart_id = c.cart_id
                WHERE b.bill_id = ? AND c.customer_id = ?
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, billId);
            preparedStatement.setInt(2, customerId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while checking the bill.", e);
        }
    }

    public boolean isBillValid(Bill bill) {

        String SQL_billValidation = """
                SELECT bill_id
                FROM bills
                WHERE bill_id = ?
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL_billValidation)){
            preparedStatement.setInt(1, bill.getBillId());

            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return false;
    }

    public List<Order> getAllOrderDetails() {
        List<Order> orderList = new ArrayList<>();

        String SQL = """
                SELECT
                    bi.bill_id,
                    cu.customer_id,
                    pay.payment_date,
                    pay.amount,
                    bi.payment_status
                FROM customers cu
                JOIN carts ca ON cu.customer_id = ca.customer_id
                JOIN bills bi ON ca.cart_id = bi.bill_id
                JOIN payments pay ON bi.bill_id = pay.payment_id
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Order order = new Order();
                order.setBillId(resultSet.getInt(1));
                order.setCustomerId(resultSet.getInt(2));
                order.setDate(resultSet.getDate(3).toLocalDate());
                order.setBillTotal(resultSet.getDouble(4));
                order.setStatus(resultSet.getString(5));

                orderList.add(order);
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return orderList;
    }
}
