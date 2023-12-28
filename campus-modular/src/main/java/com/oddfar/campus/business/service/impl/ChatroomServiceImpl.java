package com.oddfar.campus.business.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.TypeReference;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.oddfar.campus.business.domain.entity.ChatroomEntity;
import com.oddfar.campus.business.mapper.ChatroomMapper;
import com.oddfar.campus.business.service.ChatroomService;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.utils.DateUtils;
import com.oddfar.campus.common.utils.SecurityUtils;
import com.oddfar.campus.framework.mapper.SysUserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.*;

import static com.oddfar.campus.business.service.impl.UserRelationServiceImpl.hideUserInfo;


/**
 * @author Haoting
 */
@Service
public class ChatroomServiceImpl extends ServiceImpl<ChatroomMapper, ChatroomEntity>
        implements ChatroomService {

    @Resource
    private ChatroomMapper chatroomMapper;

    @Resource
    private SysUserMapper userMapper;

    /**
     * 创建聊天室
     * @param userIds 聊天室用户
     * @return 是否创建成功
     */
    public int createChatroom(List<Long> userIds) {
        Long ownerId = SecurityUtils.getUserId();
        HashMap<Long, Date> userIdMap = new HashMap<>();
        Date datetime = DateUtils.getNowDate();
        for (Long userId: userIds) {
            userIdMap.put(userId, datetime);
        }
        if (userIdMap.get(ownerId) == null) { // 群主也是群成员
            userIdMap.put(ownerId, datetime);
            userIds.add(ownerId);
        }
        ChatroomEntity chatroom = new ChatroomEntity();
        chatroom.setOwnerId(ownerId);
        chatroom.setUserIds(JSON.toJSONString(userIdMap)); // 以字符串存入
        chatroom.setCreateTime(datetime);

        // 设置群名称，默认为群成员的用户小名
        List<SysUserEntity> users = userMapper.selectBatchIds(userIds); // 群成员列表
        StringBuffer chatroomName = new StringBuffer();
        for (SysUserEntity user: users) {
            if(user.getNickName() == null) { // 用户小名为空，则用空格代替
                chatroomName.append(" ").append("、");
                continue;
            }
            if (user.getUserId().equals(userIds.get(userIds.size()-1))) { // 最后一个用户
                chatroomName.append(user.getNickName());
            }
            else {
                chatroomName.append(user.getNickName()).append("、");
            }
        }
        chatroom.setName(new String(chatroomName));

        return chatroomMapper.insert(chatroom);
    }

    /**
     * 获取聊天室所有用户
     * @param chatroomId 聊天室ID
     * @return 该聊天室用户列表
     */
    @Override
    public List<SysUserEntity> getUsers(Long chatroomId) {
        ChatroomEntity chatroom = chatroomMapper.selectById(chatroomId);
        if (chatroom == null)
            return null;
        else {
            // json字符串转为HashMap对象
            HashMap<Long, Date> userMap = JSON.parseObject(chatroom.getUserIds(), new TypeReference<HashMap<Long, Date>>() {});
            List<Long> userIds = new ArrayList<>(userMap.keySet());
            List<SysUserEntity> users = userMapper.selectBatchIds(userIds);
            hideUserInfo(users);
            return users;
        }
    }

    /**
     * 判断当前用户是否是聊天室的成员
     * @param chatroomId 聊天室ID
     * @return 是否是聊天室成员
     */
    @Override
    public int isMember(Long chatroomId) {
        ChatroomEntity chatroom = chatroomMapper.selectById(chatroomId);
        if (chatroom == null)
            return -1; // 聊天室不存在
        else {
            // json字符串转为HashMap对象
            HashMap<Long, Date> userMap = JSON.parseObject(chatroom.getUserIds(), new TypeReference<HashMap<Long, Date>>() {});
            Long currentUserId = SecurityUtils.getUserId();
            if (userMap.get(currentUserId) == null) {
                return 0; // 当前用户不是该聊天室成员
            }
            return 1; // 当前用户是该聊天室成员
        }
    }

    /**
     * 判断当前用户是否是聊天室的成员
     * @param chatroomId 聊天室ID
     * @return 是否是聊天室成员
     */
    @Override
    public int isOwner(Long chatroomId) {
        ChatroomEntity chatroom = chatroomMapper.selectById(chatroomId);
        if (chatroom == null)
            return -1; // 聊天室不存在
        else {
            Long userId = SecurityUtils.getUserId();
            if (userId.equals(chatroom.getOwnerId())) { // 当前用户是该聊天室群主
                return 1;
            }
            else { // 当前用户不是聊天室群主
                return 0;
            }
        }
    }

    @Override
    public List<ChatroomEntity> getChatroomList() {
        List<ChatroomEntity> chatroomEntityList = chatroomMapper.selectList(null);
        List<ChatroomEntity> userChatroomList = new ArrayList<>();
        for (ChatroomEntity chatroom: chatroomEntityList) {
            if (isMember(chatroom.getChatroomId()) == 1) { // 当前用户是聊天室成员
                chatroom.setUserIds(null); // 信息隐藏
                userChatroomList.add(chatroom);
            }
        }
        return userChatroomList;
    }

    /**
     * 删除聊天室
     * @param chatroomId 聊天室ID
     * @return 是否删除成功
     */
    @Override
    public int removeChatroom(Long chatroomId) {
        ChatroomEntity chatroom = chatroomMapper.selectById(chatroomId);
        if (chatroom != null)
            chatroomMapper.deleteById(chatroomId);
        return 1;
    }
}




