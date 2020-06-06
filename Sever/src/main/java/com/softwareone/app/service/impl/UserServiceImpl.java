package com.softwareone.app.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.softwareone.app.bo.UserLoginBo;
import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.entity.User;
import com.softwareone.app.mapper.UserMapper;
import com.softwareone.app.security.util.JwtUtil;
import com.softwareone.app.service.AsyncService;
import com.softwareone.app.service.UserService;
import com.softwareone.app.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.RedisTemplate;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Objects;
import java.util.concurrent.TimeUnit;

/***
 * @author chenqiting
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Autowired
    private RedisTemplate<String, Object> redisTemplate;
    @Autowired
    private JwtUtil jwtUtil;
    @Autowired
    private PasswordEncoder passwordEncoder;
    @Autowired
    private AsyncService asyncService;

    @Override
    public Result login(UserLoginBo userLoginBo) {
        User user = userMapper.selectByEmail(userLoginBo.getEmail());
        if (Objects.isNull(user)) {
            return ResultConstant.USER_ERROR;
        }

        boolean flag = passwordEncoder.matches(userLoginBo.getPassword(), user.getPassword());
        //密码是否成功
        if (flag) {
            String token = jwtUtil.createToken(user.getUserId().toString(), user.getUserId());
            return new Result<>(token);
        } else {
            return ResultConstant.USER_ERROR;
        }
    }

    @Override
    public Result register(User user) {
        User existUser = userMapper.selectByEmail(user.getEmail());
        if (Objects.nonNull(existUser)) {
            return ResultConstant.USER_EXIST;
        }
        //加密
        String encodePassword = passwordEncoder.encode(user.getPassword());
        user.setPassword(encodePassword);
        userMapper.insert(user);

        return ResultConstant.OK;
    }

    @Override
    public Result matchesCode(String email, String code) {
        String exist = (String) redisTemplate.opsForValue().get(email);
        //验证失败
        if (StringUtils.isEmpty(exist) || !exist.equals(code)) {
            return ResultConstant.CODE_ERROR;
        }
        return ResultConstant.OK;
    }

    @Override
    public Result sendCode(String email, boolean flag) {
        //此时是修改密码操作，应该判断数据库里是否存在该账号
        if (flag) {
            User user = userMapper.selectByEmail(email);
            if (Objects.isNull(user)) {
                return ResultConstant.NOT_REGISTER;
            }
        }
        String code = String.valueOf((long) (Math.random() * 1000000));
        asyncService.sendCode(code, email);
        redisTemplate.opsForValue().set(email, code, 300, TimeUnit.SECONDS);
        return ResultConstant.OK;
    }

    @Override
    public Result updatePassword(User user) {
        User exist = userMapper.selectByEmail(user.getEmail());
        if (Objects.isNull(exist)) {
            return ResultConstant.NOT_REGISTER;
        }
        exist.setPassword(passwordEncoder.encode(user.getPassword()));
        userMapper.updateById(exist);

        return ResultConstant.OK;
    }
}
