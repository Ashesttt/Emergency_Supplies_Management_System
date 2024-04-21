package com.jerryestt.springboot.exception;


import lombok.Getter;

/**
 * 自定义异常
 */
@Getter
public class ServiceException extends RuntimeException {
    private String code;

    public ServiceException(String code, String msg) {
        super(msg);// 调用父类的构造方法
        this.code = code;
    }

}
