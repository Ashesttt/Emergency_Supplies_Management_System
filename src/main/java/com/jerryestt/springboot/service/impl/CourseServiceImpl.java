package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Course;
import com.jerryestt.springboot.service.CourseService;
import com.jerryestt.springboot.mapper.CourseMapper;
import org.springframework.stereotype.Service;

/**
* @author 70562
* @description 针对表【course_info】的数据库操作Service实现
* @createDate 2024-05-09 10:10:42
*/
@Service
public class CourseServiceImpl extends ServiceImpl<CourseMapper, Course>
    implements CourseService{

}




