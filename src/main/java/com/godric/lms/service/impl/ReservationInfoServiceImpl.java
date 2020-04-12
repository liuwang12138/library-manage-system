package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.core.metadata.OrderItem;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.constants.LmsConstants;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.SignTypeEnum;
import com.godric.lms.common.po.ReservationInfoPO;
import com.godric.lms.common.po.SignInfoPO;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.dao.ReservationInfoDao;
import com.godric.lms.dao.SignInfoDao;
import com.godric.lms.service.BlacklistService;
import com.godric.lms.service.ReservationInfoService;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.LocalTime;
import java.util.*;

/**
 * @author Godric
 */
@Service
public class ReservationInfoServiceImpl implements ReservationInfoService {

    @Autowired
    BlacklistService blacklistService;

    @Autowired
    ReservationInfoDao reservationInfoDao;

    @Autowired
    SignInfoDao signInfoDao;

    @Autowired
    HttpServletRequest request;

    @Override
    public ResultMessage<Void> insertReservation(LocalDate reservationDate, Integer timeQuantum, Integer seatId) throws Exception {

        if (reservationDate.isBefore(LocalDate.now())) {
            return ResultMessage.fail("您预约的时间早于当前时间，预约失败！");
        }

        if (reservationInfoDao.countReservationInfoByCondition(null, reservationDate, reservationDate, timeQuantum, seatId) > 0) {
            return ResultMessage.fail("您预约的座位已被预约，请重新挑选座位！");
        }

        Integer userId = getMyId();
        if (blacklistService.inBlacklist(userId)) {
            return ResultMessage.fail("您在黑名单列表里，暂时不能预约座位！");
        }

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
        ResultMessage<List<ReservationInfoDTO>> reservationInfoByCondition = getReservationInfoByCondition(userId, null, null, null, null, pageNum, pageSize);
        if (reservationInfoByCondition.isSuccess()) {
            List<ReservationInfoDTO> data = reservationInfoByCondition.getData();
            generateOptForReservationInfo(data);
        }
            return reservationInfoByCondition;
    }

    private void generateOptForReservationInfo(List<ReservationInfoDTO> data) {
        data.forEach(this::generateOptForReservationInfo);
    }

    private void generateOptForReservationInfo(ReservationInfoDTO dto) {
        QueryWrapper<SignInfoPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("reservation_id", dto.getReservationId());
        List<SignInfoPO> signInfoPos = signInfoDao.selectList(queryWrapper);

        List<Integer> signTypeList = getSignTypeList(signInfoPos);
        if (signTypeList.contains(SignTypeEnum.SIGN_OUT.getCode())) {
            // 已签退
            dto.setOpt("已签退");
        }
        // else if (notLate(dto))
        else if (signInfoPos.isEmpty() && notLate(dto)) {
            // 没有签到过
            dto.setOpt("<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.SIGN_IN.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">签到</a>");
        } else if (signInfoPos.size() == 1) {
            // 只是签到过，两个：临时签退/签退
            dto.setOpt("<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.TEMP_SIGN_OUT.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">临时签退</a>&nbsp;&nbsp;" +
                    "<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.SIGN_OUT.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">签退</a>");
        }
    }

    private boolean notLate(ReservationInfoDTO dto) {
        //判断是否已迟到一小时
        LocalDate now = LocalDate.now();
        LocalDate reservationDate = dto.getReservationDate();
        if (now.isAfter(reservationDate)) {
            // 已经不是同一天了
            return false;
        } else {
            // 是同一天
            String timeQuantum = dto.getTimeQuantum();
            LocalDateTime nowTime = LocalDateTime.now();
            if ("8:00-12:00".equals(timeQuantum)) {
                return !nowTime.isAfter(LocalDateTime.of(now, LocalTime.of(9, 0)));
            } else if ("12:00-17:00".equals(timeQuantum)) {
                return !nowTime.isAfter(LocalDateTime.of(now, LocalTime.of(13, 0)));
            } else {
                // ("17:00-22:00".equals(timeQuantum))
                return !nowTime.isAfter(LocalDateTime.of(now, LocalTime.of(18, 0)));
            }
        }
    }

    private List<Integer> getSignTypeList(List<SignInfoPO> signInfoPos) {
        List<Integer> result = new ArrayList<>();
        signInfoPos.forEach(po -> {
            result.add(po.getType());
        });
        return result;
    }

    public Integer getMyId() throws Exception {
        Object user = request.getSession().getAttribute("user");
        if (Objects.isNull(user)) {
            throw new Exception("获取用户信息为空");
        }
        return ((UserPO)user).getId();
    }
}
