package com.godric.lms.common.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @author Godric
 */

@Data
public class SignInfoDTO {

    private Integer signInfoId;

    private String username;

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate reservationDate;

    private String timeQuantum;

    private Integer storey;

    private String roomNum;

    private Integer seatNum;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;

    private String signType;

    private String opt;

}
