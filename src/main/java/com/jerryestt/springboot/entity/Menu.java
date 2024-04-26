package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.util.List;

import lombok.Data;

/**
 * 
 * @TableName menu_info
 */
@Data
@TableName(value ="menu_info")
public class Menu implements Serializable {
    /**
     * 菜单id
     */
    // 不可用menu_id而是用menuId的原因同User.java
    @TableId(value = "menu_id", type = IdType.AUTO)
    private Integer menuId;

    /**
     * 菜单名字
     */
    @TableField(value = "menuname")
    private String menuname;

    /**
     * 路径
     */
    @TableField(value = "path")
    private String path;

    /**
     * 图标
     */
    @TableField(value = "icon")
    private String icon;

    /**
     * 描述
     */
    @TableField(value = "description")
    private String description;
    
    /**
     * 
     * */
    @TableField(exist = false)//不是数据库字段
    private List<Menu> children;
    
    /**
     * 父级id
     * */
    @TableField(value = "pid")
    private Integer pid;
    
    /**
     * 页面路径
     * */
    @TableField(value = "page_path")
    private String pagePath;
    
}
