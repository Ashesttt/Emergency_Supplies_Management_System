package com.jerryestt.springboot.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.jerryestt.springboot.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;


//@Mapper
public interface UserMapper extends BaseMapper<User> {
    
    @Select("SELECT user_id FROM user_info WHERE username = #{username}")
    int getUserIdByUsername(String username);

//    /**
//     * 查询
//     */
//    @Select("SELECT * from user_info")
//    List<User> findAll();
//
//    /**
//     * 插入和更新
//     */
//    @Insert("INSERT into user_info(username, password, role, email, phone, address) VALUES (#{username}, #{password}, #{role}, #{email}, #{phone}, #{address})")
//    int insert(User user);
//
//    int update(User user);
//
//    /**
//     * 删除
//     */
//    @Delete("DELETE FROM user_info WHERE user_id = #{user_id}")
//    Integer deleteById(@Param("user_id") Integer id);
//
//    /**
//     * 分页查询
//     * */
//    @Select("SELECT * FROM user_info WHERE username LIKE #{username} LIMIT #{pageNum}, #{pageSize}")
//    List<User> selectPage(@Param("pageNum") Integer pageNum, @Param("pageSize") Integer pageSize, @Param("username") String username);
//
//    
//    @Select("SELECT COUNT(*) FROM user_info WHERE username LIKE concat('%', #{username}, '%') ")
//    Integer selectTotal(String username);
}
