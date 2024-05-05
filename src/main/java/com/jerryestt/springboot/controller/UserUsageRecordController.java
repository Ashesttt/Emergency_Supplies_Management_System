package com.jerryestt.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.entity.UserUsageRecord;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.UsageRecordService;
import com.jerryestt.springboot.service.UserUsageRecordService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/userusagerecord")
public class UserUsageRecordController {

    @Resource
    private UserUsageRecordService userUsageRecordService;
    @Resource
    private UsageRecordService usageRecordService;

    @Resource
    private IMaterialService materialService;

    @Resource
    private IUserService userService;

    // 删除
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(userUsageRecordService.removeById(id));
    }

    // 批量删除
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + userUsageRecordService.removeByIds(ids) + "条数据");
    }

    // 分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String userRole,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String materialType) {

        IPage<UserUsageRecord> page = new Page<>(pageNum, pageSize);
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
        QueryWrapper<UserUsageRecord> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (!materialIds.isEmpty()) {
            queryWrapper.in("material_id", materialIds);
        }
        
        queryWrapper.orderByDesc("record_time"); // 按照创建时间降序排列
        
        // 再用 用户id和物资id 分别查询 用户名，用户身份，物资名称，物资种类，物资仓库数量
        IPage<UserUsageRecord> userUsageRecordPage = userUsageRecordService.page(page, queryWrapper);// 分页查询
        List<UserUsageRecord> records = userUsageRecordPage.getRecords();
        records.forEach(record -> {// 遍历记录列表
            User user = userService.getById(record.getUserId());
            Material material = materialService.getById(record.getMaterialId());
            // 查询用户名
            record.setUserName(user.getUsername());
            // 查询用户身份
            record.setUserRole(user.getUserRole());
            // 查询用户头像
            record.setAvatarurl(user.getAvatarurl());
            // 查询物资名称
            record.setMaterialName(material.getMaterialName());
            // 查询物资种类
            record.setMaterialType(material.getMaterialType());
            // 查询物资图片
            record.setMaterialUrl(material.getMaterialUrl());
        });
        return Result.success(userUsageRecordPage);
    }

}
