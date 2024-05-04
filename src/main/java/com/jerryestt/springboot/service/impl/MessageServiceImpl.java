package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Message;
import com.jerryestt.springboot.service.MessageService;
import com.jerryestt.springboot.mapper.MessageMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【message_info】的数据库操作Service实现
* @createDate 2024-05-04 14:02:15
*/
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, Message>
    implements MessageService{

}




