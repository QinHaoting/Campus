package com.oddfar.campus.business.service.impl;

import com.baomidou.mybatisplus.core.conditions.Wrapper;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageInfo;
import com.oddfar.campus.business.core.constant.CampusConstant;
import com.oddfar.campus.business.domain.entity.ChatroomEntity;
import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.mapper.ChatroomMapper;
import com.oddfar.campus.business.mapper.MessageMapper;
import com.oddfar.campus.business.mapper.UserRelationMapper;
import com.oddfar.campus.business.service.MessageService;
import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.core.LambdaQueryWrapperX;
import com.oddfar.campus.common.core.page.PageUtils;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.utils.DateUtils;
import com.oddfar.campus.framework.mapper.SysUserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;
import java.util.Map;
import java.util.function.Function;


/**
 * @author Haoting
 */
@Service
public class MessageServiceImpl extends ServiceImpl<MessageMapper, MessageEntity>
        implements MessageService {

    private static final int WEB_PAGE_SIZE = 5;

    @Resource
    private MessageMapper messageMapper;

    @Resource
    private ChatroomMapper chatroomMapper;


    @Override
    public int sendMessage(MessageEntity message) {
        LambdaQueryWrapperX<ChatroomEntity> lambdaQueryWrapperX = new LambdaQueryWrapperX<>();
        lambdaQueryWrapperX.eq(ChatroomEntity::getChatroomId, message.getReceiverId());
        ChatroomEntity chatroom = chatroomMapper.selectOne(lambdaQueryWrapperX);
        if (chatroom == null) { // 不存在聊天室
            return -1;
        }
        else {
            message.setCreateTime(DateUtils.getNowDate());
            if (message.getType() == null)
                message.setType(CampusConstant.MESSAGE_TYPE_TEXT); // 默认为文字类型
            return messageMapper.insert(message);
        }
    }

    /**
     * 获取聊天室的所有消息
     * @param chatroomId 聊天室ID
     * @return 该聊天室所有消息
     */
    @Override
    public List<MessageEntity> getMessageByChatroomId(Long chatroomId) {
        LambdaQueryWrapperX<MessageEntity> lambdaQueryWrapperX = new LambdaQueryWrapperX<>();
        lambdaQueryWrapperX.eq(MessageEntity::getReceiverId, chatroomId);
        return messageMapper.selectList(lambdaQueryWrapperX);
    }

}




