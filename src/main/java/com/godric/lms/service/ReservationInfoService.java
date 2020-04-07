package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public interface ReservationInfoService {

    void insertReservation(Date reservationDate, Integer timeQuantum, Integer seatId) throws Exception;

    boolean cancelReservation(Integer reservationId);

    ResultMessage<List<ReservationInfoDTO>> getReservationInfoByCondition(Integer userId, Date startDate, Date endDate, Integer timeQuantum, Integer pageNum, Integer pageSize);

    ResultMessage<List<ReservationInfoDTO>> getMyReservationList(Integer pageNum, Integer pageSize) throws Exception;
}
