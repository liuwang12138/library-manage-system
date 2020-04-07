package com.godric.lms.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.godric.lms.common.po.NoticePO;
import com.godric.lms.dao.NoticeDao;
import com.godric.lms.service.NoticeService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author Godric
 */
@Slf4j
@Service
public class NoticeServiceImpl implements NoticeService {

    @Autowired
    NoticeDao noticeDao;

    @Override
    public IPage<NoticePO> listAllNotices(Integer pageNum, Integer pageSize) {
        QueryWrapper<NoticePO> queryWrapper = new QueryWrapper<NoticePO>()
                                                    .orderByDesc("sort");
        IPage<NoticePO> page = new Page<>(pageNum, pageSize);
        return noticeDao.selectPage(page, queryWrapper);
    }

    @Override
    public void insertNotice(String title, String content) {
        Integer sort = noticeDao.getMaxSort();
        if (sort == null) {
            sort = 0;
        }
        NoticePO noticePo = NoticePO.builder().title(title).content(content).sort(sort+1).build();
        noticeDao.insert(noticePo);
    }

    @Override
    public void deleteNotice(Integer id) {
        noticeDao.deleteById(id);
    }
}
