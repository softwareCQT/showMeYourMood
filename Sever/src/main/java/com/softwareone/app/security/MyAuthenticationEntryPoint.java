package com.softwareone.app.security;


import com.softwareone.app.constant.ResultConstant;
import com.softwareone.app.security.util.ErrorHandlerUtil;
import org.springframework.security.core.AuthenticationException;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.stereotype.Component;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import com.softwareone.*;

/**
 * @author chenqiting
 */
@Component
public class MyAuthenticationEntryPoint implements AuthenticationEntryPoint {
    @Override
    public void commence(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {
        ErrorHandlerUtil.printError(httpServletResponse, ResultConstant.TOKEN_EXPIRE, 401);
    }
}
