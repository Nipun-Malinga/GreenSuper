package org.example.greensuper.dao;

import org.example.greensuper.models.Customer;
import org.example.greensuper.models.Feedback;
import org.example.greensuper.utils.DecryptionUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    Connection connection = DBConnection.getConnection();

    //User Registration
    public boolean registerUser(Customer customer) {

        // Storing Customer basic details.
        String SQL = "INSERT INTO customer (first_name, last_name, email, phone_number) VALUES (?, ?, ?, ?)";
        try(PreparedStatement statement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
            statement.setString(1, customer.getFirstName());
            statement.setString(2, customer.getLastName());
            statement.setString(3, customer.getEmail());
            statement.setString(4, customer.getPhoneNumber());

            if(statement.executeUpdate() > 0) {

                //Generating the customer id for above data insertion.
                try(ResultSet generatedKey = statement.getGeneratedKeys()) {
                    if(generatedKey.next()) {
                        int customerID = generatedKey.getInt(1);
                        System.out.println(customerID);

                        // Storing Customer Password.
                        String SQL_Password = "INSERT INTO customer_passwords (customer_id, hashed_password) VALUES (?, ?)";
                        try(PreparedStatement insertPassword = connection.prepareStatement(SQL_Password)) {
                            insertPassword.setInt(1, customerID);
                            insertPassword.setString(2, customer.getPassword());

                            if(insertPassword.executeUpdate() > 0) {

                                // Storing Customer Address.
                                String SQL_Address = "INSERT INTO customer_address (customer_id, city, street, home_number) VALUES (?, ?, ?, ?)";
                                try(PreparedStatement insertAddress = connection.prepareStatement(SQL_Address)) {
                                    insertAddress.setInt(1, customerID);
                                    insertAddress.setString(2, customer.getCity());
                                    insertAddress.setString(3, customer.getStreetName());
                                    insertAddress.setString(4, customer.getHomeNumber());

                                    if(insertAddress.executeUpdate() > 0) {
                                        return true;
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
        catch (SQLException ex) {
            throw new RuntimeException("An error accord while registering user into the database.");
        }
        return false;
    }

    //User login
    public boolean userLogin(Customer customer) {
        DecryptionUtil decryptionUtil = new DecryptionUtil();

        String SQL = "SELECT cus_pass.hashed_password FROM customer_passwords cus_pass JOIN customer c ON cus_pass.customer_id = c.customer_id WHERE c.email = ?";
        try(PreparedStatement ps = connection.prepareStatement(SQL)) {
            ps.setString(1, customer.getEmail());

            ResultSet resultSet = ps.executeQuery();

            if (resultSet.next() &&  decryptionUtil.isPasswordMatch(customer.getPassword(), resultSet.getString("hashed_password"))) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    //Fetching a specific user details from the database.
    public Customer getUserDetails(String email) {

        String SQL = "SELECT * FROM customer JOIN customer_address ON customer.customer_id = customer_address.customer_id WHERE customer.email = ?";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setString(1, email);

            ResultSet resultSet = preparedStatement.executeQuery();
            Customer customer = new Customer();
            while (resultSet.next()) {
                customer.setCustomerId(resultSet.getInt(1));
                customer.setFirstName(resultSet.getString(2));
                customer.setLastName(resultSet.getString(3));
                customer.setEmail(resultSet.getString(4));
                customer.setPhoneNumber(resultSet.getString(5));
                customer.setCity(resultSet.getString(8));
                customer.setStreetName(resultSet.getString(9));
                customer.setHomeNumber(resultSet.getString(10));
            }
            return customer;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }

    //Counting all the user count in the database.
    public int getUserCount() {

        String SQL = "SELECT COUNT(*) FROM customer";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    //Adding customer feedback to the database.
    public boolean addCustomerFeedback(Feedback feedback) {
        LocalDate localDate = LocalDate.now();

        String SQL = "INSERT INTO customer_feedback (customer_id, feedback, feedback_date) VALUES (?, ?, ?)";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, feedback.getCustomer_id());

//            preparedStatement.setInt(2, feedback.getBill_id());

            preparedStatement.setString(2, feedback.getFeedback());
            preparedStatement.setDate(3, Date.valueOf(localDate));

            if(preparedStatement.executeUpdate() > 0) {
                return true;
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    //Fetching all customer feedbacks.
    public List<Feedback> getAllCustomerFeedbacks() {
        List<Feedback> feedbackList = new ArrayList<>();

        String SQL = "SELECT * FROM customer_feedback";
        try(PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            if(resultSet.next()) {
                feedbackList.add(
                        new Feedback(
                                resultSet.getInt("feedback_id"),
                                resultSet.getInt("customer_id"),
                                resultSet.getString("feedback"),
                                resultSet.getDate("feedback_date").toLocalDate()
                        )
                );
            }
            return feedbackList;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
