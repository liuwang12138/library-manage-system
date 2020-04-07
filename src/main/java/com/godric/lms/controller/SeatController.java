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

import java.util.Objects;

/**
 * @author Godric
 */

@Controller
@RequestMapping("seat")
public class SeatController {

    @Autowired
    SeatService seatService;

    @ResponseBody
    @PostMapping("insert")
    public ResultMessage<Void> insert(@RequestParam Integer storey,
                                      @RequestParam String roomNum,
                                      @RequestParam Integer seatNum) {
        seatService.insertSeat(storey, roomNum, seatNum);
        return ResultMessage.success();
    }

    @ResponseBody
    @PostMapping("delete")
    public ResultMessage<Void> delete(@RequestParam Integer id) {
        seatService.deleteSeat(id);
        return ResultMessage.success();
    }

    @ResponseBody
    @PostMapping("updateById")
    public ResultMessage<Void> delete(@RequestParam Integer id,
                                      @RequestParam(required = false) Integer storey,
                                      @RequestParam(required = false) String roomNum,
                                      @RequestParam(required = false) Integer seatNum) {
        seatService.updateSeatById(storey, roomNum, seatNum, id);
        return ResultMessage.success();
    }

    @ResponseBody
    @PostMapping("getById")
    public ResultMessage<SeatPO> getById(@RequestParam Integer id) {
        SeatPO po = seatService.getById(id);
        if (Objects.isNull(po)) {
            return ResultMessage.fail("根据id找不到对应的座位");
        }
        return ResultMessage.success(po);
    }

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
