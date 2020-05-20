package com.softwareone.app.service;

import com.softwareone.app.bo.UserLoginBo;
import com.softwareone.app.entity.User;
import com.baomidou.mybatisplus.extension.service.IService;
import com.softwareone.app.vo.Result;

import javax.validation.Valid;
import javax.validation.constraints.Email;

/***
 * @author chenqiting
 */
public interface UserService extends IService<User>{
    /***
     * 登录
     * @param userLoginBo 账号和密码
     * @return 返回登录是否成功并给予token
     */
    Result login(UserLoginBo userLoginBo);

    /***
     * 注册
     * @param user 注册信息
     * @return 返回是否注册成功
     */
    Result register(User user);

    /***
     * 验证邮箱
     * @param email 验证的邮箱
     * @param code 验证码
     * @return 验证是否成功
     */
    Result matchesCode(String email, String code);

    /***
     * 发验证码给这个邮箱
     * @param email 邮箱
     * @param flag 账号是否已经存在
     * @return 发送是否成功
     */
    Result sendCode(String email, boolean flag);

    /***
     * 更新密码
     * @param user 更改的信息
     * @return 是否成功
     */
    Result updatePassword(User user);
}
