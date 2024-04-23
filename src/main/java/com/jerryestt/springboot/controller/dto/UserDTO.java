package com.jerryestt.springboot.controller.dto;


import com.jerryestt.springboot.entity.Role;
import lombok.Data;

/**
 * 接收前端参数
 * */
@Data
public class UserDTO {
    private String username;
    private String password;
    private Role role;
    private String avatarurl;
    private String token;
}
