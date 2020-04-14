package com.godric.lms.controller;

import com.godric.lms.common.dto.ReservationCountDTO;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.ReservationInfoService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.DateTimeFormat;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.List;

/**
 * @author Godric
 */
@Slf4j
@Controller
@RequestMapping("reservation")
public class ReservationInfoController {

    @Autowired
    ReservationInfoService reservationInfoService;


    @GetMapping("statistic")
    public String statistic() {
        return "user/statistic";
    }

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

    @GetMapping("cancel")
    public String cancelReservationInfo(@RequestParam Integer reservationId,
                                        HttpServletRequest request) {
        if (reservationInfoService.cancelReservation(reservationId)) {
            request.setAttribute("insertSignMessage", "取消成功");
        } else {
            log.warn("id = " + reservationId + "找不到对应的记录");
            request.setAttribute("insertSignMessage", "找不到对应的预约记录");
        }
        return "user/my_info";
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

    @ResponseBody
    @PostMapping("countReservationByDate")
    public ResultMessage<List<ReservationCountDTO>> countReservationByDate(@RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate startDate,
                                                                           @RequestParam(required = false) @DateTimeFormat(pattern = "yyyy-MM-dd") LocalDate endDate,
                                                                           Integer pageNum,
                                                                           Integer pageSize) {

        if (startDate == null) startDate = LocalDate.now();
        if (endDate == null) endDate = LocalDate.now();
        return reservationInfoService.countReservationByDate(startDate, endDate, pageNum, pageSize);
    }


}
