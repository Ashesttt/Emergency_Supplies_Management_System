package com.jerryestt.springboot.service.impl;

import cn.hutool.core.util.StrUtil;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Menu;
import com.jerryestt.springboot.service.IMenuService;
import com.jerryestt.springboot.mapper.MenuMapper;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
* @author mxy
* @description 针对表【menu_info】的数据库操作Service实现
* @createDate 2024-04-23 17:42:23
*/
@Service
public class IMenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

    @Override
    public List<Menu> findMenus(String menuname) {
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        if (StrUtil.isNotBlank(menuname)){  // 判断是否为空
            queryWrapper.like("menuname", menuname);
        }
        //查询所有数据
        // 原理：过滤出所有的父菜单项(就是Pid=null)，并收集到一个新的列表中。
        // 接着，对于每一个父菜单项，再次使用Stream API过滤出所有的子菜单项，并设置到父菜单的children属性中。
        List<Menu> list = list(queryWrapper);
        List<Menu> parentNode = list.stream().filter(menu -> menu.getPid() == null).collect(Collectors.toList());
        for (Menu menu : parentNode) {
            List<Menu> children = list.stream().filter(m -> menu.getMenuId().equals(m.getPid())).collect(Collectors.toList());
            menu.setChildren(children);
        }
        return parentNode;
    }
}




