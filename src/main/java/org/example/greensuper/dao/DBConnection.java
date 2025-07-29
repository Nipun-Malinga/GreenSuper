package org.example.greensuper.dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {
    private static final String URL = System.getenv("DB_URL");
    private static final String USER = System.getenv("DB_USER");
    private static final String Password = System.getenv("DB_PASS");
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
