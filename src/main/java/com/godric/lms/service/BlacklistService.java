package com.godric.lms.service;

public interface BlacklistService {

    /**
     * 扫描违规用户并加入黑名单
     * 每天
     */
    void scanBreakRuleList();

}
