package com.jerryestt.springboot.controller;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.jerryestt.springboot.common.Result;
import com.jerryestt.springboot.entity.Message;
import com.jerryestt.springboot.entity.UsageRecord;
import com.jerryestt.springboot.entity.User;
import com.jerryestt.springboot.mapper.MessageMapper;
import com.jerryestt.springboot.mapper.UserMapper;
import com.jerryestt.springboot.service.IUserService;
import com.jerryestt.springboot.service.MessageService;
import org.springframework.web.bind.annotation.*;

import javax.annotation.Resource;
import java.util.List;
import java.util.stream.Collectors;

@RestController
@RequestMapping("/message")
public class MessageController {

    @Resource
    private MessageService messageService;

    @Resource
    private UserMapper userMapper;

    @Resource
    private MessageMapper messageMapper;

    @Resource
    private IUserService userService;

    // 查找某个用户的所有消息
    @GetMapping("/getMessages")
    public Result getMessages(@RequestParam String username) {
        // 通过用户名查找用户id
        int userId = userMapper.getUserIdByUsername(username);
        // 通过用户id查找未读消息
        List<Message> messages = messageMapper.getMessagesByReceiverId(String.valueOf(userId));
        return Result.success(messages);
    }

    // 把消息标记为已读
    @PostMapping("/handleRead")
    public Result handleRead(@RequestParam Integer messageId) {
        messageMapper.handleRead(messageId);
        return Result.success();
    }


    // 分页查询
    @GetMapping("/getMessagesByPage")
    public Result getMessagesByPage(@RequestParam Integer pageNum,
                                    @RequestParam Integer pageSize,
                                    @RequestParam(defaultValue = "") String username) {

        IPage<Message> page = new Page<>(pageNum, pageSize);
        QueryWrapper<Message> wrapper = new QueryWrapper<>();
        /**
         * 模糊查询
         * */
        QueryWrapper<User> userQueryWrapper = new QueryWrapper<>();
        if (!username.isEmpty()) {
            userQueryWrapper.like("username", username);
        }
        List<User> users = userMapper.selectList(userQueryWrapper);
        if (users.isEmpty()) {
            return Result.success("没有找到该用户");
        }
        List<Integer> userIds = users.stream().map(User::getUserId).collect(Collectors.toList());

        QueryWrapper<Message> queryWrapper = new QueryWrapper<>();
        if (!userIds.isEmpty()) {
            queryWrapper.in("receiver_id", userIds);
        }
        // 按照发送时间降序排列
        queryWrapper.orderByDesc("send_time");
        IPage<Message> messageIPage = messageService.page(page, queryWrapper);
        List<Message> records = messageIPage.getRecords();// 获取记录列表
        records.forEach(record -> {// 遍历记录列表
            User user = userService.getById(record.getReceiverId());
            record.setUserName(user.getUsername());
            record.setAvatarurl(user.getAvatarurl());
        });
        return Result.success(messageIPage);
        }
}
