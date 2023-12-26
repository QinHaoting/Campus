package com.oddfar.campus.business.core.constant;

import java.util.HashMap;

public class MessageConstant {
    private static final HashMap<String, String> messageMap = init();

    public static final String RECORD_EXIST = "1";

    public static final String RECORD_NOT_EXIST = "-1";

    // 自己不能与自己建立关系
    public static final String RELATION_NO_LEGAL = "10001";
    // 成功关注
    public static final String RELATION_FOLLOW_SUCCESS = "10002";
    // 成功取消关注
    public static final String RELATION_UNFOLLOW_SUCCESS = "10003";
    // 成功特别关注
    public static final String RELATION_FOLLOW_SPECIAL_SUCCESS = "10004";
    // 成功取消特别关注
    public static final String RELATION_UNFOLLOW_SPECIAL_SUCCESS = "10005";
    // 成功拉黑
    public static final String RELATION_BLOCK_SUCCESS = "10006";
    // 成功取消拉黑
    public static final String RELATION_UNBLOCK_SUCCESS = "10007";


    private static HashMap<String, String> init() {
        HashMap<String, String> map = new HashMap<>();
        // SQL
        map.put(RECORD_EXIST, "记录已存在");
        map.put(RECORD_NOT_EXIST, "记录不存在");

        // Relation
        map.put(RELATION_NO_LEGAL, "不能与自己建立关系");
//        map.put(RELATION_FOLLOW_SUCCESS, "成功关注");
//        map.put(RELATION_UNFOLLOW_SUCCESS, "成功取消关注");
//        map.put(RELATION_FOLLOW_SPECIAL_SUCCESS, "成功特别关注");
//        map.put(RELATION_UNFOLLOW_SPECIAL_SUCCESS, "成功取消特别关注");
//        map.put(RELATION_BLOCK_SUCCESS, "成功拉黑");
//        map.put(RELATION_UNBLOCK_SUCCESS, "成功取消拉黑");
        return map;
    }

    public static String getMessage(String code) {
        return messageMap.get(code);
    }

}
