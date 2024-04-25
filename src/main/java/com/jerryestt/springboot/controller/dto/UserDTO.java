package com.jerryestt.springboot.controller.dto;


import com.jerryestt.springboot.entity.Menu;
import lombok.Data;

import java.util.List;

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
    
    private List<Menu> menus;
}
