package com.oddfar.campus.business.controller.web;

import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.business.service.ChatroomService;
import com.oddfar.campus.business.service.MessageService;
import com.oddfar.campus.common.annotation.ApiResource;
import com.oddfar.campus.common.domain.R;
import com.oddfar.campus.common.enums.ResBizTypeEnum;
import com.oddfar.campus.common.utils.SecurityUtils;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/chatroom")
@ApiResource(name = "聊天室api", appCode = "message", resBizType = ResBizTypeEnum.BUSINESS)
public class ChatroomController {

    @Autowired
    private ChatroomService chatroomService;

    /**
     * 创建聊天室
     * @param ids 聊天室成员ID
     * @return 是否创建成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/createChatroom", name = "创建聊天室")
    public R createChatRoom(@RequestBody List<Long> ids) {
        int flag = chatroomService.createChatroom(ids);
        if (flag > 0) {
            return R.ok("创建聊天室成功");
        }
        else {
            return R.error("创建聊天室失败");
        }
    }

    /**
     * 查看指定聊天室成员
     * @param id 聊天室ID
     * @return 聊天室成员
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/getMembers", name = "获取聊天室成员")
    public R getMembers(Long id) {
        int flag = chatroomService.isMember(id);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 0: return R.error("你不是该聊天室成员");
            default: return R.ok().setData(chatroomService.getUsers(id));
        }
    }

    /**
     * 删除聊天室
     * @param id 聊天室ID
     * @return 是否删除成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/removeChatroom", name = "删除聊天室")
    public R removeChatroom(Long id) {
        int flag = chatroomService.isOwner(id);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 0: return R.error("你不是该聊天室群主");
            default: {
                if (chatroomService.removeChatroom(id) > 0)
                    return R.ok("成功删除聊天室");
                else
                    return R.error();
            }
        }
    }
}
