package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum TimeQuantum {

    AM(1, "8:00-12:00"),
    PM(2, "12:00-17:00"),
    NIGHT(3, "17:00-22:00");

    private Integer code;
    private String value;

}
