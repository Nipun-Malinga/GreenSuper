package org.example.greensuper.dao;

import org.example.greensuper.models.Admin;
import org.example.greensuper.utils.DecryptionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {
    public boolean isValidAdmin(Admin admin) {
        DecryptionUtil util = new DecryptionUtil();
        String SQL = """
                SELECT admin_hashed_password
                FROM admin
                WHERE admin_email = ?
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, admin.getAdminEmail());

            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next() && util.isPasswordMatch(admin.getAdminPassword(), resultSet.getString(1))) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return false;
    }
}
