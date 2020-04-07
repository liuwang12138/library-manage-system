package com.godric.lms.common.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;


/**
 * @author Godric
 */
@Data
public class ReservationInfoDTO {

    private Integer reservationId;

    private String username;

    private Integer storey;

    private String roomNum;

    private Integer seatNum;

    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private LocalDate reservationDate;

    private String timeQuantum;

}
