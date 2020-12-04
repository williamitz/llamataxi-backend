/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100121
 Source Schema         : llamataxi_db

 Target Server Type    : MySQL
 Target Server Version : 100121
 File Encoding         : 65001

 Date: 03/12/2020 09:24:09
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for as_menu_role
-- ----------------------------
DROP TABLE IF EXISTS `as_menu_role`;
CREATE TABLE `as_menu_role`  (
  `pkMenuRole` int(10) NOT NULL AUTO_INCREMENT,
  `fkNavChildren` int(10) NOT NULL,
  `role` varchar(255) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NOT NULL,
  `fkUserRegister` int(10) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(10) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(10) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkMenuRole`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of as_menu_role
-- ----------------------------
INSERT INTO `as_menu_role` VALUES (1, 1, 'WEBMASTER_ROLE', 1, 1, '2020-05-01 10:35:10', '::1', 1, '2020-05-20 14:41:27', '::ffff:192.168.1.40', 1, '2020-05-01 18:07:48', '::1');
INSERT INTO `as_menu_role` VALUES (2, 2, 'WEBMASTER_ROLE', 1, 1, '2020-05-12 00:32:18', '::1', 1, '2020-05-20 14:41:20', '::ffff:192.168.1.40', NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (3, 4, 'WEBMASTER_ROLE', 1, 1, '2020-05-20 14:42:03', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (4, 3, 'WEBMASTER_ROLE', 1, 1, '2020-05-20 14:42:18', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (5, 3, 'ATTENTION_ROLE', 1, 1, '2020-05-20 14:42:24', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (6, 5, 'ADMIN_ROLE', 1, 1, '2020-05-20 15:01:19', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (7, 6, 'ADMIN_ROLE', 1, 1, '2020-05-20 15:01:23', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (8, 7, 'ADMIN_ROLE', 1, 1, '2020-05-20 15:01:29', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (9, 10, 'WEBMASTER_ROLE', 1, 1, '2020-05-20 16:27:31', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (10, 8, 'WEBMASTER_ROLE', 1, 1, '2020-05-20 22:02:43', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (11, 8, 'ATTENTION_ROLE', 1, 1, '2020-05-20 23:17:05', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (12, 9, 'ATTENTION_ROLE', 1, 1, '2020-05-20 23:17:22', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (13, 11, 'WEBMASTER_ROLE', 1, 1, '2020-05-26 18:17:16', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (14, 12, 'WEBMASTER_ROLE', 1, 1, '2020-05-26 18:17:27', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (15, 3, 'ADMIN_ROLE', 1, 1, '2020-05-28 01:21:17', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (16, 9, 'WEBMASTER_ROLE', 1, 1, '2020-05-28 04:15:42', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (17, 5, 'ATTENTION_ROLE', 1, 1, '2020-05-28 13:29:13', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (18, 6, 'ATTENTION_ROLE', 1, 1, '2020-05-28 13:29:22', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (19, 8, 'ADMIN_ROLE', 1, 1, '2020-05-28 17:00:23', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (20, 9, 'ADMIN_ROLE', 1, 1, '2020-05-28 17:00:30', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (21, 6, 'WEBMASTER_ROLE', 1, 1, '2020-07-13 15:26:41', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (22, 5, 'WEBMASTER_ROLE', 1, 1, '2020-07-13 15:26:47', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (23, 13, 'WEBMASTER_ROLE', 1, 1, '2020-08-15 20:16:25', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (24, 13, 'ADMIN_ROLE', 1, 1, '2020-08-15 20:16:35', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (25, 13, 'ATTENTION_ROLE', 1, 1, '2020-08-15 20:16:48', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (26, 12, 'ADMIN_ROLE', 1, 1, '2020-08-21 15:13:57', '::ffff:127.0.0.1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (27, 14, 'WEBMASTER_ROLE', 1, 1, '2020-10-26 09:33:59', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (28, 15, 'WEBMASTER_ROLE', 1, 1, '2020-10-26 12:00:31', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (29, 16, 'WEBMASTER_ROLE', 1, 1, '2020-10-30 16:05:45', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (30, 15, 'ATTENTION_ROLE', 1, 1, '2020-11-13 15:04:20', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (31, 14, 'ATTENTION_ROLE', 1, 1, '2020-11-13 15:04:52', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (32, 17, 'WEBMASTER_ROLE', 1, 1, '2020-11-18 09:43:14', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (33, 18, 'WEBMASTER_ROLE', 1, 1, '2020-11-19 10:44:01', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (34, 19, 'WEBMASTER_ROLE', 1, 1, '2020-11-30 09:43:13', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (35, 19, 'ADMIN_ROLE', 1, 1, '2020-11-30 09:43:20', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `as_menu_role` VALUES (36, 19, 'ATTENTION_ROLE', 1, 1, '2020-11-30 09:43:26', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL);

SET FOREIGN_KEY_CHECKS = 1;
