package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.entity.UserMaterial;
import com.jerryestt.springboot.entity.UserUsageRecord;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.UserMaterialService;
import com.jerryestt.springboot.service.UserUsageRecordService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/user_material")
public class UserMaterialController {

    @Resource
    private UserMaterialService userMaterialService;

    @Resource
    private IMaterialService materialService;

    @Resource
    private IUserService userService;

    @Resource
    private UserUsageRecordService userUsageRecordService;

    // 用user_id和material_id删除
    @PostMapping("/{user_id}/{material_id}")
    public Result deleteByUserIdAndMaterialId(@PathVariable Integer user_id, @PathVariable Integer material_id) {
        QueryWrapper<UserMaterial> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", user_id);
        queryWrapper.eq("material_id", material_id);
        return Result.success(userMaterialService.remove(queryWrapper));
    }

    // 分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String userRole,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String materialType) {

        IPage<UserMaterial> page = new Page<>(pageNum, pageSize);

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

        // 用 用户id和物资id 查询 该用户拥有的物资
        QueryWrapper<UserMaterial> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (!materialIds.isEmpty()) {
            queryWrapper.in("material_id", materialIds);
        }

        IPage<UserMaterial> userMaterialIPage = userMaterialService.page(page, queryWrapper);
        List<UserMaterial> records = userMaterialIPage.getRecords();
        records.forEach(record -> {
            User user = userService.getById(record.getUserId());
            record.setUsername(user.getUsername());
            record.setUserRole(user.getUserRole());
            record.setAvatarurl(user.getAvatarurl());
            Material material = materialService.getById(record.getMaterialId());
            record.setMaterialName(material.getMaterialName());
            record.setMaterialType(material.getMaterialType());
            record.setMaterialUrl(material.getMaterialUrl());
        });
        return Result.success(userMaterialIPage);
    }

    // 使用
    @PostMapping("/use")
    public Result use(@RequestParam(defaultValue = "") Integer userId,
                      @RequestParam(defaultValue = "") Integer materialId,
                      @RequestParam(defaultValue = "") Integer usage_quantity,
                      @RequestParam(defaultValue = "") String usage_reason) {

        QueryWrapper<UserMaterial> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", userId);
        queryWrapper.eq("material_id", materialId);
        UserMaterial userMaterial = userMaterialService.getOne(queryWrapper);

        // 使用前这个用户所拥有该物资的数量
        int quantity = userMaterial.getQuantity();
        if (quantity >= usage_quantity) { // 用户拥有的总数大于用户使用的
            int afteruse = quantity - usage_quantity;
            userMaterial.setQuantity(afteruse);

            // 没有主键如何更新
            // 创建一个UpdateWrapper
            UpdateWrapper<UserMaterial> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("user_id", userId);
            updateWrapper.eq("material_id", materialId);

            // 使用UpdateWrapper来更新记录
            userMaterialService.update(userMaterial, updateWrapper);

            // 记录使用记录
            UserUsageRecord userUsageRecord = new UserUsageRecord();
            userUsageRecord.setUserId(userId);
            userUsageRecord.setMaterialId(materialId);
            userUsageRecord.setQuantityBeforeUse(quantity);// 使用前数量
            userUsageRecord.setUserUsageQuantity(usage_quantity);// 使用数量
            userUsageRecord.setUsageReason(usage_reason);// 使用原因
            LocalDateTime now = LocalDateTime.now();            //获取当前时间
            userUsageRecord.setRecordTime(now);
            userUsageRecordService.save(userUsageRecord);
        } else {
            return Result.error("用户拥有的总数小于用户使用的");
        }
        return Result.success("使用成功");
    }
}
