package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.*;
import com.jerryestt.springboot.service.*;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/apply")
public class ApplyController {

    @Resource
    private ApplyService applyService;


    @Resource
    private IMaterialService materialService;

    @Resource
    private IUserService userService;

    @Resource
    private UsageRecordService usageRecordService;

    @Resource
    private UserMaterialService userMaterialService;

    // 新增或更新
    @PostMapping
    public Result save(@RequestBody Apply apply) {
        // form中只有userId，materialId，apply_quantity，apply_reason
        // apply_time和approval_status由后端自动生成
        Apply saveapply = new Apply();
        saveapply.setUserId(apply.getUserId());
        saveapply.setMaterialId(apply.getMaterialId());
        saveapply.setApplyQuantity(apply.getApplyQuantity());
        saveapply.setApplyReason(apply.getApplyReason());
        //获取当前时间
        LocalDateTime date = LocalDateTime.now();
        saveapply.setApplyTime(date);

        //设置申请状态为Pending（待审批）
        saveapply.setApprovalStatus(ApprovalStatus.Pending);

        return Result.success(applyService.saveOrUpdate(saveapply));
    }

    // 分页查询
    //TODO： 以approvalStatus排序
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String approvalStatus) {

        IPage<Apply> page = new Page<>(pageNum, pageSize);

        /**
         * 模糊查询
         * */
        // 用 用户名 模糊查询 用户id 
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        if (!"".equals(username)) { // 如果用户名不为空
            userQueryWrapper.like("username", username);
        }
        List<User> users = userService.list(userQueryWrapper);
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());// 获取用户id列表

        // 用 物资名称 模糊查询 物资的id
        QueryWrapper<Material> materialQueryWrapper = new QueryWrapper<>();
        if (!"".equals(materialName)) {
            materialQueryWrapper.like("material_name", materialName);
        }

        List<Material> materials = materialService.list(materialQueryWrapper);
        List<Integer> materialIds = materials.stream().map(Material::getMaterialId).collect(Collectors.toList());// 获取物资id列表

        // 用 用户id和物资id 查询 该用户拥有的物资
        QueryWrapper<Apply> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (!materialIds.isEmpty()) {
            queryWrapper.in("material_id", materialIds);
        }
        if (!"".equals(approvalStatus)) {
            queryWrapper.in("approval_status", approvalStatus);
        }

        IPage<Apply> applyIPage = applyService.page(page, queryWrapper);
        List<Apply> records = applyIPage.getRecords();
        records.forEach(record -> {
            User user = userService.getById(record.getUserId());
            record.setUsername(user.getUsername());
            record.setUserRole(user.getUserRole());
            Material material = materialService.getById(record.getMaterialId());
            record.setMaterialName(material.getMaterialName());
            record.setMaterialType(material.getMaterialType());
//            record.setQuantity(material.getQuantity());// 不加这个仓库总数，因为他会变的
        });
        return Result.success(applyIPage);
    }

    // 获取所有申请状态
    @GetMapping("/approvalStatus")
    public Result findAllapprovalStatus() {
        ApprovalStatus[] approvalStatus = ApprovalStatus.values();
        return Result.success(approvalStatus);
    }

    /**
     * 审批
     * 流程：
     * 1.首先在apply_info表里，通过application_id 来更新表：把申请状态approvalStatus的值变成Approved 在获取当前时间 给approval_time
     * 2.接着在material_info表 通过material_id 把申请数量apply_quantity直接拿到后端作比较再更新仓库数量
     * 3.然后去usage_record表，通过user_id,material_id,apply_quantity,获取当前时间，更新表
     * 4.最后去user_material表，通过user_id,material_id,apply_quantity来增加表里的quantity
     **/
    @PutMapping("/approval")
    @Transactional// 事务:保证多个操作要么同时成功，要么同时失败
    public Result approval(@RequestBody Apply apply) {
        // 1.首先在apply_info表里，通过application_id 来更新表：把申请状态approvalStatus的值变成Approved 在获取当前时间 给approval_time
        Apply applyInfo = applyService.getById(apply.getApplicationId());
        applyInfo.setApprovalStatus(ApprovalStatus.Approved);// 设置申请状态为Approved（已通过）
        LocalDateTime date = LocalDateTime.now();//获取当前时间给审批时间approvalTime
        applyInfo.setApprovalTime(date);
        applyService.updateById(applyInfo);

        // 2.接着在material_info表 通过material_id 把申请数量apply_quantity直接拿到后端作比较再更新仓库数量
        Material material = materialService.getById(applyInfo.getMaterialId());
        Integer applyQuantity = applyInfo.getApplyQuantity(); // 申请数量
        Integer quantity = material.getQuantity(); // 仓库数量
        if (applyQuantity > quantity) {
            return Result.error("仓库数量不足");
        }
        //TODO:仓库预警（仓库数量低于一定值时，发送邮件给管理员）
        material.setQuantity(quantity - applyQuantity);// 更新仓库数量
        materialService.updateById(material);

        // 3.然后去usage_record表，通过user_id,material_id,apply_quantity,获取当前时间，更新表
        UsageRecord usageRecord = new UsageRecord();
        usageRecord.setUserId(applyInfo.getUserId());
        usageRecord.setMaterialId(String.valueOf(applyInfo.getMaterialId()));
        usageRecord.setUsageQuantity(applyInfo.getApplyQuantity());
        usageRecord.setQuantityBeforeApplication(quantity);// 申请使用之前的仓库数量
        usageRecord.setUsageReason(applyInfo.getApplyReason());// 使用原因
        usageRecord.setRecordTime(date);
        usageRecordService.save(usageRecord);


        // 4.最后去user_material表，通过user_id,material_id,apply_quantity来增加表里的quantity
        QueryWrapper<UserMaterial> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", applyInfo.getUserId());
        queryWrapper.eq("material_id", applyInfo.getMaterialId());

        UserMaterial userMaterial = userMaterialService.getOne(queryWrapper);
        if (userMaterial != null) {
            // 如果存在这样的记录，更新它
            userMaterial.setQuantity(userMaterial.getQuantity() + applyInfo.getApplyQuantity());
            UpdateWrapper<UserMaterial> updateWrapper = new UpdateWrapper<>();
            updateWrapper.eq("user_id", userMaterial.getUserId()).eq("material_id", userMaterial.getMaterialId());
            userMaterialService.update(userMaterial, updateWrapper);
        } else {
            // 如果不存在这样的记录，插入一条新的记录
            userMaterial = new UserMaterial();
            userMaterial.setUserId(applyInfo.getUserId());
            userMaterial.setMaterialId(applyInfo.getMaterialId());
            userMaterial.setQuantity(applyInfo.getApplyQuantity());
            userMaterialService.save(userMaterial);
        }
        return Result.success("审批成功");
    }

}
