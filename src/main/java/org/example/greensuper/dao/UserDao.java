package org.example.greensuper.dao;

import org.example.greensuper.models.Customer;
import org.example.greensuper.models.Feedback;
import org.example.greensuper.utils.DecryptionUtil;

import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class UserDao {
    //User Registration
    public boolean registerUser(Customer customer) {

        // Storing Customer basic details.
        String SQL = """
                INSERT INTO customers (first_name, last_name, email, phone_number)
                VALUES (?, ?, ?, ?)
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement statement = connection.prepareStatement(SQL, Statement.RETURN_GENERATED_KEYS)) {
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
                        String SQL_Password = """
                                INSERT INTO customer_passwords (customer_id, hashed_password)
                                VALUES (?, ?)
                                """;
                        try(PreparedStatement insertPassword = connection.prepareStatement(SQL_Password)) {
                            insertPassword.setInt(1, customerID);
                            insertPassword.setString(2, customer.getPassword());

                            if(insertPassword.executeUpdate() > 0) {

                                // Storing Customer Address.
                                String SQL_Address = """
                                        INSERT INTO customer_address (customer_id, city, street, home_number)
                                        VALUES (?, ?, ?, ?)
                                        """;
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

        String SQL = """
                SELECT cus_pass.hashed_password
                FROM customer_passwords cus_pass
                JOIN customers c ON cus_pass.customer_id = c.customer_id
                WHERE c.email = ?
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(SQL)) {
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

    //Fetching All Customer details
    public List<Customer> fetchAllCustomers() {
        List<Customer> customerList = new ArrayList<>();

        String SQL = """
                SELECT *
                FROM customers cus
                JOIN customer_address cus_addr ON cus.customer_id = cus_addr.customer_id
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Customer customer = new Customer();

                customer.setCustomerId(resultSet.getInt(1));
                customer.setFirstName(resultSet.getString(2));
                customer.setLastName(resultSet.getString(3));
                customer.setEmail(resultSet.getString(4));
                customer.setPhoneNumber(resultSet.getString(5));
                customer.setHomeNumber(resultSet.getString(10));
                customer.setStreetName(resultSet.getString(9));
                customer.setCity(resultSet.getString(8));

                customerList.add(customer);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return customerList;
    }

    //Fetching a specific user details from the database.
    public Customer getUserDetails(String email) {

        String SQL = """
                SELECT *
                FROM customers
                JOIN customer_address ON customers.customer_id = customer_address.customer_id
                WHERE customers.email = ?
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
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

    //Counting all the users counts in the database.
    public int getUserCount() {

        String SQL = "SELECT COUNT(*) FROM customers";
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();
            if(resultSet.next()) {
                return resultSet.getInt(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return 0;
    }

    // True when feedback was already left for this bill. Used by FeedbackServlet.
    public boolean hasFeedbackForBill(int billId) {
        String SQL = """
                SELECT 1
                FROM customer_feedbacks
                WHERE bill_id = ?
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, billId);
            try (ResultSet resultSet = preparedStatement.executeQuery()) {
                return resultSet.next();
            }
        } catch (SQLException e) {
            throw new RuntimeException("An error occurred while checking existing feedback.", e);
        }
    }

    //Adding customer feedback to the database.
    public boolean addCustomerFeedback(Feedback feedback) {
        LocalDate localDate = LocalDate.now();

        String SQL = """
                INSERT INTO customer_feedbacks (customer_id, bill_id, feedback, feedback_date)
                VALUES (?, ?, ?, ?)
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            preparedStatement.setInt(1, feedback.getCustomer_id());
            preparedStatement.setInt(2, feedback.getBill_id());
            preparedStatement.setString(3, feedback.getFeedback());
            preparedStatement.setDate(4, Date.valueOf(localDate));

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

        String SQL = """
                SELECT
                    cus.first_name,
                    cus.last_name,
                    cus_f.bill_id,
                    cus_f.feedback_date,
                    cus_f.feedback
                FROM customer_feedbacks cus_f
                JOIN customers cus ON cus_f.customer_id = cus.customer_id
                """;
        try (Connection connection = DBConnection.getConnection();
             PreparedStatement preparedStatement = connection.prepareStatement(SQL)) {
            ResultSet resultSet = preparedStatement.executeQuery();

            while (resultSet.next()) {
                Feedback feedback = new Feedback();
                feedback.setCustomer_name(
                        resultSet.getString("first_name") + " " + resultSet.getString("last_name"));
                feedback.setBill_id(resultSet.getInt("bill_id"));
                feedback.setFeedback__date(resultSet.getDate("feedback_date").toLocalDate());
                feedback.setFeedback(resultSet.getString("feedback"));

                feedbackList.add(feedback);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return feedbackList;
    }
}
