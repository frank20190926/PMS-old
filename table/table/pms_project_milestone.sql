/*
Navicat MySQL Data Transfer

Source Server         : mysql57-localhost
Source Server Version : 50738
Source Host           : localhost:33061
Source Database       : kml-pms

Target Server Type    : MYSQL
Target Server Version : 50738
File Encoding         : 65001

Date: 2026-01-23 17:24:48
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pms_project_milestone
-- ----------------------------
DROP TABLE IF EXISTS `pms_project_milestone`;
CREATE TABLE `pms_project_milestone` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `project_id` int(11) NOT NULL COMMENT '项目ID',
  `milestone_user_id` int(11) DEFAULT NULL COMMENT '负责人用户ID',
  `milestone_title` varchar(50) NOT NULL DEFAULT '' COMMENT '里程碑标题',
  `milestone_content` varchar(200) NOT NULL DEFAULT '' COMMENT '里程碑内容',
  `deliverables_id` int(11) DEFAULT NULL COMMENT '成果物ID',
  `deliverables` varchar(100) DEFAULT '' COMMENT '成果物',
  `deadline_date` datetime DEFAULT NULL COMMENT '截止时间',
  `attachment_url` varchar(500) DEFAULT '' COMMENT '附件地址',
  `score` int(11) DEFAULT NULL COMMENT '评分',
  `del_flag` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=188 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='项目里程碑';

-- ----------------------------
-- Records of pms_project_milestone
-- ----------------------------
INSERT INTO `pms_project_milestone` VALUES ('1', '34', '28', '内部评审', '公司内部评审，陆地端及算法', null, '陆地端测试环境并内部回归测试结束', '2024-10-23 00:00:00', '', null, '0', 'huangfei', '2024-10-21 17:38:34', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('2', '29', '28', '需求评审', '完成内部需求评审', null, '需求评审通过', '2024-11-01 00:00:00', '', null, '0', 'huangfei', '2024-10-29 10:06:14', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('3', '29', '28', '内部交付', '评审优化项修改完成，完成交付前功能测试', null, '软件成果包', '2024-11-22 00:00:00', '', null, '0', 'huangfei', '2024-11-15 15:36:23', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('4', '51', '28', '设计阶段', '完成产品及 UI 设计', null, '需求文档和UI 设计', '2025-02-14 00:00:00', '', null, '0', 'huangfei', '2025-01-09 11:42:40', 'huangfei', '2025-01-23 11:41:05', null);
INSERT INTO `pms_project_milestone` VALUES ('5', '51', '9', '开发阶段', '完成前后端开发及联调可以进入到测试阶段', null, '内部访问项目及基础功能验证', '2025-02-10 00:00:00', '', null, '0', 'huangfei', '2025-01-09 11:43:43', 'huangfei', '2025-01-23 14:30:27', null);
INSERT INTO `pms_project_milestone` VALUES ('6', '51', '5', '测试阶段', '完成内部完成的测试流程，部署前准备', null, '测试报告', '2025-02-28 00:00:00', '', null, '0', 'huangfei', '2025-01-09 11:44:26', 'huangfei', '2025-01-23 11:41:19', null);
INSERT INTO `pms_project_milestone` VALUES ('7', '51', '32', '实施阶段', '实施部署', null, '现场实施部署结束', '2025-03-07 00:00:00', '', null, '0', 'huangfei', '2025-01-09 11:44:54', 'huangfei', '2025-01-23 11:41:31', null);
INSERT INTO `pms_project_milestone` VALUES ('8', '57', '16', '工时预估备案', '', null, '动画所需的所有素材', '2025-05-30 00:00:00', '/profile/upload/2025/05/09/副本科研动画演示步骤工时V4_20250509130617A001.pdf', null, '0', 'huangfei', '2025-05-09 13:06:19', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('9', '60', '28', '结项评分', '', null, '结项评分表', '2025-05-08 00:00:00', '/profile/upload/2025/05/09/结项评分表_20250509143932A002.pdf', null, '0', 'huangfei', '2025-05-09 14:39:53', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('10', '63', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('11', '63', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('12', '63', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('13', '63', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('14', '63', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('15', '63', null, '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', null, '', null, '2', 'liuyujia', '2025-05-20 09:39:51', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('16', '62', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('17', '62', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('18', '62', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('19', '62', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('20', '62', null, '软件项目/开发阶段/需求变更记录表', '需求变更记录表', '35', '需求变更记录表', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('21', '62', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('22', '62', null, '软件项目/开发阶段/切图&模型资料', '切图&模型资料', '33', '切图&模型资料', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('23', '62', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('24', '62', null, '软件项目/设计阶段/容灾方案', '容灾方案', '31', '容灾方案', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('25', '62', null, '软件项目/设计阶段/测试大纲', '测试大纲', '30', '测试大纲', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('26', '62', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('27', '62', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('28', '62', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('29', '62', null, '软件项目/需求调研阶段/评审需求池（变更文档）', '评审需求池（变更文档）', '25', '评审需求池（变更文档）', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('30', '62', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('31', '62', null, '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('32', '62', null, '软件项目/立项会议/相关方输入材料', '相关方输入材料', '22', '相关方输入材料', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('33', '62', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('34', '62', null, '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('35', '62', null, '软件项目/招投标阶段/项目解决方案', '项目解决方案', '18', '项目解决方案', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('36', '62', '37', '软件项目/招投标阶段/调研报告', '调研报告', '16', '调研报告', '2025-04-16 00:00:00', '', null, '2', 'liuyujia', '2025-05-21 09:36:05', 'wangjunfeng', '2025-06-06 15:17:18', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('37', '62', null, '软件项目/招投标阶段/产品白皮书', '产品白皮书', '15', '产品白皮书', null, '', null, '2', 'liuyujia', '2025-05-21 09:36:05', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('38', '67', null, '软件项目/立项会议/相关方输入材料', '相关方输入材料', '22', '相关方输入材料', null, '', null, '2', 'huangfei', '2025-05-22 15:20:55', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('39', '67', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '2', 'huangfei', '2025-05-22 15:20:55', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('40', '67', null, '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', null, '', null, '2', 'huangfei', '2025-05-22 15:20:55', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('41', '63', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('42', '63', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('43', '63', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('44', '63', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('45', '63', null, '软件项目/开发阶段/切图&模型资料', '切图&模型资料', '33', '切图&模型资料', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('46', '63', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('47', '63', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('48', '63', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('49', '63', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('50', '63', null, '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', null, '', null, '0', 'liuyujia', '2025-05-27 09:31:34', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('51', '68', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '0', 'liuyujia', '2025-05-28 14:09:14', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('52', '68', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '0', 'liuyujia', '2025-05-28 14:09:14', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('53', '68', null, '软件项目/测试阶段/运维手册', '运维手册', '38', '运维手册', null, '', null, '0', 'liuyujia', '2025-05-28 14:09:14', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('54', '68', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '0', 'liuyujia', '2025-05-28 14:09:14', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('55', '68', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '0', 'liuyujia', '2025-05-28 14:09:14', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('56', '47', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('57', '47', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('58', '47', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('59', '47', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('60', '47', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('61', '47', null, '软件项目/开发阶段/切图&模型资料', '切图&模型资料', '33', '切图&模型资料', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('62', '47', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('63', '47', null, '软件项目/设计阶段/测试大纲', '测试大纲', '30', '测试大纲', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('64', '47', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('65', '47', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('66', '47', '6', '软件项目/设计阶段/高精图', '高精图', '27', '高精图', '2025-06-26 00:00:00', '/profile/upload/2025/06/30/高精原型图_20250630181703A007.pdf', null, '0', 'liuyujia', '2025-05-28 16:54:15', 'yuguansheng', '2025-06-30 18:17:32', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('67', '47', null, '软件项目/需求调研阶段/评审需求池（变更文档）', '评审需求池（变更文档）', '25', '评审需求池（变更文档）', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('68', '47', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('69', '47', '36', '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', '2025-06-03 00:00:00', '/profile/upload/2025/06/30/低精原型图_20250630175611A005.pdf', null, '0', 'liuyujia', '2025-05-28 16:54:15', 'yuguansheng', '2025-06-30 17:56:22', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('70', '47', null, '软件项目/立项会议/相关方输入材料', '相关方输入材料', '22', '相关方输入材料', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('71', '47', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '0', 'liuyujia', '2025-05-28 16:54:15', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('72', '47', '36', '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', '2025-05-13 00:00:00', '/profile/upload/2025/06/30/智慧船2.0_20250630180933A006.pdf', null, '0', 'liuyujia', '2025-05-28 16:54:15', 'yuguansheng', '2025-06-30 18:09:37', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('73', '26', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('74', '26', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('75', '26', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('76', '26', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('77', '26', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('78', '26', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('79', '26', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('80', '26', null, '软件项目/需求调研阶段/评审需求池（变更文档）', '评审需求池（变更文档）', '25', '评审需求池（变更文档）', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('81', '26', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'liuyujia', '2025-05-30 08:55:47', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('82', '26', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '0', 'liuyujia', '2025-05-30 08:56:59', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('83', '26', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '0', 'liuyujia', '2025-05-30 08:56:59', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('84', '26', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '0', 'liuyujia', '2025-05-30 08:56:59', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('85', '67', null, '软件项目/运维阶段/项目复盘报告', '项目复盘报告', '47', '项目复盘报告', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('86', '67', null, '软件项目/运维阶段/运维事件报告', '运维事件报告', '46', '运维事件报告', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('87', '67', null, '软件项目/现场部署阶段/调试报告', '调试报告', '45', '调试报告', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('88', '67', null, '软件项目/准备现场部署阶段/实施文档', '实施文档', '44', '实施文档', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('89', '67', null, '软件项目/准备现场部署阶段/部署工作计划', '部署工作计划', '43', '部署工作计划', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('90', '67', null, '软件项目/准备现场部署阶段/部署物料清单', '部署物料清单', '42', '部署物料清单', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('91', '67', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('92', '67', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('93', '67', null, '软件项目/测试阶段/服务器软件离线安装手册', '服务器软件离线安装手册', '39', '服务器软件离线安装手册', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('94', '67', null, '软件项目/测试阶段/运维手册', '运维手册', '38', '运维手册', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('95', '67', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('96', '67', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('97', '67', null, '软件项目/开发阶段/需求变更记录表', '需求变更记录表', '35', '需求变更记录表', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('98', '67', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('99', '67', null, '软件项目/开发阶段/切图&模型资料', '切图&模型资料', '33', '切图&模型资料', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('100', '67', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('101', '67', null, '软件项目/设计阶段/容灾方案', '容灾方案', '31', '容灾方案', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('102', '67', null, '软件项目/设计阶段/测试大纲', '测试大纲', '30', '测试大纲', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('103', '67', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('104', '67', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('105', '67', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('106', '67', null, '软件项目/需求调研阶段/技术方案验证', '技术方案验证', '26', '技术方案验证', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('107', '67', null, '软件项目/需求调研阶段/评审需求池（变更文档）', '评审需求池（变更文档）', '25', '评审需求池（变更文档）', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('108', '67', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('109', '67', null, '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('110', '67', null, '软件项目/立项会议/相关方输入材料', '相关方输入材料', '22', '相关方输入材料', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('111', '67', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('112', '67', null, '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('113', '67', null, '软件项目/招投标阶段/客户沟通记录表', '客户沟通记录表', '19', '客户沟通记录表', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('114', '67', null, '软件项目/招投标阶段/项目解决方案', '项目解决方案', '18', '项目解决方案', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('115', '67', null, '软件项目/招投标阶段/产品功能报价清单', '产品功能报价清单', '17', '产品功能报价清单', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('116', '67', null, '软件项目/招投标阶段/调研报告', '调研报告', '16', '调研报告', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('117', '67', null, '软件项目/招投标阶段/产品白皮书', '产品白皮书', '15', '产品白皮书', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('118', '67', null, '软件项目/招投标阶段/商务标书', '商务标书', '14', '商务标书', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('119', '67', null, '软件项目/招投标阶段/技术标书', '技术标书', '13', '技术标书', null, '', null, '2', 'huangfei', '2025-06-10 09:48:40', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('120', '67', '28', '软件项目/招投标阶段/标书约束', '标书约束', '12', '标书约束', '2025-06-10 00:00:00', '', null, '2', 'huangfei', '2025-06-10 09:48:40', 'huangfei', '2025-06-10 09:49:19', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('121', '67', null, '软件项目/运维阶段/项目复盘报告', '项目复盘报告', '47', '项目复盘报告', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('122', '67', null, '软件项目/运维阶段/运维事件报告', '运维事件报告', '46', '运维事件报告', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('123', '67', null, '软件项目/现场部署阶段/调试报告', '调试报告', '45', '调试报告', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('124', '67', null, '软件项目/准备现场部署阶段/实施文档', '实施文档', '44', '实施文档', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('125', '67', null, '软件项目/准备现场部署阶段/部署工作计划', '部署工作计划', '43', '部署工作计划', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('126', '67', null, '软件项目/准备现场部署阶段/部署物料清单', '部署物料清单', '42', '部署物料清单', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('127', '67', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('128', '67', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('129', '67', null, '软件项目/测试阶段/服务器软件离线安装手册', '服务器软件离线安装手册', '39', '服务器软件离线安装手册', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('130', '67', null, '软件项目/测试阶段/运维手册', '运维手册', '38', '运维手册', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('131', '67', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('132', '67', null, '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('133', '67', null, '软件项目/开发阶段/需求变更记录表', '需求变更记录表', '35', '需求变更记录表', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('134', '67', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('135', '67', null, '软件项目/开发阶段/切图&模型资料', '切图&模型资料', '33', '切图&模型资料', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('136', '67', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('137', '67', null, '软件项目/设计阶段/容灾方案', '容灾方案', '31', '容灾方案', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('138', '67', null, '软件项目/设计阶段/测试大纲', '测试大纲', '30', '测试大纲', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('139', '67', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('140', '67', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('141', '67', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('142', '67', null, '软件项目/需求调研阶段/技术方案验证', '技术方案验证', '26', '技术方案验证', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('143', '67', null, '软件项目/需求调研阶段/评审需求池（变更文档）', '评审需求池（变更文档）', '25', '评审需求池（变更文档）', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('144', '67', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('145', '67', null, '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', null, '', null, '2', 'huangfei', '2025-06-10 10:02:08', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('146', '67', '37', '软件项目/立项会议/相关方输入材料', '相关方输入材料', '22', '相关方输入材料', '2025-06-11 00:00:00', '', null, '2', 'huangfei', '2025-06-10 10:02:08', 'huangfei', '2025-06-10 10:03:49', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('147', '67', '26', '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', '2025-06-11 00:00:00', '', null, '2', 'huangfei', '2025-06-10 10:02:08', 'huangfei', '2025-06-10 10:03:33', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('148', '67', '36', '软件项目/立项会议/技术可行性方案', '技术可行性方案', '20', '技术可行性方案', '2025-06-11 00:00:00', '', null, '2', 'huangfei', '2025-06-10 10:02:08', 'huangfei', '2025-06-10 10:03:22', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('149', '62', null, '软件项目/准备现场部署阶段/实施文档', '实施文档', '44', '实施文档', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('150', '62', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('151', '62', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('152', '62', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('153', '62', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('154', '62', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('155', '62', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('156', '62', null, '软件项目/设计阶段/高精图', '高精图', '27', '高精图', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('157', '62', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('158', '62', '37', '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', '2025-06-06 00:00:00', '/profile/upload/2025/06/19/原型图_20250619092004A002.doc', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', 'wangjunfeng', '2025-06-19 09:20:06', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('159', '62', '37', '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', '2025-04-16 00:00:00', '/profile/upload/2025/06/19/（已压缩）科迈尔MES系统_20250619091506A001.pdf', null, '2', 'wangjunfeng', '2025-06-19 08:52:18', 'wangjunfeng', '2025-06-19 09:15:28', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('160', '62', null, '软件项目/准备现场部署阶段/实施文档', '实施文档', '44', '实施文档', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('161', '62', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('162', '62', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('163', '62', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('164', '62', '5', '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', '2025-07-04 00:00:00', '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', 'wangjunfeng', '2025-06-19 09:29:42', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('165', '62', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('166', '62', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('167', '62', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('168', '62', '6', '软件项目/设计阶段/高精图', '高精图', '27', '高精图', '2025-07-04 00:00:00', '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', 'wangjunfeng', '2025-06-19 09:30:01', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('169', '62', null, '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('170', '62', null, '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('171', '62', null, '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', null, '', null, '2', 'wangjunfeng', '2025-06-19 09:29:22', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('172', '62', null, '软件项目/准备现场部署阶段/实施文档', '实施文档', '44', '实施文档', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('173', '62', null, '软件项目/测试完成阶段/使用说明书', '使用说明书', '41', '使用说明书', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('174', '62', null, '软件项目/测试完成阶段/测试报告', '测试报告', '40', '测试报告', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('175', '62', null, '软件项目/测试阶段/Bug清单', 'Bug清单', '37', 'Bug清单', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('176', '62', '5', '软件项目/开发阶段/测试用例', '测试用例', '36', '测试用例', '2025-07-04 00:00:00', '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', 'wangjunfeng', '2025-06-19 09:35:35', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('177', '62', null, '软件项目/开发阶段/需求变更记录表', '需求变更记录表', '35', '需求变更记录表', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('178', '62', null, '软件项目/开发阶段/API接口文档', 'API接口文档', '34', 'API接口文档', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('179', '62', null, '软件项目/设计阶段/开发计划文档', '开发计划文档', '32', '开发计划文档', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('180', '62', null, '软件项目/设计阶段/数据库设计', '数据库设计', '29', '数据库设计', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('181', '62', null, '软件项目/设计阶段/架构设计', '架构设计', '28', '架构设计', null, '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', '', null, '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('182', '62', '6', '软件项目/设计阶段/高精图', '高精图', '27', '高精图', '2025-07-04 00:00:00', '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', 'wangjunfeng', '2025-06-19 09:35:16', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('183', '62', '37', '软件项目/需求调研阶段/需求PRD', '需求PRD', '24', '需求PRD', '2025-06-27 00:00:00', '', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', 'wangjunfeng', '2025-06-19 09:34:56', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('184', '62', '37', '软件项目/需求调研阶段/低精原型图', '低精原型图', '23', '低精原型图', '2025-06-05 00:00:00', '/profile/upload/2025/06/19/原型图_20250619093436A004.doc', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', 'wangjunfeng', '2025-06-19 09:34:37', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('185', '62', '37', '软件项目/立项会议/整体项目计划', '整体项目计划', '21', '整体项目计划', '2025-04-16 00:00:00', '/profile/upload/2025/06/19/（已压缩）科迈尔MES系统_20250619093216A003.pdf', null, '0', 'wangjunfeng', '2025-06-19 09:31:16', 'wangjunfeng', '2025-06-19 09:32:17', '同步更新交付物至里程碑');
INSERT INTO `pms_project_milestone` VALUES ('186', '71', '28', '需求确认', '', null, '变更的原型设计', '2025-08-01 00:00:00', '', null, '0', 'huangfei', '2025-07-25 14:09:21', '', null, null);
INSERT INTO `pms_project_milestone` VALUES ('187', '71', '5', '内部测试通过', '', null, '测试报告', '2025-08-20 00:00:00', '', null, '0', 'huangfei', '2025-07-25 14:09:50', '', null, null);
