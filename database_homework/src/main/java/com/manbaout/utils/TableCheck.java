package com.manbaout.utils;

import java.sql.*;

public class TableCheck {
    public static void main(String[] args) {
        try (Connection conn = DatabaseUtil.getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "students", new String[]{"TABLE"});
            if (tables.next()) {
                System.out.println("Table 'students' exists.");
                // 查询表结构
                ResultSet columns = meta.getColumns(null, null, "students", null);
                System.out.println("Columns:");
                while (columns.next()) {
                    String columnName = columns.getString("COLUMN_NAME");
                    String columnType = columns.getString("TYPE_NAME");
                    int columnSize = columns.getInt("COLUMN_SIZE");
                    System.out.println("  " + columnName + " " + columnType + "(" + columnSize + ")");
                }
                columns.close();
            } else {
                System.out.println("Table 'students' does not exist.");
                // 创建表
                Statement stmt = conn.createStatement();
                String sql = "CREATE TABLE students (" +
                        "id SERIAL PRIMARY KEY," +
                        "name VARCHAR(100) NOT NULL," +
                        "age INTEGER NOT NULL," +
                        "email VARCHAR(100)," +
                        "created_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP" +
                        ")";
                stmt.executeUpdate(sql);
                System.out.println("Table 'students' created successfully.");
            }
            tables.close();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
}
