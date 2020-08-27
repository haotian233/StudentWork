package com.itcast.entity;

import lombok.Data;

@Data
public class User {

    int id;
    String username;// 用户名(学生为11位学号,教师为教工编号)
    String password;// 密码
    String name;// 姓名
    String status;// 状态(1:教师,2:学生)

    int total;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getStatus() {
        return status;
    }

    public void setStatus(String status) {
        this.status = status;
    }

    public int getTotal() {
        return total;
    }

    public void setTotal(int total) {
        this.total = total;
    }

    @Override
    public String toString() {
        return "{\"id\":\"" + id + "\", \"username\":\"" + username
                + "\", \"password\":\"" + password + "\", \"name\":\"" + name
                + "\", \"status\":\"" + status + "\", \"total\":\"" + total
                + "\"}";
    }

}
