package com.jerryestt.springboot.exception;


import com.jerryestt.springboot.common.Result;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

@ControllerAdvice// 控制器增强
public class GlobalExceptionHandler {

    /**
     * 如果抛出的的是ServiceException，则调用该方法
     *
     * @param se 业务异常
     * @return Result
     */
    @ExceptionHandler(ServiceException.class)// 指定处理的异常
    @ResponseBody
    public Result handle(ServiceException se) {
        return Result.error(se.getCode(), se.getMessage());
    }

}
