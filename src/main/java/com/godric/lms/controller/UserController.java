package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.UserTypeEnum;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * @author Godric
 */
@Slf4j
@RestController
@RequestMapping("user")
public class UserController {

    @Autowired
    UserService userService;

    @PostMapping("register")
    public ResultMessage<Void> register(String username,
                                        String password,
                                        String realName,
                                        String phone) {
        if ("admin".equals(username)) {
            return ResultMessage.fail("注册失败，用户名不能为admin");
        }
        ResultMessage<UserPO> resultMessage = userService.register(username, password, realName, phone, UserTypeEnum.USER.getCode());
        if (resultMessage.isSuccess()) {
            return ResultMessage.success("注册成功，您的卡号为" + resultMessage.getData().getCardNum() + ", 请妥善保管！");
        }
        return ResultMessage.fail("注册失败, 失败原因为：" + resultMessage.getMessage() + "\n 请调整后重试！");
    }

    @PostMapping("login")
    public ResultMessage<Void> login(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     HttpServletRequest request) {
        ResultMessage<UserPO> resultMessage = userService.login(username, password);
        if (!resultMessage.isSuccess()) {
            return ResultMessage.fail(resultMessage.getMessage());
        }
        if (resultMessage.getData().getType().equals(UserTypeEnum.ADMIN.getCode())) {
            return ResultMessage.fail("管理员账号请前往管理员登陆页面登陆！");
        }
        request.getSession().setAttribute("user", resultMessage.getData());
        request.getSession().setAttribute("username", resultMessage.getData().getUsername());
        return ResultMessage.success("登陆成功！");
    }

    @PostMapping("logout")
    public ResultMessage<Void> logout(HttpServletRequest request) {
        request.getSession().removeAttribute("user");
        request.getSession().removeAttribute("username");
        return ResultMessage.success();
    }

    @PostMapping("updatePassword")
    public ResultMessage<Void> updatePassword(String oldPassword,
                                              String newPassword,
                                              HttpServletRequest request) {
        Object username = request.getSession().getAttribute("username");
        if (Objects.isNull(username)) {
            return ResultMessage.fail("您尚未登陆，请登陆后操作");
        }
        return userService.updatePassword((String)username, oldPassword, newPassword);
    }

}
