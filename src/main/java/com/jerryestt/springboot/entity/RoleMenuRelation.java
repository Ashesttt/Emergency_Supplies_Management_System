package com.jerryestt.springboot.entity;


import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

@Data
@TableName(value = "role_menu_relation")
public class RoleMenuRelation {
    
    @TableId(type = IdType.AUTO)
    @TableField(value = "role_id")
    private Integer roleId;
    @TableField(value = "menu_id")
    private Integer menuId;
}
