package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
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
        log.info("username = " + username);
        log.info("password = " + password);
        log.info("realName = " + realName);
        log.info("phone = " + phone);
        ResultMessage<UserPO> resultMessage = userService.register(username, password, realName, phone);
        if (resultMessage.isSuccess()) {
            return ResultMessage.success("注册成功，您的卡号为" + resultMessage.getData().getCardNum() + ", 请妥善保管！");
        }
        return ResultMessage.fail("注册失败, 失败原因为：" + resultMessage.getMessage() + "\n 请调整后重试！");
    }

    @PostMapping("listAll")
    public ResultMessage<IPage<UserPO>> listAll(@RequestParam Integer pageNum,
                                                @RequestParam Integer pageSize) {
        IPage<UserPO> userPos = userService.listAllUsers(pageNum, pageSize);
        return ResultMessage.success(userPos);
    }

    @PostMapping("login")
    public ResultMessage<Void> login(@RequestParam("username") String username,
                                     @RequestParam("password") String password,
                                     HttpServletRequest request) {
        log.info("user login....");
        log.info("username = " + username);
        log.info("password = " + password);

        ResultMessage<UserPO> resultMessage = userService.login(username, password);
        if (!resultMessage.isSuccess()) {
            return ResultMessage.fail(resultMessage.getMessage());
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

    @PostMapping("delete")
    public ResultMessage<Void> delete(@RequestParam Integer id) {
        userService.delete(id);
        return ResultMessage.success();
    }

    @PostMapping("getById")
    public ResultMessage<UserPO> getById(@RequestParam Integer id) {
        UserPO byId = userService.getById(id);
        if (Objects.isNull(byId)) {
            return ResultMessage.fail("找不到id对应的用户！");
        }
        return ResultMessage.success(byId);
    }

    @PostMapping("updateById")
    public ResultMessage<Void> updateById(@RequestParam String username,
                                          @RequestParam String password,
                                          @RequestParam Integer id) {
        userService.updateUserById(username, password, id);
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
