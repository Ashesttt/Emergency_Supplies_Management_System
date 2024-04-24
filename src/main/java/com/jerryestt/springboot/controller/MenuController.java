package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Menu;
import com.jerryestt.springboot.service.IMenuService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/menu")
public class MenuController {

    @Resource
    private IMenuService menuService;


    // 新增或更新
    @PostMapping
    public Result save(@RequestBody Menu menu) {
        return Result.success(menuService.saveOrUpdate(menu));
    }

    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(menuService.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + menuService.removeByIds(ids) + "条数据");
    }

    @GetMapping
    public Result findAll(@RequestParam(defaultValue = "") String menuname) {
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();
        queryWrapper.like("menuname", menuname);
        //查询所有数据
        // 原理：过滤出所有的父菜单项(就是Pid=null)，并收集到一个新的列表中。
        // 接着，对于每一个父菜单项，再次使用Stream API过滤出所有的子菜单项，并设置到父菜单的children属性中。
        List<Menu> list = menuService.list(queryWrapper);
        List<Menu> parentNode = list.stream().filter(menu -> menu.getPid() == null).collect(Collectors.toList());
        for (Menu menu : parentNode) {
            List<Menu> children = list.stream().filter(m -> menu.getMenuId().equals(m.getPid())).collect(Collectors.toList());
            menu.setChildren(children);
        }
        return Result.success(parentNode);
    }

    // id查询
    @GetMapping("/{id}")
    public Result findById(@PathVariable Integer id) {
        return Result.success(menuService.getById(id));
    }

    // 分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String menuname) {

        IPage<Menu> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Menu> queryWrapper = new QueryWrapper<>();

        /**
         * 模糊查询
         * */
        if (!"".equals(menuname)) {// menuname
            queryWrapper.like("menuname", menuname);
        }
        return Result.success(menuService.page(page, queryWrapper));
    }
}
