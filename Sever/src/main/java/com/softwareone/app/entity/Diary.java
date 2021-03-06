package com.softwareone.app.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/***
 * @author chenqiting
 */
@Data
@TableName(value = "diary")
public class Diary {
    @TableId(value = "id", type = IdType.AUTO)
    private Integer id;

    @TableField(value = "diary_name")
    @NotNull
    private String diaryName;

    @TableField(value = "content")
    @NotNull
    private String content;

    @TableField(value = "date")
    @NotNull
    @JsonFormat(pattern = "yyyy-MM-dd", timezone = "GMT+8")
    private Date date;

    /**
     * 用户的心情
     */
    @TableField(value = "emoji")
    @NotNull
    private String emoji;

    @TableField(value = "weather")
    @NotNull
    private String weather;

    @TableField(value = "user_id")
    private Integer userId;

    public static final String COL_ID = "id";

    public static final String COL_DIARY_NAME = "diary_name";

    public static final String COL_CONTENT = "content";

    public static final String COL_DATE = "date";

    public static final String COL_EMOJI = "emoji";

    public static final String COL_WEATHER = "weather";

    public static final String COL_USER_ID = "user_id";
}