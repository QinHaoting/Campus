package com.oddfar.campus.business.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.oddfar.campus.business.core.constant.CampusConstant;
import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.common.core.LambdaQueryWrapperX;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;
import java.util.stream.Collectors;


@Mapper
public interface MessageMapper extends BaseMapper<MessageEntity> {

}




