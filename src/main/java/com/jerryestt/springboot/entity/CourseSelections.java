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
 * @TableName course_selections
 */
@TableName(value ="course_selections")
@Data
public class CourseSelections implements Serializable {
    /**
     * 课程选择id
     */
    @TableId(value = "course_selection_id", type = IdType.AUTO)
    private Integer courseSelectionId;

    /**
     * 课程id
     */
    @TableField(value = "course_id")
    private Integer courseId;

    /**
     * 学生id
     */
    @TableField(value = "user_id")
    private Integer userId;

    /**
     * 学习时长（单位：h）
     */
    @TableField(value = "study_time")
    private Integer studyTime;

    /**
     * 教师评分
     */
    @TableField(value = "score")
    private Integer score;

    /**
     * 选课时间
     */
    @TableField(value = "selected_time")
    private LocalDateTime selectedTime;

    /**
     * 更新时间
     */
    @TableField(value = "updated_time")
    private LocalDateTime updatedTime;
    
    
    /**
     * 课程名字
     * */
    @TableField(exist = false)
    private String courseName;
    
    /**
     * 学生名字
     * */
    @TableField(exist = false)
    private String userName;
    
    /**
     * studentId
     * */
    @TableField(exist = false)
    private Integer studentId;
    
    /**
     * StudentName
     * */
    @TableField(exist = false)
    private String studentName;
}
