package com.oddfar.campus.business.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.oddfar.campus.business.domain.entity.ContentLoveEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.enums.CampusBizCodeEnum;
import com.oddfar.campus.common.core.BaseMapperX;
import com.oddfar.campus.common.core.LambdaQueryWrapperX;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.stream.Collectors;


@Mapper
public interface UserRelationMapper extends BaseMapper<UserRelationEntity> {

    /**
     * 用户是否给某人关注
     * @param senderID
     * @param receiverID
     * @return
     */
    default boolean isFollow(Long senderID, Long receiverID) {
        Long num = selectCount(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderID, senderID)
                .eq(UserRelationEntity::getReceiverID, receiverID));
        return num > 0;
    }

    /**
     * 取消关注
     * @param senderID 关注者ID
     * @param receiverID 被关注者ID
     * @return 是否成功取消关注
     */
    default int cancelFollow(Long senderID, Long receiverID) {
        UserRelationEntity record = selectOne(new LambdaQueryWrapperX<UserRelationEntity>()
                                .eq(UserRelationEntity::getSenderID, senderID)
                                .eq(UserRelationEntity::getReceiverID, receiverID));
        record.setType(0);
        update(record, new LambdaQueryWrapperX<UserRelationEntity>()
                        .eq(UserRelationEntity::getSenderID, senderID));
        return 1;
    }

    /**
     * 筛选出关注列表
     * @param senderID 关系发起者ID
     * @return 被关注者ID列表
     */
    default List<Long> getFollowList(Long senderID) {
        List<UserRelationEntity> loves = selectList(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderID, senderID)
                .eq(UserRelationEntity::getType, CampusBizCodeEnum.RELATION_FOLLOW)
                .or()
                .eq(UserRelationEntity::getType, CampusBizCodeEnum.RELATION_SPECIAL_FOLLOW));
        List<Long> IDs = loves.stream().map(UserRelationEntity::getReceiverID).collect(Collectors.toList());
        return IDs;
    }

    /**
     * 筛选出关注列表
     * @param senderID 关系发起者ID
     * @return 被关注者ID列表
     */
    default List<Long> getBlockList(Long senderID) {

        List<UserRelationEntity> loves = selectList(new LambdaQueryWrapperX<UserRelationEntity>()
                .eq(UserRelationEntity::getSenderID, senderID)
                .eq(UserRelationEntity::getType, CampusBizCodeEnum.RELATION_BLOCK));
        List<Long> IDs = loves.stream().map(UserRelationEntity::getReceiverID).collect(Collectors.toList());
        return IDs;
    }
}




