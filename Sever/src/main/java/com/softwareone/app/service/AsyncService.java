package com.softwareone.app.service;

import org.springframework.stereotype.Service;

/**
 * @author chenqiting
 */
@Service
public class AsyncService {

    /***
     *发送注册的邮箱验证码给用户
     * @param code 要发送的验证码
     * @param to 发送的对象
     */
    public void sendRegisterCode(String code, String to){

    }

    /***
     * 发送验证用户信息的验证码给对方，以获取验证身份
     * @param code
     * @param to
     */
    public void sendUpdatePasswordCode(String code, String to){

    }

}
