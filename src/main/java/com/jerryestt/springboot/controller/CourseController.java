package com.jerryestt.springboot.controller;


import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Course;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.service.CourseService;
import com.jerryestt.springboot.service.IUserService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/course")
public class CourseController {


    @Resource
    private CourseService courseService;

    @Resource
    private IUserService userService;

    @GetMapping("/page")
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String coursename,
                           @RequestParam(defaultValue = "") String username) {

        IPage<Course> page = new Page<>(pageNum, pageSize);

        /**
         * 模糊查询
         * */
        // 用 用户名 模糊查询 用户的id
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();

        // 用户必须为老师
        userQueryWrapper.eq("role", "Teacher");
        if (!"".equals(username)) { // 如果用户名不为空
            userQueryWrapper.like("username", username);
        }

        List<User> users = userService.list(userQueryWrapper);
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());// 获取用户id列表

        QueryWrapper<Course> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("user_id", userIds);
        }
        if (!"".equals(coursename)) {
            queryWrapper.like("coursename", coursename);
        }
        IPage<Course> CourseIPage = courseService.page(page, queryWrapper);
        List<Course> records = CourseIPage.getRecords();
        records.forEach(record -> {
            User user = userService.getById(record.getUserId());
            record.setUsername(user.getUsername());
        });

        return Result.success(CourseIPage);
    }

    /**
     * 新增或更新
     */
    @PostMapping
    public Result save(@RequestBody Course course) {
        return Result.success(courseService.saveOrUpdate(course));
    }

    /**
     * 删除
     */
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(courseService.removeById(id));
    }

}
