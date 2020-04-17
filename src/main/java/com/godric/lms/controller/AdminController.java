package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.constants.LmsConstants;
import com.godric.lms.common.dto.*;
import com.godric.lms.common.enums.UserTypeEnum;
import com.godric.lms.common.po.NoticePO;
import com.godric.lms.common.po.SeatPO;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.service.*;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author Godric
 */
@Controller
@RequestMapping("admin")
public class AdminController {

    @Autowired
    UserService userService;

    @Autowired
    SeatService seatService;

    @Autowired
    NoticeService noticeService;

    @Autowired
    BlacklistService blacklistService;

    @RequestMapping("index")
    public String index() {
        return "admin/index";
    }

    @RequestMapping("login")
    public String login() {
        return "admin/login";
    }

    @RequestMapping("notice")
    public String notice() {
        return "admin/notice";
    }

    @RequestMapping("blacklist")
    public String blacklist() {
        return "admin/blacklist";
    }

    @RequestMapping("user")
    public String user() {
        return "admin/user";
    }

    @RequestMapping("signApprove")
    public String signApprove() {
        return "admin/sign_approve";
    }

    @RequestMapping("seat")
    public String seat() {
        return "admin/seat";
    }

    @ResponseBody
    @PostMapping("login")
    public ResultMessage<Void> login(String username,
                                     String password,
                                     HttpServletRequest request) {

        if ("admin".equals(username) && "123456".equals(password)) {
            request.getSession().setAttribute("user", "admin");
            request.getSession().setAttribute("username", "super admin");
            return ResultMessage.success("超级管理员账号登陆成功");
        } else {
            ResultMessage<UserPO> resultMessage = userService.login(username, password);
            if (!resultMessage.isSuccess()) {
                return ResultMessage.fail(resultMessage.getMessage());
            }
            if (!resultMessage.getData().getType().equals(UserTypeEnum.ADMIN.getCode())) {
                return ResultMessage.fail("您登陆的账号不具有管理员权限！");
            }
            request.getSession().setAttribute("user", resultMessage.getData());
            request.getSession().setAttribute("username", resultMessage.getData().getUsername());
            return ResultMessage.success("登陆成功！");
        }
    }

    // 用户的增删改查
    @ResponseBody
    @PostMapping("listUserByCondition")
    public ResultMessage<List<UserDTO>> listUserByCondition(String username,
                                                            Integer userType,
                                                            Integer pageNum,
                                                            Integer pageSize) {
        IPage<UserPO> userPos = userService.listUserByCondition(username, userType, pageNum, pageSize);

        List<UserDTO> list = new ArrayList<>();
        userPos.getRecords().forEach(po -> {
            UserDTO dto = new UserDTO();
            BeanUtils.copyProperties(po, dto);
            dto.setUserType(po.getType() == 1 ? "普通用户" : "普通管理员");
            dto.setOpt("<a href=\"" + LmsConstants.website + "admin/deleteUserInfo?id=" + po.getId() + "\">删除</a>");

            list.add(dto);
        });

        return ResultMessage.success(list, (int)userPos.getTotal());
    }

    @ResponseBody
    @PostMapping("insertCommonAdmin")
    public ResultMessage<Void> insertCommonAdmin(String username,
                                                 String realName,
                                                 String phone) {
        if ("admin".equals(username)) {
            return ResultMessage.fail("用户名不能为admin");
        }
        ResultMessage<UserPO> register = userService.register(username, "123456", realName, phone, UserTypeEnum.ADMIN.getCode());
        if (register.isSuccess()) {
            return ResultMessage.success("添加成功！");
        }
        return ResultMessage.fail("添加失败，失败原因为: " + register.getMessage());
    }

    @GetMapping("deleteUserInfo")
    public String deleteUserInfo(@RequestParam Integer id,
                                 HttpServletRequest request) {
        userService.delete(id);
        request.setAttribute("userOptInfo", "删除成功");
        return "admin/user";
    }

    @ResponseBody
    @PostMapping("getUserInfoById")
    public ResultMessage<UserPO> getUserInfoById(@RequestParam Integer id) {
        UserPO byId = userService.getById(id);
        if (Objects.isNull(byId)) {
            return ResultMessage.fail("找不到id对应的用户！");
        }
        return ResultMessage.success(byId);
    }

    @ResponseBody
    @PostMapping("updateUserInfoById")
    public ResultMessage<Void> updateUserInfoById(@RequestParam String username,
                                                  @RequestParam String password,
                                                  @RequestParam Integer id) {
        userService.updateUserById(username, password, id);
        return ResultMessage.success();
    }

