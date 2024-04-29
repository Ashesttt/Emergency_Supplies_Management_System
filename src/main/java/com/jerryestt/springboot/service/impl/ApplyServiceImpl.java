package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Apply;
import com.jerryestt.springboot.service.ApplyService;
import com.jerryestt.springboot.mapper.ApplyMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【apply_info】的数据库操作Service实现
* @createDate 2024-04-28 13:54:02
*/
@Service
public class ApplyServiceImpl extends ServiceImpl<ApplyMapper, Apply>
    implements ApplyService{

}




