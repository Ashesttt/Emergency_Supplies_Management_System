package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Role;
import com.jerryestt.springboot.service.IRoleService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;

@RestController
@RequestMapping("/role")
public class RoleController {

    @Resource
    private IRoleService roleService;


    // 新增或更新
    @PostMapping
    public Result save(@RequestBody Role role) {
        return Result.success(roleService.saveOrUpdate(role));
    }

    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(roleService.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + roleService.removeByIds(ids) + "条数据");
    }

    // 查询所有数据
    @GetMapping
    public Result findAll() {
        return Result.success(roleService.list());
    }

    // id查询
    @GetMapping("/{id}")
    public Result findById(@PathVariable Integer id) {
        return Result.success(roleService.getById(id));
    }

    // 分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String rolename) {

        IPage<Role> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Role> queryWrapper = new QueryWrapper<>();

        /**
         * 模糊查询
         * */
        if (!"".equals(rolename)) {// rolename
            queryWrapper.like("rolename", rolename);
        }
//        queryWrapper.orderByDesc("id");// id倒序
        return Result.success(roleService.page(page, queryWrapper));
    }


    /**
     * 绑定角色和菜单的关系
     *
     * @param roleId  角色id
     * @param menuIds 菜单id集合
     */
    @PostMapping("/roleMenu/{roleId}")
    public Result roleMenu(@PathVariable Integer roleId, @RequestBody List<Integer> menuIds) {
        roleService.setRoleMenuRelation(roleId, menuIds);
        return Result.success();
    }

    /**
     * 根据角色id查询
     */
    @GetMapping("/roleMenu/{roleId}")
    public Result findMenuByRoleId(@PathVariable Integer roleId) {
        List<Integer> MenuId = roleService.findMenuByRoleId(roleId);
        return Result.success(MenuId);
    }
}
