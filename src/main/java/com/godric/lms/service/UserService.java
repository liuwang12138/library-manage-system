package com.godric.lms.service;

import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.UserPO;

public interface UserService {

    ResultMessage<UserPO> register(String username, String password);

    ResultMessage<UserPO> login(String username, String password);
}
