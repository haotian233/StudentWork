package com.itcast.service;

import java.util.List;

import com.itcast.entity.Task;

public interface TaskService {

    // 添加任务
    int addTask(Task task);

    // 根据任务编号 查询 任务信息
    Task queryTaskById(String id);

    // 删除任务
    int deleteTaskById(String id);

    // 修改任务
    int editTask(Task task);

    List<Task> queryTaskByLike(String name, String userId, int offset, int rows);

}
