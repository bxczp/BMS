/*
Navicat MySQL Data Transfer

Source Server         : fnst_bms
Source Server Version : 50716
Source Host           : 10.167.221.47:3306
Source Database       : fnst_bms

Target Server Type    : MYSQL
Target Server Version : 50716
File Encoding         : 65001

Date: 2017-08-22 13:40:08
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for bug_feedback
-- ----------------------------
DROP TABLE IF EXISTS `bug_feedback`;
CREATE TABLE `bug_feedback` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) DEFAULT NULL COMMENT '用户id',
  `bug_id` int(11) DEFAULT NULL COMMENT '关联bug_id的外键关联',
  `note_description` text COMMENT 'bug反馈描述',
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  `note_code` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `bug_fk` (`bug_id`),
  CONSTRAINT `bug_fk` FOREIGN KEY (`bug_id`) REFERENCES `bug_info` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=55 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bug_feedback
-- ----------------------------
INSERT INTO `bug_feedback` VALUES ('37', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/50.gif\" alt=\"[熊猫]\">  \n\n                                     ', '2017-08-16 09:53:00', '2017-08-16 09:53:00', '0000037');
INSERT INTO `bug_feedback` VALUES ('38', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/48.gif\" alt=\"[伤心]\">  \n\n                                     ', '2017-08-16 09:59:19', '2017-08-16 09:59:19', '0000038');
INSERT INTO `bug_feedback` VALUES ('39', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/51.gif\" alt=\"[兔子]\">  \n\n                                     ', '2017-08-16 10:02:32', '2017-08-16 10:02:32', '0000039');
INSERT INTO `bug_feedback` VALUES ('40', '1', '86', 'AA', '2017-08-16 10:04:46', '2017-08-16 10:04:46', '0000040');
INSERT INTO `bug_feedback` VALUES ('41', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/29.gif\" alt=\"[拜拜]\">  \n\n                                     ', '2017-08-16 10:07:25', '2017-08-16 10:07:25', '0000041');
INSERT INTO `bug_feedback` VALUES ('42', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/68.gif\" alt=\"[钟]\">  \n\n                                     ', '2017-08-16 10:08:39', '2017-08-16 10:08:39', '0000042');
INSERT INTO `bug_feedback` VALUES ('43', '1', '86', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/27.gif\" alt=\"[疑问]\">  \n\n                                     ', '2017-08-16 10:16:33', '2017-08-16 10:16:33', '0000043');
INSERT INTO `bug_feedback` VALUES ('45', '1', '86', '  \n\n                                     ', '2017-08-16 10:37:18', '2017-08-16 10:37:18', '0000045');
INSERT INTO `bug_feedback` VALUES ('46', '1', '86', '地方很多', '2017-08-16 10:37:58', '2017-08-16 10:37:58', '0000046');
INSERT INTO `bug_feedback` VALUES ('51', '1', '96', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/26.gif\" alt=\"[怒]\">  \n\n                                     ', '2017-08-16 12:57:34', '2017-08-16 12:57:34', '0000049');
INSERT INTO `bug_feedback` VALUES ('52', '1', '96', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/55.gif\" alt=\"[NO]\">  \n\n                                     ', '2017-08-16 12:57:48', '2017-08-16 12:57:48', '0000052');
INSERT INTO `bug_feedback` VALUES ('54', '1', '103', 'AA', '2017-08-21 09:15:16', '2017-08-21 09:15:16', '0000053');

-- ----------------------------
-- Table structure for bug_feedback_changelog
-- ----------------------------
DROP TABLE IF EXISTS `bug_feedback_changelog`;
CREATE TABLE `bug_feedback_changelog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `bug_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `change_content` varchar(255) DEFAULT NULL,
  `change_type` varchar(255) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  `update_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_bug` (`bug_id`),
  KEY `fk_user` (`user_id`),
  CONSTRAINT `fk_bug` FOREIGN KEY (`bug_id`) REFERENCES `bug_info` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=117 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bug_feedback_changelog
-- ----------------------------
INSERT INTO `bug_feedback_changelog` VALUES ('85', '86', '1', '已分派 =>> 已解决', '状态变更', '2017-08-16 09:53:00', '2017-08-16 09:53:00');
INSERT INTO `bug_feedback_changelog` VALUES ('86', '86', '1', '', '添加调查注释', '2017-08-16 09:53:00', '2017-08-16 09:53:00');
INSERT INTO `bug_feedback_changelog` VALUES ('87', '86', '1', 'liuxw.jy =>> 邵婷婷', '分配给', '2017-08-16 09:59:19', '2017-08-16 09:59:19');
INSERT INTO `bug_feedback_changelog` VALUES ('88', '86', '1', '', '添加调查注释', '2017-08-16 09:59:19', '2017-08-16 09:59:19');
INSERT INTO `bug_feedback_changelog` VALUES ('89', '86', '1', '已分派 =>> 已解决', '状态变更', '2017-08-16 10:02:32', '2017-08-16 10:02:32');
INSERT INTO `bug_feedback_changelog` VALUES ('90', '86', '1', '', '添加调查注释', '2017-08-16 10:02:32', '2017-08-16 10:02:32');
INSERT INTO `bug_feedback_changelog` VALUES ('91', '86', '1', '已分派 =>> 已关闭', '状态变更', '2017-08-16 10:04:46', '2017-08-16 10:04:46');
INSERT INTO `bug_feedback_changelog` VALUES ('92', '86', '1', '', '添加调查注释', '2017-08-16 10:04:46', '2017-08-16 10:04:46');
INSERT INTO `bug_feedback_changelog` VALUES ('93', '86', '1', '已关闭 =>> 已确认', '状态变更', '2017-08-16 10:07:25', '2017-08-16 10:07:25');
INSERT INTO `bug_feedback_changelog` VALUES ('94', '86', '1', '', '添加调查注释', '2017-08-16 10:07:25', '2017-08-16 10:07:25');
INSERT INTO `bug_feedback_changelog` VALUES ('95', '86', '1', 'liuxw.jy =>> 邵婷婷', '分配给', '2017-08-16 10:08:39', '2017-08-16 10:08:39');
INSERT INTO `bug_feedback_changelog` VALUES ('96', '86', '1', '已关闭 =>> 已确认', '状态变更', '2017-08-16 10:08:39', '2017-08-16 10:08:39');
INSERT INTO `bug_feedback_changelog` VALUES ('97', '86', '1', '', '添加调查注释', '2017-08-16 10:08:39', '2017-08-16 10:08:39');
INSERT INTO `bug_feedback_changelog` VALUES ('98', '86', '1', '邵婷婷 =>> 承志鹏', '分配给', '2017-08-16 10:16:33', '2017-08-16 10:16:33');
INSERT INTO `bug_feedback_changelog` VALUES ('99', '86', '1', '', '添加调查注释', '2017-08-16 10:16:33', '2017-08-16 10:16:33');
INSERT INTO `bug_feedback_changelog` VALUES ('102', '86', '1', '已确认 =>> 已分派', '状态变更', '2017-08-16 10:37:18', '2017-08-16 10:37:18');
INSERT INTO `bug_feedback_changelog` VALUES ('103', '86', '1', '', '添加调查注释', '2017-08-16 10:37:18', '2017-08-16 10:37:18');
INSERT INTO `bug_feedback_changelog` VALUES ('104', '86', '1', '', '添加调查注释', '2017-08-16 10:37:58', '2017-08-16 10:37:58');
INSERT INTO `bug_feedback_changelog` VALUES ('107', '88', '209', '', '添加调查注释', '2017-08-16 10:45:05', '2017-08-16 10:45:05');
INSERT INTO `bug_feedback_changelog` VALUES ('109', '96', '1', '邵婷婷 =>> 承志鹏', '分配给', '2017-08-16 12:57:34', '2017-08-16 12:57:34');
INSERT INTO `bug_feedback_changelog` VALUES ('110', '96', '1', '', '添加调查注释', '2017-08-16 12:57:34', '2017-08-16 12:57:34');
INSERT INTO `bug_feedback_changelog` VALUES ('111', '96', '1', '已分派 =>> 已解决', '状态变更', '2017-08-16 12:57:48', '2017-08-16 12:57:48');
INSERT INTO `bug_feedback_changelog` VALUES ('112', '96', '1', '', '添加调查注释', '2017-08-16 12:57:48', '2017-08-16 12:57:48');
INSERT INTO `bug_feedback_changelog` VALUES ('116', '103', '1', '', '添加调查注释', '2017-08-21 09:15:16', '2017-08-21 09:15:16');

-- ----------------------------
-- Table structure for bug_info
-- ----------------------------
DROP TABLE IF EXISTS `bug_info`;
CREATE TABLE `bug_info` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `designation` varchar(255) DEFAULT NULL COMMENT 'bug番号',
  `pro_id` int(11) NOT NULL COMMENT '项目ID ___外键',
  `category` varchar(255) DEFAULT NULL COMMENT 'bug类别',
  `priority` varchar(255) DEFAULT NULL COMMENT '优先级',
  `publisher_id` int(11) DEFAULT NULL COMMENT 'bug发布人_提交者',
  `assigned_id` int(11) DEFAULT NULL COMMENT '分配给的人员_debug人员',
  `os` varchar(255) DEFAULT NULL COMMENT '操作系统',
  `description` text COMMENT '问题描述',
  `status` varchar(255) DEFAULT NULL COMMENT 'bug状态',
  `files` varchar(255) DEFAULT NULL COMMENT 'bug附件',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `fk` (`pro_id`)
) ENGINE=InnoDB AUTO_INCREMENT=105 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of bug_info
-- ----------------------------
INSERT INTO `bug_info` VALUES ('86', '0000086', '39', '1', '1', '1', '216', '2', null, '2', null, '2017-08-16 08:55:55', '2017-08-16 10:37:58', null);
INSERT INTO `bug_info` VALUES ('88', '0000088', '38', '4', '1', '1', '210', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/43.gif\" alt=\"[黑线]\">&nbsp;<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/44.gif\" alt=\"[阴险]\">', '2', '1197.jpg', '2017-08-16 10:21:54', '2017-08-16 10:45:05', '');
INSERT INTO `bug_info` VALUES ('89', '0000089', '38', '1', '1', '209', '216', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/51.gif\" alt=\"[兔子]\">', '2', null, '2017-08-16 10:37:09', '2017-08-16 10:37:09', '');
INSERT INTO `bug_info` VALUES ('90', '0000090', '38', '1', '1', '209', '209', '1', '', '2', null, '2017-08-16 10:46:27', '2017-08-16 10:46:27', '');
INSERT INTO `bug_info` VALUES ('91', '0000091', '38', '1', '1', '209', '209', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/63.gif\" alt=\"[给力]\">', '2', null, '2017-08-16 10:47:48', '2017-08-16 10:47:48', '');
INSERT INTO `bug_info` VALUES ('92', '0000092', '38', '1', '1', '1', '209', '1', '突然回过头', '2', null, '2017-08-16 11:00:21', '2017-08-16 11:00:21', '');
INSERT INTO `bug_info` VALUES ('94', '0000093', '38', '2', '1', '1', '209', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/51.gif\" alt=\"[兔子]\">', '3', null, '2017-08-16 12:05:12', '2017-08-16 12:05:12', '');
INSERT INTO `bug_info` VALUES ('95', '0000095', '39', '4', '3', '1', '216', '3', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/40.gif\" alt=\"[晕]\">', '1', null, '2017-08-16 12:06:25', '2017-08-16 12:06:25', '');
INSERT INTO `bug_info` VALUES ('96', '0000096', '40', '1', '1', '1', '216', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/40.gif\" alt=\"[晕]\">', '4', null, '2017-08-16 12:56:57', '2017-08-16 12:57:48', '');
INSERT INTO `bug_info` VALUES ('97', '0000097', '40', '3', '4', '1', '216', '1', '<img src=\"http://10.167.221.47:8080/BMS/style/layui/images/face/40.gif\" alt=\"[晕]\">', '5', null, '2017-08-16 12:57:10', '2017-08-16 12:57:10', '');
INSERT INTO `bug_info` VALUES ('100', '0000098', '38', '1', '1', '1', '209', '1', '去', '2', null, '2017-08-18 12:28:18', '2017-08-18 12:28:18', '');
INSERT INTO `bug_info` VALUES ('101', '0000101', '38', '1', '1', '1', '209', '1', '111', '2', null, '2017-08-18 13:02:49', '2017-08-18 13:02:49', '');
INSERT INTO `bug_info` VALUES ('102', '0000102', '38', '1', '1', '1', '209', '1', 'q', '2', null, '2017-08-18 13:03:26', '2017-08-18 13:03:26', '');
INSERT INTO `bug_info` VALUES ('103', '0000103', '38', '1', '1', '1', '209', '1', '我', '2', null, '2017-08-18 13:04:03', '2017-08-21 09:15:16', '');
INSERT INTO `bug_info` VALUES ('104', '0000104', '40', '1', '1', '1', '218', '1', '<img src=\"http://localhost:8080/BMS/style/layui/images/face/15.gif\" alt=\"[生病]\">', '2', 'commitbug.PNG', '2017-08-21 09:19:24', '2017-08-21 09:19:24', '');

-- ----------------------------
-- Table structure for dict
-- ----------------------------
DROP TABLE IF EXISTS `dict`;
CREATE TABLE `dict` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `value` varchar(255) DEFAULT NULL COMMENT '数据值',
  `label` varchar(255) DEFAULT NULL COMMENT '标签名',
  `type` varchar(255) DEFAULT NULL COMMENT '数据类别',
  `description` varchar(255) DEFAULT NULL COMMENT '描述',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `update_date` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=28 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of dict
-- ----------------------------
INSERT INTO `dict` VALUES ('1', '1', '文字错误', 'bug_category', 'bug分类', '2017-07-31 10:04:37', '2017-08-16 08:57:36', '12223');
INSERT INTO `dict` VALUES ('2', '2', '次要错误', 'bug_category', 'bug分类', '2017-07-31 10:11:12', '2017-08-01 12:42:51', '');
INSERT INTO `dict` VALUES ('3', '3', '严重错误', 'bug_category', 'bug分类', '2017-07-31 10:11:12', '2017-07-31 10:11:14', null);
INSERT INTO `dict` VALUES ('4', '4', '系统崩溃', 'bug_category', 'bug分类', '2017-08-01 10:32:33', '2017-08-01 10:30:30', '');
INSERT INTO `dict` VALUES ('5', '5', '重大漏洞', 'bug_category', 'bug分类', '2017-07-31 10:13:23', '2017-07-31 10:13:28', null);
INSERT INTO `dict` VALUES ('10', '1', 'win7', 'bug_os', '操作系统', '2017-08-01 10:23:19', '2017-08-01 10:23:19', '');
INSERT INTO `dict` VALUES ('11', '2', 'win8', 'bug_os', '操作系统', '2017-08-01 09:32:21', '2017-08-01 09:32:21', null);
INSERT INTO `dict` VALUES ('12', '3', 'win10', 'bug_os', '操作系统', '2017-08-01 10:32:35', '2017-08-01 12:41:19', '123');
INSERT INTO `dict` VALUES ('13', '4', 'linux', 'bug_os', '操作系统', '2017-08-01 12:42:33', '2017-08-01 13:27:26', 'os');
INSERT INTO `dict` VALUES ('17', '2', '已分派', 'bug_status', 'bug状态', '2017-08-01 13:28:33', '2017-08-01 13:28:33', 'bug_status');
INSERT INTO `dict` VALUES ('18', '3', '已确认', 'bug_status', 'bug状态', '2017-08-01 13:30:22', '2017-08-01 13:30:22', '');
INSERT INTO `dict` VALUES ('19', '4', '已解决', 'bug_status', 'bug状态', '2017-08-01 13:30:54', '2017-08-01 13:30:54', 'bug状态');
INSERT INTO `dict` VALUES ('20', '5', '已关闭', 'bug_status', 'bug状态', '2017-08-01 13:31:12', '2017-08-01 13:31:12', 'bug状态');
INSERT INTO `dict` VALUES ('21', '1', '低', 'bug_priority', 'bug优先级', '2017-08-01 13:35:55', '2017-08-01 13:35:55', 'bug优先级  bug_priority');
INSERT INTO `dict` VALUES ('22', '2', '中', 'bug_priority', 'bug_priority 优先级', '2017-08-01 13:36:18', '2017-08-15 18:07:27', 'bug_priority');
INSERT INTO `dict` VALUES ('23', '3', '高', 'bug_priority', 'bug_priority 优先级', '2017-08-01 13:36:32', '2017-08-15 18:07:11', 'bug_priority 优先级');
INSERT INTO `dict` VALUES ('24', '4', '紧急', 'bug_priority', 'bug_priority 优先级', '2017-08-01 13:37:06', '2017-08-01 13:37:06', 'bug_priority 优先级');
INSERT INTO `dict` VALUES ('26', '1', '反馈', 'bug_status', '反馈', '2017-08-15 20:28:19', '2017-08-15 20:28:19', '');
INSERT INTO `dict` VALUES ('27', '6', '不合理', 'bug_category', 'bug_category', '2017-08-16 08:57:54', '2017-08-16 08:57:54', 'bug_category');

-- ----------------------------
-- Table structure for project
-- ----------------------------
DROP TABLE IF EXISTS `project`;
CREATE TABLE `project` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '主键',
  `name` varchar(255) DEFAULT NULL COMMENT '项目名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建日期',
  `status` int(11) DEFAULT NULL COMMENT '项目标记',
  `leader` int(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '项目描述',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=44 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of project
-- ----------------------------
INSERT INTO `project` VALUES ('38', 'BMS', '2017-08-14 16:15:50', '2', '207', 'BMS(bug管理系统)\n新人演习组项目\n大家可以对本次开发项目进行bug反馈');
INSERT INTO `project` VALUES ('39', 'test', '2017-08-15 16:21:54', '1', '207', 'qweqwe');
INSERT INTO `project` VALUES ('40', '第一次测试bug反馈 proeject模', '2017-08-15 17:02:33', '1', '207', '此项目 描述 projet 模块下 所有bu');
INSERT INTO `project` VALUES ('41', 'AAA', '2017-08-16 14:31:39', '2', '207', 'AAA');
INSERT INTO `project` VALUES ('42', '测试', '2017-08-16 15:06:30', '2', '210', '123');
INSERT INTO `project` VALUES ('43', '123', '2017-08-22 13:00:42', '1', '210', '12344');

-- ----------------------------
-- Table structure for pro_user
-- ----------------------------
DROP TABLE IF EXISTS `pro_user`;
CREATE TABLE `pro_user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pro_id` int(11) DEFAULT NULL,
  `user_id` int(11) DEFAULT NULL,
  `create_date` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pro_fk` (`pro_id`),
  KEY `user_fk` (`user_id`),
  CONSTRAINT `user_fk` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=116 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pro_user
-- ----------------------------
INSERT INTO `pro_user` VALUES ('91', '38', '213', '2017-08-14 04:15:50');
INSERT INTO `pro_user` VALUES ('92', '38', '210', '2017-08-14 04:15:50');
INSERT INTO `pro_user` VALUES ('93', '38', '209', '2017-08-14 04:15:50');
INSERT INTO `pro_user` VALUES ('97', '39', '213', '2017-08-15 04:21:53');
INSERT INTO `pro_user` VALUES ('98', '39', '210', '2017-08-15 04:21:53');
INSERT INTO `pro_user` VALUES ('100', '39', '217', '2017-08-16 08:55:22');
INSERT INTO `pro_user` VALUES ('101', '39', '216', '2017-08-16 08:55:26');
INSERT INTO `pro_user` VALUES ('102', '38', '217', '2017-08-16 09:07:22');
INSERT INTO `pro_user` VALUES ('103', '38', '216', '2017-08-16 09:07:26');
INSERT INTO `pro_user` VALUES ('104', '40', '218', '2017-08-16 12:56:29');
INSERT INTO `pro_user` VALUES ('105', '40', '217', '2017-08-16 12:56:33');
INSERT INTO `pro_user` VALUES ('106', '40', '216', '2017-08-16 12:56:36');
INSERT INTO `pro_user` VALUES ('111', '41', '217', '2017-08-16 02:31:38');
INSERT INTO `pro_user` VALUES ('112', '41', '216', '2017-08-16 02:31:38');
INSERT INTO `pro_user` VALUES ('113', '42', '218', '2017-08-16 03:06:29');
INSERT INTO `pro_user` VALUES ('114', '42', '216', '2017-08-16 03:06:29');
INSERT INTO `pro_user` VALUES ('115', '43', '222', '2017-08-22 01:00:42');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '用户主键',
  `name` varchar(255) NOT NULL COMMENT '用户名',
  `idNo` varchar(20) DEFAULT NULL COMMENT '工号',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `email` varchar(255) DEFAULT NULL,
  `role_name` varchar(11) NOT NULL COMMENT '角色名称',
  `create_date` datetime DEFAULT NULL COMMENT '创建时间',
  `is_deleted` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=223 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('1', 'fnst', '108007', '12345', '11@com', 'SuperAdmin', '2017-07-25 13:14:34', '0');
INSERT INTO `user` VALUES ('207', 'dengsl.jy', '108005', '123456', '741743548@qq.com', 'Admin', '2017-08-09 22:45:59', '0');
INSERT INTO `user` VALUES ('209', 'sunb.jy', '108008', '123456', '123@934.com', 'Member', '2017-08-14 13:04:12', '0');
INSERT INTO `user` VALUES ('210', 'liuxw.jy', '108003', 'fnst1234', 'liuxw.123@mail.com', 'Admin', '2017-08-14 13:05:41', '0');
INSERT INTO `user` VALUES ('213', 'shilin', '108250', '123456', 'shjilin@cm', 'Member', '2017-08-14 15:55:07', '0');
INSERT INTO `user` VALUES ('215', 'test', '108222', '123456', '123456@q', 'Member', '2017-08-15 14:17:54', '0');
INSERT INTO `user` VALUES ('216', '承志鹏', '108049', '123456', 'chengzp.jy@cn.fujitsu.com', 'Member', '2017-08-15 14:25:25', '0');
INSERT INTO `user` VALUES ('217', 'ad', '108000', '111111', 'shaott.jy@cn', 'Member', '2017-08-15 19:27:26', '0');
INSERT INTO `user` VALUES ('218', '123', '108004', '123456', '121@q', 'Member', '2017-08-16 09:16:11', '1');
INSERT INTO `user` VALUES ('220', '测试', '108011', '123456', '121@q', 'Member', '2017-08-17 14:34:22', '1');
INSERT INTO `user` VALUES ('221', '测试2', '108012', '123456', '121@q', 'Admin', '2017-08-17 14:50:52', '1');
INSERT INTO `user` VALUES ('222', '邵婷婷', '108035', '000000', 'shaott.jy@cn.fujitsu.com', 'Member', '2017-08-18 11:19:18', '0');
