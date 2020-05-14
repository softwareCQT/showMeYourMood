package com.softwareone.app.config;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;

import java.util.concurrent.ThreadPoolExecutor;

/**
 * @author chenqiting
 */
@Configuration
public class MyConfig {

        @Bean("taskExecutor")
        public ThreadPoolTaskExecutor taskExecutor(){
            ThreadPoolTaskExecutor executor  = new ThreadPoolTaskExecutor();
            executor.setCorePoolSize(5);
            executor.setMaxPoolSize(20);
            executor.setQueueCapacity(100);
            executor.setKeepAliveSeconds(60);
            executor.setThreadNamePrefix("emailExecutor-");
            executor.setRejectedExecutionHandler(new ThreadPoolExecutor.CallerRunsPolicy());
            executor.setWaitForTasksToCompleteOnShutdown(true);
            executor.setAwaitTerminationSeconds(60);
            return executor;
      }

      @Bean
      public PasswordEncoder passwordEncoder(){
          return new BCryptPasswordEncoder();
      }
}
