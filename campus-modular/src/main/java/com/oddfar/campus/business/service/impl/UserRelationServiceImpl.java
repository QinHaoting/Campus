package com.oddfar.campus.business.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageInfo;
import com.oddfar.campus.business.core.constant.CampusConstant;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.domain.vo.UserRelationVo;
import com.oddfar.campus.business.enums.CampusBizCodeEnum;
import com.oddfar.campus.business.mapper.UserRelationMapper;
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
import java.util.Date;
import java.util.List;


/**
 * @author 致远
 */
@Service
public class UserRelationServiceImpl extends ServiceImpl<UserRelationMapper, UserRelationEntity>
        implements UserRelationService {

    private static final int WEB_PAGE_SIZE = 5;

    @Resource
    private UserRelationMapper userRelationMapper;

    @Resource
    private SysUserMapper userMapper;


    /**
     * 发起关注
     * @param senderId 关注者ID
     * @param receiverId 被关注者ID
     * @return
     */
    @Override
    public int follow(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 未存在关系
            userRelationEntity = new UserRelationEntity(senderId, receiverId, CampusConstant.RELATION_FOLLOW);
            userRelationEntity.setCreateTime(DateUtils.getNowDate());
            return userRelationMapper.insert(userRelationEntity);
        }
        else { // 已关注
            userRelationEntity.setType(CampusConstant.RELATION_FOLLOW);
            userRelationEntity.setCreateTime(DateUtils.getNowDate());
            return userRelationMapper.updateById(userRelationEntity);
        }
    }

    /**
     * 取消关注
     * @param senderId 关注者ID
     * @param receiverId 被关注者ID
     * @return
     */
    @Override
    public int cancelFollow(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 未存在关系
            return -1;
        }
        else {
            return userRelationMapper.deleteById(userRelationEntity);
        }
    }

    /**
     * 发起特别关注
     * @param senderId 关注者ID
     * @param receiverId 被特别关注者ID
     * @return 是否成功关注
     */
    @Override
    public int specialFollow(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 不存在该关系
            return -1; // 先关注才能特别关注
        }
        userRelationEntity.setType(CampusConstant.RELATION_SPECIAL_FOLLOW);
        return userRelationMapper.updateById(userRelationEntity);
    }

    /**
     * 取消特别关注
     * @param senderId 关注者ID
     * @param receiverId 被关注者ID
     * @return
     */
    @Override
    public int cancelSpecialFollow(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 未存在关系
            return -1;
        }
        else {
            userRelationEntity.setType(CampusConstant.RELATION_FOLLOW); // 取消特别关注 = 关注
            return userRelationMapper.updateById(userRelationEntity);
        }
    }

    @Override
    public int block(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 未存在关系
            userRelationEntity = new UserRelationEntity(senderId, receiverId, CampusConstant.RELATION_BLOCK);
            userRelationEntity.setCreateTime(DateUtils.getNowDate());
            return userRelationMapper.insert(userRelationEntity);
        }
        else {
            userRelationEntity.setType(CampusConstant.RELATION_BLOCK);
            userRelationEntity.setCreateTime(DateUtils.getNowDate());
            return userRelationMapper.updateById(userRelationEntity);
        }
    }

    /**
     * 取消拉黑
     * @param senderId 关注者ID
     * @param receiverId 被关注者ID
     * @return
     */
    @Override
    public int cancelBlock(Long senderId, Long receiverId) {
        UserRelationEntity userRelationEntity = userRelationMapper.selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        if (userRelationEntity == null) { // 未存在关系
            return -1;
        }
        else {
            return userRelationMapper.deleteById(userRelationEntity);
        }
    }

    /**
     * 获取关注列表
     * @param userId 用户ID
     * @return 关注列表
     */
    @Override
    public PageResult<SysUserEntity> getFollowList(Long userId) {
        // 开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        List<Long> receiverIDs = userRelationMapper.getFollowList(userId); // 被关注用户列表ID
        // 获取总关注数
        long total = new PageInfo(receiverIDs).getTotal();

        List<SysUserEntity> users = new ArrayList<>();
        SysUserEntity user;
        // TODO 隐藏信息
        for (Long id : receiverIDs) {
            user = userMapper.selectUserById(id);
            user.setPassword(null);
            user.setEmail(null);
            user.setPhonenumber(null);
            user.setLoginIp(null);
            user.setLoginDate(null);
            users.add(user);
        }
        return new PageResult<>(users, total);
    }

    /**
     * 获取特别关注列表
     * @param userId 用户ID
     * @return 特别关注列表
     */
    @Override
    public PageResult<SysUserEntity> getSpecialFollowList(Long userId) {
        // 开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        List<Long> receiverIDs = userRelationMapper.getSpecialFollowList(userId); // 被关注用户列表ID
        // 获取总关注数
        long total = new PageInfo(receiverIDs).getTotal();

        List<SysUserEntity> users = new ArrayList<>();
        SysUserEntity user;
        // TODO 隐藏信息
        for (Long id : receiverIDs) {
            user = userMapper.selectUserById(id);
            user.setPassword(null);
            user.setEmail(null);
            user.setPhonenumber(null);
            user.setLoginIp(null);
            user.setLoginDate(null);
            users.add(user);
        }
        return new PageResult<>(users, total);
    }

    /**
     * 获取黑名单
     * @param userId 用户ID
     * @return 黑名单
     */
    @Override
    public PageResult<SysUserEntity> getBlockList(Long userId) {
        // 开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        List<Long> receiverIDs = userRelationMapper.getBlockList(userId); // 被关注用户列表ID
        // 获取总关注数
        long total = new PageInfo(receiverIDs).getTotal();

        List<SysUserEntity> users = new ArrayList<>();
        SysUserEntity user;
        // TODO 隐藏信息
        for (Long id : receiverIDs) {
            user = userMapper.selectUserById(id);
            user.setPassword(null);
            user.setEmail(null);
            user.setPhonenumber(null);
            user.setLoginIp(null);
            user.setLoginDate(null);
            users.add(user);
        }
        return new PageResult<>(users, total);
    }

    @Override
    public boolean isFollow(Long senderId, Long receiverId) {
        return false;
    }

    @Override
    public boolean isSpecialFollow(Long senderId, Long receiverId) {
        return false;
    }

    @Override
    public boolean isBlock(Long senderId, Long receiverId) {
        return false;
    }
}




