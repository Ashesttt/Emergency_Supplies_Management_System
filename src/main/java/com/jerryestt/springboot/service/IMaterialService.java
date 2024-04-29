package com.jerryestt.springboot.service;

import com.jerryestt.springboot.entity.Material;
import com.baomidou.mybatisplus.extension.service.IService;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【material_info】的数据库操作Service
* @createDate 2024-04-26 20:55:45
*/
public interface IMaterialService extends IService<Material> {

    List<Object> findAllMaterialName();

    Integer findMaterialIdByMaterialName(String materialName);
}
