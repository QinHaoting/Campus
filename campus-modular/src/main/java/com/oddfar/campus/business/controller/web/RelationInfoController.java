package com.oddfar.campus.business.controller.web;

import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.annotation.ApiResource;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.R;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.enums.ResBizTypeEnum;
import com.oddfar.campus.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

@RestController
@RequestMapping("/relation")
@ApiResource(name = "关系api", appCode = "relation", resBizType = ResBizTypeEnum.BUSINESS)
public class RelationInfoController {

    @Autowired
    private UserRelationService userRelationService;

    /**
     * 关注
     * @param receiverID 被关注者ID
     * @return 是否关注成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/follow/{receiverID}", name = "关注")
    public R follow(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.follow(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("关注成功");
        }
        else {
            return R.ok().setData("已关注");
        }
    }

    /**
     * 取消关注
     * @param receiverID 被关注者ID
     * @return 是否取消关注成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/cancelFollow/{receiverID}", name = "取消关注")
    public R cancelFollow(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.cancelFollow(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("取消关注成功");
        }
        else {
            return R.ok().setData("不存在关注关系");
        }
    }

    /**
     * 特别关注
     * @param receiverID 被特别关注者ID
     * @return 是否特别关注成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PutMapping(value = "/specialFollow/{receiverID}", name = "特别关注")
    public R specialFollow(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.specialFollow(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("特别关注成功");
        }
        else {
            return R.ok().setData("特别关注失败，未建立关注");
        }
    }

    /**
     * 取消特别关注
     * @param receiverID 被关注者ID
     * @return 是否取消特别关注成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PutMapping(value = "/cancelSpecialFollow/{receiverID}", name = "取消特别关注")
    public R cancelSpecialFollow(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.cancelSpecialFollow(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("取消特别关注成功");
        }
        else {
            return R.ok().setData("不存在特别关注关系");
        }
    }

    /**
     * 拉黑
     * @param receiverID 被拉黑者ID
     * @return 是否拉黑成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/block/{receiverID}", name = "拉黑")
    public R block(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.block(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("拉黑成功");
        }
        else {
            return R.ok().setData("拉黑失败");
        }
    }

    /**
     * 取消拉黑
     * @param receiverID 被拉黑者ID
     * @return 是否取消拉黑成功
     */
    @PreAuthorize("@ss.resourceAuth()")
    @PostMapping(value = "/cancelBlock/{receiverID}", name = "取消拉黑")
    public R cancelBlock(@PathVariable Long receiverID) {
        Long userId = SecurityUtils.getUserId();
        int flag = userRelationService.cancelFollow(userId, receiverID);
        if (flag == 1) {
            return R.ok().setData("取消拉黑成功");
        }
        else {
            return R.ok().setData("不存在拉黑关系");
        }
    }

    /**
     * 查询自己的关注列表
     * @return 关注列表
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/followList", name = "查询关注列表")
    public R getFollowList() {
        //获取关注列表
        Long userID = SecurityUtils.getUserId();
        PageResult<SysUserEntity> followList = userRelationService.getFollowList(userID);
        return R.ok().put("followList", followList);
    }

    /**
     * 查询特别关注列表
     * @return 特别关注列表
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/specialFollowList", name = "查询特别关注列表")
    public R getSpecialFollowList() {
        //获取关注列表
        Long userID = SecurityUtils.getUserId();
        PageResult<SysUserEntity> specialFollowList = userRelationService.getSpecialFollowList(userID);
        return R.ok().put("specialFollowList", specialFollowList);
    }

    /**
     * 查询被拉黑人员名单
     * @return 黑名单
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/blockList", name = "查询黑名单")
    public R getBlockList() {
        //获取关注列表
        Long userID = SecurityUtils.getUserId();
        PageResult<SysUserEntity> blockList = userRelationService.getBlockList(userID);
        return R.ok().put("blockList", blockList);
    }
}
