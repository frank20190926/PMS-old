/*
Navicat MySQL Data Transfer

Source Server         : mysql57-localhost
Source Server Version : 50738
Source Host           : localhost:33061
Source Database       : kml-pms

Target Server Type    : MYSQL
Target Server Version : 50738
File Encoding         : 65001

Date: 2026-01-23 17:24:35
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for pms_project_staff_sched
-- ----------------------------
DROP TABLE IF EXISTS `pms_project_staff_sched`;
CREATE TABLE `pms_project_staff_sched` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'ID',
  `project_id` int(11) DEFAULT NULL COMMENT '项目ID',
  `sched_user_id` int(11) DEFAULT NULL COMMENT '排期人员ID',
  `sched_workhour` decimal(10,1) DEFAULT '0.0' COMMENT '预估工时',
  `sched_start_time` datetime DEFAULT NULL COMMENT '开始时间',
  `sched_end_time` datetime DEFAULT NULL COMMENT '结束时间',
  `sched_intro` text COMMENT '排期说明',
  `del_flag` char(1) CHARACTER SET utf8mb4 DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`) USING BTREE,
  KEY `project_id_index` (`project_id`) USING BTREE,
  KEY `sched_user_id_index` (`sched_user_id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=274 DEFAULT CHARSET=utf8 ROW_FORMAT=DYNAMIC COMMENT='人员排期';

-- ----------------------------
-- Records of pms_project_staff_sched
-- ----------------------------
INSERT INTO `pms_project_staff_sched` VALUES ('1', '28', '12', '160.0', '2024-08-01 00:00:00', '2024-09-09 00:00:00', '', '0', '', '2024-08-21 09:06:56', 'huangfei', '2024-09-06 09:29:06', null);
INSERT INTO `pms_project_staff_sched` VALUES ('2', '28', '6', '40.0', '2024-10-08 08:30:00', '2024-11-14 17:30:00', 'UI补充内容', '0', '', '2024-08-21 09:09:37', 'huangfei', '2024-11-13 09:46:22', null);
INSERT INTO `pms_project_staff_sched` VALUES ('3', '15', '32', '20.0', '2024-12-02 00:00:00', '2024-12-06 00:00:00', '完成陆丰151硬盘替换，NAS方案，行程测试报告给到甲方进行确认 徐涛、曾凡慈负责	\r\n', '0', '', '2024-08-26 09:42:05', 'huangfei', '2024-11-28 10:24:15', null);
INSERT INTO `pms_project_staff_sched` VALUES ('4', '2', '17', '0.0', '2024-08-26 00:00:00', '2024-08-27 00:00:00', '2024年8月23日内部海上监测子系统功能评审建议修复	\r\n', '0', '', '2024-08-26 09:43:26', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('5', '2', '5', '0.0', '2024-08-28 00:00:00', '2024-08-28 00:00:00', '2024年8月23日内部海上监测子系统功能评审建议修复', '0', '', '2024-08-26 09:44:50', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('6', '28', '4', '40.0', '2024-10-14 08:30:00', '2024-10-18 17:30:00', '后端功能完善，视频播放，操作记录联动功能开发', '0', '', '2024-08-27 14:19:54', 'huangfei', '2024-10-09 13:34:35', null);
INSERT INTO `pms_project_staff_sched` VALUES ('7', '28', '17', '24.0', '2024-10-14 08:30:00', '2024-10-18 17:30:00', '想定编辑模块功能完善，配合后端修改', '0', '', '2024-08-27 14:20:21', 'huangfei', '2024-10-09 13:35:49', null);
INSERT INTO `pms_project_staff_sched` VALUES ('8', '11', '27', '20.0', '2024-10-08 08:30:00', '2024-10-10 17:30:00', '回归问题，bug修复。', '0', '', '2024-08-27 14:21:47', 'huangfei', '2024-10-09 13:27:34', null);
INSERT INTO `pms_project_staff_sched` VALUES ('9', '11', '10', '160.0', '2024-08-01 00:00:00', '2024-09-06 00:00:00', '', '0', '', '2024-08-27 14:22:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('10', '11', '5', '80.0', '2024-08-05 00:00:00', '2024-09-13 00:00:00', '', '0', '', '2024-08-27 14:22:28', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('11', '4', '7', '0.0', '2024-08-27 00:00:00', '2024-09-13 00:00:00', '整理数据一体化数据查找逻辑', '0', '', '2024-08-30 10:26:26', 'huangfei', '2024-09-06 09:41:40', null);
INSERT INTO `pms_project_staff_sched` VALUES ('12', '4', '4', '0.0', '2024-08-26 00:00:00', '2024-09-12 00:00:00', '排查修复SACS模型导入，节点数据解析逻辑', '0', '', '2024-08-30 10:26:56', 'huangfei', '2024-09-06 11:13:10', null);
INSERT INTO `pms_project_staff_sched` VALUES ('15', '4', '14', '0.0', '2024-08-26 00:00:00', '2024-09-10 00:00:00', '实现焊缝展示功能，点击显示焊缝信息时，在三维模型上高亮显示焊缝位置 下周1开始测试，预计周二下班前结束', '0', '', '2024-08-30 10:29:20', 'huangfei', '2024-09-06 11:18:08', null);
INSERT INTO `pms_project_staff_sched` VALUES ('16', '4', '14', '0.0', '2024-08-26 00:00:00', '2024-09-06 00:00:00', '调研SACS模型解析，过度锥功能实现', '0', '', '2024-08-30 10:29:38', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('17', '4', '5', '40.0', '2024-10-08 08:30:00', '2024-10-12 17:30:00', '流花11-1陆地孪生子系统回归测试', '0', '', '2024-08-30 10:30:26', 'huangfei', '2024-10-09 08:59:23', null);
INSERT INTO `pms_project_staff_sched` VALUES ('18', '4', '5', '0.0', '2024-09-03 00:00:00', '2024-09-06 00:00:00', '流花11-13D大屏展示端回归测试', '0', '', '2024-08-30 10:30:48', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('19', '28', '16', '80.0', '2024-09-06 00:00:00', '2024-09-06 17:30:00', '', '2', '', '2024-08-30 11:25:40', 'huangfei', '2024-09-06 14:45:33', null);
INSERT INTO `pms_project_staff_sched` VALUES ('20', '4', '6', '80.0', '2024-09-02 00:00:00', '2024-09-13 00:00:00', '数据整理录入', '0', 'huangfei', '2024-09-06 09:38:29', 'huangfei', '2024-09-06 09:41:53', null);
INSERT INTO `pms_project_staff_sched` VALUES ('21', '4', '27', '40.0', '2024-09-03 08:30:00', '2024-09-09 17:30:00', '数据整理录入', '0', 'huangfei', '2024-09-06 09:41:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('22', '11', '9', '64.0', '2024-09-02 00:00:00', '2024-09-13 00:00:00', '海陆传输功能+同济环境搭建稳定性测试+', '0', 'huangfei', '2024-09-06 09:44:20', 'huangfei', '2024-09-09 15:45:09', null);
INSERT INTO `pms_project_staff_sched` VALUES ('23', '4', '17', '40.0', '2024-09-09 08:30:00', '2024-09-12 08:30:00', '	\n整理数据一体化数据', '0', 'huangfei', '2024-09-06 10:17:23', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('24', '4', '10', '40.0', '2024-09-06 00:00:00', '2024-09-13 00:00:00', '流花二级孪生算法更新', '0', 'huangfei', '2024-09-06 11:15:50', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('25', '4', '33', '100.0', '2024-09-09 00:00:00', '2024-09-20 00:00:00', '实施准备', '0', 'huangfei', '2024-09-06 11:21:31', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('26', '11', '32', '80.0', '2024-10-14 00:00:00', '2024-10-30 00:00:00', '实施准备', '0', 'huangfei', '2024-09-06 11:22:45', 'huangfei', '2024-10-09 14:57:24', null);
INSERT INTO `pms_project_staff_sched` VALUES ('27', '4', '28', '60.0', '2024-09-02 00:00:00', '2024-09-13 00:00:00', '	\n整理数据一体化数据', '0', 'huangfei', '2024-09-06 11:23:44', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('28', '28', '28', '30.0', '2024-09-02 00:00:00', '2024-09-13 00:00:00', '项目交付，及材料跟进', '0', 'huangfei', '2024-09-06 11:24:51', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('29', '11', '28', '10.0', '2024-09-11 00:00:00', '2024-09-13 00:00:00', '评审前资料整理和功能确认，测试', '0', 'huangfei', '2024-09-06 11:47:09', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('30', '4', '7', '20.0', '2024-09-09 00:00:00', '2024-09-20 00:00:00', '出海前实施跟进', '0', 'huangfei', '2024-09-06 11:48:11', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('31', '4', '16', '80.0', '2024-09-02 00:00:00', '2024-09-13 00:00:00', '数据整理录入', '0', 'huangfei', '2024-09-06 14:26:17', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('32', '16', '12', '3.0', '2024-09-10 00:00:00', '2024-09-11 00:00:00', '修改程序（输入框改下拉框）', '0', 'chenyuxi', '2024-09-06 15:43:58', 'chenyuxi', '2024-09-06 15:46:27', null);
INSERT INTO `pms_project_staff_sched` VALUES ('33', '16', '26', '1.0', '2024-09-10 00:00:00', '2024-09-11 00:00:00', '协助技术人员修改程序', '0', 'chenyuxi', '2024-09-06 15:44:33', 'chenyuxi', '2024-09-06 15:45:56', null);
INSERT INTO `pms_project_staff_sched` VALUES ('34', '4', '26', '50.0', '2024-09-09 00:00:00', '2024-09-13 00:00:00', '	\n整理数据一体化数据', '0', 'huangfei', '2024-09-09 15:44:24', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('35', '16', '5', '4.0', '2024-09-11 00:00:00', '2024-09-12 00:00:00', null, '0', 'chenyuxi', '2024-09-09 17:24:29', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('36', '28', '12', '320.0', '2024-09-18 08:30:00', '2024-11-29 17:30:00', '硬件对接排期 不准确 需要实际再评估', '0', 'huangfei', '2024-09-19 08:55:20', 'huangfei', '2024-11-28 09:38:48', null);
INSERT INTO `pms_project_staff_sched` VALUES ('37', '28', '16', '100.0', '2024-09-18 08:30:00', '2024-09-30 17:30:00', '模型暂时预估，后期实际评估后再调整', '2', 'huangfei', '2024-09-19 09:17:16', 'huangfei', '2024-10-09 08:51:41', null);
INSERT INTO `pms_project_staff_sched` VALUES ('38', '28', '4', '96.0', '2024-10-10 00:00:00', '2024-10-25 00:00:00', '视频接口等功能对接，', '2', 'huangfei', '2024-09-19 09:18:34', 'huangfei', '2024-09-19 09:20:19', null);
INSERT INTO `pms_project_staff_sched` VALUES ('39', '36', '9', '10.0', '2024-10-08 00:00:00', '2024-10-22 00:00:00', '深度爬虫一期功能开发及测试', '0', 'chenyuxi', '2024-09-27 15:00:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('40', '36', '26', '1.0', '2024-10-08 00:00:00', '2024-10-09 00:00:00', '爬虫程序功能优化完善', '0', 'chenyuxi', '2024-09-27 15:01:50', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('41', '4', '28', '15.0', '2024-09-27 00:00:00', '2024-09-30 00:00:00', '11111', '0', 'huangfei', '2024-09-29 18:46:37', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('42', '28', '16', '60.0', '2024-10-08 08:30:00', '2024-11-22 17:30:00', '地形地图，地形碰撞，各个仿真模型制作', '0', 'huangfei', '2024-10-09 08:46:15', 'huangfei', '2024-11-22 09:23:52', null);
INSERT INTO `pms_project_staff_sched` VALUES ('43', '28', '14', '40.0', '2024-10-08 08:30:00', '2024-10-12 17:30:00', '导弹发射，操作飞机飞行，变焦操作', '0', 'huangfei', '2024-10-09 08:50:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('44', '2', '5', '8.0', '2024-10-09 10:00:00', '2024-10-11 17:30:00', '海上端数据单位的修改回归测试', '0', 'huangfei', '2024-10-09 11:02:14', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('45', '2', '17', '10.0', '2024-10-09 11:02:25', '2024-10-12 17:30:00', '	\n海上端数据单位的修改', '0', 'huangfei', '2024-10-09 11:02:48', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('46', '11', '10', '104.0', '2024-10-08 08:30:00', '2024-10-23 17:30:00', '同济回归问题修改，和基础信息的导入导出的功能修改，后期增加数据库优化和底层优化', '0', 'huangfei', '2024-10-09 11:07:20', 'huangfei', '2024-10-23 14:20:57', null);
INSERT INTO `pms_project_staff_sched` VALUES ('47', '38', '14', '104.0', '2024-10-14 08:30:00', '2024-10-30 17:30:00', '国产化引擎和功能开发', '0', 'huangfei', '2024-10-09 13:11:10', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('48', '38', '26', '40.0', '2024-10-08 08:30:00', '2024-10-12 17:30:00', '产品功能设计', '0', 'huangfei', '2024-10-09 13:12:52', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('49', '38', '17', '130.0', '2024-10-08 08:30:00', '2024-10-30 17:30:00', '国产化引擎调研及功能开发', '0', 'huangfei', '2024-10-09 13:14:33', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('50', '38', '27', '200.0', '2024-10-10 08:30:00', '2024-11-12 17:30:00', '国产化引擎和功能开发\n', '0', 'huangfei', '2024-10-09 13:15:08', 'huangfei', '2024-11-06 09:20:40', null);
INSERT INTO `pms_project_staff_sched` VALUES ('51', '4', '4', '40.0', '2024-10-08 08:30:00', '2024-10-12 17:30:00', '后端功能自测', '0', 'huangfei', '2024-10-09 13:37:16', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('52', '4', '7', '80.0', '2024-10-08 08:30:00', '2024-10-18 17:30:00', '交付材料准备，产品设计完善，测试验收', '0', 'huangfei', '2024-10-09 14:12:43', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('53', '28', '28', '40.0', '2024-10-08 08:30:00', '2024-10-30 17:30:00', '项目开发跟进，需求编写', '0', 'huangfei', '2024-10-09 14:28:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('54', '4', '28', '100.0', '2024-10-08 08:30:00', '2024-12-13 00:00:00', '项目跟进，问题处理。', '0', 'huangfei', '2024-10-09 14:29:09', 'huangfei', '2024-11-28 10:27:08', null);
INSERT INTO `pms_project_staff_sched` VALUES ('55', '11', '28', '80.0', '2024-10-08 08:30:00', '2024-12-20 00:00:00', '项目跟进，开发问题解决，交付材料准备', '0', 'huangfei', '2024-10-09 14:30:03', 'huangfei', '2024-11-28 10:27:39', null);
INSERT INTO `pms_project_staff_sched` VALUES ('56', '39', '33', '320.0', '2024-10-08 08:30:00', '2024-11-29 17:30:00', '保密内部网络及系统建设', '0', 'huangfei', '2024-10-09 14:54:12', 'huangfei', '2024-11-22 09:27:00', null);
INSERT INTO `pms_project_staff_sched` VALUES ('57', '4', '33', '120.0', '2024-10-08 08:30:00', '2024-11-22 00:00:00', '系统问题跟进处理，实施准备', '0', 'huangfei', '2024-10-09 14:55:48', 'huangfei', '2024-11-13 13:54:37', null);
INSERT INTO `pms_project_staff_sched` VALUES ('58', '4', '32', '320.0', '2024-10-08 08:30:00', '2024-11-29 00:00:00', '系统问题跟进处理，实施准备 ', '0', 'huangfei', '2024-10-09 14:56:25', 'huangfei', '2024-11-20 16:29:48', null);
INSERT INTO `pms_project_staff_sched` VALUES ('59', '4', '9', '60.0', '2024-10-08 08:30:00', '2024-11-08 00:00:00', '数据库及底层问题处理优化。', '0', 'huangfei', '2024-10-09 15:51:24', 'huangfei', '2024-11-06 14:30:46', null);
INSERT INTO `pms_project_staff_sched` VALUES ('60', '24', '5', '80.0', '2024-10-14 08:30:00', '2024-10-25 17:30:00', 'ICCP集群化可是平台软著材料编写  ', '0', 'huangfei', '2024-10-16 13:41:47', 'huangfei', '2024-10-23 14:17:18', null);
INSERT INTO `pms_project_staff_sched` VALUES ('61', '39', '5', '60.0', '2024-10-14 08:30:00', '2024-12-20 17:30:00', '整理编写信息化材料', '0', 'huangfei', '2024-10-16 13:42:27', 'huangfei', '2024-11-22 09:32:05', null);
INSERT INTO `pms_project_staff_sched` VALUES ('62', '4', '5', '20.0', '2024-10-16 08:30:00', '2024-11-29 17:30:00', '数据库优化后回归统计和压测', '0', 'huangfei', '2024-10-16 13:43:20', 'huangfei', '2024-11-22 09:47:42', null);
INSERT INTO `pms_project_staff_sched` VALUES ('63', '38', '6', '50.0', '2024-10-14 08:30:00', '2024-11-08 17:30:00', 'UI设计', '0', 'huangfei', '2024-10-16 13:56:25', 'huangfei', '2024-11-06 09:20:12', null);
INSERT INTO `pms_project_staff_sched` VALUES ('64', '28', '34', '40.0', '2024-10-21 08:30:00', '2024-10-25 17:30:00', '技术材料编写', '0', 'huangfei', '2024-10-23 13:29:57', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('65', '4', '10', '40.0', '2024-10-24 08:30:00', '2024-10-31 17:30:00', '数据库底层优化修改配合', '0', 'huangfei', '2024-10-23 14:23:50', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('66', '39', '5', '40.0', '2024-11-11 08:30:00', '2024-11-15 17:30:00', '出差参加保密培训', '0', 'huangfei', '2024-10-24 14:03:12', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('67', '39', '16', '240.0', '2024-11-11 08:30:00', '2024-12-20 17:30:00', '保密建设相关工作', '0', 'huangfei', '2024-10-24 14:03:54', 'huangfei', '2024-11-22 09:31:37', null);
INSERT INTO `pms_project_staff_sched` VALUES ('68', '4', '7', '184.0', '2024-10-23 08:30:00', '2024-11-22 17:30:00', '操作手册编写  ，交付内容更新，全流程文件整合标准', '0', 'huangfei', '2024-10-24 14:05:33', 'huangfei', '2024-11-15 15:14:09', null);
INSERT INTO `pms_project_staff_sched` VALUES ('69', '29', '7', '70.0', '2024-10-29 08:30:00', '2024-11-29 17:30:00', '产品设计文档及功能说明更新', '0', 'huangfei', '2024-10-29 10:04:11', 'huangfei', '2024-11-22 09:56:08', null);
INSERT INTO `pms_project_staff_sched` VALUES ('70', '29', '32', '8.0', '2024-10-28 08:30:00', '2024-11-01 17:30:00', '软硬件环境准备', '0', 'huangfei', '2024-10-29 10:07:21', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('71', '29', '28', '60.0', '2024-10-29 08:30:00', '2024-11-29 17:30:00', '项目跟进  ', '0', 'huangfei', '2024-10-29 10:08:00', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('72', '29', '4', '32.0', '2024-11-05 08:30:00', '2024-11-08 17:30:00', '功能修改 ', '0', 'huangfei', '2024-11-06 09:23:31', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('73', '29', '17', '40.0', '2024-11-04 08:30:00', '2024-11-29 17:30:00', '功能修改，优化', '0', 'huangfei', '2024-11-06 09:24:19', 'huangfei', '2024-11-28 10:22:44', null);
INSERT INTO `pms_project_staff_sched` VALUES ('74', '29', '5', '30.0', '2024-11-04 08:30:00', '2024-11-27 17:30:00', '新功能测试  ', '0', 'huangfei', '2024-11-06 09:25:04', 'huangfei', '2024-11-22 09:35:54', null);
INSERT INTO `pms_project_staff_sched` VALUES ('75', '16', '12', '24.0', '2024-11-18 08:30:00', '2024-11-20 17:30:00', '驻场702程序对接', '0', 'chenyuxi', '2024-11-06 10:17:19', 'chenyuxi', '2024-11-13 10:40:22', null);
INSERT INTO `pms_project_staff_sched` VALUES ('76', '29', '9', '100.0', '2024-11-04 08:30:00', '2024-11-29 17:30:00', '功能修改', '0', 'huangfei', '2024-11-06 14:29:52', 'huangfei', '2024-11-28 10:22:27', null);
INSERT INTO `pms_project_staff_sched` VALUES ('77', '41', '14', '296.0', '2024-11-11 08:30:00', '2024-12-31 17:30:00', '国产化引擎封装', '0', 'huangfei', '2024-11-06 14:44:49', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('78', '41', '17', '272.0', '2024-11-14 08:30:00', '2024-12-31 17:30:00', '国产化引擎封装', '0', 'huangfei', '2024-11-06 14:45:06', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('79', '41', '27', '272.0', '2024-11-14 08:30:00', '2024-12-31 17:30:00', '国产化引擎封装', '0', 'huangfei', '2024-11-06 14:45:25', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('80', '26', '6', '80.0', '2024-11-08 08:30:00', '2024-12-06 17:30:00', '做仪控专业高保真页面', '0', 'chenyuxi', '2024-11-06 17:00:18', 'chenyuxi', '2024-11-28 17:35:36', null);
INSERT INTO `pms_project_staff_sched` VALUES ('81', '4', '4', '40.0', '2024-11-11 08:30:00', '2024-11-15 17:30:00', '客户现场运维处理', '0', 'huangfei', '2024-11-13 09:45:23', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('82', '26', '10', '400.0', '2024-11-14 08:30:00', '2025-01-22 17:30:00', '编写及封装种子库专业算法程序', '0', 'chenyuxi', '2024-11-13 10:23:55', 'chenyuxi', '2025-01-06 13:02:14', null);
INSERT INTO `pms_project_staff_sched` VALUES ('83', '26', '26', '160.0', '2024-11-13 08:30:00', '2024-12-06 17:30:00', '机理种子库软件应用化设计', '0', 'chenyuxi', '2024-11-13 10:35:22', 'chenyuxi', '2025-01-06 13:02:54', null);
INSERT INTO `pms_project_staff_sched` VALUES ('84', '26', '27', '312.0', '2024-11-18 08:30:00', '2025-01-10 17:30:00', '做机理种子库前端', '0', 'chenyuxi', '2024-11-13 10:36:08', 'chenyuxi', '2025-01-06 13:01:54', null);
INSERT INTO `pms_project_staff_sched` VALUES ('85', '40', '34', '280.0', '2024-10-14 08:30:00', '2024-11-30 17:30:00', '产品调研设计', '0', 'huangfei', '2024-11-13 13:53:08', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('86', '29', '14', '8.0', '2024-11-15 08:30:00', '2024-11-22 17:30:00', '3D模块修改', '0', 'huangfei', '2024-11-15 15:24:00', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('87', '4', '9', '60.0', '2024-11-25 08:30:00', '2024-12-06 17:30:00', '陆地端部署', '0', 'huangfei', '2024-11-20 16:29:14', 'huangfei', '2024-11-28 10:23:28', null);
INSERT INTO `pms_project_staff_sched` VALUES ('88', '10', '4', '24.0', '2024-11-25 08:30:00', '2024-11-29 17:30:00', '后端API文档制作', '0', 'huangfei', '2024-11-22 09:20:38', 'huangfei', '2024-11-28 10:03:01', null);
INSERT INTO `pms_project_staff_sched` VALUES ('89', '31', '4', '24.0', '2024-11-20 08:30:00', '2024-11-22 17:30:00', '内部依赖程序搭建，', '0', 'huangfei', '2024-11-22 09:33:49', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('90', '20', '32', '15.0', '2024-12-02 08:30:00', '2024-12-06 17:30:00', 'NAS 数据库安装迁移', '2', 'huangfei', '2024-11-28 09:51:57', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('91', '4', '32', '20.0', '2024-12-02 08:30:00', '2024-12-06 17:30:00', '临时服务器部署安装，出差深圳分现场', '0', 'huangfei', '2024-11-28 09:53:39', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('92', '11', '4', '24.0', '2024-12-02 08:30:00', '2024-12-06 17:30:00', '评审意见修改', '0', 'huangfei', '2024-11-28 10:21:40', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('93', '11', '17', '24.0', '2024-12-02 08:30:00', '2024-12-06 17:30:00', '评审意见修改。', '0', 'huangfei', '2024-11-28 10:22:04', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('94', '11', '7', '40.0', '2024-12-02 08:30:00', '2024-12-06 17:30:00', '交付材料准备。', '0', 'huangfei', '2024-11-28 10:28:24', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('95', '13', '28', '60.0', '2024-11-28 08:30:00', '2024-12-31 17:30:00', '人员储备。', '0', 'huangfei', '2024-11-29 09:07:39', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('96', '23', '28', '60.0', '2024-12-09 08:30:00', '2024-12-20 17:30:00', '功能升级设计', '0', 'huangfei', '2024-12-13 08:54:35', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('97', '26', '9', '60.0', '2024-12-13 08:30:00', '2025-01-03 17:30:00', '机理种子库算法模型封装', '0', 'chenyuxi', '2024-12-23 13:10:31', 'chenyuxi', '2025-01-06 13:01:33', null);
INSERT INTO `pms_project_staff_sched` VALUES ('98', '51', '28', '80.0', '2024-12-27 08:30:00', '2025-02-21 17:30:00', '产品设计  项目跟进', '0', 'huangfei', '2024-12-27 09:21:41', 'huangfei', '2025-01-03 16:22:19', null);
INSERT INTO `pms_project_staff_sched` VALUES ('99', '51', '27', '240.0', '2025-01-13 08:30:00', '2025-02-28 17:30:00', '光渔前端开发', '0', 'huangfei', '2025-01-03 16:18:59', 'huangfei', '2025-01-23 11:43:52', null);
INSERT INTO `pms_project_staff_sched` VALUES ('100', '51', '9', '200.0', '2025-01-13 08:30:00', '2025-02-21 17:30:00', '光渔后端框架开发', '0', 'huangfei', '2025-01-03 16:19:47', 'huangfei', '2025-02-12 13:54:28', null);
INSERT INTO `pms_project_staff_sched` VALUES ('101', '51', '10', '200.0', '2025-01-17 08:30:00', '2025-02-28 17:30:00', '光渔后端功能开发', '0', 'huangfei', '2025-01-03 16:20:20', 'huangfei', '2025-01-23 11:43:05', null);
INSERT INTO `pms_project_staff_sched` VALUES ('102', '51', '16', '48.0', '2025-01-20 08:30:00', '2025-02-07 17:30:00', '光渔导管架模型制作', '0', 'huangfei', '2025-01-03 16:21:01', 'huangfei', '2025-01-23 14:32:39', null);
INSERT INTO `pms_project_staff_sched` VALUES ('103', '51', '6', '80.0', '2025-01-03 08:30:00', '2025-02-14 17:30:00', '光渔高精制作', '0', 'huangfei', '2025-01-03 16:21:23', 'huangfei', '2025-01-23 11:42:31', null);
INSERT INTO `pms_project_staff_sched` VALUES ('104', '51', '14', '80.0', '2025-02-05 08:30:00', '2025-02-21 17:30:00', '光渔 3D 模块功能开发', '0', 'huangfei', '2025-01-03 16:21:52', 'huangfei', '2025-01-23 14:31:38', null);
INSERT INTO `pms_project_staff_sched` VALUES ('105', '15', '9', '48.0', '2025-01-03 08:30:00', '2025-01-10 17:30:00', '陆丰 151运维优化功能开发', '0', 'huangfei', '2025-01-03 16:24:10', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('106', '15', '14', '56.0', '2025-01-02 08:30:00', '2025-01-10 17:30:00', '	\n陆丰 151 运维功能开发修改', '0', 'huangfei', '2025-01-03 16:24:40', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('107', '51', '5', '120.0', '2025-01-13 08:30:00', '2025-02-28 17:30:00', '项目测试', '0', 'huangfei', '2025-01-03 16:26:33', 'huangfei', '2025-01-23 11:45:02', null);
INSERT INTO `pms_project_staff_sched` VALUES ('108', '26', '26', '40.0', '2025-01-02 08:30:00', '2025-01-10 17:30:00', '编写浮体专业软件开发报告', '0', 'chenyuxi', '2025-01-06 13:03:38', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('109', '40', '34', '96.0', '2025-01-07 08:30:00', '2025-01-22 17:30:00', '完成高精设计修改', '0', 'xiuming', '2025-01-06 15:13:02', 'xiuming', '2025-01-06 15:14:05', null);
INSERT INTO `pms_project_staff_sched` VALUES ('110', '51', '32', '80.0', '2025-01-23 08:30:00', '2025-03-14 17:30:00', '实施运维 ', '0', 'huangfei', '2025-01-23 14:28:02', 'huangfei', '2025-01-23 14:29:26', null);
INSERT INTO `pms_project_staff_sched` VALUES ('111', '56', '16', '200.0', '2025-01-13 08:30:00', '2025-03-03 17:30:00', '国产化素材整合 整理', '0', 'huangfei', '2025-02-12 13:37:01', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('112', '56', '12', '288.0', '2025-01-20 08:30:00', '2025-03-14 17:30:00', '虚拟引擎UE   国产化封装 准备 。', '0', 'huangfei', '2025-02-12 13:40:05', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('113', '40', '34', '40.0', '2025-02-12 08:30:00', '2025-02-18 17:30:00', '完成需求确认及产品设计', '0', 'xiuming', '2025-02-12 13:45:54', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('114', '47', '26', '80.0', '2025-02-10 08:30:00', '2025-02-21 17:30:00', '绘制低精原型，程序详细设计', '0', 'chenyuxi', '2025-02-12 13:46:21', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('115', '40', '6', '48.0', '2025-02-18 08:30:00', '2025-02-25 17:30:00', '完成高保真原型图', '0', 'xiuming', '2025-02-12 13:46:43', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('116', '40', '4', '120.0', '2025-02-24 08:30:00', '2025-03-14 17:30:00', '项目研发', '0', 'xiuming', '2025-02-12 13:47:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('117', '40', '26', '16.0', '2025-02-13 08:30:00', '2025-02-14 17:30:00', '编写原料管拆分软件用户手册', '0', 'xiuming', '2025-02-12 13:49:14', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('118', '4', '32', '60.0', '2025-02-12 08:30:00', '2025-06-30 17:30:00', '日常运维巡检  ', '0', 'huangfei', '2025-02-12 13:49:35', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('119', '11', '32', '60.0', '2025-02-12 08:30:00', '2025-06-30 17:30:00', '日常巡检', '0', 'huangfei', '2025-02-12 13:50:17', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('120', '15', '32', '60.0', '2025-02-12 08:30:00', '2025-06-30 17:30:00', '日常巡检', '0', 'huangfei', '2025-02-12 13:51:12', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('121', '31', '5', '60.0', '2025-02-05 08:30:00', '2025-02-14 17:30:00', 'AI工具使用调研 ', '0', 'huangfei', '2025-02-12 13:52:56', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('122', '56', '14', '40.0', '2025-02-05 08:30:00', '2025-02-14 17:30:00', '国产化 unity3D 及 其他引擎测试', '0', 'huangfei', '2025-02-12 14:47:22', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('123', '31', '4', '20.0', '2025-02-10 08:30:00', '2025-02-14 17:30:00', 'PMS功能迭代', '0', 'huangfei', '2025-02-12 14:49:13', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('124', '31', '6', '60.0', '2025-02-13 08:30:00', '2025-02-28 17:30:00', 'AI UI工具调研  ', '0', 'huangfei', '2025-02-14 09:57:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('125', '40', '28', '40.0', '2025-02-17 08:30:00', '2025-02-21 17:30:00', '产品交接 ，产品设计完善', '0', 'huangfei', '2025-02-17 10:04:10', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('126', '40', '35', '80.0', '2025-03-10 08:30:00', '2025-03-21 17:30:00', '前端开发', '0', 'huangfei', '2025-03-13 17:33:52', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('127', '7', '14', '248.0', '2025-03-19 08:30:00', '2025-04-30 17:30:00', '开发柔性混输管三维部分', '0', 'chenyuxi', '2025-03-25 08:45:14', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('128', '26', '10', '120.0', '2025-03-10 08:30:00', '2025-03-28 17:30:00', '种子库后端程序及数据接口开发', '0', 'chenyuxi', '2025-03-25 08:46:14', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('129', '58', '10', '80.0', '2025-03-31 08:30:00', '2025-04-14 17:30:00', '后端开发', '0', 'chenyuxi', '2025-03-28 14:39:35', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('130', '58', '35', '80.0', '2025-03-31 08:30:00', '2025-04-14 17:30:00', '前端开发', '0', 'chenyuxi', '2025-03-28 14:39:58', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('131', '58', '12', '40.0', '2025-04-08 08:30:00', '2025-04-14 17:30:00', '程序封装', '0', 'chenyuxi', '2025-03-28 14:41:02', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('132', '57', '16', '520.0', '2025-04-01 08:30:00', '2025-07-04 17:30:00', '模型动画制作 ', '0', 'huangfei', '2025-05-09 13:00:38', 'huangfei', '2025-06-12 13:57:20', null);
INSERT INTO `pms_project_staff_sched` VALUES ('133', '7', '14', '48.0', '2025-05-16 08:30:00', '2025-05-23 17:30:00', '开发运维管理功能，优化当前软件界面显示效果', '0', 'chenyuxi', '2025-05-16 14:36:42', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('134', '7', '26', '16.0', '2025-05-20 08:30:00', '2025-05-21 17:30:00', '混输管磨损检测过程监测界面设计', '0', 'chenyuxi', '2025-05-16 14:37:08', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('135', '7', '6', '8.0', '2025-05-22 08:30:00', '2025-05-22 17:30:00', '柔性混输管磨损检测部分高保真设计效果图修改', '0', 'chenyuxi', '2025-05-16 14:37:48', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('136', '67', '28', '100.0', '2025-06-09 08:30:00', '2025-09-19 17:30:00', '需求确认 项目沟通\n', '0', 'huangfei', '2025-06-10 09:47:36', 'huangfei', '2025-09-05 09:58:46', null);
INSERT INTO `pms_project_staff_sched` VALUES ('137', '26', '10', '35.0', '2025-06-05 08:30:00', '2025-06-11 17:30:00', '修复海工设计院扫描出的漏洞', '0', 'chenyuxi', '2025-06-10 10:28:47', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('138', '67', '35', '64.0', '2025-05-27 08:30:00', '2025-06-06 17:30:00', ' 工作计划：若依框架引入threejs环境  集成模型demo 调试路由  评估接口\n 需求： 设计主体背景logo等切图， 接口初步文档', '0', 'huangfei', '2025-06-10 11:27:04', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('139', '67', '35', '80.0', '2025-06-09 08:30:00', '2025-06-20 17:30:00', ' 工作计划：整体页面样式开发完成  真实模型引入调试\n 需求： 设计提供完整切图 ， 理工提供完整模型', '0', 'huangfei', '2025-06-10 11:27:23', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('140', '67', '35', '80.0', '2025-06-23 08:30:00', '2025-07-04 17:30:00', ' 工作计划：对接3D模型数据 完成3d整体功能\n 需求： 模型最终确认 ，模型所需完整真实数据', '0', 'huangfei', '2025-06-10 11:27:44', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('141', '67', '35', '80.0', '2025-07-07 08:30:00', '2025-07-18 17:30:00', ' 工作计划：前后端接口联调\n 需求： 所有接口最终确认和实际测试数据', '0', 'huangfei', '2025-06-10 11:28:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('142', '67', '35', '80.0', '2025-07-21 08:30:00', '2025-10-22 17:30:00', ' 工作计划：测试修改\n 需求：测试人员及时反馈测试问题', '0', 'huangfei', '2025-06-10 11:28:47', 'huangfei', '2025-10-14 10:30:30', null);
INSERT INTO `pms_project_staff_sched` VALUES ('143', '67', '5', '36.0', '2025-10-01 08:30:00', '2025-10-22 17:30:00', '测试', '0', 'huangfei', '2025-06-10 11:29:23', 'huangfei', '2025-10-14 10:33:46', null);
INSERT INTO `pms_project_staff_sched` VALUES ('144', '67', '10', '160.0', '2025-06-16 08:30:00', '2025-10-17 17:30:00', ' 工作计划：对接3D模型数据 前后端接口联调  ', '0', 'huangfei', '2025-06-10 11:32:18', 'huangfei', '2025-10-14 10:31:05', null);
INSERT INTO `pms_project_staff_sched` VALUES ('145', '47', '9', '40.0', '2025-06-09 08:30:00', '2025-06-13 17:30:00', '视觉AI识别训练平台部署与优化+数据集训练+图片识别+视频识别测试工具开发', '0', 'yuguansheng', '2025-06-10 17:39:12', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('146', '47', '9', '40.0', '2025-06-16 08:30:00', '2025-06-20 17:30:00', '项目中集成JAVA调用python视频识别模块+消息通讯模块+与客户端初步通讯', '0', 'yuguansheng', '2025-06-10 17:40:31', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('147', '47', '9', '48.0', '2025-06-23 08:30:00', '2025-06-30 17:30:00', '与客户端完成视觉模块前后端连调+硬件数据接收端模块开发', '0', 'yuguansheng', '2025-06-10 17:41:22', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('148', '47', '14', '40.0', '2025-06-09 08:30:00', '2025-06-13 17:30:00', '视频展示功能开发，视频上画线、画按钮、点击事件，信息展示等功能开发', '0', 'yuguansheng', '2025-06-10 17:42:34', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('149', '47', '14', '40.0', '2025-06-16 08:30:00', '2025-06-20 17:30:00', '对接后端视频接口，辅助线航行线等接口等', '0', 'yuguansheng', '2025-06-10 17:43:15', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('150', '47', '36', '1112.0', '2025-03-17 08:30:00', '2025-09-30 17:30:00', '负责产品从开发至项目验收的全过程管理。', '0', 'yuguansheng', '2025-06-10 17:51:57', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('151', '47', '6', '40.0', '2025-06-09 08:30:00', '2025-06-13 17:30:00', '产品低精高精制作', '0', 'yuguansheng', '2025-06-10 17:57:49', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('152', '62', '6', '152.0', '2025-06-02 08:30:00', '2025-06-27 17:30:00', 'PC端系统设计\n移动端设计\n数字大屏设计', '0', 'wangjunfeng', '2025-06-12 17:18:57', 'wangjunfeng', '2025-06-27 16:03:23', null);
INSERT INTO `pms_project_staff_sched` VALUES ('153', '62', '4', '216.0', '2025-05-21 08:30:00', '2025-06-27 17:30:00', '技术底层搭建、后端开发、前端PC开发、前端小程序开发、前端数字大屏开发、前后端联调、前后端自测', '0', 'wangjunfeng', '2025-06-12 17:20:31', 'wangjunfeng', '2025-06-27 16:22:06', null);
INSERT INTO `pms_project_staff_sched` VALUES ('154', '62', '5', '160.0', '2025-06-09 08:30:00', '2025-07-04 17:30:00', 'PC测试用例编写', '0', 'wangjunfeng', '2025-06-12 17:21:21', 'wangjunfeng', '2025-06-30 10:23:05', null);
INSERT INTO `pms_project_staff_sched` VALUES ('155', '62', '5', '256.0', '2025-09-12 08:30:00', '2025-10-31 17:30:00', '系统测试整体测试', '2', 'wangjunfeng', '2025-06-12 17:22:13', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('156', '62', '37', '1176.0', '2025-03-31 08:30:00', '2025-10-31 17:30:00', '产品由0-1全生命周期项目产品管理', '0', 'wangjunfeng', '2025-06-12 17:23:06', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('157', '47', '5', '24.0', '2025-06-02 08:30:00', '2025-06-05 17:30:00', '编写产品测试用例', '0', 'yuguansheng', '2025-06-12 17:31:45', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('158', '47', '14', '16.0', '2025-06-12 08:30:00', '2025-06-13 17:30:00', '供应商海图功能测试', '0', 'yuguansheng', '2025-06-13 08:42:48', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('159', '47', '12', '40.0', '2025-06-12 08:30:00', '2025-06-18 17:30:00', '产品宣传动画制作', '0', 'yuguansheng', '2025-06-13 08:44:20', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('160', '16', '26', '20.0', '2025-06-23 08:30:00', '2025-06-25 17:30:00', '完善多轴疲劳测试报告，编写多轴疲劳设计、开发及验证总结报告', '0', 'chenyuxi', '2025-06-19 15:37:56', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('161', '68', '9', '24.0', '2025-06-23 08:30:00', '2025-07-11 17:30:00', '硬件对接  后端部署', '0', 'huangfei', '2025-06-20 08:49:59', 'huangfei', '2025-06-27 17:03:35', null);
INSERT INTO `pms_project_staff_sched` VALUES ('162', '68', '35', '8.0', '2025-06-23 08:30:00', '2025-07-04 17:30:00', '页面调整', '0', 'huangfei', '2025-06-20 08:51:32', 'huangfei', '2025-06-27 17:03:23', null);
INSERT INTO `pms_project_staff_sched` VALUES ('163', '68', '12', '8.0', '2025-06-23 08:30:00', '2025-07-04 17:30:00', '模型替换', '0', 'huangfei', '2025-06-20 08:52:07', 'huangfei', '2025-07-03 09:41:40', null);
INSERT INTO `pms_project_staff_sched` VALUES ('164', '68', '32', '16.0', '2025-06-25 08:30:00', '2025-07-11 17:30:00', '工厂部署调试， 后续现场部署 再规划任务', '0', 'huangfei', '2025-06-20 08:52:58', 'huangfei', '2025-06-27 17:02:50', null);
INSERT INTO `pms_project_staff_sched` VALUES ('165', '68', '5', '8.0', '2025-06-26 08:30:00', '2025-07-11 17:30:00', '测试验证', '0', 'huangfei', '2025-06-20 08:53:35', 'huangfei', '2025-06-27 17:03:50', null);
INSERT INTO `pms_project_staff_sched` VALUES ('166', '59', '28', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '1、嘟嘟嘟嘟嘟嘟\n2、嘟嘟嘟嘟嘟嘟\n3、得多大是多少啊', '2', 'huangfei', '2025-06-27 15:05:08', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('167', '62', '6', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'MES 系统首页设计、登录页面、生产管理（工单管理、工序管理、工艺管理、人员统计）UI页面设计', '2', 'wangjunfeng', '2025-06-27 15:59:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('168', '62', '37', '8.0', '2025-06-27 08:30:00', '2025-06-28 17:30:00', '1231123123', '2', 'wangjunfeng', '2025-06-27 16:01:41', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('169', '62', '6', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'MES UI设计 \n1，PC端系统首页、登录页\n2，生产管理模块（工单管理、工序管理、工艺管理、人员统计）\n3，智慧视觉模块（智慧检测、监控设备、预警算法）\n4，设备管理模块（设备列表、Lot设备）\n5，系统设置模块（主体管理、工厂管理、用户管理、权限管理、菜单管理）\n6，数据大屏  UI设计\n7，移动端（登录页面、生产工单、施工任务、我的）', '2', 'wangjunfeng', '2025-06-27 16:02:51', 'wangjunfeng', '2025-06-27 16:11:32', null);
INSERT INTO `pms_project_staff_sched` VALUES ('170', '62', '5', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'MES 测试用例编写\n1，PC端系统首页、登录页 \n2，生产管理模块（工单管理、工序管理、工艺管理、人员统计） \n3，智慧视觉模块（智慧检测、监控设备、预警算法） \n4，设备管理模块（设备列表、Lot设备） \n5，系统设置模块（主体管理、工厂管理、用户管理、权限管理、菜单管理） \n6，数据大屏 \n7，移动端（登录页、生产工单、施工任务、我的）', '2', 'wangjunfeng', '2025-06-27 16:10:55', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('171', '62', '4', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'MES  生产管理与系统设置 数据库设计', '0', 'wangjunfeng', '2025-06-27 16:21:52', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('172', '67', '6', '16.0', '2025-06-30 08:30:00', '2025-07-11 17:30:00', '配合功能的页面调整修改。', '0', 'huangfei', '2025-06-27 17:01:52', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('173', '47', '14', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '1.视频ui按钮替换，视频ui层级调整，ui效果提升。\n2.航行线算法优化，由前进方向直线改为根据避碰算法计算出的避碰曲线。替换，视频ui层级调整，ui效果提升。\n3.避碰算法优化，由原来的计算最小距离改为从船舶右侧通行。\n', '0', 'yuguansheng', '2025-06-30 09:35:53', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('174', '47', '9', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '1.雷达时序数据库设计\n2.雷达数据接入并将数据保存到时序数据库\n3.AIS硬件接入\n4.AIS数据库设计并将数据接入\n5、视频放大功能开发', '0', 'yuguansheng', '2025-06-30 09:46:10', 'yuguansheng', '2025-07-04 08:59:52', null);
INSERT INTO `pms_project_staff_sched` VALUES ('175', '47', '12', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '1.首页嵌入雷达sdk\n2.qt Http通信模块 \n3.瞭望页面嵌入unity模块\n4.海图模块开发', '0', 'yuguansheng', '2025-06-30 09:55:58', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('176', '47', '5', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '1、视觉训练，图片标注录入', '0', 'yuguansheng', '2025-06-30 10:07:58', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('177', '62', '5', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '移动端测试用例编写', '0', 'wangjunfeng', '2025-06-30 10:23:26', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('178', '62', '5', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'Bi数字大屏测试用例编写', '0', 'wangjunfeng', '2025-06-30 10:23:58', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('179', '62', '6', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'PC UI效果图设计', '0', 'wangjunfeng', '2025-06-30 10:24:42', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('180', '62', '6', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', '移动端 UI效果图设计', '0', 'wangjunfeng', '2025-06-30 10:25:00', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('181', '62', '6', '40.0', '2025-06-30 08:30:00', '2025-07-04 17:30:00', 'Bi数字大屏UI效果图设计', '0', 'wangjunfeng', '2025-06-30 10:25:23', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('182', '68', '28', '16.0', '2025-06-23 08:30:00', '2025-07-11 17:30:00', '项目跟进 资料准备 ', '0', 'huangfei', '2025-07-03 09:42:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('183', '47', '9', '32.0', '2025-07-07 08:30:00', '2025-07-10 17:30:00', '1、视屏放大\n2.AIS数据库设计并将数据接入\n3.AIS数据优化并推送到客户端\n4.设计TCP硬件数据转发模块', '0', 'yuguansheng', '2025-07-08 09:26:52', 'yuguansheng', '2025-07-08 09:37:47', null);
INSERT INTO `pms_project_staff_sched` VALUES ('184', '47', '14', '24.0', '2025-07-07 08:30:00', '2025-07-09 17:30:00', '\n6.优化视频页面适配分辨率功能，视频模块适配瞭望页面。\n7、切换视频与信息交互\n8、从后端获取放大后视频', '0', 'yuguansheng', '2025-07-08 09:32:53', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('185', '47', '12', '40.0', '2025-07-07 08:30:00', '2025-07-11 17:30:00', '1.完善首页嵌入雷达sdk、瞭望页面嵌入unity模块\n2.海图模块开发。\n3.策略模块搭建框架及页面嵌入海图。\n4.航行轨迹模块框架搭建及嵌入海图\n5.右下角 udp 视频\n6.qt Http通信模块 ', '0', 'yuguansheng', '2025-07-08 09:37:16', 'yuguansheng', '2025-07-08 09:46:03', null);
INSERT INTO `pms_project_staff_sched` VALUES ('186', '47', '14', '16.0', '2025-07-15 08:30:00', '2025-07-16 17:30:00', '1、主页面UI优化\n2、瞭望界面适配', '0', 'yuguansheng', '2025-07-15 09:47:19', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('187', '47', '14', '8.0', '2025-07-16 08:30:00', '2025-07-17 17:30:00', '智慧船舶宣传视频修改', '0', 'yuguansheng', '2025-07-17 15:52:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('188', '47', '14', '40.0', '2025-07-18 08:30:00', '2025-07-24 17:30:00', '接收后端提供的AIS，雷达信息。信息解析与提取，船舶信息映射到海图中', '0', 'yuguansheng', '2025-07-18 08:51:43', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('189', '71', '9', '160.0', '2025-07-14 08:30:00', '2025-09-19 17:30:00', '硬件接口对接开发及修改', '0', 'huangfei', '2025-07-23 10:20:14', 'huangfei', '2025-09-05 09:47:47', null);
INSERT INTO `pms_project_staff_sched` VALUES ('190', '71', '28', '40.0', '2025-07-14 08:30:00', '2025-09-19 17:30:00', '项目跟进及需求对接，功能修改设计等产品相关工作', '0', 'huangfei', '2025-07-23 10:21:05', 'huangfei', '2025-09-05 09:59:12', null);
INSERT INTO `pms_project_staff_sched` VALUES ('191', '71', '35', '40.0', '2025-07-28 08:30:00', '2025-08-08 17:30:00', '前端页面修改', '0', 'huangfei', '2025-07-23 10:21:55', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('192', '71', '5', '24.0', '2025-08-11 08:30:00', '2025-10-17 17:30:00', '项目测试 ', '0', 'huangfei', '2025-07-23 10:22:28', 'huangfei', '2025-10-14 10:32:07', null);
INSERT INTO `pms_project_staff_sched` VALUES ('193', '28', '12', '32.0', '2025-07-28 08:30:00', '2025-07-31 17:30:00', '新增功能  开发', '0', 'huangfei', '2025-07-24 09:24:12', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('194', '62', '6', '40.0', '2025-07-28 08:30:00', '2025-08-01 17:30:00', '科焊智云v2.0需求UI效果图输出', '0', 'wangjunfeng', '2025-07-25 14:03:28', 'wangjunfeng', '2025-07-25 14:04:31', null);
INSERT INTO `pms_project_staff_sched` VALUES ('195', '47', '9', '40.0', '2025-08-05 08:30:00', '2025-08-11 17:30:00', '1、现场录制数据\n2、基于真实数据的转发模拟器开发', '0', 'yuguansheng', '2025-07-25 14:03:29', 'yuguansheng', '2025-08-05 17:19:42', null);
INSERT INTO `pms_project_staff_sched` VALUES ('196', '47', '14', '24.0', '2025-07-28 08:30:00', '2025-07-30 17:30:00', '1、开发产品其他功能页面、海图在轨迹监测页面展示\n2、根据历史记录信息生成路线', '0', 'yuguansheng', '2025-07-25 14:06:31', 'yuguansheng', '2025-07-29 14:46:46', null);
INSERT INTO `pms_project_staff_sched` VALUES ('197', '62', '4', '40.0', '2025-07-28 08:30:00', '2025-08-01 17:30:00', '1、用户数据权限划分与开发；\n2、工单日志模块完善', '0', 'wangjunfeng', '2025-07-25 14:06:37', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('198', '62', '10', '40.0', '2025-07-28 08:30:00', '2025-08-01 17:30:00', '1、工单相关业务功能开发', '0', 'wangjunfeng', '2025-07-25 14:06:56', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('199', '71', '16', '16.0', '2025-07-23 08:30:00', '2025-09-10 17:30:00', '模型优化 ', '0', 'huangfei', '2025-07-25 14:13:10', 'huangfei', '2025-09-05 10:00:40', null);
INSERT INTO `pms_project_staff_sched` VALUES ('200', '71', '12', '32.0', '2025-07-30 08:30:00', '2025-08-06 17:30:00', '大屏端和 3D 模块制作', '0', 'huangfei', '2025-07-25 14:13:43', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('201', '47', '9', '10.0', '2025-07-28 08:30:00', '2025-07-29 17:30:00', '优化代码适配AIS和雷达数据录制', '0', 'yuguansheng', '2025-07-28 09:31:23', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('202', '71', '6', '16.0', '2025-09-08 08:30:00', '2025-09-12 17:30:00', 'UI修改优化 ', '0', 'huangfei', '2025-09-05 09:57:53', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('203', '67', '16', '40.0', '2025-08-18 08:30:00', '2025-09-12 17:30:00', '模型修改', '0', 'huangfei', '2025-09-05 10:01:36', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('204', '47', '9', '64.0', '2025-09-17 08:30:00', '2025-09-26 17:30:00', '1、弱化雷达杂波功能开发\n2、AIS与雷达目标融合功能开发', '0', 'yuguansheng', '2025-09-05 10:05:28', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('205', '62', '10', '184.0', '2025-09-01 08:30:00', '2025-09-30 17:30:00', 'mes项目后端开发，前端开发，wms后端开发', '0', 'wangjunfeng', '2025-09-05 10:11:43', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('206', '62', '4', '184.0', '2025-09-01 08:30:00', '2025-09-30 17:30:00', 'mes项目后端开发，前端开发，wms后端开发', '0', 'wangjunfeng', '2025-09-05 10:18:36', 'admin', '2025-09-10 13:24:16', null);
INSERT INTO `pms_project_staff_sched` VALUES ('207', '62', '6', '40.0', '2025-09-08 08:30:00', '2025-09-12 17:30:00', 'wms效果图开发', '0', 'wangjunfeng', '2025-09-05 10:19:05', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('208', '7', '4', '64.0', '2025-10-15 08:30:00', '2025-10-25 17:30:00', '现场海试', '0', 'yuguansheng', '2025-10-11 09:03:22', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('209', '72', '12', '224.0', '2025-10-09 08:30:00', '2025-11-15 17:30:00', '卫星项目开发', '2', 'wangjunfeng', '2025-10-11 09:03:35', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('210', '78', '12', '24.0', '2025-11-03 08:30:00', '2025-11-05 17:30:00', '三维模块制作', '0', 'huangfei', '2025-10-11 09:11:09', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('211', '76', '12', '16.0', '2025-10-27 08:30:00', '2025-10-28 17:30:00', '3D 模块搭建', '0', 'huangfei', '2025-10-11 09:16:50', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('212', '83', '12', '14.0', '2025-11-21 08:30:00', '2025-11-22 17:30:00', '制作岛礁交互动画', '0', 'yuguansheng', '2025-11-21 15:05:10', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('213', '83', '12', '24.0', '2025-11-26 08:30:00', '2025-11-28 17:30:00', '对接甲方中台传感器数据', '0', 'yuguansheng', '2025-11-21 15:06:08', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('214', '83', '16', '20.0', '2025-11-05 08:30:00', '2025-11-07 17:30:00', '岛礁场景搭建', '0', 'yuguansheng', '2025-11-21 15:08:14', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('215', '83', '16', '10.0', '2025-11-10 08:30:00', '2025-11-11 17:30:00', '岛礁三维场景搭建', '0', 'yuguansheng', '2025-11-21 15:08:40', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('216', '83', '16', '13.0', '2025-11-20 08:30:00', '2025-11-21 17:30:00', '岛礁场景修改', '0', 'yuguansheng', '2025-11-21 15:10:01', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('217', '83', '6', '12.0', '2025-11-11 08:30:00', '2025-11-21 17:30:00', '配合岛礁项目输出及修改UI图', '0', 'yuguansheng', '2025-11-21 15:13:55', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('218', '16', '12', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目 矩阵接口数据打通 三维效果实现', '2', 'wangjunfeng', '2025-11-25 08:38:36', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('219', '16', '9', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目后端开发', '2', 'wangjunfeng', '2025-11-25 08:38:54', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('220', '16', '35', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目前言开发', '2', 'wangjunfeng', '2025-11-25 08:39:19', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('221', '72', '12', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目矩阵接口开发 三维效果实现', '0', 'wangjunfeng', '2025-11-25 08:43:36', 'wangjunfeng', '2025-11-25 08:43:48', null);
INSERT INTO `pms_project_staff_sched` VALUES ('222', '72', '9', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目后端开发', '0', 'wangjunfeng', '2025-11-25 08:44:06', 'wangjunfeng', '2025-11-25 08:44:46', null);
INSERT INTO `pms_project_staff_sched` VALUES ('223', '72', '35', '104.0', '2025-11-24 08:30:00', '2025-12-10 17:30:00', '卫星项目前端开发', '0', 'wangjunfeng', '2025-11-25 08:44:25', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('224', '80', '16', '40.0', '2025-12-01 08:30:00', '2025-12-05 17:30:00', '工程模型优化', '0', 'liuyujia', '2025-11-28 10:06:06', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('225', '72', '16', '16.0', '2025-12-01 08:30:00', '2025-12-02 17:30:00', '配合呈现三维效果', '0', 'wangjunfeng', '2025-11-28 10:06:17', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('226', '80', '6', '40.0', '2025-12-01 08:30:00', '2025-12-05 17:30:00', '预警信息、预警配置、传感器配置、海陆传输模块高精设计', '0', 'liuyujia', '2025-11-28 10:06:53', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('227', '62', '4', '48.0', '2025-11-28 08:30:00', '2025-12-05 17:30:00', 'mes项目收尾工作', '0', 'wangjunfeng', '2025-11-28 10:09:05', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('228', '62', '10', '48.0', '2025-11-28 08:30:00', '2025-12-05 17:30:00', 'mes项目收尾工作', '0', 'wangjunfeng', '2025-11-28 10:09:22', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('229', '15', '10', '40.0', '2025-12-01 08:30:00', '2025-12-05 17:30:00', '1.本地环境创建人大金仓数据库；\n2.底层架构方案的确定及修改；\n3.开发硬件采集模拟器；\n4.梳理数据库结构差异，迁移前工作准备。', '0', 'liuyujia', '2025-11-28 10:09:51', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('230', '67', '35', '40.0', '2025-12-01 08:30:00', '2025-12-05 17:30:00', '客户需求二次修改', '0', 'huangfei', '2025-11-28 10:20:32', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('231', '67', '16', '24.0', '2025-12-03 08:30:00', '2025-12-05 17:30:00', '客户需求二次修改', '0', 'huangfei', '2025-11-28 10:20:57', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('232', '15', '10', '40.0', '2025-12-08 08:30:00', '2025-12-12 17:30:00', '1.本地环境数据库数据结构、函数、存储过程、索引等迁移修改；', '0', 'liuyujia', '2025-11-28 10:25:20', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('233', '15', '4', '40.0', '2025-12-08 08:30:00', '2025-12-12 17:30:00', '本地环境业务端代码适配修改', '0', 'liuyujia', '2025-11-28 10:25:40', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('234', '11', '28', '120.0', '2025-11-24 08:30:00', '2025-12-12 17:30:00', '交付文档从新编写完善。', '0', 'huangfei', '2025-11-28 10:25:47', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('235', '11', '5', '40.0', '2025-12-01 08:30:00', '2025-12-12 17:30:00', '配合修改文档', '0', 'huangfei', '2025-11-28 10:26:45', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('236', '15', '10', '40.0', '2025-12-15 08:30:00', '2025-12-19 17:30:00', '1.本地环境业务端代码适配修改；\n2.开发自测、功能测试；\n', '0', 'liuyujia', '2025-11-28 10:26:48', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('237', '15', '4', '40.0', '2025-12-15 08:30:00', '2025-12-19 17:30:00', '1.本地环境业务端代码适配修改； 2.开发自测、功能测试；\n', '0', 'liuyujia', '2025-11-28 10:27:09', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('238', '15', '10', '40.0', '2025-12-22 08:30:00', '2025-12-26 17:30:00', '1.云端服务器部署迁移', '0', 'liuyujia', '2025-11-28 10:27:42', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('239', '47', '9', '72.0', '2026-01-06 08:30:00', '2026-01-14 17:30:00', '额', '2', 'yuguansheng', '2026-01-12 13:21:06', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('240', '80', '9', '456.0', '2026-01-14 08:30:00', '2026-03-11 17:30:00', '后端开发', '0', 'liuyujia', '2026-01-12 13:23:10', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('241', '80', '41', '352.0', '2026-01-16 08:30:00', '2026-02-28 17:30:00', '前端页面开发', '0', 'liuyujia', '2026-01-12 13:25:15', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('242', '80', '41', '80.0', '2026-03-02 08:30:00', '2026-03-11 17:30:00', '前后端接口对接', '0', 'liuyujia', '2026-01-12 13:25:51', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('243', '47', '9', '12.0', '2026-01-29 08:30:00', '2026-01-30 17:30:00', '优化船舶demo内容', '0', 'yuguansheng', '2026-01-12 13:26:09', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('244', '80', '32', '40.0', '2026-01-12 08:30:00', '2026-01-16 17:30:00', '滑轨服务器部署', '0', 'liuyujia', '2026-01-12 13:26:29', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('245', '47', '6', '6.0', '2026-01-28 08:30:00', '2026-01-28 17:30:00', '优化船舶demo界面', '0', 'yuguansheng', '2026-01-12 13:27:03', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('246', '47', '12', '24.0', '2026-01-29 08:30:00', '2026-02-02 17:30:00', '修改船舶demo', '0', 'yuguansheng', '2026-01-12 13:28:34', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('247', '80', '16', '24.0', '2026-01-12 08:30:00', '2026-01-14 17:30:00', '模型优化', '0', 'liuyujia', '2026-01-12 13:28:47', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('248', '86', '6', '40.0', '2026-01-19 08:30:00', '2026-01-23 17:30:00', '卫星2UI设计', '0', 'wangjunfeng', '2026-01-12 13:29:40', 'wangjunfeng', '2026-01-12 13:31:39', null);
INSERT INTO `pms_project_staff_sched` VALUES ('249', '78', '10', '140.0', '2026-01-12 08:30:00', '2026-01-30 17:30:00', '后端开发', '0', 'huangfei', '2026-01-12 13:31:19', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('250', '86', '41', '232.0', '2026-01-19 08:30:00', '2026-02-16 17:30:00', '卫星2前端开发', '0', 'wangjunfeng', '2026-01-12 13:31:20', 'wangjunfeng', '2026-01-12 13:38:23', null);
INSERT INTO `pms_project_staff_sched` VALUES ('251', '80', '12', '72.0', '2026-01-19 08:30:00', '2026-01-27 17:30:00', '三维开发', '0', 'liuyujia', '2026-01-12 13:32:28', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('252', '86', '12', '232.0', '2026-01-19 08:30:00', '2026-02-16 17:30:00', '卫星2三维端开发', '0', 'wangjunfeng', '2026-01-12 13:32:55', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('253', '86', '28', '8.0', '2026-01-12 08:30:00', '2026-01-12 17:30:00', '22', '2', 'wangjunfeng', '2026-01-12 13:35:08', 'wangjunfeng', '2026-01-12 13:37:10', null);
INSERT INTO `pms_project_staff_sched` VALUES ('254', '86', '9', '232.0', '2026-01-19 08:30:00', '2026-02-16 17:30:00', '卫星2后端开发', '0', 'wangjunfeng', '2026-01-12 13:38:56', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('255', '78', '41', '80.0', '2026-01-26 08:30:00', '2026-02-06 17:30:00', '前端页面开发', '0', 'huangfei', '2026-01-12 13:39:38', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('256', '80', '5', '50.0', '2026-01-12 08:30:00', '2026-01-23 17:30:00', '交付文件编写', '0', 'liuyujia', '2026-01-12 13:39:54', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('257', '80', '5', '48.0', '2026-01-22 08:30:00', '2026-01-27 17:30:00', '一期测试', '0', 'liuyujia', '2026-01-12 13:40:18', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('258', '62', '4', '40.0', '2026-02-02 08:30:00', '2026-02-06 17:30:00', 'mes工厂需求改造', '0', 'wangjunfeng', '2026-01-12 13:41:08', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('259', '62', '41', '40.0', '2026-02-02 08:30:00', '2026-02-06 17:30:00', 'mes工厂需求改造', '0', 'wangjunfeng', '2026-01-12 13:41:33', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('260', '80', '5', '50.0', '2026-03-09 08:30:00', '2026-03-18 17:30:00', '功能测试', '0', 'liuyujia', '2026-01-12 13:41:40', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('261', '78', '12', '40.0', '2026-02-02 08:30:00', '2026-02-06 17:30:00', '三维功能开发\n', '0', 'huangfei', '2026-01-12 13:44:44', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('262', '77', '10', '24.0', '2026-02-26 08:30:00', '2026-02-28 17:30:00', '前后端联调', '0', 'renjiaxu', '2026-01-12 14:05:21', 'renjiaxu', '2026-01-12 15:01:21', null);
INSERT INTO `pms_project_staff_sched` VALUES ('263', '77', '41', '24.0', '2026-02-26 08:30:00', '2026-02-28 17:30:00', '前后端联调', '0', 'renjiaxu', '2026-01-12 14:06:00', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('264', '77', '10', '160.0', '2026-01-19 08:30:00', '2026-02-13 17:30:00', '后端开发', '0', 'renjiaxu', '2026-01-12 14:08:36', 'renjiaxu', '2026-01-12 15:01:11', null);
INSERT INTO `pms_project_staff_sched` VALUES ('265', '77', '41', '40.0', '2026-02-02 08:30:00', '2026-02-06 17:30:00', '前端开发', '0', 'renjiaxu', '2026-01-12 14:14:51', 'renjiaxu', '2026-01-12 14:33:58', null);
INSERT INTO `pms_project_staff_sched` VALUES ('266', '77', '6', '80.0', '2026-01-19 08:30:00', '2026-01-30 17:30:00', 'UI高精图制作', '0', 'renjiaxu', '2026-01-12 14:35:17', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('267', '63', '39', '264.0', '2026-01-05 08:30:00', '2026-02-06 17:30:00', '算法功能开发和 3D 展示数据集准备  ', '0', 'huangfei', '2026-01-12 14:51:15', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('268', '63', '4', '80.0', '2026-01-26 08:30:00', '2026-02-16 17:30:00', '后端接口和算法对接功能开发 ', '0', 'huangfei', '2026-01-12 14:54:05', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('269', '62', '4', '40.0', '2026-01-12 08:30:00', '2026-01-16 17:30:00', '焊接机器人对接与小程序扫码功能开发', '0', 'wangjunfeng', '2026-01-12 14:54:07', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('270', '63', '41', '24.0', '2026-02-02 08:30:00', '2026-02-17 17:30:00', '前端页面开发 ', '0', 'huangfei', '2026-01-12 14:54:46', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('271', '72', '12', '96.0', '2026-01-12 08:30:00', '2026-01-23 17:30:00', '验收后调整', '0', 'wangjunfeng', '2026-01-12 15:05:46', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('272', '72', '9', '80.0', '2026-01-12 08:30:00', '2026-01-21 17:30:00', '验收后调整', '0', 'wangjunfeng', '2026-01-12 15:06:26', '', null, null);
INSERT INTO `pms_project_staff_sched` VALUES ('273', '72', '41', '80.0', '2026-01-12 08:30:00', '2026-01-21 17:30:00', '验收后调整', '0', 'wangjunfeng', '2026-01-12 15:06:44', '', null, null);
