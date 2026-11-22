package org.example.greensuper.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.List;

public class ImageDao {

    // True if any remaining image row still uses this file name. Old uploads were saved under
    // the browser's file name, so two items can share one file; it must not be deleted then.
    public boolean isImageInUse(String imageName) {
        String SQL = "SELECT 1 FROM images WHERE image_name = ? LIMIT 1";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, imageName);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while checking image usage.", e);
        }
    }

    // Deletes image rows by id. Call only after the category/product rows that reference them are gone.
    static void deleteImageRows(Connection connection, List<Integer> imageIds) throws SQLException {
        String SQL = "DELETE FROM images WHERE image_id = ?";
        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            for (int imageId : imageIds) {
                preparedStatement.setInt(1, imageId);
                preparedStatement.addBatch();
            }
            preparedStatement.executeBatch();
        }
    }
}
