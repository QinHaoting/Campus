/*
 Navicat Premium Data Transfer

 Source Server         : myserver
 Source Server Type    : MySQL
 Source Server Version : 80025
 Source Host           : localhost:3306
 Source Schema         : campus_example

 Target Server Type    : MySQL
 Target Server Version : 80025
 File Encoding         : 65001

 Date: 27/12/2023 14:15:02
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for campus_category
-- ----------------------------
DROP TABLE IF EXISTS `campus_category`;
CREATE TABLE `campus_category`  (
  `category_id` bigint NOT NULL COMMENT '分类主键',
  `category_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '分类名',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父分类id',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `slug` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '缩略名',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `icon` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '分类图标\n',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`category_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_category
-- ----------------------------
INSERT INTO `campus_category` VALUES (1, '最新墙', 0, 0, 'newest', '最近的墙内容(菜单默认选择这个)', 'Y', 'system', '0', b'0', '2022-12-30 20:11:41', 1, '2023-01-01 22:23:49', 1);
INSERT INTO `campus_category` VALUES (123, '表白墙', 0, 2, 'friends', '', 'N', 'system', '0', b'0', '2021-10-15 10:32:00', NULL, '2023-04-07 19:30:12', 1);
INSERT INTO `campus_category` VALUES (1449212758636646402, '表白', 123, 1, 'debunk', '吐槽描述', 'N', 'system', '0', b'0', '2021-10-16 11:17:01', NULL, '2023-01-01 22:26:29', 1);
INSERT INTO `campus_category` VALUES (1465662542308495361, '分享墙', 0, 3, 'share', '', 'N', 'system', '0', b'0', '2021-11-30 20:42:35', NULL, '2022-12-26 17:57:48', 1);
INSERT INTO `campus_category` VALUES (1602336520042287105, '日常分享', 1465662542308495361, 2, 'daily_sharing', NULL, 'N', 'system', '0', b'0', '2022-12-13 00:16:11', 1, '2022-12-26 17:57:51', 1);
INSERT INTO `campus_category` VALUES (1644302032332709889, '交友', 123, 2, 'make_friends', NULL, 'N', 'system', '0', b'0', '2023-04-07 19:32:09', 1, '2023-04-07 19:32:08', 1);
INSERT INTO `campus_category` VALUES (1644302999660847105, '买卖墙', 0, 4, 'buy_and_sell', NULL, 'N', 'system', '0', b'0', '2023-04-07 19:35:59', 1, '2023-04-07 19:35:59', 1);
INSERT INTO `campus_category` VALUES (1644303286433800193, '求购', 1644302999660847105, 1, 'want_to_buy', NULL, 'N', 'system', '0', b'0', '2023-04-07 19:37:08', 1, '2023-04-07 19:37:07', 1);
INSERT INTO `campus_category` VALUES (1644303516352962562, '出售', 1644302999660847105, 2, 'sell', NULL, 'N', 'system', '0', b'0', '2023-04-07 19:38:03', 1, '2023-04-07 19:38:02', 1);
INSERT INTO `campus_category` VALUES (1644309509791080449, '综合墙', 0, 6, 'synthesize', NULL, 'N', 'system', '0', b'0', '2023-04-07 20:01:52', 1, '2023-04-07 20:01:51', NULL);
INSERT INTO `campus_category` VALUES (1644309673171804161, '实习兼职', 1644309509791080449, 1, 'Internship_part-time_job', NULL, 'N', 'system', '0', b'0', '2023-04-07 20:02:31', 1, '2023-04-07 20:02:30', 1);
INSERT INTO `campus_category` VALUES (1644309825320181762, '吐槽', 1644309509791080449, 2, 'roast', NULL, 'N', NULL, '0', b'0', '2023-04-07 20:03:07', 1, '2023-04-07 20:03:06', 1);

-- ----------------------------
-- Table structure for campus_chatroom
-- ----------------------------
DROP TABLE IF EXISTS `campus_chatroom`;
CREATE TABLE `campus_chatroom`  (
  `chatroom_id` bigint NOT NULL,
  `user_ids` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`chatroom_id`) USING BTREE,
  INDEX `chatroom_id`(`chatroom_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_chatroom
-- ----------------------------

-- ----------------------------
-- Table structure for campus_comment
-- ----------------------------
DROP TABLE IF EXISTS `campus_comment`;
CREATE TABLE `campus_comment`  (
  `comment_id` bigint NOT NULL COMMENT '评论主键',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '上级id',
  `one_level_id` bigint NULL DEFAULT -1 COMMENT '所属的一级评论id',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `to_user_id` bigint NULL DEFAULT -1 COMMENT '所回复目标评论的用户id',
  `content_id` bigint NULL DEFAULT NULL COMMENT '内容id',
  `co_content` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '评论内容',
  `ip` varchar(64) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时的ip',
  `address` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '评论时的地址',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`comment_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_comment
-- ----------------------------
INSERT INTO `campus_comment` VALUES (11, 0, -1, 1594285543804383234, -1, 1, '你好11', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:09:50', NULL);
INSERT INTO `campus_comment` VALUES (12, 0, -1, 1594285543804383234, -1, 1, '你好12', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:09:52', NULL);
INSERT INTO `campus_comment` VALUES (13, 0, -1, 1594285543804383234, -1, 1, '你好13', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:09:53', NULL);
INSERT INTO `campus_comment` VALUES (14, 0, -1, 1594285543804383234, -1, 1, '你好14', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:09:55', NULL);
INSERT INTO `campus_comment` VALUES (15, 0, -1, 1594285543804383234, -1, 1, '你好15', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:09:57', NULL);
INSERT INTO `campus_comment` VALUES (16, 0, -1, 1594285543804383234, -1, 1, '你好16', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:10:00', NULL);
INSERT INTO `campus_comment` VALUES (17, 0, -1, 1594285543804383234, -1, 1, '你好17', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:10:02', NULL);
INSERT INTO `campus_comment` VALUES (18, 0, -1, 1594285543804383234, -1, 1, '你好18', '127.0.0.1', '内网IP', b'0', '2023-01-06 15:27:22', NULL, '2023-01-14 20:10:04', NULL);
INSERT INTO `campus_comment` VALUES (1629730765613047809, 0, -1, 1594285543804383234, -1, 1629730419490693121, '世界', '127.0.0.1', '内网IP', b'0', '2023-02-26 14:31:08', 1594285543804383234, '2023-02-26 14:31:08', NULL);
INSERT INTO `campus_comment` VALUES (1629730802099298306, 1629730765613047809, 1629730765613047809, 1594285543804383234, -1, 1629730419490693121, 'hello world！', '127.0.0.1', '内网IP', b'0', '2023-02-26 14:31:17', 1594285543804383234, '2023-02-26 14:31:16', NULL);
INSERT INTO `campus_comment` VALUES (1635847411633246209, 1629730765613047809, 1629730765613047809, 1594285543804383234, -1, 1629730419490693121, '123', '127.0.0.1', '内网IP', b'0', '2023-03-15 11:36:30', 1594285543804383234, '2023-03-15 11:36:30', NULL);
INSERT INTO `campus_comment` VALUES (1636017759590830082, 0, -1, 1594285543804383234, -1, 1629730419490693121, '1', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:24', 1594285543804383234, '2023-03-15 22:53:24', NULL);
INSERT INTO `campus_comment` VALUES (1636017766272356353, 0, -1, 1594285543804383234, -1, 1629730419490693121, '2', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:26', 1594285543804383234, '2023-03-15 22:53:25', NULL);
INSERT INTO `campus_comment` VALUES (1636017772526063617, 0, -1, 1594285543804383234, -1, 1629730419490693121, '3', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:27', 1594285543804383234, '2023-03-15 22:53:27', NULL);
INSERT INTO `campus_comment` VALUES (1636017800254607362, 0, -1, 1594285543804383234, -1, 1629730419490693121, '4', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:34', 1594285543804383234, '2023-03-15 22:53:33', NULL);
INSERT INTO `campus_comment` VALUES (1636017809863757825, 0, -1, 1594285543804383234, -1, 1629730419490693121, '5', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:36', 1594285543804383234, '2023-03-15 22:53:36', NULL);
INSERT INTO `campus_comment` VALUES (1636017819649069057, 0, -1, 1594285543804383234, -1, 1629730419490693121, '6', '127.0.0.1', '内网IP', b'0', '2023-03-15 22:53:39', 1594285543804383234, '2023-03-15 22:53:38', NULL);
INSERT INTO `campus_comment` VALUES (1636022008630497281, 1636017819649069057, 1636017819649069057, 1594285543804383234, -1, 1629730419490693121, '7', '127.0.0.1', '内网IP', b'0', '2023-03-15 23:10:17', 1594285543804383234, '2023-03-15 23:10:17', NULL);
INSERT INTO `campus_comment` VALUES (1643078885163933697, 0, -1, 1594285543804383234, -1, 1635923549986508801, '1', '127.0.0.1', '内网IP', b'0', '2023-04-04 10:31:48', 1594285543804383234, '2023-04-04 10:31:47', NULL);
INSERT INTO `campus_comment` VALUES (1643640726665396227, 1643078885163933697, 1643078885163933697, 1594285543804383234, -1, 1635923549986508801, '2', '127.0.0.1', '内网IP', b'0', '2023-04-05 23:44:21', 1594285543804383234, '2023-04-05 23:44:21', NULL);
INSERT INTO `campus_comment` VALUES (1643794139778953219, 1643640726665396227, 1643078885163933697, 1594285543804383234, 1594285543804383234, 1635923549986508801, '3', '127.0.0.1', '内网IP', b'0', '2023-04-06 09:53:58', 1594285543804383234, '2023-04-06 09:53:57', NULL);
INSERT INTO `campus_comment` VALUES (1643794182640545794, 1643794139778953219, 1643078885163933697, 1594285543804383234, 1594285543804383234, 1635923549986508801, '4', '127.0.0.1', '内网IP', b'0', '2023-04-06 09:54:08', 1594285543804383234, '2023-04-06 09:54:08', NULL);
INSERT INTO `campus_comment` VALUES (1643804468588101634, 1643794182640545794, 1643078885163933697, 1594285543804383234, 1594285543804383234, 1635923549986508801, '5', '127.0.0.1', '内网IP', b'0', '2023-04-06 10:35:00', 1594285543804383234, '2023-04-06 10:35:00', NULL);
INSERT INTO `campus_comment` VALUES (1738643039188393987, 0, -1, 1594285543804383234, -1, 1635923493036249089, '11', '127.0.0.1', '内网IP', b'0', '2023-12-24 03:29:38', 1594285543804383234, '2023-12-24 03:29:37', NULL);

-- ----------------------------
-- Table structure for campus_content
-- ----------------------------
DROP TABLE IF EXISTS `campus_content`;
CREATE TABLE `campus_content`  (
  `content_id` bigint NOT NULL COMMENT '内容主键',
  `user_id` bigint NULL DEFAULT NULL COMMENT '用户id',
  `category_id` bigint NULL DEFAULT NULL COMMENT '类别id',
  `content` varchar(700) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发表的内容',
  `status` tinyint(1) NULL DEFAULT NULL COMMENT '状态：0审核,1正常,2下架,3拒绝（审核不通过）',
  `type` tinyint(1) NULL DEFAULT NULL COMMENT '类型：0文字,1图片,2视频',
  `file_count` int NULL DEFAULT NULL COMMENT '文件数量',
  `love_count` int NULL DEFAULT 0 COMMENT '点赞数量',
  `is_anonymous` tinyint(1) NULL DEFAULT 0 COMMENT '0不匿名，1匿名',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  `read_level` int NULL DEFAULT NULL COMMENT '可读等级',
  PRIMARY KEY (`content_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_content
-- ----------------------------
INSERT INTO `campus_content` VALUES (1, 1, 1449212758636646402, '欢迎使用校园信息墙项目\n开源地址：https://github.com/oddfar/campus\n欢迎大家 Star 和 Fork 支持~', 1, 0, 0, 1, 1, NULL, b'0', '2022-03-05 10:55:04', 1, '2023-12-26 15:59:50', 1, 1);
INSERT INTO `campus_content` VALUES (2, 1, 1602336520042287105, 'hello world\nhello world\nhello world\nhello world', 1, 0, 1, 1, 0, NULL, b'0', '2022-12-13 00:01:47', 1, '2023-12-26 16:24:47', 1, 0);
INSERT INTO `campus_content` VALUES (3, 1, 1602336520042287105, '你好，welcome\n开源地址：https://github.com/oddfar/campus\n欢迎大家 Star 和 Fork 支持~', 1, 0, 1, 0, 0, NULL, b'0', '2022-12-13 00:01:47', 1, '2023-12-26 16:25:45', 1, 1);
INSERT INTO `campus_content` VALUES (1629730419490693121, 1594285543804383234, 1449212758636646402, '你好\n你好\n你好\n你好\n你好\n你好\n你好', 1, 0, 0, 1, 0, NULL, b'0', '2023-02-26 14:29:46', 1594285543804383234, '2023-12-26 15:59:50', 1, 1);
INSERT INTO `campus_content` VALUES (1635923493036249089, 1594285543804383234, 1449212758636646402, '1232131', 1, 0, 0, 1, 0, NULL, b'0', '2023-03-15 16:38:49', 1594285543804383234, '2023-12-26 15:59:50', 1737940657664077830, 1);
INSERT INTO `campus_content` VALUES (1635923549986508801, 1594285543804383234, 1602336520042287105, '1111111', 1, 0, 0, 2, 0, NULL, b'0', '2023-03-15 16:39:03', 1594285543804383234, '2023-12-26 15:59:50', 1594285543804383234, 1);
INSERT INTO `campus_content` VALUES (1644584732895301634, 1594285543804383234, 1449212758636646402, '123', 1, 0, 0, 0, 0, NULL, b'1', '2023-04-08 14:15:30', 1594285543804383234, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1644638851867873282, 1594285543804383234, 1449212758636646402, '1', 0, 0, 1, 0, 0, NULL, b'0', '2023-04-08 17:50:33', 1594285543804383234, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1644645933589467137, 1594285543804383234, 1449212758636646402, '2', 0, 0, 2, 0, 0, NULL, b'0', '2023-04-08 18:18:41', 1594285543804383234, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1644708092667236354, 1594285543804383234, 1449212758636646402, '3', 0, 0, 3, 0, 0, NULL, b'0', '2023-04-08 22:25:41', 1594285543804383234, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1738636158411726849, 1, 1449212758636646402, '123123', 0, 0, 0, 0, 0, NULL, b'0', '2023-12-24 03:02:17', 1, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1738636621169287170, 1594285543804383234, 1602336520042287105, '12312312', 0, 0, 0, 0, 0, NULL, b'0', '2023-12-24 03:04:07', 1594285543804383234, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1738642657259266050, 1, 1602336520042287105, '121', 0, 0, 0, 0, 0, NULL, b'0', '2023-12-24 03:28:07', 1, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1739215495967936513, 1737940657664077830, 1644303516352962562, '123123', 0, 0, 0, 0, 0, NULL, b'0', '2023-12-25 17:24:22', 1737940657664077830, '2023-12-26 15:59:50', NULL, 1);
INSERT INTO `campus_content` VALUES (1739636007684706306, 1594285543804383234, 1644302032332709889, '大家好，这是我的新账号，希望能和大家做个朋友', 0, 0, 0, 0, 0, NULL, b'0', '2023-12-26 21:15:20', 1594285543804383234, '2023-12-26 21:58:30', 1, 0);

-- ----------------------------
-- Table structure for campus_content_love
-- ----------------------------
DROP TABLE IF EXISTS `campus_content_love`;
CREATE TABLE `campus_content_love`  (
  `user_id` bigint NOT NULL COMMENT '用户id',
  `content_id` bigint NOT NULL COMMENT '文章id',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`user_id`, `content_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_content_love
-- ----------------------------
INSERT INTO `campus_content_love` VALUES (1594285543804383234, 2, '2023-02-26 14:33:17');
INSERT INTO `campus_content_love` VALUES (1594285543804383234, 1629730419490693121, '2023-03-29 16:29:37');
INSERT INTO `campus_content_love` VALUES (1594285543804383234, 1635923549986508801, '2023-03-29 16:28:22');
INSERT INTO `campus_content_love` VALUES (1737940657664077830, 1, '2023-12-25 17:55:35');
INSERT INTO `campus_content_love` VALUES (1737940657664077830, 1635923493036249089, '2023-12-25 17:28:34');
INSERT INTO `campus_content_love` VALUES (1737940657664077830, 1635923549986508801, '2023-12-25 17:28:31');

-- ----------------------------
-- Table structure for campus_content_tag
-- ----------------------------
DROP TABLE IF EXISTS `campus_content_tag`;
CREATE TABLE `campus_content_tag`  (
  `content_id` bigint NOT NULL COMMENT '内容id',
  `tag_id` bigint NOT NULL COMMENT '标签id',
  PRIMARY KEY (`content_id`, `tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_content_tag
-- ----------------------------
INSERT INTO `campus_content_tag` VALUES (1, 1);
INSERT INTO `campus_content_tag` VALUES (1, 2);
INSERT INTO `campus_content_tag` VALUES (1, 3);
INSERT INTO `campus_content_tag` VALUES (2, 1);
INSERT INTO `campus_content_tag` VALUES (2, 2);

-- ----------------------------
-- Table structure for campus_file
-- ----------------------------
DROP TABLE IF EXISTS `campus_file`;
CREATE TABLE `campus_file`  (
  `file_id` bigint NOT NULL,
  `content_id` bigint NULL DEFAULT NULL COMMENT '文章id',
  `user_id` bigint NOT NULL COMMENT '用户id',
  `url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '储存url',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_file
-- ----------------------------
INSERT INTO `campus_file` VALUES (1644638832884453378, 1644638851867873282, 1594285543804383234, '/profile/CampusFile/2023/04/08/cwrrlPaIykXB832c218354cd9fa1a558ca6c023c8abd_20230408175028A003.png', '2023-04-08 17:50:32');
INSERT INTO `campus_file` VALUES (1644645888458756098, 1644645933589467137, 1594285543804383234, '/profile/CampusFile/2023/04/08/sfVlFJlCHq7Le04f4dbfb2306d5783d9ab6247d74fbb_20230408181830A004.jpg', '2023-04-08 18:18:41');
INSERT INTO `campus_file` VALUES (1644645910021672962, 1644645933589467137, 1594285543804383234, '/profile/CampusFile/2023/04/08/c7Pex0d3zp3L832c218354cd9fa1a558ca6c023c8abd_20230408181835A005.png', '2023-04-08 18:18:41');
INSERT INTO `campus_file` VALUES (1644708042641772545, 1644708092667236354, 1594285543804383234, '/profile/CampusFile/2023/04/08/0Voe3dAhPjRSe04f4dbfb2306d5783d9ab6247d74fbb_20230408222529A006.jpg', '2023-04-08 22:25:41');
INSERT INTO `campus_file` VALUES (1644708059884556290, 1644708092667236354, 1594285543804383234, '/profile/CampusFile/2023/04/08/stJD3vUJf6D9fe8240824c1a162268048e10b12f239c_20230408222533A007.jpg', '2023-04-08 22:25:41');
INSERT INTO `campus_file` VALUES (1644708077852954625, 1644708092667236354, 1594285543804383234, '/profile/CampusFile/2023/04/08/nSdnns1irWyc832c218354cd9fa1a558ca6c023c8abd_20230408222537A008.png', '2023-04-08 22:25:41');

-- ----------------------------
-- Table structure for campus_message
-- ----------------------------
DROP TABLE IF EXISTS `campus_message`;
CREATE TABLE `campus_message`  (
  `message_id` bigint NOT NULL AUTO_INCREMENT COMMENT '消息主键ID',
  `from` bigint NULL DEFAULT NULL COMMENT '消息发送者ID',
  `to` bigint NULL DEFAULT NULL COMMENT '消息接送者ID-聊天室ID',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '消息创建时间',
  `type` tinyint NULL DEFAULT NULL COMMENT '消息类型：0文字,1图片,2视频',
  PRIMARY KEY (`message_id`) USING BTREE,
  INDEX `from`(`from`) USING BTREE,
  INDEX `message_id`(`message_id`) USING BTREE,
  INDEX `to`(`to`) USING BTREE,
  CONSTRAINT `campus_message_ibfk_1` FOREIGN KEY (`from`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `campus_message_ibfk_2` FOREIGN KEY (`to`) REFERENCES `campus_chatroom` (`chatroom_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of campus_message
-- ----------------------------

-- ----------------------------
-- Table structure for campus_relation
-- ----------------------------
DROP TABLE IF EXISTS `campus_relation`;
CREATE TABLE `campus_relation`  (
  `relation_id` bigint NOT NULL AUTO_INCREMENT COMMENT '关系记录ID',
  `sender_id` bigint NOT NULL COMMENT '关系发起者ID',
  `receiver_id` bigint NOT NULL COMMENT '关系接受者ID',
  `type` int NOT NULL COMMENT '关系类型',
  `create_time` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  PRIMARY KEY (`relation_id`) USING BTREE,
  INDEX `relation_id`(`relation_id`) USING BTREE,
  INDEX `sender_id`(`sender_id`) USING BTREE,
  INDEX `receiver_id`(`receiver_id`) USING BTREE,
  INDEX `sender_id_2`(`sender_id`, `receiver_id`) USING BTREE,
  CONSTRAINT `campus_relation_ibfk_1` FOREIGN KEY (`sender_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `campus_relation_ibfk_2` FOREIGN KEY (`receiver_id`) REFERENCES `sys_user` (`user_id`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1739160897580417037 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_relation
-- ----------------------------
INSERT INTO `campus_relation` VALUES (1, 1737940657664077830, 1594285543804383234, -1, '2023-12-25 15:49:32');
INSERT INTO `campus_relation` VALUES (2, 1594285543804383234, 1737940657664077826, 2, '2023-12-24 01:36:35');
INSERT INTO `campus_relation` VALUES (3, 1594285543804383234, 1737940657664077827, 1, '2023-12-24 01:36:35');
INSERT INTO `campus_relation` VALUES (4, 1594285543804383234, 1737940657664077828, 2, '2023-12-24 01:36:35');
INSERT INTO `campus_relation` VALUES (5, 1594285543804383234, 1737940657664077829, 1, '2023-12-24 01:36:35');
INSERT INTO `campus_relation` VALUES (6, 1594285543804383234, 1737940657664077830, -1, '2023-12-24 01:36:35');
INSERT INTO `campus_relation` VALUES (7, 1594285543804383234, 1, 1, '2023-12-26 00:51:46');
INSERT INTO `campus_relation` VALUES (1739160897580417034, 1594285543804383234, 2, 1, '2023-12-26 15:00:05');
INSERT INTO `campus_relation` VALUES (1739160897580417037, 1, 1594285543804383234, -1, '2023-12-26 17:22:08');

-- ----------------------------
-- Table structure for campus_tag
-- ----------------------------
DROP TABLE IF EXISTS `campus_tag`;
CREATE TABLE `campus_tag`  (
  `tag_id` bigint NOT NULL COMMENT '标签主键',
  `tag_name` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL COMMENT '标签名',
  `description` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '描述',
  `status` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`tag_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of campus_tag
-- ----------------------------
INSERT INTO `campus_tag` VALUES (1, '测试标签', '测试', '0', b'0', '2022-11-29 20:03:08', 1, '2022-12-01 18:16:16', NULL);
INSERT INTO `campus_tag` VALUES (2, '梅西', '利昂内尔·梅西（Lionel Messi）\n全名利昂内尔·安德烈斯·梅西·库西蒂尼（Lionel Andrés Messi Cuccitini）\n昵称莱奥·梅西（Leo Messi）', '0', b'0', '2022-11-29 20:03:28', 1, '2023-01-16 20:38:34', 1);
INSERT INTO `campus_tag` VALUES (3, '蔡徐坤', '中国内地男歌手、演员、原创音乐制作人、MV导演', '0', b'0', '2023-01-16 20:12:20', 1, '2023-01-16 20:13:54', 1);

-- ----------------------------
-- Table structure for social_user
-- ----------------------------
DROP TABLE IF EXISTS `social_user`;
CREATE TABLE `social_user`  (
  `social_user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '社会化用户表id\n',
  `uuid` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方系统的唯一ID',
  `source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '第三方用户来源',
  PRIMARY KEY (`social_user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1638895499511939073 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '社会化用户表\n' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of social_user
-- ----------------------------
INSERT INTO `social_user` VALUES (1638895499511939073, 'okhHa4h4tIoygJFw3MV196_iTTck', 'WXAMP');

-- ----------------------------
-- Table structure for social_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `social_user_auth`;
CREATE TABLE `social_user_auth`  (
  `user_id` bigint NULL DEFAULT NULL,
  `social_user_id` bigint NULL DEFAULT NULL
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of social_user_auth
-- ----------------------------
INSERT INTO `social_user_auth` VALUES (1594285543804383234, 1638895499511939073);

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` bigint NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `group_code` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '所属分类的编码',
  `remark` varchar(500) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1637978359153885186 CHARACTER SET = utf8 COLLATE = utf8_general_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, 'Mac本地文件路径', 'sys.local.profile.mac', '~/uploadPath', 'Y', 'file_config', NULL, b'0', '2022-11-10 14:06:44', 1, '2022-11-10 14:07:49', NULL);
INSERT INTO `sys_config` VALUES (2, 'Linux本地文件路径', 'sys.local.profile.linux', '/data/uploadPath', 'Y', 'file_config', NULL, b'0', '2022-01-14 10:59:39', NULL, '2022-01-16 14:11:53', 1);
INSERT INTO `sys_config` VALUES (3, 'Windows本地文件路径', 'sys.local.profile.win', 'D:\\uploadPath', 'Y', 'file_config', NULL, b'0', '2022-01-14 11:00:39', NULL, '2022-01-16 14:11:53', 1);
INSERT INTO `sys_config` VALUES (4, '默认存储文件的bucket名称', 'sys.file.default.bucket', 'defaultBucket', 'Y', 'file_config', NULL, b'0', '2022-01-14 11:03:10', NULL, '2022-01-16 14:11:54', NULL);
INSERT INTO `sys_config` VALUES (5, '文件默认部署的环境地址', 'sys.server.deploy.host', 'http://localhost:8160', 'Y', 'file_config', NULL, b'0', '2022-01-16 14:11:45', NULL, '2022-01-16 14:18:55', NULL);
INSERT INTO `sys_config` VALUES (6, '文件访问是否用nginx映射', 'sys.file.visit.nginx', 'false', 'Y', 'file_config', 'true真，false假', b'0', '2022-01-16 14:40:00', NULL, '2022-01-16 14:40:20', NULL);
INSERT INTO `sys_config` VALUES (7, '信息墙删除且对应文件也删除', 'sys.file.is.delete', 'false', 'Y', 'file_config', 'true墙和文件都删除，false文件转移到别的目录', b'0', '2022-01-17 14:29:11', NULL, '2022-01-18 15:02:14', NULL);
INSERT INTO `sys_config` VALUES (8, '文件默认转移的bucket名称', 'sys.file.move.default.bucket', 'moveBucket', 'Y', 'file_config', NULL, b'0', '2022-01-17 14:31:05', NULL, '2022-01-18 15:09:48', NULL);
INSERT INTO `sys_config` VALUES (101, '阿里云邮件服务accessKeyId', 'sys.aliyun.mail.accessKeyId', '', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:04:08', NULL, '2022-01-19 10:49:30', NULL);
INSERT INTO `sys_config` VALUES (102, '阿里云邮件服务accessKeySecret', 'sys.aliyun.mail.accessKeySecret', '', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:07:28', NULL, '2022-01-19 10:49:31', NULL);
INSERT INTO `sys_config` VALUES (113, 'smtp服务器地址', 'sys.email.smtp.host', 'smtp.qq.com', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:33:50', NULL, '2022-01-24 11:28:13', NULL);
INSERT INTO `sys_config` VALUES (114, 'smtp服务端口', 'sys.email.smtp.port', '465', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:35:29', NULL, '2022-01-24 11:28:14', NULL);
INSERT INTO `sys_config` VALUES (115, '邮箱的发送方邮箱', 'sys.email.send.account', '3066693006@qq.com', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:38:17', NULL, '2022-01-24 11:28:15', NULL);
INSERT INTO `sys_config` VALUES (116, '邮箱的密码或者授权码', 'sys.email.password', 'qiwoefvuklkkddej', 'Y', 'mail_config', NULL, b'0', '2022-01-19 10:07:31', NULL, '2022-01-19 12:02:57', 1);
INSERT INTO `sys_config` VALUES (117, '邮箱发送时的用户名', 'sys.email.name', '致远', 'Y', 'mail_config', NULL, b'0', '2022-01-19 11:10:47', NULL, '2022-01-24 11:28:19', NULL);
INSERT INTO `sys_config` VALUES (202, '用户默认头像', 'sys.user.default.avatar', 'https://img0.baidu.com/it/u=1183896628,1403534286&fm=253&fmt=auto&app=138&f=PNG', 'Y', 'sys_config', NULL, b'0', '2022-02-08 11:35:31', NULL, '2022-02-08 11:40:15', 1);
INSERT INTO `sys_config` VALUES (206, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'sys_config', '初始化密码 123456', b'0', '2022-11-09 01:41:52', 1, '2022-11-09 15:42:09', NULL);
INSERT INTO `sys_config` VALUES (300, '验证码类型', 'sys.login.captchaType', 'math', 'Y', 'sys_config', 'math 数组计算 char 字符验证', b'0', '2022-11-10 09:32:40', 1, '2022-11-30 12:14:30', NULL);
INSERT INTO `sys_config` VALUES (301, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'true', 'Y', 'sys_config', '是否开启验证码功能（true开启，false关闭）', b'0', '2023-02-01 21:48:05', 1, '2023-02-01 21:48:34', NULL);
INSERT INTO `sys_config` VALUES (302, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'sys_config', '是否开启注册用户功能（true开启，false关闭）', b'0', '2023-02-01 21:47:39', 1, '2023-02-01 21:48:31', NULL);
INSERT INTO `sys_config` VALUES (1621419076555640833, '绑定邮箱模板', 'campus.mail.bindTemplate', '<h3>您好，#{[userName]}</h3><br />请在#{[expiration]}分内点击以下链接完成邮箱验证<br /><a href=\"#{[url]}\">#{[url]}</a>', 'Y', 'campus_config', '#{[userName]}用户，#{[url]}邮箱验证的链接，#{[expiration]}，有效期', b'0', '2023-02-03 16:03:27', 1, '2023-02-03 16:03:27', 1);
INSERT INTO `sys_config` VALUES (1621419076555640834, '用户匿名头像', 'campus.user.anonymous.image', 'https://gcore.jsdelivr.net/gh/oddfar/static/campus/image/anonymous.jpeg', 'Y', 'campus_config', NULL, b'0', '2022-02-08 11:36:36', NULL, '2023-02-21 08:33:07', 1);
INSERT INTO `sys_config` VALUES (1637978152848654338, '微信小程序APPID', 'campus.wxmp.appid', 'xxxxxx', 'Y', 'campus_config', NULL, b'0', '2023-03-21 08:43:18', 1, '2023-04-08 23:46:37', 1);
INSERT INTO `sys_config` VALUES (1637978359153885186, '微信小程序SECRET', 'campus.wxmp.secret', 'xxxxxxxx', 'Y', 'campus_config', NULL, b'0', '2023-03-21 08:44:08', 1, '2023-04-08 23:46:41', 1);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1621418087714918401 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', NULL, 'default', 'Y', '0', '性别男', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', NULL, 'default', 'N', '0', '性别女', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (3, 1, '是', 'Y', 'sys_yes_no', NULL, 'success', 'N', '0', NULL, '2022-11-06 06:37:31', 1, '2022-11-06 06:39:34', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (4, 2, '否', 'N', 'sys_yes_no', NULL, 'danger', 'N', '0', NULL, '2022-11-06 06:37:42', 1, '2022-11-06 06:39:34', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', NULL, 'primary', 'Y', '0', '正常状态', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', NULL, 'danger', 'N', '0', '停用状态', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (41, 1, '显示', '0', 'sys_show_hide', NULL, 'primary', 'N', '0', '显示菜单', '2022-12-26 21:49:47', 1, '2022-12-26 21:49:47', NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (42, 2, '隐藏', '1', 'sys_show_hide', NULL, 'danger', 'N', '0', '隐藏菜单', '2022-12-26 21:50:10', 1, '2022-12-26 21:50:10', NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (101, 1, '系统配置', 'sys_config', 'sys_config_group', NULL, 'primary', 'N', '0', '配置群组的系统配置', '2022-11-06 19:27:23', NULL, '2022-11-06 06:07:20', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (102, 2, '邮件配置', 'mail_config', 'sys_config_group', NULL, 'primary', 'N', '0', NULL, '2022-11-06 05:38:04', 1, '2022-11-06 06:07:20', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (103, 3, '文件配置', 'file_config', 'sys_config_group', NULL, 'primary', 'N', '0', NULL, '2022-11-06 06:32:45', 1, '2022-11-06 20:32:44', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1597931830248570882, 1, '审核', '0', 'campus_content_status', NULL, 'warning', 'N', '0', NULL, '2022-11-30 20:33:31', 1, '2022-11-30 20:33:31', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1597931939476635650, 2, '正常', '1', 'campus_content_status', NULL, 'success', 'N', '0', NULL, '2022-11-30 20:33:57', 1, '2022-11-30 20:33:57', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1597932004085694466, 3, '下架', '2', 'campus_content_status', NULL, 'danger', 'N', '0', NULL, '2022-11-30 20:34:13', 1, '2022-11-30 20:34:12', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1597932393732341761, 1, '不匿', '0', 'campus_anonymous', NULL, 'primary', 'N', '0', NULL, '2022-11-30 20:35:45', 1, '2022-11-30 20:35:45', NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (1597932469577940994, 2, '匿名', '1', 'campus_anonymous', NULL, 'primary', 'N', '0', NULL, '2022-11-30 20:36:04', 1, '2022-11-30 20:36:03', NULL, b'0');
INSERT INTO `sys_dict_data` VALUES (1599392185411743745, 0, '文字', '0', 'campus_content_type', NULL, 'primary', 'N', '0', '', '2022-12-04 21:16:27', 1, '2022-12-04 21:16:26', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1599392255200768001, 2, '图片', '1', 'campus_content_type', NULL, 'success', 'N', '0', NULL, '2022-12-04 21:16:44', 1, '2022-12-04 21:16:43', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1599392552258154497, 3, '视频', '2', 'campus_content_type', NULL, 'info', 'N', '0', NULL, '2022-12-04 21:17:54', 1, '2022-12-04 21:17:54', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1609558539133521922, 4, '拒绝', '3', 'campus_content_status', NULL, 'danger', 'N', '0', '审核不通过', '2023-01-01 22:33:55', 1, '2023-01-01 22:33:54', 1, b'0');
INSERT INTO `sys_dict_data` VALUES (1621418087714918401, 10, 'campus配置', 'campus_config', 'sys_config_group', NULL, 'primary', 'N', '0', NULL, '2023-02-03 15:59:31', 1, '2023-02-03 15:59:31', NULL, b'0');

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新者',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1599392072043900930 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', '用户性别列表', '2023-03-09 17:31:52', NULL, '2022-11-06 01:10:21', 1, b'0');
INSERT INTO `sys_dict_type` VALUES (2, '系统是否', 'sys_yes_no', '0', '系统是否列表', '2022-11-06 06:37:05', 1, '2022-11-06 20:37:04', 1, b'0');
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', '系统开关列表', '2023-03-09 17:31:55', NULL, NULL, NULL, b'0');
INSERT INTO `sys_dict_type` VALUES (4, '菜单状态', 'sys_show_hide', '0', '菜单状态列表', '2022-12-26 21:49:15', 1, '2022-12-26 21:49:15', NULL, b'0');
INSERT INTO `sys_dict_type` VALUES (101, '配置群组', 'sys_config_group', '0', '配置群组', '2022-11-06 05:32:37', 1, '2022-11-06 19:32:37', 1, b'0');
INSERT INTO `sys_dict_type` VALUES (1597931685624774657, '校园墙内容状态', 'campus_content_status', '0', '校园墙内容状态', '2022-11-30 20:32:57', 1, '2022-11-30 20:32:56', NULL, b'0');
INSERT INTO `sys_dict_type` VALUES (1597932303005351938, '是否匿名', 'campus_anonymous', '0', '校园信息墙是否匿名', '2022-11-30 20:35:24', 1, '2022-11-30 20:35:23', NULL, b'0');
INSERT INTO `sys_dict_type` VALUES (1599392072043900930, '校园内类型', 'campus_content_type', '0', '0文字,1图片,2视频', '2022-12-04 21:16:00', 1, '2022-12-04 21:15:59', NULL, b'0');

-- ----------------------------
-- Table structure for sys_log_login
-- ----------------------------
DROP TABLE IF EXISTS `sys_log_login`;
CREATE TABLE `sys_log_login`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NULL DEFAULT NULL,
  `user_name` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `status` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `ipaddr` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_location` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `browser` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `os` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `msg` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `login_time` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`info_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1739647556390363137 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_log_login
-- ----------------------------
INSERT INTO `sys_log_login` VALUES (1737943858488414209, 1737940657664077826, '123123', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:11:20');
INSERT INTO `sys_log_login` VALUES (1737944094602563585, 1737940657664077826, '123123', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:12:16');
INSERT INTO `sys_log_login` VALUES (1737945563183595521, 1737940657664077826, '123123', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:18:06');
INSERT INTO `sys_log_login` VALUES (1737945789734731777, 1737940657664077826, '123123', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-22 05:19:00');
INSERT INTO `sys_log_login` VALUES (1737945869443284993, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:19:19');
INSERT INTO `sys_log_login` VALUES (1737946034753388545, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-22 05:19:59');
INSERT INTO `sys_log_login` VALUES (1737946067485736961, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:20:07');
INSERT INTO `sys_log_login` VALUES (1737946147081043969, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-22 05:20:26');
INSERT INTO `sys_log_login` VALUES (1737946187828707329, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 05:20:35');
INSERT INTO `sys_log_login` VALUES (1738064870840414209, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 13:12:12');
INSERT INTO `sys_log_login` VALUES (1738064958828523521, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-22 13:12:33');
INSERT INTO `sys_log_login` VALUES (1738592339507011585, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 00:08:10');
INSERT INTO `sys_log_login` VALUES (1738597061634809857, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 00:26:56');
INSERT INTO `sys_log_login` VALUES (1738597101472309249, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 00:27:05');
INSERT INTO `sys_log_login` VALUES (1738598851990249474, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 00:34:03');
INSERT INTO `sys_log_login` VALUES (1738602125724164098, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 00:47:03');
INSERT INTO `sys_log_login` VALUES (1738602401193517057, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 00:48:09');
INSERT INTO `sys_log_login` VALUES (1738602432109731842, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 00:48:16');
INSERT INTO `sys_log_login` VALUES (1738604763383586818, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 00:57:32');
INSERT INTO `sys_log_login` VALUES (1738604797256785922, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 00:57:40');
INSERT INTO `sys_log_login` VALUES (1738606796937359361, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 01:05:37');
INSERT INTO `sys_log_login` VALUES (1738606831515201538, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 01:05:45');
INSERT INTO `sys_log_login` VALUES (1738606862259449857, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 01:05:52');
INSERT INTO `sys_log_login` VALUES (1738606895109238786, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 01:06:00');
INSERT INTO `sys_log_login` VALUES (1738606906618408961, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 01:06:03');
INSERT INTO `sys_log_login` VALUES (1738608750350561282, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 01:13:23');
INSERT INTO `sys_log_login` VALUES (1738609103632592897, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:14:47');
INSERT INTO `sys_log_login` VALUES (1738610637770584065, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:20:53');
INSERT INTO `sys_log_login` VALUES (1738611107641683970, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:22:45');
INSERT INTO `sys_log_login` VALUES (1738611238629797890, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:23:16');
INSERT INTO `sys_log_login` VALUES (1738611675139403778, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:25:00');
INSERT INTO `sys_log_login` VALUES (1738612479162286081, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:28:12');
INSERT INTO `sys_log_login` VALUES (1738614646115799041, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:36:48');
INSERT INTO `sys_log_login` VALUES (1738618222473019393, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:51:01');
INSERT INTO `sys_log_login` VALUES (1738618802864107521, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 01:53:19');
INSERT INTO `sys_log_login` VALUES (1738618991142219777, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 01:54:04');
INSERT INTO `sys_log_login` VALUES (1738619035958358017, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 01:54:15');
INSERT INTO `sys_log_login` VALUES (1738619184864538626, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 01:54:50');
INSERT INTO `sys_log_login` VALUES (1738619219291385858, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 01:54:59');
INSERT INTO `sys_log_login` VALUES (1738621635516567553, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:04:35');
INSERT INTO `sys_log_login` VALUES (1738622649418256385, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:08:36');
INSERT INTO `sys_log_login` VALUES (1738623111777476610, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:10:27');
INSERT INTO `sys_log_login` VALUES (1738623419190599681, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:11:40');
INSERT INTO `sys_log_login` VALUES (1738623445480497153, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:11:46');
INSERT INTO `sys_log_login` VALUES (1738624794876174338, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:17:08');
INSERT INTO `sys_log_login` VALUES (1738625265288302594, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:19:00');
INSERT INTO `sys_log_login` VALUES (1738625775655407617, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:21:02');
INSERT INTO `sys_log_login` VALUES (1738626068187140097, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:22:11');
INSERT INTO `sys_log_login` VALUES (1738626186730754049, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:22:40');
INSERT INTO `sys_log_login` VALUES (1738626255152435202, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:22:56');
INSERT INTO `sys_log_login` VALUES (1738626328200433666, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:23:13');
INSERT INTO `sys_log_login` VALUES (1738626958746861570, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:25:44');
INSERT INTO `sys_log_login` VALUES (1738627571157286913, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:28:10');
INSERT INTO `sys_log_login` VALUES (1738627740963684353, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:28:50');
INSERT INTO `sys_log_login` VALUES (1738628546760675329, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:32:02');
INSERT INTO `sys_log_login` VALUES (1738629435554664450, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:35:34');
INSERT INTO `sys_log_login` VALUES (1738630597943103489, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 02:40:11');
INSERT INTO `sys_log_login` VALUES (1738630934837989377, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:41:32');
INSERT INTO `sys_log_login` VALUES (1738631358731128834, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:43:13');
INSERT INTO `sys_log_login` VALUES (1738631385041997825, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:43:19');
INSERT INTO `sys_log_login` VALUES (1738631748524576770, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:44:46');
INSERT INTO `sys_log_login` VALUES (1738631774147579906, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:44:52');
INSERT INTO `sys_log_login` VALUES (1738631955836448770, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:45:35');
INSERT INTO `sys_log_login` VALUES (1738632241955090433, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:46:43');
INSERT INTO `sys_log_login` VALUES (1738632854298308609, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:49:09');
INSERT INTO `sys_log_login` VALUES (1738632878084206594, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:49:15');
INSERT INTO `sys_log_login` VALUES (1738633392293294082, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:51:18');
INSERT INTO `sys_log_login` VALUES (1738633413713604610, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:51:23');
INSERT INTO `sys_log_login` VALUES (1738634351367151618, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:55:06');
INSERT INTO `sys_log_login` VALUES (1738634376532975618, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:55:12');
INSERT INTO `sys_log_login` VALUES (1738634476097363970, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 02:55:36');
INSERT INTO `sys_log_login` VALUES (1738634832311214081, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 02:57:01');
INSERT INTO `sys_log_login` VALUES (1738635810515181569, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:00:54');
INSERT INTO `sys_log_login` VALUES (1738635855197102082, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:01:05');
INSERT INTO `sys_log_login` VALUES (1738636185876029441, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:02:24');
INSERT INTO `sys_log_login` VALUES (1738636213629739009, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:02:30');
INSERT INTO `sys_log_login` VALUES (1738638251788853249, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:10:36');
INSERT INTO `sys_log_login` VALUES (1738638277554462721, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:10:42');
INSERT INTO `sys_log_login` VALUES (1738639701281595394, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:16:22');
INSERT INTO `sys_log_login` VALUES (1738639827710500866, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:16:52');
INSERT INTO `sys_log_login` VALUES (1738639989325422594, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:17:30');
INSERT INTO `sys_log_login` VALUES (1738640016047333378, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:17:37');
INSERT INTO `sys_log_login` VALUES (1738640177087635457, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:18:15');
INSERT INTO `sys_log_login` VALUES (1738640206191910914, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:18:22');
INSERT INTO `sys_log_login` VALUES (1738640507091279873, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:19:34');
INSERT INTO `sys_log_login` VALUES (1738640550745595906, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:19:44');
INSERT INTO `sys_log_login` VALUES (1738640927918383105, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:21:14');
INSERT INTO `sys_log_login` VALUES (1738640950387269633, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:21:20');
INSERT INTO `sys_log_login` VALUES (1738641215630753794, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:22:23');
INSERT INTO `sys_log_login` VALUES (1738641254893633537, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:22:32');
INSERT INTO `sys_log_login` VALUES (1738641379464462337, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:23:02');
INSERT INTO `sys_log_login` VALUES (1738641406140235778, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:23:08');
INSERT INTO `sys_log_login` VALUES (1738641572968677377, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:23:48');
INSERT INTO `sys_log_login` VALUES (1738641682020581378, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:24:14');
INSERT INTO `sys_log_login` VALUES (1738642034447065090, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:25:38');
INSERT INTO `sys_log_login` VALUES (1738642057763201026, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:25:44');
INSERT INTO `sys_log_login` VALUES (1738642157352755202, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:26:07');
INSERT INTO `sys_log_login` VALUES (1738642184984829954, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:26:14');
INSERT INTO `sys_log_login` VALUES (1738642203779506177, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:26:18');
INSERT INTO `sys_log_login` VALUES (1738642222469324802, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:26:23');
INSERT INTO `sys_log_login` VALUES (1738642250063650818, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:26:29');
INSERT INTO `sys_log_login` VALUES (1738642546630303746, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:27:40');
INSERT INTO `sys_log_login` VALUES (1738642597104558082, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:27:52');
INSERT INTO `sys_log_login` VALUES (1738642628138213377, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:28:00');
INSERT INTO `sys_log_login` VALUES (1738642664632852482, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:28:08');
INSERT INTO `sys_log_login` VALUES (1738642684274778114, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:28:13');
INSERT INTO `sys_log_login` VALUES (1738642986507935746, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:29:25');
INSERT INTO `sys_log_login` VALUES (1738643010058952705, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:29:31');
INSERT INTO `sys_log_login` VALUES (1738643121321254913, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:29:57');
INSERT INTO `sys_log_login` VALUES (1738643146050871298, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:30:03');
INSERT INTO `sys_log_login` VALUES (1738643488952000513, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 03:31:25');
INSERT INTO `sys_log_login` VALUES (1738643508212244481, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 03:31:29');
INSERT INTO `sys_log_login` VALUES (1738643837037289473, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 03:32:48');
INSERT INTO `sys_log_login` VALUES (1738644833507418113, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 03:36:45');
INSERT INTO `sys_log_login` VALUES (1738648792972374018, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 03:52:29');
INSERT INTO `sys_log_login` VALUES (1738650620644540417, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 03:59:45');
INSERT INTO `sys_log_login` VALUES (1738651709825585153, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:04:05');
INSERT INTO `sys_log_login` VALUES (1738651847075794945, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:04:38');
INSERT INTO `sys_log_login` VALUES (1738652844632297474, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:08:35');
INSERT INTO `sys_log_login` VALUES (1738654074624425986, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:13:29');
INSERT INTO `sys_log_login` VALUES (1738654655107702785, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:15:47');
INSERT INTO `sys_log_login` VALUES (1738655111032750081, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:17:36');
INSERT INTO `sys_log_login` VALUES (1738655374669922305, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:18:39');
INSERT INTO `sys_log_login` VALUES (1738656432255291393, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:22:51');
INSERT INTO `sys_log_login` VALUES (1738656669397139458, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:23:47');
INSERT INTO `sys_log_login` VALUES (1738656973454831618, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:25:00');
INSERT INTO `sys_log_login` VALUES (1738657604160692226, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:27:30');
INSERT INTO `sys_log_login` VALUES (1738657803436249090, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:28:18');
INSERT INTO `sys_log_login` VALUES (1738658184702689281, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:29:49');
INSERT INTO `sys_log_login` VALUES (1738658823922917378, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:32:21');
INSERT INTO `sys_log_login` VALUES (1738659174893948929, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:33:45');
INSERT INTO `sys_log_login` VALUES (1738659752445431810, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-24 04:36:02');
INSERT INTO `sys_log_login` VALUES (1738660424251297794, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 04:38:43');
INSERT INTO `sys_log_login` VALUES (1738660457164001281, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 04:38:50');
INSERT INTO `sys_log_login` VALUES (1738666509674618881, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 05:02:53');
INSERT INTO `sys_log_login` VALUES (1738666973342461953, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-24 05:04:44');
INSERT INTO `sys_log_login` VALUES (1738667006427131906, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 05:04:52');
INSERT INTO `sys_log_login` VALUES (1738834744718090242, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 16:11:24');
INSERT INTO `sys_log_login` VALUES (1738841891753385985, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-24 16:39:48');
INSERT INTO `sys_log_login` VALUES (1739124884090781698, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 11:24:18');
INSERT INTO `sys_log_login` VALUES (1739126636127059970, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 11:31:16');
INSERT INTO `sys_log_login` VALUES (1739155713798111233, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 13:26:49');
INSERT INTO `sys_log_login` VALUES (1739158785186316290, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 13:39:01');
INSERT INTO `sys_log_login` VALUES (1739161422732435458, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 13:49:30');
INSERT INTO `sys_log_login` VALUES (1739163702177239041, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 13:58:33');
INSERT INTO `sys_log_login` VALUES (1739164522872508418, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 14:01:49');
INSERT INTO `sys_log_login` VALUES (1739170180275585026, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 14:24:18');
INSERT INTO `sys_log_login` VALUES (1739174794056159234, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 14:42:38');
INSERT INTO `sys_log_login` VALUES (1739202784307666946, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 16:33:51');
INSERT INTO `sys_log_login` VALUES (1739202798945787906, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 16:33:55');
INSERT INTO `sys_log_login` VALUES (1739202951748476929, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 16:34:31');
INSERT INTO `sys_log_login` VALUES (1739215102257008642, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 17:22:48');
INSERT INTO `sys_log_login` VALUES (1739215407430373378, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 17:24:01');
INSERT INTO `sys_log_login` VALUES (1739215447251095553, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 17:24:10');
INSERT INTO `sys_log_login` VALUES (1739220365370392577, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 17:43:43');
INSERT INTO `sys_log_login` VALUES (1739222615413116929, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 17:52:39');
INSERT INTO `sys_log_login` VALUES (1739222651542851585, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 17:52:48');
INSERT INTO `sys_log_login` VALUES (1739237725640802306, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 18:52:42');
INSERT INTO `sys_log_login` VALUES (1739237759274926081, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 18:52:50');
INSERT INTO `sys_log_login` VALUES (1739238440832577538, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 18:55:32');
INSERT INTO `sys_log_login` VALUES (1739240061649948673, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 19:01:59');
INSERT INTO `sys_log_login` VALUES (1739246116853510145, 1737940657664077830, 'test4', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 19:26:03');
INSERT INTO `sys_log_login` VALUES (1739246152878387202, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 19:26:11');
INSERT INTO `sys_log_login` VALUES (1739246182544699394, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 19:26:18');
INSERT INTO `sys_log_login` VALUES (1739246340678348802, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 19:26:56');
INSERT INTO `sys_log_login` VALUES (1739250073139105793, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:41:46');
INSERT INTO `sys_log_login` VALUES (1739251539589419009, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:47:35');
INSERT INTO `sys_log_login` VALUES (1739252008151896066, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:49:27');
INSERT INTO `sys_log_login` VALUES (1739253862483054594, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:56:49');
INSERT INTO `sys_log_login` VALUES (1739254128452259841, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:57:53');
INSERT INTO `sys_log_login` VALUES (1739254388817874945, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:58:55');
INSERT INTO `sys_log_login` VALUES (1739254402138984449, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:58:58');
INSERT INTO `sys_log_login` VALUES (1739254456182591490, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:11');
INSERT INTO `sys_log_login` VALUES (1739254498016579585, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:21');
INSERT INTO `sys_log_login` VALUES (1739254516647677953, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:25');
INSERT INTO `sys_log_login` VALUES (1739254541268242433, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:31');
INSERT INTO `sys_log_login` VALUES (1739254585132273665, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:42');
INSERT INTO `sys_log_login` VALUES (1739254636571217922, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 19:59:54');
INSERT INTO `sys_log_login` VALUES (1739254806444724226, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 20:00:34');
INSERT INTO `sys_log_login` VALUES (1739256361726201858, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 20:06:45');
INSERT INTO `sys_log_login` VALUES (1739256431053852673, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 20:07:02');
INSERT INTO `sys_log_login` VALUES (1739256536439934977, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 20:07:27');
INSERT INTO `sys_log_login` VALUES (1739276904168931329, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 21:28:23');
INSERT INTO `sys_log_login` VALUES (1739276919713021954, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 21:28:27');
INSERT INTO `sys_log_login` VALUES (1739279390254555137, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 21:38:16');
INSERT INTO `sys_log_login` VALUES (1739279418754850818, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 21:38:22');
INSERT INTO `sys_log_login` VALUES (1739284293320318977, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-25 21:57:45');
INSERT INTO `sys_log_login` VALUES (1739284306758868994, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 21:57:48');
INSERT INTO `sys_log_login` VALUES (1739285539712278530, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-25 22:02:42');
INSERT INTO `sys_log_login` VALUES (1739290092524421121, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-25 22:20:47');
INSERT INTO `sys_log_login` VALUES (1739323072311607297, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 00:31:50');
INSERT INTO `sys_log_login` VALUES (1739326668763803649, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 00:46:08');
INSERT INTO `sys_log_login` VALUES (1739529826068729858, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 14:13:24');
INSERT INTO `sys_log_login` VALUES (1739530695585763330, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 14:16:51');
INSERT INTO `sys_log_login` VALUES (1739557224080388097, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 16:02:16');
INSERT INTO `sys_log_login` VALUES (1739558560381448194, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:07:35');
INSERT INTO `sys_log_login` VALUES (1739561742495109122, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-26 16:20:14');
INSERT INTO `sys_log_login` VALUES (1739561800351338497, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:20:27');
INSERT INTO `sys_log_login` VALUES (1739561949786001410, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-26 16:21:03');
INSERT INTO `sys_log_login` VALUES (1739562003171102722, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:21:16');
INSERT INTO `sys_log_login` VALUES (1739562656186486786, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-26 16:23:51');
INSERT INTO `sys_log_login` VALUES (1739562683348799489, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:23:58');
INSERT INTO `sys_log_login` VALUES (1739562695583584257, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-26 16:24:01');
INSERT INTO `sys_log_login` VALUES (1739562745994924034, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:24:13');
INSERT INTO `sys_log_login` VALUES (1739567200672813058, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:41:55');
INSERT INTO `sys_log_login` VALUES (1739567360970723330, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '退出成功', '2023-12-26 16:42:33');
INSERT INTO `sys_log_login` VALUES (1739567484446838785, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 16:43:03');
INSERT INTO `sys_log_login` VALUES (1739577077810040833, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 17:21:10');
INSERT INTO `sys_log_login` VALUES (1739581254128848897, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 17:37:45');
INSERT INTO `sys_log_login` VALUES (1739615733694205954, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 19:54:46');
INSERT INTO `sys_log_login` VALUES (1739637666087370754, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '登录成功', '2023-12-26 21:21:55');
INSERT INTO `sys_log_login` VALUES (1739641056381067265, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 21:35:23');
INSERT INTO `sys_log_login` VALUES (1739646496456179713, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 21:57:00');
INSERT INTO `sys_log_login` VALUES (1739646526286069761, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 21:57:08');
INSERT INTO `sys_log_login` VALUES (1739646546523586561, NULL, 'xlq', '1', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '用户不存在/密码错误', '2023-12-26 21:57:12');
INSERT INTO `sys_log_login` VALUES (1739646577037148161, NULL, 'xlq', '1', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '用户不存在/密码错误', '2023-12-26 21:57:20');
INSERT INTO `sys_log_login` VALUES (1739646645538521090, NULL, 'xlq', '1', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '用户不存在/密码错误', '2023-12-26 21:57:36');
INSERT INTO `sys_log_login` VALUES (1739646702480392193, 1, 'admin', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 21:57:50');
INSERT INTO `sys_log_login` VALUES (1739647556390363137, 1594285543804383234, 'test', '0', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '登录成功', '2023-12-26 22:01:13');

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `del_flag` bit(1) NULL DEFAULT NULL COMMENT '逻辑删除(1:已删除，0:未删除)',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1738648540370378754 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', 1, 0, 'M', '0', '0', '', 'system', '系统管理目录', b'0', '2022-10-05 15:28:43', 1, '2022-11-14 14:41:50', NULL);
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', 1, 0, 'M', '0', '0', '', 'monitor', '系统监控目录', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', 1, 0, 'M', '0', '0', '', 'tool', '系统工具目录', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (4, '源码地址', 0, 10, 'https://github.com/oddfar/campus-example', NULL, '', 0, 0, 'M', '0', '0', '', 'guide', '若依官网地址', b'0', '2022-10-05 15:28:43', 1, '2022-11-21 17:11:40', NULL);
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', '用户管理菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', '角色管理菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', '菜单管理菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', '部门管理菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', '岗位管理菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', '字典管理菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', '参数设置菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', '通知公告菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', 1, 0, 'M', '0', '0', '', 'log', '日志管理菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', '在线用户菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', '定时任务菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', '数据监控菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', '服务监控菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', '缓存监控菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', '缓存列表菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', '表单构建菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', '代码生成菜单', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', '系统接口菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', '操作日志菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', '登录日志菜单', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', '', b'0', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', '', b'1', '2022-10-05 15:28:43', NULL, NULL, NULL);
INSERT INTO `sys_menu` VALUES (1597918884311171073, '校园信息墙', 0, 5, 'campus', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'education', '', b'0', '2022-11-30 19:42:05', 1, '2022-11-30 19:42:04', 1);
INSERT INTO `sys_menu` VALUES (1597929330846040066, '内容管理', 1597918884311171073, 2, 'content', 'campus/content/index', NULL, 1, 0, 'C', '0', '0', 'campus:content:list', 'content', '', b'0', '2022-11-30 20:23:35', 1, '2022-11-30 20:23:35', 1);
INSERT INTO `sys_menu` VALUES (1597930331497922562, '评论管理', 1597918884311171073, 6, 'comment', 'campus/comment/index', NULL, 1, 0, 'C', '0', '0', 'campus:comment:list', 'comment', '', b'0', '2022-11-30 20:27:34', 1, '2022-11-30 20:27:33', 1);
INSERT INTO `sys_menu` VALUES (1597930928431267841, '类别管理', 1597918884311171073, 3, 'category', 'campus/category/index', NULL, 1, 0, 'C', '0', '0', 'campus:category:list', 'category', '', b'0', '2022-11-30 20:29:56', 1, '2022-11-30 20:29:56', 1);
INSERT INTO `sys_menu` VALUES (1597931148678365186, '标签管理', 1597918884311171073, 4, 'tag', 'campus/tag/index', NULL, 1, 0, 'C', '0', '0', 'campus:tag:list', 'tag', '', b'0', '2022-11-30 20:30:49', 1, '2022-11-30 20:30:48', 1);
INSERT INTO `sys_menu` VALUES (1738637303121174530, '关系管理', 0, 5, 'relation', NULL, NULL, 1, 0, 'M', '0', '0', NULL, 'peoples', '', b'1', '2023-12-24 03:06:50', 1, '2023-12-24 03:06:50', 1);
INSERT INTO `sys_menu` VALUES (1738637680369459201, '关系管理', 0, 5, 'relation', 'relation/index', NULL, 1, 0, 'C', '0', '0', 'relation:list', 'peoples', '', b'1', '2023-12-24 03:08:20', 1, '2023-12-24 03:08:19', 1);
INSERT INTO `sys_menu` VALUES (1738648540370378754, '关系管理', 0, 8, 'relation', NULL, NULL, 1, 0, 'C', '0', '0', 'relation:list', 'people', '', b'0', '2023-12-24 03:51:29', 1, '2023-12-24 03:51:29', 1);

-- ----------------------------
-- Table structure for sys_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_resource`;
CREATE TABLE `sys_resource`  (
  `resource_id` bigint NOT NULL COMMENT '资源id',
  `app_code` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '应用编码',
  `resource_code` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源编码',
  `resource_name` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源名称',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '类名称',
  `method_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '方法名称',
  `modular_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源模块名称，一般为控制器名称',
  `url` varchar(300) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '资源url',
  `http_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'http请求方法',
  `resource_biz_type` tinyint NULL DEFAULT 1 COMMENT '资源的业务类型：1-业务类，2-系统类',
  `required_permission_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '是否需要鉴权：Y-是，N-否',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表存在 1代表删除）',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '创建时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime(0) NULL DEFAULT CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`resource_id`) USING BTREE,
  INDEX `RESOURCE_CODE_URL`(`resource_code`, `url`) USING BTREE COMMENT '资源code和url的联合索引'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '需要认证的接口资源controller' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_resource
-- ----------------------------
INSERT INTO `sys_resource` VALUES (1739646798714511361, 'oddfar', 'oddfar.sys_dict_type.edit', '字典类型管理-修改', 'SysDictTypeController', 'edit', '字典类型管理', '/system/dict/type', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798714511362, 'campus', 'campus.comment.list', 'list', 'CommentController', 'list', '评论管理', '/admin/comment/list', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798714511363, 'oddfar', 'oddfar.sys_dict_type.optionselect', '字典类型管理-获取字典选择框列表', 'SysDictTypeController', 'optionselect', '字典类型管理', '/system/dict/type/optionselect', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798714511364, 'campus', 'campus.category.edit', '修改分类', 'CategoryController', 'edit', '分类管理', '/admin/category', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798714511365, 'oddfar', 'oddfar.sys_login.get_routers', '获取路由信息', 'SysLoginController', 'getRouters', '登录路由', '/getRouters', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065794, 'oddfar', 'oddfar.sys_menu.tree_select', '菜单管理-获取菜单下拉树列表', 'SysMenuController', 'treeSelect', '菜单管理', '/system/menu/treeselect', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065795, 'campus', 'campus.user_action.image_upload', '图片文件上传', 'UserActionController', 'imageUpload', '用户操作api', '/campus/imageUpload', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065796, 'oddfar', 'oddfar.sys_role.remove', 'remove', 'SysRoleController', 'remove', '角色管理', '/system/role/{roleIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065797, 'oddfar', 'oddfar.sys_menu.role_menu_treeselect', '菜单管理-加载对应角色菜单列表树', 'SysMenuController', 'roleMenuTreeselect', '菜单管理', '/system/menu/roleMenuTreeselect/{roleId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065798, 'oddfar', 'oddfar.sys_profile.update_profile', 'updateProfile', 'SysProfileController', 'updateProfile', '个人信息管理', '/system/user/profile/个人信息管理-修改', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065799, 'campus', 'campus.user_account.send_reset_pwd_code', 'sendResetPwdCode', 'UserAccountController', 'sendResetPwdCode', '用户账户操作api', '/campus/pwd-code', 'post', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065800, 'oddfar', 'oddfar.sys_role.add', 'add', 'SysRoleController', 'add', '角色管理', '/system/role', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065801, 'campus', 'campus.comment_info.to_comment', '添加评论', 'CommentInfoController', 'toComment', '评论api', '/campus/toComment', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065802, 'relation', 'relation.relation_info.cancel_block', '取消拉黑', 'RelationInfoController', 'cancelBlock', '关系api', '/relation/cancelBlock/{receiverID}', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065803, 'oddfar', 'oddfar.sys_login.login', '登录方法', 'SysLoginController', 'login', '登录路由', '/login', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065804, 'relation', 'relation.relation_info.get_block_list', '查询黑名单', 'RelationInfoController', 'getBlockList', '关系api', '/relation/blockList', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065805, 'oddfar', 'oddfar.sys_role.get_info', 'getInfo', 'SysRoleController', 'getInfo', '角色管理', '/system/role/{roleId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065806, 'oddfar', 'oddfar.sys_user.auth_role', 'authRole', 'SysUserController', 'authRole', '用户管理', '/system/user/authRole/{userId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065807, 'oddfar', 'oddfar.sys_config.edit', '参数配置管理-修改', 'SysConfigController', 'edit', '参数配置管理', '/system/config', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065808, 'oddfar', 'oddfar.sys_menu.edit', '菜单管理-修改', 'SysMenuController', 'edit', '菜单管理', '/system/menu', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065809, 'relation', 'relation.relation_info.cancel_special_follow', '取消特别关注', 'RelationInfoController', 'cancelSpecialFollow', '关系api', '/relation/cancelSpecialFollow/{receiverID}', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065810, 'campus', 'campus.content.page', '分页', 'ContentController', 'page', '内容管理', '/admin/content/list', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065811, 'oddfar', 'oddfar.sys_user.insert_auth_role', 'insertAuthRole', 'SysUserController', 'insertAuthRole', '用户管理', '/system/user/authRole', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065812, 'oddfar', 'oddfar.sys_logininfor.list', '登录日志-分类列表', 'SysLogininforController', 'list', '登录日志管理', '/monitor/logininfor/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065813, 'oddfar', 'oddfar.sys_config.refresh_cache', '参数配置管理-刷新缓存', 'SysConfigController', 'refreshCache', '参数配置管理', '/system/config/refreshCache', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065814, 'oddfar', 'oddfar.sys_role.cancel_auth_user_all', 'cancelAuthUserAll', 'SysRoleController', 'cancelAuthUserAll', '角色管理', '/system/role/authUser/cancelAll', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065815, 'relation', 'relation.relation_info.get_special_follow_list', '查询特别关注列表', 'RelationInfoController', 'getSpecialFollowList', '关系api', '/relation/specialFollowList', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065816, 'oddfar', 'oddfar.sys_operlog.clean', '操作日志-清空', 'SysOperlogController', 'clean', '操作日志管理', '/monitor/operlog/clean', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065817, 'oddfar', 'oddfar.sys_dict_type.get_info', '字典类型管理-查询', 'SysDictTypeController', 'getInfo', '字典类型管理', '/system/dict/type/{dictId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065818, 'oddfar', 'oddfar.sys_user.update', 'update', 'SysUserController', 'update', '用户管理', '/system/user', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065819, 'oddfar', 'oddfar.sys_api_resource.edit_role_resource', '修改对应角色api资源', 'SysApiResourceController', 'editRoleResource', '资源管理', '/system/resource/roleApi', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065820, 'oddfar', 'oddfar.sys_role.unallocated_list', 'unallocatedList', 'SysRoleController', 'unallocatedList', '角色管理', '/system/role/authUser/unallocatedList', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065821, 'oddfar', 'oddfar.sys_logininfor.clean', '登录日志-清空', 'SysLogininforController', 'clean', '登录日志管理', '/monitor/logininfor/clean', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798748065822, 'campus', 'campus.campus_info.category_list', '查询分类列表', 'CampusInfoController', 'categoryList', '校园墙信息api', '/campus/categoryList', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174658, 'campus', 'campus.content_info.del_content', '删除自己的校园墙', 'ContentInfoController', 'delContent', '信息墙api', '/campus/delContent/{contentId}', 'delete', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174659, 'oddfar', 'oddfar.sys_role.change_status', 'changeStatus', 'SysRoleController', 'changeStatus', '角色管理', '/system/role/changeStatus', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174660, 'oddfar', 'oddfar.sys_logininfor.remove', '登录日志-删除', 'SysLogininforController', 'remove', '登录日志管理', '/monitor/logininfor/{infoIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174661, 'campus', 'campus.tag.add', 'add', 'TagController', 'add', '标签管理', '/admin/tag', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174662, 'campus', 'campus.comment_info.get_comment', '添加评论', 'CommentInfoController', 'getComment', '评论api', '/campus/getComment', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174663, 'oddfar', 'oddfar.sys_dict_data.remove', '字典数据管理-删除', 'SysDictDataController', 'remove', '字典数据管理', '/system/dict/data/{dictCodes}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174664, 'campus', 'campus.content_info.get_content_by_id', '查询信息墙详细内容', 'ContentInfoController', 'getContentById', '信息墙api', '/campus/getContent', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174665, 'oddfar', 'oddfar.sys_dict_data.get_info', '字典数据管理-查询', 'SysDictDataController', 'getInfo', '字典数据管理', '/system/dict/data/{dictCode}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174666, 'campus', 'campus.content_info.get_own_love_content', '查询点赞的信息墙列表', 'ContentInfoController', 'getOwnLoveContent', '信息墙api', '/campus/getOwnLoveContent', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174667, 'campus', 'campus.comment.add', 'add', 'CommentController', 'add', '评论管理', '/admin/comment', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174668, 'campus', 'campus.tag.list', 'list', 'TagController', 'list', '标签管理', '/admin/tag/list', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174669, 'oddfar', 'oddfar.sys_login.get_info', '获取用户信息', 'SysLoginController', 'getInfo', '登录路由', '/getInfo', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174670, 'campus', 'campus.content.get_info', '获取校园墙内容', 'ContentController', 'getInfo', '内容管理', '/admin/content/{contentId}', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174671, 'oddfar', 'oddfar.sys_user.reset_pwd', 'resetPwd', 'SysUserController', 'resetPwd', '用户管理', '/system/user/resetPwd', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174672, 'oddfar', 'oddfar.sys_menu.get_info', '菜单管理-查询', 'SysMenuController', 'getInfo', '菜单管理', '/system/menu/{menuId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174673, 'oddfar', 'oddfar.sys_role.cancel_auth_user', 'cancelAuthUser', 'SysRoleController', 'cancelAuthUser', '角色管理', '/system/role/authUser/cancel', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174674, 'oddfar', 'oddfar.sys_menu.remove', '菜单管理-删除', 'SysMenuController', 'remove', '菜单管理', '/system/menu/{menuId}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174675, 'oddfar', 'oddfar.sys_role.list', 'list', 'SysRoleController', 'list', '角色管理', '/system/role/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174676, 'oddfar', 'oddfar.sys_dict_type.refresh_cache', '字典类型管理-刷新', 'SysDictTypeController', 'refreshCache', '字典类型管理', '/system/dict/type/refreshCache', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174677, 'oddfar', 'oddfar.sys_menu.add', '菜单管理-新增', 'SysMenuController', 'add', '菜单管理', '/system/menu', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174678, 'oddfar', 'oddfar.sys_user.page', 'page', 'SysUserController', 'page', '用户管理', '/system/user/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174679, 'oddfar', 'oddfar.sys_role.allocated_list', 'allocatedList', 'SysRoleController', 'allocatedList', '角色管理', '/system/role/authUser/allocatedList', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174680, 'relation', 'relation.relation_info.special_follow', '特别关注', 'RelationInfoController', 'specialFollow', '关系api', '/relation/specialFollow/{receiverID}', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174681, 'campus', 'campus.tag.remove', 'remove', 'TagController', 'remove', '标签管理', '/admin/tag/{tagIds}', 'delete', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174682, 'oddfar', 'oddfar.sys_dict_data.edit', '字典数据管理-修改', 'SysDictDataController', 'edit', '字典数据管理', '/system/dict/data', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174683, 'campus', 'campus.category.remove', '删除分类', 'CategoryController', 'remove', '分类管理', '/admin/category/{categoryId}', 'delete', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174684, 'campus', 'campus.user_account.send_mail', 'sendMail', 'UserAccountController', 'sendMail', '用户账户操作api', '/campus/bindMail', 'post', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174685, 'oddfar', 'oddfar.sys_operlog.list', '操作日志-分页', 'SysOperlogController', 'list', '操作日志管理', '/monitor/operlog/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174686, 'campus', 'campus.category.add', '新增分类', 'CategoryController', 'add', '分类管理', '/admin/category', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174687, 'oddfar', 'oddfar.sys_role.select_auth_user_all', 'selectAuthUserAll', 'SysRoleController', 'selectAuthUserAll', '角色管理', '/system/role/authUser/selectAll', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174688, 'oddfar', 'oddfar.sys_config.add', '参数配置管理-新增', 'SysConfigController', 'add', '参数配置管理', '/system/config', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174689, 'oddfar', 'oddfar.sys_dict_type.remove', '字典类型管理-删除', 'SysDictTypeController', 'remove', '字典类型管理', '/system/dict/type/{dictIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174690, 'campus', 'campus.comment_info.get_comment_children_list', '查询一级评论的子评论', 'CommentInfoController', 'getCommentChildrenList', '评论api', '/campus/getCommentChildrenList', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174691, 'campus', 'campus.content_info.update_content', '修改信息墙', 'ContentInfoController', 'updateContent', '信息墙api', '/campus/updateContent', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174692, 'campus', 'campus.content.remove', 'remove', 'ContentController', 'remove', '内容管理', '/admin/content/{contentIds}', 'delete', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174693, 'oddfar', 'oddfar.sys_config.get_info', '参数配置管理-查询id信息', 'SysConfigController', 'getInfo', '参数配置管理', '/system/config/{id}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174694, 'relation', 'relation.relation_info.cancel_follow', '取消关注', 'RelationInfoController', 'cancelFollow', '关系api', '/relation/cancelFollow/{receiverID}', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174695, 'oddfar', 'oddfar.sys_config.remove', '参数配置管理-删除', 'SysConfigController', 'remove', '参数配置管理', '/system/config/{configIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174696, 'campus', 'campus.comment_info.get_own_comment_list', '分页查询自己发布或回复的评论列表', 'CommentInfoController', 'getOwnCommentList', '评论api', '/campus/getOwnComment', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174697, 'campus', 'campus.content.edit', '修改信息墙内容', 'ContentController', 'edit', '内容管理', '/admin/content/', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174698, 'oddfar', 'oddfar.sys_dict_data.add', '字典数据管理-新增', 'SysDictDataController', 'add', '字典数据管理', '/system/dict/data', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174699, 'campus', 'campus.content_info.own_contents', '查看自己的单个信息墙', 'ContentInfoController', 'ownContents', '信息墙api', '/campus/ownContents', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174700, 'oddfar', 'oddfar.sys_dict_data.dict_type', '字典数据管理-根据字典类型查询字典数据信息', 'SysDictDataController', 'dictType', '字典数据管理', '/system/dict/data/type/{dictType}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174701, 'campus', 'campus.category.list', '查询分类列表', 'CategoryController', 'list', '分类管理', '/admin/category/list', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174702, 'oddfar', 'oddfar.sys_config.get_config_key', 'getConfigKey', 'SysConfigController', 'getConfigKey', '参数配置管理', '/system/config/configKey/{configKey:.+}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174703, 'oddfar', 'oddfar.sys_profile.avatar', '个人信息管理-头像上次', 'SysProfileController', 'avatar', '个人信息管理', '/system/user/profile/avatar', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174704, 'oddfar', 'oddfar.sys_user.get_info', 'getInfo', 'SysUserController', 'getInfo', '用户管理', '/system/user/{userId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174705, 'campus', 'campus.comment.edit', 'edit', 'CommentController', 'edit', '评论管理', '/admin/comment', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174706, 'campus', 'campus.comment_info.get_one_level_comment', '查询一级评论', 'CommentInfoController', 'getOneLevelComment', '评论api', '/campus/getOneLevelComment', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174707, 'campus', 'campus.user_account.change_pwd', 'changePwd', 'UserAccountController', 'changePwd', '用户账户操作api', '/campus/changePwd', 'post', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174708, 'oddfar', 'oddfar.sys_config.page', '参数配置管理-分页', 'SysConfigController', 'page', '参数配置管理', '/system/config/page', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174709, 'campus', 'campus.comment_info.get_comment_children', '分页查询一级评论的子评论', 'CommentInfoController', 'getCommentChildren', '评论api', '/campus/getCommentChildren', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174710, 'campus', 'campus.comment_info.del_own_comment', '删除自己的评论', 'CommentInfoController', 'delOwnComment', '评论api', '/campus/delOwnComment', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174711, 'oddfar', 'oddfar.sys_menu.list', '菜单管理-分页', 'SysMenuController', 'list', '菜单管理', '/system/menu/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174712, 'campus', 'campus.content_info.get_content_by_condition', '条件查询信息墙', 'ContentInfoController', 'getContentByCondition', '信息墙api', '/campus/getContentByCondition', 'post', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798815174713, 'campus', 'campus.user_action.zan_content', '点赞', 'UserActionController', 'zanContent', '用户操作api', '/campus/zan/{contentId}', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283522, 'relation', 'relation.relation_info.block', '拉黑', 'RelationInfoController', 'block', '关系api', '/relation/block/{receiverID}', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283523, 'oddfar', 'oddfar.sys_dict_type.list', '字典类型管理-分页', 'SysDictTypeController', 'list', '字典类型管理', '/system/dict/type/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283524, 'campus', 'campus.content_info.get_content_list', '查询信息墙内容列表', 'ContentInfoController', 'getContentList', '信息墙api', '/campus/contentList', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283525, 'oddfar', 'oddfar.sys_profile.update_pwd', '个人信息管理-重置密码', 'SysProfileController', 'updatePwd', '个人信息管理', '/system/user/profile/updatePwd', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283526, 'oddfar', 'oddfar.sys_user.remove', 'remove', 'SysUserController', 'remove', '用户管理', '/system/user/{userIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283527, 'campus', 'campus.user_account.email_validate', 'emailValidate', 'UserAccountController', 'emailValidate', '用户账户操作api', '/campus/email-validate', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283528, 'campus', 'campus.user_account.have_mail', 'haveMail', 'UserAccountController', 'haveMail', '用户账户操作api', '/campus/haveMail', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283529, 'campus', 'campus.content_info.to_content', '发表信息墙', 'ContentInfoController', 'toContent', '信息墙api', '/campus/sendContent', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283530, 'campus', 'campus.content_info.get_simple_hot_content', '查询信息墙内容列表', 'ContentInfoController', 'getSimpleHotContent', '信息墙api', '/campus/simpleHotContent', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283531, 'oddfar', 'oddfar.sys_user.add', 'add', 'SysUserController', 'add', '用户管理', '/system/user', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283532, 'campus', 'campus.category.list_select', '查询分类列表选择器', 'CategoryController', 'listSelect', '分类管理', '/admin/category/listSelect', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283533, 'campus', 'campus.user_action.video_upload', '视频文件上传', 'UserActionController', 'videoUpload', '用户操作api', '/campus/videoUpload', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283534, 'oddfar', 'oddfar.sys_user.change_status', 'changeStatus', 'SysUserController', 'changeStatus', '用户管理', '/system/user/changeStatus', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283535, 'oddfar', 'oddfar.sys_dict_data.page', '字典数据管理-分页', 'SysDictDataController', 'page', '字典数据管理', '/system/dict/data/list', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283536, 'campus', 'campus.campus_info.category_children', '查询分类子列表', 'CampusInfoController', 'categoryChildren', '校园墙信息api', '/campus/categoryChildren/{categoryId}', 'get', 1, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283537, 'campus', 'campus.category.get_info', '获取分类详细信息', 'CategoryController', 'getInfo', '分类管理', '/admin/category/{categoryId}', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283538, 'relation', 'relation.relation_info.follow', '关注', 'RelationInfoController', 'follow', '关系api', '/relation/follow/{receiverID}', 'post', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283539, 'oddfar', 'oddfar.sys_operlog.remove', '操作日志-删除', 'SysOperlogController', 'remove', '操作日志管理', '/monitor/operlog/{operIds}', 'delete', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283540, 'campus', 'campus.comment.get_info', 'getInfo', 'CommentController', 'getInfo', '评论管理', '/admin/comment/{commentId}', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283541, 'oddfar', 'oddfar.sys_api_resource.role_menu_tree_select', '资源管理-加载对应角色资源列表树', 'SysApiResourceController', 'roleMenuTreeSelect', '资源管理', '/system/resource/roleApiTreeselect/{roleId}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283542, 'oddfar', 'oddfar.sys_profile.profile', '个人信息管理-查询', 'SysProfileController', 'profile', '个人信息管理', '/system/user/profile', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283543, 'oddfar', 'oddfar.sys_logininfor.unlock', '登录日志-解锁', 'SysLogininforController', 'unlock', '登录日志管理', '/monitor/logininfor/unlock/{userName}', 'get', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283544, 'oddfar', 'oddfar.sys_dict_type.add', '字典类型管理-新增', 'SysDictTypeController', 'add', '字典类型管理', '/system/dict/type', 'post', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283545, 'campus', 'campus.tag.get_info', 'getInfo', 'TagController', 'getInfo', '标签管理', '/admin/tag/{tagId}', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283546, 'campus', 'campus.tag.edit', 'edit', 'TagController', 'edit', '标签管理', '/admin/tag', 'put', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283547, 'relation', 'relation.relation_info.get_follow_list', '查询关注列表', 'RelationInfoController', 'getFollowList', '关系api', '/relation/followList', 'get', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283548, 'campus', 'campus.comment.remove', 'remove', 'CommentController', 'remove', '评论管理', '/admin/comment/{commentIds}', 'delete', 1, 'Y', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');
INSERT INTO `sys_resource` VALUES (1739646798882283549, 'oddfar', 'oddfar.sys_role.edit', 'edit', 'SysRoleController', 'edit', '角色管理', '/system/role', 'put', 2, 'N', b'0', NULL, '2023-12-26 21:58:13', NULL, '2023-12-26 21:58:12');

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` bit(1) NULL DEFAULT b'0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1628997651572027394 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, 1, '0', '超级管理员', b'0', NULL, '2022-10-05 15:28:43', NULL, '2023-12-24 02:40:03');
INSERT INTO `sys_role` VALUES (2, '普通角色', 'common', 2, 1, '0', '普通角色', b'0', NULL, '2022-10-05 15:28:43', 1, '2023-12-24 02:40:03');
INSERT INTO `sys_role` VALUES (1594285449147330561, '普通用户', 'campus:common', 0, 1, '0', NULL, b'0', 1, '2022-11-20 19:04:06', 1, '2023-12-24 03:30:34');
INSERT INTO `sys_role` VALUES (1628997165540274178, '审核员', 'campus:auditor', 0, 1, '0', '审核信息墙内容，可以修改信息墙内容', b'0', 1, '2023-02-24 13:56:04', 1, '2023-12-25 22:02:55');
INSERT INTO `sys_role` VALUES (1628997651572027394, '浏览用户', 'campus:glance', 0, 1, '0', '只可浏览信息墙，点赞信息墙，不可发表墙和评论', b'0', 1, '2023-02-24 13:58:00', 1, '2023-02-24 14:10:46');

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1);
INSERT INTO `sys_role_menu` VALUES (2, 4);
INSERT INTO `sys_role_menu` VALUES (2, 100);
INSERT INTO `sys_role_menu` VALUES (2, 101);
INSERT INTO `sys_role_menu` VALUES (2, 1000);
INSERT INTO `sys_role_menu` VALUES (2, 1001);
INSERT INTO `sys_role_menu` VALUES (2, 1002);
INSERT INTO `sys_role_menu` VALUES (2, 1003);
INSERT INTO `sys_role_menu` VALUES (2, 1004);
INSERT INTO `sys_role_menu` VALUES (2, 1005);
INSERT INTO `sys_role_menu` VALUES (2, 1006);
INSERT INTO `sys_role_menu` VALUES (2, 1007);
INSERT INTO `sys_role_menu` VALUES (2, 1008);
INSERT INTO `sys_role_menu` VALUES (2, 1009);
INSERT INTO `sys_role_menu` VALUES (2, 1010);
INSERT INTO `sys_role_menu` VALUES (2, 1011);
INSERT INTO `sys_role_menu` VALUES (2, 1597918884311171073);
INSERT INTO `sys_role_menu` VALUES (2, 1597929330846040066);
INSERT INTO `sys_role_menu` VALUES (2, 1597930331497922562);
INSERT INTO `sys_role_menu` VALUES (2, 1597930928431267841);
INSERT INTO `sys_role_menu` VALUES (2, 1597931148678365186);
INSERT INTO `sys_role_menu` VALUES (2, 1738630210028703745);
INSERT INTO `sys_role_menu` VALUES (1594285449147330561, 4);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1597918884311171073);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1597929330846040066);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1597930331497922562);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1597930928431267841);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1597931148678365186);
INSERT INTO `sys_role_menu` VALUES (1628997165540274178, 1738648540370378754);

-- ----------------------------
-- Table structure for sys_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_resource`;
CREATE TABLE `sys_role_resource`  (
  `resource_code` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '资源编码',
  `role_id` bigint NOT NULL COMMENT '角色id',
  PRIMARY KEY (`role_id`, `resource_code`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '角色资源关联' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_resource
-- ----------------------------
INSERT INTO `sys_role_resource` VALUES ('campus.content.get_info', 2);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.del_content', 2);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.get_own_love_content', 2);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.own_contents', 2);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.to_content', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.block', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_block', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_follow', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_special_follow', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.follow', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_block_list', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_follow_list', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_special_follow_list', 2);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.special_follow', 2);
INSERT INTO `sys_role_resource` VALUES ('campus.comment_info.get_own_comment_list', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.comment_info.to_comment', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.del_content', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.get_own_love_content', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.own_contents', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.to_content', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.user_action.image_upload', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.user_action.video_upload', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.user_action.zan_content', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.block', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_block', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_follow', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_special_follow', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.follow', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_block_list', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_follow_list', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_special_follow_list', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.special_follow', 1594285449147330561);
INSERT INTO `sys_role_resource` VALUES ('campus.category.add', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.category.edit', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.category.get_info', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.category.list', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.category.list_select', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.category.remove', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content.edit', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content.get_info', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content.page', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content.remove', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.del_content', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.get_own_love_content', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.own_contents', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.to_content', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.update_content', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.block', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_block', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_follow', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.cancel_special_follow', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.follow', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_block_list', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_follow_list', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.get_special_follow_list', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('relation.relation_info.special_follow', 1628997165540274178);
INSERT INTO `sys_role_resource` VALUES ('campus.comment_info.del_own_comment', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.comment_info.get_own_comment_list', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.comment_info.to_comment', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content.edit', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content.get_info', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content.page', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content.remove', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.del_content', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.get_own_love_content', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.content_info.own_contents', 1628997651572027394);
INSERT INTO `sys_role_resource` VALUES ('campus.user_action.zan_content', 1628997651572027394);

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime(0) NULL DEFAULT NULL COMMENT '最后登录时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `introduction` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人介绍',
  `experience` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人经历',
  `create_user` bigint NULL DEFAULT NULL COMMENT '创建者',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `update_user` bigint NULL DEFAULT NULL COMMENT '更新者',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `del_flag` bit(1) NULL DEFAULT NULL COMMENT '逻辑删除(1:已删除，0:未删除)',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1737940657664077832 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 'admin', 'admin', '00', 'oddfar@163.com', '15888888888', '0', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '127.0.0.1', '2023-12-26 21:57:50', '管理员', '我是管理员', '北京大学', 0, '2022-10-05 15:28:43', 1, '2023-12-26 21:57:50', b'0');
INSERT INTO `sys_user` VALUES (2, 'zhiyuan', '致远', '00', 'a_zhiyuan@163.com', '15666666666', '1', '', '$2a$10$LtM4R7ovl31aBeT8yLrb.uoMFjU4TisUHHSZk4/PsLVkkyZT.Fgf.', '0', '127.0.0.1', '2023-01-11 23:04:36', '测试', '我是致远', '清华大学', 0, '2022-10-05 15:28:43', 2, '2023-01-11 23:04:36', b'0');
INSERT INTO `sys_user` VALUES (1594285543804383234, 'test', '测试账号', '00', '123123@163.com', '', '0', 'https://img0.baidu.com/it/u=1183896628,1403534286&fm=253&fmt=auto&app=138&f=PNG', '$2a$10$jEsSgqNclOA.0Vj4xuKIdeXLC0D9trS1aAoZBLA6e/Z7JSDmU67HW', '0', '127.0.0.1', '2023-12-26 22:01:13', '测试', '我是KD', '中国科学技术大学', 1, '2022-11-20 19:04:29', 1594285543804383234, '2023-12-26 22:01:13', b'0');
INSERT INTO `sys_user` VALUES (1737940657664077826, '123123', '123123', '00', '123123@163.com', '', '0', '', '$2a$10$T8nMS5L8tLUYaAKJCDqe2ei98zM2L6L3SQHA42o/toOL3BaLe3Tmu', '0', '127.0.0.1', '2023-12-22 05:18:06', NULL, '我是百味', '重庆大学', NULL, '2023-12-22 04:58:37', 1737940657664077826, '2023-12-22 05:18:06', b'0');
INSERT INTO `sys_user` VALUES (1737940657664077827, 'test1', '用户1', '00', '123123@163.com', '', '0', '', '$2a$10$jEsSgqNclOA.0Vj4xuKIdeXLC0D9trS1aAoZBLA6e/Z7JSDmU67HW', '0', '', NULL, NULL, '我是LBJ', '重庆大学', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_user` VALUES (1737940657664077828, 'test2', '用户2', '00', '123123@163.com', '', '0', '', '$2a$10$jEsSgqNclOA.0Vj4xuKIdeXLC0D9trS1aAoZBLA6e/Z7JSDmU67HW', '0', '', NULL, NULL, '我是用户2', '中国科学技术大学', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_user` VALUES (1737940657664077829, 'test3', '用户3', '00', '123123@163.com', '', '0', '', '$2a$10$jEsSgqNclOA.0Vj4xuKIdeXLC0D9trS1aAoZBLA6e/Z7JSDmU67HW', '0', '', NULL, NULL, '我是用户3', '中国科学技术大学', NULL, NULL, NULL, NULL, b'0');
INSERT INTO `sys_user` VALUES (1737940657664077830, 'test4', '用户4', '00', '123123@163.com', '', '0', '', '$2a$10$jEsSgqNclOA.0Vj4xuKIdeXLC0D9trS1aAoZBLA6e/Z7JSDmU67HW', '0', '127.0.0.1', '2023-12-25 19:01:59', NULL, '我是用户4', '中国科学技术大学', NULL, NULL, 1737940657664077830, '2023-12-25 19:01:59', b'0');
INSERT INTO `sys_user` VALUES (1737940657664077831, 'test4', '用户5', '00', '123123@163.com', '', '0', '', '', '0', '', NULL, NULL, '我是用户5', '中国科学技术大学', NULL, NULL, NULL, NULL, NULL);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1);
INSERT INTO `sys_user_role` VALUES (2, 2);
INSERT INTO `sys_user_role` VALUES (1594285543804383234, 1628997165540274178);
INSERT INTO `sys_user_role` VALUES (1638895499486773250, 1628997165540274178);
INSERT INTO `sys_user_role` VALUES (1638913642586238978, 2);
INSERT INTO `sys_user_role` VALUES (1737940657664077827, 1628997165540274178);
INSERT INTO `sys_user_role` VALUES (1737940657664077828, 1628997165540274178);
INSERT INTO `sys_user_role` VALUES (1737940657664077829, 1628997165540274178);
INSERT INTO `sys_user_role` VALUES (1737940657664077830, 2);
INSERT INTO `sys_user_role` VALUES (1737940657664077830, 1594285449147330561);
INSERT INTO `sys_user_role` VALUES (1737940657664077830, 1628997165540274178);

SET FOREIGN_KEY_CHECKS = 1;
