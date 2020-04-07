package com.godric.lms.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.po.ReservationInfoPO;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;

public interface ReservationInfoDao extends BaseMapper<ReservationInfoPO> {
    List<ReservationInfoDTO> getReservationInfoByCondition(@Param("userId") Integer userId,
                                                           @Param("startDate") Date startDate,
                                                           @Param("endDate") Date endDate,
                                                           @Param("timeQuantum") Integer timeQuantum,
                                                           @Param("startNum") Integer startNum,
                                                           @Param("pageSize") Integer pageSize);

    Integer countReservationInfoByCondition(@Param("userId") Integer userId,
                                            @Param("startDate") Date startDate,
                                            @Param("endDate") Date endDate,
                                            @Param("timeQuantum") Integer timeQuantum);
}
