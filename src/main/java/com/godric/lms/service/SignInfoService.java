package com.godric.lms.service;

import com.godric.lms.common.dto.ResultMessage;

public interface SignInfoService {

    ResultMessage<Void> insertSignInfo(Integer type,
                                       Integer reservationId);

}
