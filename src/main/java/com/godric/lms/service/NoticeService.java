package com.godric.lms.service;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.godric.lms.common.po.NoticePO;

import java.util.List;

/**
 * @author Godric
 */

public interface NoticeService {

    IPage<NoticePO> listAllNotices(Integer pageNum, Integer pageSize);

    void insertNotice(String title, String content);

    void deleteNotice(Integer id);
}
