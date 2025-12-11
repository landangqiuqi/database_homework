// src/main/java/com/manbaout/utils/DatabaseUtil.java
package com.manbaout.utils;

import com.zaxxer.hikari.HikariConfig;
import com.zaxxer.hikari.HikariDataSource;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.Properties;

public class DatabaseUtil {
    private static HikariDataSource dataSource;
    
    static {
        initDataSource();
    }
    
    public static Connection getConnection() throws SQLException {
        if (dataSource == null) {
            initDataSource();
        }
        return dataSource.getConnection();
    }
    
    private static synchronized void initDataSource() {
        if (dataSource != null) {
            return;
        }
        try {
            Properties props = new Properties();
            InputStream input = DatabaseUtil.class.getClassLoader()
                .getResourceAsStream("db.properties");
            if (input == null) {
                throw new RuntimeException("无法找到db.properties文件");
            }
            props.load(input);
            
            HikariConfig config = new HikariConfig();
            config.setJdbcUrl(props.getProperty("db.url"));
            config.setUsername(props.getProperty("db.username"));
            config.setPassword(props.getProperty("db.password"));
            config.setMaximumPoolSize(
                Integer.parseInt(props.getProperty("db.pool.size", "10")));
            config.setDriverClassName(props.getProperty("db.driver"));
            
            dataSource = new HikariDataSource(config);
            System.out.println("✅ 数据库连接池初始化成功");
        } catch (Exception e) {
            System.err.println("❌ 数据库连接池初始化失败: " + e.getMessage());
            e.printStackTrace();
            throw new RuntimeException("数据库连接池初始化失败", e);
        }
    }
    
    public static void closeConnection(Connection conn) {
        if (conn != null) {
            try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
        }
    }
}
