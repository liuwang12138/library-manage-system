package com.godric.lms.service;

import com.godric.lms.common.dto.BlacklistDTO;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;

import java.util.List;

public interface BlacklistService {

    /**
     * 扫描违规用户并加入黑名单
     * 定时任务执行
     */
    void scanBreakRuleList();

    boolean inBlacklist(Integer userId);

    ResultMessage<List<BlacklistDTO>> listBlack(Integer pageNum, Integer pageSize);

}
