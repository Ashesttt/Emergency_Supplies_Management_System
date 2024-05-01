package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.UsageRecord;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.mapper.MaterialMapper;
import com.jerryestt.springboot.mapper.UsageRecordMapper;
import com.jerryestt.springboot.mapper.UserMapper;
import com.jerryestt.springboot.service.UsageRecordService;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
 * @author Rick SanChez
 * @description 针对表【usage_record】的数据库操作Service实现
 * @createDate 2024-04-27 19:41:20
 */
@Service
public class UsageRecordServiceImpl extends ServiceImpl<UsageRecordMapper, UsageRecord>
        implements UsageRecordService {

    @Resource
    private UserMapper userMapper;

    @Resource
    private MaterialMapper materialMapper;

    @Override
    public List<UsageRecord> findAll() {
        List<UsageRecord> usageRecords = this.list();
        for (UsageRecord usageRecord : usageRecords) {
            try {
                Integer userId = usageRecord.getUserId();
                User user = userMapper.selectById(userId);
                if (user == null) {
                    log.warn("No user found with id: " + userId);
                } else {
                    usageRecord.setUser(user);
                }

                String materialId = String.valueOf(usageRecord.getMaterialId());
                Material material = materialMapper.selectById(materialId);
                if (material == null) {
                    log.warn("No material found with id: " + materialId);
                } else {
                    usageRecord.setMaterial(material);
                }
            } catch (Exception e) {
                log.error("Error processing usage record: " + usageRecord.getUsageRecordId(), e);
            }
        }
        return usageRecords;
    }


}




