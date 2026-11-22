package org.example.greensuper.dao;

import org.example.greensuper.models.Admin;
import org.example.greensuper.utils.DecryptionUtil;
import org.example.greensuper.utils.EncryptionUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class AdminDao {
    public boolean isValidAdmin(Admin admin) {
        DecryptionUtil util = new DecryptionUtil();
        String SQL = """
                SELECT admin_hashed_password
                FROM admins
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

    public boolean adminExists(String adminEmail) {
        String SQL = """
                SELECT 1
                FROM admins
                WHERE admin_email = ?
                LIMIT 1
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, adminEmail);

            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    /** Stores the admin with a BCrypt hash of its plain-text password. */
    public boolean addAdmin(Admin admin) {
        String SQL = """
                INSERT INTO admins (admin_email, admin_hashed_password)
                VALUES (?, ?)
                """;

        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, admin.getAdminEmail());
            preparedStatement.setString(2, new EncryptionUtil().hashingPassword(admin.getAdminPassword()));

            return preparedStatement.executeUpdate() > 0;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
