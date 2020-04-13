package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.UserTypeEnum;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.dao.UserDao;
import com.godric.lms.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Objects;
import java.util.Random;

/**
 * @author Godric
 */
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    UserDao userDao;

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");

    private Random random = new Random();

    @Override
    public ResultMessage<UserPO> register(String username, String password, String realName, String phone, Integer type) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<UserPO>().eq("username", username);
        List<UserPO> userPos = userDao.selectList(queryWrapper);
        if (!userPos.isEmpty()) {
            return ResultMessage.fail("已存在相同的username！");
        }

        UserPO userPo = UserPO.builder()
                            .username(username)
                            .password(password)
                            .realName(realName)
                            .phone(phone)
                            .type(type)
                            .cardNum(generateCardNum())
                            .build();
        userDao.insert(userPo);
        return ResultMessage.success(userPo);
    }

    private boolean existSameCardNum(String cardNum) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<UserPO>().eq("card_num", cardNum);
        List<UserPO> userPos = userDao.selectList(queryWrapper);
        return !userPos.isEmpty();
    }

    private String generateCardNum() {
        String result = "";
        do {
            result = sdf.format(new Date()) + generateFourBitRandomNum();
        } while (existSameCardNum(result));

        return result;
    }

    private int generateFourBitRandomNum() {
        return random.nextInt(9000) + 1000;
    }

    @Override
    public ResultMessage<UserPO> login(String username, String password) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<UserPO>()
                                                    .eq("username", username)
                                                    .eq("password", password);
        UserPO userPo = userDao.selectOne(queryWrapper);
        if (Objects.isNull(userPo)) {
            return ResultMessage.fail("用户名或密码错误！");
        }
        return ResultMessage.success(userPo);
    }

    @Override
    public IPage<UserPO> listAllUsers(Integer pageNum, Integer pageSize) {
        QueryWrapper<UserPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.orderByDesc("create_time", "id");
        IPage<UserPO> page = new Page<>(pageNum, pageSize);
        return userDao.selectPage(page, queryWrapper);
    }

    @Override
    public void delete(Integer id) {
        userDao.deleteById(id);
    }

    @Override
    public UserPO getById(Integer id) {
        return userDao.selectById(id);
    }

    @Override
    public void updateUserById(String username, String password, Integer id) {
        if (StringUtils.isEmpty(username) && StringUtils.isEmpty(password)) {
            return;
        }
        UserPO user = UserPO.builder().username(username).password(password).id(id).build();
        userDao.updateById(user);
    }

    @Override
    public ResultMessage<Void> updatePassword(String username, String oldPassword, String newPassword) {
        ResultMessage<UserPO> loginResult = login(username, oldPassword);
        if (!loginResult.isSuccess()) {
            return ResultMessage.fail(loginResult.getMessage());
        }
        updateUserById(null, newPassword, loginResult.getData().getId());
        return ResultMessage.success();
    }
}
