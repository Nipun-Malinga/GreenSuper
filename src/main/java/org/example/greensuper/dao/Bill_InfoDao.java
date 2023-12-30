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
    Connection connection = DBConnection.getConnection();
    public boolean isBillValid(Bill bill) {

        String SQL_billValidation = "SELECT bill_id FROM bill WHERE bill_id = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL_billValidation)){
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

        String SQL = "select bi.bill_id, cu.customer_id, pay.payment_date, pay.amount, bi.payment_status  " +
                "from customer cu  " +
                "JOIN cart ca ON cu.customer_id = ca.customer_id " +
                "join bill bi on ca.cart_id = bi.bill_id " +
                "join payment pay on bi.bill_id = pay.payment_id;";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
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
