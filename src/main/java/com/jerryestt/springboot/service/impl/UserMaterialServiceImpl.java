package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.UserMaterial;
import com.jerryestt.springboot.service.UserMaterialService;
import com.jerryestt.springboot.mapper.UserMaterialMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【user_material】的数据库操作Service实现
* @createDate 2024-04-28 14:20:19
*/
@Service
public class UserMaterialServiceImpl extends ServiceImpl<UserMaterialMapper, UserMaterial>
    implements UserMaterialService{

}




