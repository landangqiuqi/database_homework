<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>学生管理系统 - OpenGauss数据库作业</title>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background-color: #f5f7fa;
            color: #333;
            line-height: 1.6;
            padding: 20px;
        }
        
        .container {
            max-width: 1200px;
            margin: 0 auto;
            background: white;
            border-radius: 12px;
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.08);
            overflow: hidden;
        }
        
        header {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
            padding: 30px 40px;
            border-bottom: 5px solid #5a67d8;
        }
        
        header h1 {
            font-size: 2.5rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            gap: 15px;
        }
        
        header h1 i {
            font-size: 2.2rem;
        }
        
        .subtitle {
            font-size: 1.1rem;
            opacity: 0.9;
            margin-bottom: 5px;
        }
        
        .database-info {
            background: rgba(255, 255, 255, 0.15);
            padding: 12px 20px;
            border-radius: 8px;
            margin-top: 15px;
            display: inline-block;
            font-size: 0.9rem;
        }
        
        .content {
            padding: 40px;
        }
        
        .section {
            margin-bottom: 40px;
            padding: 25px;
            background: #f8fafc;
            border-radius: 10px;
            border-left: 5px solid #667eea;
        }
        
        .section-title {
            font-size: 1.5rem;
            color: #4a5568;
            margin-bottom: 20px;
            padding-bottom: 10px;
            border-bottom: 2px solid #e2e8f0;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .form-group {
            margin-bottom: 20px;
        }
        
        .form-row {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }
        
        .form-col {
            flex: 1;
            min-width: 200px;
        }
        
        label {
            display: block;
            margin-bottom: 8px;
            font-weight: 600;
            color: #4a5568;
        }
        
        input[type="text"],
        input[type="number"],
        input[type="email"] {
            width: 100%;
            padding: 12px 15px;
            border: 2px solid #e2e8f0;
            border-radius: 8px;
            font-size: 1rem;
            transition: all 0.3s;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
            box-shadow: 0 0 0 3px rgba(102, 126, 234, 0.1);
        }
        
        .btn {
            padding: 12px 24px;
            border: none;
            border-radius: 8px;
            font-size: 1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(102, 126, 234, 0.4);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }
        
        .btn-danger:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(245, 101, 101, 0.4);
        }
        
        .btn-warning {
            background: linear-gradient(135deg, #ed8936 0%, #dd6b20 100%);
            color: white;
        }
        
        .btn-warning:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(237, 137, 54, 0.4);
        }
        
        .btn-success {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }
        
        .btn-success:hover {
            transform: translateY(-2px);
            box-shadow: 0 5px 15px rgba(72, 187, 120, 0.4);
        }
        
        .btn-sm {
            padding: 6px 12px;
            font-size: 0.875rem;
        }
        
        .table-container {
            overflow-x: auto;
            border-radius: 8px;
            border: 1px solid #e2e8f0;
        }
        
        table {
            width: 100%;
            border-collapse: collapse;
            min-width: 800px;
        }
        
        th {
            background: #f7fafc;
            padding: 16px;
            text-align: left;
            font-weight: 600;
            color: #4a5568;
            border-bottom: 2px solid #e2e8f0;
        }
        
        td {
            padding: 16px;
            border-bottom: 1px solid #e2e8f0;
        }
        
        tr:hover {
            background: #f8fafc;
        }
        
        .actions {
            display: flex;
            gap: 8px;
            flex-wrap: wrap;
        }
        
        .message {
            padding: 15px;
            border-radius: 8px;
            margin-bottom: 20px;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        .error {
            background: #fff5f5;
            border: 1px solid #feb2b2;
            color: #c53030;
        }
        
        .success {
            background: #f0fff4;
            border: 1px solid #9ae6b4;
            color: #276749;
        }
        
        .search-box {
            display: flex;
            gap: 10px;
            margin-bottom: 20px;
        }
        
        .search-box input {
            flex: 1;
        }
        
        .stats {
            display: flex;
            gap: 20px;
            margin-bottom: 30px;
        }
        
        .stat-card {
            flex: 1;
            background: white;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 4px 6px rgba(0, 0, 0, 0.05);
            border-top: 4px solid #667eea;
            text-align: center;
        }
        
        .stat-number {
            font-size: 2.5rem;
            font-weight: 700;
            color: #667eea;
            margin: 10px 0;
        }
        
        .stat-label {
            font-size: 0.9rem;
            color: #718096;
            text-transform: uppercase;
            letter-spacing: 1px;
        }
        
        footer {
            text-align: center;
            padding: 20px;
            color: #718096;
            font-size: 0.9rem;
            border-top: 1px solid #e2e8f0;
            margin-top: 40px;
        }
        
        @media (max-width: 768px) {
            .content {
                padding: 20px;
            }
            
            .form-row {
                flex-direction: column;
            }
            
            .stats {
                flex-direction: column;
            }
            
            header h1 {
                font-size: 2rem;
            }
        }
    </style>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
</head>
<body>
    <div class="container">
        <header>
            <h1>
                <i class="fas fa-graduation-cap"></i>
                学生管理系统
            </h1>
            <p class="subtitle">基于OpenGauss数据库的三层架构Java Web应用</p>
            <div class="database-info">
                <i class="fas fa-database"></i> 数据库: OpenGauss | 
                <i class="fas fa-layer-group"></i> 架构: Model-DAO-Service-Controller |
                <i class="fas fa-code"></i> 技术栈: Java Servlet, JSP, JDBC, HikariCP
            </div>
        </header>
        
        <div class="content">
            <c:if test="${not empty error}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <div class="stats">
                <div class="stat-card">
                    <div class="stat-label">学生总数</div>
                    <div class="stat-number">${not empty students ? students.size() : 0}</div>
                    <i class="fas fa-users fa-2x" style="color: #667eea;"></i>
                </div>
                <div class="stat-card">
                    <div class="stat-label">数据源</div>
                    <div class="stat-number">OpenGauss</div>
                    <i class="fas fa-server fa-2x" style="color: #48bb78;"></i>
                </div>
                <div class="stat-card">
                    <div class="stat-label">连接池</div>
                    <div class="stat-number">HikariCP</div>
                    <i class="fas fa-bolt fa-2x" style="color: #ed8936;"></i>
                </div>
            </div>
            
            <div class="section">
                <h2 class="section-title">
                    <i class="fas fa-search"></i> 搜索学生
                </h2>
                <form action="students" method="get" class="search-box">
                    <input type="hidden" name="action" value="search">
                    <input type="text" name="name" placeholder="输入学生姓名进行搜索..." 
                           value="${searchName}" required>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-search"></i> 搜索
                    </button>
                    <a href="students?action=list" class="btn btn-success">
                        <i class="fas fa-redo"></i> 显示全部
                    </a>
                </form>
            </div>
            
            <div class="section">
                <h2 class="section-title">
                    <i class="fas fa-plus-circle"></i> 添加新学生
                </h2>
                <form action="students" method="post">
                    <input type="hidden" name="action" value="add">
                    <div class="form-row">
                        <div class="form-col">
                            <label for="name"><i class="fas fa-user"></i> 姓名 *</label>
                            <input type="text" id="name" name="name" placeholder="请输入学生姓名" required>
                        </div>
                        <div class="form-col">
                            <label for="age"><i class="fas fa-birthday-cake"></i> 年龄 *</label>
                            <input type="number" id="age" name="age" placeholder="请输入年龄" min="1" max="150" required>
                        </div>
                        <div class="form-col">
                            <label for="email"><i class="fas fa-envelope"></i> 邮箱 *</label>
                            <input type="email" id="email" name="email" placeholder="请输入邮箱地址" required>
                        </div>
                    </div>
                    <button type="submit" class="btn btn-primary">
                        <i class="fas fa-user-plus"></i> 添加学生
                    </button>
                </form>
            </div>
            
            <div class="section">
                <h2 class="section-title">
                    <i class="fas fa-list"></i> 学生列表
                </h2>
                <c:choose>
                    <c:when test="${not empty students && students.size() > 0}">
                        <div class="table-container">
                            <table>
                                <thead>
                                    <tr>
                                        <th>ID</th>
                                        <th>姓名</th>
                                        <th>年龄</th>
                                        <th>邮箱</th>
                                        <th>创建时间</th>
                                        <th>操作</th>
                                    </tr>
                                </thead>
                                <tbody>
                                    <c:forEach var="student" items="${students}">
                                        <tr>
                                            <td>${student.id}</td>
                                            <td><strong>${student.name}</strong></td>
                                            <td>${student.age}</td>
                                            <td>${student.email}</td>
                                            <td>${student.createdTime}</td>
                                            <td class="actions">
                                                <a href="students?action=edit&id=${student.id}" 
                                                   class="btn btn-warning btn-sm">
                                                    <i class="fas fa-edit"></i> 编辑
                                                </a>
                                                <a href="students?action=delete&id=${student.id}" 
                                                   class="btn btn-danger btn-sm"
                                                   onclick="return confirm('确定要删除学生 ${student.name} 吗？')">
                                                    <i class="fas fa-trash"></i> 删除
                                                </a>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </tbody>
                            </table>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <div class="message">
                            <i class="fas fa-info-circle"></i>
                            没有找到学生记录。请添加学生或调整搜索条件。
                        </div>
                    </c:otherwise>
                </c:choose>
            </div>
            
            <div class="section">
                <h2 class="section-title">
                    <i class="fas fa-info-circle"></i> 系统信息
                </h2>
                <div class="form-row">
                    <div class="form-col">
                        <h3><i class="fas fa-cogs"></i> 作业要求已完成</h3>
                        <ul style="list-style-type: none; padding-left: 0;">
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> StudentDAOImpl.java - delete方法</li>
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> StudentDAOImpl.java - update方法</li>
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> StudentDAOImpl.java - findByName方法</li>
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> StudentServiceImpl.java - 对应的业务方法</li>
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> 三层架构完整实现</li>
                            <li><i class="fas fa-check-circle" style="color: #48bb78;"></i> Web界面增删改查功能</li>
                        </ul>
                    </div>
                    <div class="form-col">
                        <h3><i class="fas fa-code-branch"></i> 技术栈</h3>
                        <ul style="list-style-type: none; padding-left: 0;">
                            <li><i class="fas fa-database" style="color: #667eea;"></i> OpenGauss数据库</li>
                            <li><i class="fas fa-coffee" style="color: #ed8936;"></i> Java 11 + Maven</li>
                            <li><i class="fas fa-layer-group" style="color: #9f7aea;"></i> 三层架构 (Model-DAO-Service)</li>
                            <li><i class="fas fa-globe" style="color: #38a169;"></i> Java Web (Servlet + JSP)</li>
                            <li><i class="fas fa-tachometer-alt" style="color: #f56565;"></i> HikariCP连接池</li>
                            <li><i class="fas fa-shield-alt" style="color: #4299e1;"></i> PreparedStatement防SQL注入</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <footer>
            <p>
                <i class="fas fa-university"></i> 数据库课程作业 - 学生管理系统 
                | 基于OpenGauss数据库的三层架构Java Web实现
                | <i class="fas fa-heart" style="color: #f56565;"></i> 使用Java + Servlet + JSP开发
            </p>
            <p style="font-size: 0.8rem; margin-top: 10px; opacity: 0.7;">
                技术栈: OpenGauss JDBC 6.0.2 | HikariCP 5.0.1 | Java Servlet 4.0.1 | JSP 2.3.3
            </p>
        </footer>
    </div>
    
    <script>
        // 表单验证
        document.addEventListener('DOMContentLoaded', function() {
            const forms = document.querySelectorAll('form');
            forms.forEach(form => {
                form.addEventListener('submit', function(e) {
                    const requiredInputs = form.querySelectorAll('input[required]');
                    let valid = true;
                    
                    requiredInputs.forEach(input => {
                        if (!input.value.trim()) {
                            valid = false;
                            input.style.borderColor = '#f56565';
                            input.focus();
                        } else {
                            input.style.borderColor = '#e2e8f0';
                        }
                    });
                    
                    if (!valid) {
                        e.preventDefault();
                        alert('请填写所有必填字段！');
                    }
                });
            });
            
            // 搜索框回车键搜索
            const searchInput = document.querySelector('input[name="name"]');
            if (searchInput) {
                searchInput.addEventListener('keypress', function(e) {
                    if (e.key === 'Enter') {
                        e.preventDefault();
                        this.form.submit();
                    }
                });
            }
        });
    </script>
</body>
</html>
