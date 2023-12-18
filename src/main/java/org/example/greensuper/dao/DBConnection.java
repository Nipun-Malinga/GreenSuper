package org.example.greensuper.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = "jdbc:mysql://127.0.0.1:3307/green_super_database";
    private static final String USER = "root";
    private static final String Password = "";

    private static Connection connection = null;
    public static Connection getConnection() {
        if(connection == null)
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                connection = DriverManager.getConnection(URL, USER, Password);
            } catch (SQLException ex) {
                throw new RuntimeException("Could not able to Connect to the SQL server");
            } catch (ClassNotFoundException ex) {
                throw new RuntimeException("JDBC Class Not Found.");
            }
        return connection;
    }
}
