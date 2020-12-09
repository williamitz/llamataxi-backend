/*
 Navicat Premium Data Transfer

 Source Server         : local-llamataxi-dev
 Source Server Type    : MySQL
 Source Server Version : 100413
 Source Host           : localhost:3306
 Source Schema         : llamataxi_db

 Target Server Type    : MySQL
 Target Server Version : 100413
 File Encoding         : 65001

 Date: 04/12/2020 13:46:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for rb_config_referal
-- ----------------------------
DROP TABLE IF EXISTS `rb_config_referal`;
CREATE TABLE `rb_config_referal`  (
  `pkConfigReferal` tinyint(1) NOT NULL AUTO_INCREMENT,
  `amountClient` float(4, 2) NOT NULL,
  `bonusCliRef` float(4, 2) NULL DEFAULT 0,
  `amountDriver` float(4, 2) NOT NULL,
  `bonusDriRef` float(4, 2) NULL DEFAULT 0,
  `daysExpClient` tinyint(2) NULL DEFAULT NULL,
  `daysExpDriver` tinyint(2) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NOT NULL,
  `fkUserUpdate` int(11) NOT NULL,
  `ipUserUpdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`pkConfigReferal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of rb_config_referal
-- ----------------------------
INSERT INTO `rb_config_referal` VALUES (1, 2.00, 2.00, 15.00, 10.00, 10, 30, '2020-11-09 12:18:44', 3, '::1');

SET FOREIGN_KEY_CHECKS = 1;
