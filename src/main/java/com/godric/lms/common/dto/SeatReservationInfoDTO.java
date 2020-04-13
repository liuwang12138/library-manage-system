package com.godric.lms.common.dto;

import com.godric.lms.common.po.SeatPO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author Godric
 */

@Data
@EqualsAndHashCode(callSuper = true)
public class SeatReservationInfoDTO extends SeatPO {

    private String opt;

}
