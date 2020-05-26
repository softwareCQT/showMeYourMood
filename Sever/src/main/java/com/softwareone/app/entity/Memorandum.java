package com.softwareone.app.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;
import java.time.LocalDateTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.format.annotation.DateTimeFormat;

import javax.validation.constraints.NotNull;

/***
 * @author chenqiting
 */
@Data
@TableName(value = "memorandum")
public class Memorandum implements Serializable {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "content")
    @NotNull
    private String content;

    @TableField(value = "user_id")
    private Integer userId;

    @TableField(value = "create_time")
    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date createTime;

    public static final String COL_ID = "id";

    public static final String COL_CONTENT = "content";

    public static final String COL_USER_ID = "user_id";

    public static final String COL_CREATE_TIME = "create_time";
}