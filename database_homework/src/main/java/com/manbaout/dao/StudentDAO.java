// src/main/java/com/manbaout/dao/StudentDAO.java
package com.manbaout.dao;

import com.manbaout.model.Student;
import java.util.List;

public interface StudentDAO {
    // 增
    int insert(Student student);
    
    // 删
    int delete(Integer id);
    
    // 改
    int update(Student student);
    
    // 查
    Student findById(Integer id);
    List<Student> findAll();
    List<Student> findByName(String name);
}