package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Role;
import com.jerryestt.springboot.entity.RoleMenuRelation;
import com.jerryestt.springboot.mapper.RoleMapper;
import com.jerryestt.springboot.mapper.RoleMenuMapper;
import com.jerryestt.springboot.service.IRoleService;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.List;

@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {


    @Resource
    private RoleMenuMapper roleMenuMapper;
    
    @Transactional// 事务:保证多个操作要么同时成功，要么同时失败
    @Override
    public void setRoleMenuRelation(Integer roleId, List<Integer> menuIds) {
        // 先删除原有关系
        QueryWrapper<RoleMenuRelation> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("role_id", roleId);
        roleMenuMapper.delete(queryWrapper);
        
        // 建立新关系
        // 一个角色对应多个菜单，所以要遍历menuIds
        for (Integer menuId : menuIds) {
            RoleMenuRelation roleMenuRelation = new RoleMenuRelation();
            roleMenuRelation.setRoleId(roleId);
            roleMenuRelation.setMenuId(menuId);
            roleMenuMapper.insert(roleMenuRelation);
        }
        
    }

    @Override
    public List<Integer> findMenuByRoleId(Integer roleId) {
        
        return roleMenuMapper.findMenuByRoleId(roleId);
    }
}
