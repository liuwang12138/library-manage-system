package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.ReservationStatusEnum;
import com.godric.lms.common.enums.SignStatusEnum;
import com.godric.lms.common.enums.SignTypeEnum;
import com.godric.lms.common.po.SignInfoPO;
import com.godric.lms.dao.ReservationInfoDao;
import com.godric.lms.dao.SignInfoDao;
import com.godric.lms.service.ReservationInfoService;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Objects;

/**
 * @author Godric
 */
@Service
public class SignInfoServiceImpl implements SignInfoService {

    @Autowired
    SignInfoDao signInfoDao;

    @Autowired
    ReservationInfoService reservationInfoService;

    @Autowired
    ReservationInfoDao reservationInfoDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultMessage<Void> insertSignInfo(Integer type,
                                              Integer reservationId) throws Exception {

        Integer reservationStatus;
        if (type.equals(SignTypeEnum.SIGN_IN.getCode())) {
            // 签到，把预约状态置为签到待审核
            reservationStatus = ReservationStatusEnum.SIGN_IN_WAIT_APPROVE.getCode();
        } else if (type.equals(SignTypeEnum.TEMP_SIGN_OUT.getCode())) {
            // 临时签退，把预约状态改为临时签退待审核
            reservationStatus = ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_APPROVE.getCode();
        } else if (type.equals(SignTypeEnum.TEMP_SIGN_IN.getCode())) {
            // 回馆，把预约状态改为回馆待审核
            reservationStatus = ReservationStatusEnum.TEMP_SIGN_BACK_WAIT_APPROVE.getCode();
        } else if (type.equals(SignTypeEnum.SIGN_OUT.getCode())) {
            // 签退，把预约状态改为签退待审核
            reservationStatus = ReservationStatusEnum.SIGN_OUT_WAIT_APPROVE.getCode();
        } else {
            return ResultMessage.fail("传入的type不合法");
        }

        Integer myId = null;
        try {
            myId = reservationInfoService.getMyId();
        } catch (Exception e) {
            return ResultMessage.fail("用户没有登陆！");
        }
        SignInfoPO po = SignInfoPO.builder().userId(myId).type(type).reservationId(reservationId).build();
        signInfoDao.insert(po);

        reservationInfoService.updateReservationStatus(reservationId, reservationStatus);
        return ResultMessage.success();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public ResultMessage<Void> approve(Integer signId) throws Exception {
        SignInfoPO signInfo = signInfoDao.selectById(signId);
        if (Objects.isNull(signInfo)) {
            return ResultMessage.fail("根据id找不到对应的签到记录");
        }
        if (!SignStatusEnum.TO_AUDITED.getCode().equals(signInfo.getStatus())) {
            return ResultMessage.fail("签到记录状态不正确！");
        }
        signInfo.setStatus(SignStatusEnum.AUDITED.getCode());
        signInfoDao.updateById(signInfo);

        Integer reservationStatus;
        if (signInfo.getType().equals(SignTypeEnum.SIGN_IN.getCode())) {
            reservationStatus = ReservationStatusEnum.WAIT_SIGN_OUT.getCode();
        } else if (signInfo.getType().equals(SignTypeEnum.TEMP_SIGN_OUT.getCode())) {
            reservationStatus = ReservationStatusEnum.TEMP_SIGN_OUT_WAIT_BACK.getCode();
        } else if (signInfo.getType().equals(SignTypeEnum.TEMP_SIGN_IN.getCode())) {
            reservationStatus = ReservationStatusEnum.WAIT_SIGN_OUT.getCode();
        } else {
            reservationStatus = ReservationStatusEnum.SIGN_OUT.getCode();
        }
        reservationInfoService.updateReservationStatus(signInfo.getReservationId(), reservationStatus);

        return ResultMessage.success();
    }

    @Override
    public IPage<SignInfoPO> getUnauditedSignRecord(LocalDateTime startTime, LocalDateTime endTime, Integer pageNum, Integer pageSize) {
        QueryWrapper<SignInfoPO> queryWrapper = new QueryWrapper<SignInfoPO>();
        if (startTime != null) {
            queryWrapper.gt("create_time", startTime);
        }
        if (startTime != null) {
            queryWrapper.lt("create_time", endTime);
        }
        IPage<SignInfoPO> page = new Page<>(pageNum, pageSize);

        return signInfoDao.selectPage(page, queryWrapper);
    }

    @Override
    public List<SignInfoPO> getOverSignRecord(Integer reservationId, LocalDateTime startTime, LocalDateTime endTime) {
        QueryWrapper<SignInfoPO> queryWrapper = new QueryWrapper<>();
        if (Objects.nonNull(reservationId)) {
            queryWrapper.eq("reservation_id", reservationId);
        }
        if (Objects.nonNull(startTime)) {
            queryWrapper.gt("create_time", startTime);
        }
        if (Objects.nonNull(endTime)) {
            queryWrapper.lt("create_time", endTime);
        }

        return signInfoDao.selectList(queryWrapper);
    }

    @Override
    public List<SignInfoPO> getOverSignRecord(Integer reservationId) {
        return getOverSignRecord(reservationId, null, null);
    }
}
