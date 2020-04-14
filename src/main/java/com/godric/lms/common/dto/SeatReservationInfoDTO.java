package com.godric.lms.common.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.godric.lms.common.po.SeatPO;
import lombok.Data;
import lombok.EqualsAndHashCode;

import java.time.LocalDate;

/**
 * @author Godric
 */

@Data
@EqualsAndHashCode(callSuper = true)
public class SeatReservationInfoDTO extends SeatPO {

    private String opt;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    private String timeQuantum;

}
