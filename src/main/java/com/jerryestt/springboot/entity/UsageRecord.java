package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @TableName usage_record
 */
@TableName(value = "usage_record")
@Data
public class UsageRecord implements Serializable {
    /**
     * 申请记录id
     */
    @TableId(value = "usage_record_id", type = IdType.AUTO)
    private Integer usageRecordId;

    /**
     * 物资id
     */
    @TableField(value = "material_id")
    private String materialId;

    /**
     * 用户id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 记录时间
     */
    @TableField(value = "record_time")
    private LocalDateTime recordTime;

    /**
     * 申请使用数量
     */
    @TableField(value = "usage_quantity")
    private Integer usageQuantity;

    // 新增字段
    /**
     * 物资名称
     */
    @TableField(exist = false)
    private String materialName;

    /**
     * 物资种类
     */
    @TableField(exist = false)
    private MaterialType materialType;

    /**
     * 物资仓库数量
     */
    @TableField(exist = false)
    private Integer quantity;


    /**
     * 用户名
     */
    @TableField(exist = false)
    private String userName;

    /**
     * 用户身份
     */
    @TableField(exist = false)
    private String userRole;


    public void setMaterial(Material material) {
        this.materialName = material.getMaterialName();
        this.materialType = material.getMaterialType();
        this.quantity = material.getQuantity();
    }

    public void setUser(User user) {
        this.userName = user.getUsername();
        this.userRole = user.getUserRole();
    }

}
