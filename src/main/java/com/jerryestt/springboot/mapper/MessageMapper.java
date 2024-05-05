package com.jerryestt.springboot.mapper;

import com.jerryestt.springboot.entity.Message;
import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;

import java.util.List;

/**
* @author Rick SanChez
* @description 针对表【message_info】的数据库操作Mapper
* @createDate 2024-05-04 14:02:15
* @Entity com.jerryestt.springboot.entity.Message
*/
public interface MessageMapper extends BaseMapper<Message> {


    @Select("SELECT * FROM message_info WHERE receiver_id = #{userId} AND read_status = 'NO' ORDER BY send_time DESC")
    List<Message> getMessagesByReceiverId(String userId);


    @Update("UPDATE message_info SET read_status = 'YES' WHERE message_id = #{messageId}")
    void handleRead(Integer messageId);
}




