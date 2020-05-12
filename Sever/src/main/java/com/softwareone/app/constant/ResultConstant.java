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
}
