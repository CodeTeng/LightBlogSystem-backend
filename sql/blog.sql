/*
 Navicat Premium Data Transfer

 Source Server         : Centos7.6虚拟机
 Source Server Type    : MySQL
 Source Server Version : 80027
 Source Host           : 192.168.80.129:3306
 Source Schema         : blog

 Target Server Type    : MySQL
 Target Server Version : 80027
 File Encoding         : 65001

 Date: 01/03/2024 20:31:56
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for t_about
-- ----------------------------
DROP TABLE IF EXISTS `t_about`;
CREATE TABLE `t_about`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '内容',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_about
-- ----------------------------
INSERT INTO `t_about` VALUES (1, '{\"content\":\"我就是我\"}', '2022-07-24 17:22:13', '2024-03-01 15:35:26');

-- ----------------------------
-- Table structure for t_article
-- ----------------------------
DROP TABLE IF EXISTS `t_article`;
CREATE TABLE `t_article`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NOT NULL COMMENT '作者',
  `category_id` int(0) NULL DEFAULT NULL COMMENT '文章分类',
  `article_cover` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章缩略图',
  `article_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `article_abstract` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文章摘要，如果该字段为空，默认取文章的前500个字符作为摘要',
  `article_content` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶 0否 1是',
  `is_featured` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否推荐 0否 1是',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态值 1公开 2私密 3草稿',
  `type` tinyint(1) NOT NULL DEFAULT 1 COMMENT '文章类型 1原创 2转载 3翻译',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '访问密码',
  `original_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '原文链接',
  `create_time` datetime(0) NOT NULL COMMENT '发表时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 137 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article
-- ----------------------------
INSERT INTO `t_article` VALUES (135, 1024, 217, 'http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/3ed360913fbc09fe612c94333dbad8c9.jpg', '2024-03-01', '这是我的一篇文章', '123', 0, 1, 0, 1, 1, NULL, NULL, '2024-03-01 15:22:10', '2024-03-01 18:57:40');
INSERT INTO `t_article` VALUES (136, 1024, 222, 'http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/a7799f18551353efd5aebb4d53be2cd7.jpg', '2024-03-01', '一篇关于Java基础的文章', '# Java基础概念\n\n1. 简单易学；面向对象（封装，继承，多态）；\n2. 平台无关性（ Java 虚拟机实现平台无关性）；\n3. 支持多线程（ C++ 语言没有内置的多线程机制，因此必须调用操作系统的多线程功能来进行多线程程序设计，而 Java 语言却提供了多线程支持）；\n4. 可靠性（具备异常处理和自动内存管理机制）；\n5. 安全性（Java 语言本身的设计就提供了多重安全防护机制如访问权限修饰符、限制程序直接访问操作系统资源）；\n6. 高效性（通过 Just In Time 编译器等技术的优化，Java 语言的运行效率还是非常不错的）；\n7. 支持网络编程并且很方便；\n8. 编译与解释并存；\n9. ……\n\n🌈 拓展一下：\n“Write Once, Run Anywhere（一次编写，随处运行）”这句宣传口号，真心经典，流传了好多年！以至于，直到今天，依然有很多人觉得跨平台是 Java 语言最大的优势。实际上，跨平台已经不是 Java 最大的卖点了，各种 JDK 新特性也不是。目前市面上虚拟化技术已经非常成熟，比如你通过 Docker 就很容易实现跨平台了。在我看来，Java 强大的生态才是！\n\n\n', 0, 1, 0, 1, 1, NULL, NULL, '2024-03-01 18:56:42', '2024-03-01 18:57:30');

-- ----------------------------
-- Table structure for t_article_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_article_tag`;
CREATE TABLE `t_article_tag`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `article_id` int(0) NOT NULL COMMENT '文章id',
  `tag_id` int(0) NOT NULL COMMENT '标签id',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_article_tag_1`(`article_id`) USING BTREE,
  INDEX `fk_article_tag_2`(`tag_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 90 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_article_tag
-- ----------------------------
INSERT INTO `t_article_tag` VALUES (87, 135, 41);
INSERT INTO `t_article_tag` VALUES (88, 135, 43);
INSERT INTO `t_article_tag` VALUES (89, 136, 41);

-- ----------------------------
-- Table structure for t_category
-- ----------------------------
DROP TABLE IF EXISTS `t_category`;
CREATE TABLE `t_category`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `category_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '分类名',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 230 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_category
-- ----------------------------
INSERT INTO `t_category` VALUES (217, '后端', '2024-03-01 15:20:37', NULL);
INSERT INTO `t_category` VALUES (218, '前端', '2024-03-01 15:20:46', NULL);
INSERT INTO `t_category` VALUES (219, '算法', '2024-03-01 15:20:53', NULL);
INSERT INTO `t_category` VALUES (220, '测试', '2024-03-01 15:20:57', NULL);
INSERT INTO `t_category` VALUES (221, 'UI', '2024-03-01 15:21:01', NULL);
INSERT INTO `t_category` VALUES (222, 'Java', '2024-03-01 18:51:24', NULL);
INSERT INTO `t_category` VALUES (223, 'GoLang', '2024-03-01 18:51:31', NULL);
INSERT INTO `t_category` VALUES (224, 'Python', '2024-03-01 18:51:35', NULL);
INSERT INTO `t_category` VALUES (225, '面试', '2024-03-01 18:51:41', NULL);
INSERT INTO `t_category` VALUES (226, '计算机基础', '2024-03-01 18:52:05', NULL);
INSERT INTO `t_category` VALUES (227, '运维', '2024-03-01 18:52:17', NULL);
INSERT INTO `t_category` VALUES (228, 'C++', '2024-03-01 18:52:26', NULL);
INSERT INTO `t_category` VALUES (229, '嵌入式', '2024-03-01 18:52:36', NULL);

-- ----------------------------
-- Table structure for t_comment
-- ----------------------------
DROP TABLE IF EXISTS `t_comment`;
CREATE TABLE `t_comment`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `user_id` int(0) NOT NULL COMMENT '评论用户Id',
  `topic_id` int(0) NULL DEFAULT NULL COMMENT '评论主题id',
  `comment_content` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '评论内容',
  `reply_user_id` int(0) NULL DEFAULT NULL COMMENT '回复用户id',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父评论id',
  `type` tinyint(0) NOT NULL COMMENT '评论类型 1.文章 2.留言 3.关于我 4.友链 5.说说',
  `is_delete` tinyint(0) NOT NULL DEFAULT 0 COMMENT '是否删除  0否 1是',
  `is_review` tinyint(1) NOT NULL DEFAULT 1 COMMENT '是否审核',
  `create_time` datetime(0) NOT NULL COMMENT '评论时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_comment_user`(`user_id`) USING BTREE,
  INDEX `fk_comment_parent`(`parent_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1035 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_comment
-- ----------------------------
INSERT INTO `t_comment` VALUES (1032, 1024, 135, '写的很好', NULL, NULL, 1, 0, 1, '2024-03-01 15:22:39', NULL);
INSERT INTO `t_comment` VALUES (1033, 1024, 135, '你也不错', 1024, 1032, 1, 0, 1, '2024-03-01 15:22:46', NULL);
INSERT INTO `t_comment` VALUES (1034, 1024, NULL, '你好', NULL, NULL, 2, 0, 1, '2024-03-01 15:31:09', NULL);

-- ----------------------------
-- Table structure for t_exception_log
-- ----------------------------
DROP TABLE IF EXISTS `t_exception_log`;
CREATE TABLE `t_exception_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `opt_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求接口',
  `opt_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '请求方式',
  `request_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求方式',
  `request_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '请求参数',
  `opt_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '操作描述',
  `exception_info` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL COMMENT '异常信息',
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `create_time` datetime(0) NOT NULL COMMENT '操作时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_exception_log
-- ----------------------------

-- ----------------------------
-- Table structure for t_friend_link
-- ----------------------------
DROP TABLE IF EXISTS `t_friend_link`;
CREATE TABLE `t_friend_link`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `link_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接名',
  `link_avatar` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接头像',
  `link_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接地址',
  `link_intro` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '链接介绍',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `fk_friend_link_user`(`link_name`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 48 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_friend_link
-- ----------------------------
INSERT INTO `t_friend_link` VALUES (47, '我是测试好友', 'http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/avatar/aa36bad4068f13992d7b2beec074838a.jpg', 'https://github.com/CodeTeng', '木子Teng的好友', '2024-03-01 15:33:45', '2024-03-01 15:34:26');

-- ----------------------------
-- Table structure for t_job
-- ----------------------------
DROP TABLE IF EXISTS `t_job`;
CREATE TABLE `t_job`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` tinyint(1) NULL DEFAULT 3 COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` tinyint(1) NULL DEFAULT 1 COMMENT '是否并发执行（0禁止 1允许）',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '状态（0暂停 1正常）',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '备注信息',
  PRIMARY KEY (`id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 86 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_job
-- ----------------------------
INSERT INTO `t_job` VALUES (81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '0 0,30 * * * ?', 3, 1, 1, '2022-08-11 21:49:27', '2022-08-13 08:49:47', '统计用户的地域分布');
INSERT INTO `t_job` VALUES (82, '统计访问量', '默认', 'auroraQuartz.saveUniqueView', '0 0 0 * * ?', 3, 1, 1, '2022-08-12 16:35:11', NULL, '向数据库中写入每天的访问量');
INSERT INTO `t_job` VALUES (83, '清空redis访客记录', '默认', 'auroraQuartz.clear', '0 0 1 * * ?', 3, 1, 1, '2022-08-12 16:36:30', '2022-08-13 08:47:48', '清空redis访客记录');
INSERT INTO `t_job` VALUES (84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '0 0/10 * * * ?', 3, 1, 1, '2022-08-13 21:19:08', '2022-08-19 14:13:52', '百度SEO');
INSERT INTO `t_job` VALUES (85, '清理定时任务日志', '默认', 'auroraQuartz.clearJobLogs', '0 0 0 * * ?', 3, 1, 1, '2022-08-13 21:26:21', NULL, '清理定时任务日志');

-- ----------------------------
-- Table structure for t_job_log
-- ----------------------------
DROP TABLE IF EXISTS `t_job_log`;
CREATE TABLE `t_job_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_id` int(0) NOT NULL COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` tinyint(1) NULL DEFAULT 0 COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime(0) NULL DEFAULT NULL COMMENT '创建时间',
  `start_time` datetime(0) NULL DEFAULT NULL COMMENT '开始时间',
  `end_time` datetime(0) NULL DEFAULT NULL COMMENT '结束时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6244 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_job_log
-- ----------------------------
INSERT INTO `t_job_log` VALUES (6175, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：28毫秒', 1, '', '2024-02-26 17:10:00', '2024-02-26 17:10:00', '2024-02-26 17:10:00');
INSERT INTO `t_job_log` VALUES (6176, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-02-26 17:20:00', '2024-02-26 17:20:00', '2024-02-26 17:20:00');
INSERT INTO `t_job_log` VALUES (6177, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：12毫秒', 1, '', '2024-02-26 17:30:00', '2024-02-26 17:30:00', '2024-02-26 17:30:00');
INSERT INTO `t_job_log` VALUES (6178, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：1052毫秒', 1, '', '2024-02-26 17:30:01', '2024-02-26 17:30:00', '2024-02-26 17:30:01');
INSERT INTO `t_job_log` VALUES (6179, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：60毫秒', 1, '', '2024-02-27 15:40:00', '2024-02-27 15:40:00', '2024-02-27 15:40:00');
INSERT INTO `t_job_log` VALUES (6180, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：7毫秒', 1, '', '2024-02-27 15:50:00', '2024-02-27 15:50:00', '2024-02-27 15:50:00');
INSERT INTO `t_job_log` VALUES (6181, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：26毫秒', 1, '', '2024-02-27 16:00:00', '2024-02-27 16:00:00', '2024-02-27 16:00:00');
INSERT INTO `t_job_log` VALUES (6182, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：885毫秒', 1, '', '2024-02-27 16:00:01', '2024-02-27 16:00:00', '2024-02-27 16:00:01');
INSERT INTO `t_job_log` VALUES (6183, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：13毫秒', 1, '', '2024-02-27 16:10:00', '2024-02-27 16:10:00', '2024-02-27 16:10:00');
INSERT INTO `t_job_log` VALUES (6184, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：7毫秒', 1, '', '2024-02-27 16:20:00', '2024-02-27 16:20:00', '2024-02-27 16:20:00');
INSERT INTO `t_job_log` VALUES (6185, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-02-27 16:30:00', '2024-02-27 16:30:00', '2024-02-27 16:30:00');
INSERT INTO `t_job_log` VALUES (6186, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：17毫秒', 1, '', '2024-02-27 16:30:00', '2024-02-27 16:30:00', '2024-02-27 16:30:00');
INSERT INTO `t_job_log` VALUES (6187, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：7毫秒', 1, '', '2024-02-27 16:40:00', '2024-02-27 16:40:00', '2024-02-27 16:40:00');
INSERT INTO `t_job_log` VALUES (6188, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：12毫秒', 1, '', '2024-02-27 16:50:00', '2024-02-27 16:50:00', '2024-02-27 16:50:00');
INSERT INTO `t_job_log` VALUES (6189, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：12毫秒', 1, '', '2024-02-27 17:00:00', '2024-02-27 17:00:00', '2024-02-27 17:00:00');
INSERT INTO `t_job_log` VALUES (6190, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：12毫秒', 1, '', '2024-02-27 17:00:00', '2024-02-27 17:00:00', '2024-02-27 17:00:00');
INSERT INTO `t_job_log` VALUES (6191, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：8毫秒', 1, '', '2024-02-27 17:10:00', '2024-02-27 17:10:00', '2024-02-27 17:10:00');
INSERT INTO `t_job_log` VALUES (6192, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：24毫秒', 1, '', '2024-02-28 16:40:00', '2024-02-28 16:40:00', '2024-02-28 16:40:00');
INSERT INTO `t_job_log` VALUES (6193, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：56毫秒', 1, '', '2024-02-29 15:20:00', '2024-02-29 15:20:00', '2024-02-29 15:20:00');
INSERT INTO `t_job_log` VALUES (6194, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：13毫秒', 1, '', '2024-02-29 15:30:00', '2024-02-29 15:30:00', '2024-02-29 15:30:00');
INSERT INTO `t_job_log` VALUES (6195, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：26毫秒', 1, '', '2024-02-29 15:30:00', '2024-02-29 15:30:00', '2024-02-29 15:30:00');
INSERT INTO `t_job_log` VALUES (6196, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：10毫秒', 1, '', '2024-02-29 15:40:00', '2024-02-29 15:40:00', '2024-02-29 15:40:00');
INSERT INTO `t_job_log` VALUES (6197, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：25毫秒', 1, '', '2024-03-01 12:00:00', '2024-03-01 12:00:00', '2024-03-01 12:00:00');
INSERT INTO `t_job_log` VALUES (6198, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：28毫秒', 1, '', '2024-03-01 12:00:00', '2024-03-01 12:00:00', '2024-03-01 12:00:00');
INSERT INTO `t_job_log` VALUES (6199, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：12毫秒', 1, '', '2024-03-01 12:10:00', '2024-03-01 12:10:00', '2024-03-01 12:10:00');
INSERT INTO `t_job_log` VALUES (6200, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：9毫秒', 1, '', '2024-03-01 12:20:00', '2024-03-01 12:20:00', '2024-03-01 12:20:00');
INSERT INTO `t_job_log` VALUES (6201, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-03-01 12:30:00', '2024-03-01 12:30:00', '2024-03-01 12:30:00');
INSERT INTO `t_job_log` VALUES (6202, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：10毫秒', 1, '', '2024-03-01 12:30:00', '2024-03-01 12:30:00', '2024-03-01 12:30:00');
INSERT INTO `t_job_log` VALUES (6203, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：13毫秒', 1, '', '2024-03-01 12:40:00', '2024-03-01 12:40:00', '2024-03-01 12:40:00');
INSERT INTO `t_job_log` VALUES (6204, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：9毫秒', 1, '', '2024-03-01 12:50:00', '2024-03-01 12:50:00', '2024-03-01 12:50:00');
INSERT INTO `t_job_log` VALUES (6205, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：7毫秒', 1, '', '2024-03-01 13:00:00', '2024-03-01 13:00:00', '2024-03-01 13:00:00');
INSERT INTO `t_job_log` VALUES (6206, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：21毫秒', 1, '', '2024-03-01 13:00:00', '2024-03-01 13:00:00', '2024-03-01 13:00:00');
INSERT INTO `t_job_log` VALUES (6207, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：21毫秒', 1, '', '2024-03-01 13:10:00', '2024-03-01 13:10:00', '2024-03-01 13:10:00');
INSERT INTO `t_job_log` VALUES (6208, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-03-01 13:20:00', '2024-03-01 13:20:00', '2024-03-01 13:20:00');
INSERT INTO `t_job_log` VALUES (6209, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：6毫秒', 1, '', '2024-03-01 13:30:00', '2024-03-01 13:30:00', '2024-03-01 13:30:00');
INSERT INTO `t_job_log` VALUES (6210, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：28毫秒', 1, '', '2024-03-01 13:30:00', '2024-03-01 13:30:00', '2024-03-01 13:30:00');
INSERT INTO `t_job_log` VALUES (6211, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-03-01 13:40:00', '2024-03-01 13:40:00', '2024-03-01 13:40:00');
INSERT INTO `t_job_log` VALUES (6212, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：19毫秒', 1, '', '2024-03-01 13:50:00', '2024-03-01 13:50:00', '2024-03-01 13:50:00');
INSERT INTO `t_job_log` VALUES (6213, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：11毫秒', 1, '', '2024-03-01 15:10:00', '2024-03-01 15:10:00', '2024-03-01 15:10:00');
INSERT INTO `t_job_log` VALUES (6214, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：5毫秒', 1, '', '2024-03-01 15:20:00', '2024-03-01 15:20:00', '2024-03-01 15:20:00');
INSERT INTO `t_job_log` VALUES (6215, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：18毫秒', 1, '', '2024-03-01 15:30:00', '2024-03-01 15:30:00', '2024-03-01 15:30:00');
INSERT INTO `t_job_log` VALUES (6216, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：217毫秒', 1, '', '2024-03-01 15:30:00', '2024-03-01 15:30:00', '2024-03-01 15:30:00');
INSERT INTO `t_job_log` VALUES (6217, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：170毫秒', 1, '', '2024-03-01 15:40:00', '2024-03-01 15:40:00', '2024-03-01 15:40:00');
INSERT INTO `t_job_log` VALUES (6218, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：13毫秒', 1, '', '2024-03-01 16:00:00', '2024-03-01 16:00:00', '2024-03-01 16:00:00');
INSERT INTO `t_job_log` VALUES (6219, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：235毫秒', 1, '', '2024-03-01 16:00:00', '2024-03-01 16:00:00', '2024-03-01 16:00:00');
INSERT INTO `t_job_log` VALUES (6220, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：258毫秒', 1, '', '2024-03-01 16:10:00', '2024-03-01 16:10:00', '2024-03-01 16:10:00');
INSERT INTO `t_job_log` VALUES (6221, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：126毫秒', 1, '', '2024-03-01 16:20:00', '2024-03-01 16:20:00', '2024-03-01 16:20:00');
INSERT INTO `t_job_log` VALUES (6222, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：26毫秒', 1, '', '2024-03-01 16:30:00', '2024-03-01 16:30:00', '2024-03-01 16:30:00');
INSERT INTO `t_job_log` VALUES (6223, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：129毫秒', 1, '', '2024-03-01 16:30:00', '2024-03-01 16:30:00', '2024-03-01 16:30:00');
INSERT INTO `t_job_log` VALUES (6224, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：189毫秒', 1, '', '2024-03-01 16:40:00', '2024-03-01 16:40:00', '2024-03-01 16:40:00');
INSERT INTO `t_job_log` VALUES (6225, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：186毫秒', 1, '', '2024-03-01 16:50:00', '2024-03-01 16:50:00', '2024-03-01 16:50:00');
INSERT INTO `t_job_log` VALUES (6226, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：16毫秒', 1, '', '2024-03-01 17:00:00', '2024-03-01 17:00:00', '2024-03-01 17:00:00');
INSERT INTO `t_job_log` VALUES (6227, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：222毫秒', 1, '', '2024-03-01 17:00:00', '2024-03-01 17:00:00', '2024-03-01 17:00:00');
INSERT INTO `t_job_log` VALUES (6228, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：233毫秒', 1, '', '2024-03-01 17:10:00', '2024-03-01 17:10:00', '2024-03-01 17:10:00');
INSERT INTO `t_job_log` VALUES (6229, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：116毫秒', 1, '', '2024-03-01 17:20:00', '2024-03-01 17:20:00', '2024-03-01 17:20:00');
INSERT INTO `t_job_log` VALUES (6230, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：14毫秒', 1, '', '2024-03-01 17:30:00', '2024-03-01 17:30:00', '2024-03-01 17:30:00');
INSERT INTO `t_job_log` VALUES (6231, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：584毫秒', 1, '', '2024-03-01 17:30:01', '2024-03-01 17:30:00', '2024-03-01 17:30:01');
INSERT INTO `t_job_log` VALUES (6232, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：937毫秒', 1, '', '2024-03-01 17:40:01', '2024-03-01 17:40:00', '2024-03-01 17:40:01');
INSERT INTO `t_job_log` VALUES (6233, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：133毫秒', 1, '', '2024-03-01 17:50:00', '2024-03-01 17:50:00', '2024-03-01 17:50:00');
INSERT INTO `t_job_log` VALUES (6234, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：7毫秒', 1, '', '2024-03-01 18:00:00', '2024-03-01 18:00:00', '2024-03-01 18:00:00');
INSERT INTO `t_job_log` VALUES (6235, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：136毫秒', 1, '', '2024-03-01 18:00:00', '2024-03-01 18:00:00', '2024-03-01 18:00:00');
INSERT INTO `t_job_log` VALUES (6236, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：145毫秒', 1, '', '2024-03-01 18:10:00', '2024-03-01 18:10:00', '2024-03-01 18:10:00');
INSERT INTO `t_job_log` VALUES (6237, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：169毫秒', 1, '', '2024-03-01 18:20:00', '2024-03-01 18:20:00', '2024-03-01 18:20:00');
INSERT INTO `t_job_log` VALUES (6238, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：8毫秒', 1, '', '2024-03-01 18:30:00', '2024-03-01 18:30:00', '2024-03-01 18:30:00');
INSERT INTO `t_job_log` VALUES (6239, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：130毫秒', 1, '', '2024-03-01 18:30:00', '2024-03-01 18:30:00', '2024-03-01 18:30:00');
INSERT INTO `t_job_log` VALUES (6240, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：292毫秒', 1, '', '2024-03-01 18:40:00', '2024-03-01 18:40:00', '2024-03-01 18:40:00');
INSERT INTO `t_job_log` VALUES (6241, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：183毫秒', 1, '', '2024-03-01 18:50:00', '2024-03-01 18:50:00', '2024-03-01 18:50:00');
INSERT INTO `t_job_log` VALUES (6242, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：9毫秒', 1, '', '2024-03-01 19:00:00', '2024-03-01 19:00:00', '2024-03-01 19:00:00');
INSERT INTO `t_job_log` VALUES (6243, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：156毫秒', 1, '', '2024-03-01 19:00:00', '2024-03-01 19:00:00', '2024-03-01 19:00:00');
INSERT INTO `t_job_log` VALUES (6244, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：316毫秒', 1, '', '2024-03-01 19:10:00', '2024-03-01 19:10:00', '2024-03-01 19:10:00');
INSERT INTO `t_job_log` VALUES (6245, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：247毫秒', 1, '', '2024-03-01 19:20:00', '2024-03-01 19:20:00', '2024-03-01 19:20:00');
INSERT INTO `t_job_log` VALUES (6246, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：27毫秒', 1, '', '2024-03-01 19:30:00', '2024-03-01 19:30:00', '2024-03-01 19:30:00');
INSERT INTO `t_job_log` VALUES (6247, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：156毫秒', 1, '', '2024-03-01 19:30:00', '2024-03-01 19:30:00', '2024-03-01 19:30:00');
INSERT INTO `t_job_log` VALUES (6248, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：190毫秒', 1, '', '2024-03-01 19:40:00', '2024-03-01 19:40:00', '2024-03-01 19:40:00');
INSERT INTO `t_job_log` VALUES (6249, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：176毫秒', 1, '', '2024-03-01 19:50:00', '2024-03-01 19:50:00', '2024-03-01 19:50:00');
INSERT INTO `t_job_log` VALUES (6250, 81, '统计用户地域分布', '默认', 'auroraQuartz.statisticalUserArea', '统计用户地域分布 总共耗时：13毫秒', 1, '', '2024-03-01 20:00:00', '2024-03-01 20:00:00', '2024-03-01 20:00:00');
INSERT INTO `t_job_log` VALUES (6251, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：209毫秒', 1, '', '2024-03-01 20:00:00', '2024-03-01 20:00:00', '2024-03-01 20:00:00');
INSERT INTO `t_job_log` VALUES (6252, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：193毫秒', 1, '', '2024-03-01 20:10:00', '2024-03-01 20:10:00', '2024-03-01 20:10:00');
INSERT INTO `t_job_log` VALUES (6253, 84, '百度SEO', '默认', 'auroraQuartz.baiduSeo', '百度SEO 总共耗时：278毫秒', 1, '', '2024-03-01 20:20:00', '2024-03-01 20:20:00', '2024-03-01 20:20:00');

-- ----------------------------
-- Table structure for t_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_menu`;
CREATE TABLE `t_menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名',
  `path` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单路径',
  `component` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '组件',
  `icon` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单icon',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `order_num` tinyint(1) NOT NULL COMMENT '排序',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父id',
  `is_hidden` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否隐藏  0否1是',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 226 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_menu
-- ----------------------------
INSERT INTO `t_menu` VALUES (1, '首页', '/', '/home/Home.vue', 'el-icon-myshouye', '2021-01-26 17:06:51', '2022-07-27 16:33:11', 1, NULL, 0);
INSERT INTO `t_menu` VALUES (2, '文章管理', '/article-submenu', 'Layout', 'el-icon-mywenzhang-copy', '2021-01-25 20:43:07', '2022-07-27 16:32:55', 2, NULL, 0);
INSERT INTO `t_menu` VALUES (3, '消息管理', '/message-submenu', 'Layout', 'el-icon-myxiaoxi', '2021-01-25 20:44:17', '2022-07-27 16:32:57', 3, NULL, 0);
INSERT INTO `t_menu` VALUES (4, '系统管理', '/system-submenu', 'Layout', 'el-icon-myshezhi', '2021-01-25 20:45:57', '2021-01-25 20:45:59', 5, NULL, 0);
INSERT INTO `t_menu` VALUES (5, '个人中心', '/setting', '/setting/Setting.vue', 'el-icon-myuser', '2021-01-26 17:22:38', '2021-01-26 17:22:41', 7, NULL, 0);
INSERT INTO `t_menu` VALUES (6, '发布文章', '/articles', '/article/Article.vue', 'el-icon-myfabiaowenzhang', '2021-01-26 14:30:48', '2021-01-26 14:30:51', 1, 2, 0);
INSERT INTO `t_menu` VALUES (7, '修改文章', '/articles/*', '/article/Article.vue', 'el-icon-myfabiaowenzhang', '2021-01-26 14:31:32', '2022-07-28 16:28:06', 2, 2, 1);
INSERT INTO `t_menu` VALUES (8, '文章列表', '/article-list', '/article/ArticleList.vue', 'el-icon-mywenzhangliebiao', '2021-01-26 14:32:13', '2021-01-26 14:32:16', 3, 2, 0);
INSERT INTO `t_menu` VALUES (9, '分类管理', '/categories', '/category/Category.vue', 'el-icon-myfenlei', '2021-01-26 14:33:42', '2021-01-26 14:33:43', 4, 2, 0);
INSERT INTO `t_menu` VALUES (10, '标签管理', '/tags', '/tag/Tag.vue', 'el-icon-myicontag', '2021-01-26 14:34:33', '2021-01-26 14:34:36', 5, 2, 0);
INSERT INTO `t_menu` VALUES (11, '评论管理', '/comments', '/comment/Comment.vue', 'el-icon-mypinglunzu', '2021-01-26 14:35:31', '2021-01-26 14:35:34', 1, 3, 0);
INSERT INTO `t_menu` VALUES (13, '用户列表', '/users', '/user/User.vue', 'el-icon-myyonghuliebiao', '2021-01-26 14:38:09', '2021-01-26 14:38:12', 1, 202, 0);
INSERT INTO `t_menu` VALUES (14, '角色管理', '/roles', '/role/Role.vue', 'el-icon-myjiaoseliebiao', '2021-01-26 14:39:01', '2021-01-26 14:39:03', 2, 213, 0);
INSERT INTO `t_menu` VALUES (15, '接口管理', '/resources', '/resource/Resource.vue', 'el-icon-myjiekouguanli', '2021-01-26 14:40:14', '2021-08-07 20:00:28', 2, 213, 0);
INSERT INTO `t_menu` VALUES (16, '菜单管理', '/menus', '/menu/Menu.vue', 'el-icon-mycaidan', '2021-01-26 14:40:54', '2021-08-07 10:18:49', 2, 213, 0);
INSERT INTO `t_menu` VALUES (17, '社交板块管理', '/links', '/friendLink/FriendLink.vue', 'el-icon-mydashujukeshihuaico-', '2021-01-26 14:41:35', '2024-03-01 16:14:16', 3, 4, 0);
INSERT INTO `t_menu` VALUES (18, '关于我', '/about', '/about/About.vue', 'el-icon-myguanyuwo', '2021-01-26 14:42:05', '2021-01-26 14:42:10', 4, 4, 0);
INSERT INTO `t_menu` VALUES (19, '日志管理', '/log-submenu', 'Layout', 'el-icon-myguanyuwo', '2021-01-31 21:33:56', '2021-01-31 21:33:59', 6, NULL, 0);
INSERT INTO `t_menu` VALUES (20, '操作日志', '/operation/log', '/log/OperationLog.vue', 'el-icon-myguanyuwo', '2021-01-31 15:53:21', '2022-07-28 10:51:28', 1, 19, 0);
INSERT INTO `t_menu` VALUES (201, '在线用户', '/online/users', '/user/Online.vue', 'el-icon-myyonghuliebiao', '2021-02-05 14:59:51', '2021-02-05 14:59:53', 7, 202, 0);
INSERT INTO `t_menu` VALUES (202, '用户管理', '/users-submenu', 'Layout', 'el-icon-myyonghuliebiao', '2021-02-06 23:44:59', '2022-07-27 16:32:59', 4, NULL, 0);
INSERT INTO `t_menu` VALUES (205, '相册管理', '/album-submenu', 'Layout', 'el-icon-myimage-fill', '2021-08-03 15:10:54', '2021-08-07 20:02:06', 5, NULL, 0);
INSERT INTO `t_menu` VALUES (206, '相册列表', '/albums', '/album/Album.vue', 'el-icon-myzhaopian', '2021-08-03 20:29:19', '2021-08-04 11:45:47', 1, 205, 0);
INSERT INTO `t_menu` VALUES (208, '照片管理', '/albums/:albumId', '/album/Photo.vue', 'el-icon-myzhaopian', '2021-08-03 21:37:47', '2021-08-05 10:24:08', 1, 205, 1);
INSERT INTO `t_menu` VALUES (209, '定时任务', '/quartz', '/quartz/Quartz.vue', 'el-icon-myyemianpeizhi', '2021-08-04 11:36:27', '2021-08-07 20:01:26', 2, 4, 0);
INSERT INTO `t_menu` VALUES (210, '照片回收站', '/photos/delete', '/album/Delete.vue', 'el-icon-myhuishouzhan', '2021-08-05 13:55:19', NULL, 3, 205, 1);
INSERT INTO `t_menu` VALUES (213, '权限管理', '/permission-submenu', 'Layout', 'el-icon-mydaohanglantubiao_quanxianguanli', '2021-08-07 19:56:55', '2021-08-07 19:59:40', 4, NULL, 0);
INSERT INTO `t_menu` VALUES (214, '网站管理', '/website', '/website/Website.vue', 'el-icon-myxitong', '2021-08-07 20:06:41', NULL, 1, 4, 0);
INSERT INTO `t_menu` VALUES (220, '定时任务日志', '/quartz/log/:quartzId', '/log/QuartzLog.vue', 'el-icon-myguanyuwo', '2022-07-28 10:53:23', '2022-08-05 10:27:47', 2, 19, 1);
INSERT INTO `t_menu` VALUES (221, '说说管理', '/talk-submenu', 'Layout', 'el-icon-mypinglun', '2022-08-15 17:27:10', '2022-08-15 17:27:39', 3, NULL, 0);
INSERT INTO `t_menu` VALUES (222, '说说列表', '/talk-list', '/talk/TalkList.vue', 'el-icon-myiconfontdongtaidianji', '2022-08-15 17:29:05', NULL, 1, 221, 0);
INSERT INTO `t_menu` VALUES (223, '发布说说', '/talks', '/talk/Talk.vue', 'el-icon-myfabusekuai', '2022-08-15 17:34:26', '2022-08-16 16:06:04', 2, 221, 0);
INSERT INTO `t_menu` VALUES (224, '修改说说', '/talks/:talkId', '/talk/Talk.vue', 'el-icon-myfabusekuai', '2022-08-16 16:06:59', '2022-08-16 16:08:21', 3, 221, 1);
INSERT INTO `t_menu` VALUES (225, '异常日志', '/exception/log', '/log/ExceptionLog.vue', 'el-icon-myguanyuwo', '2022-08-25 13:40:08', '2022-08-25 13:40:31', 1, 19, 0);

-- ----------------------------
-- Table structure for t_operation_log
-- ----------------------------
DROP TABLE IF EXISTS `t_operation_log`;
CREATE TABLE `t_operation_log`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `opt_module` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作模块',
  `opt_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作类型',
  `opt_uri` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作url',
  `opt_method` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作方法',
  `opt_desc` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作描述',
  `request_param` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求参数',
  `request_method` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '请求方式',
  `response_data` longtext CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '返回数据',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `ip_address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作ip',
  `ip_source` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '操作地址',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1785 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_operation_log
-- ----------------------------
INSERT INTO `t_operation_log` VALUES (1671, '用户信息模块', '修改', '/users/avatar', 'com.aurora.controller.UserInfoController.updateUserAvatar', '更新用户头像', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/avatar/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '用户1762399507569467394', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:09:52', NULL);
INSERT INTO `t_operation_log` VALUES (1672, '用户信息模块', '修改', '/users/info', 'com.aurora.controller.UserInfoController.updateUserInfo', '更新用户信息', '[{\"intro\":\"我是木子Teng\",\"nickname\":\"木子Teng\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '用户1762399507569467394', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:10:34', NULL);
INSERT INTO `t_operation_log` VALUES (1673, '用户信息模块', '修改', '/admin/users/role', 'com.aurora.controller.UserInfoController.updateUserRole', '修改用户角色', '[{\"nickname\":\"木子Teng\",\"roleIds\":[1,2],\"userInfoId\":1024}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '用户1762399507569467394', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:10:45', NULL);
INSERT INTO `t_operation_log` VALUES (1674, '用户信息模块', '修改', '/admin/users/disable', 'com.aurora.controller.UserInfoController.updateUserDisable', '修改用户禁用状态', '[{\"id\":1024,\"isDisable\":1}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '用户1762399507569467394', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:10:48', NULL);
INSERT INTO `t_operation_log` VALUES (1675, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:12:30', NULL);
INSERT INTO `t_operation_log` VALUES (1676, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"https://gitee.com/linhaojun\",\"github\":\"https://github.com/linhaojun857\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"https://static.linhaojun.top/config/cc36e9fa5aeb214e41495c1e2268f2db.png\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"https://static.linhaojun.top/config/2af2e2db20740e712f0a011a6f8c9af5.jpg\",\"twitter\":\"\",\"userAvatar\":\"https://static.linhaojun.top/config/0af1901da1e64dfb99bb61db21e716c4.jpeg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:13:11', NULL);
INSERT INTO `t_operation_log` VALUES (1677, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:14:33', NULL);
INSERT INTO `t_operation_log` VALUES (1678, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:16:11', NULL);
INSERT INTO `t_operation_log` VALUES (1679, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"https://gitee.com/linhaojun\",\"github\":\"https://github.com/linhaojun857\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"https://static.linhaojun.top/config/2af2e2db20740e712f0a011a6f8c9af5.jpg\",\"twitter\":\"\",\"userAvatar\":\"https://static.linhaojun.top/config/0af1901da1e64dfb99bb61db21e716c4.jpeg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:16:14', NULL);
INSERT INTO `t_operation_log` VALUES (1680, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"https://static.linhaojun.top/config/2af2e2db20740e712f0a011a6f8c9af5.jpg\",\"twitter\":\"\",\"userAvatar\":\"https://static.linhaojun.top/config/0af1901da1e64dfb99bb61db21e716c4.jpeg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:17:09', NULL);
INSERT INTO `t_operation_log` VALUES (1681, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:17:23', NULL);
INSERT INTO `t_operation_log` VALUES (1682, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:17:25', NULL);
INSERT INTO `t_operation_log` VALUES (1683, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:17:27', NULL);
INSERT INTO `t_operation_log` VALUES (1684, '用户信息模块', '修改', '/admin/users/role', 'com.aurora.controller.UserInfoController.updateUserRole', '修改用户角色', '[{\"nickname\":\"演示账号\",\"roleIds\":[1,14],\"userInfoId\":1}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:18:03', NULL);
INSERT INTO `t_operation_log` VALUES (1685, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"后端\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:20:37', NULL);
INSERT INTO `t_operation_log` VALUES (1686, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"前端\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:20:46', NULL);
INSERT INTO `t_operation_log` VALUES (1687, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"算法\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:20:53', NULL);
INSERT INTO `t_operation_log` VALUES (1688, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"测试\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:20:57', NULL);
INSERT INTO `t_operation_log` VALUES (1689, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"UI\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:01', NULL);
INSERT INTO `t_operation_log` VALUES (1690, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Java\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:07', NULL);
INSERT INTO `t_operation_log` VALUES (1691, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"VUE\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:11', NULL);
INSERT INTO `t_operation_log` VALUES (1692, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"MySQL\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:17', NULL);
INSERT INTO `t_operation_log` VALUES (1693, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Redis\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:22', NULL);
INSERT INTO `t_operation_log` VALUES (1694, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Python\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:27', NULL);
INSERT INTO `t_operation_log` VALUES (1695, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"C++\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:31', NULL);
INSERT INTO `t_operation_log` VALUES (1696, '文章模块', '上传', '/admin/articles/images', 'com.aurora.controller.ArticleController.saveArticleImages', '上传文章图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/3ed360913fbc09fe612c94333dbad8c9.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:21:54', NULL);
INSERT INTO `t_operation_log` VALUES (1697, '文章模块', '上传', '/admin/articles/images', 'com.aurora.controller.ArticleController.saveArticleImages', '上传文章图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/3ed360913fbc09fe612c94333dbad8c9.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:22:03', NULL);
INSERT INTO `t_operation_log` VALUES (1698, '文章模块', '新增或修改', '/admin/articles', 'com.aurora.controller.ArticleController.saveOrUpdateArticle', '保存和修改文章', '[{\"articleAbstract\":\"这是我的一篇文章\",\"articleContent\":\"123\",\"articleCover\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/3ed360913fbc09fe612c94333dbad8c9.jpg\",\"articleTitle\":\"2024-03-01\",\"categoryName\":\"后端\",\"isFeatured\":1,\"isTop\":1,\"status\":1,\"tagNames\":[],\"type\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:22:10', NULL);
INSERT INTO `t_operation_log` VALUES (1699, '评论模块', '新增', '/comments/save', 'com.aurora.controller.CommentController.saveComment', '添加评论', '[{\"commentContent\":\"写的很好\",\"topicId\":135,\"type\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:22:39', NULL);
INSERT INTO `t_operation_log` VALUES (1700, '评论模块', '新增', '/comments/save', 'com.aurora.controller.CommentController.saveComment', '添加评论', '[{\"commentContent\":\"你也不错\",\"parentId\":1032,\"replyUserId\":1024,\"topicId\":135,\"type\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:22:46', NULL);
INSERT INTO `t_operation_log` VALUES (1701, '文章模块', '新增或修改', '/admin/articles', 'com.aurora.controller.ArticleController.saveOrUpdateArticle', '保存和修改文章', '[{\"articleAbstract\":\"这是我的一篇文章\",\"articleContent\":\"123\",\"articleCover\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/3ed360913fbc09fe612c94333dbad8c9.jpg\",\"articleTitle\":\"2024-03-01\",\"categoryName\":\"后端\",\"id\":135,\"isFeatured\":1,\"isTop\":1,\"status\":1,\"tagNames\":[],\"type\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:23:06', NULL);
INSERT INTO `t_operation_log` VALUES (1702, '评论模块', '新增', '/comments/save', 'com.aurora.controller.CommentController.saveComment', '添加评论', '[{\"commentContent\":\"你好\",\"type\":2}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:31:09', NULL);
INSERT INTO `t_operation_log` VALUES (1703, '友链模块', '新增或修改', '/admin/links', 'com.aurora.controller.FriendLinkController.saveOrUpdateFriendLink', '保存或修改友链', '[{\"linkAddress\":\"https://github.com/CodeTeng\",\"linkAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/avatar/aa36bad4068f13992d7b2beec074838a.jpg\",\"linkIntro\":\"测试\",\"linkName\":\"测试\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:33:45', NULL);
INSERT INTO `t_operation_log` VALUES (1704, '友链模块', '新增或修改', '/admin/links', 'com.aurora.controller.FriendLinkController.saveOrUpdateFriendLink', '保存或修改友链', '[{\"id\":47,\"linkAddress\":\"https://github.com/CodeTeng\",\"linkAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/avatar/aa36bad4068f13992d7b2beec074838a.jpg\",\"linkIntro\":\"木子Teng的好友\",\"linkName\":\"我是测试好友\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:34:26', NULL);
INSERT INTO `t_operation_log` VALUES (1705, 'aurora信息', '修改', '/admin/about', 'com.aurora.controller.AuroraInfoController.updateAbout', '修改关于我信息', '[{\"content\":\"我就是我\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 15:35:26', NULL);
INSERT INTO `t_operation_log` VALUES (1706, '用户信息模块', '修改', '/admin/users/role', 'com.aurora.controller.UserInfoController.updateUserRole', '修改用户角色', '[{\"nickname\":\"演示账号\",\"roleIds\":[14,1,2],\"userInfoId\":1}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:00:05', NULL);
INSERT INTO `t_operation_log` VALUES (1707, '用户信息模块', '删除', '/admin/users/delete/1', 'com.aurora.controller.UserInfoController.deleteUserInfo', '删除用户角色', '[1]', 'DELETE', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:09:57', NULL);
INSERT INTO `t_operation_log` VALUES (1708, '菜单模块', '新增或修改', '/admin/menus', 'com.aurora.controller.MenuController.saveOrUpdateMenu', '新增或修改菜单', '[{\"component\":\"/friendLink/FriendLink.vue\",\"icon\":\"el-icon-mydashujukeshihuaico-\",\"id\":17,\"isHidden\":0,\"name\":\"社交板块管理\",\"orderNum\":3,\"path\":\"/links\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:14:16', NULL);
INSERT INTO `t_operation_log` VALUES (1709, '资源模块', '新增或修改', '/admin/resources', 'com.aurora.controller.ResourceController.saveOrUpdateResource', '新增或修改资源', '[{\"id\":1050,\"isAnonymous\":0,\"resourceName\":\"我的信息\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:16:59', NULL);
INSERT INTO `t_operation_log` VALUES (1710, '用户信息模块', '修改', '/users/subscribe', 'com.aurora.controller.UserInfoController.updateUserSubscribe', '修改用户的订阅状态', '[{\"isSubscribe\":1,\"userId\":1024}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:19:38', NULL);
INSERT INTO `t_operation_log` VALUES (1711, '用户信息模块', '修改', '/users/info', 'com.aurora.controller.UserInfoController.updateUserInfo', '更新用户信息', '[{\"intro\":\"我是木子Teng\",\"nickname\":\"木子Teng\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:19:39', NULL);
INSERT INTO `t_operation_log` VALUES (1712, '说说模块', '新增或修改', '/admin/talks', 'com.aurora.controller.TalkController.saveOrUpdateTalk', '保存或修改说说', '[{\"content\":\"123123123\",\"images\":\"\",\"isTop\":0,\"status\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:20:17', NULL);
INSERT INTO `t_operation_log` VALUES (1713, '用户信息模块', '修改', '/users/info', 'com.aurora.controller.UserInfoController.updateUserInfo', '更新用户信息', '[{\"intro\":\"我是木子Teng\",\"nickname\":\"木子Teng\",\"website\":\"https://github.com/CodeTeng\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:21:25', NULL);
INSERT INTO `t_operation_log` VALUES (1714, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:22:17', NULL);
INSERT INTO `t_operation_log` VALUES (1715, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"https://static.linhaojun.top/config/da4c6d8c13f66a8dd6716ddb48d73299.jpg\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"https://static.linhaojun.top/config/ed47edae605f74306f751c6fba9f14bd.png\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:22:31', NULL);
INSERT INTO `t_operation_log` VALUES (1716, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:22:50', NULL);
INSERT INTO `t_operation_log` VALUES (1717, 'aurora信息', '上传', '/admin/config/images', 'com.aurora.controller.AuroraInfoController.savePhotoAlbumCover', '上传博客配置图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:22:52', NULL);
INSERT INTO `t_operation_log` VALUES (1718, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:22:53', NULL);
INSERT INTO `t_operation_log` VALUES (1719, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"这是一条公告\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:23:09', NULL);
INSERT INTO `t_operation_log` VALUES (1720, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"这是一条公告\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:23:57', NULL);
INSERT INTO `t_operation_log` VALUES (1721, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"这是一条公告\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:28:41', NULL);
INSERT INTO `t_operation_log` VALUES (1722, 'aurora信息', '修改', '/admin/website/config', 'com.aurora.controller.AuroraInfoController.updateWebsiteConfig', '更新网站配置', '[{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"这是一条公告\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 16:28:57', NULL);
INSERT INTO `t_operation_log` VALUES (1723, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"MongoDB\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:39:56', NULL);
INSERT INTO `t_operation_log` VALUES (1724, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"ES\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:40:02', NULL);
INSERT INTO `t_operation_log` VALUES (1725, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"算法\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:40:09', NULL);
INSERT INTO `t_operation_log` VALUES (1726, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"MQ\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:40:15', NULL);
INSERT INTO `t_operation_log` VALUES (1727, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Docker\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:40:20', NULL);
INSERT INTO `t_operation_log` VALUES (1728, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"SpringBoot\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:40:41', NULL);
INSERT INTO `t_operation_log` VALUES (1729, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Spring\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:03', NULL);
INSERT INTO `t_operation_log` VALUES (1730, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"SpringMVC\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:09', NULL);
INSERT INTO `t_operation_log` VALUES (1731, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Mybatis\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:13', NULL);
INSERT INTO `t_operation_log` VALUES (1732, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"MybatisPlus\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:19', NULL);
INSERT INTO `t_operation_log` VALUES (1733, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"SpringSecurity\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:32', NULL);
INSERT INTO `t_operation_log` VALUES (1734, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"SpringCloud\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:42', NULL);
INSERT INTO `t_operation_log` VALUES (1735, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Linux\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:50', NULL);
INSERT INTO `t_operation_log` VALUES (1736, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Git\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:54', NULL);
INSERT INTO `t_operation_log` VALUES (1737, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Maven\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:41:58', NULL);
INSERT INTO `t_operation_log` VALUES (1738, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"id\":41,\"tagName\":\"JavaSE\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:11', NULL);
INSERT INTO `t_operation_log` VALUES (1739, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Dubbo\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:25', NULL);
INSERT INTO `t_operation_log` VALUES (1740, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"设计模式\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:34', NULL);
INSERT INTO `t_operation_log` VALUES (1741, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"数据结构\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:46', NULL);
INSERT INTO `t_operation_log` VALUES (1742, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"操作系统\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:50', NULL);
INSERT INTO `t_operation_log` VALUES (1743, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"计算机网络\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:42:56', NULL);
INSERT INTO `t_operation_log` VALUES (1744, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Nginx\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:09', NULL);
INSERT INTO `t_operation_log` VALUES (1745, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Shiro\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:22', NULL);
INSERT INTO `t_operation_log` VALUES (1746, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"分库分表\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:30', NULL);
INSERT INTO `t_operation_log` VALUES (1747, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"定时任务\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:39', NULL);
INSERT INTO `t_operation_log` VALUES (1748, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"JVM\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:48', NULL);
INSERT INTO `t_operation_log` VALUES (1749, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"JavaScript\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:43:57', NULL);
INSERT INTO `t_operation_log` VALUES (1750, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"TypeScript\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:44:07', NULL);
INSERT INTO `t_operation_log` VALUES (1751, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"运维\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:44:40', NULL);
INSERT INTO `t_operation_log` VALUES (1752, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"HTML5\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:45:12', NULL);
INSERT INTO `t_operation_log` VALUES (1753, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"CSS3\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:45:16', NULL);
INSERT INTO `t_operation_log` VALUES (1754, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"小程序\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:45:27', NULL);
INSERT INTO `t_operation_log` VALUES (1755, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"uni-app\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:45:35', NULL);
INSERT INTO `t_operation_log` VALUES (1756, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"数据分析\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:45:58', NULL);
INSERT INTO `t_operation_log` VALUES (1757, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"机器学习\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:46:02', NULL);
INSERT INTO `t_operation_log` VALUES (1758, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"深度学习\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:46:07', NULL);
INSERT INTO `t_operation_log` VALUES (1759, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"多线程\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:46:35', NULL);
INSERT INTO `t_operation_log` VALUES (1760, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"高并发\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:47:38', NULL);
INSERT INTO `t_operation_log` VALUES (1761, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Gradle\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:11', NULL);
INSERT INTO `t_operation_log` VALUES (1762, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Netty\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:19', NULL);
INSERT INTO `t_operation_log` VALUES (1763, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"系统设计\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:37', NULL);
INSERT INTO `t_operation_log` VALUES (1764, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"数据安全\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:45', NULL);
INSERT INTO `t_operation_log` VALUES (1765, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"认证授权\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:51', NULL);
INSERT INTO `t_operation_log` VALUES (1766, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"分布式\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:48:58', NULL);
INSERT INTO `t_operation_log` VALUES (1767, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"Zookper\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:49:07', NULL);
INSERT INTO `t_operation_log` VALUES (1768, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"高性能\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:49:21', NULL);
INSERT INTO `t_operation_log` VALUES (1769, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"高可用\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:49:25', NULL);
INSERT INTO `t_operation_log` VALUES (1770, '标签模块', '新增或修改', '/admin/tags', 'com.aurora.controller.TagController.saveOrUpdateTag', '添加或修改标签', '[{\"tagName\":\"RPC\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:49:34', NULL);
INSERT INTO `t_operation_log` VALUES (1771, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"Java\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:51:24', NULL);
INSERT INTO `t_operation_log` VALUES (1772, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"GoLang\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:51:31', NULL);
INSERT INTO `t_operation_log` VALUES (1773, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"Python\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:51:35', NULL);
INSERT INTO `t_operation_log` VALUES (1774, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"面试\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:51:41', NULL);
INSERT INTO `t_operation_log` VALUES (1775, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"计算机基础\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:52:05', NULL);
INSERT INTO `t_operation_log` VALUES (1776, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"运维\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:52:17', NULL);
INSERT INTO `t_operation_log` VALUES (1777, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"C++\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:52:26', NULL);
INSERT INTO `t_operation_log` VALUES (1778, '分类模块', '新增或修改', '/admin/categories', 'com.aurora.controller.CategoryController.saveOrUpdateCategory', '添加或修改分类', '[{\"categoryName\":\"嵌入式\"}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:52:36', NULL);
INSERT INTO `t_operation_log` VALUES (1779, '文章模块', '上传', '/admin/articles/images', 'com.aurora.controller.ArticleController.saveArticleImages', '上传文章图片', 'file', 'POST', '{\"code\":20000,\"data\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/a7799f18551353efd5aebb4d53be2cd7.jpg\",\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:56:28', NULL);
INSERT INTO `t_operation_log` VALUES (1780, '文章模块', '新增或修改', '/admin/articles', 'com.aurora.controller.ArticleController.saveOrUpdateArticle', '保存和修改文章', '[{\"articleAbstract\":\"一篇关于Java基础的文章\",\"articleContent\":\"# Java基础概念\\n\\n1. 简单易学；面向对象（封装，继承，多态）；\\n2. 平台无关性（ Java 虚拟机实现平台无关性）；\\n3. 支持多线程（ C++ 语言没有内置的多线程机制，因此必须调用操作系统的多线程功能来进行多线程程序设计，而 Java 语言却提供了多线程支持）；\\n4. 可靠性（具备异常处理和自动内存管理机制）；\\n5. 安全性（Java 语言本身的设计就提供了多重安全防护机制如访问权限修饰符、限制程序直接访问操作系统资源）；\\n6. 高效性（通过 Just In Time 编译器等技术的优化，Java 语言的运行效率还是非常不错的）；\\n7. 支持网络编程并且很方便；\\n8. 编译与解释并存；\\n9. ……\\n\\n🌈 拓展一下：\\n“Write Once, Run Anywhere（一次编写，随处运行）”这句宣传口号，真心经典，流传了好多年！以至于，直到今天，依然有很多人觉得跨平台是 Java 语言最大的优势。实际上，跨平台已经不是 Java 最大的卖点了，各种 JDK 新特性也不是。目前市面上虚拟化技术已经非常成熟，比如你通过 Docker 就很容易实现跨平台了。在我看来，Java 强大的生态才是！\\n\\n\\n\",\"articleCover\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/articles/a7799f18551353efd5aebb4d53be2cd7.jpg\",\"articleTitle\":\"2024-03-01\",\"categoryName\":\"Java\",\"isFeatured\":0,\"isTop\":0,\"status\":1,\"tagNames\":[],\"type\":1}]', 'POST', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:56:42', NULL);
INSERT INTO `t_operation_log` VALUES (1781, '文章模块', '修改', '/admin/articles/topAndFeatured', 'com.aurora.controller.ArticleController.updateArticleTopAndFeatured', '修改文章是否置顶和推荐', '[{\"id\":135,\"isFeatured\":1,\"isTop\":0}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:56:59', NULL);
INSERT INTO `t_operation_log` VALUES (1782, '文章模块', '修改', '/admin/articles/topAndFeatured', 'com.aurora.controller.ArticleController.updateArticleTopAndFeatured', '修改文章是否置顶和推荐', '[{\"id\":136,\"isFeatured\":1,\"isTop\":0}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:57:30', NULL);
INSERT INTO `t_operation_log` VALUES (1783, '文章模块', '修改', '/admin/articles/topAndFeatured', 'com.aurora.controller.ArticleController.updateArticleTopAndFeatured', '修改文章是否置顶和推荐', '[{\"id\":135,\"isFeatured\":0,\"isTop\":0}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:57:39', NULL);
INSERT INTO `t_operation_log` VALUES (1784, '文章模块', '修改', '/admin/articles/topAndFeatured', 'com.aurora.controller.ArticleController.updateArticleTopAndFeatured', '修改文章是否置顶和推荐', '[{\"id\":135,\"isFeatured\":1,\"isTop\":0}]', 'PUT', '{\"code\":20000,\"flag\":true,\"message\":\"操作成功\"}', 1014, '木子Teng', '127.0.0.1', '内网IP|内网IP', '2024-03-01 18:57:40', NULL);

-- ----------------------------
-- Table structure for t_photo
-- ----------------------------
DROP TABLE IF EXISTS `t_photo`;
CREATE TABLE `t_photo`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `album_id` int(0) NOT NULL COMMENT '相册id',
  `photo_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '照片名',
  `photo_desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '照片描述',
  `photo_src` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '照片地址',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 68 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '照片' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_photo
-- ----------------------------

-- ----------------------------
-- Table structure for t_photo_album
-- ----------------------------
DROP TABLE IF EXISTS `t_photo_album`;
CREATE TABLE `t_photo_album`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `album_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相册名',
  `album_desc` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相册描述',
  `album_cover` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '相册封面',
  `is_delete` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否删除',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态值 1公开 2私密',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '相册' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_photo_album
-- ----------------------------

-- ----------------------------
-- Table structure for t_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_resource`;
CREATE TABLE `t_resource`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `resource_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '资源名',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限路径',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '请求方式',
  `parent_id` int(0) NULL DEFAULT NULL COMMENT '父模块id',
  `is_anonymous` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否匿名访问 0否 1是',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '修改时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1189 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_resource
-- ----------------------------
INSERT INTO `t_resource` VALUES (1050, '我的信息', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', '2024-03-01 16:16:59');
INSERT INTO `t_resource` VALUES (1051, '分类模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1052, '友链模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1053, '定时任务日志模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1054, '定时任务模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1055, '异常处理模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1056, '操作日志模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1057, '文章模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1058, '标签模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1059, '照片模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1060, '用户信息模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1061, '用户账号模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1062, '相册模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1063, '菜单模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1064, '角色模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1065, '评论模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1066, '说说模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1067, '资源模块', NULL, NULL, NULL, 0, '2022-08-19 22:26:21', NULL);
INSERT INTO `t_resource` VALUES (1068, '获取系统信息', '/', 'GET', 1050, 1, '2022-08-19 22:26:22', '2022-08-19 22:26:55');
INSERT INTO `t_resource` VALUES (1069, '查看关于我信息', '/about', 'GET', 1050, 1, '2022-08-19 22:26:22', '2022-08-19 22:26:57');
INSERT INTO `t_resource` VALUES (1070, '获取系统后台信息', '/admin', 'GET', 1050, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1071, '修改关于我信息', '/admin/about', 'PUT', 1050, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1072, '获取后台文章', '/admin/articles', 'GET', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1073, '保存和修改文章', '/admin/articles', 'POST', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1074, '删除或者恢复文章', '/admin/articles', 'PUT', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1075, '物理删除文章', '/admin/articles/delete', 'DELETE', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1076, '导出文章', '/admin/articles/export', 'POST', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1077, '上传文章图片', '/admin/articles/images', 'POST', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1078, '导入文章', '/admin/articles/import', 'POST', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1079, '修改文章是否置顶和推荐', '/admin/articles/topAndFeatured', 'PUT', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1080, '根据id查看后台文章', '/admin/articles/*', 'GET', 1057, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1081, '查看后台分类列表', '/admin/categories', 'GET', 1051, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1082, '添加或修改分类', '/admin/categories', 'POST', 1051, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1083, '删除分类', '/admin/categories', 'DELETE', 1051, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1084, '搜索文章分类', '/admin/categories/search', 'GET', 1051, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1085, '查询后台评论', '/admin/comments', 'GET', 1065, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1086, '删除评论', '/admin/comments', 'DELETE', 1065, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1087, '审核评论', '/admin/comments/review', 'PUT', 1065, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1088, '上传博客配置图片', '/admin/config/images', 'POST', 1050, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1089, '获取定时任务的日志列表', '/admin/jobLogs', 'GET', 1053, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1090, '删除定时任务的日志', '/admin/jobLogs', 'DELETE', 1053, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1091, '清除定时任务的日志', '/admin/jobLogs/clean', 'DELETE', 1053, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1092, '获取定时任务日志的所有组名', '/admin/jobLogs/jobGroups', 'GET', 1053, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1093, '获取任务列表', '/admin/jobs', 'GET', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1094, '添加定时任务', '/admin/jobs', 'POST', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1095, '修改定时任务', '/admin/jobs', 'PUT', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1096, '删除定时任务', '/admin/jobs', 'DELETE', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1097, '获取所有job分组', '/admin/jobs/jobGroups', 'GET', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1098, '执行某个任务', '/admin/jobs/run', 'PUT', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1099, '更改任务的状态', '/admin/jobs/status', 'PUT', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1100, '根据id获取任务', '/admin/jobs/*', 'GET', 1054, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1101, '查看后台友链列表', '/admin/links', 'GET', 1052, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1102, '保存或修改友链', '/admin/links', 'POST', 1052, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1103, '删除友链', '/admin/links', 'DELETE', 1052, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1104, '查看菜单列表', '/admin/menus', 'GET', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1105, '新增或修改菜单', '/admin/menus', 'POST', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1106, '修改目录是否隐藏', '/admin/menus/isHidden', 'PUT', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1107, '删除菜单', '/admin/menus/*', 'DELETE', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1108, '查看操作日志', '/admin/operation/logs', 'GET', 1056, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1109, '删除操作日志', '/admin/operation/logs', 'DELETE', 1056, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1110, '根据相册id获取照片列表', '/admin/photos', 'GET', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1111, '保存照片', '/admin/photos', 'POST', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1112, '更新照片信息', '/admin/photos', 'PUT', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1113, '删除照片', '/admin/photos', 'DELETE', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1114, '移动照片相册', '/admin/photos/album', 'PUT', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1115, '查看后台相册列表', '/admin/photos/albums', 'GET', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1116, '保存或更新相册', '/admin/photos/albums', 'POST', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1117, '上传相册封面', '/admin/photos/albums/cover', 'POST', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1118, '获取后台相册列表信息', '/admin/photos/albums/info', 'GET', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1119, '根据id删除相册', '/admin/photos/albums/*', 'DELETE', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1120, '根据id获取后台相册信息', '/admin/photos/albums/*/info', 'GET', 1062, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1121, '更新照片删除状态', '/admin/photos/delete', 'PUT', 1059, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1122, '查看资源列表', '/admin/resources', 'GET', 1067, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1123, '新增或修改资源', '/admin/resources', 'POST', 1067, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1124, '删除资源', '/admin/resources/*', 'DELETE', 1067, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1125, '保存或更新角色', '/admin/role', 'POST', 1064, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1126, '查看角色菜单选项', '/admin/role/menus', 'GET', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1127, '查看角色资源选项', '/admin/role/resources', 'GET', 1067, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1128, '查询角色列表', '/admin/roles', 'GET', 1064, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1129, '删除角色', '/admin/roles', 'DELETE', 1064, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1130, '查询后台标签列表', '/admin/tags', 'GET', 1058, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1131, '添加或修改标签', '/admin/tags', 'POST', 1058, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1132, '删除标签', '/admin/tags', 'DELETE', 1058, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1133, '搜索文章标签', '/admin/tags/search', 'GET', 1058, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1134, '查看后台说说', '/admin/talks', 'GET', 1066, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1135, '保存或修改说说', '/admin/talks', 'POST', 1066, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1136, '删除说说', '/admin/talks', 'DELETE', 1066, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1137, '上传说说图片', '/admin/talks/images', 'POST', 1066, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1138, '根据id查看后台说说', '/admin/talks/*', 'GET', 1066, 1, '2022-08-19 22:26:22', '2022-08-19 22:33:52');
INSERT INTO `t_resource` VALUES (1139, '查看当前用户菜单', '/admin/user/menus', 'GET', 1063, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1140, '查询后台用户列表', '/admin/users', 'GET', 1061, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1141, '获取用户区域分布', '/admin/users/area', 'GET', 1061, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1142, '修改用户禁用状态', '/admin/users/disable', 'PUT', 1060, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1143, '查看在线用户', '/admin/users/online', 'GET', 1060, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1144, '修改管理员密码', '/admin/users/password', 'PUT', 1061, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1145, '查询用户角色选项', '/admin/users/role', 'GET', 1064, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1146, '修改用户角色', '/admin/users/role', 'PUT', 1060, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1147, '下线用户', '/admin/users/*/online', 'DELETE', 1060, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1148, '获取网站配置', '/admin/website/config', 'GET', 1050, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1149, '更新网站配置', '/admin/website/config', 'PUT', 1050, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1150, '根据相册id查看照片列表', '/albums/*/photos', 'GET', 1059, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:54');
INSERT INTO `t_resource` VALUES (1151, '获取所有文章归档', '/archives/all', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:35');
INSERT INTO `t_resource` VALUES (1152, '获取所有文章', '/articles/all', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:37');
INSERT INTO `t_resource` VALUES (1153, '根据分类id获取文章', '/articles/categoryId', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:38');
INSERT INTO `t_resource` VALUES (1154, '搜索文章', '/articles/search', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:40');
INSERT INTO `t_resource` VALUES (1155, '根据标签id获取文章', '/articles/tagId', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:40');
INSERT INTO `t_resource` VALUES (1156, '获取置顶和推荐文章', '/articles/topAndFeatured', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:41');
INSERT INTO `t_resource` VALUES (1157, '根据id获取文章', '/articles/*', 'GET', 1057, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:42');
INSERT INTO `t_resource` VALUES (1158, '/处理BizException', '/bizException', 'GET', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1159, '/处理BizException', '/bizException', 'HEAD', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1160, '/处理BizException', '/bizException', 'POST', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1161, '/处理BizException', '/bizException', 'PUT', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1162, '/处理BizException', '/bizException', 'DELETE', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1163, '/处理BizException', '/bizException', 'OPTIONS', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1164, '/处理BizException', '/bizException', 'PATCH', 1055, 0, '2022-08-19 22:26:22', NULL);
INSERT INTO `t_resource` VALUES (1165, '获取所有分类', '/categories/all', 'GET', 1051, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:05');
INSERT INTO `t_resource` VALUES (1166, '获取评论', '/comments', 'GET', 1065, 1, '2022-08-19 22:26:22', '2022-08-19 22:33:50');
INSERT INTO `t_resource` VALUES (1167, '添加评论', '/comments/save', 'POST', 1065, 0, '2022-08-19 22:26:22', '2022-08-19 22:33:47');
INSERT INTO `t_resource` VALUES (1168, '获取前七个评论', '/comments/topSeven', 'GET', 1065, 1, '2022-08-19 22:26:22', '2022-08-19 22:33:44');
INSERT INTO `t_resource` VALUES (1169, '查看友链列表', '/links', 'GET', 1052, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:13');
INSERT INTO `t_resource` VALUES (1170, '获取相册列表', '/photos/albums', 'GET', 1062, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:25');
INSERT INTO `t_resource` VALUES (1171, 'report', '/report', 'POST', 1050, 1, '2022-08-19 22:26:22', '2022-08-19 22:27:00');
INSERT INTO `t_resource` VALUES (1172, '获取所有标签', '/tags/all', 'GET', 1058, 1, '2022-08-19 22:26:22', '2022-08-19 22:31:23');
INSERT INTO `t_resource` VALUES (1173, '获取前十个标签', '/tags/topTen', 'GET', 1058, 1, '2022-08-19 22:26:22', '2022-08-19 22:31:27');
INSERT INTO `t_resource` VALUES (1174, '查看说说列表', '/talks', 'GET', 1066, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:38');
INSERT INTO `t_resource` VALUES (1175, '根据id查看说说', '/talks/*', 'GET', 1066, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:38');
INSERT INTO `t_resource` VALUES (1176, '更新用户头像', '/users/avatar', 'POST', 1060, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:05');
INSERT INTO `t_resource` VALUES (1177, '发送邮箱验证码', '/users/code', 'GET', 1061, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:15');
INSERT INTO `t_resource` VALUES (1178, '绑定用户邮箱', '/users/email', 'PUT', 1060, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:06');
INSERT INTO `t_resource` VALUES (1179, '更新用户信息', '/users/info', 'PUT', 1060, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:07');
INSERT INTO `t_resource` VALUES (1180, '根据id获取用户信息', '/users/info/*', 'GET', 1060, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:07');
INSERT INTO `t_resource` VALUES (1181, '用户登出', '/users/logout', 'POST', 1061, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:15');
INSERT INTO `t_resource` VALUES (1182, 'qq登录', '/users/oauth/qq', 'POST', 1061, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:16');
INSERT INTO `t_resource` VALUES (1183, '修改密码', '/users/password', 'PUT', 1061, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:18');
INSERT INTO `t_resource` VALUES (1184, '用户注册', '/users/register', 'POST', 1061, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:17');
INSERT INTO `t_resource` VALUES (1185, '修改用户的订阅状态', '/users/subscribe', 'PUT', 1060, 1, '2022-08-19 22:26:22', '2022-08-19 22:28:08');
INSERT INTO `t_resource` VALUES (1186, '异常日志模块', NULL, NULL, NULL, 0, '2022-08-25 15:13:40', NULL);
INSERT INTO `t_resource` VALUES (1187, '获取异常日志', '/admin/exception/logs', 'GET', 1186, 0, '2022-08-25 15:14:27', NULL);
INSERT INTO `t_resource` VALUES (1188, '删除异常日志', '/admin/exception/logs', 'DELETE', 1186, 0, '2022-08-25 15:14:59', NULL);

-- ----------------------------
-- Table structure for t_role
-- ----------------------------
DROP TABLE IF EXISTS `t_role`;
CREATE TABLE `t_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键id',
  `role_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名',
  `is_disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用  0否 1是',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 15 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role
-- ----------------------------
INSERT INTO `t_role` VALUES (1, 'admin', 0, '2022-07-20 13:25:19', '2022-08-16 16:07:49');
INSERT INTO `t_role` VALUES (2, 'user', 0, '2022-07-20 13:25:40', '2022-08-19 22:55:26');
INSERT INTO `t_role` VALUES (14, 'test', 0, '2022-08-19 21:48:14', '2022-08-19 22:38:15');

-- ----------------------------
-- Table structure for t_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `t_role_menu`;
CREATE TABLE `t_role_menu`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色id',
  `menu_id` int(0) NULL DEFAULT NULL COMMENT '菜单id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2886 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_menu
-- ----------------------------
INSERT INTO `t_role_menu` VALUES (2784, 1, 1);
INSERT INTO `t_role_menu` VALUES (2785, 1, 2);
INSERT INTO `t_role_menu` VALUES (2786, 1, 6);
INSERT INTO `t_role_menu` VALUES (2787, 1, 7);
INSERT INTO `t_role_menu` VALUES (2788, 1, 8);
INSERT INTO `t_role_menu` VALUES (2789, 1, 9);
INSERT INTO `t_role_menu` VALUES (2790, 1, 10);
INSERT INTO `t_role_menu` VALUES (2791, 1, 3);
INSERT INTO `t_role_menu` VALUES (2792, 1, 11);
INSERT INTO `t_role_menu` VALUES (2793, 1, 221);
INSERT INTO `t_role_menu` VALUES (2794, 1, 222);
INSERT INTO `t_role_menu` VALUES (2795, 1, 223);
INSERT INTO `t_role_menu` VALUES (2796, 1, 224);
INSERT INTO `t_role_menu` VALUES (2797, 1, 202);
INSERT INTO `t_role_menu` VALUES (2798, 1, 13);
INSERT INTO `t_role_menu` VALUES (2799, 1, 201);
INSERT INTO `t_role_menu` VALUES (2800, 1, 213);
INSERT INTO `t_role_menu` VALUES (2801, 1, 14);
INSERT INTO `t_role_menu` VALUES (2802, 1, 15);
INSERT INTO `t_role_menu` VALUES (2803, 1, 16);
INSERT INTO `t_role_menu` VALUES (2804, 1, 4);
INSERT INTO `t_role_menu` VALUES (2805, 1, 214);
INSERT INTO `t_role_menu` VALUES (2806, 1, 209);
INSERT INTO `t_role_menu` VALUES (2807, 1, 17);
INSERT INTO `t_role_menu` VALUES (2808, 1, 18);
INSERT INTO `t_role_menu` VALUES (2809, 1, 205);
INSERT INTO `t_role_menu` VALUES (2810, 1, 206);
INSERT INTO `t_role_menu` VALUES (2811, 1, 208);
INSERT INTO `t_role_menu` VALUES (2812, 1, 210);
INSERT INTO `t_role_menu` VALUES (2813, 1, 19);
INSERT INTO `t_role_menu` VALUES (2814, 1, 20);
INSERT INTO `t_role_menu` VALUES (2815, 1, 225);
INSERT INTO `t_role_menu` VALUES (2816, 1, 220);
INSERT INTO `t_role_menu` VALUES (2817, 1, 5);
INSERT INTO `t_role_menu` VALUES (2852, 14, 1);
INSERT INTO `t_role_menu` VALUES (2853, 14, 2);
INSERT INTO `t_role_menu` VALUES (2854, 14, 6);
INSERT INTO `t_role_menu` VALUES (2855, 14, 7);
INSERT INTO `t_role_menu` VALUES (2856, 14, 8);
INSERT INTO `t_role_menu` VALUES (2857, 14, 9);
INSERT INTO `t_role_menu` VALUES (2858, 14, 10);
INSERT INTO `t_role_menu` VALUES (2859, 14, 3);
INSERT INTO `t_role_menu` VALUES (2860, 14, 11);
INSERT INTO `t_role_menu` VALUES (2861, 14, 221);
INSERT INTO `t_role_menu` VALUES (2862, 14, 222);
INSERT INTO `t_role_menu` VALUES (2863, 14, 223);
INSERT INTO `t_role_menu` VALUES (2864, 14, 224);
INSERT INTO `t_role_menu` VALUES (2865, 14, 202);
INSERT INTO `t_role_menu` VALUES (2866, 14, 13);
INSERT INTO `t_role_menu` VALUES (2867, 14, 201);
INSERT INTO `t_role_menu` VALUES (2868, 14, 213);
INSERT INTO `t_role_menu` VALUES (2869, 14, 14);
INSERT INTO `t_role_menu` VALUES (2870, 14, 15);
INSERT INTO `t_role_menu` VALUES (2871, 14, 16);
INSERT INTO `t_role_menu` VALUES (2872, 14, 4);
INSERT INTO `t_role_menu` VALUES (2873, 14, 214);
INSERT INTO `t_role_menu` VALUES (2874, 14, 209);
INSERT INTO `t_role_menu` VALUES (2875, 14, 17);
INSERT INTO `t_role_menu` VALUES (2876, 14, 18);
INSERT INTO `t_role_menu` VALUES (2877, 14, 205);
INSERT INTO `t_role_menu` VALUES (2878, 14, 206);
INSERT INTO `t_role_menu` VALUES (2879, 14, 208);
INSERT INTO `t_role_menu` VALUES (2880, 14, 210);
INSERT INTO `t_role_menu` VALUES (2881, 14, 19);
INSERT INTO `t_role_menu` VALUES (2882, 14, 20);
INSERT INTO `t_role_menu` VALUES (2883, 14, 225);
INSERT INTO `t_role_menu` VALUES (2884, 14, 220);
INSERT INTO `t_role_menu` VALUES (2885, 14, 5);

-- ----------------------------
-- Table structure for t_role_resource
-- ----------------------------
DROP TABLE IF EXISTS `t_role_resource`;
CREATE TABLE `t_role_resource`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色id',
  `resource_id` int(0) NULL DEFAULT NULL COMMENT '权限id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5547 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_role_resource
-- ----------------------------
INSERT INTO `t_role_resource` VALUES (5406, 2, 1146);
INSERT INTO `t_role_resource` VALUES (5407, 2, 1167);
INSERT INTO `t_role_resource` VALUES (5408, 1, 1050);
INSERT INTO `t_role_resource` VALUES (5409, 1, 1070);
INSERT INTO `t_role_resource` VALUES (5410, 1, 1071);
INSERT INTO `t_role_resource` VALUES (5411, 1, 1088);
INSERT INTO `t_role_resource` VALUES (5412, 1, 1148);
INSERT INTO `t_role_resource` VALUES (5413, 1, 1149);
INSERT INTO `t_role_resource` VALUES (5414, 1, 1051);
INSERT INTO `t_role_resource` VALUES (5415, 1, 1081);
INSERT INTO `t_role_resource` VALUES (5416, 1, 1082);
INSERT INTO `t_role_resource` VALUES (5417, 1, 1083);
INSERT INTO `t_role_resource` VALUES (5418, 1, 1084);
INSERT INTO `t_role_resource` VALUES (5419, 1, 1052);
INSERT INTO `t_role_resource` VALUES (5420, 1, 1101);
INSERT INTO `t_role_resource` VALUES (5421, 1, 1102);
INSERT INTO `t_role_resource` VALUES (5422, 1, 1103);
INSERT INTO `t_role_resource` VALUES (5423, 1, 1053);
INSERT INTO `t_role_resource` VALUES (5424, 1, 1089);
INSERT INTO `t_role_resource` VALUES (5425, 1, 1090);
INSERT INTO `t_role_resource` VALUES (5426, 1, 1091);
INSERT INTO `t_role_resource` VALUES (5427, 1, 1092);
INSERT INTO `t_role_resource` VALUES (5428, 1, 1054);
INSERT INTO `t_role_resource` VALUES (5429, 1, 1093);
INSERT INTO `t_role_resource` VALUES (5430, 1, 1094);
INSERT INTO `t_role_resource` VALUES (5431, 1, 1095);
INSERT INTO `t_role_resource` VALUES (5432, 1, 1096);
INSERT INTO `t_role_resource` VALUES (5433, 1, 1097);
INSERT INTO `t_role_resource` VALUES (5434, 1, 1098);
INSERT INTO `t_role_resource` VALUES (5435, 1, 1099);
INSERT INTO `t_role_resource` VALUES (5436, 1, 1100);
INSERT INTO `t_role_resource` VALUES (5437, 1, 1055);
INSERT INTO `t_role_resource` VALUES (5438, 1, 1158);
INSERT INTO `t_role_resource` VALUES (5439, 1, 1159);
INSERT INTO `t_role_resource` VALUES (5440, 1, 1160);
INSERT INTO `t_role_resource` VALUES (5441, 1, 1161);
INSERT INTO `t_role_resource` VALUES (5442, 1, 1162);
INSERT INTO `t_role_resource` VALUES (5443, 1, 1163);
INSERT INTO `t_role_resource` VALUES (5444, 1, 1164);
INSERT INTO `t_role_resource` VALUES (5445, 1, 1056);
INSERT INTO `t_role_resource` VALUES (5446, 1, 1108);
INSERT INTO `t_role_resource` VALUES (5447, 1, 1109);
INSERT INTO `t_role_resource` VALUES (5448, 1, 1057);
INSERT INTO `t_role_resource` VALUES (5449, 1, 1072);
INSERT INTO `t_role_resource` VALUES (5450, 1, 1073);
INSERT INTO `t_role_resource` VALUES (5451, 1, 1074);
INSERT INTO `t_role_resource` VALUES (5452, 1, 1075);
INSERT INTO `t_role_resource` VALUES (5453, 1, 1076);
INSERT INTO `t_role_resource` VALUES (5454, 1, 1077);
INSERT INTO `t_role_resource` VALUES (5455, 1, 1078);
INSERT INTO `t_role_resource` VALUES (5456, 1, 1079);
INSERT INTO `t_role_resource` VALUES (5457, 1, 1080);
INSERT INTO `t_role_resource` VALUES (5458, 1, 1058);
INSERT INTO `t_role_resource` VALUES (5459, 1, 1130);
INSERT INTO `t_role_resource` VALUES (5460, 1, 1131);
INSERT INTO `t_role_resource` VALUES (5461, 1, 1132);
INSERT INTO `t_role_resource` VALUES (5462, 1, 1133);
INSERT INTO `t_role_resource` VALUES (5463, 1, 1059);
INSERT INTO `t_role_resource` VALUES (5464, 1, 1110);
INSERT INTO `t_role_resource` VALUES (5465, 1, 1111);
INSERT INTO `t_role_resource` VALUES (5466, 1, 1112);
INSERT INTO `t_role_resource` VALUES (5467, 1, 1113);
INSERT INTO `t_role_resource` VALUES (5468, 1, 1114);
INSERT INTO `t_role_resource` VALUES (5469, 1, 1121);
INSERT INTO `t_role_resource` VALUES (5470, 1, 1060);
INSERT INTO `t_role_resource` VALUES (5471, 1, 1142);
INSERT INTO `t_role_resource` VALUES (5472, 1, 1143);
INSERT INTO `t_role_resource` VALUES (5473, 1, 1146);
INSERT INTO `t_role_resource` VALUES (5474, 1, 1147);
INSERT INTO `t_role_resource` VALUES (5475, 1, 1061);
INSERT INTO `t_role_resource` VALUES (5476, 1, 1140);
INSERT INTO `t_role_resource` VALUES (5477, 1, 1141);
INSERT INTO `t_role_resource` VALUES (5478, 1, 1144);
INSERT INTO `t_role_resource` VALUES (5479, 1, 1062);
INSERT INTO `t_role_resource` VALUES (5480, 1, 1115);
INSERT INTO `t_role_resource` VALUES (5481, 1, 1116);
INSERT INTO `t_role_resource` VALUES (5482, 1, 1117);
INSERT INTO `t_role_resource` VALUES (5483, 1, 1118);
INSERT INTO `t_role_resource` VALUES (5484, 1, 1119);
INSERT INTO `t_role_resource` VALUES (5485, 1, 1120);
INSERT INTO `t_role_resource` VALUES (5486, 1, 1063);
INSERT INTO `t_role_resource` VALUES (5487, 1, 1104);
INSERT INTO `t_role_resource` VALUES (5488, 1, 1105);
INSERT INTO `t_role_resource` VALUES (5489, 1, 1106);
INSERT INTO `t_role_resource` VALUES (5490, 1, 1107);
INSERT INTO `t_role_resource` VALUES (5491, 1, 1126);
INSERT INTO `t_role_resource` VALUES (5492, 1, 1139);
INSERT INTO `t_role_resource` VALUES (5493, 1, 1064);
INSERT INTO `t_role_resource` VALUES (5494, 1, 1125);
INSERT INTO `t_role_resource` VALUES (5495, 1, 1128);
INSERT INTO `t_role_resource` VALUES (5496, 1, 1129);
INSERT INTO `t_role_resource` VALUES (5497, 1, 1145);
INSERT INTO `t_role_resource` VALUES (5498, 1, 1065);
INSERT INTO `t_role_resource` VALUES (5499, 1, 1085);
INSERT INTO `t_role_resource` VALUES (5500, 1, 1086);
INSERT INTO `t_role_resource` VALUES (5501, 1, 1087);
INSERT INTO `t_role_resource` VALUES (5502, 1, 1167);
INSERT INTO `t_role_resource` VALUES (5503, 1, 1066);
INSERT INTO `t_role_resource` VALUES (5504, 1, 1134);
INSERT INTO `t_role_resource` VALUES (5505, 1, 1135);
INSERT INTO `t_role_resource` VALUES (5506, 1, 1136);
INSERT INTO `t_role_resource` VALUES (5507, 1, 1137);
INSERT INTO `t_role_resource` VALUES (5508, 1, 1067);
INSERT INTO `t_role_resource` VALUES (5509, 1, 1122);
INSERT INTO `t_role_resource` VALUES (5510, 1, 1123);
INSERT INTO `t_role_resource` VALUES (5511, 1, 1124);
INSERT INTO `t_role_resource` VALUES (5512, 1, 1127);
INSERT INTO `t_role_resource` VALUES (5513, 1, 1186);
INSERT INTO `t_role_resource` VALUES (5514, 1, 1187);
INSERT INTO `t_role_resource` VALUES (5515, 1, 1188);
INSERT INTO `t_role_resource` VALUES (5516, 14, 1070);
INSERT INTO `t_role_resource` VALUES (5517, 14, 1148);
INSERT INTO `t_role_resource` VALUES (5518, 14, 1081);
INSERT INTO `t_role_resource` VALUES (5519, 14, 1084);
INSERT INTO `t_role_resource` VALUES (5520, 14, 1101);
INSERT INTO `t_role_resource` VALUES (5521, 14, 1089);
INSERT INTO `t_role_resource` VALUES (5522, 14, 1092);
INSERT INTO `t_role_resource` VALUES (5523, 14, 1093);
INSERT INTO `t_role_resource` VALUES (5524, 14, 1097);
INSERT INTO `t_role_resource` VALUES (5525, 14, 1100);
INSERT INTO `t_role_resource` VALUES (5526, 14, 1108);
INSERT INTO `t_role_resource` VALUES (5527, 14, 1072);
INSERT INTO `t_role_resource` VALUES (5528, 14, 1080);
INSERT INTO `t_role_resource` VALUES (5529, 14, 1130);
INSERT INTO `t_role_resource` VALUES (5530, 14, 1133);
INSERT INTO `t_role_resource` VALUES (5531, 14, 1110);
INSERT INTO `t_role_resource` VALUES (5532, 14, 1143);
INSERT INTO `t_role_resource` VALUES (5533, 14, 1140);
INSERT INTO `t_role_resource` VALUES (5534, 14, 1141);
INSERT INTO `t_role_resource` VALUES (5535, 14, 1115);
INSERT INTO `t_role_resource` VALUES (5536, 14, 1118);
INSERT INTO `t_role_resource` VALUES (5537, 14, 1104);
INSERT INTO `t_role_resource` VALUES (5538, 14, 1126);
INSERT INTO `t_role_resource` VALUES (5539, 14, 1139);
INSERT INTO `t_role_resource` VALUES (5540, 14, 1128);
INSERT INTO `t_role_resource` VALUES (5541, 14, 1145);
INSERT INTO `t_role_resource` VALUES (5542, 14, 1085);
INSERT INTO `t_role_resource` VALUES (5543, 14, 1134);
INSERT INTO `t_role_resource` VALUES (5544, 14, 1122);
INSERT INTO `t_role_resource` VALUES (5545, 14, 1127);
INSERT INTO `t_role_resource` VALUES (5546, 14, 1187);

-- ----------------------------
-- Table structure for t_tag
-- ----------------------------
DROP TABLE IF EXISTS `t_tag`;
CREATE TABLE `t_tag`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `tag_name` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标签名',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 94 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_tag
-- ----------------------------
INSERT INTO `t_tag` VALUES (41, 'JavaSE', '2024-03-01 15:21:07', '2024-03-01 18:42:11');
INSERT INTO `t_tag` VALUES (42, 'VUE', '2024-03-01 15:21:11', NULL);
INSERT INTO `t_tag` VALUES (43, 'MySQL', '2024-03-01 15:21:17', NULL);
INSERT INTO `t_tag` VALUES (44, 'Redis', '2024-03-01 15:21:22', NULL);
INSERT INTO `t_tag` VALUES (45, 'Python', '2024-03-01 15:21:27', NULL);
INSERT INTO `t_tag` VALUES (46, 'C++', '2024-03-01 15:21:31', NULL);
INSERT INTO `t_tag` VALUES (47, 'MongoDB', '2024-03-01 18:39:56', NULL);
INSERT INTO `t_tag` VALUES (48, 'ES', '2024-03-01 18:40:02', NULL);
INSERT INTO `t_tag` VALUES (49, '算法', '2024-03-01 18:40:09', NULL);
INSERT INTO `t_tag` VALUES (50, 'MQ', '2024-03-01 18:40:15', NULL);
INSERT INTO `t_tag` VALUES (51, 'Docker', '2024-03-01 18:40:20', NULL);
INSERT INTO `t_tag` VALUES (52, 'SpringBoot', '2024-03-01 18:40:41', NULL);
INSERT INTO `t_tag` VALUES (53, 'Spring', '2024-03-01 18:41:03', NULL);
INSERT INTO `t_tag` VALUES (54, 'SpringMVC', '2024-03-01 18:41:09', NULL);
INSERT INTO `t_tag` VALUES (55, 'Mybatis', '2024-03-01 18:41:13', NULL);
INSERT INTO `t_tag` VALUES (56, 'MybatisPlus', '2024-03-01 18:41:19', NULL);
INSERT INTO `t_tag` VALUES (57, 'SpringSecurity', '2024-03-01 18:41:32', NULL);
INSERT INTO `t_tag` VALUES (58, 'SpringCloud', '2024-03-01 18:41:42', NULL);
INSERT INTO `t_tag` VALUES (59, 'Linux', '2024-03-01 18:41:50', NULL);
INSERT INTO `t_tag` VALUES (60, 'Git', '2024-03-01 18:41:54', NULL);
INSERT INTO `t_tag` VALUES (61, 'Maven', '2024-03-01 18:41:58', NULL);
INSERT INTO `t_tag` VALUES (62, 'Dubbo', '2024-03-01 18:42:25', NULL);
INSERT INTO `t_tag` VALUES (63, '设计模式', '2024-03-01 18:42:34', NULL);
INSERT INTO `t_tag` VALUES (64, '数据结构', '2024-03-01 18:42:46', NULL);
INSERT INTO `t_tag` VALUES (65, '操作系统', '2024-03-01 18:42:50', NULL);
INSERT INTO `t_tag` VALUES (66, '计算机网络', '2024-03-01 18:42:56', NULL);
INSERT INTO `t_tag` VALUES (67, 'Nginx', '2024-03-01 18:43:09', NULL);
INSERT INTO `t_tag` VALUES (68, 'Shiro', '2024-03-01 18:43:22', NULL);
INSERT INTO `t_tag` VALUES (69, '分库分表', '2024-03-01 18:43:30', NULL);
INSERT INTO `t_tag` VALUES (70, '定时任务', '2024-03-01 18:43:39', NULL);
INSERT INTO `t_tag` VALUES (71, 'JVM', '2024-03-01 18:43:48', NULL);
INSERT INTO `t_tag` VALUES (72, 'JavaScript', '2024-03-01 18:43:57', NULL);
INSERT INTO `t_tag` VALUES (73, 'TypeScript', '2024-03-01 18:44:07', NULL);
INSERT INTO `t_tag` VALUES (74, '运维', '2024-03-01 18:44:40', NULL);
INSERT INTO `t_tag` VALUES (75, 'HTML5', '2024-03-01 18:45:12', NULL);
INSERT INTO `t_tag` VALUES (76, 'CSS3', '2024-03-01 18:45:16', NULL);
INSERT INTO `t_tag` VALUES (77, '小程序', '2024-03-01 18:45:27', NULL);
INSERT INTO `t_tag` VALUES (78, 'uni-app', '2024-03-01 18:45:35', NULL);
INSERT INTO `t_tag` VALUES (79, '数据分析', '2024-03-01 18:45:58', NULL);
INSERT INTO `t_tag` VALUES (80, '机器学习', '2024-03-01 18:46:02', NULL);
INSERT INTO `t_tag` VALUES (81, '深度学习', '2024-03-01 18:46:07', NULL);
INSERT INTO `t_tag` VALUES (82, '多线程', '2024-03-01 18:46:35', NULL);
INSERT INTO `t_tag` VALUES (83, '高并发', '2024-03-01 18:47:38', NULL);
INSERT INTO `t_tag` VALUES (84, 'Gradle', '2024-03-01 18:48:11', NULL);
INSERT INTO `t_tag` VALUES (85, 'Netty', '2024-03-01 18:48:19', NULL);
INSERT INTO `t_tag` VALUES (86, '系统设计', '2024-03-01 18:48:37', NULL);
INSERT INTO `t_tag` VALUES (87, '数据安全', '2024-03-01 18:48:45', NULL);
INSERT INTO `t_tag` VALUES (88, '认证授权', '2024-03-01 18:48:51', NULL);
INSERT INTO `t_tag` VALUES (89, '分布式', '2024-03-01 18:48:58', NULL);
INSERT INTO `t_tag` VALUES (90, 'Zookper', '2024-03-01 18:49:07', NULL);
INSERT INTO `t_tag` VALUES (91, '高性能', '2024-03-01 18:49:21', NULL);
INSERT INTO `t_tag` VALUES (92, '高可用', '2024-03-01 18:49:25', NULL);
INSERT INTO `t_tag` VALUES (93, 'RPC', '2024-03-01 18:49:34', NULL);

-- ----------------------------
-- Table structure for t_talk
-- ----------------------------
DROP TABLE IF EXISTS `t_talk`;
CREATE TABLE `t_talk`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '说说id',
  `user_id` int(0) NOT NULL COMMENT '用户id',
  `content` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '说说内容',
  `images` varchar(2500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图片',
  `is_top` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否置顶',
  `status` tinyint(1) NOT NULL DEFAULT 1 COMMENT '状态 1.公开 2.私密',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 69 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_talk
-- ----------------------------
INSERT INTO `t_talk` VALUES (68, 1024, '123123123', '', 0, 1, '2024-03-01 16:20:17', NULL);

-- ----------------------------
-- Table structure for t_unique_view
-- ----------------------------
DROP TABLE IF EXISTS `t_unique_view`;
CREATE TABLE `t_unique_view`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `views_count` int(0) NOT NULL COMMENT '访问量',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1539 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_unique_view
-- ----------------------------

-- ----------------------------
-- Table structure for t_user_auth
-- ----------------------------
DROP TABLE IF EXISTS `t_user_auth`;
CREATE TABLE `t_user_auth`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_info_id` int(0) NOT NULL COMMENT '用户信息id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `login_type` tinyint(1) NOT NULL COMMENT '登录类型',
  `ip_address` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户登录ip',
  `ip_source` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'ip来源',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  `last_login_time` datetime(0) NULL DEFAULT NULL COMMENT '上次登录时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `username`(`username`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1015 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_auth
-- ----------------------------
INSERT INTO `t_user_auth` VALUES (1014, 1024, 'teng2002823@163.com', '$2a$10$C0ShvWT.7kVRKiVT8CzOO.pa1rZiirb0Tg9RoLM12C.29jK0x9mdW', 1, '127.0.0.1', '内网IP|内网IP', '2024-02-27 16:49:21', '2024-03-01 16:33:33', '2024-03-01 16:33:33');

-- ----------------------------
-- Table structure for t_user_info
-- ----------------------------
DROP TABLE IF EXISTS `t_user_info`;
CREATE TABLE `t_user_info`  (
  `id` int(0) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱号',
  `nickname` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_age` tinyint(0) UNSIGNED NULL DEFAULT NULL COMMENT '用户年龄',
  `user_gender` tinyint(1) NOT NULL DEFAULT 0 COMMENT '用户性别 0-男生 1-女生',
  `user_visited` bigint(0) NOT NULL DEFAULT 0 COMMENT '用户访问次数',
  `avatar` varchar(1024) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '用户头像',
  `intro` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户简介',
  `website` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '个人网站',
  `is_subscribe` tinyint(1) NULL DEFAULT NULL COMMENT '是否订阅',
  `is_disable` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否禁用',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1025 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_info
-- ----------------------------
INSERT INTO `t_user_info` VALUES (1024, 'teng2002823@163.com', '木子Teng', 22, 0, 0, 'http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/avatar/aa36bad4068f13992d7b2beec074838a.jpg', '我是木子Teng', 'https://github.com/CodeTeng', 1, 0, '2024-02-27 16:49:21', '2024-03-01 16:21:25');

-- ----------------------------
-- Table structure for t_user_role
-- ----------------------------
DROP TABLE IF EXISTS `t_user_role`;
CREATE TABLE `t_user_role`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `user_id` int(0) NULL DEFAULT NULL COMMENT '用户id',
  `role_id` int(0) NULL DEFAULT NULL COMMENT '角色id',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1040 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_user_role
-- ----------------------------
INSERT INTO `t_user_role` VALUES (1033, 1024, 1);
INSERT INTO `t_user_role` VALUES (1034, 1024, 2);

-- ----------------------------
-- Table structure for t_website_config
-- ----------------------------
DROP TABLE IF EXISTS `t_website_config`;
CREATE TABLE `t_website_config`  (
  `id` int(0) NOT NULL AUTO_INCREMENT,
  `config` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '配置信息',
  `create_time` datetime(0) NOT NULL COMMENT '创建时间',
  `update_time` datetime(0) NULL DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of t_website_config
-- ----------------------------
INSERT INTO `t_website_config` VALUES (1, '{\"alipayQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/e222f8f74736488de2596a995c05dc93.png\",\"author\":\"木子Teng\",\"authorAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"authorIntro\":\"我是木子Teng\",\"beianNumber\":\"\",\"csdn\":\"\",\"englishName\":\"CodeTeng\",\"gitee\":\"\",\"github\":\"https://github.com/CodeTeng\",\"isCommentReview\":0,\"isEmailNotice\":1,\"isReward\":1,\"juejin\":\"\",\"logo\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"multiLanguage\":1,\"name\":\"轻博客团队\",\"notice\":\"这是一条公告\",\"qq\":\"2300858713@qq.com\",\"qqLogin\":1,\"stackoverflow\":\"\",\"touristAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"twitter\":\"\",\"userAvatar\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weChat\":\"\",\"websiteCreateTime\":\"2024-03-01\",\"weiXinQRCode\":\"http://my-bucket0823.oss-cn-beijing.aliyuncs.com/aurora/config/aa36bad4068f13992d7b2beec074838a.jpg\",\"weibo\":\"\",\"zhihu\":\"\"}', '2022-07-24 12:05:33', '2024-03-01 16:28:57');

SET FOREIGN_KEY_CHECKS = 1;
