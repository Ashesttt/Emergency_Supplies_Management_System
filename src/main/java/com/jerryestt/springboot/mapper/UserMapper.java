package com.jerryestt.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jerryestt.springboot.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;


//@Mapper
public interface UserMapper extends BaseMapper<User> {
    
    @Select("SELECT user_id FROM user_info WHERE username = #{username}")
    int getUserIdByUsername(String username);

    @Select("SELECT COUNT(*) FROM user_info")
    String getTotleUser();
}
