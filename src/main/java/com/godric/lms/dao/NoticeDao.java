package com.godric.lms.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.godric.lms.common.po.NoticePO;

public interface NoticeDao extends BaseMapper<NoticePO> {
    Integer getMaxSort();
}
