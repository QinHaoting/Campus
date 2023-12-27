package com.oddfar.campus.business.core.constant;

/**
 * 通用常量信息
 */
public class CampusConstant {


    /**
     * 绑定邮箱有效期（分钟）
     */
    public static final Integer BIND_MAIL_EXPIRATION = 10;

    /**
     * 重发验证码有效期（分钟）
     */
    public static final Integer REGISTER_REPEAT_EXPIRATION = 1;

    /**
     * 注册邮箱的key
     */
    public static final String BIND_MAIL_KEY = "bind_mails:";

    /**
     * 检测重复发送邮箱验证码的key
     */
    public static final String MAIL_CHECK_KEY = "mail_check_codes:";

    /**
     * 重置密码key
     */
    public static final String RESET_PWD_KEY = "reset_pwd:";

    /**
     * 重置密码code有效期（分钟）
     */
    public static final Integer RESET_PWD_EXPIRATION = 10;


    /**
     * 用户关系-关注
     */
    public static final Integer RELATION_FOLLOW = 1;

    /**
     * 用户关系-特别关注
     */
    public static final Integer RELATION_SPECIAL_FOLLOW = 2;

    /**
     * 用户关系-拉黑
     */
    public static final Integer RELATION_BLOCK = -1;

    /**
     * 文章-全部可读
     */
    public static final Integer CONTENT_READ_ALL = 0;
    /**
     * 文章-关注可读
     */
    public static final Integer CONTENT_READ_FOLLOW = 1;


    // 消息类型
    public static final Integer MESSAGE_TYPE_TEXT = 0; // 文字
    public static final Integer MESSAGE_TYPE_IMG = 1; // 图片
    public static final Integer MESSAGE_TYPE_VIDEO = 2; // 视频
}
