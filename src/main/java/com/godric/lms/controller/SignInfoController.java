package com.godric.lms.controller;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

/**
 * @author Godric
 */

@Controller
@RequestMapping("sign")
public class SignInfoController {

    @Autowired
    SignInfoService signInfoService;

    @RequestMapping("insert")
    public ResultMessage<Void> insertSignInfo(Integer type,
                                              Integer reservationId) {
        return signInfoService.insertSignInfo(type, reservationId);
    }


}
