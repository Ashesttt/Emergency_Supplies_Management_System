package com.jerryestt.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jerryestt.springboot.entity.RoleMenuRelation;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface RoleMenuMapper extends BaseMapper<RoleMenuRelation> {
    
    @Select("select menu_id from role_menu_relation where role_id = #{roleId}")
    List<Integer> findMenuByRoleId(@Param("roleId") Integer roleId);
}
