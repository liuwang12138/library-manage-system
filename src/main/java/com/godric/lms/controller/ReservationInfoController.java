package com.godric.lms.controller;

import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.ReservationInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;

/**
 * @author Godric
 */
@Controller
@Slf4j
@RequestMapping("reservation")
public class ReservationInfoController {

    @Autowired
    ReservationInfoService reservationInfoService;

    @ResponseBody
    @PostMapping("insert")
    public ResultMessage<Void> insertReservationInfo(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate reservationDate,
                                                     @RequestParam Integer timeQuantum,
                                                     @RequestParam Integer seatId) {
        try {
            return reservationInfoService.insertReservation(reservationDate, timeQuantum, seatId);
        } catch (Exception e) {
            e.printStackTrace();
            return ResultMessage.fail(e.getMessage());
        }
    }

    @ResponseBody
    @PostMapping("cancel")
    public ResultMessage<Void> insertReservationInfo(@RequestParam Integer reservationId) {
        if (reservationInfoService.cancelReservation(reservationId)) {
            return ResultMessage.success();
        }
        log.warn("id = " + reservationId + "找不到对应的记录");
        return ResultMessage.fail("找不到id对应的预约记录");
    }

    @ResponseBody
    @PostMapping("getMyReservationInfo")
    public ResultMessage<List<ReservationInfoDTO>> getMyReservationInfo(@RequestParam Integer pageNum,
                                                                        @RequestParam Integer pageSize) {
        try {
            return reservationInfoService.getMyReservationList(pageNum, pageSize);
        } catch (Exception e) {
            return ResultMessage.fail(e.getMessage());
        }
    }

    @ResponseBody
    @PostMapping("getReservationInfoByCondition")
    public ResultMessage<List<ReservationInfoDTO>> getReservationInfoByCondition(@RequestParam Integer userId,
                                                                                 @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                                                                 @RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                                                                 @RequestParam Integer timeQuantum,
                                                                                 @RequestParam Integer seatId,
                                                                                 @RequestParam Integer pageNum,
                                                                                 @RequestParam Integer pageSize) {
        return reservationInfoService.getReservationInfoByCondition(userId, startDate, endDate, timeQuantum, seatId, pageNum, pageSize);
    }

}
