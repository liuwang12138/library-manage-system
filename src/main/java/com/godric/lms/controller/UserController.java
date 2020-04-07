package com.godric.lms.controller;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Godric
 */
@Controller
@RequestMapping("user")
@Slf4j
public class UserController {

    @Autowired
    UserService userService;

    @PostMapping("register")
    @ResponseBody
    public ResultMessage<Void> register(@RequestParam("username") String username,
                                        @RequestParam("password") String password) {
        log.info("username = " + username);
        log.info("password = " + password);
        ResultMessage<UserPO> resultMessage = userService.register(username, password);
        if (resultMessage.isSuccess()) {
            return ResultMessage.success("注册成功，您的卡号为" + resultMessage.getData().getCardNum() + ", 请妥善保管！");
        }
        return ResultMessage.fail("注册失败, 失败原因为：" + resultMessage.getMessage() + "\n 请调整后重试！");
    }

    @PostMapping("login")
    @ResponseBody
    public ResultMessage<Void> login(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     HttpServletRequest request) {
        ResultMessage<UserPO> resultMessage = userService.login(username, password);
        if (!resultMessage.isSuccess()) {
            return ResultMessage.fail(resultMessage.getMessage());
        }
        request.getSession().setAttribute("user", resultMessage.getData());
        return ResultMessage.success("登陆成功！");
    }


}
