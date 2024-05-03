package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.UpdateWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.*;
import com.jerryestt.springboot.mapper.ApplyMapper;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.TransportService;
import com.jerryestt.springboot.service.UserMaterialService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/transport")
public class TransportController {

    @Resource
    private IMaterialService materialService;

    @Resource
    private IUserService userService;

    @Resource
    private TransportService transportService;


    @Resource
    private ApplyMapper applyMapper;
    
    @Resource
    private UserMaterialService userMaterialService;

    //分页查询
    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") Integer transportId,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String materialName,
                           @RequestParam(defaultValue = "") String driverName,
                           @RequestParam(defaultValue = "") String transportStatus) {

        IPage<Transport> page = new Page<>(pageNum, pageSize);

        /**
         * 模糊查询
         * */
        // 用 用户名 模糊查询 用户id 
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        List<Integer> userIds = null;
        if (!"".equals(username)) { // 如果用户名不为空
            userQueryWrapper.like("username", username);
            List<User> users = userService.list(userQueryWrapper);
            userIds = users.stream().map(User::getUserId).collect(Collectors.toList());
        }

        // 用 物资名称 模糊查询 物资的id
        QueryWrapper<Material> materialQueryWrapper = new QueryWrapper<>();
        List<Integer> materialIds = null;
        if (!"".equals(materialName)) {
            materialQueryWrapper.like("material_name", materialName);
            List<Material> materials = materialService.list(materialQueryWrapper);
            materialIds = materials.stream().map(Material::getMaterialId).collect(Collectors.toList());
        }


        // 用 司机名 模糊查询 司机id
        QueryWrapper<User> driverQueryWrapper = new QueryWrapper<>();
        List<Integer> driverIds = null;
        if (!"".equals(driverName)) {
            driverQueryWrapper.like("username", driverName);
            List<User> drivers = userService.list(driverQueryWrapper);
            driverIds = drivers.stream().map(User::getUserId).collect(Collectors.toList());
        }


        // 用 运输id列表、用户id列表、物资id列表、司机id列表 查询
        QueryWrapper<Transport> queryWrapper = new QueryWrapper<>();
        if (userIds != null && !userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (materialIds != null && !materialIds.isEmpty()) {
            queryWrapper.in("material_id", materialIds);
        }
        if (driverIds != null && !driverIds.isEmpty()) {
            queryWrapper.in("driver_id", driverIds);
        }
        if (!"".equals(transportStatus)) {
            queryWrapper.like("transport_status", transportStatus);
        }
        if (transportId != null) {
            queryWrapper.eq("transport_id", transportId);
        }
        IPage<Transport> transportIPage = transportService.page(page, queryWrapper);
        List<Transport> records = transportIPage.getRecords();
        records.forEach(transport -> {
            User user = userService.getById(transport.getUserId());
            transport.setUsername(user.getUsername());
            transport.setAvatarurl(user.getAvatarurl());
            Material material = materialService.getById(transport.getMaterialId());
            transport.setMaterialName(material.getMaterialName());
            transport.setMaterialUrl(material.getMaterialUrl());
            // 如果司机id不为空，就将司机名和司机头像url存入transport表中
            if (transport.getDriverId() != null) {
                User driver = userService.getById(transport.getDriverId());
                transport.setDriverName(driver.getUsername());
                transport.setDriverAvatarurl(driver.getAvatarurl());
            }
        });
        return Result.success(transportIPage);
    }

    @GetMapping("/transportStatus")
    public Result transportStatus() {
        TransportStatus[] transportStatuses = TransportStatus.values();
        return Result.success(transportStatuses);
    }

    // 分配司机
    @PostMapping("/assign")
    public Result assign(@RequestBody Map<String, Integer> params) {
        Integer transportId = params.get("transportId");
        Integer driverId = params.get("driverId");


        Transport transport = transportService.getById(transportId);
        // 获取当前运输状态
        TransportStatus currentStatus = transport.getTransportStatus();
        if (TransportStatus.Transporting.equals(currentStatus)) {
            return Result.error("运输中的运输单不能再分配司机");
        }
        if (TransportStatus.Arrived.equals(currentStatus)) {
            return Result.error("已完成的运输单不能再分配司机");
        }

        if (TransportStatus.Assign.equals(currentStatus)) {
            transport.setDriverId(driverId);
            transport.setTransportStatus(TransportStatus.Transporting);
            transportService.updateById(transport);

            // 根据运输id查询apply_info表中的申请信息,并更新申请信息的状态
            Apply apply = applyMapper.selectApplyByTransportId(transportId);
            apply.setApprovalStatus(ApprovalStatus.Transporting);
            apply.setApprovalComment("已分配到司机，" + userService.getById(driverId).getUsername() + "正在运输中");
            applyMapper.updateById(apply);
        }

        return Result.success("分配司机成功");
    }

    /**
     * 司机已到达
     */
    @PutMapping("/arrive")
    public Result arrive(@RequestBody Map<String, Integer> params) {
        Integer transportId = params.get("transportId");
        Transport transport = transportService.getById(transportId);
        // 获取当前运输状态
        TransportStatus currentStatus = transport.getTransportStatus();
        if (TransportStatus.Arrived.equals(currentStatus)) {
            return Result.error("已到达的运输单不能再次确认到达");
        }
        if (TransportStatus.Transporting.equals(currentStatus)) {
            transport.setTransportStatus(TransportStatus.Arrived);
            // 获取当前时间
            LocalDateTime arriveTime = LocalDateTime.now();
            transport.setEndTime(arriveTime);
            transportService.updateById(transport);

            // 根据运输id查询apply_info表中的申请信息,并更新申请信息的状态
            Apply apply = applyMapper.selectApplyByTransportId(transportId);
            apply.setApprovalStatus(ApprovalStatus.Completed);
            apply.setApprovalComment(userService.getById(transport.getDriverId()).getUsername() + "已到达，运输完成，到达时间：" + arriveTime);
            applyMapper.updateById(apply);
            
            try {
                // 记录
                // 4.最后去user_material表，通过user_id,material_id,apply_quantity来增加表里的quantity
                QueryWrapper<UserMaterial> queryWrapper = new QueryWrapper<>();
                queryWrapper.eq("user_id", apply.getUserId());
                queryWrapper.eq("material_id", apply.getMaterialId());
                UserMaterial userMaterial = userMaterialService.getOne(queryWrapper);
                if (userMaterial != null) {
                    // 如果存在这样的记录，更新它
                    userMaterial.setQuantity(userMaterial.getQuantity() + apply.getApplyQuantity());
                    UpdateWrapper<UserMaterial> updateWrapper = new UpdateWrapper<>();
                    updateWrapper.eq("user_id", userMaterial.getUserId()).eq("material_id", userMaterial.getMaterialId());
                    userMaterialService.update(userMaterial, updateWrapper);
                } else {
                    // 如果不存在这样的记录，插入一条新的记录
                    userMaterial = new UserMaterial();
                    userMaterial.setUserId(apply.getUserId());
                    userMaterial.setMaterialId(apply.getMaterialId());
                    userMaterial.setQuantity(apply.getApplyQuantity());
                    userMaterialService.save(userMaterial);
                }
            } catch (Exception e) {
                throw new RuntimeException(e);
            }
            
        }
        return Result.success("确认到达成功");
    }
}
