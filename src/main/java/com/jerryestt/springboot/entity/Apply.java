package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDate;
import java.time.LocalDateTime;

/**
 * @TableName apply_info
 */
@TableName(value = "apply_info")
@Data
public class Apply implements Serializable {
    /**
     * 申请id
     */

    @TableId(value = "application_id", type = IdType.AUTO)
    private Integer applicationId;

    /**
     * 申请人id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 申请物资id
     */
    @TableField(value = "material_id")
    private Integer materialId;

    /**
     * 申请数量
     */
    @TableField(value = "apply_quantity")
    private Integer applyQuantity;

    /**
     * 申批状态
     */
    @TableField(value = "approval_status")
    private ApprovalStatus approvalStatus;

    /**
     * 申请时间
     */
    @TableField(value = "apply_time")
    private LocalDateTime applyTime;

    /**
     * 申请原因
     */
    @TableField(value = "apply_reason")
    private String applyReason;

    /**
     * 审批时间
     */
    @TableField(value = "approval_time")
    private LocalDateTime approvalTime;

    /**
     * 用户名
     */
    @TableField(exist = false)
    private String username;

    /**
     * 用户身份
     */
    @TableField(exist = false)
    private String userRole;

    /**
     * 物资名
     */
    @TableField(exist = false)
    private String materialName;

    /**
     * 物资类型
     */
    @TableField(exist = false)
    private MaterialType materialType;

    /**
     * 物资仓库数量
     */
    @TableField(exist = false)
    private Integer quantity;
}
