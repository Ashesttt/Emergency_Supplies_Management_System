package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonIgnore;
import lombok.Data;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;


@Data
@TableName(value = "user_info")
public class User implements Serializable {

    /**
     * 为什么user_id会返回null:
     * 在MyBatis Plus中，如果数据库表的主键字段名和实体类的属性名不一致
     * ，需要使用@TableField注解来显式指定映射关系。  在你的情况下，数据
     * 库表的主键字段可能是user_id，但在Java中，按照命名规范，属性名应该是
     * userId，而不是user_id。因此，你需要将User实体类中的user_id字段名
     * 改为userId，并使用@TableField注解来指定其映射到数据库表的user_id字段。
     * */
    @TableId(type = IdType.AUTO)
    @TableField(value = "user_id")
    private Integer userId;
    private String username;

    @JsonIgnore
    private String password;
    private Role role;
    private String email;
    private String phone;
    private String address;
    
    @TableField(value = "create_time")
    private String createTime;
}
