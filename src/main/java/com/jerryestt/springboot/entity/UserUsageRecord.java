package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDateTime;
import lombok.Data;

/**
 * 
 * @TableName user_usage_record
 */
@TableName(value ="user_usage_record")
@Data
public class UserUsageRecord implements Serializable {
    /**
     * 用户使用记录
     */
    @TableId(value = "user_usage_record_id", type = IdType.AUTO)
    private Integer userUsageRecordId;

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
     * 记录时间
     */
    @TableField(value = "record_time")
    private LocalDateTime recordTime;

    /**
     * 用户使用数量
     */
    @TableField(value = "user_usage_quantity")
    private Integer userUsageQuantity;

    /**
     * 使用前个人仓库数量
     */
    @TableField(value = "quantity_before_use")
    private Integer quantityBeforeUse;

    /**
     * 用户使用原因
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
}
