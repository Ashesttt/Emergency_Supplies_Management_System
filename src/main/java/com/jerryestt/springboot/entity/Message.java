package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.io.Serializable;
import java.time.LocalDateTime;

/**
 * @TableName message_info
 */
@TableName(value = "message_info")
@Data
public class Message implements Serializable {
    /**
     * 消息id
     */
    @TableId(value = "message_id", type = IdType.AUTO)
    private Integer messageId;

    /**
     * 接收者id
     */
    @TableField(value = "receiver_id")
    private Integer receiverId;

    /**
     * 信息标题
     */
    @TableField(value = "title")
    private String title;

    /**
     * 信息
     */
    @TableField(value = "content")
    private String content;

    /**
     * 发送时间
     */
    @TableField(value = "send_time")
    private LocalDateTime sendTime;

    /**
     * 消息的阅读状态
     */
    @TableField(value = "read_status")
    private ReadStatus readStatus;

    /**
     * 信息重要程度
     */
    @TableField(value = "type")
    private Type type;

    /**
     * 用户名
     */
    @TableField(exist = false)
    private String userName;

    /**
     * 用户头像
     */
    @TableField(exist = false)
    private String avatarurl;
}
