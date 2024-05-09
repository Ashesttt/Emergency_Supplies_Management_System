package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.CourseSelections;
import com.jerryestt.springboot.service.CourseSelectionsService;
import com.jerryestt.springboot.mapper.CourseSelectionsMapper;
import org.springframework.stereotype.Service;

/**
* @author 70562
* @description 针对表【course_selections】的数据库操作Service实现
* @createDate 2024-05-09 13:47:47
*/
@Service
public class CourseSelectionsServiceImpl extends ServiceImpl<CourseSelectionsMapper, CourseSelections>
    implements CourseSelectionsService{

}




