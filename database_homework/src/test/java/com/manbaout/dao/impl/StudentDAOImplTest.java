package com.manbaout.dao.impl;

import com.manbaout.model.Student;
import com.manbaout.utils.DatabaseUtil;
import org.junit.BeforeClass;
import org.junit.Test;
import java.sql.*;
import java.util.List;
import static org.junit.Assert.*;

public class StudentDAOImplTest {
    private StudentDAOImpl dao = new StudentDAOImpl();

    @BeforeClass
    public static void createTableIfNotExists() throws SQLException {
        try (Connection conn = DatabaseUtil.getConnection()) {
            DatabaseMetaData meta = conn.getMetaData();
            ResultSet tables = meta.getTables(null, null, "students", new String[]{"TABLE"});
            if (!tables.next()) {
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
        }
    }

    @Test
    public void testFindById() {
        // 假设存在id=1的学生
        Student student = dao.findById(1);
        if (student != null) {
            System.out.println("Found student: " + student.getName());
            assertNotNull(student);
        } else {
            System.out.println("No student with id=1");
        }
    }

    @Test
    public void testFindAll() {
        List<Student> students = dao.findAll();
        System.out.println("Total students: " + students.size());
        for (Student s : students) {
            System.out.println(s);
        }
    }

    @Test
    public void testFindByName() {
        List<Student> students = dao.findByName("张");
        System.out.println("Students with name containing '张': " + students.size());
        for (Student s : students) {
            System.out.println(s);
        }
    }

    @Test
    public void testInsert() {
        Student student = new Student();
        student.setName("测试学生");
        student.setAge(20);
        student.setEmail("test@example.com");
        int rows = dao.insert(student);
        System.out.println("Inserted rows: " + rows);
        System.out.println("Generated ID: " + student.getId());
        assertTrue(rows > 0);
    }

    @Test
    public void testUpdate() {
        // 先插入一个学生，然后更新
        Student student = new Student();
        student.setName("更新前");
        student.setAge(18);
        student.setEmail("before@example.com");
        dao.insert(student);
        System.out.println("Inserted student id: " + student.getId());

        student.setName("更新后");
        student.setAge(19);
        student.setEmail("after@example.com");
        int rows = dao.update(student);
        System.out.println("Updated rows: " + rows);
        assertEquals(1, rows);
    }

    @Test
    public void testDelete() {
        // 先插入一个学生，然后删除
        Student student = new Student();
        student.setName("待删除");
        student.setAge(22);
        student.setEmail("delete@example.com");
        dao.insert(student);
        int id = student.getId();
        System.out.println("Student to delete id: " + id);

        int rows = dao.delete(id);
        System.out.println("Deleted rows: " + rows);
        assertEquals(1, rows);
    }
}
