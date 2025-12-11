// src/main/java/com/manbaout/dao/impl/StudentDAOImpl.java
package com.manbaout.dao.impl;

import com.manbaout.dao.StudentDAO;
import com.manbaout.model.Student;
import com.manbaout.utils.DatabaseUtil;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class StudentDAOImpl implements StudentDAO {
    
    @Override
    public int insert(Student student) {
        String sql = "INSERT INTO students (name, age, email) VALUES (?, ?, ?)";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS)) {
            
            pstmt.setString(1, student.getName());
            pstmt.setInt(2, student.getAge());
            pstmt.setString(3, student.getEmail());
            
            int rows = pstmt.executeUpdate();
            
            // 获取自增ID
            try (ResultSet rs = pstmt.getGeneratedKeys()) {
                if (rs.next()) {
                    student.setId(rs.getInt(1));
                }
            }
            return rows;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    @Override
    public Student findById(Integer id) {
        String sql = "SELECT * FROM students WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            ResultSet rs = pstmt.executeQuery();
            
            if (rs.next()) {
                return mapResultSetToStudent(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }
    
    @Override
    public List<Student> findAll() {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students ORDER BY id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             Statement stmt = conn.createStatement();
             ResultSet rs = stmt.executeQuery(sql)) {
            
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
    
    private Student mapResultSetToStudent(ResultSet rs) throws SQLException {
        Student student = new Student();
        student.setId(rs.getInt("id"));
        student.setName(rs.getString("name"));
        student.setAge(rs.getInt("age"));
        student.setEmail(rs.getString("email"));
        student.setCreatedTime(rs.getTimestamp("created_time"));
        return student;
    }
    
    @Override
    public int delete(Integer id) {
        String sql = "DELETE FROM students WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setInt(1, id);
            int rows = pstmt.executeUpdate();
            return rows;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    @Override
    public int update(Student student) {
        String sql = "UPDATE students SET name = ?, age = ?, email = ? WHERE id = ?";
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, student.getName());
            pstmt.setInt(2, student.getAge());
            pstmt.setString(3, student.getEmail());
            pstmt.setInt(4, student.getId());
            
            int rows = pstmt.executeUpdate();
            return rows;
        } catch (SQLException e) {
            e.printStackTrace();
            return 0;
        }
    }
    
    @Override
    public List<Student> findByName(String name) {
        List<Student> students = new ArrayList<>();
        String sql = "SELECT * FROM students WHERE name LIKE ? ORDER BY id";
        
        try (Connection conn = DatabaseUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            
            pstmt.setString(1, "%" + name + "%");
            ResultSet rs = pstmt.executeQuery();
            
            while (rs.next()) {
                students.add(mapResultSetToStudent(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return students;
    }
}
