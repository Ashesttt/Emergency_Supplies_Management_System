package com.jerryestt.springboot.entity;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;
import lombok.Getter;
import lombok.Setter;

@Getter
@Setter
@Data
@TableName("file_info")
public class Files {

    @TableId(type = IdType.AUTO)
    @TableField(value = "file_id")
    private Integer fileId;
    private String filename;
    private String type;
    private Long size;
    private String url;
    private String md5;
    private Boolean is_delete;
    private Boolean enable;

}

