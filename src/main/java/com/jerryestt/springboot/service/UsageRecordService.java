package com.jerryestt.springboot.service;

import com.jerryestt.springboot.entity.UsageRecord;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【usage_record】的数据库操作Service
* @createDate 2024-04-27 19:41:20
*/
public interface UsageRecordService extends IService<UsageRecord> {

    List<UsageRecord> findAll();
}
