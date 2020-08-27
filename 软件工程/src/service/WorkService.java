package com.itcast.service;

import java.util.List;

import com.itcast.entity.Work;

public interface WorkService {

    // 添加作业
    int addWork(Work work);

    // 根据作业编号 查询 作业信息
    Work queryWorkById(String id);

    // 删除作业
    int deleteWorkById(String id);

    // 修改作业
    int editWork(Work work);

    List<Work> queryWorkByLike(String name, String userId, String teacherId,String taskNum,
                               int offset, int rows);
}
