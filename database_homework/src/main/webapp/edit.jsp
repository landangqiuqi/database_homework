<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>编辑学生 - 学生管理系统</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css">
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }
        
        body {
            background: linear-gradient(135deg, #667eea 0%, #764ba2 100%);
            min-height: 100vh;
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 20px;
        }
        
        .edit-container {
            background: white;
            border-radius: 16px;
            box-shadow: 0 20px 60px rgba(0, 0, 0, 0.3);
            width: 100%;
            max-width: 600px;
            overflow: hidden;
        }
        
        .edit-header {
            background: linear-gradient(135deg, #4c51bf 0%, #5a67d8 100%);
            color: white;
            padding: 30px;
            text-align: center;
            border-bottom: 5px solid #434190;
        }
        
        .edit-header h1 {
            font-size: 2.2rem;
            margin-bottom: 10px;
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 15px;
        }
        
        .edit-header p {
            opacity: 0.9;
            font-size: 1.1rem;
        }
        
        .edit-form {
            padding: 40px;
        }
        
        .form-group {
            margin-bottom: 25px;
        }
        
        label {
            display: block;
            margin-bottom: 10px;
            font-weight: 600;
            color: #4a5568;
            font-size: 1.1rem;
            display: flex;
            align-items: center;
            gap: 10px;
        }
        
        label i {
            color: #667eea;
            width: 24px;
        }
        
        input[type="text"],
        input[type="number"],
        input[type="email"] {
            width: 100%;
            padding: 15px 20px;
            border: 2px solid #e2e8f0;
            border-radius: 10px;
            font-size: 1.1rem;
            transition: all 0.3s;
            background: #f8fafc;
        }
        
        input:focus {
            outline: none;
            border-color: #667eea;
            background: white;
            box-shadow: 0 0 0 4px rgba(102, 126, 234, 0.1);
        }
        
        .readonly-field {
            background: #edf2f7 !important;
            color: #718096;
            cursor: not-allowed;
        }
        
        .form-actions {
            display: flex;
            gap: 15px;
            margin-top: 40px;
            padding-top: 30px;
            border-top: 2px solid #e2e8f0;
        }
        
        .btn {
            padding: 15px 30px;
            border: none;
            border-radius: 10px;
            font-size: 1.1rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.3s;
            display: inline-flex;
            align-items: center;
            justify-content: center;
            gap: 10px;
            flex: 1;
        }
        
        .btn-primary {
            background: linear-gradient(135deg, #48bb78 0%, #38a169 100%);
            color: white;
        }
        
        .btn-primary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(72, 187, 120, 0.3);
        }
        
        .btn-secondary {
            background: linear-gradient(135deg, #a0aec0 0%, #718096 100%);
            color: white;
        }
        
        .btn-secondary:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(160, 174, 192, 0.3);
        }
        
        .btn-danger {
            background: linear-gradient(135deg, #f56565 0%, #e53e3e 100%);
            color: white;
        }
        
        .btn-danger:hover {
            transform: translateY(-3px);
            box-shadow: 0 10px 20px rgba(245, 101, 101, 0.3);
        }
        
        .student-info {
            background: #f0fff4;
            border: 2px solid #9ae6b4;
            border-radius: 10px;
            padding: 20px;
            margin-bottom: 30px;
        }
        
        .info-row {
            display: flex;
            margin-bottom: 10px;
        }
        
        .info-label {
            font-weight: 600;
            color: #276749;
            min-width: 120px;
        }
        
        .info-value {
            color: #2d3748;
        }
        
        .message {
            padding: 15px;
            border-radius: 10px;
            margin-bottom: 25px;
            display: flex;
            align-items: center;
            gap: 12px;
            font-size: 1.1rem;
        }
        
        .error {
            background: #fff5f5;
            border: 2px solid #fc8181;
            color: #c53030;
        }
        
        .success {
            background: #f0fff4;
            border: 2px solid #68d391;
            color: #276749;
        }
        
        .back-link {
            text-align: center;
            margin-top: 30px;
            padding-top: 20px;
            border-top: 1px solid #e2e8f0;
        }
        
        .back-link a {
            color: #667eea;
            text-decoration: none;
            font-weight: 600;
            display: inline-flex;
            align-items: center;
            gap: 8px;
            transition: color 0.3s;
        }
        
        .back-link a:hover {
            color: #553c9a;
            text-decoration: underline;
        }
        
        @media (max-width: 768px) {
            .edit-container {
                max-width: 95%;
            }
            
            .edit-form {
                padding: 25px;
            }
            
            .form-actions {
                flex-direction: column;
            }
            
            .btn {
                width: 100%;
            }
        }
    </style>
</head>
<body>
    <div class="edit-container">
        <div class="edit-header">
            <h1>
                <i class="fas fa-user-edit"></i>
                编辑学生信息
            </h1>
            <p>修改学生详细信息并保存</p>
        </div>
        
        <div class="edit-form">
            <c:if test="${not empty error}">
                <div class="message error">
                    <i class="fas fa-exclamation-circle"></i>
                    ${error}
                </div>
            </c:if>
            
            <c:if test="${not empty student}">
                <div class="student-info">
                    <div class="info-row">
                        <div class="info-label">当前学生ID:</div>
                        <div class="info-value"><strong>${student.id}</strong></div>
                    </div>
                    <div class="info-row">
                        <div class="info-label">创建时间:</div>
                        <div class="info-value">${student.createdTime}</div>
                    </div>
                </div>
                
                <form action="students" method="post">
                    <input type="hidden" name="action" value="update">
                    <input type="hidden" name="id" value="${student.id}">
                    
                    <div class="form-group">
                        <label for="id">
                            <i class="fas fa-id-card"></i> 学生ID
                        </label>
                        <input type="text" id="id" value="${student.id}" class="readonly-field" readonly>
                    </div>
                    
                    <div class="form-group">
                        <label for="name">
                            <i class="fas fa-user"></i> 姓名 *
                        </label>
                        <input type="text" id="name" name="name" 
                               value="${student.name}" 
                               placeholder="请输入学生姓名" 
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label for="age">
                            <i class="fas fa-birthday-cake"></i> 年龄 *
                        </label>
                        <input type="number" id="age" name="age" 
                               value="${student.age}" 
                               placeholder="请输入年龄" 
                               min="1" max="150" 
                               required>
                    </div>
                    
                    <div class="form-group">
                        <label for="email">
                            <i class="fas fa-envelope"></i> 邮箱 *
                        </label>
                        <input type="email" id="email" name="email" 
                               value="${student.email}" 
                               placeholder="请输入邮箱地址" 
                               required>
                    </div>
                    
                    <div class="form-actions">
                        <button type="submit" class="btn btn-primary">
                            <i class="fas fa-save"></i> 保存修改
                        </button>
                        <a href="students?action=list" class="btn btn-secondary">
                            <i class="fas fa-times"></i> 取消
                        </a>
                        <a href="students?action=delete&id=${student.id}" 
                           class="btn btn-danger"
                           onclick="return confirm('确定要删除学生 ${student.name} 吗？此操作不可撤销！')">
                            <i class="fas fa-trash"></i> 删除学生
                        </a>
                    </div>
                </form>
            </c:if>
            
            <c:if test="${empty student}">
                <div class="message error">
                    <i class="fas fa-exclamation-triangle"></i>
                    未找到学生信息或学生ID无效！
                </div>
                <div class="form-actions">
                    <a href="students?action=list" class="btn btn-primary" style="flex: none;">
                        <i class="fas fa-arrow-left"></i> 返回学生列表
                    </a>
                </div>
            </c:if>
            
            <div class="back-link">
                <a href="students?action=list">
                    <i class="fas fa-arrow-left"></i> 返回学生列表
                </a>
            </div>
        </div>
    </div>
    
    <script>
        // 表单验证
        document.addEventListener('DOMContentLoaded', function() {
            const form = document.querySelector('form');
            if (form) {
                form.addEventListener('submit', function(e) {
                    const name = document.getElementById('name');
                    const age = document.getElementById('age');
                    const email = document.getElementById('email');
                    let valid = true;
                    
                    // 清除之前的错误样式
                    [name, age, email].forEach(input => {
                        input.style.borderColor = '#e2e8f0';
                    });
                    
                    // 验证姓名
                    if (!name.value.trim()) {
                        valid = false;
                        name.style.borderColor = '#f56565';
                        name.focus();
                    }
                    
                    // 验证年龄
                    if (!age.value.trim() || isNaN(age.value) || age.value < 1 || age.value > 150) {
                        valid = false;
                        age.style.borderColor = '#f56565';
                        if (valid) age.focus(); // 如果姓名也错误，保持焦点在姓名
                    }
                    
                    // 验证邮箱
                    const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                    if (!email.value.trim() || !emailPattern.test(email.value)) {
                        valid = false;
                        email.style.borderColor = '#f56565';
                        if (valid) email.focus();
                    }
                    
                    if (!valid) {
                        e.preventDefault();
                        alert('请正确填写所有字段！\n- 姓名不能为空\n- 年龄必须是1-150之间的数字\n- 邮箱格式必须正确');
                    }
                });
            }
            
            // 输入时实时验证
            const inputs = document.querySelectorAll('input[name="name"], input[name="age"], input[name="email"]');
            inputs.forEach(input => {
                input.addEventListener('input', function() {
                    this.style.borderColor = '#e2e8f0';
                    
                    if (this.name === 'age') {
                        const value = parseInt(this.value);
                        if (isNaN(value) || value < 1 || value > 150) {
                            this.style.borderColor = '#f56565';
                        } else {
                            this.style.borderColor = '#48bb78';
                        }
                    }
                    
                    if (this.name === 'email') {
                        const emailPattern = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
                        if (emailPattern.test(this.value)) {
                            this.style.borderColor = '#48bb78';
                        } else if (this.value.trim()) {
                            this.style.borderColor = '#f56565';
                        }
                    }
                    
                    if (this.name === 'name' && this.value.trim()) {
                        this.style.borderColor = '#48bb78';
                    }
                });
            });
        });
    </script>
</body>
</html>
