package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.UserUsageRecord;
import com.jerryestt.springboot.service.UserUsageRecordService;
import com.jerryestt.springboot.mapper.UserUsageRecordMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【user_usage_record】的数据库操作Service实现
* @createDate 2024-05-01 12:22:02
*/
@Service
public class UserUsageRecordServiceImpl extends ServiceImpl<UserUsageRecordMapper, UserUsageRecord>
    implements UserUsageRecordService{

}




