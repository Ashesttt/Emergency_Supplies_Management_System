package com.jerryestt.springboot.common;

public interface Constants {
    String SUCCESS = "200";// 成功
    String BAD_REQUEST = "400";// 错误请求
    String UNAUTHORIZED = "401";// 未授权
    String FORBIDDEN = "403";// 禁止访问
    String NOT_FOUND = "404";// 未找到
    String METHOD_NOT_ALLOWED = "405";// 方法不允许
    String ERROR = "500";// 系统错误
    String SERVICE_UNAVAILABLE = "503";// 服务不可用
    String GATEWAY_TIMEOUT = "504";// 网关超时
    String UNKNOWN = "10000";// 未知错误
    String INCORRECT_USERNAME_OR_PASSWORD = "10001";// 用户名或密码错误
    String USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY = "10002";// 用户名或密码不能为空
    String USERNAME_ALREADY_EXISTS = "10003";// 用户名已存在
    String USER_NOT_FOUND = "10004";// 用户未找到
    String DICT_TYPE_ICON = "icon";// 字典类型-图标
    String SUCCESS_BUT_RUNNING_OUT_OF_MATERIAL = "11000"; //成功但仓库快没有物资啦
}

