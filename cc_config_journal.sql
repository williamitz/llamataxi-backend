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

 Date: 04/12/2020 10:47:31
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for cc_config_journal
-- ----------------------------
DROP TABLE IF EXISTS `cc_config_journal`;
CREATE TABLE `cc_config_journal`  (
  `pkConfigJournal` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nameJournal` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rateJournal` float(4, 2) NULL DEFAULT NULL,
  `modeJournal` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `advancePayment` tinyint(1) NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT 1,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fkUserUpdate` int(10) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(10) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkConfigJournal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Records of cc_config_journal
-- ----------------------------
INSERT INTO `cc_config_journal` VALUES (1, 'Tarifa plana', 5.00, 'FORTODAY', 1, 1, 3, '2020-11-02 12:03:00', '::1', NULL, NULL, NULL, NULL, NULL, NULL);
INSERT INTO `cc_config_journal` VALUES (2, 'Tarifa ocasional', 1.00, 'FORSERVI', 0, 1, 3, '2020-11-02 12:21:03', '::1', 3, '2020-11-02 12:47:57', '::1', 3, '2020-11-02 12:47:51', '::1');

SET FOREIGN_KEY_CHECKS = 1;
