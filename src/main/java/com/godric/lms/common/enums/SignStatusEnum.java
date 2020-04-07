package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SignStatusEnum {

    TO_AUDITED(1, "待审核"),
    AUDITED(2, "已审核");

    private Integer code;
    private String value;

}
