package com.godric.lms.service.impl;

import com.godric.lms.common.constants.LmsConstants;
import com.godric.lms.common.dto.ReservationCountDTO;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.ReservationStatusEnum;
import com.godric.lms.common.enums.SignTypeEnum;
import com.godric.lms.common.enums.TimeQuantum;
import com.godric.lms.common.po.ReservationInfoPO;
import com.godric.lms.common.po.SignInfoPO;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.dao.ReservationInfoDao;
import com.godric.lms.dao.SignInfoDao;
import com.godric.lms.service.BlacklistService;
import com.godric.lms.service.ReservationInfoService;
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
        ResultMessage<List<ReservationInfoDTO>> reservationInfoByCondition = getReservationInfoByCondition(userId, LocalDate.now(), null, null, null, pageNum, pageSize);
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
        if (ReservationStatusEnum.WAIT_SIGN_IN.getCode().equals(dto.getStatus())) {
            if (!notLate(dto)) {
                // 已迟
                dto.setOpt("已迟到");
                dto.setCancel("无法取消");
            } else {
                dto.setOpt("<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.SIGN_IN.getCode()
                        + "&reservationId=" + dto.getReservationId() + "\">签到</a>");
                dto.setCancel("<a href=\"" + LmsConstants.website + "reservation/cancel?reservationId="
                        + dto.getReservationId() + "\">取消预约</a>");
            }
        } else if (ReservationStatusEnum.SIGN_IN_WAIT_APPROVE.getCode().equals(dto.getStatus())) {
            dto.setOpt("签到待审核");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.WAIT_SIGN_OUT.getCode().equals(dto.getStatus())) {
            // 待签退
            dto.setOpt("<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.TEMP_SIGN_OUT.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">临时签退</a>&nbsp;&nbsp;" +
                    "<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.SIGN_OUT.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">签退</a>");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_APPROVE.getCode().equals(dto.getStatus())) {
            // 临时签退待审核
            dto.setOpt("临时签退待审核");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_BACK.getCode().equals(dto.getStatus())) {
            dto.setOpt("<a href=\"" + LmsConstants.website + "sign/insert?type=" + SignTypeEnum.TEMP_SIGN_IN.getCode()
                    + "&reservationId=" + dto.getReservationId() + "\">回馆</a>");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.TEMP_SIGN_BACK_WAIT_APPROVE.getCode().equals(dto.getStatus())) {
            dto.setOpt("已回馆待审核");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.SIGN_OUT_WAIT_APPROVE.getCode().equals(dto.getStatus())) {
            dto.setOpt("签退待审核");
            dto.setCancel("无法取消");
        } else if (ReservationStatusEnum.SIGN_OUT.getCode().equals(dto.getStatus())) {
            dto.setOpt("已签退");
            dto.setCancel("无法取消");
        }
    }

    private boolean notLate(ReservationInfoDTO dto) {
        //判断是否已迟到一小时
        LocalDate now = LocalDate.now();
        LocalDate reservationDate = dto.getReservationDate();
        if (now.isAfter(reservationDate)) {
            // 已经不是同一天了
            return false;
        } else if (!now.equals(reservationDate)) {
            return true;
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

    @Override
    public void updateReservationStatus(Integer reservationId, Integer reservationStatus) throws Exception {
        ReservationInfoPO reservationInfo = reservationInfoDao.selectById(reservationId);
        if (Objects.isNull(reservationInfo)) {
            throw new Exception("根据id找不到预约信息！");
        }
        if (ReservationStatusEnum.SIGN_IN_WAIT_APPROVE.getCode().equals(reservationStatus)) {
            // 变更为签到待审核
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.WAIT_SIGN_IN.getCode())) {
                throw new Exception("原状态不是待签到，无法将状态变更为签到待审核");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.WAIT_SIGN_OUT.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.SIGN_IN_WAIT_APPROVE.getCode())
            && !reservationInfo.getStatus().equals(ReservationStatusEnum.TEMP_SIGN_BACK_WAIT_APPROVE.getCode())) {
                throw new Exception("原状态不是签到待审核或回馆待审核，无法将状态变更为待签退");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_APPROVE.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.WAIT_SIGN_OUT.getCode())) {
                throw new Exception("原状态不是待签退，无法将状态变更为临时签退待审核");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_BACK.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_APPROVE.getCode())) {
                throw new Exception("原状态不是临时签退待审核，无法将状态变更为");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.TEMP_SIGN_BACK_WAIT_APPROVE.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_BACK.getCode())) {
                throw new Exception("原状态不是待回馆，无法将状态变更为回馆待审核");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.SIGN_OUT_WAIT_APPROVE.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.WAIT_SIGN_OUT.getCode())) {
                throw new Exception("原状态不是待签退，无法将状态变更为签退待审核");
            }
            reservationInfo.setStatus(reservationStatus);
        } else if (ReservationStatusEnum.SIGN_OUT.getCode().equals(reservationStatus)) {
            if (!reservationInfo.getStatus().equals(ReservationStatusEnum.SIGN_OUT_WAIT_APPROVE.getCode())) {
                throw new Exception("原状态不是签退待审核，无法将状态变更为已签退");
            }
            reservationInfo.setStatus(reservationStatus);
        } else {
            throw new Exception("更新的状态不正确");
        }
        reservationInfoDao.updateById(reservationInfo);
    }

    @Override
    public boolean canSignIn(Integer reservationId) {
        ReservationInfoPO reservationInfo = reservationInfoDao.selectById(reservationId);
        if (!reservationInfo.getReservationDate().equals(LocalDate.now())) {
            return false;
        }

        if (reservationInfo.getTimeQuantum().equals(TimeQuantum.AM.getCode())) {
            return LocalDateTime.now().isBefore(LocalDateTime.of(LocalDate.now(), LocalTime.of(9, 0, 0)))
                    && LocalDateTime.now().isAfter(LocalDateTime.of(LocalDate.now(), LocalTime.of(7, 50, 0)));
        } else if (reservationInfo.getTimeQuantum().equals(TimeQuantum.PM.getCode())) {
            return LocalDateTime.now().isBefore(LocalDateTime.of(LocalDate.now(), LocalTime.of(13, 0, 0)))
                    && LocalDateTime.now().isAfter(LocalDateTime.of(LocalDate.now(), LocalTime.of(11, 50, 0)));
        } else if (reservationInfo.getTimeQuantum().equals(TimeQuantum.NIGHT.getCode())) {
            return LocalDateTime.now().isBefore(LocalDateTime.of(LocalDate.now(), LocalTime.of(18, 0, 0)))
                    && LocalDateTime.now().isAfter(LocalDateTime.of(LocalDate.now(), LocalTime.of(16, 50, 0)));
        } else {
            return false;
        }
    }

    @Override
    public ResultMessage<List<ReservationCountDTO>> countReservationByDate(LocalDate startDate, LocalDate endDate, Integer pageNum, Integer pageSize) {

        List<ReservationCountDTO> list = new ArrayList<>();

        long count = endDate.toEpochDay() - startDate.toEpochDay() + 1;

        int startNum = (pageNum - 1) * pageSize;

        startDate = startDate.plusDays(startNum);
        LocalDate endPageDate = startDate.plusDays(pageSize);
        endDate = endDate.isBefore(endPageDate) ? endDate : endPageDate;


        for (LocalDate date = startDate; date.isBefore(endDate) || date.isEqual(endDate); date = date.plusDays(1)) {
            ReservationCountDTO dto = new ReservationCountDTO();
            dto.setDate(date);
            Integer amNum = reservationInfoDao.countReservationInfoByCondition(null, date, date, TimeQuantum.AM.getCode(), null);
            Integer pmNum = reservationInfoDao.countReservationInfoByCondition(null, date, date, TimeQuantum.PM.getCode(), null);
            Integer nightNum = reservationInfoDao.countReservationInfoByCondition(null, date, date, TimeQuantum.NIGHT.getCode(), null);

            dto.setAmNum(amNum);
            dto.setPmNum(pmNum);
            dto.setNightNum(nightNum    );

            list.add(dto);
        }

        return ResultMessage.success(list, (int)count);
    }
}
