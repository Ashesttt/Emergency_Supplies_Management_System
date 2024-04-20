package com.jerryestt.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {


    @Autowired
    private UserService userService;

    /**
     * 查询所有数据
     */
    @GetMapping
    public List<User> findAll() {
        return userService.listUsers();
    }

    /**
     * 插入或更新
     */
    @PostMapping
    public boolean save(@RequestBody User user) {
        return userService.saveUser(user);
    }

    /**
     * 删除
     */
    @DeleteMapping("/{id}")
    public boolean delete(@PathVariable Integer id) {
        return userService.removeById(id);
    }

    /**
     * 分页查询--mybatis（已弃用）
     * */
    // 接口路径 /user/page?pageNum=1&pageSize=10
//    @GetMapping("/page")
//    public Map<String, Object> findPage(@RequestParam Integer pageNum, @RequestParam Integer pageSize, @RequestParam String username) {
//        pageNum = (pageNum - 1) * pageSize;
//        username = "%" + username + "%";// 模糊查询
//        List<User> data = userMapper.selectPage(pageNum, pageSize, username);
//        Integer total = userMapper.selectTotal(username);
//        Map<String, Object> res = new HashMap<>();
//        res.put("data", data);
//        res.put("total", total);
//        return res;
//    }


    /**
     * 分页查询--mybatis-plus
     */
    @GetMapping("/page")
    public IPage<User> findPage(@RequestParam Integer pageNum,
                                @RequestParam Integer pageSize,
                                @RequestParam(defaultValue = "") String username,
                                @RequestParam(defaultValue = "") String role,
                                @RequestParam(defaultValue = "") String email,
                                @RequestParam(defaultValue = "") String phone,
                                @RequestParam(defaultValue = "") String address,
                                @RequestParam(defaultValue = "") String createTime) {

        IPage<User> page = new Page<>(pageNum, pageSize);
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();

        /**
         * 模糊查询
         * */
        if (!"".equals(username)) {// 如果username不为空
            queryWrapper.like("username", username);
        }
        if (!"".equals(role)) {
            queryWrapper.like("role", role);
        }
        if (!"".equals(email)) {
            queryWrapper.like("email", email);
        }
        if (!"".equals(phone)) {
            queryWrapper.like("phone", phone);
        }
        if (!"".equals(address)) {
            queryWrapper.like("address", address);
        }
        if (!"".equals(createTime)) {
            queryWrapper.apply("DATE_FORMAT(create_time, '%Y-%m-%d %H:%i:%s') LIKE {0}", "%" + createTime + "%");
        }
        return userService.page(page, queryWrapper);
    }
    
    
    /**
     * 批量删除
     * */
    @PostMapping("/del/batch")
    public boolean deleteBatch(@RequestBody List<Integer> ids) {
        return userService.removeByIds(ids);
    }

}
