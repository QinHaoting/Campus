package com.oddfar.campus.business.domain.entity;

import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;
import org.springframework.context.annotation.Primary;

import javax.validation.constraints.NotNull;
import java.util.Date;

/**
 * 
 * @TableName campus_content_love
 */
@TableName(value ="campus_relation")
@Data
public class UserRelationEntity {
    private static final long serialVersionUID = 1L;

    /**
     * 关系记录主键
     */
    @TableId
    private Long relationID;

    /**
     * 关系发起者ID
     */
    private Long senderID;

    /**
     * 关系接收者ID
     */
    private Long receiverID;

    /**
     * 关系类型
     */
    @NotNull(message = "类别不能为空")
    private Integer type;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;

    public UserRelationEntity() {
    }

    public UserRelationEntity(Long senderID, Long receiverID, Integer type) {
        this.senderID = senderID;
        this.receiverID = receiverID;
        this.type = type;
    }

}