package com.godric.lms.common.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Builder;
import lombok.Data;
import lombok.experimental.Tolerate;

import java.time.LocalDateTime;
import java.util.Date;

/**
 * @author Godric
 */
@Data
@Builder
@TableName("user")
public class UserPO {

    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField("card_num")
    private String cardNum;

    @TableField("username")
    private String username;

    @TableField("password")
    private String password;

    @TableField("create_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    @TableField("update_time")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date updateTime;

    @Tolerate
    public UserPO() {}

}
