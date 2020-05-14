package com.softwareone.app.controller;

import com.softwareone.app.bo.UserLoginBo;
import com.softwareone.app.entity.User;
import com.softwareone.app.service.UserService;
import com.softwareone.app.vo.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.format.annotation.NumberFormat;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import javax.validation.Valid;
import javax.validation.constraints.Email;
import javax.validation.constraints.Pattern;

/**
 * @author chenqiting
 */
@RestController
@Validated
public class UserController {


    @Autowired
    private UserService userService;

    @PostMapping("/api/user/login")
    public Result userLogin(@RequestBody @Valid UserLoginBo userLoginBo){
        return userService.login(userLoginBo);
    }
    @PostMapping("/api/user/register")
    public Result userRegister(@RequestBody @Valid User user) {
        return userService.register(user);
    }
    @GetMapping("/api/user/code/valid")
    public Result userMatches(@Valid @Email(message = "邮箱格式") String email, @Valid @Pattern(regexp = "[0-9]?") String code) {
        return userService.matchesCode(email,code);
    }

    @GetMapping("/api/user/register/code/send")
    public Result sendCodeForRegister(@RequestParam("email") @Valid @Email(message = "邮箱格式") String email){
        return userService.sendCode(email, false);
    }

    @GetMapping("/api/user/password/code/send")
    public Result sendCodeForUpdatePassword(@RequestParam("email") @Valid @Email(message = "邮箱格式") String email) {
        return userService.sendCode(email, true);
    }

    @PostMapping("/api/user/password/update")
    public Result updatePassword(@RequestBody @Valid User user) {
        return userService.updatePassword(user);
    }
}
