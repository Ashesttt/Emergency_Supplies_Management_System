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
 * @TableName transport_info
 */
@TableName(value ="transport_info")
@Data
public class Transport implements Serializable {
    /**
     * 运输id
     */
    @TableId(value = "transport_id", type = IdType.AUTO)
    private Integer transportId;

    /**
     * 接收用户id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 要运输的物资id
     */
    @TableField(value = "material_id")
    private Integer materialId;

    /**
     * 物资数量
     */
    @TableField(value = "quantity")
    private Integer quantity;
    
    /**
     * 司机id
     */
    @TableField(value = "driver_id")
    private Integer driverId;

    /**
     * 目的地
     */
    @TableField(value = "destination")
    private String destination;

    /**
     * 运输状态
     */
    @TableField(value = "transport_status")
    private TransportStatus transportStatus;

    /**
     * 订单开始时间
     */
    @TableField(value = "start_time")
    private LocalDateTime startTime;

    /**
     * 订单结束时间
     */
    @TableField(value = "end_time")
    private LocalDateTime endTime;

    

    /**
     * 用户名
     */
    @TableField(exist = false)
    private String username;

    /**
     * 物资名
     */
    @TableField(exist = false)
    private String materialName;

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
    
    /**
     * 司机名字
     * */
    @TableField(exist = false)
    private String driverName;
    
    /**
     * 司机头像
     * */
    @TableField(exist = false)
    private String driverAvatarurl;

}
