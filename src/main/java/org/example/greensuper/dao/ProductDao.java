package org.example.greensuper.dao;

import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;
import org.example.greensuper.models.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    public boolean addProduct(Product product, Image image) {
        //Testing (Debug)

        Connection connection = DBConnection.getConnection();
        boolean imageStored = false;
        boolean productStored = false;

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

                    String SQL_Category = "INSERT INTO product (category_id, product_name, description, price, quantity, image_id) VALUES (?, ?, ?, ?, ?, ?)";

                    try (PreparedStatement categoryDetails = connection.prepareStatement(SQL_Category)) {
                        categoryDetails.setInt(1, product.getCategoryId());
                        categoryDetails.setString(2, product.getProductName());
                        categoryDetails.setString(3, product.getDescription());
                        categoryDetails.setDouble(4, product.getPrice());
                        categoryDetails.setInt(5, product.getQuantity());
                        categoryDetails.setInt(6, image_id);

                        if (categoryDetails.executeUpdate() > 0) {
                            productStored = true;
                        }
                        //Return true if image and category is stored.
                        return imageStored && productStored;
                    }
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return false;
    }

    public boolean removeProduct(Product product) {
        return false;
    }

    public boolean updateProduct(Product product) {
        return false;
    }

    public List<Product> fetchAllProducts(Category category) {
        Connection connection = DBConnection.getConnection();
        List<Product> productList = new ArrayList<>();

        String SQL = "SELECT pr.product_id, pr.category_id, pr.product_name, pr.description, pr.price, pr.quantity, pr.is_in_stock, img.image_name FROM product pr JOIN images img ON pr.image_id = img.image_id WHERE category_id = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, category.getCategoryId());

            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                productList.add(new Product(
                        resultSet.getInt(1),
                        resultSet.getInt(2),
                        resultSet.getString(3),
                        resultSet.getString(4),
                        resultSet.getDouble(5),
                        resultSet.getInt(6),
                        resultSet.getBoolean(7),
                        resultSet.getString(8)
                ));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }
}
