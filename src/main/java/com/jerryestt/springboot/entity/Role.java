package com.jerryestt.springboot.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName(value = "role_info")
public class Role {
    @TableId(type = IdType.AUTO)
    private Integer id;
    private String rolename;
    private String description;
}
