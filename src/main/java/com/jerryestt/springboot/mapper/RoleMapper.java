package com.jerryestt.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jerryestt.springboot.entity.Role;
import org.apache.ibatis.annotations.Select;

public interface RoleMapper extends BaseMapper<Role> {
    
    @Select("select id from role_info where rolename = #{rolename}")
    Integer selectByrolename(String rolename);
}
