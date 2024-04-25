package com.jerryestt.springboot.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.log.Log;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.common.Constants;
import com.jerryestt.springboot.controller.dto.UserDTO;
import com.jerryestt.springboot.entity.Menu;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.exception.ServiceException;
import com.jerryestt.springboot.mapper.RoleMapper;
import com.jerryestt.springboot.mapper.RoleMenuMapper;
import com.jerryestt.springboot.mapper.UserMapper;
import com.jerryestt.springboot.service.IMenuService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.utils.TokenUtils;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;

@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    private static final Log LOG = Log.get();

    @Resource//注入RoleMapper
    private RoleMapper roleMapper;

    @Resource
    private RoleMenuMapper roleMenuMapper;

    @Resource
    private IMenuService menuService;

    @Override
    public UserDTO login(UserDTO userDTO) {
        User one = getUserInfo(userDTO);
        if (one != null) {// 查询成功
            BeanUtil.copyProperties(one, userDTO, true);
            // 设置token
            String token = TokenUtils.genToken(one.getUserId().toString(), one.getPassword());
            userDTO.setToken(token);

            String rolename = one.getUserRole(); // 获取用户角色
            
            List<Menu> roleMenus = getMenusByRoleName(rolename);// 用 用户角色 查询 该角色对应的菜单列表
            userDTO.setMenus(roleMenus);// 设置用户菜单
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
    
    /**
     * 封装 用 角色名 查询 该角色对应的菜单列表
     * @param rolename 角色名
     * @return List<Menu> roleMenus 菜单列表
     * */
    private List<Menu> getMenusByRoleName(String rolename) {
        Integer roleId = roleMapper.selectByrolename(rolename);// 根据角色名称 查询角色id
        List<Integer> menuIds = roleMenuMapper.findMenuByRoleId(roleId);// 根据角色id查询这个角色拥有的菜单id

        List<Menu> menus = menuService.findMenus("");// 查询所有菜单

        List<Menu> roleMenus = new ArrayList<>();// 保存角色对应的菜单

        //筛选出当前用户角色对应的菜单
        for (Menu menu : menus) {// 遍历所有菜单
            if (menuIds.contains(menu.getMenuId())) {// 如果菜单id在当前用户角色对应的菜单id中
                roleMenus.add(menu);
            }
            List<Menu> children = menu.getChildren();// 获取菜单的子菜单
            children.removeIf(child -> !menuIds.contains(child.getMenuId()));// 筛选出子菜单中在当前用户角色对应的菜单id中的子菜单

            if (!children.isEmpty() && !roleMenus.contains(menu)) {// 如果子菜单不为空且roleMenus列表中不包含父菜单
                Menu parent = new Menu();
                BeanUtil.copyProperties(menu, parent, true);
                parent.setChildren(children);
                roleMenus.add(parent);
            }
        }

//        // 筛选出与角色关联的菜单
//        for (Menu menu : menus) {
//            List<Menu> children = menu.getChildren();// 获取子菜单
//            for (Menu child : children) {
//                if (menuIds.contains(child.getMenuId())) {// 如果子菜单的id在与角色关联的菜单id列表中
//                    if (!roleMenus.contains(menu)) {// 如果父菜单还没有被添加到roleMenus列表中
//                        roleMenus.add(menu);// 先添加父菜单
//                    }
//                    roleMenus.add(child);// 然后添加子菜单
//                }
//            }
//        }
        return roleMenus;
    }
    
}
