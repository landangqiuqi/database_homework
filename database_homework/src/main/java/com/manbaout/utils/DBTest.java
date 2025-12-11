package com.manbaout.utils;

import java.sql.Connection;
import java.sql.DriverManager;

public class DBTest {
    public static void main(String[] args) {
        String url = "jdbc:opengauss://192.168.100.31:26000/homework_test";
        String user = "remote_user";
        String password = "Remote@123";
        
        try {
            Class.forName("org.opengauss.Driver");
            Connection conn = DriverManager.getConnection(url, user, password);
            System.out.println("✅ OpenGauss 数据库连接成功！");
            conn.close();
        } catch (Exception e) {
            System.out.println("❌ 数据库连接失败: " + e.getMessage());
            e.printStackTrace();
        }
    }
}