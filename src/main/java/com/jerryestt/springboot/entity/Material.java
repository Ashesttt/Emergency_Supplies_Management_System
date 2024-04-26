package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import java.io.Serializable;
import java.time.LocalDate;
import lombok.Data;

/**
 * 
 * @TableName material_info
 */
@TableName(value ="material_info")
@Data
public class Material implements Serializable {
    /**
     * 物资id
     */
    @TableId(value = "material_id", type = IdType.AUTO)
    private Integer materialId;

    /**
     * 物资名字
     */
    @TableField(value = "material_name")
    private String materialName;

    /**
     * 物资类型
     */
    @TableField(value = "material_type")
    private MaterialType materialType;

    /**
     * 数量
     */
    @TableField(value = "quantity")
    private Integer quantity;

    /**
     * 物资的照片url
     */
    @TableField(value = "material_url")
    private String materialUrl;

    /**
     * 生产日期
     */
    @TableField(value = "production_date")
    private LocalDate productionDate;

    /**
     * 到期日期
     */
    @TableField(value = "expiry_date")
    private LocalDate expiryDate;
    

    /**
     * 目前状态
     */
    @TableField(value = "status")
    private Status status;
}
