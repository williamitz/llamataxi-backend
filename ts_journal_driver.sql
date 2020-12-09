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

 Date: 04/12/2020 10:51:19
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for ts_journal_driver
-- ----------------------------
DROP TABLE IF EXISTS `ts_journal_driver`;
CREATE TABLE `ts_journal_driver`  (
  `pkJournalDriver` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkConfigJournal` tinyint(255) NULL DEFAULT NULL,
  `fkDriver` int(255) NULL DEFAULT NULL,
  `codeJournal` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateStart` datetime(0) NULL DEFAULT NULL,
  `dateEnd` datetime(0) NULL DEFAULT NULL,
  `journalStatus` tinyint(1) NULL DEFAULT NULL,
  `paidOut` tinyint(255) NULL DEFAULT 0,
  `datePaid` datetime(0) NULL DEFAULT NULL,
  `illPay` tinyint(1) NULL DEFAULT 1,
  `cardCulqui` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `chargeCulqui` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `chargeAmount` int(5) NULL DEFAULT NULL,
  `totalCash` float(10, 2) NULL DEFAULT 0,
  `totalCard` float(10, 2) NULL DEFAULT 0,
  `totalCredit` float(10, 2) NULL DEFAULT 0,
  `totalDiscount` float(10, 2) NULL DEFAULT 0,
  `countService` int(255) NULL DEFAULT 0,
  `nameJournal` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rateJournal` float(5, 2) NULL DEFAULT NULL,
  `modeJournal` varchar(8) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT 1,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkLiquidation` bigint(20) NULL DEFAULT 0,
  `liquidated` tinyint(4) NULL DEFAULT 0,
  `dateLiquidated` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`pkJournalDriver`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 11 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

SET FOREIGN_KEY_CHECKS = 1;
