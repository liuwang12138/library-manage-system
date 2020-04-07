package com.godric.lms.service.impl;

import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.service.BlacklistService;
import com.godric.lms.service.ReservationInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author Godric
 */
@Service
public class BlacklistServiceImpl implements BlacklistService {

    @Autowired
    ReservationInfoService reservationInfoService;

    @Override
    public void scanBreakRuleList() {
        // 只扫描今天的信息
        ResultMessage<List<ReservationInfoDTO>> reservationInfoByCondition = reservationInfoService.getReservationInfoByCondition(null, LocalDate.now(), LocalDate.now(), null, null, null, null);
        List<ReservationInfoDTO> list = reservationInfoByCondition.getData();
        System.out.println(list);

    }
}
