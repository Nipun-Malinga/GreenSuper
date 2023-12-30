package org.example.greensuper.dao;

import org.example.greensuper.models.CartItem;
import org.example.greensuper.models.Category;
import org.example.greensuper.models.Image;
import org.example.greensuper.models.Product;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class ProductDao {
    Connection connection = DBConnection.getConnection();
    public boolean addProduct(Product product, Image image) {
        //Testing (Debug)
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
            throw new RuntimeException("An error occurred while adding product into the database.");
        }
        return false;
    }

    public boolean removeProduct(Product product) {
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
        String SQL = "UPDATE product pr " +
                "JOIN images img ON pr.image_id = img.image_id " +
                "SET pr.category_id = ?, pr.product_name = ?, pr.price = ?, pr.quantity = ?, pr.description = ?, img.image_name = ? " +
                "WHERE pr.product_id = ?";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)){
            preparedStatement.setInt(1, product.getCategoryId());
            preparedStatement.setString(2, product.getProductName());
            preparedStatement.setDouble(3, product.getPrice());
            preparedStatement.setInt(4, product.getQuantity());
            preparedStatement.setString(5, product.getDescription());
            preparedStatement.setString(6, product.getImageName());
            preparedStatement.setInt(7, product.getProductId());

            if(preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while updating product in the database.");
        }
        return false;
    }

    public void updateQuantity(List<CartItem> cartItemList) {
        String SQL = "UPDATE product SET quantity = ? WHERE product_id = ?";

        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            for (var cart_item : cartItemList) {
                preparedStatement.setInt(1, cart_item.getQuantity()-cart_item.getBoughtQuantity());
                preparedStatement.setInt(2, cart_item.getProductId());

                if(preparedStatement.executeUpdate() > 0) {
                    System.out.println("Product: " + cart_item.getProductName() + " Quantity Updated.");
                }
            }

        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Fetch Single Product Information
    public Product getSingleProduct(int productId) {
        Product product = new Product();

        String SQL = "SELECT * FROM product JOIN category ON product.category_id = category.category_id WHERE  product_id = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {

            preparedStatement.setInt(1, productId);
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                product.setProductId(resultSet.getInt(1));
                product.setCategoryId(resultSet.getInt(2));
                product.setProductName(resultSet.getString(3));
                product.setDescription(resultSet.getString(4));
                product.setPrice(resultSet.getDouble(5));
                product.setQuantity(resultSet.getInt(6));
                product.setCategoryName(resultSet.getString(10));
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return product;
    }

    //Fetching product items for a specific category,
    public List<Product> getProducts(Category category) {
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
            throw new RuntimeException("An error occurred while fetching products from the database.");
        }
        return productList;
    }

    // Fetching All products
    public List<Product> getAllProducts() {
        String SQL = "SELECT product.product_id, " +
                            "product.product_name, " +
                            "images.image_name, " +
                            "category.category_type, " +
                            "product.quantity, " +
                            "product.price " +
                    "FROM product JOIN category " +
                    "ON product.category_id = category.category_id " +
                    "JOIN images ON product.image_id = images.image_id";

        List<Product> productList = new ArrayList<>();
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while(resultSet.next()) {
                Product product = new Product();
                product.setProductId(resultSet.getInt("product_id"));
                product.setProductName(resultSet.getString("product_name"));
                product.setImageName(resultSet.getString("image_name"));
                product.setCategoryName(resultSet.getString("category_type"));
                product.setQuantity(resultSet.getInt("quantity"));
                product.setPrice(resultSet.getDouble("price"));

                productList.add(product);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return productList;
    }

    //Fetching Product items for cart.
    public List<CartItem> getForCart(List<CartItem> cartItemList) {
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
                throw new RuntimeException("An error occurred while fetching product info from the database.");
            }
        }
        return cartItems;
    }

    public double getCartAmount(List<CartItem> cartItemList) {
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
            throw new RuntimeException("An error occurred while calculating cart amount.");
        }
        return totalAmount;
    }
}
