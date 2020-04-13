package com.godric.lms.controller;

import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.ReservationInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
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

    @GetMapping("insert")
    public String insertReservationInfo(@RequestParam @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate reservationDate,
                                        @RequestParam Integer timeQuantum,
                                        @RequestParam Integer seatId,
                                        HttpServletRequest request) {
        try {
            ResultMessage<Void> voidResultMessage = reservationInfoService.insertReservation(reservationDate, timeQuantum, seatId);
            if (voidResultMessage.isSuccess()) {
                request.setAttribute("reserveInfo", "预约成功");
            } else {
                request.setAttribute("reserveInfo", voidResultMessage.getMessage());
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("reserveInfo", e.getMessage());
        }

        return "user/seat";
    }

    @ResponseBody
    @PostMapping("cancel")
    public ResultMessage<Void> cancelReservationInfo(@RequestParam Integer reservationId) {
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
