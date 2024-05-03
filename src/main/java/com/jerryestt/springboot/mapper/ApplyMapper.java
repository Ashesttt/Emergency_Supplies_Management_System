package com.jerryestt.springboot.mapper;

import com.jerryestt.springboot.entity.Apply;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【apply_info】的数据库操作Mapper
* @createDate 2024-04-28 13:54:02
* @Entity com.jerryestt.springboot.entity.Apply
*/
public interface ApplyMapper extends BaseMapper<Apply> {

    @Select("select * from apply_info where transport_id = #{transportId}")
    Apply selectApplyByTransportId(Integer transportId);
}




