package com.jerryestt.springboot.tasks;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.jerryestt.springboot.entity.*;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.MessageService;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Component;

import javax.annotation.Resource;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Component
public class RepertoryAlert {
    
    
    @Resource
    private MessageService messageService;
    
    @Resource
    private IMaterialService materialService;
    
    @Resource
    private IUserService userService;
    
    
    @Scheduled(cron = "0 0 8 * * ?")// 每天早上8点执行
    public void sendAlert() {
        // 查看仓库库存，如果低于阈值，则发送警告
        
        // 1. 获取全部仓库库存
        StringBuilder content = new StringBuilder();
        List<Material> materialList = materialService.list();
        for (Material material : materialList) {
            if (material.getQuantity() <= material.getThreshold()) {// 库存低于阈值
                //2. 获取并拼接需要的信息
                content.append("物料：").append(material.getMaterialName()).append("当前库存数量：").append(material.getQuantity()).append(" ，低于阈值： ").append(material.getThreshold()).append("<br>");
            }
        }
        content.append("请及时补充库存！");
        
        // 3. 获取全部管理员
        List<User> users = userService.list(new QueryWrapper<User>().eq("role", "Admin"));
        // 获取用户id列表
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());
        for (Integer userId : userIds) {
            // 4. 发送警告
            Message message = new Message();
            message.setTitle("每日库存警告报告");
            message.setContent(content.toString());
            message.setType(Type.Warning);
            message.setReceiverId(userId);
            message.setSendTime(LocalDateTime.now());
            messageService.save(message);
        }
    }
    
    // 过期物料提醒
    // 每天早上8点执行
//    @Scheduled(cron = "0 0 8 * * ?")
    @Scheduled(cron = "*/5 * * * * ?")
    public void sendExpireAlert() {
        // 1. 获取全部仓库库存
        StringBuilder content = new StringBuilder();
        List<Material> materialList = materialService.list();
        for (Material material : materialList) {
            if (material.getExpiryDate().isBefore(LocalDate.now())) {// 物料已过期
                Status status = material.getStatus();
                if (status != Status.Expired) {
                    //把这个物资的状态改为已过期
                    material.setStatus(Status.Expired);
                    materialService.updateById(material);
                }
                //2. 获取并拼接需要的信息
                content.append("物料：").append(material.getMaterialName()).append("已过期，过期时间：").append(material.getExpiryDate()).append("<br>");
            }
        }
        content.append("请及时处理！");
        
        // 3. 获取全部管理员
        List<User> users = userService.list(new QueryWrapper<User>().eq("role", "Admin"));
        // 获取用户id列表
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());
        for (Integer userId : userIds) {
            // 4. 发送警告
            Message message = new Message();
            message.setTitle("每日过期物料提醒");
            message.setContent(content.toString());
            message.setType(Type.Warning);
            message.setReceiverId(userId);
            message.setSendTime(LocalDateTime.now());
            messageService.save(message);
        }
    }
    
    
}
