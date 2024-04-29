package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import lombok.Data;

/**
 * 
 * @TableName user_material
 */
@TableName(value ="user_material")
@Data
public class UserMaterial implements Serializable {
    /**
     * 用户id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 物资id
     */
    @TableField(value = "material_id")
    private Integer materialId;

    /**
     * 拥有的数量
     */
    @TableField(value = "quantity")
    private Integer quantity;
    
    /**
     * 用户名
     * */
    @TableField(exist = false)
    private String username;
    
    /**
     * 用户身份
     * */
    @TableField(exist = false)
    private String userRole;
    
    /**
     * 物资名
     * */
    @TableField(exist = false)
    private String materialName;
    
    /**
     * 物资类型
     * */
    @TableField(exist = false)
    private MaterialType materialType;
}
