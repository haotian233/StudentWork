package com.itcast.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.itcast.entity.Task;

public interface TaskDao {

    // 添加任务
    int addTask(Task task);

    // 根据任务编号 查询 任务信息
    Task queryTaskById(@Param("id") String id);

    // 删除任务
    int deleteTaskById(@Param("id") String id);

    // 修改任务
    int editTask(Task task);

    List<Task> queryTaskByLike(@Param("name") String name, @Param("userId") String userId,
                               @Param("offset") int offset, @Param("rows") int rows);

}
