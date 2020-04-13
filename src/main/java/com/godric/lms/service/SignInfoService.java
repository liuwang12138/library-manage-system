package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.dto.SignInfoDTO;
import com.godric.lms.common.po.SignInfoPO;

import java.time.LocalDateTime;
import java.util.List;

public interface SignInfoService {

    ResultMessage<Void> insertSignInfo(Integer type,
                                       Integer reservationId) throws Exception;

    ResultMessage<Void> approve(Integer signId) throws Exception;

    List<SignInfoPO> getOverSignRecord(Integer reservationId,
                                       LocalDateTime startTime,
                                       LocalDateTime endTime);

    List<SignInfoPO> getOverSignRecord(Integer reservationId);

    ResultMessage<List<SignInfoDTO>> listSignInfoWaitingApprove(Integer pageNum, Integer pageSize);
}
