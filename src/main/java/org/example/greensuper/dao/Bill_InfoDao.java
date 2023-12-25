package org.example.greensuper.dao;

import org.example.greensuper.models.Bill;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class Bill_InfoDao {
    public boolean isBillValid(Bill bill) {
        Connection connection = DBConnection.getConnection();

        String SQL = "SELECT bill_id FROM bill WHERE bill_id = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)){
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
}
