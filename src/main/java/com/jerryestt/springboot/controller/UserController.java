package com.jerryestt.springboot.controller;

import cn.hutool.core.collection.CollUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.poi.excel.ExcelReader;
import cn.hutool.poi.excel.ExcelUtil;
import cn.hutool.poi.excel.ExcelWriter;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Constants;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.controller.dto.UserDTO;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.service.IUserService;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.annotation.Resource;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import java.io.InputStream;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@RestController
@RequestMapping("/user")
public class UserController {

//    @Value("${files.upload.path}")
//    private String filesUploadPath;

    @Resource
    private IUserService userService;

//    /**
//     * 查询所有数据
//     */
//    @GetMapping
//    public Result findAll() {
//        return Result.success(userService.list());
//    }

    /**
     * 新增或更新
     */
    @PostMapping
    public Result save(@RequestBody User user) {
        return Result.success(userService.saveOrUpdate(user));
    }

    /**
     * 删除
     */
    @DeleteMapping("/{id}")
    public Result delete(@PathVariable Integer id) {
        return Result.success(userService.removeById(id));
    }


    /**
     * 批量删除
     */
    @PostMapping("/del/batch")
    public Result deleteBatch(@RequestBody List<Integer> ids) {
        return Result.success("成功删除" + userService.removeByIds(ids) + "条数据");
    }

//    /**
//     * 根据id查询
//     */
//    @GetMapping("/{id}")
//    public Result findById(@PathVariable Integer id) {
//        return Result.success(userService.getById(id));
//    }

    /**
     * 根据username查询
     */
    @GetMapping("/username/{username}")
    public Result findByUsername(@PathVariable String username) {
        QueryWrapper<User> queryWrapper = new QueryWrapper<>();
        queryWrapper.eq("username", username);
        return Result.success(userService.getOne(queryWrapper));
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
    public Result findPage(@RequestParam Integer pageNum,
                           @RequestParam Integer pageSize,
                           @RequestParam(defaultValue = "") String username,
                           @RequestParam(defaultValue = "") String userRole,
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
        if (!"".equals(userRole)) {
            queryWrapper.like("role", userRole);
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


//        这是getCurrentUser方法，从request的Token中解码得到用户信息
//        User currentUser = TokenUtils.getCurrentUser();
//        System.out.println(currentUser);
//        System.out.println(currentUser.getUsername());
        return Result.success(userService.page(page, queryWrapper));
    }


    /**
     * excel 导出接口
     */
    @GetMapping("/export")
    public Result export(HttpServletResponse response) throws Exception {
        // 从数据库查询出所有的数据
        List<User> list = userService.list();
        // 通过工具类创建writer 写出到磁盘路径
//        ExcelWriter writer = ExcelUtil.getWriter(filesUploadPath + "/用户信息.xlsx");
        // 在内存操作，写出到浏览器
        // 参数true表示在内存中操作，而不是写入到磁盘文件
        ExcelWriter writer = ExcelUtil.getWriter(true);
        //自定义标题别名
//        writer.addHeaderAlias("userId", "userId");
//        writer.addHeaderAlias("username", "username");
//        writer.addHeaderAlias("password", "password");
//        writer.addHeaderAlias("role", "role");
//        writer.addHeaderAlias("email", "email");
//        writer.addHeaderAlias("phone", "phone");
//        writer.addHeaderAlias("address", "address");
//        writer.addHeaderAlias("createTime", "createTime");

        // 一次性写出list内的对象到excel，使用默认样式，强制输出标题
        writer.write(list, true);

        // 设置浏览器响应的格式
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet;charset=utf-8");
        String fileName = URLEncoder.encode("用户信息", "UTF-8");
        response.setHeader("Content-Disposition", "attachment;filename=" + fileName + ".xlsx");

        ServletOutputStream out = response.getOutputStream();// 获取输出流
        writer.flush(out, true);// 关闭writer，释放内存
        out.close();// 关闭输出流
        writer.close();// 关闭writer
        return Result.success();
    }


    /**
     * excel 导入接口
     *
     * @param file
     * @throws Exception
     */
    @PostMapping("/import")
    public Result imp(MultipartFile file) throws Exception {
        InputStream inputStream = file.getInputStream();// 获取文件输入流
        ExcelReader reader = ExcelUtil.getReader(inputStream);// 通过工具类创建reader

//        // 方式1：(推荐) 通过 javabean的方式读取Excel内的对象，但是要求表头必须是英文，跟javabean的属性要对应起来
//        List<User> list = reader.readAll(User.class);

//        // 方式2：
        List<List<Object>> list = reader.read(1);
        List<User> users = CollUtil.newArrayList();
        for (List<Object> row : list) {
            User user = new User();
            user.setUsername(row.get(1).toString());
            user.setPassword(row.get(2).toString());
            // 如果 role 是空的，设置一个默认值
            String role = row.get(3).toString();
            user.setEmail(row.get(4).toString());
            user.setPhone(row.get(5).toString());
            user.setAddress(row.get(6).toString());

            String createTime = row.get(7).toString();
            if (createTime.isEmpty()) {
                // 如果 create_time 是空的，设置一个默认值
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = format.parse("2023-04-14 21:00:00");
                user.setCreateTime(date);
            } else {
                SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
                Date date = format.parse(createTime);
                user.setCreateTime(date);
            }
            users.add(user);
        }
        return Result.success(userService.saveBatch(users));
    }


    /**
     * 登录
     */
    @PostMapping("/login")
    public Result login(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();

        //是否要写？前端Login.vue写死了 用户名或密码不为空，但是害怕直接访问接口
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {// 如果用户名或密码为空
            return Result.error(Constants.USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY, "用户名或密码不能为空");
        }
        UserDTO user = userService.login(userDTO);
        return Result.success(user);
    }


    /**
     * 注册
     */
    @PostMapping("/register")
    public Result register(@RequestBody UserDTO userDTO) {
        String username = userDTO.getUsername();
        String password = userDTO.getPassword();
//        String role = userDTO.getUserRole().toString();

        //同上Login方法的疑问
        if (StrUtil.isBlank(username) || StrUtil.isBlank(password)) {// 如果用户名或密码为空
            return Result.error(Constants.USERNAME_OR_PASSWORD_CANNOT_BE_EMPTY, "用户名或密码不能为空");
        }
        return Result.success(userService.register(userDTO));
    }
    
    
    /**
     * 根据id查询用户信息
     * */
    @GetMapping("/{id}")
    public Result findById(@PathVariable Integer id) {
        return Result.success(userService.getById(id));
    }
    
    
}
