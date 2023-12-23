package com.oddfar.campus.business.controller.web;

import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.annotation.Anonymous;
import com.oddfar.campus.common.annotation.ApiResource;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.R;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.enums.ResBizTypeEnum;
import com.oddfar.campus.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
@RequestMapping("/relation")
@ApiResource(name = "关系api", appCode = "relation", resBizType = ResBizTypeEnum.BUSINESS)
public class RelationInfoController {

    @Autowired
    private UserRelationService userRelationService;

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
