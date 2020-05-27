package com.softwareone.app.constant;


import com.softwareone.app.vo.Result;

/**
 * @author chenqiting
 */
public class ResultConstant {
    public static final Result OK = new Result(200, "ok");
    public final static Result LOGIN_ERROR = new Result(401, "未登录");

    public final static Result PERMISSION_DENIED = new Result(1000, "权限不足");
    public static final Result TOKEN_EXPIRE = new Result(1001, "密匙过期");
    public static final Result USER_ERROR = new Result(402, "用户账号或密码错误");
    public static final Result USER_EXIST = new Result(1002, "用户已经存在");
    public static final Result CODE_ERROR = new Result(1003, "验证码错误");
    public static final Result NOT_REGISTER = new Result(1004, "该账号还没注册");
    public static final Result DIARY_EXIST = new Result(1005, "今天的日记已存在");

    public static final Result SYSTEM_ERROR = new Result(-1, "操作错误");
}
