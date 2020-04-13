package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.po.NoticePO;
import com.godric.lms.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;

/**
 * @author Godric
 */

@Controller
public class PathController {

    @Autowired
    NoticeService noticeService;

    @RequestMapping(value = "")
    public String toIndex() {
        return "user/index";
    }

    @GetMapping(value = "notice")
    public String toNotice(//Model model,
                           //Integer pageNum,
                           //Integer pageSize) {
                            ) {
//        IPage<NoticePO> noticePOIPage = noticeService.listAllNotices(pageNum, pageSize);
//        model.addAttribute("noticeList", noticePOIPage);
        return "user/notice";
    }

    @GetMapping(value = "myInfo")
    public String toMyInfo() {
        return "user/my_info";
    }

    @GetMapping(value = "register")
    public String toRegister() {
        return "user/register";
    }

    @GetMapping(value = "seat")
    public String toSeat() {
        return "user/seat";
    }

}
