package com.godric.lms.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.dto.SeatReservationInfoDTO;
import com.godric.lms.common.enums.TimeQuantum;
import com.godric.lms.common.po.SeatPO;
import com.godric.lms.service.SeatService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.time.LocalDate;
import java.util.List;
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
    public ResultMessage<List<SeatReservationInfoDTO>> listSeatsByCondition(Integer storey,
                                                                            String roomNum,
                                                                            Integer seatNum,
                                                                            Integer pageNum,
                                                                            Integer pageSize,
                                                                            @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate date,
                                                                            Integer timeQuantum) {
        if (date == null) {
            date = LocalDate.now();
        }
        if (timeQuantum == null) {
            timeQuantum = TimeQuantum.AM.getCode();
        }
        return seatService.listByCondition(storey, roomNum, seatNum, date, timeQuantum, pageNum, pageSize);
    }

}
