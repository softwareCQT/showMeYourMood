package com.softwareone.app.handler;

import com.softwareone.app.constant.SystemConstant;
import com.softwareone.app.entity.Memorandum;
import com.softwareone.app.entity.User;
import com.softwareone.app.mapper.UserMapper;
import com.softwareone.app.service.AsyncService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.config.ConfigurableBeanFactory;
import org.springframework.context.annotation.Scope;
import org.springframework.data.redis.core.ZSetOperations;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.util.Objects;
import java.util.Set;

/**
 * @author chenqiting
 */
@Scope(ConfigurableBeanFactory.SCOPE_PROTOTYPE)
@Component
@Slf4j
public class AsyncRedisHandler implements Runnable {

    @Resource(name = "redisTemplate")
    private ZSetOperations<String, Memorandum> operations;
    @Resource
    private UserMapper userMapper;
    @Resource
    private AsyncService asyncService;

    @Override
    public void run() {
        Set<Memorandum> set = operations.rangeByScore(SystemConstant.REMEMBER_KEY, 0, System.currentTimeMillis());

        if (!(set == null || set.isEmpty())) {
            log.info("开始执行：" + set);
            for (Memorandum memorandum : set) {
                //先移除，防止并发
                Long count = operations.remove(SystemConstant.REMEMBER_KEY, memorandum);
                if (Objects.nonNull(count) && count != 0) {
                    User user = userMapper.selectById(memorandum.getUserId());
                    asyncService.sendMessageForTime(memorandum.getContent(), user.getEmail());
                }
            }
        }
    }
}
