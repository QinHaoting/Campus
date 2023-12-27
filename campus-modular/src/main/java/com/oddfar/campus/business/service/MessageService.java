package com.oddfar.campus.business.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.entity.SysUserEntity;

import java.util.List;

/**
 * @author Haoting
 */
public interface MessageService extends IService<MessageEntity> {
    /**
     * 发送消息
     * @param message 消息实体
     * @return 是否发送成功
     */
    int sendMessage(MessageEntity message);

    /**
     * 根据聊天室ID获取聊天室所有消息
     * @param chatroomId 聊天室ID
     * @return 该聊天室消息
     */
    List<MessageEntity> getMessageByChatroomId(Long chatroomId);
}
