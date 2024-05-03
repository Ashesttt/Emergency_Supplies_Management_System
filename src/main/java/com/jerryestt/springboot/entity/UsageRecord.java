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
     * 使用记录id
     */
    @TableId(value = "usage_record_id", type = IdType.AUTO)
    private Integer usageRecordId;

    /**
     * 物资id
     */
    @TableField(value = "material_id")
    private Integer materialId;

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
     * 使用数量
     */
    @TableField(value = "usage_quantity")
    private Integer usageQuantity;
    
    /**
     * 申请使用之前的仓库数量
     * */
    @TableField(value = "quantity_before_application")
    private Integer quantityBeforeApplication;
    
    /**
     * 运输单号
     * */
    @TableField(value = "transport_id")
    private Integer transportId;
    
    /**
     * 使用原因
     */
    @TableField(value = "usage_reason")
    private String usageReason;

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
     * 用户名
     */
    @TableField(exist = false)
    private String userName;

    /**
     * 用户身份
     */
    @TableField(exist = false)
    private String userRole;
    
    /**
     * 用户头像
     * */
    @TableField(exist = false)
    private String avatarurl;

    /**
     * 物资图片
     * */
    @TableField(exist = false)
    private String materialUrl;


    public void setMaterial(Material material) {
        this.materialName = material.getMaterialName();
        this.materialType = material.getMaterialType();
    }

    public void setUser(User user) {
        this.userName = user.getUsername();
        this.userRole = user.getUserRole();
    }

}
