package com.jerryestt.springboot.mapper;

import com.jerryestt.springboot.entity.Material;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【material_info】的数据库操作Mapper
* @createDate 2024-04-26 20:55:45
* @Entity com.jerryestt.springboot.entity.Material
*/
public interface MaterialMapper extends BaseMapper<Material> {

    @Select("SELECT SUM(quantity) AS total_quantity FROM material_info")
    Long getTotleMaterial();
}




