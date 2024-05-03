package com.jerryestt.springboot.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.jerryestt.springboot.entity.Transport;
import com.jerryestt.springboot.service.TransportService;
import com.jerryestt.springboot.mapper.TransportMapper;
import org.springframework.stereotype.Service;

/**
* @author Rick SanChez
* @description 针对表【transport_info】的数据库操作Service实现
* @createDate 2024-05-01 23:30:34
*/
@Service
public class TransportServiceImpl extends ServiceImpl<TransportMapper, Transport>
    implements TransportService{

}




