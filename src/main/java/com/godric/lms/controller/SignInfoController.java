package com.godric.lms.controller;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;

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
                                 Integer reservationId,
                                 HttpServletRequest request) throws Exception {
        ResultMessage<Void> voidResultMessage = signInfoService.insertSignInfo(type, reservationId);

        if ( !voidResultMessage.isSuccess()) {
            request.setAttribute("insertSignMessage", voidResultMessage.getMessage());
        }

        return "/user/my_info";
    }

}
