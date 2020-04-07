package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.ReservationInfoPO;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.dao.ReservationInfoDao;
import com.godric.lms.service.ReservationInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * @author Godric
 */
@Service
public class ReservationInfoServiceImpl implements ReservationInfoService {

    @Autowired
    ReservationInfoDao reservationInfoDao;

    @Autowired
    HttpServletRequest request;

    @Override
    public ResultMessage<Void> insertReservation(LocalDate reservationDate, Integer timeQuantum, Integer seatId) throws Exception {

        if (reservationDate.isBefore(LocalDate.now())) {
            return ResultMessage.fail("您预约的时间早于当前时间，预约失败");
        }

        if (reservationInfoDao.countReservationInfoByCondition(null, reservationDate, reservationDate, timeQuantum, seatId) > 0) {
            return ResultMessage.fail("您预约的座位已被预约，请重新挑选座位");
        }

        Integer userId = getMyId();
        ReservationInfoPO info = ReservationInfoPO.builder()
                                            .reservationDate(reservationDate)
                                            .timeQuantum(timeQuantum)
                                            .seatId(seatId)
                                            .userId(userId).build();
        reservationInfoDao.insert(info);
        return ResultMessage.success();
    }

    @Override
    public boolean cancelReservation(Integer reservationId) {
        return reservationInfoDao.deleteById(reservationId) > 0;
    }

    @Override
    public ResultMessage<List<ReservationInfoDTO>> getReservationInfoByCondition(Integer userId, LocalDate startDate, LocalDate endDate, Integer timeQuantum, Integer seatId, Integer pageNum, Integer pageSize) {
        Integer startNum = null;
        if (pageNum != null && pageSize != null) {
            startNum = (pageNum - 1) * pageSize;
        }
        List<ReservationInfoDTO> reservationInfoList = reservationInfoDao.getReservationInfoByCondition(userId, startDate, endDate, timeQuantum, seatId, startNum, pageSize);
        Integer count = reservationInfoDao.countReservationInfoByCondition(userId, startDate, endDate, timeQuantum, seatId);

        return ResultMessage.success(reservationInfoList, count);
    }

    @Override
    public ResultMessage<List<ReservationInfoDTO>> getMyReservationList(Integer pageNum, Integer pageSize) throws Exception {
        Integer userId = getMyId();
        Calendar now = Calendar.getInstance();
        now.setTime(new Date());
        return getReservationInfoByCondition(userId, null, null, null, null, pageNum, pageSize);
    }

    public Integer getMyId() throws Exception {
        Object user = request.getSession().getAttribute("user");
        if (Objects.isNull(user)) {
            throw new Exception("获取用户信息为空");
        }
        return ((UserPO)user).getId();
    }
}
