package com.jerryestt.springboot.common;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;


/**
 * 统一返回结果
 */

@Data
@NoArgsConstructor// 无参构造方法
@AllArgsConstructor// 有参构造方法
public class Result {
    private String code;
    private String msg;
    private Object data;

    public static Result success() {
        return new Result(Constants.SUCCESS, "成功", null);
    }
    
    public static Result success(String msg) {
        return new Result(Constants.SUCCESS, msg, null);
    }

    public static Result success(Object data) {
        return new Result(Constants.SUCCESS, "成功", data);
    }
    
    public static Result success(String code, String msg){return new Result(code, msg, null);}

    public static Result error(String code, String msg) {
        return new Result(code, msg, null);
    }

    public static Result error() {
        return new Result(Constants.ERROR, "系统错误", null);
    }

    public static Result error(String s) {
        return new Result(Constants.ERROR, s, null);
    }
}
