package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.UsageRecord;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.UsageRecordService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/usagerecord")
public class UsageRecordController {

    @Resource
    private UsageRecordService usageRecordService;

    @Resource
    private IMaterialService materialService;

    @Resource
    private IUserService userService;

    // 新增或更新
    @PostMapping
    public Result save(@RequestBody UsageRecord usageRecord) {
        return Result.success(usageRecordService.saveOrUpdate(usageRecord));
    }

    // 根据id查询
    @GetMapping("/{id}")
    public Result findById(@PathVariable Integer id) {
        return Result.success(usageRecordService.getById(id));
    }


    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(usageRecordService.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + usageRecordService.removeByIds(ids) + "条数据");
    }

    // 查询所有
    @GetMapping
    public Result findAll() {
        return Result.success(usageRecordService.findAll());
    }


    /**
     * 分页查询
     *                @param pageNum 当前页
     *                pageSize 每页显示的条数
     *                username 用户名
     *                userRole 用户身份
     *                materialName 物资名称
     *                materialType 物资种类
     *                @return
     *     
     * */
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String userRole,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String materialType) {

        IPage<UsageRecord> page = new Page<>(pageNum, pageSize);
        /**
         * 模糊查询
         * */
        // 用 用户名和用户身份 模糊查询 用户的id
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        if (!"".equals(username)) { // 如果用户名不为空
            userQueryWrapper.like("username", username);
        }
        if (!"".equals(userRole)) {
            userQueryWrapper.like("role", userRole);
        }

        List<User> users = userService.list(userQueryWrapper);
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());// 获取用户id列表

        // 用 物资名称和物资种类 模糊查询 物资的id
        QueryWrapper<Material> materialQueryWrapper = new QueryWrapper<>();
        if (!"".equals(materialName)) {
            materialQueryWrapper.like("material_name", materialName);
        }
        if (!"".equals(materialType)) {
            materialQueryWrapper.like("material_type", materialType);
        }

        List<Material> materials = materialService.list(materialQueryWrapper);
        List<Integer> materialIds = materials.stream().map(Material::getMaterialId).collect(Collectors.toList());// 获取物资id列表

        // 用 用户id和物资id 查询 使用记录
        QueryWrapper<UsageRecord> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (!materialIds.isEmpty()) {
            queryWrapper.in("material_id", materialIds);
        }
        
        // 再用 用户id和物资id 分别查询 用户名，用户身份，物资名称，物资种类，物资仓库数量
        IPage<UsageRecord> usageRecordPage = usageRecordService.page(page, queryWrapper);// 分页查询
        List<UsageRecord> records = usageRecordPage.getRecords();// 获取记录列表
        records.forEach(record -> {// 遍历记录列表
            User user = userService.getById(record.getUserId());
            Material material = materialService.getById(record.getMaterialId());
            record.setUserName(user.getUsername());
            record.setUserRole(user.getUserRole());
            record.setAvatarurl(user.getAvatarurl());
            record.setMaterialName(material.getMaterialName());
            record.setMaterialType(material.getMaterialType());
            record.setMaterialUrl(material.getMaterialUrl());
        });
        
        

        return Result.success(usageRecordPage);
    }

}
