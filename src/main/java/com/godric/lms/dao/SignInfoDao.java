package com.godric.lms.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.godric.lms.common.dto.SignInfoDTO;
import com.godric.lms.common.po.SignInfoPO;
import org.apache.ibatis.annotations.Param;

import java.time.LocalDateTime;
import java.util.List;

public interface SignInfoDao extends BaseMapper<SignInfoPO> {

    List<SignInfoDTO> getTodayUnApprovedSignList(@Param("startTime") LocalDateTime startTime,
                                                 @Param("startNum") Integer startNum,
                                                 @Param("pageSize") Integer pageSize);

    Integer countUnapprovedSignList(@Param("startTime") LocalDateTime startTime);

}
