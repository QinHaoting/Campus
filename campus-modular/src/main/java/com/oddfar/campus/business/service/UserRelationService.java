package com.oddfar.campus.business.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.oddfar.campus.business.domain.entity.ContentLoveEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.domain.vo.ContentVo;
import com.oddfar.campus.business.domain.vo.UserRelationVo;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.entity.SysUserEntity;

import java.util.List;

/**
 * @author Haoting
 */
public interface UserRelationService extends IService<UserRelationEntity> {

    /**
     * 关注
     * @param senderId 关注者ID
     * @param receiverId 被关注者ID
     * @return 是否成功关注
     */
    int follow(Long senderId, Long receiverId);

    /**
     * 关注
     * @param senderId 关注者ID
     * @param receiverId 被特别关注者ID
     * @return 是否成功特别关注
     */
    int specialFollow(Long senderId, Long receiverId);

    /**
     * 关注
     * @param senderId 拉黑者ID
     * @param receiverId 拉黑者ID
     * @return 是否成功特别关注
     */
    int block(Long senderId, Long receiverId);

    /**
     * 获取关注列表
     * @param userId 用户ID
     * @return 关注列表
     */
    PageResult<SysUserEntity> getFollowList(Long userId);

    /**
     * 获取特别关注列表
     * @param userId 用户ID
     * @return 特别关注列表
     */
    PageResult<SysUserEntity> getSpecialFollowList(Long userId);

    /**
     * 获取黑名单列表
     * @param userId 用户ID
     * @return 黑名单列表
     */
    PageResult<SysUserEntity> getBlockList(Long userId);

    /**
     * 用户是否关注
     * @param senderId 关注者
     * @param receiverId 被关注者
     * @return 真关注
     */
    boolean isFollow(Long senderId, Long receiverId);

    /**
     * 用户是否特别关注
     * @param senderId 关注者
     * @param receiverId 被特别关注者
     * @return 真特别关注
     */
    boolean isSpecialFollow(Long senderId, Long receiverId);

    /**
     * 用户是否拉黑
     * @param senderId 拉黑者
     * @param receiverId 被特别拉黑者
     * @return 真拉黑
     */
    boolean isBlock(Long senderId, Long receiverId);
}
