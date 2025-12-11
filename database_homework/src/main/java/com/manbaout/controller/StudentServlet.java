package com.manbaout.controller;

import com.manbaout.model.Student;
import com.manbaout.service.StudentService;
import com.manbaout.service.impl.StudentServiceImpl;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class StudentServlet extends HttpServlet {
    private StudentService studentService = new StudentServiceImpl();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应的字符编码为UTF-8，解决中文乱码问题
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "list":
                listStudents(request, response);
                break;
            case "edit":
                showEditForm(request, response);
                break;
            case "delete":
                deleteStudent(request, response);
                break;
            case "search":
                searchStudents(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // 设置请求和响应的字符编码为UTF-8，解决中文乱码问题
        request.setCharacterEncoding("UTF-8");
        response.setCharacterEncoding("UTF-8");
        response.setContentType("text/html;charset=UTF-8");
        
        String action = request.getParameter("action");
        
        if (action == null) {
            action = "list";
        }

        switch (action) {
            case "add":
                addStudent(request, response);
                break;
            case "update":
                updateStudent(request, response);
                break;
            default:
                listStudents(request, response);
                break;
        }
    }

    private void listStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        List<Student> students = studentService.getAllStudents();
        request.setAttribute("students", students);
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }

    private void addStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String email = request.getParameter("email");

        if (name == null || name.trim().isEmpty() ||
            ageStr == null || ageStr.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "所有字段都必须填写");
            listStudents(request, response);
            return;
        }

        try {
            int age = Integer.parseInt(ageStr);
            Student student = new Student(name, age, email);
            boolean success = studentService.addStudent(student);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/students?action=list");
            } else {
                request.setAttribute("error", "添加学生失败，请检查输入");
                listStudents(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "年龄必须是数字");
            listStudents(request, response);
        }
    }

    private void showEditForm(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/students?action=list");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            Student student = studentService.getStudentById(id);
            
            if (student == null) {
                response.sendRedirect(request.getContextPath() + "/students?action=list");
                return;
            }

            request.setAttribute("student", student);
            request.getRequestDispatcher("/edit.jsp").forward(request, response);
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/students?action=list");
        }
    }

    private void updateStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        String name = request.getParameter("name");
        String ageStr = request.getParameter("age");
        String email = request.getParameter("email");

        if (idStr == null || idStr.trim().isEmpty() ||
            name == null || name.trim().isEmpty() ||
            ageStr == null || ageStr.trim().isEmpty() ||
            email == null || email.trim().isEmpty()) {
            request.setAttribute("error", "所有字段都必须填写");
            listStudents(request, response);
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            int age = Integer.parseInt(ageStr);
            
            Student student = new Student(name, age, email);
            student.setId(id);
            
            boolean success = studentService.updateStudent(student);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/students?action=list");
            } else {
                request.setAttribute("error", "更新学生信息失败");
                listStudents(request, response);
            }
        } catch (NumberFormatException e) {
            request.setAttribute("error", "ID和年龄必须是数字");
            listStudents(request, response);
        }
    }

    private void deleteStudent(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String idStr = request.getParameter("id");
        
        if (idStr == null || idStr.trim().isEmpty()) {
            response.sendRedirect(request.getContextPath() + "/students?action=list");
            return;
        }

        try {
            int id = Integer.parseInt(idStr);
            boolean success = studentService.deleteStudent(id);
            
            if (success) {
                response.sendRedirect(request.getContextPath() + "/students?action=list");
            } else {
                request.setAttribute("error", "删除学生失败");
                listStudents(request, response);
            }
        } catch (NumberFormatException e) {
            response.sendRedirect(request.getContextPath() + "/students?action=list");
        }
    }

    private void searchStudents(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String name = request.getParameter("name");
        
        if (name == null || name.trim().isEmpty()) {
            listStudents(request, response);
            return;
        }

        List<Student> students = studentService.searchStudentsByName(name.trim());
        request.setAttribute("students", students);
        request.setAttribute("searchName", name.trim());
        request.getRequestDispatcher("/index.jsp").forward(request, response);
    }
}
