package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Menu;
import com.jerryestt.springboot.service.IMenuService;
import com.jerryestt.springboot.mapper.MenuMapper;
import org.springframework.stereotype.Service;

/**
* @author mxy
* @description 针对表【menu_info】的数据库操作Service实现
* @createDate 2024-04-23 17:42:23
*/
@Service
public class IMenuServiceImpl extends ServiceImpl<MenuMapper, Menu> implements IMenuService {

}




