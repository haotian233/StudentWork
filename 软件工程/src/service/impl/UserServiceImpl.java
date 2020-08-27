package com.itcast.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itcast.dao.UserDao;
import com.itcast.entity.User;
import com.itcast.service.UserService;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserDao userDao;

    @Override
    public int addUser(User user) {

        return userDao.addUser(user);
    }

    @Override
    public User queryUserById(int id) {

        return userDao.queryUserById(id);
    }

    @Override
    public User queryUserByUsernameAndPwd(String username, String password) {

        return userDao.queryUserByUsernameAndPwd(username, password);
    }

    @Override
    public User queryUserByUsername(String username) {

        return userDao.queryUserByUsername(username);
    }

    @Override
    public int deleteUserById(int id) {

        return userDao.deleteUserById(id);
    }

    @Override
    public int editUser(User user) {

        return userDao.editUser(user);
    }

    @Override
    public List<User> queryUserByLike(String status, String name, int offset,
                                      int rows) {

        return userDao.queryUserByLike(status, name, offset, rows);
    }

}
