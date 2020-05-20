package com.softwareone.app.bo;

import lombok.Data;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotNull;

/**
 * @author chenqiting
 */
@Data
public class UserLoginBo {
    @Email(message = "邮件格式")
    private String email;
    @NotNull(message = "密码不为空")
    private String password;
}
