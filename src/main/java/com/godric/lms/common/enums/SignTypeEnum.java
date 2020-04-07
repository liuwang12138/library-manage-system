package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum SignTypeEnum {

    SIGN_IN(1),
    TEMP_SIGN_OUT(2),
    TEMP_SIGN_IN(3),
    SIGN_OUT(4);

    Integer code;


}
