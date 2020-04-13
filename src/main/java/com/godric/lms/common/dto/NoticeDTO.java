package com.godric.lms.common.dto;

import com.godric.lms.common.po.NoticePO;
import lombok.Data;
import lombok.EqualsAndHashCode;

/**
 * @author Godric
 */

@Data
@EqualsAndHashCode(callSuper = true)
public class NoticeDTO extends NoticePO {

    private String opt;

}
