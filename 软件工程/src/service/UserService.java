package com.itcast.service;

import java.util.List;

import com.itcast.entity.User;

public interface UserService {

    // 添加 用户
    int addUser(User user);

    // 根据用户id 查询 用户信息
    User queryUserById(int id);

    // 根据用户名 和 密码 查询 用户信息
    User queryUserByUsernameAndPwd(String username, String password);

    // 根据用户名 查询 用户信息
    User queryUserByUsername(String username);

    // 删除用户
    int deleteUserById(int id);

    // 修改用户
    int editUser(User user);

    List<User> queryUserByLike(String status, String name, int offset, int rows);

}
