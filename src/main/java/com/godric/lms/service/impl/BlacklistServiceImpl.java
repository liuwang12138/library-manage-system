package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.dto.BlacklistDTO;
import com.godric.lms.common.dto.ReservationInfoDTO;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.enums.SignTypeEnum;
import com.godric.lms.common.po.BlacklistPO;
import com.godric.lms.common.po.SignInfoPO;
import com.godric.lms.common.po.UserPO;
import com.godric.lms.dao.BlacklistDao;
import com.godric.lms.dao.UserDao;
import com.godric.lms.service.BlacklistService;
import com.godric.lms.service.ReservationInfoService;
import com.godric.lms.service.SignInfoService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

/**
 * @author Godric
 */
@Service
public class BlacklistServiceImpl implements BlacklistService {

    @Autowired
    ReservationInfoService reservationInfoService;

    @Autowired
    SignInfoService signInfoService;

    @Autowired
    BlacklistDao blacklistDao;

    @Autowired
    UserDao userDao;

    @Override
    public void scanBreakRuleList() {
        // 只扫描今天的信息
        ResultMessage<List<ReservationInfoDTO>> reservationInfoByCondition = reservationInfoService.getReservationInfoByCondition(null, LocalDate.now(), LocalDate.now(), null, null, null, null);
        List<ReservationInfoDTO> list = reservationInfoByCondition.getData();

        list.forEach(dto -> {
            List<SignInfoPO> overSignRecord = signInfoService.getOverSignRecord(dto.getReservationId());
            if (overSignRecord.isEmpty()) {
                // 没有已完成的签到记录
                addUserToBlacklist(dto.getUserId());
            }
            overSignRecord.forEach(signInfoPo -> {
                if (SignTypeEnum.TEMP_SIGN_OUT.getCode().equals(signInfoPo.getStatus())) {
                    // 存在临时退出的签退记录，查看是否存在一小时内的临时签到记录
                    List<SignInfoPO> overSignRecord1 = signInfoService.getOverSignRecord(dto.getReservationId(), signInfoPo.getCreateTime(), signInfoPo.getCreateTime().plusHours(1));
                    if (overSignRecord1.isEmpty()) {
                        addUserToBlacklist(dto.getUserId());
                    }
                }
            });
        });
    }

    private void addUserToBlacklist(Integer userId) {
        BlacklistPO po = BlacklistPO.builder().userId(userId).deadline(LocalDateTime.now().plusDays(3)).build();
        blacklistDao.insert(po);
    }

    @Override
    public boolean inBlacklist(Integer userId) {
        QueryWrapper<BlacklistPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId)
                    .gt("deadline", LocalDateTime.now());
        List<BlacklistPO> blacklistPos = blacklistDao.selectList(queryWrapper);
        return !blacklistPos.isEmpty();
    }

    @Override
    public ResultMessage<List<BlacklistDTO>> listBlack(Integer pageNum, Integer pageSize) {
        QueryWrapper<BlacklistPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.gt("deadline", LocalDateTime.now());
        queryWrapper.orderByDesc("create_time", "id");

        IPage<BlacklistPO> page = new Page<>(pageNum, pageSize);
        IPage<BlacklistPO> blacklistPOIPage = blacklistDao.selectPage(page, queryWrapper);

        List<BlacklistDTO> list = new ArrayList<>();
        blacklistPOIPage.getRecords().forEach(po -> {
            BlacklistDTO dto = new BlacklistDTO();
            dto.setDeadline(po.getDeadline());
            dto.setCreateTime(po.getCreateTime());
            UserPO user = userDao.selectById(po.getUserId());
            dto.setUsername(user == null ? "" : user.getUsername());

            list.add(dto);
        });

        return ResultMessage.success(list, (int)page.getTotal());
    }

}
