package com.softwareone.app.util;

import org.springframework.context.ApplicationContext;

/**
 * @author chenqiting
 */
public class SpringBootUtils {
    private static ApplicationContext applicationContext = null;


    public static <T> T getBean(Class<T> c) {
        return applicationContext.getBean(c);
    }

    public static void setApplicationContext(ApplicationContext appApplication) {
        SpringBootUtils.applicationContext = appApplication;
    }
}
