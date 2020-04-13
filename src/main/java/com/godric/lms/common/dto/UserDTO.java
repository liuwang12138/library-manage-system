package com.godric.lms.common.dto;

import com.godric.lms.common.po.UserPO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author Godric
 */

@Data
@EqualsAndHashCode(callSuper = false)
public class UserDTO extends UserPO {

    private String userType;

    private String opt;

}
