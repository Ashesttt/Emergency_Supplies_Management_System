package com.jerryestt.springboot.service;

import com.jerryestt.springboot.entity.Menu;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【menu_info】的数据库操作Service
* @createDate 2024-04-23 17:42:23
*/
public interface IMenuService extends IService<Menu> {

    List<Menu> findMenus(String menuname);
}
