package com.oddfar.campus.business.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 
 * @TableName campus_chatroom
 */
@TableName(value ="campus_chatroom")
@Data
public class ChatroomEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 聊天室主键
     */
    @TableId(value = "chatroom_id", type = IdType.AUTO)
    private Long chatroomId;

    /**
     * 聊天室群主ID
     */
    @NotNull(message = "聊天室不能没有群主")
    @TableField(value = "owner_id")
    private Long ownerId;

    /**
     * 聊天室所有用户ID
     */
    @NotNull(message = "聊天室不能没人接收消息")
    @TableField(value = "user_ids")
    private String userIds;


    @TableField(value = "create_time", fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

}