package com.godric.lms.controller;

import com.godric.lms.service.TeacherService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Godric
 */
@Controller
@RequestMapping(value = "/teacher")
public class TeacherController {

    @Autowired
    private TeacherService teacherService;

    @RequestMapping(value = "teacher")
    public String teacher() {

        int count = 0;
        try {
            count = teacherService.countAll();
        } catch (Exception e) {
            e.printStackTrace();
        }
        System.out.println("count = " + count);
        return "index";
    }

}
