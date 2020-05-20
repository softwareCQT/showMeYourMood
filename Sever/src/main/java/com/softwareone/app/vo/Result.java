package com.softwareone.app.vo;

import com.fasterxml.jackson.annotation.JsonInclude;
import lombok.Data;

/**
 * @author chenqiting
 */
@Data
@JsonInclude(JsonInclude.Include.NON_NULL)
public class Result<T> {
    private Integer code;
    private String msg;
    private T data;

    /**
     * 功能描述 请求成功的返回数据
     *
     * @param data
     * @author chenqiting
     * @date 2020/2/9 13:13
     */
    public Result(T data) {
        this.data = data;
        this.code = 200;
        this.msg = "ok";
    }

    /**
     * 功能描述
     *
     * @param msg  请求错误的响应信息
     * @param code 请求错误的响应码
     * @author chenqiting
     * @date 2020/2/9 13:15
     */
    public Result(Integer code, String msg) {
        this.code = code;
        this.msg = msg;
    }
}
