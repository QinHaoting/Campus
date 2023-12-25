package com.oddfar.campus.business.domain.entity;

import com.baomidou.mybatisplus.annotation.*;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.oddfar.campus.common.domain.BaseEntity;
import lombok.Data;
import org.springframework.context.annotation.Primary;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 
 * @TableName campus_relation
 */
@TableName(value ="campus_relation")
@Data
public class UserRelationEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 关系记录主键
     */
    @TableId(value = "relation_id", type = IdType.AUTO)
    private Long relationId;

    /**
     * 关系发起者ID
     */
    @NotNull(message = "关系发起者ID不能为空")
    private Long senderId;

    /**
     * 关系接收者ID
     */
    @NotNull(message = "关系接收者ID不能为空")
    private Long receiverId;

    /**
     * 关系类型
     */
    @NotNull(message = "类别不能为空")
    private Integer type;

    @TableField(value = "create_time", fill = FieldFill.INSERT_UPDATE)
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    public UserRelationEntity() {
    }

    public UserRelationEntity(Long senderId, Long receiverId, Integer type) {
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.type = type;
    }

}