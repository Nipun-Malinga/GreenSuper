package org.example.greensuper.dao;

import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CategoryDao {
    //Add category image with details.
    public boolean addCategory(Category category, Image image) {
        isCategoryExists(category.getCategoryType());

        boolean imageStored = false;
        boolean categoryStored = false;

        String SQL = """
                INSERT INTO images (image_name)
                VALUES (?)
                """;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, image.getImageName());

            if (preparedStatement.executeUpdate() > 0) {
                imageStored = true;
            }
            // Getting Generated key(image id)
            try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                if (generatedKeys.next()) {
                    int image_id = generatedKeys.getInt(1);

                    String SQL_Category = """
                            INSERT INTO category (category_type, image_id)
                            VALUES (?, ?)
                            """;

                    try (PreparedStatement categoryDetails = connection.prepareStatement(SQL_Category)) {
                        categoryDetails.setString(1, category.getCategoryType());
                        categoryDetails.setInt(2, image_id);

                        if (categoryDetails.executeUpdate() > 0) {
                            categoryStored = true;
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException("An error occurred while inserting category details to the database....", ex);
        }
        return imageStored && categoryStored;
    }

    public boolean removeCategory(Category category) {

        String SQL_delete_cart_item = """
                DELETE FROM cart_item
                WHERE product_id IN (
                    SELECT product_id
                    FROM product
                    WHERE category_id = ?
                )
                """;
        String SQL_delete_products = """
                DELETE FROM product
                WHERE category_id = ?
                """;
        String SQL_delete_category = """
                DELETE FROM category
                WHERE category_id = ?
                """;

        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SQL_delete_cart_item)) {
            // Collected first: once the rows below are deleted, these ids can no longer be looked up.
            List<Integer> imageIds = getCategoryImageIds(connection, category.getCategoryId());

            preparedStatement.setInt(1, category.getCategoryId());

            if (preparedStatement.executeUpdate() > 0) {
                System.out.println("Cart Item Deleted SuccessFully");
            }
            try (PreparedStatement deleteProduct = connection.prepareStatement(SQL_delete_products)) {
                deleteProduct.setInt(1, category.getCategoryId());

                if (deleteProduct.executeUpdate() > 0) {
                    System.out.println("Products Deleted Successfully");
                }
            }
            try (PreparedStatement deleteCategory = connection.prepareStatement(SQL_delete_category)) {
                deleteCategory.setInt(1, category.getCategoryId());

                if (deleteCategory.executeUpdate() > 0) {
                    System.out.println("Category Successfully Deleted from the database");
                    ImageDao.deleteImageRows(connection, imageIds);
                    return true;
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean updateCategory(Category category) {
        String SQL = """
                UPDATE category
                JOIN images ON category.category_id = images.image_id
                SET
                    category.category_type = ?,
                    images.image_name = ?
                WHERE category.category_id = ?
                """;

        System.out.println(category.getCategoryType() + category.getImageName());
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, category.getCategoryType());
            preparedStatement.setString(2, category.getImageName());
            preparedStatement.setInt(3, category.getCategoryId());

            if (preparedStatement.executeUpdate() > 0) {
                System.out.println("Category Updated Successfully.");
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public Category getCategory(int categoryId) {
        Category category = new Category();


        String SQL = """
                SELECT
                    ca.category_id,
                    ca.category_type,
                    img.image_name
                FROM category ca
                JOIN images img ON ca.image_id = img.image_id
                WHERE category_id = ?
                """;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, categoryId);

            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                category.setCategoryId(resultSet.getInt(1));
                category.setCategoryType(resultSet.getString(2));
                category.setImageName(resultSet.getString(3));
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }

        return category;
    }

    public List<Category> getAllCategories() {
        List<Category> categoryList = new ArrayList<>();

        String SQL = """
                SELECT
                    ca.category_id,
                    ca.category_type,
                    img.image_name
                FROM category ca
                JOIN images img ON ca.image_id = img.image_id
                """;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement statement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = statement.executeQuery();
            while (resultSet.next()) {
                categoryList.add(new Category(resultSet.getInt(1), resultSet.getString(2), resultSet.getString(3)));
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while fetching categories from the database...");
        }

        return categoryList;
    }

    // Throws AlreadyExistsException if a category with the same name (ignoring case and
    // surrounding spaces) is already in the database.
    private void isCategoryExists(String categoryType) {
        String SQL = """
                SELECT 1
                FROM category
                WHERE LOWER(TRIM(category_type)) = LOWER(TRIM(?))
                LIMIT 1
                """;
        try (Connection connection = DBConnection.getConnection(); PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, categoryType);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                if (resultSet.next()) {
                    throw new AlreadyExistsException("Category '" + categoryType + "' already exists.");
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while checking for an existing category.", e);
        }
    }

    // Image ids of the category itself and of every product in it.
    private List<Integer> getCategoryImageIds(Connection connection, int categoryId) throws SQLException {
        String SQL = """
                SELECT image_id
                FROM category
                WHERE category_id = ?
                  AND image_id IS NOT NULL
                UNION
                SELECT image_id
                FROM product
                WHERE category_id = ?
                  AND image_id IS NOT NULL
                """;
        List<Integer> imageIds = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, categoryId);
            preparedStatement.setInt(2, categoryId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                while (resultSet.next()) {
                    imageIds.add(resultSet.getInt(1));
                }
            }
        }
        return imageIds;
    }
}
