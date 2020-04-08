package com.godric.lms.service;

public interface BlacklistService {

    /**
     * 扫描违规用户并加入黑名单
     * 定时任务执行
     */
    void scanBreakRuleList();

    boolean inBlacklist(Integer userId);

}
