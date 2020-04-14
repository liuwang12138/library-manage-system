package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.constants.LmsConstants;
import com.godric.lms.common.dto.ResultMessage;
import com.godric.lms.common.dto.SeatDTO;
import com.godric.lms.common.dto.SeatReservationInfoDTO;
import com.godric.lms.common.po.ReservationInfoPO;
import com.godric.lms.common.po.SeatPO;
import com.godric.lms.dao.ReservationInfoDao;
import com.godric.lms.dao.SeatDao;
import com.godric.lms.service.SeatService;
import com.mysql.cj.util.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

/**
 * @author Godric
 */
@Service
public class SeatServiceImpl implements SeatService {

    @Autowired
    SeatDao seatDao;

    @Autowired
    ReservationInfoDao reservationInfoDao;

    @Override
    public ResultMessage<List<SeatReservationInfoDTO>> listByCondition(Integer storey, String roomNum, Integer seatNum, LocalDate date, Integer timeQuantum, Integer pageNum, Integer pageSize) {
        IPage<SeatPO> seatPOIPage = getSeatPoIPage(storey, roomNum, seatNum, pageNum, pageSize);

        List<SeatReservationInfoDTO> list = new ArrayList<>();
        seatPOIPage.getRecords().forEach(po -> {
            SeatReservationInfoDTO dto = new SeatReservationInfoDTO();
            BeanUtils.copyProperties(po, dto);
            if (reserved(po, date, timeQuantum)) {
                dto.setOpt("已预约");
            } else {
                // <a href="http://localhost:20202/reservation/insert?reservationDate=2020-04-13&timeQuantum=1&seatId=2">预约</a>
                dto.setOpt("<a href=\"" + LmsConstants.website + "reservation/insert?reservationDate=" + date +
                        "&timeQuantum=" + timeQuantum + "&seatId=" + po.getId() + "\">预约</a>");
            }

            list.add(dto);
        });

        return ResultMessage.success(list, (int)seatPOIPage.getTotal());
    }

    @Override
    public ResultMessage<List<SeatDTO>> listByCondition(Integer storey, String roomNum, Integer seatNum, Integer pageNum, Integer pageSize) {
        IPage<SeatPO> seatPoIPage = getSeatPoIPage(storey, roomNum, seatNum, pageNum, pageSize);

        List<SeatDTO> list = new ArrayList<>();
        seatPoIPage.getRecords().forEach(po -> {
            SeatDTO dto = new SeatDTO();
            BeanUtils.copyProperties(po, dto);

            dto.setOpt("<a href=\"" + LmsConstants.website + "deleteSeatById?id=" + po.getId() +
                    "\">删除</a>");
            list.add(dto);
        });

        return ResultMessage.success(list, (int)seatPoIPage.getTotal());
    }

    private IPage<SeatPO> getSeatPoIPage(Integer storey, String roomNum, Integer seatNum, Integer pageNum, Integer pageSize) {
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
        queryWrapper.orderByAsc("id");
        IPage<SeatPO> page = new Page<>(pageNum, pageSize);

        return seatDao.selectPage(page, queryWrapper);
    }

    /**
     * 判断座位是否已经被预定
     */
    private Boolean reserved(SeatPO po, LocalDate date, Integer timeQuantum) {
        QueryWrapper<ReservationInfoPO> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("seat_id", po.getId());
        queryWrapper.ge("reservation_date", date);
        queryWrapper.ge("time_quantum", timeQuantum);

        List<ReservationInfoPO> reservationInfoPos = reservationInfoDao.selectList(queryWrapper);
        return !reservationInfoPos.isEmpty();
    }

    @Override
    public void insertSeat(Integer storey, String roomNum, Integer seatNum) {
        SeatPO seatPo = SeatPO.builder().storey(storey).roomNum(roomNum).seatNum(seatNum).build();
        seatDao.insert(seatPo);
    }

    @Override
    public void deleteSeat(Integer id) {
        seatDao.deleteById(id);
    }

    @Override
    public SeatPO getById(Integer id) {
        return seatDao.selectById(id);
    }

    @Override
    public void updateSeatById(Integer storey, String roomNum, Integer seatNum, Integer id) {
        if (Objects.isNull(storey) && org.springframework.util.StringUtils.isEmpty(roomNum) && Objects.isNull(seatNum)) {
            return;
        }
        SeatPO seat = SeatPO.builder().storey(storey).roomNum(roomNum).seatNum(seatNum).id(id).build();
        seatDao.updateById(seat);
    }
}
