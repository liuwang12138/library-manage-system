package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.dto.SeatReservationInfoDTO;
import com.godric.lms.common.po.SeatPO;

import java.time.LocalDate;
import java.util.List;

/**
 * @author Godric
 */

public interface SeatService {

    ResultMessage<List<SeatReservationInfoDTO>> listByCondition(Integer storey, String roomNum, Integer seatNum, LocalDate date, Integer timeQuantum, Integer pageNum, Integer pageSize);

    ResultMessage<List<SeatPO>> listByCondition(Integer storey, String roomNum, Integer seatNum, Integer pageNum, Integer pageSize);

    void insertSeat(Integer storey, String roomNum, Integer seatNum);

    void deleteSeat(Integer id);

    SeatPO getById(Integer id);

    void updateSeatById(Integer storey, String roomNum, Integer seatNum, Integer id);
}
