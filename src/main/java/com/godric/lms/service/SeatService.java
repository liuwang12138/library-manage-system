package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.po.SeatPO;

/**
 * @author Godric
 */

public interface SeatService {

    IPage<SeatPO> listByCondition(Integer storey, String roomNum, Integer seatNum, Integer pageNum, Integer pageSize);

    void insertSeat(Integer storey, String roomNum, Integer seatNum);

    void deleteSeat(Integer id);

    SeatPO getById(Integer id);

    void updateSeatById(Integer storey, String roomNum, Integer seatNum, Integer id);
}
