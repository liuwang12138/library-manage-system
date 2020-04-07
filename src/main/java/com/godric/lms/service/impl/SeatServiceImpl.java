package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.po.SeatPO;
import com.godric.lms.dao.SeatDao;
import com.godric.lms.service.SeatService;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Objects;

/**
 * @author Godric
 */
@Service
public class SeatServiceImpl implements SeatService {

    @Autowired
    SeatDao seatDao;

    @Override
    public IPage<SeatPO> listByCondition(Integer storey, String roomNum, Integer seatNum, Integer pageNum, Integer pageSize) {
        QueryWrapper<SeatPO> queryWrapper = new QueryWrapper<SeatPO>();
        if (Objects.nonNull(storey)) {
            queryWrapper.eq("storey", storey);
        }
        if (!StringUtils.isNullOrEmpty(roomNum)) {
            queryWrapper.eq("room_num", roomNum);
        }
        if (Objects.nonNull(seatNum)) {
            queryWrapper.eq("seat_num", seatNum);
        }
        IPage<SeatPO> page = new Page<>(pageNum, pageSize);
        return seatDao.selectPage(page, queryWrapper);
    }
}
