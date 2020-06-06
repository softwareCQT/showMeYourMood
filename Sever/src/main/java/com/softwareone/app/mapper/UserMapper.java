package com.softwareone.app.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.softwareone.app.entity.User;
import org.apache.ibatis.annotations.Mapper;

@Mapper
public interface UserMapper extends BaseMapper<User> {
    /***
     * 找用户的email
     * @param email 邮箱地址
     * @return 用户
     */
    User selectByEmail(String email);
}