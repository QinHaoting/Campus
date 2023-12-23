package com.oddfar.campus.business.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageInfo;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.domain.vo.UserRelationVo;
import com.oddfar.campus.business.enums.CampusBizCodeEnum;
import com.oddfar.campus.business.mapper.UserRelationMapper;
import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.core.page.PageUtils;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.framework.mapper.SysUserMapper;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.ArrayList;
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


    @Override
    public int follow(Long senderID, Long receiverID) {
        UserRelationEntity userRelationEntity = new UserRelationEntity(senderID, receiverID, new Integer(String.valueOf(CampusBizCodeEnum.RELATION_FOLLOW)));
        userRelationMapper.insert(userRelationEntity);
        return 0;
    }

    @Override
    public int specialFollow(Long senderID, Long receiverID) {
        return 0;
    }

    @Override
    public int block(Long senderID, Long receiverID) {
        return 0;
    }

    @Override
    public PageResult<SysUserEntity> getFollowList(Long userID) {
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        List<Long> receiverIDs = userRelationMapper.getFollowList(userID); // 被关注用户列表ID
        //获取总关注数
        long total = new PageInfo(receiverIDs).getTotal();

        List<SysUserEntity> users = new ArrayList<>();
        SysUserEntity user;
        for (Long id : receiverIDs) {
            user = userMapper.selectUserById(id);
            user.setPassword(null);
            user.setEmail(null);
            user.setPhonenumber(null);
            user.setLoginIp(null);
            user.setLoginDate(null);
            users.add(user);
            user = null; // 清空
        }
        // TODO 隐藏信息

        return new PageResult<>(users, total);
    }

    @Override
    public PageResult<SysUserEntity> getSpecialFollowList(Long userID) {
        return null;
    }

    @Override
    public PageResult<SysUserEntity> getBlockList(Long userID) {
        return null;
    }

    @Override
    public boolean isFollow(Long senderID, Long receiverID) {
        return false;
    }

    @Override
    public boolean isSpecialFollow(Long senderID, Long receiverID) {
        return false;
    }

    @Override
    public boolean isBlock(Long senderID, Long receiverID) {
        return false;
    }
}




