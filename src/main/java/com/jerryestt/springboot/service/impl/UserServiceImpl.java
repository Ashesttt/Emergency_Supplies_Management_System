package com.jerryestt.springboot.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.common.Constants;
import com.jerryestt.springboot.controller.dto.UserDTO;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.exception.ServiceException;
import com.jerryestt.springboot.mapper.UserMapper;
import com.jerryestt.springboot.service.IUserService;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    private static final Log LOG = Log.get();

    @Override
    public UserDTO login(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one != null) {// 查询成功
            BeanUtil.copyProperties(one, userDTO, true);
            return userDTO;
        } else {// 登录失败
            throw new ServiceException(Constants.INCORRECT_USERNAME_OR_PASSWORD, "用户名或密码错误");
        }

    }

    public User register(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one == null) {// 用户不存在
            one = new User();
            BeanUtil.copyProperties(userDTO, one, true);
            save(one);
        }
        //TODO:列举所有违规用户名,返回给前端：用户名违规
        else {// 用户已存在
            throw new ServiceException(Constants.USERNAME_ALREADY_EXISTS, "用户名已存在");
        }
        return one;
    }

    /**
     * 封装查询用户信息的方法
     */
    private User getUserInfo(UserDTO userDTO) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", userDTO.getUsername());
        queryWrapper.eq("password", userDTO.getPassword());
        User one;
        // 处理异常情况
        //TODO:优化异常情况
        try {
            one = getOne(queryWrapper);
        } catch (Exception e) {//查询失败
            LOG.error(e);
            throw new ServiceException(Constants.ERROR, "系统错误");
        }
        return one;
    }
}
