package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

import javax.validation.constraints.NotNull;

@Getter
@AllArgsConstructor
public enum TimeQuantum {

    AM(1, "8:00-12:00"),
    PM(2, "12:00-17:00"),
    NIGHT(3, "17:00-22:00");

    private Integer code;
    private String value;

    public static String getValueByCode(@NotNull Integer code) {
        for (TimeQuantum timeQuantum : TimeQuantum.values()) {
            if (timeQuantum.getCode().equals(code)) {
                return timeQuantum.getValue();
            }
        }
        return "";
    }

}
