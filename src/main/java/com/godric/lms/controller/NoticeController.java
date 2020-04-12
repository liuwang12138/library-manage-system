package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.NoticePO;
import com.godric.lms.service.NoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.List;

/**
 * @author Godric
 */

@Controller
@RequestMapping("notice")
public class NoticeController {

    @Autowired
    NoticeService noticeService;

    @PostMapping("listAll")
    @ResponseBody
    public ResultMessage<List<NoticePO>> listAllNotices(@RequestParam("pageNum") Integer pageNum,
                                                         @RequestParam("pageSize") Integer pageSize) {
        IPage<NoticePO> noticePOIPage = noticeService.listAllNotices(pageNum, pageSize);

        return ResultMessage.success(noticePOIPage.getRecords(), (int)noticePOIPage.getTotal());
    }

    @PostMapping("delete")
    @ResponseBody
    public ResultMessage<Void> delete(@RequestParam Integer id) {
        noticeService.deleteNotice(id);
        return ResultMessage.success();
    }

    @PostMapping("insert")
    @ResponseBody
    public ResultMessage<Void> insert(@RequestParam String title,
                                      @RequestParam String content) {
        noticeService.insertNotice(title, content);
        return ResultMessage.success();
    }

}
