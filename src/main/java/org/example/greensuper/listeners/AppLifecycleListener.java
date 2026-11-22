package org.example.greensuper.listeners;

import com.mysql.cj.jdbc.AbandonedConnectionCleanupThread;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;
import org.example.greensuper.dao.DBConnection;
import org.example.greensuper.seeders.AdminSeeder;

import java.sql.Driver;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Collections;

@WebListener
public class AppLifecycleListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        try {
            AdminSeeder.seed();
        } catch (RuntimeException e) {
            // A seeding failure (e.g. schema not imported yet) shouldn't stop the app from starting.
            System.err.println("AdminSeeder: failed to seed the initial admin: " + e);
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        DBConnection.closePool();
        releaseMysqlDriver();
    }

    /**
     * The MySQL driver ships inside the WAR, so on undeploy it must be deregistered and its
     * cleanup thread stopped; otherwise Tomcat reports a memory leak on every redeploy.
     */
    private void releaseMysqlDriver() {
        ClassLoader webappLoader = Thread.currentThread().getContextClassLoader();
        for (Driver driver : Collections.list(DriverManager.getDrivers())) {
            if (driver.getClass().getClassLoader() == webappLoader) {
                try {
                    DriverManager.deregisterDriver(driver);
                } catch (SQLException e) {
                    System.err.println("Could not deregister JDBC driver " + driver + ": " + e);
                }
            }
        }
        AbandonedConnectionCleanupThread.checkedShutdown();
    }
}
