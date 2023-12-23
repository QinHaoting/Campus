package com.oddfar.campus.business.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.oddfar.campus.business.core.constant.CampusConstant;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.common.core.LambdaQueryWrapperX;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.stream.Collectors;


@Mapper
public interface UserRelationMapper extends BaseMapper<UserRelationEntity> {

    /**
     * 用户是否给某人关注
     *
     * @param senderId
     * @param receiverId
     * @return
     */
    default boolean isFollow(Long senderId, Long receiverId) {
        Long num = selectCount(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        return num > 0;
    }

    /**
     * 取消关注
     *
     * @param senderId   关注者ID
     * @param receiverId 被关注者ID
     * @return 是否成功取消关注
     */
    default int cancelFollow(Long senderId, Long receiverId) {
        UserRelationEntity record = selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getReceiverId, receiverId));
        record.setType(0);
        update(record, new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId));
        return 1;
    }

    /**
     * 筛选出关注列表
     *
     * @param senderId 关系发起者ID
     * @return 被关注者ID列表
     */
    default List<Long> getFollowList(Long senderId) {
        List<UserRelationEntity> followList = selectList(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getType, CampusConstant.RELATION_FOLLOW)
                .or()
                .eq(UserRelationEntity::getType, CampusConstant.RELATION_SPECIAL_FOLLOW));
        List<Long> IDs = followList.stream().map(UserRelationEntity::getReceiverId).collect(Collectors.toList());
        return IDs;
    }

    /**
     * 筛选出特别关注列表
     *
     * @param senderId 特别关注发起者ID
     * @return 被特别关注者ID列表
     */
    default List<Long> getSpecialFollowList(Long senderId) {
        List<UserRelationEntity> followList = selectList(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getType, CampusConstant.RELATION_SPECIAL_FOLLOW));
        List<Long> IDs = followList.stream().map(UserRelationEntity::getReceiverId).collect(Collectors.toList());
        return IDs;
    }

    /**
     * 筛选出被拉黑列表
     * @param senderId 拉黑关系发起者ID
     * @return 黑名单
     */
    default List<Long> getBlockList(Long senderId) {
        List<UserRelationEntity> loves = selectList(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderId, senderId)
                .eq(UserRelationEntity::getType, CampusConstant.RELATION_BLOCK));
        List<Long> IDs = loves.stream().map(UserRelationEntity::getReceiverId).collect(Collectors.toList());
        return IDs;
    }


}




