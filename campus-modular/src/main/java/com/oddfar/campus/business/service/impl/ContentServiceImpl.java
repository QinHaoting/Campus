package com.oddfar.campus.business.service.impl;

import cn.hutool.core.bean.BeanUtil;
import cn.hutool.core.util.ObjectUtil;
import com.baomidou.mybatisplus.core.toolkit.IdWorker;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.github.pagehelper.PageInfo;
import com.oddfar.campus.business.core.constant.CampusConstant;
import com.oddfar.campus.business.core.expander.CampusConfigExpander;
import com.oddfar.campus.business.domain.entity.CategoryEntity;
import com.oddfar.campus.business.domain.entity.ContentEntity;
import com.oddfar.campus.business.domain.entity.ContentTagEntity;
import com.oddfar.campus.business.domain.entity.UserRelationEntity;
import com.oddfar.campus.business.domain.vo.CampusFileVo;
import com.oddfar.campus.business.domain.vo.ContentVo;
import com.oddfar.campus.business.domain.vo.SendContentVo;
import com.oddfar.campus.business.enums.CampusBizCodeEnum;
import com.oddfar.campus.business.mapper.ContentLoveMapper;
import com.oddfar.campus.business.mapper.ContentMapper;
import com.oddfar.campus.business.mapper.UserRelationMapper;
import com.oddfar.campus.business.service.CampusFileService;
import com.oddfar.campus.business.service.CategoryService;
import com.oddfar.campus.business.service.ContentService;
import com.oddfar.campus.business.service.TagService;
import com.oddfar.campus.common.core.LambdaQueryWrapperX;
import com.oddfar.campus.common.core.page.PageUtils;
import com.oddfar.campus.common.domain.PageResult;
import com.oddfar.campus.common.domain.entity.SysUserEntity;
import com.oddfar.campus.common.exception.ServiceException;
import com.oddfar.campus.common.utils.SecurityUtils;
import com.oddfar.campus.framework.api.sysconfig.ConfigExpander;
import com.oddfar.campus.framework.mapper.SysUserMapper;
import io.swagger.models.auth.In;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.Objects;
import java.util.function.Function;
import java.util.stream.Collectors;