    // 座位管理
    @ResponseBody
    @PostMapping("insertSeat")
    public ResultMessage<Void> insertSeat(@RequestParam Integer storey,
                                          @RequestParam String roomNum,
                                          @RequestParam Integer seatNum) {
        seatService.insertSeat(storey, roomNum, seatNum);
        return ResultMessage.success("新增成功");
    }

    @GetMapping("deleteSeatById")
    public String deleteSeatById(@RequestParam Integer id,
                                 HttpServletRequest request) {
        seatService.deleteSeat(id);
        request.setAttribute("seatOptInfo", "删除成功");
        return "admin/seat";
    }

    @ResponseBody
    @PostMapping("updateSeatInfoById")
    public ResultMessage<Void> updateSeatInfoById(@RequestParam Integer id,
                                                  @RequestParam(required = false) Integer storey,
                                                  @RequestParam(required = false) String roomNum,
                                                  @RequestParam(required = false) Integer seatNum) {
        seatService.updateSeatById(storey, roomNum, seatNum, id);
        return ResultMessage.success();
    }

    @ResponseBody
    @PostMapping("getSeatInfoById")
    public ResultMessage<SeatPO> getSeatInfoById(@RequestParam Integer id) {
        SeatPO po = seatService.getById(id);
        if (Objects.isNull(po)) {
            return ResultMessage.fail("根据id找不到对应的座位");
        }
        return ResultMessage.success(po);
    }

    @ResponseBody
    @PostMapping("listSeatInfoByCondition")
    public ResultMessage<List<SeatDTO>> listSeatInfoByCondition(Integer storey,
                                                                String roomNum,
                                                                Integer seatNum,
                                                                Integer pageNum,
                                                                Integer pageSize) {
        return seatService.listByCondition(storey, roomNum, seatNum, pageNum, pageSize);
    }

    // 公告管理
    @ResponseBody
    @PostMapping("insertNotice")
    public ResultMessage<Void> insertNotice(@RequestParam String title,
                                            @RequestParam String content) {
        noticeService.insertNotice(title, content);
        return ResultMessage.success("新增公告成功");
    }

    @GetMapping("deleteNotice")
    public String deleteNotice(@RequestParam Integer id,
                               HttpServletRequest request) {
        noticeService.deleteNotice(id);
        request.setAttribute("noticeOptInfo", "删除成功");
        return "admin/notice";
    }

    @ResponseBody
    @PostMapping("listAllNotices")
    public ResultMessage<List<NoticeDTO>> listAllNotices(Integer pageNum,
                                                         Integer pageSize) {
        IPage<NoticePO> noticePOIPage = noticeService.listAllNotices(pageNum, pageSize);

        List<NoticeDTO> list = new ArrayList<>();
        noticePOIPage.getRecords().forEach(po -> {
            NoticeDTO dto = new NoticeDTO();
            BeanUtils.copyProperties(po, dto);
            dto.setOpt("<a href=\"" + LmsConstants.website + "admin/deleteNotice?id=" + po.getId() + "\">删除</a>");

            list.add(dto);
        });

        return ResultMessage.success(list, (int)noticePOIPage.getTotal());
    }

    @ResponseBody
    @PostMapping("listBlack")
    public ResultMessage<List<BlacklistDTO>> listBlack(Integer pageNum,
                                                       Integer pageSize) {
        return blacklistService.listBlack(pageNum, pageSize);
    }

    @GetMapping("delBlackById")
    public String delBlackById(Integer id,
                               HttpServletRequest request) {
        blacklistService.delById(id);
        request.setAttribute("blackOpt", "删除成功");
        return "admin/blacklist";
    }

    @Autowired
    SignInfoService signInfoService;

    @ResponseBody
    @PostMapping("listSignInfoWaitingApprove")
    public ResultMessage<List<SignInfoDTO>> listSignInfoWaitingApprove(Integer pageNum,
                                                                       Integer pageSize) {
        return signInfoService.listSignInfoWaitingApprove(pageNum, pageSize);
    }

    @RequestMapping("approveSignInfo")
    public String approveSignInfo(Integer signId,
                                  HttpServletRequest request) {
        try {
            ResultMessage<Void> approve = signInfoService.approve(signId);
            if (approve.isSuccess()) {
                request.setAttribute("approveInfo", "审核成功");
            } else {
                request.setAttribute("approveInfo", "审核失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("approveInfo", "审核失败，" + e.getMessage());
        }
        return "admin/sign_approve";
    }

}
