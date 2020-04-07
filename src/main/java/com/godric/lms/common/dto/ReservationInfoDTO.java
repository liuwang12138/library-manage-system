package com.godric.lms.common.dto;

import lombok.Data;

import java.util.Date;

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

    private Date reservationDate;

    private String timeQuantum;

}
