package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.SignInfoPO;

import java.time.LocalDateTime;
import java.util.List;

public interface SignInfoService {

    ResultMessage<Void> insertSignInfo(Integer type,
                                       Integer reservationId);

    ResultMessage<Void> approve(Integer signId);

    IPage<SignInfoPO> getUnauditedSignRecord(LocalDateTime startTime,
                                             LocalDateTime endTime,
                                             Integer pageNum,
                                             Integer pageSize);

    List<SignInfoPO> getOverSignRecord(Integer reservationId,
                                       LocalDateTime startTime,
                                       LocalDateTime endTime);

    List<SignInfoPO> getOverSignRecord(Integer reservationId);
}