package com.itcast.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itcast.dao.TaskDao;
import com.itcast.entity.Task;
import com.itcast.service.TaskService;

@Service
public class TaskServiceImpl implements TaskService {
    @Autowired
    private TaskDao taskDao;

    @Override
    public int addTask(Task task) {

        return taskDao.addTask(task);
    }

    @Override
    public Task queryTaskById(String id) {

        return taskDao.queryTaskById(id);
    }

    @Override
    public int deleteTaskById(String id) {

        return taskDao.deleteTaskById(id);
    }

    @Override
    public int editTask(Task task) {

        return taskDao.editTask(task);
    }

    @Override
    public List<Task> queryTaskByLike(String name, String userId, int offset,
                                      int rows) {

        return taskDao.queryTaskByLike(name, userId, offset, rows);
    }

}
