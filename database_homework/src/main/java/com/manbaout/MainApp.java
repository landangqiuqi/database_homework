package com.manbaout;

import com.manbaout.model.Student;
import com.manbaout.service.StudentService;
import com.manbaout.service.impl.StudentServiceImpl;
import java.util.List;  // 确保导入了List

public class MainApp {
    public static void main(String[] args) {
        System.out.println("=== 三层架构数据库作业测试 ===");
        
        StudentService studentService = new StudentServiceImpl();
        
        // 测试1：添加学生
        System.out.println("\n1. 测试添加学生:");
        Student newStudent = new Student("测试学生", 20, "test@example.com");
        boolean success = studentService.addStudent(newStudent);
        System.out.println("添加结果: " + (success ? "成功" : "失败"));
        if (success) {
            System.out.println("生成的学生ID: " + newStudent.getId());
        }
        
        // 测试2：查询所有学生
        System.out.println("\n2. 查询所有学生:");
        List<Student> students = studentService.getAllStudents();  // 修改这里
        if (students.isEmpty()) {
            System.out.println("没有学生记录");
        } else {
            System.out.println("共有 " + students.size() + " 名学生:");
            for (Student s : students) {
                System.out.println("  " + s);
            }
        }
        
        // 测试3：按ID查询
        System.out.println("\n3. 按ID查询学生:");
        if (newStudent.getId() != null) {
            Student found = studentService.getStudentById(newStudent.getId());
            System.out.println("查询结果: " + (found != null ? found : "未找到"));
        }
        
        System.out.println("\n=== 测试完成 ===");
        System.out.println("作业待完成部分:");
        System.out.println("1. 实现StudentDAO中的delete、update、findByName方法");
        System.out.println("2. 实现StudentServiceImpl中的对应业务方法");
        System.out.println("3. 可以添加更多业务逻辑验证");
    }
}