/*
Navicat MySQL Data Transfer

Source Server         : mysql57-localhost
Source Server Version : 50738
Source Host           : localhost:33061
Source Database       : kml-pms

Target Server Type    : MYSQL
Target Server Version : 50738
File Encoding         : 65001

Date: 2026-01-23 17:25:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept` (
  `dept_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint(20) DEFAULT '0' COMMENT '父部门id',
  `ancestors` varchar(50) DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) DEFAULT '' COMMENT '部门名称',
  `order_num` int(11) DEFAULT '0' COMMENT '显示顺序',
  `leader` varchar(20) DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) DEFAULT NULL COMMENT '邮箱',
  `status` char(1) DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  PRIMARY KEY (`dept_id`)
) ENGINE=InnoDB AUTO_INCREMENT=201 DEFAULT CHARSET=utf8mb4 COMMENT='部门表';

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES ('100', '0', '0', '总部', '0', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-16 10:53:36');
INSERT INTO `sys_dept` VALUES ('101', '100', '0,100', '大连总公司', '1', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-21 18:17:30');
INSERT INTO `sys_dept` VALUES ('102', '100', '0,100', '分公司', '2', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-21 18:17:57');
INSERT INTO `sys_dept` VALUES ('103', '101', '0,100,101', '软件研发部', '1', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-21 18:18:23');
INSERT INTO `sys_dept` VALUES ('104', '101', '0,100,101', '人事行政部', '2', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-22 08:39:38');
INSERT INTO `sys_dept` VALUES ('105', '101', '0,100,101', '信息管理部', '3', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-22 08:39:52');
INSERT INTO `sys_dept` VALUES ('106', '103', '0,100,101,103', '研发一部', '4', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-21 18:33:46');
INSERT INTO `sys_dept` VALUES ('107', '103', '0,100,101,103', '研发二部', '5', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-21 18:34:01');
INSERT INTO `sys_dept` VALUES ('108', '103', '0,100,101,103', '研发三部', '6', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', 'admin', '2024-08-22 08:41:59');
INSERT INTO `sys_dept` VALUES ('109', '102', '0,100,102', '财务部门', '2', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-12 16:23:25', '', null);
INSERT INTO `sys_dept` VALUES ('200', '102', '0,100,102', '市场部门', '3', '科迈尔', '15888888888', 'kingmile@kingmile.com', '0', '0', 'admin', '2024-08-22 08:40:23', '', null);