@Service
public class ContentServiceImpl extends ServiceImpl<ContentMapper, ContentEntity>
        implements ContentService {

    private static final int WEB_PAGE_SIZE = 5;
    @Resource
    private ContentMapper contentMapper;
    @Resource
    private CategoryService categoryService;
    @Resource
    private ContentLoveMapper contentLoveMapper;
    @Resource
    private CampusFileService fileService;
    @Resource
    private TagService tagService;
    @Resource
    private UserRelationMapper userRelationMapper;
    @Resource
    private SysUserMapper userMapper;

    @Override
    public PageResult<ContentVo> page(ContentEntity contentEntity) {
        //设置分类等其他参数
        setQueryContentEntity(contentEntity);

        List<ContentVo> contentVoList = contentMapper.selectContentList(contentEntity);

        List<ContentVo> contentVos = contentFilter(contentVoList); // 过滤后的可读文章

        setAnonymous(contentVos);
        //获取文件url列表
        setFileListByContentVos(contentVos);
        //获取标签
        setTagListByContentVos(contentVos);

        return PageUtils.getPageResult(contentVos);
    }

    /**
     * 文章可读过滤
     * @param contentVoList 待过滤文章列表
     * @return 可读文章列表
     */
    private List<ContentVo> contentFilter(List<ContentVo> contentVoList) {
        List<ContentVo> contentVos = new ArrayList<>();
        for (ContentVo contentVo: contentVoList) {
            if (checkContentCanRead(contentVo)) {
                contentVos.add(contentVo);
            }
        }
        return contentVos;
    }

    /**
     * 当前登录者是否可读该文章
     * @param contentVo 文章
     * @return 是否可读
     */
    @Override
    public boolean checkContentCanRead(ContentVo contentVo) {
        Long contentAuthorId = contentVo.getUserId();
        Long currentUserId = SecurityUtils.getUserId();
        if (currentUserId.equals(contentAuthorId)) // 自己可读自己的文章
            return true;
        LambdaQueryWrapperX<UserRelationEntity> lambdaQueryWrapperX = new LambdaQueryWrapperX<>();
        lambdaQueryWrapperX.eq(UserRelationEntity::getSenderId, contentAuthorId);
        lambdaQueryWrapperX.eq(UserRelationEntity::getReceiverId, currentUserId);
        UserRelationEntity relation = userRelationMapper.selectOne(lambdaQueryWrapperX);
        if (relation != null) { // 两者有关系
            if (relation.getType().equals(CampusConstant.RELATION_BLOCK)) // 被拉黑，不可读
                return false;
            // 有关系且非拉黑则至少是关注，可读
        }
        else { // 文章发表者与当前登录者没有关系
            if (contentVo.getReadLevel().equals(CampusConstant.CONTENT_READ_FOLLOW))  // 文章仅关注可读，两者没有关注关系，不可看
                return false;
            // 文章为非拉黑可读，可读
        }
        return true;
    }

    /**
     * 条件查询帖子
     * @param contentVo 查询条件
     * @return 符合条件的帖子
     */
    @Override
    public PageResult<ContentVo> getContentByCondition(ContentVo contentVo) {
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        LambdaQueryWrapperX<ContentEntity> lambdaQueryWrapperX = new LambdaQueryWrapperX<>();
        lambdaQueryWrapperX.eq(contentVo.getContentId()!=null && contentVo.getContentId()!=0, ContentEntity::getContentId, contentVo.getContentId());
        lambdaQueryWrapperX.eq(contentVo.getUserId()!=null && contentVo.getUserId()!=0, ContentEntity::getUserId, contentVo.getUserId());
        lambdaQueryWrapperX.like(contentVo.getContent()!=null && !contentVo.getContent().equals(""), ContentEntity::getContent, contentVo.getContent());
        lambdaQueryWrapperX.eq(contentVo.getStatus()!=null, ContentEntity::getStatus, contentVo.getStatus());
        lambdaQueryWrapperX.eq(contentVo.getType()!=null, ContentEntity::getType, contentVo.getType());
        lambdaQueryWrapperX.eq(contentVo.getIsAnonymous()!=null, ContentEntity::getIsAnonymous, contentVo.getIsAnonymous());
        lambdaQueryWrapperX.eq(contentVo.getReadLevel()!=null, ContentEntity::getReadLevel, contentVo.getReadLevel());

        List<ContentEntity> contentEntities = contentMapper.selectList(lambdaQueryWrapperX);
        if (contentEntities.size() == 0) { // 无符合条件的帖子
            return null;
        }
        // 有帖子
        List<Long> contentIds = new ArrayList<>();
        for (ContentEntity content: contentEntities) {
            if (checkContentCanRead(new ContentVo(content)))
                contentIds.add(content.getContentId());
        }

        //获取数量
        long total = new PageInfo(contentIds).getTotal();
        List<ContentVo> contentVos = contentMapper.selectContentByIds(contentIds);

        return new PageResult<>(contentVos, total);
    }

    @Override
    public PageResult<ContentVo> newestPage() {
        ContentEntity contentEntity = new ContentEntity();
        contentEntity.getParams().put("orderBy", "newest");
        contentEntity.setStatus(1);
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);

        return page(contentEntity);
    }

    @Override
    public PageResult<ContentVo> hotPage() {
        ContentEntity contentEntity = new ContentEntity();
        contentEntity.setStatus(1);
        contentEntity.getParams().put("orderBy", "hotContent");
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);

        return page(contentEntity);
    }

    @Override
    public PageResult<ContentVo> getLoveContentByUserId(Long userId) {
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        List<Long> contentIds = contentMapper.selectLoveContentList(userId);
        //获取总点赞的墙数量
        long total = new PageInfo(contentIds).getTotal();
        List<ContentVo> contentVos = contentMapper.selectContentByIds(contentIds);

        return new PageResult<>(contentVos, total);
    }

    @Override
    public PageResult<ContentVo> getOwnContent() {

        ContentEntity contentEntity = new ContentEntity();
        contentEntity.setUserId(SecurityUtils.getUserId());
        contentEntity.getParams().put("orderBy", "newest");
        //开始分页
        PageUtils.startPage(WEB_PAGE_SIZE);
        return page(contentEntity);
    }


    @Override
    public ContentVo selectContentByContentId(ContentEntity contentEntity) {
        ContentVo contentVo = contentMapper.selectContentByContent(contentEntity);
        if (contentVo != null) {
            //设置文件
            setFileByContentEntity(contentVo);
        }
        return contentVo;
    }

    @Override
    @Transactional
    public int sendContent(SendContentVo sendContentVo) {

        ContentEntity contentEntity = new ContentEntity();
        assertAllowed(sendContentVo);
        BeanUtil.copyProperties(sendContentVo, contentEntity);

        //设置信息
        contentEntity.setUserId(SecurityUtils.getUserId());
        if (sendContentVo.getFileList() != null && sendContentVo.getFileList().size() > 0) {
            contentEntity.setFileCount(sendContentVo.getFileList().size());

        } else {
            contentEntity.setFileCount(0);
            contentEntity.setType(0);
        }

        contentEntity.setContentId(IdWorker.getId());
        contentEntity.setStatus(0);

        if (contentEntity.getReadLevel() == null)
            contentEntity.setReadLevel(0); // 默认非拉黑可读

        int insert = contentMapper.insert(contentEntity);
        //更新文件数据库
        fileService.updateContentFile(sendContentVo.getFileList(), contentEntity.getContentId());

        return insert;
    }

    @Override
    public int updateContent(ContentEntity content) {

        return contentMapper.updateById(content);
    }

    @Override
    public List<ContentEntity> getSimpleHotContent() {

        return contentMapper.getSimpleHotContent();
    }

    @Override
    public List<ContentEntity> getSimpleContentText(List<Long> contentIdList) {
        List<ContentEntity> simpleContentText = contentMapper.getSimpleContentText(contentIdList);
        return simpleContentText;
    }

    @Override
    public void deleteContentById(Long contentId) {
        ContentEntity contentEntity = contentMapper.selectById(contentId);
        if (contentEntity == null) {
            return;
        }
        //TODO 删除信息墙的处理
        //删除评论

        //墙的文件处理

        //删除墙
        contentMapper.deleteById(contentId);
    }

    @Override
    public void deleteOwnContent(Long contentId) {
        Long userId = SecurityUtils.getUserId();
        ContentEntity contentEntity = contentMapper.selectById(contentId);
        if (contentEntity != null && contentEntity.getUserId().equals(userId)) {
            deleteContentById(contentId);
        } else {
            throw new ServiceException(CampusBizCodeEnum.CONTENT_NOT_YOU.getMsg(), CampusBizCodeEnum.CONTENT_NOT_YOU.getCode());
        }
    }

    @Override
    public boolean checkOwnContent(Long contentId) {
        ContentEntity contentEntity = contentMapper.selectById(contentId);
        if (contentEntity.getUserId().equals(SecurityUtils.getUserId())) {
            return true;
        } else {
            return false;
        }
    }


    /**
     * 文件 分类核对
     *
     * @param sendContentVo
     */
    private void assertAllowed(SendContentVo sendContentVo) {

        CategoryEntity category = categoryService.getById(sendContentVo.getCategoryId());
        if (category == null) {
            throw new ServiceException(CampusBizCodeEnum.CATEGORY_NOT_EXIST.getMsg(),
                    CampusBizCodeEnum.CATEGORY_NOT_EXIST.getCode());
        }

        if (sendContentVo.getType() == 0) {
            //类别为文字时候，内容不能为空
            if (sendContentVo.getContent().length() == 0) {
                throw new ServiceException(CampusBizCodeEnum.CONTENT_NOT_NULL.getMsg(),
                        CampusBizCodeEnum.CONTENT_NOT_NULL.getCode());
            }
            sendContentVo.setFileList(null);
        } else {
            if (sendContentVo.getFileList() == null) {
                throw new ServiceException(CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getMsg(),
                        CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getCode());
            }
            if (sendContentVo.getType() == 1) {
                //类别为图片时候，文件数量最大为3
                if (sendContentVo.getFileList().size() < 1 || sendContentVo.getFileList().size() > 3) {
                    throw new ServiceException(CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getMsg(),
                            CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getCode());
                }
            }
            if (sendContentVo.getType() == 2) {
                //类别为视频，文件数量为1
                if (sendContentVo.getFileList().size() != 1) {
                    throw new ServiceException(CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getMsg(),
                            CampusBizCodeEnum.CONTENT_FILE_COUNT_EXCEPTION.getCode());
                }
            }
            //判断文件是否都存在
            if (!fileService.fileExist(sendContentVo.getFileList(), sendContentVo.getType())) {
                throw new ServiceException(CampusBizCodeEnum.CONTENT_FILE_EXCEPTION.getMsg(),
                        CampusBizCodeEnum.CONTENT_FILE_EXCEPTION.getCode());
            }
        }

    }

    /**
     * 用户发表信息墙时，设置其参数
     *
     * @param contentEntity
     */
    private void setAddContentEntity(ContentEntity contentEntity) {


    }

    /**
     * 查询信息墙时，设置分类等其他参数
     *
     * @param contentEntity
     */
    private void setQueryContentEntity(ContentEntity contentEntity) {

        CategoryEntity category = categoryService.selectCategoryById(contentEntity.getCategoryId());
        //查询当前分类及其子类
        if (category != null && category.getParentId() == 0 && category.getChildren() != null) {
            List<Long> categoryIds = category.getChildren().stream()
                    .map(CategoryEntity::getCategoryId).collect(Collectors.toList());
            categoryIds.add(contentEntity.getCategoryId());
            contentEntity.getParams().put("categoryIds", categoryIds);
        }
        //查询当前分类
        if (category != null && (category.getParentId() != 0 || category.getChildren() == null)) {
            List<Long> categoryIds = new ArrayList<>();
            categoryIds.add(category.getCategoryId());
            contentEntity.getParams().put("categoryIds", categoryIds);
        }
    }

    /**
     * 设置信息墙列表的文件url列表
     *
     * @param contentVos
     */
    private void setFileListByContentVos(List<ContentVo> contentVos) {

        List<Long> contentIds = contentVos.stream().map(ContentVo::getContentId).collect(Collectors.toList());
        //获取文件
        if (contentIds.size() <= 0) {
            return;
        }
        List<CampusFileVo> contentFiles = fileService.getContentFile(contentIds);
        //把文件list转map
        Map<Long, CampusFileVo> fileVoMap =
                contentFiles.stream().collect(Collectors.toMap(CampusFileVo::getContentId, Function.identity()));
        //文件信息加入到ContentVo集合
        contentVos.forEach(vo -> {
            if (fileVoMap.containsKey(vo.getContentId())) {
                vo.setFileUrl(fileVoMap.get(vo.getContentId()).getFileUrls());
            }
        });

    }

    /**
     * 设置信息墙列表的标签列表
     *
     * @param contentVos
     */
    private void setTagListByContentVos(List<ContentVo> contentVos) {

        List<Long> contentIds = contentVos.stream().map(ContentVo::getContentId).collect(Collectors.toList());
        if (contentIds.size() <= 0) {
            return;
        }
        //获取有关系的tag列表
        List<ContentTagEntity> contentTags = tagService.getTagListByContentIds(contentIds);
        //把标签list转map
        Map<Long, List<ContentTagEntity>> tagMap = contentTags.stream().collect(Collectors.groupingBy(ContentTagEntity::getContentId));
        //文件信息加入到ContentVo集合
        contentVos.forEach(vo -> {
            if (tagMap.containsKey(vo.getContentId())) {
                vo.setTags(tagMap.get(vo.getContentId()));
            }
        });

    }

    /**
     * 设置信息墙的文件
     *
     * @param contentVo
     */
    private void setFileByContentEntity(ContentVo contentVo) {
        //设置头像
        Map<String, Object> params = contentVo.getParams();
        if ((!params.containsKey("avatar")) || ObjectUtil.isEmpty(params.get("avatar"))) {
            params.put("avatar", ConfigExpander.getUserDefaultAvatar());
        }

        if (contentVo.getType() != 0) {

        }
        CampusFileVo contentFile = fileService.getContentFile(contentVo.getContentId());
        if (contentFile != null) {
            contentVo.setFileUrl(contentFile.getFileUrls());
        }

    }

    /**
     * 设置匿名数据
     *
     * @param contentVos
     */
    private void setAnonymous(List<ContentVo> contentVos) {
        String userDefaultAvatar = ConfigExpander.getUserDefaultAvatar();
        for (ContentVo contentVo : contentVos) {
            Map<String, Object> params = contentVo.getParams();
            if (contentVo.getIsAnonymous() == 1) {
                contentVo.setUserId(null);

                params.put("avatar", CampusConfigExpander.getCampusAnonymousImage());
                params.put("nickName", "匿名用户");
                params.put("userId", null);
                params.put("userName", null);

            }
            //设置头像
            if ((!params.containsKey("avatar")) || ObjectUtil.isEmpty(params.get("avatar"))) {
                params.put("avatar", userDefaultAvatar);
            }

        }

    }


}




