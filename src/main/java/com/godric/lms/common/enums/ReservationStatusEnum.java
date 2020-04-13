package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NonNull;

@Getter
@AllArgsConstructor
public enum ReservationStatusEnum {
    // 1-待签到，2-签到待审核，3-待签退/暂时签退，4-暂时离馆待审核，5-待回馆，6-回馆待审核，7-签退待审核，8-已签退
    /**            --------<------
     *            |              |
     * 1 -> 2 -> 3 -> 4 -> 5 -> 6
     *             -> 7 -> 8
     */
    WAIT_SIGN_IN(1, "待签到"),
    SIGN_IN_WAIT_APPROVE(2, "签到待审核"),
    WAIT_SIGN_OUT(3, "待签退/暂时签退"),
    TEMP_SIGN_OUT_WAIT_APPROVE(4, "暂时离馆待审核"),
    TEMP_SIGN_OUT_WAIT_BACK(5, "待回馆"),
    TEMP_SIGN_BACK_WAIT_APPROVE(6, "回馆待审核"),
    SIGN_OUT_WAIT_APPROVE(7, "签退待审核"),
    SIGN_OUT(8, "已签退");

    Integer code;
    String value;

    public static String getValueByCode(@NonNull Integer code) {
        for (ReservationStatusEnum statusEnum : ReservationStatusEnum.values()) {
            if (statusEnum.getCode().equals(code)) {
                return statusEnum.getValue();
            }
        }
        return "";
    }

}
