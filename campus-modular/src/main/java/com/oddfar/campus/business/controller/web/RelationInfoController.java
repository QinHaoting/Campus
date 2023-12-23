package com.oddfar.campus.business.controller.web;

import com.oddfar.campus.business.domain.entity.ContentEntity;
import com.oddfar.campus.business.domain.vo.ContentQueryVo;
import com.oddfar.campus.business.domain.vo.ContentVo;
import com.oddfar.campus.business.domain.vo.SendContentVo;
import com.oddfar.campus.business.domain.vo.UserRelationVo;
import com.oddfar.campus.business.service.ContentLoveService;
import com.oddfar.campus.business.service.ContentService;
import com.oddfar.campus.business.service.UserRelationService;
import com.oddfar.campus.common.annotation.Anonymous;
import com.oddfar.campus.common.annotation.ApiResource;
import com.oddfar.campus.common.core.page.PageUtils;
import com.oddfar.campus.common.core.text.Convert;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.R;
import com.oddfar.campus.common.enums.ResBizTypeEnum;
import com.oddfar.campus.common.utils.SecurityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/campus")
@ApiResource(name = "关系api", appCode = "campus", resBizType = ResBizTypeEnum.BUSINESS)
public class RelationInfoController {

    @Autowired
    private UserRelationService userRelationService;

    /**
     * 查询自己的关注列表
     */
    @PreAuthorize("@ss.resourceAuth()")
    @GetMapping(value = "/getFollowList", name = "查询点赞的信息墙列表")
    public R getFollowList() {
        //获取关注列表
        Long userID = SecurityUtils.getUserId();
        PageResult<UserRelationVo> followList = userRelationService.getFollowList(userID);
        return R.ok().put(followList);
    }
}
