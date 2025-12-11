// src/main/java/com/manbaout/model/Student.java
package com.manbaout.model;

import java.util.Date;

public class Student {
    private Integer id;
    private String name;
    private Integer age;
    private String email;
    private Date createdTime;
    
    // 构造方法
    public Student() {}
    
    public Student(String name, Integer age, String email) {
        this.name = name;
        this.age = age;
        this.email = email;
    }
    
    // Getter和Setter
    public Integer getId() { return id; }
    public void setId(Integer id) { this.id = id; }
    
    public String getName() { return name; }
    public void setName(String name) { this.name = name; }
    
    public Integer getAge() { return age; }
    public void setAge(Integer age) { this.age = age; }
    
    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }
    
    public Date getCreatedTime() { return createdTime; }
    public void setCreatedTime(Date createdTime) { this.createdTime = createdTime; }
    
    @Override
    public String toString() {
        return "Student{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", age=" + age +
                ", email='" + email + '\'' +
                ", createdTime=" + createdTime +
                '}';
    }
}