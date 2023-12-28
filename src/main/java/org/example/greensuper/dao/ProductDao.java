package org.example.greensuper.dao;

import org.example.greensuper.models.CartItem;
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

        String SQL = "INSERT INTO images(image_name) VALUES (?)";
        try (PreparedStatement preparedStatement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            preparedStatement.setString(1, image.getImageName());

            if (preparedStatement.executeUpdate() > 0) {
                // Getting Generated key(image id)
                try (ResultSet generatedKeys = preparedStatement.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        int image_id = generatedKeys.getInt(1);

                        String SQL_Category = "INSERT INTO product (category_id, product_name, description, price, quantity, is_in_stock, image_id) VALUES (?, ?, ?, ?, ?, ?, ?)";

                        try (PreparedStatement categoryDetails = connection.prepareStatement(SQL_Category)) {
                            categoryDetails.setInt(1, product.getCategoryId());
                            categoryDetails.setString(2, product.getProductName());
                            categoryDetails.setString(3, product.getDescription());
                            categoryDetails.setDouble(4, product.getPrice());
                            categoryDetails.setInt(5, product.getQuantity());
                            categoryDetails.setBoolean(6, product.getIsInStock());
                            categoryDetails.setInt(7, image_id);

                            if (categoryDetails.executeUpdate() > 0) {
                                //Return true if image and category are stored in a database.
                                return true;
                            }
                        }
                    }
                }
            }
        } catch (SQLException ex) {
            throw new RuntimeException(ex);
        }
        return false;
    }

    public boolean removeProduct(Product product) {
        Connection connection = DBConnection.getConnection();
        String SQL = "DELETE FROM product WHERE product_id = ?";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, product.getProductId());

            if(preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    public boolean updateProduct(Product product) {
        Connection connection = DBConnection.getConnection();

        String SQL = "UPDATE product pr" +
                     "JOIN image img ON pr.image_id = img.image_id" +
                     "SET " +
                        "pr.product_name = ?," +
                        "pr.description = ?," +
                        "pr.price = ?," +
                        "pr.quantity = ?," +
                        "img.img_name = ?" +
                    "WHERE pr.product_id = ?;";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)){
            preparedStatement.setString(1, product.getProductName());
            preparedStatement.setString(2, product.getDescription());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setString(5, product.getImageName());

            if(preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    //Fetching product items for a specific category,
    public List<Product> fetchProducts(Category category) {
        Connection connection = DBConnection.getConnection();
        List<Product> productList = new ArrayList<>();

        String SQL = "SELECT " +
                        "pr.product_id, " +
                        "pr.category_id, " +
                        "pr.product_name, " +
                        "pr.description, " +
                        "pr.price, " +
                        "pr.quantity, " +
                        "pr.is_in_stock, " +
                        "img.image_name " +
                    "FROM product pr " +
                    "JOIN images img ON pr.image_id = img.image_id " +
                    "WHERE category_id = ?";
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

    //Fetching Product items for cart.
    public List<CartItem> fetchForCart(List<CartItem> cartItemList) {
        Connection connection = DBConnection.getConnection();
        List<CartItem> cartItems = new ArrayList<>();

        String SQL = "SELECT " +
                        "pr.product_id, " +
                        "pr.product_name, " +
                        "pr.price, " +
                        "pr.quantity, " +
                        "img.image_name " +
                    "FROM product pr J" +
                    "OIN images img " +
                    "ON pr.image_id = img.image_id WHERE product_id = ?";
        if(!cartItemList.isEmpty()) {
            try (PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
                for (var item : cartItemList) {
                    preparedStatement.setInt(1, item.getProductId());

                    ResultSet resultSet = preparedStatement.executeQuery();
                    while (resultSet.next()) {
                        CartItem cartItem = new CartItem();

                        cartItem.setProductId(resultSet.getInt(1));
                        cartItem.setProductName(resultSet.getString(2));
                        cartItem.setPrice(resultSet.getDouble(3));
                        cartItem.setBoughtQuantity(item.getBoughtQuantity());
                        cartItem.setQuantity(resultSet.getInt(4));
                        cartItem.setImageName(resultSet.getString(5));

                        cartItems.add(cartItem);
                    }
               }
            }
            catch (SQLException e) {
                throw new RuntimeException(e);
            }
        }
        return cartItems;
    }

    public double fetchCartAmount(List<CartItem> cartItemList) {
        Connection connection = DBConnection.getConnection();
        double totalAmount = 0;
        String SQL = "SELECT price " +
                     "FROM product " +
                     "WHERE product_id = ?";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            for(var item : cartItemList) {
                preparedStatement.setInt(1, item.getProductId());

                ResultSet resultSet = preparedStatement.executeQuery();

                while (resultSet.next()) {
                    totalAmount += resultSet.getDouble(1) * item.getBoughtQuantity();
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return totalAmount;
    }
}
