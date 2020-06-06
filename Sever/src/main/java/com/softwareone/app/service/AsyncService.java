package com.softwareone.app.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;

/**
 * @author chenqiting
 */
@Service
public class AsyncService {

    @Resource
    private JavaMailSender javaMailSender;

    @Value("${spring.mail.username}")
    private String emailSender;

    /***
     *发送注册的邮箱验证码给用户
     * @param code 要发送的验证码
     * @param to 发送的对象
     */
    @Async("taskExecutor")
    public void sendCode(String code, String to) {
        SimpleMailMessage message = new SimpleMailMessage();
        //生成验证码
        message.setFrom(this.emailSender);
        message.setText("(该验证码五分钟内有效)您的验证码是：" + code);
        message.setSubject("必备记APP");
        message.setTo(to);
        //进行邮件发送
        javaMailSender.send(message);
    }

    @Async
    public void sendMessageForTime(String message, String to) {
        SimpleMailMessage email = new SimpleMailMessage();
        //生成消息
        email.setFrom(this.emailSender);
        email.setText("（必备记）请不要忘记备忘录中的我喔：" + message);
        email.setTo(to);
        email.setSubject("必备记APP");
        //邮件发送
        javaMailSender.send(email);
    }

}
