package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum ReservationStatusEnum {
    // 1-待签到，2-签到待审核，3-待签退/暂时签退，4-待暂签退审核，5-已暂时签退，待回，6-暂时签回待审核，7-签退待审核，8-签退已审核
    /**            --------<------
     *            |              |
     * 1 -> 2 -> 3 -> 4 -> 5 -> 6
     *             -> 7 -> 8
     */
    WAIT_SIGN_IN(1),
    SIGN_IN_WAIT_APPROVE(2),
    WAIT_SIGN_OUT(3),
    TEMP_SIGN_OUT_WAIT_APPROVE(4),
    TEMP_SIGN_OUT_WAIT_BACK(5),
    TEMP_SIGN_BACK_WAIT_APPROVE(6),
    SIGN_OUT_WAIT_APPROVE(7),
    SIGN_OUT(8);

    Integer code;

}
