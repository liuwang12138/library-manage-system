package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.SeatPO;
import com.godric.lms.service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

/**
 * @author Godric
 */

@Controller
@RequestMapping("seat")
public class SeatController {

    @Autowired
    SeatService seatService;

    @ResponseBody
    @PostMapping("listByCondition")
    public ResultMessage<IPage<SeatPO>> listSeatsByCondition(@RequestParam(required = false) Integer storey,
                                                             @RequestParam(required = false) String roomNum,
                                                             @RequestParam(required = false) Integer seatNum,
                                                             @RequestParam Integer pageNum,
                                                             @RequestParam Integer pageSize) {
        IPage<SeatPO> data = seatService.listByCondition(storey, roomNum, seatNum, pageNum, pageSize);
        return ResultMessage.success(data);
    }

}
