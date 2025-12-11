// src/main/java/com/manbaout/service/StudentService.java
package com.manbaout.service;

import com.manbaout.model.Student;
import java.util.List;

public interface StudentService {
    // 添加学生（带业务逻辑检查）
    boolean addStudent(Student student);
    
    // 删除学生
    boolean deleteStudent(Integer id);
    
    // 更新学生信息
    boolean updateStudent(Student student);
    
    // 查询学生
    Student getStudentById(Integer id);
    List<Student> getAllStudents();
    List<Student> searchStudentsByName(String name);
}