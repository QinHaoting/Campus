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
     * @param senderID 关注者ID
     * @param receiverID 被关注者ID
     * @return 是否成功关注
     */
    int follow(Long senderID, Long receiverID);

    /**
     * 关注
     * @param senderID 关注者ID
     * @param receiverID 被特别关注者ID
     * @return 是否成功特别关注
     */
    int specialFollow(Long senderID, Long receiverID);

    /**
     * 关注
     * @param senderID 拉黑者ID
     * @param receiverID 拉黑者ID
     * @return 是否成功特别关注
     */
    int block(Long senderID, Long receiverID);

    /**
     * 获取关注列表
     * @param userID 用户ID
     * @return 关注列表
     */
    PageResult<SysUserEntity> getFollowList(Long userID);

    /**
     * 获取特别关注列表
     * @param userID 用户ID
     * @return 特别关注列表
     */
    PageResult<SysUserEntity> getSpecialFollowList(Long userID);

    /**
     * 获取黑名单列表
     * @param userID 用户ID
     * @return 黑名单列表
     */
    PageResult<SysUserEntity> getBlockList(Long userID);

    /**
     * 用户是否关注
     * @param senderID 关注者
     * @param receiverID 被关注者
     * @return 真关注
     */
    boolean isFollow(Long senderID, Long receiverID);

    /**
     * 用户是否特别关注
     * @param senderID 关注者
     * @param receiverID 被特别关注者
     * @return 真特别关注
     */
    boolean isSpecialFollow(Long senderID, Long receiverID);

    /**
     * 用户是否拉黑
     * @param senderID 拉黑者
     * @param receiverID 被特别拉黑者
     * @return 真拉黑
     */
    boolean isBlock(Long senderID, Long receiverID);
}
