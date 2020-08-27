package com.itcast.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import com.itcast.entity.Work;

public interface WorkDao {

    // 添加作业
    int addWork(Work work);

    // 根据作业编号 查询 作业信息
    Work queryWorkById(@Param("id") String id);

    // 删除作业
    int deleteWorkById(@Param("id") String id);

    // 修改作业
    int editWork(Work work);

    List<Work> queryWorkByLike(@Param("name") String name,
                               @Param("userId") String userId, @Param("teacherId") String teacherId,@Param("taskNum") String taskNum,
                               @Param("offset") int offset, @Param("rows") int rows);

}
