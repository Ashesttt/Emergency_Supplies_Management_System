package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;

import java.io.Serializable;

import lombok.Data;

/**
 * @TableName course_info
 */
@TableName(value = "course_info")
@Data
public class Course implements Serializable {
    /**
     * 课程id
     */
    @TableId(value = "course_id", type = IdType.AUTO)
    private Integer courseId;

    /**
     * 课程名字
     */
    @TableField(value = "coursename")
    private String coursename;

    /**
     * 教师id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 课时(单位：h)
     */
    @TableField(value = "course_time")
    private Integer courseTime;

    /**
     * 课程描述
     */
    @TableField(value = "description")
    private String description;
    
    /**
     * 教师名字
     */
    @TableField(exist = false)
    private String username;
}
