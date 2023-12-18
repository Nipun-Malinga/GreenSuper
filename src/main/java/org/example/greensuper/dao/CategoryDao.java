package org.example.greensuper.dao;

import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    //Add category image with details.
    public boolean addCategory(Category category, Image image) {
        // Testing(Debug)
        System.out.println(category.getCategoryType() + " " + image.getImageName());

        Connection connection = DBConnection.getConnection();
        boolean imageStored = false;
        boolean categoryStored = false;

        String SQL = "INSERT INTO images(image_name) VALUES (?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, image.getImageName());

            if (preparedStatement.executeUpdate() > 0) {
                imageStored = true;
            }
            // Getting Generated key(image id)
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int image_id = generatedKeys.getInt(1);

                    String SQL_Category = "INSERT INTO category (category_type, image_id) VALUES (?, ?)";

                    try (PreparedStatement categoryDetails = connection.prepareStatement(SQL_Category)) {
                        categoryDetails.setString(1, category.getCategoryType());
                        categoryDetails.setInt(2, image_id);

                        if (categoryDetails.executeUpdate() > 0) {
                            categoryStored = true;
                        }
                        //Return true if image and category is stored.
                        return imageStored && categoryStored;
                    }
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return false;
    }

    public boolean removeCategory(Category category) {
        return false;
    }

    public boolean updateCategory(Category category) {
        return false;
    }

    public List<Category> fetchAllCategories() {
        List<Category> categoryList = new ArrayList<>();

        return categoryList;
    }
}
