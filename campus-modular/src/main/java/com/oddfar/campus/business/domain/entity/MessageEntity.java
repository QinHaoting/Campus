package com.oddfar.campus.business.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 
 * @TableName campus_message
 */
@TableName(value ="campus_message")
@Data
public class MessageEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 消息主键
     */
    @TableId(value = "message_id", type = IdType.AUTO)
    private Long messageId;

    /**
     * 消息发送者ID
     */
    @NotNull(message = "消息发送者ID不能为空")
    @TableField(value = "sender_id")
    private Long senderId;

    /**
     * 消息接收者ID
     */
    @NotNull(message = "消息接收者ID不能为空")
    @TableField(value = "receiver_id")
    private Long receiverId;

    /**
     * 消息内容
     */
    @NotNull(message = "类别不能为空")
    @TableField(value = "content")
    private String content;

    /**
     * 消息类型
     */
    @NotNull(message = "类别不能为空")
    @TableField(value = "type")
    private Integer type;

    @TableField(value = "create_time", fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    /**
     * 消息发送者小名
     */
    @TableField(exist = false)
    private String senderName;
}