package com.jerryestt.springboot.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.jerryestt.springboot.entity.Role;

import java.util.List;

public interface IRoleService extends IService<Role> {
    void setRoleMenuRelation(Integer roleId, List<Integer> menuIds);

    List<Integer> findMenuByRoleId(Integer roleId);
}
