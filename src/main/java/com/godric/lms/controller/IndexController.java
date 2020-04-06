package com.godric.lms.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Godric
 */

@Controller
@RequestMapping(value = "index")
public class IndexController {

    @RequestMapping(value = "toIndex")
    public String toIndex() {
        System.out.println("index......................");
        return "index";
    }

}
