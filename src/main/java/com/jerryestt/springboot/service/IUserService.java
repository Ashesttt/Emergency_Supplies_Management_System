package com.jerryestt.springboot.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jerryestt.springboot.controller.dto.UserDTO;
import com.jerryestt.springboot.entity.User;

public interface IUserService extends IService<User> {

    UserDTO login(UserDTO userDTO);
    User register(UserDTO userDTO);
}
