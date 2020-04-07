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
    public void insertReservation(Date reservationDate, Integer timeQuantum, Integer seatId) throws Exception {
        Integer userId = getMyId();
        ReservationInfoPO info = ReservationInfoPO.builder()
                                            .reservationDate(reservationDate)
                                            .timeQuantum(timeQuantum)
                                            .seatId(seatId)
                                            .userId(userId).build();
        reservationInfoDao.insert(info);
    }

    @Override
    public boolean cancelReservation(Integer reservationId) {
        return reservationInfoDao.deleteById(reservationId) > 0;
    }

    @Override
    public ResultMessage<List<ReservationInfoDTO>> getReservationInfoByCondition(Integer userId, Date startDate, Date endDate, Integer timeQuantum, Integer pageNum, Integer pageSize) {
        Integer startNum = (pageNum - 1) * pageSize;
        List<ReservationInfoDTO> reservationInfoList = reservationInfoDao.getReservationInfoByCondition(userId, startDate, endDate, timeQuantum, startNum, pageSize);
        Integer count = reservationInfoDao.countReservationInfoByCondition(userId, startDate, endDate, timeQuantum);

        return ResultMessage.success(reservationInfoList, count);
    }

    @Override
    public ResultMessage<List<ReservationInfoDTO>> getMyReservationList(Integer pageNum, Integer pageSize) throws Exception {
        Integer userId = getMyId();
        return getReservationInfoByCondition(userId, null, null, null, pageNum, pageSize);
    }

    private Integer getMyId() throws Exception {
        Object user = request.getSession().getAttribute("user");
        if (Objects.isNull(user)) {
            throw new Exception("获取用户信息为空");
        }
        return ((UserPO)user).getId();
    }
}
