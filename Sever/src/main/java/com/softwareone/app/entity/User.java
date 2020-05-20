package com.softwareone.app.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotBlank;
import javax.validation.constraints.NotNull;

/***
 * @author chenqiting
 */
@Data
@TableName(value = "user")
public class User {
    @TableId(value = "user_id", type = IdType.AUTO)
    private Integer userId;

    @TableField(value = "email")
    @Email(message = "email格式")
    private String email;

    @TableField(value = "password")
    @NotBlank(message = "密码不能为空")
    private String password;

    @TableField(value = "nick_name")
    private String nickName;

    /**
     * 头像
     */
    @TableField(value = "avatar_url")
    private String avatarUrl;

    public static final String COL_USER_ID = "user_id";

    public static final String COL_EMAIL = "email";

    public static final String COL_PASSWORD = "password";

    public static final String COL_NICK_NAME = "nick_name";

    public static final String COL_AVATAR_URL = "avatar_url";
}