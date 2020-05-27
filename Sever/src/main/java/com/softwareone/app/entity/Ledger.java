package com.softwareone.app.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.time.LocalDateTime;
import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;

@Data
@TableName(value = "memory.ledger")
public class Ledger {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "money")
    @NotNull
    @Min(value = 0)
    private Double money;

    @TableField(value = "date")
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date date;

    @TableField(value = "remarks")
    @NotNull(message = "简单说明不能空，可默认传账本信息进来")
    private String remarks;

    /**
     * 0是收入，1是支出
     */
    @TableField(value = "pay")
    @NotNull
    private Boolean pay;

    @TableField(value = "type")
    @NotNull
    private Object type;

    @TableField(value = "user_id")
    private Integer userId;

    public static final String COL_ID = "id";

    public static final String COL_MONEY = "money";

    public static final String COL_DATE = "date";

    public static final String COL_REMARKS = "remarks";

    public static final String COL_PAY = "pay";

    public static final String COL_TYPE = "type";

    public static final String COL_USER_ID = "user_id";
}