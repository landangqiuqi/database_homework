// src/main/java/com/manbaout/service/impl/StudentServiceImpl.java
package com.manbaout.service.impl;

import com.manbaout.dao.StudentDAO;
import com.manbaout.dao.impl.StudentDAOImpl;
import com.manbaout.model.Student;
import com.manbaout.service.StudentService;
import java.util.List;

public class StudentServiceImpl implements StudentService {
    private StudentDAO studentDAO = new StudentDAOImpl();
    
    @Override
    public boolean addStudent(Student student) {
        // 业务逻辑验证
        if (student == null) {
            System.out.println("学生信息不能为空");
            return false;
        }
        if (student.getName() == null || student.getName().trim().isEmpty()) {
            System.out.println("学生姓名不能为空");
            return false;
        }
        if (student.getAge() == null || student.getAge() <= 0 || student.getAge() > 150) {
            System.out.println("年龄必须为1-150之间的有效数字");
            return false;
        }
        
        // 调用DAO层
        return studentDAO.insert(student) > 0;
    }
    
    @Override
    public Student getStudentById(Integer id) {
        if (id == null || id <= 0) {
            System.out.println("ID不能为空且必须大于0");
            return null;
        }
        return studentDAO.findById(id);
    }
    
    @Override
    public List<Student> getAllStudents() {
        return studentDAO.findAll();
    }
    
    // 其他方法（作业部分）
    @Override
    public boolean deleteStudent(Integer id) {
        if (id == null || id <= 0) {
            System.out.println("ID不能为空且必须大于0");
            return false;
        }
        int rows = studentDAO.delete(id);
        return rows > 0;
    }
    
    @Override
    public boolean updateStudent(Student student) {
        if (student == null) {
            System.out.println("学生信息不能为空");
            return false;
        }
        if (student.getId() == null || student.getId() <= 0) {
            System.out.println("学生ID不能为空且必须大于0");
            return false;
        }
        if (student.getName() == null || student.getName().trim().isEmpty()) {
            System.out.println("学生姓名不能为空");
            return false;
        }
        if (student.getAge() == null || student.getAge() <= 0 || student.getAge() > 150) {
            System.out.println("年龄必须为1-150之间的有效数字");
            return false;
        }
        int rows = studentDAO.update(student);
        return rows > 0;
    }
    
    @Override
    public List<Student> searchStudentsByName(String name) {
        if (name == null || name.trim().isEmpty()) {
            System.out.println("搜索姓名不能为空");
            return new java.util.ArrayList<>();
        }
        return studentDAO.findByName(name.trim());
    }
}
