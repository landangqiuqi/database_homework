package com.manbaout.listener;

import com.manbaout.utils.DatabaseUtil;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.sql.*;

public class DBInitializerListener implements ServletContextListener {
    
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("DBInitializerListener: Checking and creating database table if needed...");
        try (Connection conn = DatabaseUtil.getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "STUDENTS", new String[]{"TABLE"});
            if (!tables.next()) {
                System.out.println("DBInitializerListener: Table 'students' does not exist, creating...");
                Statement stmt = conn.createStatement();
                String sql = "CREATE TABLE students (" +
                        "id SERIAL PRIMARY KEY," +
                        "name VARCHAR(100) NOT NULL," +
                        "age INTEGER NOT NULL," +
                        "email VARCHAR(100)," +
                        "created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ")";
                stmt.executeUpdate(sql);
                System.out.println("DBInitializerListener: Table 'students' created successfully.");
            } else {
                System.out.println("DBInitializerListener: Table 'students' already exists.");
            }
            tables.close();
        } catch (SQLException e) {
            e.printStackTrace();
            System.err.println("DBInitializerListener: Failed to create table: " + e.getMessage());
        }
    }
    
    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        // Cleanup if needed
    }
}
