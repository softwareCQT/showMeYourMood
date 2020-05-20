package com.softwareone.app.security.util;

import com.fasterxml.jackson.databind.ObjectMapper;
import com.softwareone.app.vo.Result;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * @author chenqiting
 */
public class ErrorHandlerUtil {

    public static void printError(HttpServletResponse response, Result result, Integer statusCode) throws IOException {
        //设置以json的形式返回
        response.setContentType("application/json;charset=utf-8");
        //设置好返回的http响应状态码
        response.setStatus(statusCode);

        PrintWriter writer = response.getWriter();
        ObjectMapper objectMapper = new ObjectMapper();
        writer.write(objectMapper.writeValueAsString(result));
        writer.flush();
        writer.close();
        //刷出response，响应客户端
        response.flushBuffer();
    }
}
