package com.godric.lms.common.enums;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
public enum UserTypeEnum {

    USER(1),
    ADMIN(2);

    Integer code;


}
