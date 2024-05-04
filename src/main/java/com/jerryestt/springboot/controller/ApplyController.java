package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Constants;
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
    private TransportService transportService;

    @Resource
    private MessageService messageService;

    // 新增或更新
    @PostMapping
    public Result save(@RequestBody Apply apply) {
        Integer applyQuantity = apply.getApplyQuantity();
        if (applyQuantity <= 0) {
            return Result.error("申请数量不能小于等于0");
        }

        Apply saveapply = new Apply();
        saveapply.setUserId(apply.getUserId());
        saveapply.setMaterialId(apply.getMaterialId());
        saveapply.setApplyQuantity(applyQuantity);
        saveapply.setApplyReason(apply.getApplyReason());
        saveapply.setDestination(apply.getDestination());
        //获取当前时间
        LocalDateTime date = LocalDateTime.now();
        saveapply.setApplyTime(date);

        //设置申请状态为Pending（待审批）
        saveapply.setApprovalStatus(ApprovalStatus.Pending);

        //TODO: 把发送信息模块重构一个函数

        // 发送信息模块
        // 获取所有身份为管理员的用户
        List<User> users = userService.list(new QueryWrapper<User>().eq("role", "Admin"));
        // 获取用户id列表
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());

        // 发送信息
        for (Integer userId : userIds) {
            Message message = new Message();
            message.setReceiverId(userId);
            message.setTitle("新的申请");
            String username = apply.getUsername();
            String materialName = apply.getMaterialName();
            message.setContent("用户 " + username + " 申请了 " + apply.getApplyQuantity() + " 个 " + materialName + " ，请尽快审批");
            message.setSendTime(date);
            message.setType(Type.Emergency);
            messageService.save(message);
        }

        // 发送 申请信息发送成功 给申请人
        Message message = new Message();
        message.setReceiverId(apply.getUserId());
        message.setTitle("申请信息发送成功");
        message.setContent("您申请了 " + apply.getApplyQuantity() + " 个 " + apply.getMaterialName() + " ，请等待管理员审批");
        message.setSendTime(date);
        message.setType(Type.Info);
        messageService.save(message);


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
            // 通过用户id获取头像
            record.setAvatarurl(user.getAvatarurl());
            Material material = materialService.getById(record.getMaterialId());
            record.setMaterialName(material.getMaterialName());
            record.setMaterialType(material.getMaterialType());
            // 通过物资id获取物资图片
            record.setMaterialUrl(material.getMaterialUrl());
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
        Material material = materialService.getById(applyInfo.getMaterialId());
        Integer applyQuantity = applyInfo.getApplyQuantity(); // 申请数量
        Integer quantity = material.getQuantity(); // 仓库数量

        // 获取当前的申请状态
        ApprovalStatus CurrentStatus = applyInfo.getApprovalStatus();
        if (ApprovalStatus.Approved.equals(CurrentStatus)) {
            return Result.success("该申请已通过审批，等待运输分配司机中，请勿重复通过");
        }
        if (ApprovalStatus.Transporting.equals(CurrentStatus)) {
            return Result.success("该申请已在运输中,请勿重复通过");
        }
        if (ApprovalStatus.Completed.equals(CurrentStatus)) {
            return Result.success("该申请已完成，请勿重复通过");
        }
        if (ApprovalStatus.Rejected.equals(CurrentStatus)) {
            return Result.error("该申请已被管理员拒绝，请勿重复通过");
        }
        if (ApprovalStatus.Canceled.equals(CurrentStatus)) {
            return Result.error("该申请已被用户取消，请勿重复审批");
        }
        if (ApprovalStatus.Pending.equals(CurrentStatus)) {// 如果申请状态是Pending（待审批）
            applyInfo.setApprovalStatus(ApprovalStatus.Processing);// 设置申请状态为Processing（处理中）
            applyInfo.setApprovalComment("处理中");
        }
        if (ApprovalStatus.InsufficientStock.equals(CurrentStatus)) {
            if (applyQuantity <= quantity) {// 如果申请的数量不大于仓库总量
                applyInfo.setApprovalStatus(ApprovalStatus.Processing);// 设置申请状态为Processing（处理中）
                applyInfo.setApprovalComment("处理中");
                applyService.updateById(applyInfo);
                return approval(applyInfo);//重新进行函数
            }
            return Result.error("库存不足！不能通过审批，请补充库存");
        }

        LocalDateTime date = null;//获取当前时间给审批时间approvalTime
        date = LocalDateTime.now();
        try {
            applyInfo.setApprovalTime(date);
            applyService.updateById(applyInfo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        int quantityAfterUpdate = 0;

        try {
            // 2.接着在material_info表 通过material_id 把申请数量apply_quantity直接拿到后端作比较再更新仓库数量
            if (applyQuantity > quantity) {
                applyInfo.setApprovalStatus(ApprovalStatus.InsufficientStock);// 设置申请状态为InsufficientStock（库存不足）
                applyInfo.setApprovalComment("仓库库存不足");
                applyService.updateById(applyInfo);

                // 发送库存不足信息模块(给该用户和管理员)
                // 获取物资名称
                String materialName = material.getMaterialName();
                // 获取所有身份为管理员的用户
                List<User> users = userService.list(new QueryWrapper<User>().eq("role", "Admin"));
                // 获取用户id列表
                List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());
                // 发送信息
                for (Integer userId : userIds) {
                    Message message1 = new Message();
                    message1.setReceiverId(userId);
                    message1.setTitle("库存不足");
                    message1.setContent("仓库中的 " + materialName + " 不足 " + applyQuantity + " ，请补充库存");
                    message1.setSendTime(date);
                    message1.setType(Type.Error);
                    messageService.save(message1);
                }
                // 给用户
                Message message = new Message();
                message.setReceiverId(applyInfo.getUserId());
                message.setTitle("已通过审批，但库存不足，请等待");
                message.setContent("仓库中的 " + materialName + " 不足 " + applyQuantity + " ，请等待管理员补充库存，再发放");
                message.setSendTime(date);
                message.setType(Type.Error);
                messageService.save(message);

                return Result.error("仓库库存不足");
            }
            // 更新后的仓库数量
            quantityAfterUpdate = quantity - applyQuantity;
            material.setQuantity(quantityAfterUpdate);// 更新仓库数量
            materialService.updateById(material);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        // 2.5 新建运输订单
        Transport transport = new Transport();
        transport.setMaterialId(applyInfo.getMaterialId());
        transport.setUserId(applyInfo.getUserId());
        transport.setQuantity(applyInfo.getApplyQuantity());
        transport.setDestination(applyInfo.getDestination());
        transport.setTransportStatus(TransportStatus.Assign);
        // 获取当前时间
        transport.setStartTime(date);
        transportService.save(transport);
        // 获取运输订单的id,给usage_record表作出库记录用
        Integer transportId = transport.getTransportId();


        try {
            // 出库记录
            // 3.然后去usage_record表，通过user_id,material_id,apply_quantity,获取当前时间，更新表
            UsageRecord usageRecord = new UsageRecord();
            usageRecord.setUserId(applyInfo.getUserId());
            usageRecord.setMaterialId(applyInfo.getMaterialId());
            usageRecord.setUsageQuantity(applyInfo.getApplyQuantity());
            usageRecord.setQuantityBeforeApplication(quantity);// 申请使用之前的仓库数量
            usageRecord.setUsageReason(applyInfo.getApplyReason());// 使用原因
            usageRecord.setRecordTime(date);
            usageRecord.setTransportId(transportId);
            usageRecordService.save(usageRecord);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }


        try {
            // 5.更新申请状态为已审批
            applyInfo.setTransportId(transportId);
            applyInfo.setApprovalStatus(ApprovalStatus.Approved);
            applyInfo.setApprovalComment("已通过审批，等待运输分配司机中");

            // 发送申请通过信息模块(给用户)
            Message message = new Message();
            message.setReceiverId(applyInfo.getUserId());
            message.setTitle("申请通过");
            String materialName = material.getMaterialName();
            message.setContent("您申请的 " + materialName + " 已通过审批，等待运输分配司机中");
            message.setSendTime(date);
            message.setType(Type.Success);
            messageService.save(message);

            applyService.updateById(applyInfo);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        // 仓库预警（申请通过的实时预警）
        //TODO：(定时预警)把这个预警功能放到一个定时任务里，每天检查一次
        Integer threshold = material.getThreshold();
        if (quantityAfterUpdate < threshold) {
            applyInfo.setApprovalComment("审批成功，但仓库中的 " + material.getMaterialName() + " 还剩 " + quantityAfterUpdate + " ，需要增加库存啦！");
            applyService.updateById(applyInfo);

            // 发送预警信息模块(给管理员)
            // 获取所有身份为管理员的用户
            List<User> users = userService.list(new QueryWrapper<User>().eq("role", "Admin"));
            // 获取用户id列表
            List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());
            // 发送信息
            for (Integer userId : userIds) {
                Message message = new Message();
                message.setReceiverId(userId);
                message.setTitle("仓库预警");
                message.setContent("仓库中的 " + material.getMaterialName() + " 还剩 " + quantityAfterUpdate + " ，需要增加库存啦！");
                message.setSendTime(date);
                message.setType(Type.Warning);
                messageService.save(message);
            }

            return Result.success(Constants.SUCCESS_BUT_RUNNING_OUT_OF_MATERIAL, "仓库中的" + material.getMaterialName() + "还剩" + quantityAfterUpdate + "，需要增加库存啦！");
        }
        applyService.updateById(applyInfo);
        return Result.success("审批成功");
    }

    /**
     * 拒绝
     */
    @PutMapping("/reject")
    public Result reject(@RequestBody Apply apply) {
        // 获取approvalComment
        String approvalComment = apply.getApprovalComment();
        Apply applyInfo = applyService.getById(apply.getApplicationId());
        ApprovalStatus CurrentStatus = applyInfo.getApprovalStatus();
        if (ApprovalStatus.Approved.equals(CurrentStatus)) {
            return Result.success("该申请已通过审批，等待运输分配司机中，请勿重复拒绝");
        }
        if (ApprovalStatus.Transporting.equals(CurrentStatus)) {
            return Result.success("该申请已在运输中,请勿重复拒绝");
        }
        if (ApprovalStatus.InsufficientStock.equals(CurrentStatus)) {
            return Result.success("库存不足！不能拒绝审批，请补充库存");
        }
        if (ApprovalStatus.Completed.equals(CurrentStatus)) {
            return Result.success("该申请已完成，请勿重复拒绝");
        }
        if (ApprovalStatus.Rejected.equals(CurrentStatus)) {
            return Result.error("该申请已被管理员拒绝，请勿重复点击拒绝");
        }
        if (ApprovalStatus.Canceled.equals(CurrentStatus)) {
            return Result.error("该申请已被用户取消");
        }
        if (ApprovalStatus.Pending.equals(CurrentStatus)) {
            applyInfo.setApprovalStatus(ApprovalStatus.Rejected);
            if (approvalComment != null) {
                applyInfo.setApprovalComment(approvalComment);
            } else {
                applyInfo.setApprovalComment("已被管理员拒绝");
            }
        }
        // 获取当前时间
        LocalDateTime date = LocalDateTime.now();
        applyInfo.setApprovalTime(date);
        applyService.updateById(applyInfo);
        
        // 发送拒绝信息模块(给用户)
        Message message = new Message();
        message.setReceiverId(applyInfo.getUserId());
        message.setTitle("申请被拒绝");
        String materialName = materialService.getById(applyInfo.getMaterialId()).getMaterialName();
        message.setContent("您申请的 " + materialName + " 已被管理员拒绝");
        message.setSendTime(date);
        message.setType(Type.Error);
        messageService.save(message);
        
        return Result.success("已拒绝");
    }

}
