package com.godric.lms.service.impl;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.SignInfoPO;
import com.godric.lms.dao.SignInfoDao;
import com.godric.lms.service.ReservationInfoService;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author Godric
 */
@Service
public class SignInfoServiceImpl implements SignInfoService {

    @Autowired
    SignInfoDao signInfoDao;

    @Autowired
    ReservationInfoService reservationInfoService;

    @Override
    public ResultMessage<Void> insertSignInfo(Integer type,
                                              Integer reservationId) {
        Integer myId = null;
        try {
            myId = reservationInfoService.getMyId();
        } catch (Exception e) {
            return ResultMessage.fail("用户没有登陆！");
        }
        SignInfoPO po = SignInfoPO.builder().userId(myId).type(type).reservationId(reservationId).build();
        signInfoDao.insert(po);
        return ResultMessage.success();
    }

}
