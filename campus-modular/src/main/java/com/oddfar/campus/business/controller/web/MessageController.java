package com.oddfar.campus.business.controller.web;

import com.oddfar.campus.business.core.constant.MessageConstant;
import com.oddfar.campus.business.domain.entity.MessageEntity;
import com.oddfar.campus.business.service.ChatroomService;
import com.oddfar.campus.business.service.MessageService;
import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.annotation.ApiResource;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.R;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.enums.ResBizTypeEnum;
import com.oddfar.campus.common.utils.DateUtils;
import com.oddfar.campus.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/message")
@ApiResource(name = "消息api", appCode = "message", resBizType = ResBizTypeEnum.BUSINESS)
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private ChatroomService chatroomService;

    /**
     * 发送消息
     * @param message 聊天室ID+消息内容
     * @return 是否发送成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/sendMessage", name = "发送消息")
    public R sendMessage(@RequestBody MessageEntity message) {
        int flag = messageService.sendMessage(message);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 1: return R.ok("发送成功");
            default: return R.error("发送失败");
        }
    }

    /**
     * 查看指定聊天室的消息
     * @param id 查看接收者ID
     * @return 是否接收成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/getMessage", name = "获取指定聊天室消息")
    public R getMessageByID(Long id) {
        int flag = chatroomService.isMember(id);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 0: return R.error("你不是聊天室成员");
            default: return R.ok().setData(messageService.getMessageByChatroomId(id));
        }
    }

    /**
     * 根据消息ID修改消息记录
     * @param message 更新后的消息实体
     * @return 是否修改成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PutMapping(value = "/updateMessage", name = "修改消息")
    public R updateMessage(@RequestBody MessageEntity message) {
        Long chatroomId = message.getReceiverId();
        System.out.println("message:" + message);
        int flag = chatroomService.isMember(chatroomId);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 0: return R.error("你不是聊天室成员");
            default: {
                if (!message.getSenderId().equals(SecurityUtils.getUserId())) // 当前用户不是消息发起者，不可修改
                    return R.error("你不是消息发起者");
                else {
                    message.setCreateTime(DateUtils.getNowDate());
                    if (messageService.updateById(message))
                        return R.ok("修改成功");
                    return R.error("消息不存在");
                }
            }
        }
    }

    /**
     * 根据消息ID删除消息记录
     * @param id 消息记录ID
     * @return 是否删除成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @DeleteMapping(value = "/deleteMessage", name = "删除消息")
    public R deleteMessage(Long id) {
        MessageEntity message = messageService.getById(id);
        if (message == null)
            return R.error("消息不存在");

        Long chatroomId = message.getReceiverId();
        int flag = chatroomService.isMember(chatroomId);
        switch (flag) {
            case -1: return R.error("聊天室不存在");
            case 0: return R.error("你不是聊天室成员");
            default: {
                if (!message.getSenderId().equals(SecurityUtils.getUserId())) // 当前用户不是消息发起者，不可修改
                    return R.error("你不是消息发起者");
                else {
                    if (messageService.removeById(id))
                        return R.ok("删除成功");
                    return R.error("消息不存在");
                }
            }
        }
    }
}
