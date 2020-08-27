package com.itcast.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.itcast.entity.User;

public interface UserDao {

    // 添加 用户
    int addUser(User user);

    // 根据用户id 查询 用户信息
    User queryUserById(@Param("id") int id);

    // 根据用户名 和 密码 查询 用户信息
    User queryUserByUsernameAndPwd(@Param("username") String username,
                                   @Param("password") String password);

    // 根据用户名 查询 用户信息
    User queryUserByUsername(@Param("username") String username);

    // 删除用户
    int deleteUserById(@Param("id") int id);

    // 修改用户
    int editUser(User user);

    List<User> queryUserByLike(@Param("status") String status,
                               @Param("name") String name, @Param("offset") int offset,
                               @Param("rows") int rows);

}
