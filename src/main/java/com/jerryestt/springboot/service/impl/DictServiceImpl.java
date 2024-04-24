package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Dict;
import com.jerryestt.springboot.service.DictService;
import com.jerryestt.springboot.mapper.DictMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【dict_info】的数据库操作Service实现
* @createDate 2024-04-24 17:37:28
*/
@Service
public class DictServiceImpl extends ServiceImpl<DictMapper, Dict>
    implements DictService{

}




