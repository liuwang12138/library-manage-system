package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.po.UserPO;

public interface UserService {

    ResultMessage<UserPO> register(String username, String password, String realName, String phone);

    ResultMessage<UserPO> login(String username, String password);

    IPage<UserPO> listAllUsers(Integer pageNum, Integer pageSize);

    void delete(Integer id);

    UserPO getById(Integer id);

    void updateUserById(String username, String password, Integer id);

    ResultMessage<Void> updatePassword(String username, String oldPassword, String newPassword);
}
