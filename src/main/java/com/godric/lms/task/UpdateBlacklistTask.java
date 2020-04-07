package com.godric.lms.task;

import com.godric.lms.service.BlacklistService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

/**
 * @author Godric
 */
@Slf4j
@Component("updateBlacklistTask")
public class UpdateBlacklistTask {

    @Autowired
    BlacklistService blacklistService;

//    @Scheduled(cron = "*/5 * * * * ?")
//    public void updateBlacklist() {
////        System.out.println("updateBlacklist...");
////        blacklistService.scanBreakRuleList();
//    }
//
//    @Scheduled(cron = "*/2 * * * * ?")
//    public void updateBlacklist2() {
//    }

}
