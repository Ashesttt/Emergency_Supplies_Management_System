package com.jerryestt.springboot.service;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.mapper.UserMapper;
import org.springframework.stereotype.Service;

import java.security.PublicKey;
import java.util.List;

@Service
public class UserService extends ServiceImpl<UserMapper, User> {

    public List<User> listUsers() {
        return list();
    }

    public boolean saveUser(User user) {
        return saveOrUpdate(user);
    }

}
