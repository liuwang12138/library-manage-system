package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Objects;

/**
 * @author Godric
 */
@Slf4j
@Controller
@RequestMapping("user")
public class UserController {

    @Autowired
    UserService userService;

    @ResponseBody
    @PostMapping("register")
    public ResultMessage<Void> register(@RequestParam String username,
                                        @RequestParam String password) {
        log.info("username = " + username);
        log.info("password = " + password);
        ResultMessage<UserPO> resultMessage = userService.register(username, password);
        if (resultMessage.isSuccess()) {
            return ResultMessage.success("注册成功，您的卡号为" + resultMessage.getData().getCardNum() + ", 请妥善保管！");
        }
        return ResultMessage.fail("注册失败, 失败原因为：" + resultMessage.getMessage() + "\n 请调整后重试！");
    }

    @PostMapping("listAll")
    @ResponseBody
    public ResultMessage<IPage<UserPO>> listAll(@RequestParam Integer pageNum,
                                                @RequestParam Integer pageSize) {
        IPage<UserPO> userPos = userService.listAllUsers(pageNum, pageSize);
        return ResultMessage.success(userPos);
    }

    @ResponseBody
    @PostMapping("login")
    public ResultMessage<Void> login(@RequestParam String username,
                                     @RequestParam String password,
                                     HttpServletRequest request) {

        log.info("username = " + username);
        log.info("password = " + password);

        ResultMessage<UserPO> resultMessage = userService.login(username, password);
        if (!resultMessage.isSuccess()) {
            return ResultMessage.fail(resultMessage.getMessage());
        }
        request.getSession().setAttribute("user", resultMessage.getData());
        return ResultMessage.success("登陆成功！");
    }

    @PostMapping("delete")
    @ResponseBody
    public ResultMessage<Void> delete(@RequestParam Integer id) {
        userService.delete(id);
        return ResultMessage.success();
    }

    @PostMapping("getById")
    @ResponseBody
    public ResultMessage<UserPO> getById(@RequestParam Integer id) {
        UserPO byId = userService.getById(id);
        if (Objects.isNull(byId)) {
            return ResultMessage.fail("找不到id对应的用户！");
        }
        return ResultMessage.success(byId);
    }

    @PostMapping("updateById")
    @ResponseBody
    public ResultMessage<Void> updateById(@RequestParam String username,
                                          @RequestParam String password,
                                          @RequestParam Integer id) {
        userService.updateUserById(username, password, id);
        return ResultMessage.success();
    }

    @PostMapping("用户修改密码")
    @ResponseBody
    public ResultMessage<Void> updatePassword(@RequestParam String username,
                                              @RequestParam String oldPassword,
                                              @RequestParam String newPassword) {
        return userService.updatePassword(username, oldPassword, newPassword);
    }

}
