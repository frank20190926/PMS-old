/*
Navicat MySQL Data Transfer

Source Server         : mysql57-localhost
Source Server Version : 50738
Source Host           : localhost:33061
Source Database       : kml-pms

Target Server Type    : MYSQL
Target Server Version : 50738
File Encoding         : 65001

Date: 2026-01-23 17:25:15
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user` (
  `user_id` bigint(20) NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint(20) DEFAULT NULL COMMENT '部门ID',
  `user_name` varchar(30) NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) DEFAULT '' COMMENT '手机号码',
  `sex` char(1) DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) DEFAULT '' COMMENT '密码',
  `cost` decimal(10,2) DEFAULT '0.00' COMMENT '人员成本',
  `status` char(1) DEFAULT '0' COMMENT '帐号状态（0正常 1停用）',
  `del_flag` char(1) DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime DEFAULT NULL COMMENT '最后登录时间',
  `create_by` varchar(64) DEFAULT '' COMMENT '创建者',
  `create_time` datetime DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) DEFAULT '' COMMENT '更新者',
  `update_time` datetime DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=42 DEFAULT CHARSET=utf8mb4 COMMENT='用户信息表';

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES ('1', '100', 'admin', 'admin', '00', 'kingmile@kingmile.com', '15888888888', '1', '', '$2a$10$ERb5z4DIo0BIZAZGW49UHebgpQozpJ55zxrlH3l1fIrZVPOc2aXx.', '0.00', '0', '0', '113.235.127.69', '2026-01-13 14:45:01', 'admin', '2024-08-12 16:23:25', '', '2026-01-13 14:45:01', '管理员');
INSERT INTO `sys_user` VALUES ('2', '100', 'leader', 'leader', '00', 'leader@kingmile.com', '', '2', '', '$2a$10$W8CH4Jsi8ZuodjjNdPROAuNNxLQlalNKWE/6Py0o4pJZs5oJyQuOi', '0.00', '0', '0', '113.235.122.130', '2026-01-21 16:26:08', 'admin', '2024-08-12 16:23:25', 'admin', '2026-01-21 16:26:08', '管理员');
INSERT INTO `sys_user` VALUES ('3', '103', 'zourunxuan', '邹润轩', '00', 'zourunxuan@kingmile.com', '', '2', '', '$2a$10$0YjHFnptVfPMDnNLxwBvR.bJ1HFaW3a1PAl6oHKrRdD/Ch/Q7PDqK', '0.00', '0', '0', '116.3.195.236', '2025-09-11 14:17:02', 'admin', '2024-08-12 16:23:25', 'leader', '2025-09-11 14:17:02', '');
INSERT INTO `sys_user` VALUES ('4', '103', 'mengqiang', '孟强', '00', 'mengqiang@kingmile.com', '', '2', '', '$2a$10$rSRhIjbf9JUgRCyzNHYqTOtEw/VT5a9iqYgDwaA2IPIfgEiilym7e', '23925.00', '0', '0', '113.235.122.130', '2026-01-15 14:09:04', 'admin', '2024-08-12 16:23:25', 'admin', '2026-01-15 14:09:04', '');
INSERT INTO `sys_user` VALUES ('5', '103', 'liuyujia', '刘羽佳', '00', 'liuyujia@kingmile.com', '', '2', '', '$2a$10$D5wo2cTwaxMdYmFpiAq/JOaGIvZRDqvo6CszkRzW7Td4SJucJw50W', '15225.00', '0', '0', '113.235.122.130', '2026-01-21 08:54:00', 'admin', '2024-08-12 16:23:25', 'admin', '2026-01-21 08:54:00', '');
INSERT INTO `sys_user` VALUES ('6', '103', 'tongmingru', '佟明儒', '00', 'tongmingru@kingmile.com', '', '2', '', '$2a$10$8eC0zZbVgrIIomyleGNg4OOUXuqwUyjpZeYk.9e2JVtqxqHcrX3Hm', '17400.00', '0', '0', '113.235.127.136', '2026-01-23 09:52:19', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-23 09:52:18', '');
INSERT INTO `sys_user` VALUES ('7', '103', 'duxiaofei', '杜晓飞', '00', 'duxiaofei@kingmile.com', '', '2', '', '$2a$10$yrb3ewXLcdfnRgVk4t3rOeuK.7Q0YUcQPu3LJxO6jsaYWK.TPbTBa', '23925.00', '1', '0', '42.84.238.18', '2024-12-13 08:52:31', 'admin', '2024-08-12 16:23:25', 'leader', '2024-12-20 09:42:20', '');
INSERT INTO `sys_user` VALUES ('8', '103', 'majian', '马剑', '00', 'majian@kingmile.com', '', '2', '', '$2a$10$wwR5hJQvaccCKb45LUIkC.XBYv6avb2cOjuIxhYBKG/Oz4ykhbM0G', '23925.00', '1', '0', '42.84.40.94', '2024-12-02 09:35:23', 'admin', '2024-08-12 16:23:25', 'admin', '2024-12-02 23:01:07', '');
INSERT INTO `sys_user` VALUES ('9', '103', 'wangliang', '王亮', '00', 'wangliang@kingmile.com', '', '2', '', '$2a$10$JCbFyxNuuqdYWLiTt9zgoukjRAWmIJ74nqqczaEtVxF2MULrx.UDG', '28275.00', '0', '0', '123.177.19.18', '2026-01-21 17:05:55', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-21 17:05:54', '');
INSERT INTO `sys_user` VALUES ('10', '103', 'linke', '林棵', '00', 'linke@kingmile.com', '', '2', '', '$2a$10$SZE0Zjaf5C/yP.gJ3noVye7UrxKT6r6ONMj3cqznbWkEWR28EZTJG', '23925.00', '0', '0', '113.235.127.69', '2026-01-23 15:32:45', 'admin', '2024-08-12 16:23:25', 'admin', '2026-01-23 15:32:45', '');
INSERT INTO `sys_user` VALUES ('11', '103', 'xujingxiang', '许景翔', '00', 'xujingxiang@kingmile.com', '', '2', '', '$2a$10$jWpdzsDO4luyvfSzq8SpNOOQq6zBnY/E4HikEDZnqxTfr8MGcsECG', '23925.00', '1', '0', '42.84.233.115', '2024-11-29 16:55:04', 'admin', '2024-08-12 16:23:25', 'admin', '2024-11-29 17:03:05', '');
INSERT INTO `sys_user` VALUES ('12', '103', 'quchunlin', '曲春霖', '00', 'quchunlin@kingmile.com', '', '2', '', '$2a$10$4imP/eHC0.8KaKEBIAZ5kOXCuqbT//wJc.Ce3vFc8ihE8jdVUB/k.', '28275.00', '0', '0', '113.235.122.130', '2026-01-16 17:33:45', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-16 17:33:44', '');
INSERT INTO `sys_user` VALUES ('13', '103', 'gaoyongsheng', '高永盛', '00', 'gaoyongsheng@kingmile.com', '', '2', '', '$2a$10$DY5jmJ//ZA2qYyFZgGBJHudUqEwBzT5lrFSSMmhxI6Z3A3n1p4r0q', '23925.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:30:48', '');
INSERT INTO `sys_user` VALUES ('14', '103', 'sunhaotian', '孙昊天', '00', 'sunhaotian@kingmile.com', '', '2', '', '$2a$10$mnymLt43UkLU0lxeyoBw1OOyIbYwTWsYBcABJzm4mK3OoGQ10EiAm', '23925.00', '1', '0', '175.162.0.140', '2025-12-17 11:19:20', 'admin', '2024-08-12 16:23:25', 'admin', '2025-12-17 13:56:33', '');
INSERT INTO `sys_user` VALUES ('15', '103', 'zhangchengbo', '张成博', '00', 'zhangchengbo@kingmile.com', '', '2', '', '$2a$10$ZA.JJBDvhQxxKgiRTSyK0ug9R1V.Rpzb9mTilwy4It11w5YACKkce', '23925.00', '1', '0', '42.84.233.115', '2024-11-29 16:56:14', 'admin', '2024-08-12 16:23:25', 'admin', '2024-12-02 23:00:48', '');
INSERT INTO `sys_user` VALUES ('16', '103', 'qiaozhi', '乔治', '00', 'qiaozhi@kingmile.com', '13190130512', '0', '', '$2a$10$KbinZ0EJRz/S8xVCjDOTaO3aJUdINTmxHEUm0qDDxmg6xRZGGVhs.', '13050.00', '0', '0', '113.235.127.136', '2026-01-21 18:59:01', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-21 18:59:00', '');
INSERT INTO `sys_user` VALUES ('17', '103', 'xuguoyao', '徐国尧', '00', 'xuguoyao@kingmile.com', '', '2', '', '$2a$10$nETtkp3cC0KovySzU/BQpuENJ2RMEg/Nve2VbXgyQgLNpanVMfhuK', '15225.00', '1', '0', '42.84.238.39', '2024-12-13 08:51:48', 'admin', '2024-08-12 16:23:25', 'leader', '2025-11-19 11:37:20', '');
INSERT INTO `sys_user` VALUES ('18', '105', 'hanjiazhuang', '韩家状', '00', 'hanjiazhuang@kingmile.com', '', '2', '', '$2a$10$ypJBWDyE9eAG4jWu4rIoSu/dXjHpskgJlfGot4EqO7G.oHygYnkFy', '23925.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:30:14', '');
INSERT INTO `sys_user` VALUES ('19', '104', 'huke', '胡克', '00', 'huke@kingmile.com', '', '2', '', '$2a$10$sx5TthH54C.5Rwmic7iD0enoNkqE7xBJlBaJNzY9WiHZ314XO3jCy', '0.00', '0', '0', '60.21.109.236', '2024-09-06 16:22:29', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-06 16:22:29', '');
INSERT INTO `sys_user` VALUES ('20', '104', 'liusiyu', '刘思瑜', '00', 'liusiyu@kingmile.com', '', '2', '', '$2a$10$hJO0WRHJnyQybwzI6x25muFekBZhNYrj1QYfBc3PM9HsZ0ttdEsf.', '0.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'leader', '2024-12-20 09:43:58', '');
INSERT INTO `sys_user` VALUES ('21', '104', 'zhengjiawen', '郑迦文', '00', 'zhengjiawen@kingmile.com', '', '2', '', '$2a$10$S2zwfjA3q11a2nbPyDvCaeWiTs9qBFaZ.RAIb5/MIFYTgHeNXvHMa', '0.00', '0', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:28:37', '');
INSERT INTO `sys_user` VALUES ('22', '104', 'yanlihui', '闫黎晖', '00', 'yanlihui@kingmile.com', '', '2', '', '$2a$10$b1X0EOc/Gva/dmxisgEK3.DXlEd2R4p967FwEBL7y0enE7jhpYvuC', '0.00', '0', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:28:47', '');
INSERT INTO `sys_user` VALUES ('23', '104', 'gaonan', '高楠', '00', 'gaonan@kingmile.com', '', '2', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:28:54', '');
INSERT INTO `sys_user` VALUES ('24', '104', 'wanglei', '王垒', '00', 'wanglei@kingmile.com', '', '2', '', '$2a$10$/Bumnw6Mg.mebEvB3tLPsOmaRtqfCggaGgQXyqdxaNWNxpMkmDKK6', '0.00', '0', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:29:01', '');
INSERT INTO `sys_user` VALUES ('25', '103', 'zhanglianxin', '张连新', '00', 'zhanglianxin@kingmile.com', '', '2', '', '$2a$10$gmGoD1WqNNktjtzWzndoguQ2ETnjy326FyoiJbjiaX38TcAVkc/82', '23925.00', '1', '0', '42.84.233.158', '2024-11-29 16:42:20', 'admin', '2024-08-12 16:23:25', 'admin', '2024-12-02 23:01:16', '');
INSERT INTO `sys_user` VALUES ('26', '108', 'chenyuxi', '陈语曦', '00', 'chenyuxi@kingmile.com', '', '2', '', '$2a$10$MS/KVN9khjx8SF4uY8FivOtXg4qOsHO22uXHGvHA2Q9ylpBxECzwi', '23925.00', '1', '0', '175.162.0.140', '2025-12-17 11:32:49', 'admin', '2024-08-12 16:23:25', 'admin', '2025-12-17 13:56:22', '');
INSERT INTO `sys_user` VALUES ('27', '103', 'zhongweihua', '钟伟华', '00', 'zhongweihua@kingmile.com', '15134289291', '2', '', '$2a$10$S61eZxhby9t6uDtVh168I.JVTTCE4Lfg5Jkh.gk6ch8riSqPZBlUS', '23925.00', '1', '0', '39.144.55.78', '2025-02-21 13:43:17', 'admin', '2024-08-12 16:23:25', 'admin', '2025-04-11 10:53:11', '');
INSERT INTO `sys_user` VALUES ('28', '106', 'huangfei', '黄飞', '00', 'huangfei@kingmile.com', '15642326662', '0', '', '$2a$10$tCaKRvMDKhCO1irxyd9zc.yBLiT2efRkualZ65GGPKLMutx0fx/Hq', '21750.00', '0', '0', '113.235.122.130', '2026-01-21 08:52:54', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-21 08:52:54', '');
INSERT INTO `sys_user` VALUES ('29', '105', 'shenyanjie', '沈彦杰', '00', 'shenyanjie@kingmile.com', '', '2', '', '$2a$10$1tGinnFmINiCtybak8NWm.ZfmhNmdplJAr4e4XRY6T1JiMPWq5XaO', '0.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'leader', '2024-12-20 09:43:34', '');
INSERT INTO `sys_user` VALUES ('30', '103', 'dongfachang', '董发昌', '00', 'dongfachang@kingmile.com', '', '2', '', '$2a$10$9jk3ARsR2vt3fTyXWhKCcOUsRSI1xDf7/4HhtwoPQOsiZ0WQdPmTC', '23925.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'admin', '2024-09-04 18:29:47', '');
INSERT INTO `sys_user` VALUES ('31', '105', 'infomanage', '信息部管理员', '00', 'infomanage@kingmile.com', '', '2', '', '$2a$10$s3EbXqh4ASF8QFyrS6vDkOjKKixzTfWTmBOY2CK2Zfpkr73ScA4Q6', '0.00', '1', '0', '192.168.1.11', '2024-08-20 18:16:01', 'admin', '2024-08-12 16:23:25', 'leader', '2024-12-20 09:43:29', '');
INSERT INTO `sys_user` VALUES ('32', '103', 'xutao', '徐涛', '00', 'xutao@kingmile.com', '15504256256', '0', '', '$2a$10$vYUbEafSAYs19VpprVq9V.VUbasPe6BUad81u5B94o74nmKGf66ka', '10875.00', '0', '0', '113.235.122.130', '2026-01-16 10:25:32', 'admin', '2024-08-12 16:23:25', 'leader', '2026-01-16 10:25:31', '');
INSERT INTO `sys_user` VALUES ('33', '103', 'zengfanci', '曾凡慈', '00', 'zengfanci@kingmile.com', '', '2', '', '$2a$10$o2D2hhphaRqcJ.RkMhgfEeh3Fp8chHdGEog9TVy8DlqpiXv7dIrMe', '23925.00', '1', '0', '42.84.233.210', '2024-12-13 10:16:59', 'admin', '2024-08-12 16:23:25', 'leader', '2024-12-20 09:42:39', '');
INSERT INTO `sys_user` VALUES ('34', '107', 'xiuming', '修明', '00', '', '', '0', '', '$2a$10$slSD5s2bJhFvAKRay8/0VeWthDmf3qfPsJRDR8ow9BvNPMWewbDCy', '15225.00', '0', '0', '175.162.0.140', '2025-12-17 13:30:29', 'admin', '2024-09-10 17:22:36', 'admin', '2025-12-17 13:30:28', null);
INSERT INTO `sys_user` VALUES ('35', '103', 'tenghaoxiang', '滕灏翔', '00', '', '', '0', '', '$2a$10$aU84rGn1lbkGx1NhqYFPO.B0PrXbKlAmxRmxncwZsluwAPIAjGvOe', '15225.00', '1', '0', '175.162.0.140', '2025-12-17 13:42:29', 'admin', '2025-02-25 11:23:05', 'leader', '2026-01-12 15:09:41', null);
INSERT INTO `sys_user` VALUES ('36', '107', 'yuguansheng', '于官圣', '00', '', '', '0', '', '$2a$10$z93/2V1k3spIq6VwG4kxA.KVAKl0BN0jc2.ZVJ/MTkSh3mUc4.mES', '21750.00', '0', '0', '113.235.127.136', '2026-01-23 09:14:38', 'admin', '2025-03-17 14:49:58', 'leader', '2026-01-23 09:14:38', null);
INSERT INTO `sys_user` VALUES ('37', '107', 'wangjunfeng', '王君封', '00', '', '', '0', '', '$2a$10$jNZfuuggCVQRokbAd0D/nO492gGFXaESgNTT0.pBSdByyrR955FRG', '19575.00', '0', '0', '123.177.19.18', '2026-01-23 13:23:41', 'admin', '2025-03-31 15:50:25', 'leader', '2026-01-23 13:23:41', null);
INSERT INTO `sys_user` VALUES ('38', '108', 'renjiaxu', '任佳旭', '00', '', '', '0', '', '$2a$10$86M2YTIqd.sfCfyt0b.1J.O/auYko//f4u4YLIxtjm.hr3SUVYCOW', '10875.00', '0', '0', '113.235.127.69', '2026-01-23 09:04:17', 'admin', '2025-08-04 09:18:12', 'leader', '2026-01-23 09:04:17', null);
INSERT INTO `sys_user` VALUES ('39', '108', 'liushengchi', '刘晟池', '00', '', '', '0', '', '$2a$10$IB4ivrASjXJX8nBKA.s3D.Jjnh5eHXJ6oxE7WPbdPLP1yWW5V119i', '17400.00', '0', '0', '104.28.158.90', '2026-01-23 08:51:09', 'admin', '2025-08-05 09:49:53', 'leader', '2026-01-23 08:51:09', null);
INSERT INTO `sys_user` VALUES ('40', '103', 'jinzilai', '金梓来', '00', '', '', '0', '', '$2a$10$feNCmdd5PwBekvVCylex5.fd1OnEMw9S1cxR8S/r3qnB3v7LdsKx2', '15225.00', '1', '0', '175.162.0.140', '2025-11-25 14:55:36', 'admin', '2025-10-20 13:17:15', 'admin', '2025-11-28 10:12:01', null);
INSERT INTO `sys_user` VALUES ('41', '103', 'wangcong', '王聪', '00', '', '', '0', '', '$2a$10$UBv8Ej/sx4CIWftG6K1Ld.JbOCkhhqwegC0qHbEhxqgXdWjvfC9b6', '15225.00', '0', '0', '39.144.53.136', '2026-01-23 13:20:42', 'admin', '2025-12-08 11:15:36', 'admin', '2026-01-23 13:20:41', null);
