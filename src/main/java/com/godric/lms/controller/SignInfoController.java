package com.godric.lms.controller;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Godric
 */

@Controller
@RequestMapping("sign")
public class SignInfoController {

    @Autowired
    SignInfoService signInfoService;

    @GetMapping("insert")
    public String insertSignInfo(Integer type,
                                 Integer reservationId) {
        try {
            ResultMessage<Void> voidResultMessage = signInfoService.insertSignInfo(type, reservationId);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "/user/my_info";
    }

    @RequestMapping("approve")
    public ResultMessage<Void> approve(Integer signId) {
        try {
            return signInfoService.approve(signId);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultMessage.fail("调用过程发生未知异常");
        }
    }

}
