package com.softwareone.app;

import cn.hutool.extra.spring.SpringUtil;
import com.softwareone.app.handler.AsyncRedisHandler;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

import org.springframework.context.ApplicationContext;
import org.springframework.scheduling.annotation.EnableAsync;


@SpringBootApplication
@EnableAsync
public class AppApplication {

    public static void main(String[] args) {
       SpringApplication.run(AppApplication.class, args);
    }


}
