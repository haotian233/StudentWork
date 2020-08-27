package com.itcast.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.itcast.dao.WorkDao;
import com.itcast.entity.Work;
import com.itcast.service.WorkService;

@Service
public class WorkServiceImpl implements WorkService {
    @Autowired
    private WorkDao workDao;

    @Override
    public int addWork(Work work) {

        return workDao.addWork(work);
    }

    @Override
    public Work queryWorkById(String id) {

        return workDao.queryWorkById(id);
    }

    @Override
    public int deleteWorkById(String id) {

        return workDao.deleteWorkById(id);
    }

    @Override
    public int editWork(Work work) {

        return workDao.editWork(work);
    }

    @Override
    public List<Work> queryWorkByLike(String name, String userId,
                                      String teacherId,String taskNum, int offset, int rows) {

        return workDao.queryWorkByLike(name, userId, teacherId,taskNum, offset, rows);
    }

}
