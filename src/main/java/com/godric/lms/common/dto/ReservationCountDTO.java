package com.godric.lms.common.dto;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.time.LocalDate;

/**
 * @author Godric
 */

@Data
public class ReservationCountDTO {

    @JsonFormat(pattern = "yyyy-MM-dd")
    private LocalDate date;

    private Integer amNum;

    private Integer pmNum;

    private Integer nightNum;
}
