package com.jerryestt.springboot.controller.dto;


import lombok.Data;

/**
 * 接收前端参数
 */
@Data
public class UserDTO {
    private String username;
    private String password;
    private String userRole;
    private String avatarurl;
    private String token;
}
