package com.godric.lms.service.impl;

import com.godric.lms.service.TeacherService;
import com.godric.lms.dao.TeacherDao;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Godric
 */
@Service
public class TeacherServiceImpl implements TeacherService {

    @Autowired
    private TeacherDao teacherDao;

    @Override
    public Integer countAll() throws Exception {
        return teacherDao.countAll();
    }
}
