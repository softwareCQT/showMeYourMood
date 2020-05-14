package com.softwareone.app.handler;

import com.softwareone.app.vo.Result;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.validation.BindException;
import org.springframework.web.bind.MethodArgumentNotValidException;
import org.springframework.web.bind.MissingPathVariableException;
import org.springframework.web.bind.annotation.RestControllerAdvice;
import org.springframework.web.context.request.WebRequest;
import org.springframework.web.servlet.mvc.method.annotation.ResponseEntityExceptionHandler;


/**
 * @author chenqiting
 */
@RestControllerAdvice
public class GlobalExceptionHandler extends ResponseEntityExceptionHandler {
    @Override
    protected ResponseEntity<Object> handleMissingPathVariable(MissingPathVariableException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        StringBuilder stringBuilder = new StringBuilder("参数错误：");

        stringBuilder.append(ex.getMessage());
        return new ResponseEntity<>(new Result<>(400,stringBuilder.toString()), HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleMethodArgumentNotValid(MethodArgumentNotValidException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        StringBuilder stringBuilder = new StringBuilder("参数错误：");
        ex.getBindingResult().getAllErrors().forEach(v -> stringBuilder.append(v.getDefaultMessage()).append(","));

        return new ResponseEntity<>(new Result<>(400,stringBuilder.toString()), HttpStatus.BAD_REQUEST);
    }

    @Override
    protected ResponseEntity<Object> handleBindException(BindException ex, HttpHeaders headers, HttpStatus status, WebRequest request) {
        StringBuilder stringBuilder = new StringBuilder("参数错误：");
        ex.getAllErrors().forEach(v -> stringBuilder.append(v.getDefaultMessage()).append(","));
        return new ResponseEntity<>(new Result<>(400,stringBuilder.toString()), HttpStatus.BAD_REQUEST);
    }
}
