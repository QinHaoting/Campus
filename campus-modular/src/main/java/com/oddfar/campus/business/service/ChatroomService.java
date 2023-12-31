package com.oddfar.campus.business.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.oddfar.campus.business.domain.entity.ChatroomEntity;
import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.domain.vo.SysUserVO;

import java.util.List;

/**
 * @author Haoting
 */
public interface ChatroomService extends IService<ChatroomEntity> {

    /**
     * 创建聊天室
     * @param userIds 聊天室成员ID
     * @return 是否创建成功
     */
    int createChatroom(List<Long> userIds);

    /**
     * 删除聊天室
     * @param chatroomId 聊天室ID
     * @return 是否删除成功
     */
    int removeChatroom(Long chatroomId);

    /**
     * 根据聊天室ID获取聊天室成员
     * @param chatroomId 聊天室ID
     * @return 群成员列表
     */
    List<SysUserEntity> getUsers(Long chatroomId);

    /**
     * 判断用户是否在聊天室
     * @param chatroomId 聊天室ID
     * @param userId 用户ID
     * @return 是否在聊天室
     */
    int isMember(Long chatroomId, Long userId);

    /**
     * 判断当前用户是否为聊天室群主
     * @param chatroomId 聊天室ID
     * @return 是否为群主
     */
    int isOwner(Long chatroomId);

    /**
     * 获取当前用户所在的聊天室
     * @return 用户所在聊天室
     */
    List<ChatroomEntity> getChatroomList();

    /**
     * 移除聊天室内的成员
     * @param chatroomId 聊天室ID
     * @param userId 成员ID
     * @return 是否移除成功
     */
    int removeMember(Long chatroomId, Long userId);
}
