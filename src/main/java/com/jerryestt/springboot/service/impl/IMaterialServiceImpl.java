package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.mapper.MaterialMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【material_info】的数据库操作Service实现
* @createDate 2024-04-26 20:55:45
*/
@Service
public class IMaterialServiceImpl extends ServiceImpl<MaterialMapper, Material>
    implements IMaterialService {

}




