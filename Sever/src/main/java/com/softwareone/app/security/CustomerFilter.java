package com.softwareone.app.security;

import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.constant.SystemConstant;
import com.softwareone.app.security.util.ErrorHandlerUtil;
import com.softwareone.app.security.util.JwtUtil;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.web.authentication.www.BasicAuthenticationFilter;
import org.springframework.util.StringUtils;

import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

import java.util.Objects;

/**
 * @author chenqiting
 */
public class CustomerFilter extends BasicAuthenticationFilter {

    private JwtUtil jwtUtil;


    public CustomerFilter(AuthenticationManager authenticationManager,JwtUtil jwtUtil) {
        super(authenticationManager);
        this.jwtUtil = jwtUtil;
    }


    @Override
    protected void doFilterInternal(
            HttpServletRequest request, HttpServletResponse response, FilterChain chain) throws IOException, ServletException {
        String token = request.getHeader(SystemConstant.HEAD);
        //判断header是否合法
        if (!StringUtils.isEmpty(token) && token.startsWith(SystemConstant.BEARER)) {
            //获取jwt
            String jwt = token.substring(SystemConstant.BEARER.length());
            //获取userName
            String uuid = jwtUtil.getUuid(jwt);
            //获取userId
            Integer userId = jwtUtil.getUserId(jwt);

            if (Objects.nonNull(uuid)) {
                    //对全部字符串要加上前缀
                    UsernamePasswordAuthenticationToken usernamePasswordAuthenticationToken =
                            new UsernamePasswordAuthenticationToken(userId, null, null);
                    // 设置具体的detail与否根据功能需求可以自定义设置details,即后台自定义传导数据
                    usernamePasswordAuthenticationToken.setDetails(userId);
                    SecurityContextHolder.getContext().setAuthentication(usernamePasswordAuthenticationToken);
                    chain.doFilter(request, response);
                }
        }else {
            ErrorHandlerUtil.printError(response, ResultConstant.LOGIN_ERROR, 401);
        }
    }



}

