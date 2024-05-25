package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Material;
import com.jerryestt.springboot.entity.Status;
import com.jerryestt.springboot.service.IMaterialService;
import com.jerryestt.springboot.mapper.MaterialMapper;
import org.springframework.stereotype.Service;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【material_info】的数据库操作Service实现
* @createDate 2024-04-26 20:55:45
*/
@Service
public class IMaterialServiceImpl extends ServiceImpl<MaterialMapper, Material>
    implements IMaterialService {

    @Override
    public List<Object> findAllMaterialName() {
        QueryWrapper<Material> queryWrapper = new QueryWrapper<>();
        queryWrapper.ne("status", Status.Expired);
        queryWrapper.select("material_name");
        return baseMapper.selectObjs(queryWrapper);// 返回所有的物料名称
        
        
    }

    @Override
    public Integer findMaterialIdByMaterialName(String materialName) {
        QueryWrapper<Material> queryWrapper = new QueryWrapper<>();
        queryWrapper.select("material_id").eq("material_name", materialName);
        return baseMapper.selectOne(queryWrapper).getMaterialId();// 返回物料名称对应的物料id
    }
    
}




