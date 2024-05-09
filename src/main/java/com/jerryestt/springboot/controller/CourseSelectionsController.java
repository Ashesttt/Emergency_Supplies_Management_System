package com.jerryestt.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Course;
import com.jerryestt.springboot.entity.CourseSelections;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.service.CourseSelectionsService;
import com.jerryestt.springboot.service.CourseService;
import com.jerryestt.springboot.service.IUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.time.LocalDateTime;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/courseSelections")
public class CourseSelectionsController {


    @Resource
    private CourseSelectionsService courseSelectionsService;

    @Resource
    private IUserService userService;

    @Resource
    private CourseService courseService;

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String coursename,
                           @RequestParam(defaultValue = "") String username) {

        IPage<CourseSelections> page = new Page<>(pageNum, pageSize);

        /**
         * 模糊查询
         * */
        // 用 用户名 模糊查询 用户的id
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();

        // 用户必须为学生
        userQueryWrapper.eq("role", "Student");
        if (!"".equals(username)) { // 如果用户名不为空
            userQueryWrapper.like("username", username);

        }
        List<User> users = userService.list(userQueryWrapper);
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());// 获取用户id列表

        // 用 课程名 模糊查询 课程的id
        QueryWrapper<Course> courseQueryWrapper = new QueryWrapper<>();
        if (!"".equals(coursename)) {
            courseQueryWrapper.like("coursename", coursename);
        }
        List<Course> courses = courseService.list(courseQueryWrapper);
        List<Integer> courseIds = courses.stream().map(Course::getCourseId).collect(Collectors.toList());// 获取课程id列表

        QueryWrapper<CourseSelections> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) { // 如果用户id列表不为空
            queryWrapper.in("user_id", userIds);
        }
        if (!courseIds.isEmpty()) { // 如果课程id列表不为空
            queryWrapper.in("course_id", courseIds);
        }


        IPage<CourseSelections> CourseSelectionsIPage = courseSelectionsService.page(page, queryWrapper);
        List<CourseSelections> records = CourseSelectionsIPage.getRecords();
        records.forEach(record -> {
            User user = userService.getById(record.getUserId());
            record.setUserName(user.getUsername());
            Course course = courseService.getById(record.getCourseId());
            record.setCourseName(course.getCoursename());
        });

        return Result.success(CourseSelectionsIPage);
    }

    /**
     * 教师打分
     */
    @PostMapping
    public Result save(@RequestBody CourseSelections courseSelections) {
        LocalDateTime now = LocalDateTime.now();
        courseSelections.setUpdatedTime(now);
        return Result.success(courseSelectionsService.saveOrUpdate(courseSelections));
    }

    /**
     * 学生选课
     */
    @PostMapping("/select")
    public Result select(@RequestBody Map<String, Object> form) {
        String studentName = (String) form.get("StudentName");
        int userId = (int) form.get("userId");
        int courseId = (int) form.get("courseId");
        
        // 查看用户的id
        QueryWrapper<User> UserqueryWrapper = new QueryWrapper<>();
        UserqueryWrapper.eq("username", studentName);
        User user = userService.getOne(UserqueryWrapper);
        if (user == null) {
            return Result.error("用户不存在");
        }
        int studentId = user.getUserId();
        
        // 判断是否已经选过课
        QueryWrapper<CourseSelections> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("user_id", studentId);
        queryWrapper.eq("course_id", courseId);
        CourseSelections one = courseSelectionsService.getOne(queryWrapper);
        if (one != null) {
            return Result.error("已经选过课了");
        } else {
            CourseSelections courseSelections = new CourseSelections();
            courseSelections.setCourseId(courseId);
            courseSelections.setUserId(studentId);
            LocalDateTime now = LocalDateTime.now();
            courseSelections.setSelectedTime(now);
            return Result.success(courseSelectionsService.saveOrUpdate(courseSelections));
        }
    }

}
