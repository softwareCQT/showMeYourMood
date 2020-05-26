package com.softwareone.app.util;

import cn.hutool.extra.spring.SpringUtil;
import javafx.application.Application;
import org.springframework.context.ApplicationContext;

/**
 * @author chenqiting
 */
public class SpringBootUtils {
    private static ApplicationContext applicationContext =null;


    public static <T> T getBean(Class<T> c) {
        return applicationContext.getBean(c);
    }

    public static void setApplicationContext(ApplicationContext appApplication) {
        SpringBootUtils.applicationContext = appApplication;
    }
}
