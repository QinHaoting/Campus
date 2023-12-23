package com.oddfar.campus.business.domain.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import javax.validation.constraints.NotNull;
import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Data
public class UserRelationVo {
    private static final long serialVersionUID = 1L;

    /**
     * 关系记录主键
     */
    private Long relationId;

    /**
     * 关系发起者ID
     */
    private Long senderId;

    /**
     * 关系接收者ID
     */
    private Long receiverId;

    /**
     * 关系类型
     */
    @NotNull(message = "类别不能为空")
    private Integer type;

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
    private Date createTime;

    private Map<String, Object> params;

    public Map<String, Object> getParams()
    {
        if (params == null)
        {
            params = new HashMap<>();
        }
        return params;
    }
}
