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

 Date: 06/11/2020 17:57:28
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for as_application
-- ----------------------------
DROP TABLE IF EXISTS `as_application`;
CREATE TABLE `as_application`  (
  `pkApplication` int(10) NOT NULL AUTO_INCREMENT,
  `nameApp` varchar(40) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `description` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `plattform` varchar(10) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkApplication`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_brand
-- ----------------------------
DROP TABLE IF EXISTS `as_brand`;
CREATE TABLE `as_brand`  (
  `pkBrand` tinyint(5) NOT NULL AUTO_INCREMENT,
  `fkCategory` tinyint(1) NOT NULL,
  `nameBrand` varchar(255) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkBrand`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 103 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_category
-- ----------------------------
DROP TABLE IF EXISTS `as_category`;
CREATE TABLE `as_category`  (
  `pkCategory` tinyint(1) NOT NULL AUTO_INCREMENT,
  `nameCategory` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `aliasCategory` varchar(30) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `codeCategory` varchar(10) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkCategory`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_chart
-- ----------------------------
DROP TABLE IF EXISTS `as_chart`;
CREATE TABLE `as_chart`  (
  `pkChart` int(255) NOT NULL AUTO_INCREMENT,
  `traffic` int(255) NULL DEFAULT NULL,
  `newUsers` int(255) NULL DEFAULT NULL,
  `taxiServices` int(255) NULL DEFAULT NULL,
  `veriffiedDrivers` int(255) NULL DEFAULT NULL,
  `chartMonth` tinyint(255) NULL DEFAULT NULL,
  `chartYear` int(255) NULL DEFAULT NULL,
  PRIMARY KEY (`pkChart`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for as_driver
-- ----------------------------
DROP TABLE IF EXISTS `as_driver`;
CREATE TABLE `as_driver`  (
  `pkDriver` int(10) NOT NULL AUTO_INCREMENT,
  `fkPerson` int(10) NOT NULL,
  `imgLicense` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateLicenseExpiration` date NOT NULL,
  `isEmployee` tinyint(1) NOT NULL,
  `imgPhotoCheck` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgCriminalRecord` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgPolicialRecord` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `percentProfile` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
  `fkVehicleUsing` int(20) NULL DEFAULT NULL,
  PRIMARY KEY (`pkDriver`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1859 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_log_activity
-- ----------------------------
DROP TABLE IF EXISTS `as_log_activity`;
CREATE TABLE `as_log_activity`  (
  `pkLogActivity` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkPerson` int(255) NULL DEFAULT NULL,
  `nameActivity` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `descriptionActivity` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `classIcon` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'success',
  `dateActivity` datetime(0) NULL DEFAULT NULL,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkLogActivity`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6389 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

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
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_message
-- ----------------------------
DROP TABLE IF EXISTS `as_message`;
CREATE TABLE `as_message`  (
  `pkMessage` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkUserEmisor` int(255) NOT NULL,
  `fkUserReceptor` int(255) NOT NULL,
  `subject` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT '',
  `message` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `tags` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `statusRegister` tinyint(1) NOT NULL,
  `archived` tinyint(1) NOT NULL,
  `dateArchived` datetime(0) NULL DEFAULT NULL,
  `fkUserRegister` int(255) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isResponse` tinyint(255) NULL DEFAULT 0,
  `fkMessage` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '0',
  `readed` tinyint(1) NULL DEFAULT 0,
  `dateReaded` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`pkMessage`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 76816 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_model
-- ----------------------------
DROP TABLE IF EXISTS `as_model`;
CREATE TABLE `as_model`  (
  `pkModel` int(5) NOT NULL AUTO_INCREMENT,
  `fkCategory` tinyint(5) NULL DEFAULT NULL,
  `fkBrand` tinyint(5) NULL DEFAULT NULL,
  `nameModel` varchar(80) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkModel`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 321 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_nationality
-- ----------------------------
DROP TABLE IF EXISTS `as_nationality`;
CREATE TABLE `as_nationality`  (
  `pkNationality` int(255) NOT NULL AUTO_INCREMENT,
  `isoAlfaTwo` char(2) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameCountry` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isoNumber` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isoAlfaThree` char(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `prefixPhone` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkNationality`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 241 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_nav_children
-- ----------------------------
DROP TABLE IF EXISTS `as_nav_children`;
CREATE TABLE `as_nav_children`  (
  `pkNavChildren` int(10) NOT NULL AUTO_INCREMENT,
  `fkNavFather` int(10) NOT NULL,
  `navChildrenText` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `navChildrenPath` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `navChildrenIcon` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  `isVisible` tinyint(255) NULL DEFAULT 1,
  PRIMARY KEY (`pkNavChildren`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_nav_father
-- ----------------------------
DROP TABLE IF EXISTS `as_nav_father`;
CREATE TABLE `as_nav_father`  (
  `pkNavFather` int(10) NOT NULL AUTO_INCREMENT,
  `navFatherText` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `statusRegister` tinyint(255) NOT NULL,
  `fkUserRegister` int(255) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(11) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkNavFather`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_nav_pather
-- ----------------------------
DROP TABLE IF EXISTS `as_nav_pather`;
CREATE TABLE `as_nav_pather`  (
  `pkNavPather` int(255) NOT NULL AUTO_INCREMENT,
  `navPatherText` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `statusRegister` tinyint(255) NOT NULL,
  `fkUserRegister` int(255) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(11) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkNavPather`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_notification
-- ----------------------------
DROP TABLE IF EXISTS `as_notification`;
CREATE TABLE `as_notification`  (
  `pkNotification` int(10) NOT NULL AUTO_INCREMENT,
  `fkUserEmisor` int(10) NOT NULL,
  `fkUserReceptor` int(10) NOT NULL,
  `notificationTitle` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NOT NULL,
  `notificationSubTitle` varchar(100) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `notificationMessage` varchar(255) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `urlShow` varchar(50) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
  `sended` tinyint(1) NULL DEFAULT NULL,
  `dateSend` datetime(0) NULL DEFAULT NULL,
  `readed` tinyint(1) NULL DEFAULT 0,
  `dateReaded` datetime(0) NULL DEFAULT NULL,
  `ipReaded` varchar(20) CHARACTER SET latin1 COLLATE latin1_spanish_ci NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkNotification`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1347 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_person
-- ----------------------------
DROP TABLE IF EXISTS `as_person`;
CREATE TABLE `as_person`  (
  `pkPerson` int(10) NOT NULL AUTO_INCREMENT,
  `fkTypeDocument` int(10) NOT NULL,
  `fkNationality` int(10) NOT NULL,
  `name` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `surname` varchar(40) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `nameComplete` varchar(80) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `document` varchar(12) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `brithDate` date NULL DEFAULT NULL,
  `email` varchar(60) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `phone` varchar(16) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `sex` char(1) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `img` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `idCulqui` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `address` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `city` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
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
  `aboutMe` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkPerson`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2690 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_type_document
-- ----------------------------
DROP TABLE IF EXISTS `as_type_document`;
CREATE TABLE `as_type_document`  (
  `pkTypeDocument` int(255) NOT NULL AUTO_INCREMENT,
  `code` varchar(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameDocument` varchar(150) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `longitude` int(2) NULL DEFAULT NULL,
  `statusRegister` tinyint(4) NULL DEFAULT NULL,
  `prefix` varchar(13) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkTypeDocument`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_user
-- ----------------------------
DROP TABLE IF EXISTS `as_user`;
CREATE TABLE `as_user`  (
  `pkUser` int(10) NOT NULL AUTO_INCREMENT,
  `fkPerson` int(10) NOT NULL,
  `userName` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPassword` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `verifyReniec` tinyint(1) NULL DEFAULT NULL,
  `role` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `authFacebook` tinyint(255) NULL DEFAULT NULL,
  `authGoogle` tinyint(255) NOT NULL,
  `verified` tinyint(255) NOT NULL DEFAULT 0,
  `dateVerified` datetime(0) NULL DEFAULT NULL,
  `fkUserVerified` int(10) NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NOT NULL,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(11) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `osId` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT '',
  `statusSocket` tinyint(2) NULL DEFAULT 0,
  `indexHex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `lat` float(30, 20) NULL DEFAULT NULL,
  `lng` float(30, 20) NULL DEFAULT NULL,
  `category` tinyint(1) NULL DEFAULT 0,
  `occupied` tinyint(1) NULL DEFAULT 0,
  `playGeo` tinyint(1) NULL DEFAULT 0,
  `waiting` tinyint(1) NULL DEFAULT 0,
  `dateWaiting` datetime(0) NULL DEFAULT NULL,
  `pendingRestore` tinyint(1) NULL DEFAULT 0,
  `dateRestore` datetime(0) NULL DEFAULT NULL,
  `ipRestore` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `codeReferal` varchar(15) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkUser`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2460 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for as_vehicle
-- ----------------------------
DROP TABLE IF EXISTS `as_vehicle`;
CREATE TABLE `as_vehicle`  (
  `pkVehicle` int(255) NOT NULL AUTO_INCREMENT,
  `fkDriver` int(255) NOT NULL,
  `fkCategory` int(255) NULL DEFAULT NULL,
  `fkBrand` int(255) NULL DEFAULT NULL,
  `fkModel` int(255) NULL DEFAULT NULL,
  `numberPlate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `year` int(4) NOT NULL,
  `imgSoat` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateSoatExpiration` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `imgPropertyCard` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `isProper` tinyint(1) NOT NULL,
  `color` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `imgTaxiFrontal` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgTaxiBack` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `imgTaxiInterior` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NOT NULL,
  `fkUserRegister` int(255) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(255) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `verified` tinyint(1) NULL DEFAULT 0,
  `dateVerified` datetime(0) NULL DEFAULT NULL,
  `fkUserVerified` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `driverUsing` tinyint(255) NULL DEFAULT 0,
  PRIMARY KEY (`pkVehicle`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1855 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cc_config
-- ----------------------------
DROP TABLE IF EXISTS `cc_config`;
CREATE TABLE `cc_config`  (
  `pkConfig` int(255) NOT NULL AUTO_INCREMENT,
  `percentRate` float(5, 2) NULL DEFAULT NULL,
  `culquiKey` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkConfig`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cc_config_journal
-- ----------------------------
DROP TABLE IF EXISTS `cc_config_journal`;
CREATE TABLE `cc_config_journal`  (
  `pkConfigJournal` tinyint(255) NOT NULL AUTO_INCREMENT,
  `nameJournal` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `rateJournal` float(4, 2) NULL DEFAULT NULL,
  `modeJournal` char(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
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
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for cc_journal
-- ----------------------------
DROP TABLE IF EXISTS `cc_journal`;
CREATE TABLE `cc_journal`  (
  `pkJournal` int(255) NOT NULL AUTO_INCREMENT,
  `nameJournal` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `codeJournal` varchar(10) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hourStart` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `hourEnd` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(255) NULL DEFAULT NULL,
  `fkUserRegister` int(10) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(10) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(10) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkJournal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for cc_payment_driver
-- ----------------------------
DROP TABLE IF EXISTS `cc_payment_driver`;
CREATE TABLE `cc_payment_driver`  (
  `pkPaymentDriver` tinyint(255) NOT NULL AUTO_INCREMENT,
  `namePayment` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `valuePayment` float(5, 2) NULL DEFAULT NULL,
  `isPercent` tinyint(1) NULL DEFAULT NULL,
  `statusRegister` tinyint(255) NULL DEFAULT 1,
  `dateRegister` datetime(0) NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP(0),
  `fkUserRegister` int(255) NULL DEFAULT 2,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `fkUserUpdate` int(11) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkPaymentDriver`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 3 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for cc_rate
-- ----------------------------
DROP TABLE IF EXISTS `cc_rate`;
CREATE TABLE `cc_rate`  (
  `pkRate` int(11) NOT NULL AUTO_INCREMENT,
  `fkCategory` int(11) NULL DEFAULT NULL,
  `fkJournal` int(11) NULL DEFAULT NULL,
  `priceRate` float(10, 2) NULL DEFAULT NULL,
  `priceMin` float(10, 2) NULL DEFAULT NULL,
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
  PRIMARY KEY (`pkRate`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for rb_config_referal
-- ----------------------------
DROP TABLE IF EXISTS `rb_config_referal`;
CREATE TABLE `rb_config_referal`  (
  `pkConfigReferal` tinyint(1) NOT NULL AUTO_INCREMENT,
  `amountClient` float(4, 2) NOT NULL,
  `amountDriver` float(4, 2) NOT NULL,
  `daysExpClient` tinyint(2) NULL DEFAULT NULL,
  `daysExpDriver` tinyint(2) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NOT NULL,
  `fkUserUpdate` int(11) NOT NULL,
  `ipUserUpdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  PRIMARY KEY (`pkConfigReferal`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for rb_coupon
-- ----------------------------
DROP TABLE IF EXISTS `rb_coupon`;
CREATE TABLE `rb_coupon`  (
  `pkCoupon` int(255) NOT NULL AUTO_INCREMENT,
  `codeCoupon` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `titleCoupon` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `descriptionCoupon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `minRateService` float(5, 2) NULL DEFAULT NULL,
  `amountCoupon` float(4, 2) NULL DEFAULT NULL,
  `dateExpiration` date NULL DEFAULT NULL,
  `daysExpiration` tinyint(2) NULL DEFAULT NULL,
  `roleCoupon` char(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT NULL,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fkUserUpdate` int(11) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(255) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkCoupon`, `codeCoupon`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for rb_coupon_user
-- ----------------------------
DROP TABLE IF EXISTS `rb_coupon_user`;
CREATE TABLE `rb_coupon_user`  (
  `pkCouponUser` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkUser` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `codeCoupon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `bonus` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `dateExpiration` date NULL DEFAULT NULL,
  `dateUsed` datetime(0) NULL DEFAULT NULL,
  `isUsed` tinyint(255) NULL DEFAULT 0,
  `statusRegister` tinyint(1) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `ipRegister` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkCouponUser`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for rb_referal_user
-- ----------------------------
DROP TABLE IF EXISTS `rb_referal_user`;
CREATE TABLE `rb_referal_user`  (
  `pkReferalUser` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkUser` int(255) NULL DEFAULT NULL,
  `bonus` float(5, 2) NULL DEFAULT NULL,
  `bonusUsed` float(5, 2) NULL DEFAULT 0,
  `dateExpiration` date NULL DEFAULT NULL,
  `dateUsed` datetime(0) NULL DEFAULT NULL,
  `isUsed` tinyint(255) NULL DEFAULT 0,
  `fkUserRefered` int(255) NULL DEFAULT NULL,
  `nameCompleteRefered` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NULL DEFAULT NULL,
  `fkPersonRefered` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  PRIMARY KEY (`pkReferalUser`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_alert_notify
-- ----------------------------
DROP TABLE IF EXISTS `ts_alert_notify`;
CREATE TABLE `ts_alert_notify`  (
  `pkAlertNotify` int(255) NOT NULL AUTO_INCREMENT,
  `header` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `message` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `url` varchar(300) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateAlert` datetime(0) NULL DEFAULT NULL,
  `fkUser` int(255) NULL DEFAULT NULL,
  `ipUser` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkAlertNotify`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = COMPACT;

-- ----------------------------
-- Table structure for ts_alert_service
-- ----------------------------
DROP TABLE IF EXISTS `ts_alert_service`;
CREATE TABLE `ts_alert_service`  (
  `pkAlertService` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkService` int(255) NULL DEFAULT NULL,
  `fkPerson` int(255) NULL DEFAULT NULL,
  `isClient` tinyint(255) NULL DEFAULT NULL,
  `lat` float(30, 20) NULL DEFAULT NULL,
  `lng` float(30, 20) NULL DEFAULT NULL,
  `dateAlert` datetime(0) NULL DEFAULT NULL,
  `fkUser` int(255) NULL DEFAULT NULL,
  `ipUser` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkAlertService`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_calification_service
-- ----------------------------
DROP TABLE IF EXISTS `ts_calification_service`;
CREATE TABLE `ts_calification_service`  (
  `pkCalification` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkService` bigint(255) NULL DEFAULT NULL,
  `isClient` tinyint(1) NULL DEFAULT NULL,
  `calification` tinyint(1) NULL DEFAULT NULL,
  `observation` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateCalification` datetime(0) NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT NULL,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkCalification`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 181 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_card
-- ----------------------------
DROP TABLE IF EXISTS `ts_card`;
CREATE TABLE `ts_card`  (
  `pkCard` int(255) NOT NULL AUTO_INCREMENT,
  `fkPerson` int(255) NOT NULL,
  `idCardCulqui` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `idCustomerCulqui` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `cardNumber` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `lastFour` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `bankName` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cardBrand` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `cardType` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `countryBank` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `countryCodeBank` varchar(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NOT NULL,
  `fkUserRegister` int(20) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(20) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(20) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkCard`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_contac
-- ----------------------------
DROP TABLE IF EXISTS `ts_contac`;
CREATE TABLE `ts_contac`  (
  `pkContact` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkPerson` int(255) NULL DEFAULT NULL,
  `fkNationality` int(255) NULL DEFAULT NULL,
  `name` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `surname` varchar(50) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `nameComplete` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `email` varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `phone` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `fkUserRegister` int(20) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `fkUserUpdate` int(20) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `fkUserDelete` int(20) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkContact`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 31 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

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
  `totalCash` float(10, 2) NULL DEFAULT 0,
  `totalCard` float(10, 2) NULL DEFAULT 0,
  `totalCredit` float(10, 2) NULL DEFAULT 0,
  `totalDiscount` float(10, 2) NULL DEFAULT 0,
  `countService` int(255) NULL DEFAULT 0,
  `nameJournal` varchar(30) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rateJournal` float(5, 2) NULL DEFAULT NULL,
  `modeJournal` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NULL DEFAULT 1,
  `fkUserRegister` int(255) NULL DEFAULT NULL,
  `dateRegister` datetime(0) NULL DEFAULT NULL,
  `ipRegister` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkJournalDriver`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_offer_service
-- ----------------------------
DROP TABLE IF EXISTS `ts_offer_service`;
CREATE TABLE `ts_offer_service`  (
  `pkOfferService` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkService` bigint(255) NOT NULL,
  `fkDriver` int(255) NOT NULL,
  `fkVehicle` int(255) NULL DEFAULT NULL,
  `rateOffer` float(10, 2) NOT NULL,
  `isClient` tinyint(1) NULL DEFAULT NULL,
  `dateOfferClient` datetime(0) NULL DEFAULT NULL,
  `dateOfferDriver` datetime(0) NULL DEFAULT NULL,
  `declined` tinyint(1) NOT NULL,
  `dateDeclined` datetime(0) NULL DEFAULT NULL,
  `declinedIsClient` tinyint(1) NULL DEFAULT NULL,
  `acceptedClient` tinyint(1) NOT NULL,
  `acceptedDriver` tinyint(1) NOT NULL,
  `dateAceptedClient` datetime(0) NULL DEFAULT NULL,
  `dateAceptedDriver` datetime(0) NULL DEFAULT NULL,
  `fkJournalDriver` bigint(255) NULL DEFAULT NULL,
  `codeJournal` char(5) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  PRIMARY KEY (`pkOfferService`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 254 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Table structure for ts_service
-- ----------------------------
DROP TABLE IF EXISTS `ts_service`;
CREATE TABLE `ts_service`  (
  `pkService` bigint(255) NOT NULL AUTO_INCREMENT,
  `fkJournal` int(255) NOT NULL,
  `fkRate` int(255) NOT NULL,
  `fkCategory` int(1) NULL DEFAULT NULL,
  `fkClient` int(255) NOT NULL,
  `fkDriver` int(255) NULL DEFAULT NULL,
  `latOrigin` float(30, 20) NOT NULL,
  `lngOrigin` float(30, 20) NOT NULL,
  `streetOrigin` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `latDestination` float(30, 20) NOT NULL,
  `lngDestination` float(30, 20) NOT NULL,
  `streetDestination` varchar(200) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `distance` float(10, 2) NOT NULL,
  `distanceText` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `minutes` float(10, 2) NOT NULL,
  `minutesText` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `rateHistory` float(10, 2) NOT NULL,
  `rateService` float(10, 2) NOT NULL,
  `minRate` float(10, 2) NULL DEFAULT NULL,
  `minRatePercent` float(10, 2) NOT NULL,
  `isMinRate` tinyint(1) NULL DEFAULT NULL,
  `paymentType` char(4) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkCard` int(255) NULL DEFAULT NULL,
  `indexHex` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `statusService` tinyint(255) NOT NULL,
  `countOffer` tinyint(4) NULL DEFAULT NULL,
  `statusRegister` tinyint(1) NOT NULL,
  `fkUserRegister` int(20) NOT NULL,
  `dateRegister` datetime(0) NOT NULL,
  `ipRegister` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `fkUserUpdate` int(20) NULL DEFAULT NULL,
  `dateUpdate` datetime(0) NULL DEFAULT NULL,
  `ipUpdate` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `fkUserDelete` int(20) NULL DEFAULT NULL,
  `dateDelete` datetime(0) NULL DEFAULT NULL,
  `ipDelete` varchar(20) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL,
  `dateStartService` datetime(0) NULL DEFAULT NULL,
  `dateFinishService` datetime(0) NULL DEFAULT NULL,
  `fkPkVehicle` int(255) NULL DEFAULT NULL,
  `fkOffer` bigint(255) NULL DEFAULT NULL,
  `runOrigin` tinyint(1) NULL DEFAULT NULL,
  `finishOrigin` tinyint(1) NULL DEFAULT NULL,
  `runDestination` tinyint(1) NULL DEFAULT 0,
  `finishDestination` tinyint(1) NULL DEFAULT 0,
  `dateRunOrigin` datetime(0) NULL DEFAULT NULL,
  `dateFinishOrigin` datetime(0) NULL DEFAULT NULL,
  `dateRunDestination` datetime(0) NULL DEFAULT NULL,
  `dateFinishDestination` datetime(0) NULL DEFAULT NULL,
  `calificatedClient` tinyint(1) NULL DEFAULT 0,
  `calificatedDriver` tinyint(1) NULL DEFAULT 0,
  `deleteIsClient` tinyint(255) NULL DEFAULT NULL,
  `fkCouponUser` bigint(255) NULL DEFAULT NULL,
  `discount` float(10, 2) NULL DEFAULT 0,
  `discountType` char(6) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT 'NONEDD',
  PRIMARY KEY (`pkService`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 858 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Function structure for as_fn_add_logActivity
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_add_logActivity`;
delimiter ;;
CREATE FUNCTION `as_fn_add_logActivity`(`InFkPerson` int,
`InNameActivity` varchar(50),
`InDescriptionActivity` varchar(300),
`InClassIcon` VARCHAR(10),
`InFkUser` INT,
`InIpUser` VARCHAR(20))
 RETURNS bigint(20)
BEGIN
	
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	INSERT INTO as_log_activity(
			fkPerson,
			nameActivity,
			descriptionActivity,
			classIcon,
			dateActivity,
			fkUserRegister,
			dateRegister,
			ipRegister
	) VALUES(
		InFkPerson,
		InNameActivity,
		InDescriptionActivity,
		InClassIcon,
		CURRENT_TIMESTAMP(),
		InFkUser,
		CURRENT_TIMESTAMP(),
		InIpUser
	);
	
	SET outPkLog = LAST_INSERT_ID(); 

	RETURN outPkLog;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_count_response
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_count_response`;
delimiter ;;
CREATE FUNCTION `as_fn_count_response`(`InPkMessage` int)
 RETURNS int(11)
BEGIN
	
	DECLARE outCount INT DEFAULT 0;
	
	SELECT COUNT(*) INTO outCount
	FROM as_message
	WHERE fkMessage = InPkMessage AND isResponse = 1;
	
	RETURN outCount;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_count_responseNoReaded
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_count_responseNoReaded`;
delimiter ;;
CREATE FUNCTION `as_fn_count_responseNoReaded`(`InPkMessage` int,
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outCount INT DEFAULT 0;
	
	DECLARE vIsEmisor, vPkReceptor, vPkEmisor INT DEFAULT 0;

	SELECT IF( fkUserEmisor = InFkUser, 1, 0),
							fkUserReceptor,
							fkUserEmisor
	INTO vIsEmisor, vPkReceptor, vPkEmisor
	FROM as_message
	WHERE pkMessage = InPkMessage;
	-- si es emisor voy a ver los que ha emitido el receptor
	-- si es receptor voy a ver los que ha emitido el emisor
	
	IF vIsEmisor = 1 THEN
	
		SELECT COUNT(*) INTO outCount
		FROM as_message
		WHERE fkMessage = InPkMessage AND isResponse = 1 AND readed = 0 AND fkUserEmisor = vPkEmisor;

	ELSE
	
		SELECT COUNT(*) INTO outCount
		FROM as_message
		WHERE fkMessage = InPkMessage AND isResponse = 1 AND readed = 0 AND fkUserEmisor = vPkReceptor ;

	END IF;
	
	
	
	RETURN outCount;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_getNamesUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_getNamesUser`;
delimiter ;;
CREATE FUNCTION `as_fn_getNamesUser`(`InPkUser` int)
 RETURNS varchar(100) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outNames VARCHAR(100) DEFAULT '';
	
	SELECT IF(P.nameComplete IS NULL,'', P.nameComplete)
	INTO outNames
	FROM as_user U
	INNER JOIN as_person P ON U.fkPerson = P.pkPerson
	WHERE U.pkUser = InPkUser;
	
	RETURN outNames;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verifyUpdatePhotoUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verifyUpdatePhotoUser`;
delimiter ;;
CREATE FUNCTION `as_fn_verifyUpdatePhotoUser`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE vExistUser INT;
	DECLARE outError INT DEFAULT 0;
	
	SELECT pkUser INTO vExistUser
	FROM as_user
	WHERE pkUser = InPkUser;
	
	IF vExistUser IS NULL THEN
		SET outError = vExistUser + 16;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addApplication
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addApplication`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addApplication`(`InNameApp` VARCHAR(80))
 RETURNS tinyint(1)
BEGIN
	
DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkApp INT;
	
	
	
	SELECT pkApplication,
				IF( nameApp = InNameApp  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkApp, vErrName, vErrStatus	
	FROM as_application
	WHERE nameApp = InNameApp LIMIT 0,1;
	
	IF vPkApp IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addBrand
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addBrand`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addBrand`(`InNameBrand` VARCHAR(80))
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkBrand INT;
	
	
	
	SELECT pkBrand,
				IF( nameBrand = InNameBrand  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkBrand, vErrName, vErrStatus	
	FROM as_brand
	WHERE nameBrand = InNameBrand LIMIT 0,1;
	
	IF vPkBrand IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addDriver`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addDriver`(`InNumberPlate` varchar(10),
`InEmail` varchar(60),
`InUserName` varchar(60),
`InFkTypeDocument` INT,
`InFkNationality` INT,
`InDocument` VARCHAR(20))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkUser INT;
	DECLARE vErrUser, vErrEmail, vErrStatus, vErrPerson, vErrPlate, vFoundtdoc, vFoundnaty TINYINT DEFAULT 0;
	
	SELECT  U.pkUser,
					IF( U.userName = InUserName, 1, 0),
					IF( P.email = InEmail, 2, 0),
					IF( U.statusRegister = 0, 4, 0),
					IF( P.document = InDocument AND U.role = 'DRIVER_ROLE' ,8 , 0)
					
	INTO vPkUser, vErrUser, vErrEmail, vErrStatus, vErrPerson
	FROM as_user U
	LEFT JOIN as_person P ON P.pkPerson = U.fkPerson AND ( P.document = InDocument AND U.role = 'DRIVER_ROLE' OR P.email = InEmail )
	WHERE (U.userName = InUserName OR P.email = InEmail) OR ( P.document = InDocument AND U.role = 'DRIVER_ROLE' ) LIMIT 0,1;
	
	
	SELECT IF(pkVehicle IS NOT NULL, 16, 0) INTO  vErrPlate
	FROM as_vehicle
	WHERE numberPlate = InNumberPlate AND statusRegister = 1 LIMIT 0,1;
	
	SELECT IF(pkTypeDocument IS NULL, 32, 0) INTO vFoundtdoc
	FROM as_type_document
	WHERE pkTypeDocument = InFkTypeDocument AND statusRegister = 1;
	
	SELECT IF(pkNationality IS NULL, 64, 0) INTO vFoundnaty
	FROM as_nationality
	WHERE pkNationality = InFkNationality;
	
	SET outError = vErrUser + vErrEmail + vErrStatus + vErrPerson + vErrPlate + vFoundtdoc + vFoundnaty;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addMenuRole
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addMenuRole`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addMenuRole`(`InPkNavChildren` INT, `InRole` VARCHAR(255))
 RETURNS tinyint(1)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkMenu INT;
	
	
	
	SELECT pkMenuRole,
				IF( role = InRole  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkMenu, vErrName, vErrStatus	
	FROM as_menu_role
	WHERE role = InRole and fkNavChildren = InPkNavChildren LIMIT 0,1;
	
	IF vPkMenu IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addMessage
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addMessage`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addMessage`(`InEmisor` int,
`InReceptor` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrStatusEmisor, vErrStatusReceptor TINYINT DEFAULT 0 ;
	DECLARE vPkEmisor, vPkReceptor INT;
	
	SELECT pkUser,
					IF(statusRegister = 0, 2, 0)	
	INTO vPkEmisor, vErrStatusEmisor
	FROM as_user
	WHERE pkUser = InEmisor;
	
	
	SELECT pkUser,
					IF(statusRegister = 0, 8, 0)	
	INTO vPkReceptor, vErrStatusReceptor
	FROM as_user
	WHERE pkUser = InReceptor ;

	
	IF vPkEmisor IS NULL THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrStatusEmisor;
	END IF;
	
	IF vPkReceptor IS NULL THEN
		SET outError = outError + 4;
	ELSE
		SET outError = outError + vErrStatusReceptor;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addModel
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addModel`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addModel`(`InPkCategory` TINYINT, 
`InPkBrand` INT, 
`InNameModel` VARCHAR(80))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus, vErrModel INT DEFAULT 0;
	DECLARE vPkModel INT;	
	
	SELECT -- IF(pkModel IS NULL, 1, 0),
				IF( nameModel = InNameModel  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vErrName, vErrStatus	
	FROM as_model
	WHERE nameModel = InNameModel AND fkBrand = InPkBrand AND fkCategory = InPkCategory LIMIT 0,1;
	-- fkCategory = InPkCategory and
	
	SET outError = vErrName + vErrStatus;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addNavChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addNavChildren`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addNavChildren`(`InPkNavFather` INT, `InNavChildrenText` VARCHAR(255))
 RETURNS int(11)
BEGIN
	
		DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkNav INT;
	
	
	
	SELECT pkNavChildren,
				IF( navChildrenText = InNavChildrenText  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkNav, vErrName, vErrStatus
	
	FROM as_nav_children
	WHERE fkNavFather = InPkNavFather and navChildrenText = InNavChildrenText LIMIT 0,1;
	
	IF vPkNav IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;

	RETURN 0;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addNavFather
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addNavFather`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addNavFather`(`InNameNav` VARCHAR(100))
 RETURNS tinyint(4)
BEGIN
	
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkNav INT;
	
	
	
	SELECT pkNavFather,
				IF( navFatherText = InNameNav  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkNav, vErrName, vErrStatus
	
	FROM as_nav_father
	WHERE navFatherText = InNameNav LIMIT 0,1;
	
	IF vPkNav IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addNavPather
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addNavPather`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addNavPather`(`InNameNav` varchar(100))
 RETURNS tinyint(4)
BEGIN
	
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkNav INT;
	
	
	
	SELECT pkNavPather,
				IF( navPatherText = InNameNav  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkNav, vErrName, vErrStatus
	
	FROM as_nav_pather
	WHERE navPatherText = InNameNav LIMIT 0,1;
	
	IF vPkNav IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addResponseMsg
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addResponseMsg`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addResponseMsg`(`InFkMessage` int,
`InEmisor` int,
`InReceptor` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrStatusEmisor, vErrStatusReceptor, vErrFoundMsg, vErrFoundEmisor, vErrFoundReceptor TINYINT DEFAULT 0;
	
	SELECT IF(pkMessage IS NULL, 1, 0) INTO vErrFoundMsg
	FROM as_message 
	WHERE pkMessage = InFkMessage;
	
	SELECT IF(pkUser IS NULL, 2, 0) ,
				IF( statusRegister = 0 , 4 ,0)
	INTO vErrFoundEmisor, vErrStatusEmisor
	FROM as_user 
	WHERE pkUser = InEmisor;
	
	SELECT IF(pkUser IS NULL, 8, 0) ,
				IF( statusRegister = 0 , 16 ,0)
	INTO vErrFoundReceptor, vErrStatusReceptor
	FROM as_user 
	WHERE pkUser = InReceptor;
	
	
	SET outError = vErrFoundMsg + vErrFoundEmisor + vErrStatusEmisor + vErrFoundReceptor + vErrStatusReceptor;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addUser`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addUser`(`InFkTypeDocument` int,
`InFkNationality` int,
`InDocument` VARCHAR(20),
`InEmail` varchar(60),
`InUser` varchar(60),
`InRole` varchar(20))
 RETURNS tinyint(4)
BEGIN
	DECLARE vExistUser INT;
	DECLARE outError, vErrUser, vErrEmail, vErrStatus, vErrRepit, vFoundtDoc, vFoundNaty TINYINT DEFAULT 0;
	
	SELECT 	U.pkUser,
					IF(U.userName = InUser, 1, 0),
					IF(P.email = InEmail, 2, 0),
					IF(U.statusRegister = 0, 4, 0),
					IF( P.document = InDocument AND U.role = InRole ,8 , 0)
					
	INTO vExistUser, vErrUser, vErrEmail, vErrStatus, vErrRepit
	FROM as_user U
	LEFT JOIN as_person P ON P.pkPerson = U.fkPerson AND ( P.document = InDocument AND U.role = InRole OR P.email = InEmail)
	WHERE (U.userName = InUser  OR P.email = InEmail) OR ( P.document = InDocument AND U.role = InRole )
	LIMIT 0,1;
	
	SELECT IF(pkTypeDocument IS NULL, 16, 0) INTO vFoundtDoc
	FROM as_type_document
	WHERE pkTypeDocument = InFkTypeDocument AND statusRegister = 1;
	
	SELECT IF(pkNationality IS NULL, 32, 0) INTO vFoundNaty
	FROM as_nationality
	WHERE pkNationality = InFkNationality;
	
	SET outError = vErrUser + vErrEmail + vErrStatus + vErrRepit + vFoundtDoc + vFoundNaty;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_addVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_addVehicle`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_addVehicle`(`InFkDriver` INT,
`InFkPerson` INT,
`InNumberPlate` VARCHAR(15))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrFound,vErrNumber, vErrStatus, vErrFoundDriver TINYINT DEFAULT 0;
	DECLARE vPkVehicle INT;
	
	SELECT IF( pkVehicle IS NOT NULL, 1,  0) INTO vErrNumber	
	FROM as_vehicle
	WHERE numberPlate = InNumberPlate  AND statusRegister = 1 LIMIT 0,1;
	 
	SELECT IF(pkDriver IS NULL, 2,0),
				IF(statusRegister = 0, 4, 0)
	INTO vErrFoundDriver, vErrStatus
	FROM as_driver 
	WHERE pkDriver = InFkDriver AND fkPerson = InFkPerson;

	
	SET outError = outError + vErrNumber + vErrFoundDriver + vErrStatus;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_changePassword
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_changePassword`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_changePassword`(`InPkUser` int,
`InPkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrVerified, vErrStatus TINYINT DEFAULT 0;
	
	SELECT IF(pkUser IS NULL, 1, 0),
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vErrFound, vErrVerified, vErrStatus
	FROM as_user
	WHERE pkUser = InPkUser AND fkPerson = InPkPerson;
	
	SET outError = vErrFound + vErrVerified + vErrStatus;
	
	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteApplication
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteApplication`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteApplication`(InPkApplication INT)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkApp INT;
	
	SELECT pkApplication INTO vPkApp
	FROM as_application
	WHERE pkApplication = InPkApplication;
	
	IF vPkApp IS NULL THEN
		SET outError = 4;	
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteBrand
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteBrand`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteBrand`(`InPkBrand` INT)
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrModel, vErrVehicle INT DEFAULT 0;

	SELECT IF(fkBrand = InPkBrand,1,0)
	INTO vErrModel
	FROM as_model
	WHERE fkBrand = InPkBrand AND statusRegister = 1;
		
	SELECT IF(fkBrand = InPkBrand,2,0)
	INTO vErrVehicle
	FROM as_vehicle_driver
	WHERE fkBrand = InPkBrand AND statusRegister = 1;
	
	SET outError = vErrModel + vErrVehicle;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteDriver`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteDriver`(`InPkUser` int,`InPkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkDriver INT;
		
	SELECT pkDriver INTO vPkDriver
	FROM as_driver
	WHERE pkDriver = InPkDriver;
	
	IF vPkDriver IS NULL THEN
		SET outError = 1;
	END IF;

	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteModel
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteModel`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteModel`(`InPkModel` INT)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SELECT IF(fkModel = InPkModel,1,0)
	INTO outError
	FROM as_vehicle_driver
	WHERE fkModel = InPkModel AND statusRegister = 1;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteNavChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteNavChildren`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteNavChildren`(`InPkNavChildren` INT)
 RETURNS int(11)
BEGIN
	
	DECLARE outError INT DEFAULT 0;

	SELECT IF(fkNavChildren = InPkNavChildren,1,0)
	INTO outError
	FROM as_menu_role
	WHERE fkNavChildren = InPkNavChildren AND statusRegister = 1;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteNavFather
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteNavFather`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteNavFather`(`InPkNavFather` INT)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	DECLARE vPkNav, vPkNavChildren INT;

	SELECT pkNavChildren
	INTO vPkNavChildren
	FROM as_nav_children
	WHERE fkNavFather = InPkNavFather AND statusRegister = 1 LIMIT 0,1;
	
	SELECT pkNavFather INTO vPkNav
	FROM as_nav_father 
	WHERE pkNavFather = InPkNavFather;
	
	IF vPkNavChildren IS NOT NULL THEN
		SET outError = 4;
	END IF;
	
	IF vPkNav IS NULL THEN
		SET outError = 8;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteUser`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteUser`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkUser INT ;
	
	SELECT pkUser INTO vPkUser
	FROM as_user
	WHERE pkUser = InPkUser;
	
	IF vPkUser IS NULL THEN
		SET outError = outError + 1;
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_deleteVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_deleteVehicle`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_deleteVehicle`(`InPkVehicle` int,
`InFkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkVehicle INT;
	
	SELECT pkVehicle INTO vPkVehicle
	FROM as_vehicle 
	WHERE pkVehicle = InPkVehicle AND fkDriver = InFkDriver;
	
	IF vPkVehicle IS NULL THEN
		SET outError = 4;
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_disableAccount
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_disableAccount`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_disableAccount`(`InPkUser` int,
`InFkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus TINYINT DEFAULT 0;
	
	SELECT 	IF( pkUser IS NULL , 1, 0),
					IF( statusRegister = 0 , 2, 0)
	INTO vErrFound, vErrStatus
	FROM as_user
	WHERE pkUser = InPkUser;
	
	SET outError = vErrFound + vErrStatus;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_restorePsw
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_restorePsw`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_restorePsw`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrPending TINYINT DEFAULT 0;
	
	SELECT IF( pkUser IS NULL , 1, 0 ),
					IF( pendingRestore = 0, 2, 0 )
	INTO vErrFound, vErrPending
	FROM as_user
	WHERE pkUser = InPkUser;
	
	SET outError = vErrFound + vErrPending;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_singSocket
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_singSocket`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_singSocket`(`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrFound TINYINT DEFAULT 0;
	DECLARE vPkUser INT;
	
	SELECT IF(pkUser IS NULL, 1, 0) INTO vErrFound
	FROM as_user
	WHERE pkUser = InFkUser;
	
	SET outError = vErrFound;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateApplication
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateApplication`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateApplication`(`InPkApplication` INT, `InNameApp` VARCHAR(80))
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkApp, vPkAppDouble INT ;
	
	SELECT pkApplication,
			IF( nameApp = InNameApp ,1, 0),
			IF( statusRegister = 0 ,2, 0)
	INTO vPkAppDouble, vErrName, vErrStatus	
	FROM as_application 	
	WHERE nameApp = InNameApp AND pkApplication != InPkApplication;		
		
	SELECT pkApplication INTO vPkApp
	FROM as_application
	WHERE pkApplication = InPkApplication;
	
	IF vPkAppDouble IS NOT NULL THEN
		SET outError = outError + vErrName + vErrStatus;
	END IF;
	
	IF vPkApp IS NULL THEN
		SET outError = outError + 4;	
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateBrand
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateBrand`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateBrand`(`InPkBrand` INT, `InNameBrand` VARCHAR(80))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkBrand, vPkBrandDouble INT ;
	
	SELECT pkBrand INTO vPkBrand
	FROM as_brand
	WHERE pkBrand = InPkBrand;
	
	IF vPkBrand IS NULL THEN
		SET outError = 1;	
	ELSE
		SELECT pkBrand,
				IF( nameBrand = InNameBrand ,2, 0),
				IF( statusRegister = 0 ,4, 0)
		INTO vPkBrandDouble, vErrName, vErrStatus	
		FROM as_brand 	
		WHERE nameBrand = InNameBrand AND pkBrand != InPkBrand;
		
		IF vPkBrandDouble IS NOT NULL THEN
				SET outError = outError + vErrName + vErrStatus;
		END IF;
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateFilesdriver
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateFilesdriver`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateFilesdriver`(`InFkEntity` int,`InEntity` varchar(10))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkEntity INT;
	
	CASE InEntity
		WHEN 'DRIVER' THEN
			
			SELECT pkDriver INTO vPkEntity
			FROM as_driver
			WHERE pkDriver = InFkEntity;
			
			IF vPkEntity IS NULL THEN
				SET outError = 1;
			END IF;
			
		WHEN 'VEHICLE' THEN
			
			SELECT pkVehicle INTO vPkEntity
			FROM as_vehicle
			WHERE pkVehicle = InFkEntity;
			
			IF vPkEntity IS NULL THEN
				SET outError = 2;
			END IF;
			
		ELSE
			SET outError = 4;
	END CASE;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateMenuRole
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateMenuRole`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateMenuRole`(`InPkMenuRole` INT, `InPkNavChildren` INT, `InRole` VARCHAR(255))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkMenu, vPkMenuDouble INT ;
	
	SELECT pkMenuRole INTO vPkMenu
	FROM as_menu_role
	WHERE pkMenuRole = InPkMenuRole;
	
	IF vPkMenu IS NULL THEN
		SET outError = 1;	
	ELSE
		SELECT pkMenuRole,
				IF( role = InRole ,2, 0),
				IF( statusRegister = 0 ,4, 0)
		INTO vPkMenuDouble, vErrName, vErrStatus	
		FROM as_menu_role 	
		WHERE role = InRole AND fkNavChildren = InPkNavChildren AND pkMenuRole != InPkMenuRole;
		
		IF vPkMenuDouble IS NOT NULL THEN
				SET outError = outError + vErrName + vErrStatus;
		END IF;
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateModel
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateModel`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateModel`(`InPkModel` INT, 
`InPkBrand` INT, 
`InNameModel` VARCHAR(80))
 RETURNS tinyint(4)
BEGIN
	
DECLARE outError, vErrFound, vErrRepit, vErrName, vErrStatus TINYINT DEFAULT 0;
	DECLARE vPkModel, vPkModelDouble INT ;
	
	SELECT IF(pkModel IS NULL, 4, 0) INTO vErrFound
	FROM as_model
	WHERE pkModel = InPkModel;
	
	SELECT 	-- IF(pkModel IS NOT NULL ,8, 0),
					IF( nameModel = InNameModel ,1, 0),
					IF( statusRegister = 0 ,2, 0)
	INTO vErrName, vErrStatus	
	FROM as_model 	
	WHERE nameModel = InNameModel AND fkBrand = InPkBrand AND pkModel != InPkModel LIMIT 0, 1;
	
	SET outError = vErrFound + vErrName + vErrStatus;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateNavChildren
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateNavChildren`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateNavChildren`(`InPkNavChildren` INT, `InPkNavFather` INT, `InNavChildrenText` VARCHAR(255))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkNav, vPkNavDouble INT ;
	
	SELECT pkNavChildren INTO vPkNav
	FROM as_nav_children
	WHERE pkNavChildren = InPkNavChildren;
	
	IF vPkNav IS NULL THEN
		SET outError = 1;	
	ELSE
		SELECT pkNavChildren,
				IF( navChildrenText = InNavChildrenText ,2, 0),
				IF( statusRegister = 0 ,4, 0)
		INTO vPkNavDouble, vErrName, vErrStatus	
		FROM as_nav_children 	
		WHERE navChildrenText = InNavChildrenText AND fkNavFather = InPkNavFather AND pkNavChildren != InPkNavChildren;
		
		IF vPkNavDouble IS NOT NULL THEN
				SET outError = outError + vErrName + vErrStatus;
		END IF;
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateNavFather
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateNavFather`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateNavFather`(`InPkNavFather` INT, `InNameFather` VARCHAR(100))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrName, vErrStatus INT DEFAULT 0;
	DECLARE vPkNav, vPkNavDouble INT ;
	
	SELECT pkNavFather INTO vPkNav
	FROM as_nav_father
	WHERE pkNavFather = InPkNavFather;
	
	IF vPkNav IS NULL THEN
		SET outError = 1;	
	ELSE
		SELECT pkNavFather,
				IF( navFatherText = InNameFather ,2, 0),
				IF( statusRegister = 0 ,4, 0)
		INTO vPkNavDouble, vErrName, vErrStatus	
		FROM as_nav_father 	
		WHERE navFatherText = InNameFather AND pkNavFather != InPkNavFather LIMIT 0,1;
		
		IF vPkNavDouble IS NOT NULL THEN
				SET outError = outError + vErrName + vErrStatus;
		END IF;
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updatePassUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updatePassUser`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updatePassUser`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SELECT IF(pkUser IS NULL, 1 , 0) INTO outError
	FROM as_user
	WHERE pkUser = InPkUser;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updatePlayGeo
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updatePlayGeo`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updatePlayGeo`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SELECT IF(pkUser IS NULL, 1, 0) INTO outError
	FROM as_user
	WHERE pkUser = InPkUser;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateProfile
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateProfile`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateProfile`(`InPkUser` int,
`InFkTypeDoc` int,
`InDocument` varchar(20))
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrDocument, vErrStatus INT DEFAULT 0;
	DECLARE vPkUser, vPkTypeDoc, vPkPerson INT ;
	
	
	SELECT pkUser INTO vPkUser
	FROM as_user
	WHERE pkUser = InPkUser;
	
	
	SELECT pkTypeDocument INTO vPkTypeDoc
	FROM as_type_document
	WHERE pkTypeDocument = InFkTypeDoc AND statusRegister = 1;
	
	SELECT P.pkPerson,
					IF( P.document = InDocument ,4, 0),
					IF( P.statusRegister = 0 ,8, 0)
	INTO vPkPerson, vErrDocument, vErrStatus
	
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE P.document = InDocument AND P.pkPerson != ( SELECT fkPerson FROM as_user WHERE pkUser = InPkUser );
	
	IF vPkUser IS NULL THEN
		SET outError = 1;
	END IF;
	
	IF vPkTypeDoc IS NULL THEN
		SET outError = outError + 2;
	END IF;
	
	IF vPkPerson IS NOT NULL THEN
		SET outError = outError + vErrDocument + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateProfileDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateProfileDriver`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateProfileDriver`(`InPkUser` INT,
`InPkPerson` INT,
`InPkDriver` INT,
`InEmail` VARCHAR(80))
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	
	DECLARE outError, vErrRole, vErrEmail TINYINT DEFAULT 0;
	DECLARE vPkUser, vPkPerson, vPkDriver INT;
	
	SELECT pkUser,
					IF(role != 'DRIVER_ROLE', 2, 0)
	INTO vPkUser, vErrRole
	FROM as_user
	WHERE pkUser = InPkUser;
		
	SELECT pkPerson,
				IF(email = InEmail, 4, 0)
				
	INTO vPkPerson, vErrEmail
	FROM as_person
	WHERE pkPerson != InPkPerson AND email = InEmail;
	
	
	SELECT pkDriver INTO vPkDriver
	FROM as_driver
	WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson;
	
	IF vPkDriver IS NULL THEN
	
		SET outError = outError + 1;
		
	ELSE
		 
		 SET outError = outError + vErrRole + vErrEmail ;
		 
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateProfileUser
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateProfileUser`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateProfileUser`(`InPkUser` INT,
`InEmail` VARCHAR(100))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrEmail, vErrStatus TINYINT DEFAULT 0;
	DECLARE vPkUser, InPkPerson, vPkPerson INT;

	SELECT pkUser, fkPerson 
	INTO vPkUser, InPkPerson
	FROM as_user 
	WHERE pkUser = InPkUser;
	
	SELECT pkPerson,
				IF(email = InEmail, 2, 0)
				-- IF(statusRegister = 0, 4, 0)
				
	INTO vPkPerson, vErrEmail
	FROM as_person
	WHERE pkPerson != InPkPerson AND email = InEmail;
	
	IF vPkUser IS NULL THEN
		SET outError = 1;
	ELSE
		SET outError = outError + vErrEmail + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateReadedMsg
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateReadedMsg`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateReadedMsg`(`InPkMsg` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrReaded TINYINT DEFAULT 0;
	
	SELECT IF(pkMessage IS NULL, 1, 0),
					IF(readed = 1, 2, 0)
	INTO vErrFound, vErrReaded
	FROM as_message
	WHERE pkMessage = InPkMsg;
	
	SET outError = outError + vErrFound + vErrReaded;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateReadedNoti
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateReadedNoti`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateReadedNoti`(`InPkNoti` int,`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError,vErrReceptor, vErrStatus INT DEFAULT 0;
	DECLARE vPkNoti INT;
	
	SELECT pkNotification,
					IF(fkUserReceptor != InFkUser, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vPkNoti, vErrReceptor, vErrStatus
	FROM as_notification
	WHERE pkNotification = InPkNoti;
	
	IF vPkNoti IS NULL THEN
		SET outError =  outError + 1;
	ELSE
		SET outError = outError + vErrReceptor + vErrStatus;
	END IF;

	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateVehicle`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateVehicle`(`InPkVehicle` INT,
`InFkDriver` INT,
`InFkPerson` INT,
`InNumberPlate` VARCHAR(15))
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrPlate, vErrStatus INT DEFAULT 0;
	DECLARE vPkVehicle, vPkDriver, vPkExistVehicle INT;
	
	SELECT pkVehicle,
				IF( numberPlate = InNumberPlate, 1,  0)
				
	INTO vPkVehicle, vErrPlate	
	FROM as_vehicle
	WHERE numberPlate = InNumberPlate AND statusRegister = 1 AND pkVehicle != InPkVehicle LIMIT 0,1;
	
	SELECT pkDriver,
				IF(statusRegister = 0, 4, 0)
	INTO vPkDriver, vErrStatus
	FROM as_driver 
	WHERE pkDriver = InFkDriver AND fkPerson = InFkPerson;
	
	#verificamos existencia de vehículo
	SELECT pkVehicle INTO vPkExistVehicle
	FROM as_vehicle
	WHERE pkVehicle = InPkVehicle;
	
	IF vPkVehicle IS NOT NULL THEN
		SET outError = outError + vErrPlate;
	END IF;
	
	IF vPkDriver IS NULL THEN
		SET outError = outError + 2;
	ELSE
		SET outError = outError + vErrStatus;
	END IF;
	
	IF vPkExistVehicle IS NULL THEN
		SET outError = outError + 8;
	END IF;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateVerifDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateVerifDriver`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateVerifDriver`(`InPkDriver` int,
`InPkUserDriver` int)
 RETURNS tinyint(4)
BEGIN
	
	DECLARE outError, vErrStatus, vErrVerif, vErrVehicles TINYINT DEFAULT 0;
	DECLARE vPkDriver  INT;
	
	SELECT pkDriver,
				IF(statusRegister = 0, 2, 0)
				
	INTO vPkDriver, vErrStatus
	FROM as_driver
	WHERE pkDriver = InPkDriver;
	
	SELECT IF(verified = 1, 4, 0) INTO vErrVerif
	FROM as_user
	WHERE pkUser = InPkUserDriver;
	
	SELECT IF(COUNT(*) = 0, 8, 0) INTO vErrVehicles
	FROM as_vehicle
	WHERE statusRegister = 1 AND verified = 1 AND fkDriver = vPkDriver;
	
	IF vPkDriver IS NULL THEN
		SET outError = 1;
	ELSE
		SET outError = outError + vErrStatus + vErrVehicles;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_fn_verify_updateVerifyVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `as_fn_verify_updateVerifyVehicle`;
delimiter ;;
CREATE FUNCTION `as_fn_verify_updateVerifyVehicle`(`InPkVehicle` int,
`InFkDriver` int,
`InFkCategory` int,
`InFkBrand` int,
`InFkModel` int)
 RETURNS int(4)
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	DECLARE vErrStatusDriver, vErrStatusVehicle, vErrVerify INT DEFAULT 0;
	DECLARE vPkDriver, vPkVehicle, vPkCategory, vPkBrand, vPkModel INT;
	
	SELECT 	pkDriver,
					IF(statusRegister = 0, 2, 0)
	INTO vPkDriver, vErrStatusDriver
	FROM as_driver
	WHERE pkDriver = InFkDriver;
	
	SELECT 	pkVehicle,
					IF(statusRegister = 0, 8, 0),
					IF(verified = 1, 16, 0)
	INTO vPkVehicle, vErrStatusVehicle, vErrVerify
	FROM as_vehicle
	WHERE pkVehicle = InPkVehicle AND fkDriver = InFkDriver;
	
	SELECT pkCategory INTO vPkCategory
	FROM as_category
	WHERE pkCategory = InFkCategory AND statusRegister = 1;
	
	SELECT pkBrand INTO vPkBrand
	FROM as_brand
	WHERE pkBrand = InFkBrand AND statusRegister = 1;
	
	SELECT pkModel INTO vPkModel
	FROM as_model
	WHERE pkModel = InFkModel AND statusRegister = 1;
	
	IF vPkDriver IS NULL THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrStatusDriver;
	END IF;
	
	IF vPkVehicle IS NULL THEN
		SET outError = outError + 4;
	ELSE
		SET outError = outError + vErrStatusVehicle + vErrVerify;
	END IF;
	
	IF vPkCategory IS NULL THEN
		SET outError = outError + 32;
	END IF;
	
	IF vPkBrand IS NULL THEN
		SET outError = outError + 64;
	END IF;
	
	IF vPkModel IS NULL THEN
		SET outError = outError + 128;
	END IF;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addApplication
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addApplication`;
delimiter ;;
CREATE PROCEDURE `as_sp_addApplication`(IN `InNameApp` VARCHAR(40), 
IN `InDescription` VARCHAR(100), 
IN `InPlattform` VARCHAR(10), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
DECLARE outShowError, outPkApplication INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addApplication( InNameApp );
	
	IF outShowError = 0 THEN
		INSERT INTO as_application(
				nameApp,
				description,
				plattform,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InNameApp,
			InDescription,
			InPlattform,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkApplication = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkApplication AS 'pkApplication';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addBrand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addBrand`;
delimiter ;;
CREATE PROCEDURE `as_sp_addBrand`(IN `InPkCategory` INT, IN `InNameBrand` VARCHAR(80), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkBrand INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addBrand(InNameBrand );
	
	IF outShowError = 0 THEN
		INSERT INTO as_brand(
				fkCategory,
				nameBrand,			
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkCategory,
			InNameBrand,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkBrand = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkBrand AS 'pkBrand';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addCategory
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addCategory`;
delimiter ;;
CREATE PROCEDURE `as_sp_addCategory`(IN `InName` VARCHAR(80), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkCategory INT DEFAULT 0;
	
	
	
	IF outShowError = 0 THEN
		INSERT INTO as_category(
				nameCategory,			
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InName,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkCategory = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkCategory AS 'pkCategory';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_addDriver`(IN `InFkTypeDocument` INT, 
IN `InFkNationality` INT, 
IN `InName` VARCHAR(40), 
IN `InSurname` VARCHAR(40), 
IN `InDocument` VARCHAR(20), 
IN `InVerifyReniec` tinyint,
IN `InEmail` VARCHAR(60), 
IN `InPhone` VARCHAR(20),
IN `InBrithDate` VARCHAR(20),
IN `InSex` CHAR(1),

IN `InUser` VARCHAR(60), 
IN `InPassword` VARCHAR(200), 
IN `InRole` VARCHAR(30), 
IN `InAuthGoogle` TINYINT, 


IN `InDateLicenseExpiration` VARCHAR(20),
IN `InIsEmployee` TINYINT,


IN `InNumberPlate` VARCHAR(20),
IN `InYear` VARCHAR(20),
IN `InColor` VARCHAR(20),
IN `InDateSoatExpiration` VARCHAR(20),
IN `InIsProper` TINYINT,

IN `InFkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError, outPkUser, outPkPerson, outPkDriver, outPkVehicle, outNewAccounts INT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	SET outError = as_fn_verify_addDriver(InNumberPlate, InEmail, InUser, InFkTypeDocument, InFkNationality, InDocument);
	
	IF outError = 0 THEN
		
		SET outNewAccounts = ch_fn_addNewAccount();
	
		INSERT INTO as_person(
				fkTypeDocument,
				fkNationality,
				`name`,
				surname,
				nameComplete,
				document,
				brithDate,
				email,
				phone,
				sex,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister				
		) VALUES ( 
				InFkTypeDocument,
				InFkNationality,
				InName,
				InSurname,
				CONCAT(InSurname ,", ", InName),
				InDocument,
				InBrithDate,
				TRIM(InEmail),
				TRIM(InPhone),
				InSex,
				1,
				InFkUser,
				CURRENT_TIMESTAMP(),
				InIpUser
		);
		
		SET outPkPerson = LAST_INSERT_ID();
		
		INSERT INTO as_user(
				fkPerson,
				userName,
				userPassword,
				role,
				authGoogle,
				verifyReniec,
				verified,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		)VALUES(
			outPkPerson,
			TRIM(InUser),
			InPassword,
			InRole,
			InAuthGoogle,
			InVerifyReniec,
			0,
			1,
			InFkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		
		SET outPkUser = LAST_INSERT_ID();
		
		
		/**			
			UPDATE as_user SET codeReferal = as_sp_generateCode( InName, InSurname, outPkUser )
			WHERE pkUser = outPkUser;
			
		*/
		
		SET outPkLog = as_fn_add_logActivity( outPkPerson, 'Se unió a llamataxi app', '', 'info', outPkUser, InIpUser );
		
		INSERT INTO as_driver(
			fkPerson,
			dateLicenseExpiration,
			isEmployee,
			statusRegister,
			dateRegister,
			fkUserRegister,
			ipRegister
		) VALUES(
			outPkPerson,
			InDateLicenseExpiration,
			InIsEmployee,
			1,
			CURRENT_TIMESTAMP(),
			InFkUser,
			InIpUser			
		);
		
		SET outPkDriver = LAST_INSERT_ID();
		
		INSERT INTO as_vehicle(
			fkDriver,
			numberPlate,
			`year`,
			dateSoatExpiration,
			isProper,
			color,
			statusRegister,
			dateRegister,
			fkUserRegister,
			ipRegister
		) VALUES(
			outPkDriver,
			InNumberPlate,
			InYear,
			InDateSoatExpiration,
			InIsProper,
			InColor,
			1,
			CURRENT_TIMESTAMP(),
			InFkUser,
			InIpUser				
		);
		
		SET outPkVehicle = LAST_INSERT_ID();
	END IF;
	
	SELECT outError AS 'showError',
					outPkUser AS 'pkUser',
					outPkPerson AS 'pkPerson',
					outPkDriver AS 'pkDriver',
					outPkVehicle AS 'pkVehicle',
					InUser AS 'userName',
					CONCAT(InSurname ,", ", InName) AS 'nameComplete',
					InRole AS 'role';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addMenuRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addMenuRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_addMenuRole`(IN `InPkNavChildren` INT, IN `InRole` VARCHAR(255), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkMenuRole INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addMenuRole( InPkNavChildren,InRole );
	
	IF outShowError = 0 THEN	
		INSERT INTO as_menu_role(
				fkNavChildren,
				role,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkNavChildren,
			InRole,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkMenuRole = LAST_INSERT_ID();
	END IF;
	
	SELECT outShowError AS 'showError', outPkMenuRole AS 'pkMenuRole';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addMessage
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addMessage`;
delimiter ;;
CREATE PROCEDURE `as_sp_addMessage`(IN `InEmisor` int,
IN `InReceptor` int,
IN `InSubject` varchar(100),
IN `InMessage` varchar(255),
IN `InTags` varchar(100),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkMessage BIGINT DEFAULT 0;
	
	
	
	
	SET outError = as_fn_verify_addMessage( InEmisor, InReceptor );
	
	IF outError = 0 THEN
		INSERT INTO as_message( fkUserEmisor,
														fkUserReceptor,
														`subject`,
														message,
														tags,
														statusRegister,
														archived,
														fkUserRegister,
														dateRegister,
														ipRegister ) 
		VALUES( InEmisor,
						InReceptor,
						InSubject,
						InMessage,
						InTags,
						1,
						0,
						InFkUser,
						CURRENT_TIMESTAMP(),
						InIpUser );
						
		SET outPkMessage = LAST_INSERT_ID();
	END IF;
	
	SELECT outError AS 'showError', outPkMessage AS 'pkMessage';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addModel
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addModel`;
delimiter ;;
CREATE PROCEDURE `as_sp_addModel`(IN `InPkCategory` TINYINT, 
IN `InPkBrand` INT, 
IN `InNameModel` VARCHAR(80), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkModel INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addModel(InPkCategory,InPkBrand,InNameModel );
	
	IF outShowError = 0 THEN
		INSERT INTO as_model(
				fkCategory,
				fkBrand,
				nameModel,			
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkCategory,
			InPkBrand,
			InNameModel,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkModel = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkModel AS 'pkModel';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addNavChildren
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addNavChildren`;
delimiter ;;
CREATE PROCEDURE `as_sp_addNavChildren`(IN `InPkNavFather` INT,
IN `InNavChildrenText` VARCHAR(50),
IN `InNavChildrenPath` VARCHAR(50), 
IN `InNavChildrenIcon` VARCHAR(20), 
IN `InIsVisible` TINYINT, 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkNav INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addNavChildren( InPkNavFather,InNavChildrenText );
	
	IF outShowError = 0 THEN
		INSERT INTO as_nav_children(
				fkNavFather,
				navChildrenText,
				navChildrenPath,
				navChildrenIcon,
				isVisible,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkNavFather,
			InNavChildrenText,
			InNavChildrenPath,
			InNavChildrenIcon,
			InIsVisible,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkNav = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkNav AS 'pkNavChildren';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addNavFahter
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addNavFahter`;
delimiter ;;
CREATE PROCEDURE `as_sp_addNavFahter`(IN `InNameFather` VARCHAR(100), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	
	DECLARE outShowError, outPkNav INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addNavFather( InNamefather );
	
	IF outShowError = 0 THEN
		INSERT INTO as_nav_father(
				navFatherText,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InNameFather,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkNav = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkNav AS 'pkNavFather';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addNavPahter
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addNavPahter`;
delimiter ;;
CREATE PROCEDURE `as_sp_addNavPahter`(IN `InNamePather` varchar(100),
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	
	DECLARE outShowError, outPkNav INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addNavPather( InNamePather );
	
	IF outShowError = 0 THEN
		INSERT INTO as_nav_pather(
				navPatherText,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InNamePather,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkNav = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkNav AS 'pkNavPather';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addNotification
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addNotification`;
delimiter ;;
CREATE PROCEDURE `as_sp_addNotification`(IN `InPkUserEmisor` INT,
IN `InPkUserReceptor` INT,
IN `InNotificationTitle` VARCHAR(255),
IN `InNotificationSubTitle` VARCHAR(255),
IN `InNotificationMessage` VARCHAR(255),
IN `InUrlShow` VARCHAR(50),
IN `InPkUser` INT,
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outPkNotification INT DEFAULT 0;
	
		INSERT INTO as_notification (	
				fkUserEmisor,
				fkUserReceptor,
				notificationTitle,
				notificationSubTitle,
				notificationMessage,
				urlShow,
				sended,
				dateSend,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister) 
		VALUES(
				InPkUserEmisor,
				InPkUserReceptor,
				InNotificationTitle,
				InNotificationSubTitle,
				InNotificationMessage,
				InUrlShow,
				1,
				CURRENT_TIMESTAMP(),
				1,
				InPkUser,
				CURRENT_TIMESTAMP(),
				InIpUser				
		);
		SET outPkNotification = LAST_INSERT_ID();
	
	SELECT 0 AS 'showError', outPkNotification AS 'pkNotification' ;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addResponseMsg
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addResponseMsg`;
delimiter ;;
CREATE PROCEDURE `as_sp_addResponseMsg`(IN `InFkMessage` int,
IN `InEmisor` int,
IN `InReceptor` int,

IN `InMessage` varchar(255),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outDate VARCHAR(30);
	DECLARE outPersonEmisor, outPersonReceptor, outPkMessage INT DEFAULT 0;
	
	SET outPersonEmisor = (SELECT fkPerson FROM as_user WHERE pkUser = InEmisor);
	SET outPersonReceptor = (SELECT fkPerson FROM as_user WHERE pkUser = InReceptor);
	
	SET outError = as_fn_verify_addResponseMsg( InFkMessage, InEmisor, InReceptor );
	
	IF outError = 0 THEN
		SET outDate = CURRENT_TIMESTAMP();
		
		INSERT INTO as_message( fkUserEmisor,
														fkUserReceptor,
														
														message,
														
														statusRegister,
														archived,
														fkUserRegister,
														dateRegister,
														ipRegister,
														isResponse,
														fkMessage) 
		VALUES( InEmisor,
						InReceptor,
						
						InMessage,
						
						1,
						0,
						InFkUser,
						outDate,
						InIpUser,
						1,
						InFkMessage );
						
		SET outPkMessage = LAST_INSERT_ID();
	END IF;

	
	SELECT outError AS 'showError', 
	outPkMessage AS 'pkMessage', 
	outDate AS 'dateRegister',
	(SELECT nameComplete FROM as_person WHERE pkPerson = outPersonEmisor ) AS nameEmisor,
	(SELECT nameComplete FROM as_person WHERE pkPerson = outPersonEmisor) AS nameReceptor,
	
	(SELECT img FROM as_person WHERE pkPerson = outPersonEmisor ) AS imgEmisor,
	(SELECT img FROM as_person WHERE pkPerson = outPersonEmisor ) AS imgReceptor
	;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_addUser`(IN `InFkTypeDocument` INT, 
IN `InFkNationality` INT, 
IN `InName` VARCHAR(40), 
IN `InSurname` VARCHAR(40), 
IN `InDocument` VARCHAR(20), 
IN `InEmail` VARCHAR(60), 
IN `InPhone` VARCHAR(20), 
IN `InUser` VARCHAR(60), 
IN `InPassword` VARCHAR(200), 
IN `InRole` VARCHAR(30), 
IN `InAuthGoogle` TINYINT, 
IN `InVerifyReniec` TINYINT,
-- driver params
IN `InDateLicenseExp` VARCHAR(12),
IN `InIsEmployee` TINYINT,

-- driver params

IN `InFkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	
	DECLARE outError, outPkUser, outPkPerson, outNewAccounts INT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	SET outError = as_fn_verify_addUser(InFkTypeDocument, InFkNationality, InDocument, InEmail, InUser, InRole);
	
	IF outError = 0 THEN
		
		SET outNewAccounts = ch_fn_addNewAccount();
		
		INSERT INTO as_person(
				fkTypeDocument,
				fkNationality,
				`name`,
				surname,
				nameComplete,
				document,
				email,
				phone,
				
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister				
		) VALUES ( 
				InFkTypeDocument,
				InFkNationality,
				InName,
				InSurname,
				CONCAT(InSurname ,", ", InName),
				InDocument,
				TRIM(InEmail),
				InPhone,
				
				1,
				InFkUser,
				CURRENT_TIMESTAMP(),
				InIpUser
		);
		
		SET outPkPerson = LAST_INSERT_ID();
		
		INSERT INTO as_user(
				fkPerson,
				userName,
				userPassword,
				role,
				authGoogle,
				verified,
				verifyReniec,
				dateVerified,
				fkUserVerified,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		)VALUES(
			outPkPerson,
			TRIM(InUser),
			InPassword,
			InRole,
			InAuthGoogle,
			1,
			InVerifyReniec,
			CURRENT_TIMESTAMP(),
			0,
			1,
			InFkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		
		SET outPkUser = LAST_INSERT_ID();
		
		
		# si es un cliente, generar código referente
		/**IF InRole = 'CLIENT_ROLE'  THEN
			
			UPDATE as_user SET codeReferal = as_sp_generateCode( InName, InSurname, outPkUser )
			WHERE pkUser = outPkUser;
			
		END IF;*/

		
		
		IF InRole = 'DRIVER_ROLE' THEN
			
			INSERT as_driver( fkPerson,
							dateLicenseExpiration,
							isEmployee,
							statusRegister,
							dateRegister,
							fkUserRegister,												
							ipRegister)
			VALUES( outPkPerson,
					InDateLicenseExp,
					InIsEmployee,
					1,
					CURRENT_TIMESTAMP(),
					InFkUser,
					InIpUser);
			
		END IF;
        
		SET outPkLog = as_fn_add_logActivity(outPkPerson, 
											'Se unió a llamataxi app', 
                                            'Creó cuenta a travéz de la app', 
                                            'info',outPkUser, InIpUser );
	END IF;

	SELECT outError AS 'showError',
				outPkUser AS 'pkUser',
				outPkPerson AS 'pkPerson',
				InRole AS 'role',
				InUser AS 'userName',
				CONCAT(InSurname ,", ", InName) AS 'nameComplete' ;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_addVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_addVehicle`;
delimiter ;;
CREATE PROCEDURE `as_sp_addVehicle`(IN `InPkDriver` INT, 
IN `InFkPerson` INT, 
IN `InFkCategory` INT, 
IN `InFkBrand` INT, 
IN `InPkModel` INT, 
IN `InIsProper` TINYINT, 
IN `InNumberPlate` VARCHAR(15), 
IN `InYear` INT, 
IN `InColor` VARCHAR(20), 
IN `InDateSoatExpiration` VARCHAR(20), 
IN `InVerified` TINYINT,
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outShowError, outPkVehicle, outPkLog INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addVehicle( InPkDriver, InFkPerson , InNumberPlate );
	
	IF outShowError = 0 THEN
		INSERT INTO as_vehicle(
				fkDriver,
				fkCategory,
				fkBrand,
				fkModel,
				isProper,
				numberPlate,
				`year`,
				color,
				dateSoatExpiration,
				statusRegister,
				verified,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkDriver,
			InFkCategory,
			InFkBrand,
			InPkModel,
			InIsProper,
			InNumberPlate,
			InYear,
			InColor,
			InDateSoatExpiration,
			1,
			InVerified,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkVehicle = LAST_INSERT_ID();
		
		
		IF InVerified = 1 THEN
			UPDATE as_vehicle SET fkUserVerified = InPkUser,
														dateVerified = CURRENT_TIMESTAMP()
			WHERE pkVehicle = outPkVehicle;
			
			-- Vehículo verificado por: VIGGIO AVALOS, HUGO FREDY.
			SET outPkLog = as_fn_add_logActivity( InFkPerson,
																						CONCAT('Vehiculo con placa ',InNumberPlate,' habilitado'),
																						CONCAT('Vehículo verificado por:', as_fn_getNamesUser(InPkUser),'.'),
																						'success',
																						InPkUser,
																						InIpUser);
		END IF;

		
		
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkVehicle AS 'pkVehicleDriver', outPkLog AS 'pkLog' ;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_changePassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_changePassword`;
delimiter ;;
CREATE PROCEDURE `as_sp_changePassword`(IN `InPkUser` int,
IN `InPkPerson` int,
IN `InPassword` varchar(200),
IN `InIp` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	SET outError = as_fn_verify_changePassword( InPkUser, InPkPerson );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET userPassword = InPassword,
												dateUpdate = CURRENT_TIMESTAMP(),
												ipUpdate = InIp,
												fkUserUpdate = InPkUser
		WHERE pkUser = InPkUser AND fkPerson = InPkPerson;
		/*
		`InFkPerson` int,
		`InNameActivity` varchar(50),
		`InDescriptionActivity` varchar(300),
		`InClassIcon` VARCHAR(10),
		`InFkUser` INT,
		`InIpUser` VARCHAR(20)
		*/

		SET outPkLog = as_fn_add_logActivity( InPkPerson, 
																					'Cambio de contraseña', 
																					'Cambio de contraseña desde la app móvil',
																					'success',
																					InPkUser,
																					InIp);
		
	END IF;
	
	SELECT outError AS 'showError', outPkLog AS 'pkLog';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteApplication
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteApplication`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteApplication`(IN `InPkApplication` INT,
IN `InStatus` TINYINT,
IN `InFkUser` INT,
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;	
	
	SET outError = as_fn_verify_deleteApplication( InPkApplication );
	
	
	IF outError = 0 THEN
	
		IF InStatus = 1  THEN			
			UPDATE as_application SET 
							statusRegister = 1,
							dateUpdate = CURRENT_TIMESTAMP(),
							fkUserUpdate = InFkUser,
							ipUpdate = InIpUser
			WHERE pkApplication = InPkApplication;
		ELSE 
			UPDATE as_application SET 
							statusRegister = 0,
							dateDelete = CURRENT_TIMESTAMP(),
							fkUserDelete = InFkUser,
							ipDelete = InIpUser
			WHERE pkApplication = InPkApplication;
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteBrand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteBrand`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteBrand`(IN `InPkBrand` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
		
	IF(InStatus = 1) THEN			
					UPDATE as_brand SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkBrand = InPkBrand;
	ELSE 
					SET outError = as_fn_verify_deleteBrand(InPkBrand);
					IF outError = 0 THEN
							UPDATE as_brand SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
							WHERE pkBrand = InPkBrand;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteCategory
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteCategory`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteCategory`(IN `InPkCategory` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
		
	IF(InStatus = 1) THEN			
					UPDATE as_category SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkCategory = InPkCategory;
	ELSE 
					
					IF outError = 0 THEN
							UPDATE as_category SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
							WHERE pkCategory = InPkCategory;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteDriver`(IN `InPkUser` int,
IN `InPkDriver` int,
IN `InStatus` tinyint,
IN `InObservation` varchar(200),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLog INT DEFAULT 0;
	DECLARE InAction, InIcon VARCHAR(50);
	DECLARE InPkPerson INT;
	
	SET InAction = '';
	SET InIcon = 'success';
	
	SET outError = as_fn_verify_deleteDriver( InPkUser, InPkDriver );
	
	IF outError = 0 THEN
	
		SET InPkPerson = ( SELECT fkPerson FROM as_user WHERE pkUser = InPkUser);		
		
		IF InStatus = 0 THEN
		
			SET InAction = 'Deshabilitación de cuenta';
			SET InIcon = 'warning';
			
			UPDATE as_person	SET statusRegister = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													fkUserDelete = InFkUser,
													ipDelete = InIpUser
			WHERE pkPerson = InPkPerson;
			
			UPDATE as_user SET statusRegister = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													fkUserDelete = InFkUser,
													ipDelete = InIpUser
			WHERE pkUser = InPkUser;
			
			UPDATE as_driver SET statusRegister = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													fkUserDelete = InFkUser,
													ipDelete = InIpUser
			WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson;
			
			
		ELSE
		
			SET InAction = 'Habilitación de cuenta';
			SET InIcon = 'success';
			
			UPDATE as_person	SET statusRegister = 1,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser
			WHERE pkPerson = InPkPerson;
			
			UPDATE as_user SET statusRegister = 1,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser
			WHERE pkUser = InPkUser;
			
			UPDATE as_driver SET statusRegister = 1,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser
			WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson;
			
		END IF;
		
		/*
				`InNameActivity` varchar(50),
				`InDescriptionActivity` varchar(100),
				`InClassIcon` VARCHAR(10),
				`InFkUser` INT,
				`InIpUser` VARCHAR(20)
			**/
			
			SET outPkLog = as_fn_add_logActivity(InPkPerson, InAction, InObservation, InIcon, InFkUser, InIpUser );

		
	END IF;
	
	SELECT outError AS 'showError', outPkLog AS 'pkLog';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteMenuRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteMenuRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteMenuRole`(IN `InPkMenuRole` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	IF(InStatus = 1) THEN			
					UPDATE as_menu_role SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE  pkMenuRole = InPkMenuRole;
	ELSE 
				
				IF outError = 0 THEN
						UPDATE as_menu_role SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
						WHERE pkMenuRole = InPkMenuRole;
				END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteModel
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteModel`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteModel`(IN `InPkModel` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	IF(InStatus = 1) THEN			
					UPDATE as_model SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkModel = InPkModel;
	ELSE 
					SET outError = as_fn_verify_deleteModel(InPkModel);
					IF outError = 0 THEN
							UPDATE as_model SET 
											statusRegister = 0,
											dateDelete = CURRENT_TIMESTAMP(),
											fkUserDelete = InPkUser,
											ipDelete = InIpUser
							WHERE pkModel = InPkModel;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteNavChildren
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteNavChildren`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteNavChildren`(IN `InPkNavChildren` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;	
	IF(InStatus = 1) THEN			
					UPDATE as_nav_children SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkNavChildren = InPkNavChildren;
	ELSE 
					SET outError = as_fn_verify_deleteNavChildren(InPkNavChildren);
					IF outError = 0 THEN							
							UPDATE as_nav_children SET 
											statusRegister = 0,
											dateDelete = CURRENT_TIMESTAMP(),
											fkUserDelete = InPkUser,
											ipDelete = InIpUser
							WHERE pkNavChildren = InPkNavChildren;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteNavFather
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteNavFather`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteNavFather`(IN `InPkNavFather` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_deleteNavFather(InPkNavFather);
	
	IF outError = 0 THEN		
		IF(InStatus = 1) THEN			
			UPDATE as_nav_father SET 
							statusRegister = 1,
							dateUpdate = CURRENT_TIMESTAMP(),
							fkUserUpdate = InPkUser,
							ipUpdate = InIpUser
			WHERE pkNavFather = InPkNavFather;
		ELSE 
						
												
			UPDATE as_nav_father SET 
							statusRegister = 0,
							dateDelete = CURRENT_TIMESTAMP(),
							fkUserDelete = InPkUser,
							ipDelete = InIpUser
			WHERE pkNavFather = InPkNavFather;
						
		END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteNotification
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteNotification`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteNotification`(IN `InPkNotification` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;

	if(InStatus = 1) THEN			
					UPDATE as_notification SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkNotification = InPkNotification;
	ELSE 
				
				IF outError = 0 THEN			
						UPDATE as_notification SET 
										statusRegister = 0,
										dateDelete = CURRENT_TIMESTAMP(),
										fkUserDelete = InPkUser,
										ipDelete = InIpUser
						WHERE pkNotification = InPkNotification;
				END IF;
	END IF;
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteUser`(IN `InPkUser` int,
IN `InStatus` tinyint,
IN `InObservation` VARCHAR(100),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLog INT DEFAULT 0;
	DECLARE InAction, InIcon VARCHAR(50);
	DECLARE InPkPerson INT;
	
	SET InAction = '';
	SET InIcon = 'success';
	
	SET outError = as_fn_verify_deleteUser( InPkUser );
	
	IF outError = 0 THEN
	
		SET InPkPerson = ( SELECT fkPerson FROM as_user WHERE pkUser = InPkUser);		
		
		IF InStatus = 0 THEN
		
			SET InAction = 'Deshabilitación de cuenta';
			SET InIcon = 'warning';
			
			UPDATE as_person	SET statusRegister = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													fkUserDelete = InFkUser,
													ipDelete = InIpUser
			WHERE pkPerson = InPkPerson;
			
			UPDATE as_user SET statusRegister = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													fkUserDelete = InFkUser,
													ipDelete = InIpUser
			WHERE pkUser = InPkUser;
			
			
		ELSE
		
			SET InAction = 'Habilitación de cuenta';
			SET InIcon = 'success';
			
			UPDATE as_person	SET statusRegister = 1,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser
			WHERE pkPerson = InPkPerson;
			
			UPDATE as_user SET statusRegister = 1,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser
			WHERE pkUser = InPkUser;
			
		END IF;
		
		/*
				`InNameActivity` varchar(50),
				`InDescriptionActivity` varchar(100),
				`InClassIcon` VARCHAR(10),
				`InFkUser` INT,
				`InIpUser` VARCHAR(20)
			**/
			
			SET outPkLog = as_fn_add_logActivity(InPkPerson, InAction, InObservation, InIcon, InFkUser, InIpUser );

		
	END IF;
	
	SELECT outError AS 'showError', outPkLog AS 'pkLog';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_deleteVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_deleteVehicle`;
delimiter ;;
CREATE PROCEDURE `as_sp_deleteVehicle`(IN `InPkVehicle` INT,
IN `InFkDriver` INT,
IN `InStatus` TINYINT,
IN `InPkUser` INT,
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_deleteVehicle( InPkVehicle, InFkDriver );
	
	IF outError = 0 THEN
	
		if(InStatus = 1) THEN			
		
				UPDATE as_vehicle SET 
										statusRegister = 1,
										dateUpdate = CURRENT_TIMESTAMP(),
										fkUserUpdate = InPkUser,
										ipUpdate = InIpUser
				WHERE pkVehicle = InPkVehicle AND fkDriver = InFkDriver;
				
		ELSE 
				
				UPDATE as_vehicle SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
				WHERE pkVehicle = InPkVehicle AND fkDriver = InFkDriver;
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_disableAccount
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_disableAccount`;
delimiter ;;
CREATE PROCEDURE `as_sp_disableAccount`(IN `InPkUser` int,
IN `InFkPerson` int,
IN `InIp` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_disableAccount( InPkUser, InFkPerson );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET statusRegister = 0,
												dateDelete = CURRENT_TIMESTAMP(),
												fkUserDelete = InPkUser,
												ipDelete = InIp
		WHERE pkUser = InPkUser AND fkPerson = InFkPerson;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Function structure for as_sp_generateCode
-- ----------------------------
DROP FUNCTION IF EXISTS `as_sp_generateCode`;
delimiter ;;
CREATE FUNCTION `as_sp_generateCode`(`InName` varchar(40),
`InSurname` varchar(40),
`InPkUser` int)
 RETURNS varchar(15) CHARSET utf8mb4
BEGIN
	#Routine body goes here...
	DECLARE outCode, vCorre, vName, vSurname VARCHAR(15) DEFAULT '';
	
	SET vCorre = CONCAT('00000', CAST( InPkUser AS CHAR ) );
	
	SET vName = SUBSTR( TRIM( InName ), 1, 3 );
	SET vSurname = SUBSTR( TRIM( InSurname ), 1, 2 );
	SET vCorre = SUBSTR( vCorre,  -6 );
	SET outCode = CONCAT(vName,vSurname,vCorre);

	RETURN outCode;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getAllowMenu
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getAllowMenu`;
delimiter ;;
CREATE PROCEDURE `as_sp_getAllowMenu`(IN `InPkUser` int,
IN `InRole` varchar(30),
IN `InUrl` varchar(30))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkMenu INT;
	
	SELECT 	MR.pkMenuRole INTO vPkMenu
	FROM as_menu_role MR
	INNER JOIN as_nav_children NCH ON NCH.pkNavChildren = MR.fkNavChildren
	WHERE MR.statusRegister = 1 AND MR.role = InRole AND NCH.navChildrenPath = InUrl;
	
	IF vPkMenu IS NULL THEN
		SET outError = 1;
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListApplication
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListApplication`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListApplication`(IN `InPage` INT,
IN `InQuery` VARCHAR(50),
IN `InShowInactive` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET @InStart = (InPage - 1) * 10;
	SET @InLimit = InPage  * 10;
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InShowInactive );
	
	IF InQuery != '' THEN
		SET outWhere = CONCAT( outWhere, " AND nameApp LIKE '%",InShowInactive, "%'" );
	END IF;

	
	SET @sql = CONCAT("	SELECT pkApplication, 
															nameApp, 
															description,
															plattform,
															statusRegister,
															dateRegister ",
										"FROM as_application",	
										outWhere,
										" ORDER BY dateRegister DESC",
										" LIMIT ?,?");
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart, @InLimit;
	
	DEALLOCATE PREPARE stmt;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListBrand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListBrand`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListBrand`(IN `InPage` INT, 
IN `InQueryCat` VARCHAR(80), 
IN `InQueryBrand` VARCHAR(80), 
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	
	SET outWhere = CONCAT( ' WHERE B.statusRegister = ',InStatus );
	
	IF InQueryCat != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND C.nameCategory LIKE '%",InQueryCat, "%'");	
	END IF;
	
	IF InQueryBrand != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND B.nameBrand LIKE '%",InQueryBrand,"%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT 
					B.pkBrand,
					B.fkCategory,
					C.nameCategory,
					B.nameBrand,
					B.dateRegister,
					B.statusRegister "
				,"FROM as_brand B "
				,"INNER JOIN as_category C ON C.pkCategory = B.fkCategory"
				,outWhere,
				" ORDER BY B.dateRegister DESC",
				" LIMIT ?, 10");
	
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	
	 DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListBrandAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListBrandAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListBrandAll`(IN `InFkCategory` INT)
BEGIN
	
	DECLARE outWhere VARCHAR(200) DEFAULT '';
	
	SET outWhere = "WHERE statusRegister = 1";
	
	IF InFkCategory != 0 THEN
		SET outWhere = CONCAT(outWhere, " AND fkCategory = ", InFkCategory);
	END IF;

	SET @sql = CONCAT(	"SELECT pkBrand, nameBrand ",
											"FROM as_brand ",
											outWhere);
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListCategory
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListCategory`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListCategory`(IN `InStatus` TINYINT)
BEGIN
	
	SELECT pkCategory, nameCategory,statusRegister
	FROM as_category 
	WHERE statusRegister = InStatus;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListCategoryAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListCategoryAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListCategoryAll`()
BEGIN
	
	SELECT pkCategory, nameCategory
	FROM as_category 
	WHERE statusRegister = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListDriverAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListDriverAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListDriverAll`()
BEGIN
	
	SELECT pkDriver, p.nameComplete	
	FROM as_driver d 
	INNER JOIN as_person p on d.fkPerson = p.pkPerson
	WHERE d.statusRegister = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListMenuRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListMenuRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListMenuRole`(IN `InPage` INT, 
IN `InQueryNav` VARCHAR(50), 
IN `InQueryRole` VARCHAR(55), 
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;

	
	SET outWhere = CONCAT( ' WHERE MR.statusRegister = ',InStatus );
	
	IF InQueryNav != '' THEN 
		SET outWhere = CONCAT(outWhere," AND CH.navChildrenText LIKE '%",pkNavChildren, "%'");	
	END IF;
	
	IF InQueryRole != '' THEN 
		SET outWhere = CONCAT(outWhere,' AND MR.role LIKE ',"'%",InQueryRole,"%'");	
	END IF;	
	
	SET @sql = CONCAT("SELECT MR.pkMenuRole,
														MR.fkNavChildren,
														CH.navChildrenText,
														MR.role,
														MR.statusRegister,
														MR.dateRegister	"
				,"FROM as_menu_role MR "
				," INNER JOIN as_nav_children CH ON MR.fkNavChildren = CH.pkNavChildren"
				,outWhere,	
				" ORDER BY MR.dateRegister DESC",
				" LIMIT ?, 10");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	
	 DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListMessages
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListMessages`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListMessages`(IN `InFkUser` int,
IN `InPage` int,
IN `InRowsForPage` tinyint,
IN `InStatusRegister` tinyint)
BEGIN
	
	DECLARE outWhere VARCHAR(500) DEFAULT '';


	SET outWhere = CONCAT("WHERE M.statusRegister = ",InStatusRegister, 
												" AND (M.fkUserEmisor = ", InFkUser, " OR M.fkUserReceptor = ", InFkUser, ") ",
											  " AND M.isResponse = 0 "	);
	
	SET @InStart = ( InPage - 1 ) * InRowsForPage;
	SET @InEnd = InPage * InRowsForPage;
	
	SET @sql = CONCAT( "SELECT 	M.pkMessage,
															M.fkUserEmisor,
															M.fkUserReceptor,
															M.`subject`,
															M.message,
															M.tags,
															M.dateRegister,
															M.readed,
															M.dateReaded,
															
															(SELECT nameComplete FROM as_person WHERE pkPerson = UE.fkPerson ) AS nameEmisor,
															UE.userName AS userEmisor,
															(SELECT nameComplete FROM as_person WHERE pkPerson = UR.fkPerson) AS nameReceptor,
															
															(SELECT img FROM as_person WHERE pkPerson = UE.fkPerson ) AS imgEmisor,
															(SELECT img FROM as_person WHERE pkPerson = UR.fkPerson) AS imgReceptor,
															as_fn_count_response(M.pkMessage) AS totalResponses,
															as_fn_count_responseNoReaded( M.pkMessage, " ,InFkUser, " ) AS totalResponseNoReaded,
															30 AS sliceLength,
															0 AS showMore
															" , 
										 "FROM as_message M ",
										 "INNER JOIN as_user UE ON UE.pkUser = M.fkUserEmisor ",
										 "INNER JOIN as_user UR ON UR.pkUser = M.fkUserReceptor ",
										 outWhere,
										 "ORDER BY M.dateRegister DESC ",
										 "LIMIT ?, ?");
										 
	 
										 
	 PREPARE stmt FROM @sql;
	 EXECUTE stmt USING @InStart, @InEnd;
	 
	 DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListModel
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListModel`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListModel`(IN `InPage` INT,
IN `InQueryCategory` VARCHAR(50),
IN `InQueryBrand` VARCHAR(50),
IN `InQueryModel` VARCHAR(50), 
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	SET @InLimit = InPage  * 10;
	
	SET outWhere = CONCAT( ' WHERE M.statusRegister = ',InStatus );
	
	IF InQueryCategory != '' THEN 
		SET outWhere = CONCAT(outWhere," AND C.nameCategory LIKE '%", InQueryCategory, "%'");	
	END IF;
	
	IF InQueryBrand != '' THEN 
		SET outWhere = CONCAT(outWhere, " AND B.nameBrand LIKE '%" ,InQueryBrand, "%'");
	END IF;
	
	IF InQueryModel != '' THEN 
		SET outWhere = CONCAT(outWhere," AND M.nameModel LIKE '%",InQueryModel,"%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT M.pkModel,
														M.fkCategory,
														C.nameCategory,
														M.fkBrand,
														B.nameBrand,
														M.nameModel,
														M.dateRegister,
														M.statusRegister "
				,"FROM as_model M  "
				,"INNER JOIN as_category C ON C.pkCategory = M.fkCategory "
				,"INNER JOIN as_brand B on B.pkBrand = M.fkBrand "
				,outWhere,
				" ORDER BY M.dateRegister DESC",
				" LIMIT ?,?");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart, @InLimit;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListModelAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListModelAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListModelAll`(IN `InFkCategory` INT,
IN `InFkBrand` INT)
BEGIN
	
	DECLARE outWhere VARCHAR(200) DEFAULT '';
	
	SET outWhere = "WHERE statusRegister = 1";
	
	IF InFkCategory != 0 THEN
		SET outWhere = CONCAT(outWhere, " AND fkCategory = ", InFkCategory);
	END IF;
	
	IF InFkBrand != 0 THEN
		SET outWhere = CONCAT(outWhere, " AND fkBrand = ", InFkBrand);
	END IF;


	SET @sql = CONCAT(	"SELECT pkModel, nameModel ",
											"FROM as_model ",
											outWhere);
											
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNationality
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNationality`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNationality`(IN `InQuery` varchar(20))
BEGIN
	
	DECLARE outWhere, outFields VARCHAR(1000) DEFAULT 'WHERE prefixPhone IS NOT NULL ';
	
	IF InQuery != '' THEN
		SET outWhere = CONCAT(' AND nameCountry LIKE ',"'%",InQuery,"%'");
	END IF;
	
	SET outFields = "  ";
	
	SET @sql = CONCAT("SELECT pkNationality, 
														nameCountry, 
														prefixPhone, 
														isoAlfaThree,
														isoAlfaTwo,
														pkNationality AS 'value',
														nameCountry AS 'text' "
							,"FROM as_nationality "
							,outWhere
							,"ORDER BY nameCountry");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	
	DEALLOCATE PREPARE stmt;
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNavChildren
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNavChildren`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNavChildren`(IN `InPage` INT,
IN `InQueryFather` VARCHAR(50),
IN `InQueryChildren` VARCHAR(50),
IN `InQueryUrl` VARCHAR(50),
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;

	SET outWhere = CONCAT( ' WHERE NCH.statusRegister = ',InStatus );
	
	IF InQueryFather != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NFT.navFatherText LIKE '%", InQueryFather, "%'");	
	END IF;
	
	IF InQueryChildren != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NCH.navChildrenText LIKE '%", InQueryChildren, "%'");	
	END IF;
	
	IF InQueryUrl != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NCH.navChildrenPath LIKE '%", InQueryUrl, "%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT NCH.pkNavChildren,
														NCH.fkNavFather,
														NFT.navFatherText,
														NCH.navChildrenText,
														NCH.navChildrenPath,
														NCH.navChildrenIcon,
														NCH.isVisible,
														NCH.statusRegister "
				,"FROM as_nav_children NCH "
				,"INNER JOIN as_nav_father NFT ON NFT.pkNavFather = NCH.fkNavFather "
				,outWhere,
				" ORDER BY NCH.dateRegister DESC",
				" LIMIT ?, 10");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNavChildrenAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNavChildrenAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNavChildrenAll`()
BEGIN
	
	SELECT pkNavChildren, navChildrenText
	FROM as_nav_children 
	WHERE statusRegister = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNavFather
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNavFather`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNavFather`(IN `InPage` INT, 
IN `InQuery` VARCHAR(20), 
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InStatus );
	
	IF InQuery != '' THEN 
		SET outWhere = CONCAT(outWhere,' AND navFatherText LIKE ',"'%",InQuery,"%'");	
	END IF;

	
	SET @sql = CONCAT("SELECT pkNavFather, navFatherText, statusRegister, dateRegister "
				,"FROM as_nav_father "
				,outWhere,
				" ORDER BY dateRegister DESC",
				" LIMIT ?, 10");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNavFatherAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNavFatherAll`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNavFatherAll`()
BEGIN
	
	
	SELECT pkNavFather, navFatherText
	FROM as_nav_father 
	WHERE statusRegister = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListNotification
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListNotification`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListNotification`(IN `InPage` INT, IN `InPkUserEmisor` INT, IN `InUserReceptor` INT, IN `InTitle` VARCHAR(50), IN `InSender` TINYINT, IN `InReader` TINYINT, IN `InStatus` TINYINT)
BEGIN
	

	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	
	SET @InStart = (InPage - 1) * 10;
	SET @InLimit = InPage  * 10;
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InStatus );
	IF InPkUserEmisor != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserEmisor = ',InPkUserEmisor);	END IF;
	IF InUserReceptor != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InUserReceptor);	END IF;
	IF InTitle != '' THEN SET outWhere = CONCAT(outWhere,' AND notificationTitle LIKE ',"'%",InTitle,"%'");	END IF;
	IF InSender != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InSender);	END IF;
	IF InReader != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InReader);	END IF;
	
	
	SET @sql = CONCAT("SELECT pkNotification,fkUserEmisor,
	fkUserReceptor,notificationTitle,
	notificationSubTitle,notificationMessage,
	sended,dateSend,readed,
	dateReaded,statusRegister "
				,"FROM as_notification "
				,outWhere,
				" ORDER BY dateRegister DESC",
				" LIMIT ?,?");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt  USING @InStart, @InLimit;
	
	
	 DEALLOCATE PREPARE stmt;
	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListResponses
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListResponses`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListResponses`(IN `InPkMessage` int,
IN `InFkUser` int)
BEGIN

	DECLARE vIsEmisor, vPkReceptor, vPkEmisor INT DEFAULT 0;

	SELECT IF( fkUserEmisor = InFkUser, 1, 0),
							fkUserReceptor,
							fkUserEmisor
	INTO vIsEmisor, vPkReceptor, vPkEmisor
	FROM as_message
	WHERE pkMessage = InPkMessage;
	-- si es emisor voy a ver los que ha emitido el receptor
	-- si es receptor voy a ver los que ha emitido el emisor
	
	IF vIsEmisor = 1 THEN
	
		UPDATE as_message SET readed = 1,
													dateReaded = CURRENT_TIMESTAMP()
		WHERE fkMessage = InPkMessage 
		AND readed = 0 
		AND isResponse = 1
		AND fkUserEmisor = vPkEmisor;

	ELSE
	
		UPDATE as_message SET readed = 1,
													dateReaded = CURRENT_TIMESTAMP()
		WHERE fkMessage = InPkMessage 
		AND readed = 0 
		AND isResponse = 1
		AND fkUserEmisor = vPkReceptor;

	END IF;

	

	SELECT	
					M.pkMessage,
					M.fkUserEmisor,
					M.fkUserReceptor,
					M.`subject`,
					M.message,
					M.tags,
					M.dateRegister,
					M.readed,
					M.dateReaded,
					
					(SELECT nameComplete FROM as_person WHERE pkPerson = UE.fkPerson ) AS nameEmisor,
					(SELECT nameComplete FROM as_person WHERE pkPerson = UR.fkPerson) AS nameReceptor,
					
					(SELECT img FROM as_person WHERE pkPerson = UE.fkPerson ) AS imgEmisor,
					(SELECT img FROM as_person WHERE pkPerson = UR.fkPerson) AS imgReceptor
	FROM as_message M
	INNER JOIN as_user UE ON UE.pkUser = M.fkUserEmisor 
	INNER JOIN as_user UR ON UR.pkUser = M.fkUserReceptor
	WHERE isResponse = 1 AND fkMessage = InPkMessage;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListTypeDocument
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListTypeDocument`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListTypeDocument`()
BEGIN
	
	
	SELECT pkTypeDocument, nameDocument, prefix, longitude, pkTypeDocument AS 'value', prefix AS 'text'
	FROM as_type_document 
	WHERE statusRegister = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListUser`(IN `InPage` int,
IN `InRowsForPage` int,
IN `InQueryName` varchar(30),
IN `InQueryEmail` varchar(30),
IN `InQueryUser` varchar(30),
IN `InQueryRole` varchar(20),
IN `InQueryVerified` tinyint,
IN `InQueryConnect` tinyint,
IN `InStatusRegister` tinyint)
BEGIN
	
	DECLARE outWhere, outFields VARCHAR(800) DEFAULT '';
	
	SET @InStart = ( InPage - 1 ) * InRowsForPage;
	
	
	SET outWhere = CONCAT( " WHERE P.statusRegister = ", InStatusRegister );
	
	IF InQueryName != '' THEN
		SET outWhere = CONCAT( outWhere, " AND P.nameComplete LIKE '%", InQueryName, "%'" );
	END IF;
	
	IF InQueryEmail != '' THEN
		SET outWhere = CONCAT( outWhere, " AND P.email LIKE '%", InQueryEmail, "%'" );
	END IF;
	
	IF InQueryUser != '' THEN
		SET outWhere = CONCAT( outWhere, " AND U.userName LIKE '%", InQueryUser, "%'" );
	END IF;
	
	IF InQueryRole != '' THEN
		SET outWhere = CONCAT( outWhere, " AND U.role = '", InQueryRole, "'" );
	END IF;
	
	IF InQueryVerified < 2 THEN
		SET outWhere = CONCAT( outWhere, " AND U.verified = ", InQueryVerified );
	END IF;
	
	IF InQueryConnect < 2 THEN
		SET outWhere = CONCAT( outWhere, " AND U.statusSocket = ", InQueryConnect );
	END IF;
	
	SET outFields =  " P.pkPerson,
											P.`name`,
											P.surname,
											P.nameComplete,
											P.document,
											P.email,
											P.phone,
											P.img,
											
											U.pkUser,
											
											U.role,
											U.userName,
											U.verified,
											U.dateVerified,
											U.verifyReniec,
											U.fkUserVerified,
											U.statusSocket,
											U.dateRegister,
											U.osId,
											
											N.nameCountry,
											N.prefixPhone,
											
											TD.nameDocument,
											TD.prefix,
											
											IF(D.pkDriver IS NULL,0 , 1) AS 'isDriver',
											
											IF(D.pkDriver IS NULL,0 ,D.pkDriver) AS 'pkDriver' ";
	
	SET @sql = CONCAT( "SELECT" 
										, outFields
										," FROM as_person P"
										, " INNER JOIN as_user U ON U.fkPerson = P.pkPerson
												INNER JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
												INNER JOIN as_nationality N ON N.pkNationality = P.fkNationality
												LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson "
										, outWhere
										, " ORDER BY U.dateRegister DESC"
										, " LIMIT ?,", InRowsForPage);
	
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;								
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getListVehicleDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getListVehicleDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_getListVehicleDriver`(IN `InPage` INT, 
IN `InPkDriver` INT, 
IN `InPkBrand` TINYINT, 
IN `InPkModel` TINYINT,
IN `InIsProper` TINYINT, 
IN `InNumberPlate` VARCHAR(15), 
IN `InYear` TINYINT, 
IN `InColor` VARCHAR(20), 
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	SET @InLimit = InPage  * 10;
	
	SET outWhere = CONCAT( ' WHERE v.statusRegister = ',InStatus );
	IF InPkDriver != '' THEN SET outWhere = CONCAT(outWhere,' AND v.fkDriver = ',InPkDriver);	END IF;
	IF InPkBrand != '' THEN SET outWhere = CONCAT(outWhere,' AND v.fkBrand = ',InPkBrand);	END IF;
	IF InPkModel != '' THEN SET outWhere = CONCAT(outWhere,' AND v.fkModel = ',InPkModel);	END IF;
	IF InIsProper != '' THEN SET outWhere = CONCAT(outWhere,' AND v.isProper = ',InIsProper);	END IF;
	IF InNumberPlate != '' THEN SET outWhere = CONCAT(outWhere,' AND v.numberPlate LIKE ',"'%",InNumberPlate,"%'");	END IF;
	IF InYear != '' THEN SET outWhere = CONCAT(outWhere,' AND v.year = ',InYear);	END IF;
	IF InColor != '' THEN SET outWhere = CONCAT(outWhere,' AND v.color LIKE ',"'%",InColor,"%'");	END IF;	
	
	SET @sql = CONCAT("SELECT v.pkVehicleDriver,
v.fkDriver,
pe.nameComplete,
v.fkBrand,
b.nameBrand,
	v.fkModel,
	m.nameModel,
	v.isProper,
	v.imgLease,
	v.numberPlate,
	v.year,
	v.color,
	v.imgSoat,
	v.dateSoatExpiration,
	v.imgPropertyCard,
	v.statusRegister	 "
				,"	FROM as_vehicle_driver v	
	INNER JOIN as_brand b ON v.fkBrand = b.pkBrand
	INNER JOIN as_model m on v.fkModel = m.pkModel
	INNER JOIN as_driver dr on v.fkDriver = dr.pkDriver
	INNER JOIN as_person pe on dr.fkPerson = pe.pkPerson "
				,outWhere,	
				" ORDER BY v.dateRegister DESC",
				" LIMIT ?,?");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart, @InLimit;
	
	
	 DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getMenuForRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getMenuForRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_getMenuForRole`(IN `InPkUser` int,
IN `InRole` varchar(20))
BEGIN
	
	SELECT 	MR.pkMenuRole,
					MR.fkNavChildren,
					NCH.navChildrenText,
					NCH.navChildrenPath,
					NCH.navChildrenIcon,
					MR.role,
					NCH.isVisible
	FROM as_menu_role MR
	INNER JOIN as_nav_children NCH ON NCH.pkNavChildren = MR.fkNavChildren
	WHERE MR.statusRegister = 1 AND MR.role = InRole AND NCH.isVisible = 1
	ORDER BY NCH.navChildrenText;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getMonitorClients
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getMonitorClients`;
delimiter ;;
CREATE PROCEDURE `as_sp_getMonitorClients`()
BEGIN
	#Routine body goes here...
	SELECT U.pkUser,
	U.lat, 
	U.lng, 
	P.nameComplete,
	U.dateWaiting

	FROM as_user U
	LEFT JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE U.role = 'CLIENT_ROLE' 
	AND U.statusSocket = 1 
	AND U.statusRegister = 1 
	AND U.verified = 1
	AND U.waiting = 1
	AND U.lat IS NOT NULL;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getMonitorDrivers
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getMonitorDrivers`;
delimiter ;;
CREATE PROCEDURE `as_sp_getMonitorDrivers`()
BEGIN
	#Routine body goes here...
	SELECT U.pkUser,
	U.lat, 
	U.lng, 
	U.occupied, 
	P.nameComplete, 
	CASE U.category
		WHEN 1 THEN
			'BASIC'
		WHEN 2 THEN
			'STANDAR'
		WHEN 3 THEN
			'PREMIUM'
		ELSE
			'UNDEFINED'
	END AS 'codeCategory'

	FROM as_user U
	LEFT JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE U.role = 'DRIVER_ROLE' 
	AND U.statusSocket = 1 
	AND U.statusRegister = 1 
	AND U.verified = 1 
	AND U.playGeo = 1 
	AND U.lat IS NOT NULL;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getNotifyReceptor
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getNotifyReceptor`;
delimiter ;;
CREATE PROCEDURE `as_sp_getNotifyReceptor`(IN `InPkUser` int)
BEGIN
	
	
	SELECT N.pkNotification, 
					N.fkUserEmisor,
					P.nameComplete,
					P.img,
					N.dateSend,
					N.readed,
					N.notificationTitle,
					N.notificationSubTitle,
					N.notificationMessage,
					N.urlShow
	FROM as_notification N
	INNER JOIN as_user U ON U.pkUser = N.fkUserEmisor
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE N.fkUserReceptor = InPkUser AND N.statusRegister = 1 
	ORDER BY N.dateSend DESC
	LIMIT 0,5;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getPasswordUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getPasswordUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_getPasswordUser`(IN `InPkUser` int)
BEGIN
	#Routine body goes here...
	DECLARE outPass VARCHAR(200) DEFAULT 'xD';
	
	SELECT	IF(userPassword IS NULL,'xD', userPassword) INTO outPass
	FROM as_user
	WHERE pkUser = InPkUser;
	
	SELECT outPass AS 'password';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getProfileDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getProfileDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_getProfileDriver`(IN `InPkDriver` int)
BEGIN
	
	
	SELECT P.pkPerson,
			P.`name`,
			P.surname,
			P.nameComplete,
			P.document,
			P.email,
			P.phone,
			IF(P.img IS NULL,'', P.img) AS 'img',
			P.brithDate,
			P.sex,
			P.fkTypeDocument,
			P.fkNationality,
			
			IF(P.brithDate IS NOT NULL ,  YEAR( CURRENT_TIMESTAMP() ) - YEAR(P.brithDate), 0) AS yearsOld,
			U.pkUser,
			U.userName,
			U.verified,
			U.dateVerified,
			U.verifyReniec,
			U.fkUserVerified,
			U.osId,
			U.statusRegister,
			
			N.nameCountry,
			N.prefixPhone,
			
			TD.nameDocument,
			TD.prefix,
			
			IF(D.pkDriver IS NULL,0, D.pkDriver) AS 'pkDriver',
			D.imgLicense,
			D.imgPhotoCheck,
			D.imgCriminalRecord,
			D.imgPolicialRecord,
			D.isEmployee,
			D.dateLicenseExpiration
			
	FROM as_person P 
		LEFT JOIN as_user U ON U.fkPerson = P.pkPerson
		LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
		LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
		LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson  
	WHERE D.pkDriver = InPkDriver; 
					
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getProfileUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getProfileUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_getProfileUser`(IN `InPkUser` INT)
BEGIN
	
	
	SELECT P.pkPerson,
			P.fkTypeDocument,
			P.fkNationality,
			P.`name`,
			P.surname,
			P.nameComplete,
			P.document,
			P.email,
			P.phone,
			P.img,
			P.brithDate,
			P.sex,
			
			IF(P.brithDate IS NOT NULL ,  YEAR( CURRENT_TIMESTAMP() ) - YEAR(P.brithDate), 0) AS yearsOld,
			U.pkUser,
			U.userName,
			U.verified,
			U.dateVerified,
			U.verifyReniec,
			U.fkUserVerified,
			U.osId,
			U.statusRegister,
			
			N.nameCountry,
			N.prefixPhone,

			TD.nameDocument,
			TD.prefix
			
	FROM as_user U 
		LEFT JOIN as_person P ON U.fkPerson = P.pkPerson
		LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
		LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
	WHERE U.pkUser = InPkUser; 

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getTotalMsg
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getTotalMsg`;
delimiter ;;
CREATE PROCEDURE `as_sp_getTotalMsg`(IN `InFkReceptor` int)
BEGIN
	#Routine body goes here...
	
	SELECT COUNT(*) AS 'total'
	FROM as_message 
	WHERE fkUserReceptor = InFkReceptor AND statusRegister = 1 AND readed = 0 AND isResponse = 0;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getUserAttentionOf
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getUserAttentionOf`;
delimiter ;;
CREATE PROCEDURE `as_sp_getUserAttentionOf`()
BEGIN
	

	SELECT 	U.pkUser,
					U.role,
					P.nameComplete
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE U.role = 'ATTENTION_ROLE' AND U.statusRegister = 1
	ORDER BY U.dateRegister, U.dateUpdate DESC
	LIMIT 0,1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getUserRestore
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getUserRestore`;
delimiter ;;
CREATE PROCEDURE `as_sp_getUserRestore`(IN `InEmail` varchar(100))
BEGIN
	#Routine body goes here... 
	DECLARE outPkUser INT DEFAULT 0;
	DECLARE outName VARCHAR(100) DEFAULT '';
	DECLARE vErrRole TINYINT DEFAULT 2;
	
	SELECT IF( U.pkUser IS NULL , 0, U.pkUser),
					IF( P.nameComplete IS NULL, '', P.nameComplete),
					IF( U.role IN ('CLIENT_ROLE', 'DRIVER_ROLE') , 0, 2)
	INTO outPkUser, outName, vErrRole
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE  TRIM( P.email ) = TRIM( InEmail ) LIMIT 0,1;
	
	IF outPkUser != 0 AND vErrRole = 0 THEN
		
		UPDATE as_user SET pendingRestore = 1,
												dateRestore = CURRENT_TIMESTAMP()
		WHERE pkUser = outPkUser;
		
	END IF;

	
	SELECT outPkUser AS 'pkUser', outName AS 'nameComplete', 'restore' AS 'role', vErrRole AS 'errRole';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getVehicleDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getVehicleDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_getVehicleDriver`(IN `InPkDriver` int)
BEGIN
	
	
	SELECT V.pkVehicle,
					V.fkDriver,
					V.fkCategory,
					V.fkBrand,
					V.fkModel,
					V.imgSoat,
					V.dateSoatExpiration,
					V.color,
					V.numberPlate,
					V.`year`,
					V.imgPropertyCard,
					V.imgTaxiBack,
					V.imgTaxiFrontal,
					V.imgTaxiInterior,
					V.isProper,
					V.dateRegister,
					V.verified,
					V.dateVerified,
					V.statusRegister,
					C.aliasCategory AS 'nameCategory',
					C.codeCategory,
					B.nameBrand,
					V.driverUsing,
					M.nameModel
					
	FROM as_vehicle V
	LEFT JOIN as_category C ON C.pkCategory = V.fkCategory
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	WHERE V.fkDriver = InPkDriver AND V.statusRegister = 1
	ORDER BY V.dateRegister DESC;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_getZonesDemand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_getZonesDemand`;
delimiter ;;
CREATE PROCEDURE `as_sp_getZonesDemand`()
BEGIN
	#Routine body goes here...
	DECLARE vPkCategory INT DEFAULT 0;
	DECLARE InWhere VARCHAR(1500);
	
	SET InWhere = " WHERE statusRegister = 1 AND statusService = 1";

	
	SET @sql = CONCAT(" SELECT indexHex, COUNT(*) AS 'total', ts_fn_countDriverZone( indexHex ) AS 'totalDrivers' ",
										" FROM ts_service",
										InWhere,
										-- " AND ts_fn_countDeclineOfer( ts_service.pkService, ", InPkUser , ") = 0 ",
										" GROUP BY indexHex ",
										" ORDER BY COUNT(*) DESC, ts_fn_countDriverZone( indexHex ) ASC;");
	-- select @sql;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_loginClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_loginClient`;
delimiter ;;
CREATE PROCEDURE `as_sp_loginClient`(IN `InUserName` varchar(60))
BEGIN
	
	DECLARE vPkUser INT;
	DECLARE vErrPass, vErrFound, vErrVerified, vErrStatus, outError, vErrRole TINYINT DEFAULT 0 ;
	
	SELECT 	pkUser,
					IF(pkUser IS NULL, 1, 0),
					IF(verified = 0, 4, 0),
					IF(statusRegister = 0, 8, 0),
					IF(role = 'CLIENT_ROLE', 0, 16)
					
	INTO vPkUser, vErrFound, vErrVerified, vErrStatus, vErrRole
	FROM as_user 
	WHERE userName = TRIM( InUserName );

	SET outError = outError + vErrFound + vErrVerified + vErrStatus + vErrRole;
	
	
	IF outError != 0 THEN
		SELECT outError AS 'showError';
	ELSE
		 
		 SELECT U.pkUser,
						P.pkPerson,
						U.userName,
						U.userPassword,
						
						P.`name`,
						P.surname,
						P.nameComplete,
						TD.prefix,
						N.nameCountry,
						P.document,
						P.email,
						P.phone,
						P.img,
						
						U.role,
						outError AS 'showError'
						
		 FROM as_user U
		 LEFT JOIN as_person P on P.pkPerson = U.fkPerson
		 LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
		 LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
		 WHERE pkUser = vPkUser;
		 
	END IF;


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_loginDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_loginDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_loginDriver`(IN `InUserName` varchar(50))
BEGIN
	#Routine body goes here...
	DECLARE vPkUser INT;
	DECLARE outError, vErrVerified, vErrStatus, outErrRole TINYINT DEFAULT 0 ;
	
	SELECT 	pkUser,
					IF(verified = 0, 4, 0),
					IF(statusRegister = 0, 8, 0),
					IF(role != 'DRIVER_ROLE', 16, 0)
					
	INTO vPkUser, vErrVerified, vErrStatus, outErrRole
	FROM as_user 
	WHERE userName = TRIM( InUserName );
	
	IF vPkUser IS NULL THEN
		SET outError = 1;
	ELSE
		SET outError = outError + vErrVerified + outErrRole + vErrStatus;
	END IF;
	
	
	IF outError != 0 THEN
		SELECT outError AS 'showError';
	ELSE
		 
		 SELECT U.pkUser,
						P.pkPerson,
						D.pkDriver,
						U.userName,
						U.userPassword,
						
						P.`name`,
						P.surname,
						P.nameComplete,
						-- TD.prefix,
						-- N.nameCountry,
						-- P.document,
						P.email,
						P.phone,
						P.img,
						
						U.role,
						
						# jornada conductor
						JD.pkJournalDriver,
						JD.rateJournal,
						JD.nameJournal,
						JD.modeJournal,
						JD.dateStart,
						JD.codeJournal,
						
						outError AS 'showError'
						
		 FROM as_user U
		 LEFT JOIN as_person P on P.pkPerson = U.fkPerson
		 LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson
		 LEFT JOIN ts_journal_driver JD ON JD.fkDriver = D.pkDriver AND JD.journalStatus = 1
		 -- LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
		 -- LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
		 WHERE pkUser = vPkUser;
		 
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_loginWeb
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_loginWeb`;
delimiter ;;
CREATE PROCEDURE `as_sp_loginWeb`(IN `InUserName` varchar(60),
IN `InUserPass` varchar(200))
BEGIN
	
	DECLARE vPkUser INT;
	DECLARE vErrPass, vErrVerified, vErrRole, vErrFound, outError TINYINT DEFAULT 0 ;
	
	SELECT 	pkUser, 
					IF(pkUser IS NULL,1 , 0),
					
					IF(verified = 0, 4, 0),
					
					CASE role
						WHEN 'DRIVER_ROLE' THEN	8
						WHEN 'CLIENT_ROLE' THEN 16
					END 

	INTO vPkUser,vErrFound, vErrVerified, vErrRole
	FROM as_user 
	WHERE userName = TRIM( InUserName );

	SET outError = outError + vErrFound + vErrVerified + vErrRole;
	
	
	IF outError != 0 THEN
		SELECT outError AS 'showError';
	ELSE
		 
		 SELECT U.pkUser,
						U.userName,
						U.userPassword,
						P.nameComplete,
						P.email,
						P.phone,
						P.img,
						U.role,
						outError AS 'showError'
						
		 FROM as_user U
		 LEFT JOIN as_person P on P.pkPerson = U.fkPerson
		 WHERE pkUser = vPkUser;
		 
	END IF;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageApplication
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageApplication`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageApplication`(IN `InQuery` varchar(50),
IN `InShowInactive` tinyint)
BEGIN
	
	DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InShowInactive );
	
	IF InQuery != '' THEN
		SET outWhere = CONCAT( outWhere, " AND nameApp LIKE '%",InShowInactive, "%'" );
	END IF;
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total ",
										"FROM as_application",	
										outWhere );
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageBrand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageBrand`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageBrand`(IN `InQueryCat` VARCHAR(80), 
IN `InQueryBrand` VARCHAR(80), 
IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE B.statusRegister = ',InStatus );
	
	IF InQueryCat != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND C.nameCategory LIKE '%",InQueryCat, "%'");	
	END IF;
	
	IF InQueryBrand != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND B.nameBrand LIKE '%",InQueryBrand,"%'");	
	END IF;

	
	SET @sql = CONCAT("SELECT COUNT(*) AS total ",
										"FROM as_brand B ",
										"INNER JOIN as_category C ON C.pkCategory = B.fkCategory ",
										outWhere );
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageMenuRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageMenuRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageMenuRole`(IN `InQueryNav` VARCHAR(50), 
IN `InQueryRole` VARCHAR(50), 
IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE MR.statusRegister = ',InStatus );
	
	IF InQueryNav != '' THEN 
		SET outWhere = CONCAT(outWhere," AND CH.navChildrenText LIKE '%",pkNavChildren, "%'");	
	END IF;
	
	IF InQueryRole != '' THEN 
		SET outWhere = CONCAT(outWhere,' AND MR.role LIKE ',"'%",InQueryRole,"%'");	
	END IF;	
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_menu_role MR "
				,"INNER JOIN as_nav_children CH ON MR.fkNavChildren = CH.pkNavChildren "
				,outWhere);
	
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageMessages
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageMessages`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageMessages`(IN `InFkUser` int,
IN `InStatusRegister` tinyint)
BEGIN
	
	DECLARE outWhere VARCHAR(500) DEFAULT '';
	
	SET outWhere = CONCAT("WHERE M.statusRegister = ",InStatusRegister, 
												" AND (M.fkUserEmisor = ", InFkUser, " OR M.fkUserReceptor = ", InFkUser, ") ",
												" AND M.isResponse = 0 ");

	SET @sql = CONCAT( "SELECT COUNT(*) AS 'total' FROM as_message M ",
										 outWhere,
										 "ORDER BY M.dateRegister DESC ");
										 
	 PREPARE stmt FROM @sql;
	 EXECUTE stmt;
	 
	 DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageModel
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageModel`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageModel`(IN `InQueryCategory` VARCHAR(50),
IN `InQueryBrand` VARCHAR(50),
IN `InQueryModel` VARCHAR(50), 
IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE M.statusRegister = ',InStatus );
	
	IF InQueryCategory != '' THEN 
		SET outWhere = CONCAT(outWhere," AND C.nameCategory LIKE '%", InQueryCategory, "%'");	
	END IF;
	
	IF InQueryBrand != '' THEN 
		SET outWhere = CONCAT(outWhere, " AND B.nameBrand LIKE '%" ,InQueryBrand, "%'");
	END IF;
	
	IF InQueryModel != '' THEN 
		SET outWhere = CONCAT(outWhere," AND M.nameModel LIKE '%",InQueryModel,"%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_model "
				,outWhere);
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_model M  "
				,"INNER JOIN as_category C ON C.pkCategory = M.fkCategory "
				,"INNER JOIN as_brand B on B.pkBrand = M.fkBrand "
				,outWhere);
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageNavChildren
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageNavChildren`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageNavChildren`(IN `InQueryFather` VARCHAR(50),
IN `InQueryChildren` VARCHAR(50),
IN `InQueryUrl` VARCHAR(50),
IN `InStatus` TINYINT)
BEGIN
	
	DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE NCH.statusRegister = ',InStatus );
	
	IF InQueryFather != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NFT.navFatherText LIKE '%", InQueryFather, "%'");	
	END IF;
	
	IF InQueryChildren != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NCH.navChildrenText LIKE '%", InQueryChildren, "%'");	
	END IF;
	
	IF InQueryUrl != '' THEN 
		SET outWhere = CONCAT(outWhere," AND NCH.navChildrenPath LIKE '%", InQueryUrl, "%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total ",
										"FROM as_nav_children NCH ",	
										"INNER JOIN as_nav_father NFT ON NFT.pkNavFather = NCH.fkNavFather ",
										outWhere );
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageNavFather
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageNavFather`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageNavFather`(IN `InQuery` VARCHAR(20), 
IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InStatus );
	
	IF InQuery != '' THEN 
		SET outWhere = CONCAT(outWhere,' AND navFatherText LIKE ',"'%",InQuery,"%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_nav_father "
				,outWhere);
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageNotification
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageNotification`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageNotification`(IN `InPkUserEmisor` INT, IN `InUserReceptor` INT, IN `InTitle` VARCHAR(50), IN `InSender` TINYINT, IN `InReader` TINYINT, IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InStatus );
	IF InPkUserEmisor != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserEmisor = ',InPkUserEmisor);	END IF;
	IF InUserReceptor != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InUserReceptor);	END IF;
	IF InTitle != '' THEN SET outWhere = CONCAT(outWhere,' AND notificationTitle LIKE ',"'%",InTitle,"%'");	END IF;
	IF InSender != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InSender);	END IF;
	IF InReader != '' THEN SET outWhere = CONCAT(outWhere,' AND fkUserReceptor = ',InReader);	END IF;
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_notification "
				,outWhere);
	
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageUser`(IN `InQueryName` varchar(30),
IN `InQueryEmail` varchar(30),
IN `InQueryUser` varchar(30),
IN `InQueryRole` varchar(20),
IN `InQueryVerified` tinyint,
IN `InQueryConnect` tinyint,
IN `InStatusRegister` tinyint)
BEGIN
	
	DECLARE outWhere VARCHAR(700) DEFAULT '';
	
	SET outWhere = CONCAT( " WHERE P.statusRegister = ", InStatusRegister );
	
	IF InQueryName != '' THEN
		SET outWhere = CONCAT( outWhere, " AND P.nameComplete LIKE '%", InQueryName, "%'" );
	END IF;
	
	IF InQueryEmail != '' THEN
		SET outWhere = CONCAT( outWhere, " AND P.email LIKE '%", InQueryEmail, "%'" );
	END IF;
	
	IF InQueryUser != '' THEN
		SET outWhere = CONCAT( outWhere, " AND U.userName LIKE '%", InQueryUser, "%'" );
	END IF;
	
	IF InQueryRole != '' THEN
		SET outWhere = CONCAT( outWhere, " AND U.role = '", InQueryRole, "'" );
	END IF;
	
	IF InQueryVerified < 2 THEN
		SET outWhere = CONCAT( outWhere, " AND U.verified = ", InQueryVerified );
	END IF;
	
	IF InQueryConnect < 2 THEN
		SET outWhere = CONCAT( outWhere, " AND U.statusSocket = ", InQueryConnect );
	END IF;
	
	
	SET @sql = CONCAT( "SELECT COUNT(*) as total FROM as_person P"
										, " INNER JOIN as_user U ON U.fkPerson = P.pkPerson "
										, outWhere);
										
	-- SELECT @sql;
										
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_overallPageVehicleDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_overallPageVehicleDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_overallPageVehicleDriver`(IN `InPkDriver` INT, IN `InPkBrand` TINYINT, IN `InPkModel` TINYINT, IN `InIsProper` TINYINT, IN `InNumberPlate` VARCHAR(15), IN `InYear` TINYINT, IN `InColor` VARCHAR(20), IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE statusRegister = ',InStatus );
	IF InPkDriver != '' THEN SET outWhere = CONCAT(outWhere,' AND fkDriver = ',InPkDriver);	END IF;
	IF InPkBrand != '' THEN SET outWhere = CONCAT(outWhere,' AND fkBrand = ',InPkBrand);	END IF;
	IF InPkModel != '' THEN SET outWhere = CONCAT(outWhere,' AND fkModel = ',InPkModel);	END IF;
	IF InIsProper != '' THEN SET outWhere = CONCAT(outWhere,' AND isProper = ',InIsProper);	END IF;
	IF InNumberPlate != '' THEN SET outWhere = CONCAT(outWhere,' AND numberPlate LIKE ',"'%",InNumberPlate,"%'");	END IF;
	IF InYear != '' THEN SET outWhere = CONCAT(outWhere,' AND year = ',InYear);	END IF;
	IF InColor != '' THEN SET outWhere = CONCAT(outWhere,' AND color LIKE ',"'%",InColor,"%'");	END IF;	
	
	SET @sql = CONCAT("SELECT COUNT(*) AS total "
				,"FROM as_vehicle_driver "
				,outWhere);
	
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_restorePassword
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_restorePassword`;
delimiter ;;
CREATE PROCEDURE `as_sp_restorePassword`(IN `InPkUser` int,
IN `InPassword` varchar(200),
IN `InIp` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_restorePsw( InPkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET 	userPassword = InPassword,
												pendingRestore = 0,
												dateRestore = CURRENT_TIMESTAMP(),
												ipRestore = InIp
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_singSocket
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_singSocket`;
delimiter ;;
CREATE PROCEDURE `as_sp_singSocket`(IN `InFkUser` int,
IN `InOsId` varchar(100),
IN `InStatusSocket` tinyint)
BEGIN
	
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkTraffic INT DEFAULT 0;
	DECLARE vStatusSocket, vErrRole TINYINT DEFAULT 0;
	
	SET outError =  as_fn_verify_singSocket( InFkUser );
	
	IF outError = 0 THEN
	
		SELECT statusSocket,
						IF(role NOT BETWEEN 'CLIENT_ROLE' AND 'DRIVER_ROLE', 1, 0)
		INTO vStatusSocket, vErrRole
		FROM as_user
		WHERE pkUser = InFkUser;
		
		IF InStatusSocket = 1 THEN
			UPDATE as_user SET osId = InOsId,
												 statusSocket = 1
			WHERE pkUser = InFkUser;
			
			IF vStatusSocket = 0 AND vErrRole = 0 THEN
				SET outPkTraffic = ch_fn_addTraffic();
			END IF;

		ELSE
			UPDATE as_user SET statusSocket = 0,
												 playGeo = 0
			WHERE pkUser = InFkUser;
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError', outPkTraffic AS 'traffic';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateApplication
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateApplication`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateApplication`(IN `InPkApplication` INT,
IN `InNameApp` VARCHAR(40),
IN `InDescription` VARCHAR(100),
IN `InPlattform` VARCHAR(10),
IN `InPkUser` INT,
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateApplication(InPkApplication, InNameApp);
	
	IF outError = 0 THEN
		UPDATE as_application SET 
						nameApp = InNameApp,
						description = InDescription,
						plattform = InPlattform,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkApplication = InPkApplication;
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateBrand
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateBrand`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateBrand`(IN `InPkBrand` INT, IN `InPkCategory` INT, IN `InNameBrand` VARCHAR(80), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateBrand(InPkBrand,InNameBrand);
	
	IF outError = 0 THEN
		UPDATE as_brand SET 
						fkCategory=InPkCategory,
						nameBrand=InNameBrand,		
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkBrand = InPkBrand;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateCategory
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateCategory`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateCategory`(IN `InPkCategory` INT, IN `InName` VARCHAR(80), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	
	
	IF outError = 0 THEN
		UPDATE as_category SET 
						nameCategory=InName,		
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkCategory = InPkCategory;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateFilesDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateFilesDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateFilesDriver`(IN `InFkEntity` int,
IN `InEntity` varchar(10),
IN `InDocument` varchar(20),
IN `InImg` varchar(50),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	DECLARE outOldImg VARCHAR(50) DEFAULT '';
	
	SET outError = as_fn_verify_updateFilesdriver( InFkEntity, InEntity );
	
	
	
	IF outError = 0 THEN
	
		IF InEntity = 'DRIVER' THEN
		
			CASE InDocument
				WHEN 'LICENSE' THEN
				
					SET outOldImg = (SELECT imgLicense FROM as_driver WHERE pkDriver = InFkEntity);
				
					UPDATE as_driver SET imgLicense = InImg
					WHERE pkDriver = InFkEntity;
					
				WHEN 'PHOTO_CHECK' THEN
				
					SET outOldImg = (SELECT imgPhotoCheck FROM as_driver WHERE pkDriver = InFkEntity);
					
					UPDATE as_driver SET imgPhotoCheck = InImg
					WHERE pkDriver = InFkEntity;
					
				WHEN 'CRIMINAL_RECORD' THEN
				
					SET outOldImg = (SELECT imgCriminalRecord FROM as_driver WHERE pkDriver = InFkEntity);
				
					UPDATE as_driver SET imgCriminalRecord = InImg
					WHERE pkDriver = InFkEntity;
					
				WHEN 'POLICIAL_RECORD' THEN
				
					SET outOldImg = (SELECT imgPolicialRecord FROM as_driver WHERE pkDriver = InFkEntity);
				
					UPDATE as_driver SET imgPolicialRecord = InImg
					WHERE pkDriver = InFkEntity;
					
			END CASE;

		ELSEIF InEntity = 'VEHICLE' THEN
		
			CASE InDocument
				WHEN 'SOAT' THEN
				
					SET outOldImg = (SELECT imgSoat FROM as_vehicle WHERE pkVehicle = InFkEntity);
				
					UPDATE as_vehicle SET imgSoat = InImg
					WHERE pkVehicle = InFkEntity;
					
				WHEN 'PROPERTY_CARD' THEN
				
					SET outOldImg = (SELECT imgPropertyCard FROM as_vehicle WHERE pkVehicle = InFkEntity);
				
					UPDATE as_vehicle SET imgPropertyCard = InImg
					WHERE pkVehicle = InFkEntity;
					
				WHEN 'TAXI_FRONTAL' THEN
					
					SET outOldImg = (SELECT imgTaxiFrontal FROM as_vehicle WHERE pkVehicle = InFkEntity);
					
					UPDATE as_vehicle SET imgTaxiFrontal = InImg
					WHERE pkVehicle = InFkEntity;
					
				WHEN 'TAXI_BACK' THEN
					
					SET outOldImg = (SELECT imgTaxiBack FROM as_vehicle WHERE pkVehicle = InFkEntity);
				
					UPDATE as_vehicle SET imgTaxiBack = InImg
					WHERE pkVehicle = InFkEntity;
					
				WHEN 'TAXI_INTERIOR' THEN
					
					SET outOldImg = (SELECT imgTaxiInterior FROM as_vehicle WHERE pkVehicle = InFkEntity);
				
					UPDATE as_vehicle SET imgTaxiInterior = InImg
					WHERE pkVehicle = InFkEntity;
					 
			END CASE;
			
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError', outOldImg AS 'oldImg';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateMenuRole
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateMenuRole`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateMenuRole`(IN `InPkMenuRole` INT, IN `InPkNavChildren` INT, IN `InRole` VARCHAR(255), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateMenuRole(InPkMenuRole, InPkNavChildren,InRole);
	
	IF outError = 0 THEN
		UPDATE as_menu_role SET 
						fkNavChildren=InPkNavChildren,
						role=InRole,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkMenuRole = InPkMenuRole;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateModel
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateModel`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateModel`(IN `InPkModel` INT, 
IN `InPkCategory` TINYINT, 
IN `InPkBrand` INT, 
IN `InNameModel` VARCHAR(80), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateModel(InPkModel,InPkBrand, InNameModel);
	
	IF outError = 0 THEN
		UPDATE as_model SET 
						fkCategory=InPkCategory,
						fkBrand=InPkBrand,
						nameModel=InNameModel,			
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkModel = InPkModel;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateNavChildren
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateNavChildren`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateNavChildren`(IN `InPkNavChildren` INT, 
IN `InPkNavFather` INT, 
IN `InNavChildrenText` VARCHAR(50), 
IN `InNavChildrenPath` VARCHAR(40), 
IN `InNavChildrenIcon` VARCHAR(20), 
IN `InIsVisible` TINYINT, 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateNavChildren(InPkNavChildren, InPkNavFather,InNavChildrenText);
	
	IF outError = 0 THEN
		UPDATE as_nav_children SET 
						fkNavFather = InPkNavFather,
						navChildrenText = InNavChildrenText,
						navChildrenPath = InNavChildrenPath,
						navChildrenIcon = InNavChildrenIcon,
						isVisible = InIsVisible,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkNavChildren = InPkNavChildren;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateNavFather
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateNavFather`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateNavFather`(IN `InPkNavFather` INT, IN `InNameFather` VARCHAR(100), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateNavFather(InPkNavFather, InNameFather);
	
	IF outError = 0 THEN
		UPDATE as_nav_father SET 
						navFatherText=InNameFather,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkNavFather = InPkNavFather;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateNotification
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateNotification`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateNotification`(IN `InPkNotificacion` INT, IN `InPkUserEmisor` INT, IN `InPkUserReceptor` INT, IN `InNotificationTitle` VARCHAR(255), IN `InNotificationSubTitle` VARCHAR(255), IN `InNotificationMessage` VARCHAR(255), IN `InSended` TINYINT, IN `InReaded` TINYINT, IN `InDateReaded` VARCHAR(20), IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	
	
	IF outError = 0 THEN
		UPDATE as_notification SET 
						fkUserEmisor=InPkUserEmisor,
						fkUserReceptor=InPkUserReceptor,
						notificationTitle=InNotificationTitle,
						notificationSubTitle=InNotificationSubTitle,
						notificationMessage=InNotificationMessage,
						sended=InSended,
						readed=InReaded,
						dateReaded=STR_TO_DATE(InDateReaded, '%d/%m/%Y')  ,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkNotification = InPkNotificacion;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updatePassUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updatePassUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_updatePassUser`(IN `InPkUser` int,
IN `InPassword` varchar(200),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updatePassUser( InPkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET userPassword = InPassword,
												dateUpdate = CURRENT_TIMESTAMP(),
												fkUserUpdate = InFkUser,
												ipUpdate = InIpUser
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updatePhotoUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updatePhotoUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_updatePhotoUser`(IN `InPkUser` int,
IN `InPhoto` varchar(80),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verifyUpdatePhotoUser( InPkUser );
	
	IF outError = 0 THEN
		UPDATE as_person SET img = InPhoto
		WHERE pkPerson = ( SELECT fkPerson FROM as_user WHERE pkUser = InPkUser );
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updatePlayGeo
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updatePlayGeo`;
delimiter ;;
CREATE PROCEDURE `as_sp_updatePlayGeo`(IN `InPkUser` int,
IN `InPlayGeo` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updatePlayGeo( InPkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET playGeo = InPlayGeo
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateProfile
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateProfile`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateProfile`(IN `InPkUser` int,
IN `InFkTypeDoc` int,
IN `InDocument` varchar(20),
IN `InNames` varchar(80),
IN `InSurname` varchar(80),
IN `InDateBirth` varchar(80),
IN `InFkUser` int,
IN `InIp` varchar(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateProfile(InPkUser, InFkTypeDoc, InDocument);
	
	IF outError = 0 THEN
		UPDATE as_person SET fkTypeDocument = InFkTypeDoc,
													document = InDocument,
													`name`= InNames,
													surname = InSurname,
													nameComplete = CONCAT(InSurname,", ",InNames),
													brithDate = InDateBirth,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIp
		WHERE pkPerson = (SELECT fkPerson FROM as_user WHERE pkUser = InPkUser);
	END IF;

	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateProfileDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateProfileDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateProfileDriver`(IN `InPkUser` int,
IN `InPkPerson` int,
IN `InPkDriver` int,
IN `InFkTypeDoc` int,
IN `InFkNationality` int,
IN `InDocument` varchar(15),

IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InEmail` varchar(50),
IN `InPhone` varchar(20),
IN `InSex` CHAR(1),
IN `InDateBirth` varchar(12),

IN `InDateLicenceExpiration` varchar(12),
IN `InIsEmployee` tinyint,

IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updateProfileDriver(InPkUser, InPkPerson, InPkDriver, InEmail);
	
	IF outError = 0 THEN
		UPDATE as_person SET fkTypeDocument = InFkTypeDoc,
													fkNationality = InFkNationality,
													document = InDocument,
													`name` = InName,
													surname = InSurname,
													nameComplete = CONCAT( InSurname, ', ', InName ),
													email = InEmail,
													phone = InPhone,
													sex = InSex,
													brithDate = IF(InDateBirth = '', null , InDateBirth),
													
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser,
													dateUpdate = CURRENT_TIMESTAMP()
		WHERE pkPerson = InPkPerson;
		
		UPDATE as_user SET 	fkUserUpdate = InFkUser,
												ipUpdate = InIpUser,
												dateUpdate = CURRENT_TIMESTAMP()
		WHERE pkUser =  InPkUser AND fkPerson = InPkPerson;
		
		UPDATE as_driver SET dateLicenseExpiration = InDateLicenceExpiration,
													isEmployee = InIsEmployee,
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser,
													dateUpdate = CURRENT_TIMESTAMP()
		WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson ;
												
	END IF;
	
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateProfileUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateProfileUser`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateProfileUser`(IN `InPkUser` int,
IN `InFkTypeDoc` int,
IN `InFkNationality` int,
IN `InDocument` varchar(15),

IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InEmail` varchar(50),
IN `InPhone` varchar(20),
IN `InSex` CHAR(1),
IN `InDateBirth` varchar(12),

IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updateProfileUser(InPkUser, InEmail);
	
	IF outError = 0 THEN
		UPDATE as_person SET fkTypeDocument = InFkTypeDoc,
													fkNationality = InFkNationality,
													document = InDocument,
													`name` = InName,
													surname = InSurname,
													nameComplete = CONCAT( InSurname, ', ', InName ),
													email = InEmail,
													phone = InPhone,
													sex = InSex,
													brithDate = IF(InDateBirth = '', null , InDateBirth),
													
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser,
													dateUpdate = CURRENT_TIMESTAMP()
		WHERE pkPerson = ( SELECT fkPerson FROM as_user WHERE pkUser =  InPkUser );
		
		UPDATE as_user SET 	fkUserUpdate = InFkUser,
												ipUpdate = InIpUser,
												dateUpdate = CURRENT_TIMESTAMP()
		WHERE pkUser =  InPkUser;
												
	END IF;
	
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateReadedMsg
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateReadedMsg`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateReadedMsg`(IN `InPkMsg` int,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updateReadedMsg( InPkMsg );
	
	IF outError = 0 THEN
		
		UPDATE as_message SET readed = 1,
													dateReaded = CURRENT_TIMESTAMP()
		WHERE pkMessage = InPkMsg;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateReadedNoti
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateReadedNoti`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateReadedNoti`(IN `InPkNoti` int,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = as_fn_verify_updateReadedNoti( InPkNoti, InFkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_notification SET 	readed = 1,
																dateReaded = CURRENT_TIMESTAMP(),
																ipReaded = InIpUser
		WHERE pkNotification = InPkNoti AND fkUserReceptor = InFkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateVehicle`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateVehicle`(IN `InPkVehicle` INT, 
IN `InPkDriver` INT, 
IN `InFkPerson` INT, 
IN `InFkCategory` INT, 
IN `InFkBrand` INT, 
IN `InPkModel` INT, 
IN `InIsProper` TINYINT, 
IN `InNumberPlate` VARCHAR(15), 
IN `InYear` INT, 
IN `InColor` VARCHAR(20), 
IN `InDateSoatExpiration` VARCHAR(20), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = as_fn_verify_updateVehicle(InPkVehicle, InPkDriver, InFkPerson, InNumberPlate);
	
	IF outError = 0 THEN
		UPDATE as_vehicle SET 
						fkCategory 	= InFkCategory,
						fkBrand 		= InFkBrand,
						fkModel			= InPkModel,
						isProper		= InIsProper,
						numberPlate	= InNumberPlate,
						`year`			= InYear,
						color 			= InColor,
						dateSoatExpiration	= InDateSoatExpiration,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateVerifDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateVerifDriver`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateVerifDriver`(IN `InPkDriver` int,
IN `InObservation` varchar(200),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkUser, outPkPerson, outPkLog, outVerified INT DEFAULT 0;
	
	SET outPkPerson = (SELECT fkPerson FROM as_driver WHERE pkDriver = InPkDriver);
	SET outPkUser = (SELECT pkUser FROM as_user WHERE fkPerson = outPkPerson);
	
	SET outError = as_fn_verify_updateVerifDriver( InPkDriver, outPkUser );
	
	IF outError = 0 THEN
		
		SET outVerified = ch_fn_addVerified();
		
		UPDATE as_user SET 	verified = 1,
												dateVerified = CURRENT_TIMESTAMP(),
												fkUserVerified = InFkUser
		WHERE pkUser = outPkUser;
		
		
		SET outPkLog = as_fn_add_logActivity(outPkPerson, 'Cuenta habilitada', InObservation, 'success', InFkUser, InIpUser);
		
	END IF;

	SELECT outError AS 'showError', outPkLog AS 'pkLog', outVerified AS 'accountsVerified';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for as_sp_updateVerifyVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `as_sp_updateVerifyVehicle`;
delimiter ;;
CREATE PROCEDURE `as_sp_updateVerifyVehicle`(IN `InPkVehicle` int,
IN `InFkDriver` int,

IN `InFkCategory` int,
IN `InFkBrand` int,
IN `InFkModel` int,

IN `InObservation` varchar(255),
IN `InNumberPlate` varchar(10),

IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE InPkPerson INT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	SET outError = as_fn_verify_updateVerifyVehicle( InPkVehicle, InFkDriver, InFkCategory, InFkBrand, InFkModel);
	
	IF outError = 0 THEN
		UPDATE as_vehicle SET fkCategory = InFkCategory,
													fkBrand = InFkBrand,
													fkModel = InFkModel,
													verified = 1,
													dateVerified = CURRENT_TIMESTAMP(),
													fkUserVerified = InFkUser
		WHERE pkVehicle = InPkVehicle AND fkDriver = InFkDriver;
		
		SET InPkPerson = (SELECT fkPerson FROM as_driver WHERE pkDriver = InFkDriver );
		SET outPkLog = as_fn_add_logActivity( 
		InPkPerson, 
		CONCAT("Vehículo con placa ",InNumberPlate,", habilitado con éxito"), 
		InObservation, 
		'success',
		InFkUser,
		InIpUser);
	END IF;

	SELECT outError AS 'showError', outPkLog AS 'pkLog';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_addConfigJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_addConfigJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_addConfigJournal`(`InName` varchar(30),
`InRate` float(5,2),
`InMode` char(8),
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName, vErrRate, vErrMode, vErrStatus, vErrFound TINYINT DEFAULT 0;
	
	SELECT  IF( rateJournal = InRate ,1, 0),
					IF( modeJournal = InMode ,2, 0),
					IF( statusRegister = 0 , 4, 0)
	INTO vErrRate, vErrMode, vErrStatus
	FROM cc_config_journal
	WHERE rateJournal = InRate AND modeJournal = InMode;
	
	SELECT IF( pkUser IS NULL , 8, 0) INTO vErrFound
	FROM as_user
	WHERE pkUser = InFkUser;
	
	SET outError =  vErrRate + vErrMode + vErrStatus + vErrFound;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_addJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_addJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_addJournal`(`InNameJournal` VARCHAR(50),
`InCodeJournal` VARCHAR(50),
`InHourStart` CHAR(5),
`InHourEnd` CHAR(5))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName,vErrCode, vErrStatus INT DEFAULT 0;
	DECLARE vPkJournal INT;
	
	#verificamos existencia de duplicado
	
	SELECT pkJournal,
				IF( nameJournal = InNameJournal, 1,  0),
				IF( codeJournal = InCodeJournal, 2,  0),
				IF( statusRegister = 0 , 4,  0)
				
	INTO vPkJournal, vErrName,vErrCode, vErrStatus	
	FROM cc_journal
	WHERE  codeJournal = InCodeJournal AND hourStart = InHourStart AND hourEnd = InHourEnd 
	LIMIT 0,1;
	-- nameJournal = InNameJournal or
	
	IF vPkJournal IS NOT NULL THEN
		SET outError = vErrName + vErrCode + vErrStatus;
	END IF;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_addRate
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_addRate`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_addRate`(`InPkCategory` INT,
`InPkJournal` INT)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName, vErrStatus, vErrStatusCategory, vErrStatusJournal INT DEFAULT 0;
	DECLARE vPkRate, vPkCategory, vPkJournal INT;
	
	#verificamos existencia de duplicado
	
	SELECT pkRate,
				IF( fkCategory = InPkCategory  , 1,  0),
				IF( statusRegister = 0  , 2,  0)
				
	INTO vPkRate, vErrName, vErrStatus	
	FROM cc_rate
	WHERE fkCategory = InPkCategory and fkJournal = InPkJournal LIMIT 0,1;
	
	#verificamos existencia de categoría
	SELECT pkCategory,
					IF(statusRegister = 0, 8, 0)
	INTO vPkCategory, vErrStatusCategory
	FROM as_category
	WHERE pkCategory = InPkCategory;
	
	#verificamos existencia de jornada
	SELECT pkJournal,
					IF(statusRegister = 0, 32, 0)
	INTO vPkJournal, vErrStatusJournal
	FROM cc_journal
	WHERE pkJournal = InPkCategory;
	
	IF vPkRate IS NOT NULL THEN
		SET outError = vErrName + vErrStatus;
	END IF;
	
	IF vPkCategory IS NULL THEN
		SET outError = outError + 4;
	ELSE
		SET outError = outError + vErrStatusCategory;
	END IF;

	IF vPkJournal IS NULL THEN
		SET outError = outError + 16;
	ELSE
		SET outError = outError + vErrStatusJournal;
	END IF;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_deleteConfigJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_deleteConfigJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_deleteConfigJournal`(`InPkConf` tinyint,
`InStatus` tinyint)
 RETURNS tinyint(4)
BEGIN

	DECLARE outError, vErrFound TINYINT DEFAULT 0;
	
	SELECT	IF( pkConfigJournal IS NULL , 1, 0) INTO vErrFound
	FROM cc_config_journal
	WHERE pkConfigJournal = InPkConf;
	
	# Verificar que no existan jornadas abiertas con esta jornada
	
	SET outError = vErrFound;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_deleteJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_deleteJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_deleteJournal`(`InPkJournal` INT)
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrRate INT DEFAULT 0;

	SELECT IF(fkJournal = InPkJournal,1,0)
	INTO vErrRate
	FROM cc_rate
	WHERE fkJournal = InPkJournal AND statusRegister = 1;
		
	
	SET outError = vErrRate;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_deleteRate
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_deleteRate`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_deleteRate`(`InPkRate` INT)
 RETURNS int(11)
BEGIN
	
	DECLARE outError, vErrRate INT DEFAULT 0;

		

	
	


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_updateConfigJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_updateConfigJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_updateConfigJournal`(`InPkConfig` tinyint,
`InName` varchar(30),
`InRate` float(5,2),
`InMode` char(8),
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName, vErrRate, vErrMode, vErrStatus, vErrFound TINYINT DEFAULT 0;
	
	SELECT  IF( rateJournal = InRate ,1, 0),
					IF( modeJournal = InMode ,2, 0),
					IF( statusRegister = 0 , 4, 0)
	INTO vErrRate, vErrMode, vErrStatus
	FROM cc_config_journal
	WHERE rateJournal = InRate AND modeJournal = InMode AND pkConfigJournal != InPkConfig;
	
	SELECT IF( pkUser IS NULL , 8, 0) INTO vErrFound
	FROM as_user
	WHERE pkUser = InFkUser;
	
	SET outError =  vErrRate + vErrMode + vErrStatus + vErrFound;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_updateJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_updateJournal`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_updateJournal`(`InPkJournal` INT, 
`InNameJournal` varchar(50),
`InCodeJournal` VARCHAR(50),
`InHourStart` CHAR(5),
`InHourEnd` CHAR(5))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName,vErrCode, vErrStatus INT DEFAULT 0;
	DECLARE vPkJournal, vPkJournalDouble INT ;
	
	SELECT pkJournal INTO vPkJournal
	FROM cc_journal
	WHERE pkJournal = InPkJournal;
	

		SELECT pkJournal,
				IF( nameJournal = InNameJournal  , 1,  0),
				IF( codeJournal = InCodeJournal  , 2,  0),
				IF( statusRegister = 0  , 4,  0)
		INTO vPkJournalDouble, vErrName,vErrCode, vErrStatus	
		FROM cc_journal 	
		WHERE (codeJournal = InCodeJournal AND hourStart = InHourStart AND hourEnd = InHourEnd ) AND pkJournal != InPkJournal
		LIMIT 0,1;
		
		IF vPkJournalDouble IS NOT NULL THEN
				SET outError = vErrName + vErrCode + vErrStatus;
		END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for cc_fn_verify_updateRate
-- ----------------------------
DROP FUNCTION IF EXISTS `cc_fn_verify_updateRate`;
delimiter ;;
CREATE FUNCTION `cc_fn_verify_updateRate`(`InPkRate` INT,
`InPkCategory` INT,
`InPkJournal` INT)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrName, vErrStatus, vErrStatusCategory, vErrStatusJournal INT DEFAULT 0;
	DECLARE vPkRate, vPkRateDouble ,vPkCategory, vPkJournal INT;
	
	SELECT pkRate INTO vPkRate
	FROM cc_rate
	WHERE pkRate = InPkRate;
	
	SELECT pkRate,
				IF( fkCategory = InPkCategory ,2, 0),
				IF( statusRegister = 0 ,4, 0)
		INTO vPkRateDouble, vErrName, vErrStatus	
		FROM cc_rate 	
		WHERE fkCategory = InPkCategory AND fkJournal = InPkJournal AND pkRate != InPkRate;
	
	
	#verificamos existencia de categoría
	SELECT pkCategory,
					IF(statusRegister = 0, 8, 0)
	INTO vPkCategory, vErrStatusCategory
	FROM as_category
	WHERE pkCategory = InPkCategory;
	
	#verificamos existencia de jornada
	SELECT pkJournal,
					IF(statusRegister = 0, 32, 0)
	INTO vPkJournal, vErrStatusJournal
	FROM cc_journal
	WHERE pkJournal = InPkCategory;
	
	IF vPkRate IS NULL THEN
		SET outError = 1;	
	ELSE
		SET outError = outError + vErrName + vErrStatus;
	END IF;
	
	
	IF vPkCategory IS NULL THEN
		SET outError = outError + 4;
	ELSE
		SET outError = outError + vErrStatusCategory;
	END IF;

	IF vPkJournal IS NULL THEN
		SET outError = outError + 16;
	ELSE
		SET outError = outError + vErrStatusJournal;
	END IF;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_addConfigJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_addConfigJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_addConfigJournal`(IN `InName` varchar(30),
IN `InRate` float(5,2),
IN `InMode` char(8),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError, outPk TINYINT DEFAULT 0;
	
	SET outError = cc_fn_verify_addConfigJournal( InName, InRate, InMode, InFkUser );
	
	IF outError = 0 THEN
		
		INSERT INTO cc_config_journal( 	nameJournal,
																		rateJournal,
																		modeJournal,
																		statusRegister,
																		fkUserRegister,
																		dateRegister,
																		ipRegister)
		VALUES( InName,
						InRate,
						InMode,
						1,
						InFkUser,
						CURRENT_TIMESTAMP(),
						InIpUser);
		
		SET outPk = LAST_INSERT_ID();
		
	END IF;
	
	SELECT outError AS 'showError', outPk AS 'pkConfigJournal';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_addJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_addJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_addJournal`(IN `InNameJournal` varchar(50),
IN `InCodeJournal` varchar(50),
IN `InHourStart` CHAR(5),
IN `InHourEnd` CHAR(5),
IN `InPkUser` INT,
IN `InIpUser` VARCHAR(20))
BEGIN
	#Routine body goes here...
	DECLARE outShowError, outPkJournal INT DEFAULT 0;
	
	SET outShowError = cc_fn_verify_addJournal(InNameJournal, InCodeJournal, InHourStart, InHourEnd);
	
	IF outShowError = 0 THEN
		INSERT INTO cc_journal(
				nameJournal,
				codeJournal,
				hourStart,
				hourEnd,			
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InNameJournal,
			InCodeJournal,
			InHourStart,
			InHourEnd,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkJournal = LAST_INSERT_ID();
	END IF;
	
	SELECT outShowError AS 'showError', outPkJournal AS 'pkJournal';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_addRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_addRate`;
delimiter ;;
CREATE PROCEDURE `cc_sp_addRate`(IN `InPkCategory` INT,
IN `InPkJournal` INT, 
IN `InPriceRate` FLOAT(10,2),
IN `InPriceMin` FLOAT(10,2), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	#Routine body goes here...
	DECLARE outShowError, outPkRate INT DEFAULT 0;
	
	SET outShowError = cc_fn_verify_addRate( InPkCategory, InPkJournal );
	
	IF outShowError = 0 THEN
		INSERT INTO cc_rate(
				fkCategory,
				fkJournal,
				priceRate,
				priceMin,
				statusRegister,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkCategory,
			InPkJournal,
			InPriceRate,
			InPriceMin,
			1,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkRate = LAST_INSERT_ID();
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkRate AS 'pkRate';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_deleteConfigJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_deleteConfigJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_deleteConfigJournal`(IN `InPkConf` tinyint,
IN `InStatus` tinyint,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = cc_fn_verify_deleteConfigJournal( InPkConf, InStatus );
	
	IF outError = 0 THEN
	
		IF InStatus = 0 THEN
		
			UPDATE cc_config_journal SET statusRegister = 0,
																	fkUserDelete = InPkUser,
																	dateDelete = CURRENT_TIMESTAMP(),
																	ipDelete = InIpUser
			WHERE pkConfigJournal = InPkConf;

		ELSE

			UPDATE cc_config_journal SET statusRegister = 1,
																	fkUserUpdate = InPkUser,
																	dateUpdate = CURRENT_TIMESTAMP(),
																	ipUpdate = InIpUser
			WHERE pkConfigJournal = InPkConf;

		END IF;
		
	END IF;

	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_deleteJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_deleteJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_deleteJournal`(IN `InPkJournal` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
		
	IF(InStatus = 1) THEN			
					UPDATE cc_journal SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkJournal = InPkJournal;
	ELSE 
					SET outError = cc_fn_verify_deleteJournal(InPkJournal);
					IF outError = 0 THEN
							UPDATE cc_journal SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
							WHERE pkJournal = InPkJournal;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_deleteRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_deleteRate`;
delimiter ;;
CREATE PROCEDURE `cc_sp_deleteRate`(IN `InPkRate` INT, IN `InStatus` TINYINT, IN `InPkUser` INT, IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
		
	IF(InStatus = 1) THEN			
					UPDATE cc_rate SET 
									statusRegister = 1,
									dateUpdate = CURRENT_TIMESTAMP(),
									fkUserUpdate = InPkUser,
									ipUpdate = InIpUser
					WHERE pkRate = InPkRate;
	ELSE 
					SET outError = cc_fn_verify_deleteRate(InPkRate);
					IF outError = 0 THEN
							UPDATE cc_rate SET 
								statusRegister = 0,
								dateDelete = CURRENT_TIMESTAMP(),
								fkUserDelete = InPkUser,
								ipDelete = InIpUser
							WHERE pkRate = InPkRate;
					END IF;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_getCulquiKey
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_getCulquiKey`;
delimiter ;;
CREATE PROCEDURE `cc_sp_getCulquiKey`()
BEGIN
	#Routine body goes here...
	
	SELECT pkConfig, culquiKey
	FROM cc_config;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_getListCJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_getListCJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_getListCJournal`(IN `InPage` int,
IN `InStatus` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	
	SET outWhere = CONCAT( ' WHERE C.statusRegister = ',InStatus );
	
	SET @sql = CONCAT("SELECT C.pkConfigJournal,
														C.nameJournal,
														C.rateJournal,
														C.modeJournal,
														C.statusRegister,
														C.dateRegister "
				,"FROM cc_config_journal C  "
				,outWhere,
				" ORDER BY C.dateRegister DESC",
				" LIMIT ?, 10;");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_getListJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_getListJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_getListJournal`(IN `InStatus` TINYINT)
BEGIN
	
	SELECT pkJournal,nameJournal,codeJournal,hourStart,hourEnd,statusRegister
	FROM cc_journal 
	WHERE statusRegister = InStatus;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_getListJournalAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_getListJournalAll`;
delimiter ;;
CREATE PROCEDURE `cc_sp_getListJournalAll`()
BEGIN
	#Routine body goes here...	
	SELECT pkJournal,nameJournal, hourStart, hourEnd
	FROM cc_journal 
	WHERE statusRegister = 1;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_getListRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_getListRate`;
delimiter ;;
CREATE PROCEDURE `cc_sp_getListRate`(IN `InPage` INT, 
IN `InQueryCategory` VARCHAR(80), 
IN `InQueryJournal` VARCHAR(80), 
IN `InStatus` TINYINT)
BEGIN
	
	#Routine body goes here...
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	SET @InStart = (InPage - 1) * 10;
	
	SET outWhere = CONCAT( ' WHERE R.statusRegister = ',InStatus );
	
	IF InQueryCategory != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND C.nameCategory LIKE '%",InQueryCategory, "%'");	
	END IF;
	IF InQueryJournal != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND J.nameJournal LIKE '%",InQueryJournal, "%'");	
	END IF;
	
	SET @sql = CONCAT("SELECT 
					R.pkRate,
					R.fkCategory,
					C.nameCategory,
					R.fkJournal,
					J.nameJournal,
					J.hourStart,
					J.hourEnd,
					R.priceRate,
					R.priceMin,
					R.dateRegister,
					R.statusRegister "
				,"FROM cc_rate R "
				,"INNER JOIN as_category C ON C.pkCategory = R.fkCategory "
				,"INNER JOIN cc_journal J ON J.pkJournal = R.fkJournal "
				,outWhere,
				" ORDER BY R.dateRegister DESC",
				" LIMIT ?, 10");
	
	-- SELECT @sql;
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	-- USING @paramStart, @paramEnd;
	
	 DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_overallPageCJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_overallPageCJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_overallPageCJournal`(IN `InStatus` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outWhere VARCHAR(1000) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE C.statusRegister = ',InStatus );
	
	SET @sql = CONCAT("SELECT COUNT(*) AS 'total' FROM cc_config_journal C  ",outWhere);
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_overallPageRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_overallPageRate`;
delimiter ;;
CREATE PROCEDURE `cc_sp_overallPageRate`(IN `InQueryCategory` VARCHAR(80), 
IN `InQueryJournal` VARCHAR(80), 
IN `InStatus` TINYINT)
BEGIN
	
DECLARE outWhere VARCHAR(100) DEFAULT '';
	
SET outWhere = CONCAT( ' WHERE R.statusRegister = ',InStatus );
	
	IF InQueryCategory != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND C.nameCategory LIKE '%",InQueryCategory, "%'");	
	END IF;
	IF InQueryJournal != '' THEN 
		SET outWhere = CONCAT(outWhere,"  AND J.nameJournal LIKE '%",InQueryJournal, "%'");	
	END IF;

	
	SET @sql = CONCAT("SELECT COUNT(*) AS total ",
										"FROM cc_rate R "
										,"INNER JOIN as_category C ON C.pkCategory = R.fkCategory "
										,"INNER JOIN cc_journal J ON J.pkJournal = R.fkJournal "
										,outWhere );
				
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_updateConfigJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_updateConfigJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_updateConfigJournal`(IN `InPkConfig` tinyint,
IN `InName` varchar(30),
IN `InRate` float(5,2),
IN `InMode` char(8),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError, outPk TINYINT DEFAULT 0;
	
	SET outError = cc_fn_verify_updateConfigJournal( InPkConfig, InName, InRate, InMode, InFkUser );
	
	IF outError = 0 THEN
		
		UPDATE cc_config_journal SET 	nameJournal = InName,
																	rateJournal = InRate,
																	modeJournal = InMode,
																	fkUserUpdate = InFkUser,
																	dateUpdate = CURRENT_TIMESTAMP(),
																	ipUpdate = InIpUser
		
		WHERE pkConfigJournal = InPkConfig;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_updateJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_updateJournal`;
delimiter ;;
CREATE PROCEDURE `cc_sp_updateJournal`(IN `InPkJournal` INT, 
IN `InNameJournal` varchar(50),
IN `InCodeJournal` varchar(50),
IN `InHourStar` CHAR(5), 
IN `InHourEnd` CHAR(5), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	
	DECLARE outError INT DEFAULT 0;
	
	SET outError = cc_fn_verify_updateJournal(InPkJournal,InNameJournal, InCodeJournal, InHourStar, InHourEnd);
	
	IF outError = 0 THEN
		UPDATE cc_journal SET 
						nameJournal=InNameJournal,
						codeJournal=codeJournal,
						hourStart=InHourStar,	
						hourEnd=InHourEnd,		
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkJournal = InPkJournal;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cc_sp_updateRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `cc_sp_updateRate`;
delimiter ;;
CREATE PROCEDURE `cc_sp_updateRate`(IN `InPkRate` INT, 
IN `InPkCategory` INT,
IN `InPkJournal` INT, 
IN `InPriceRate` FLOAT(10,2), 
IN `InPriceMin` FLOAT(10,2), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	#Routine body goes here...
	DECLARE outError INT DEFAULT 0;
	
	SET outError = cc_fn_verify_updateRate(InPkRate,InPkCategory,InPkJournal);
	
	IF outError = 0 THEN
		UPDATE cc_rate SET 
						fkCategory=InPkCategory,
						fkJournal=InPkJournal,	
						priceRate=InPriceRate,	
						priceMin = InPriceMin,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkRate = InPkRate;
	END IF;
	
	SELECT outError AS 'showError';
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_addNewAccount
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_addNewAccount`;
delimiter ;;
CREATE FUNCTION `ch_fn_addNewAccount`()
 RETURNS int(11)
BEGIN
	#Funcion para contar las nuevas cuentas de los usuarios
	#asociado al procedure as_sp_addUser y as_sp_addDriver
	
	DECLARE InMonth TINYINT DEFAULT 0;
	DECLARE InYear, InPkChart, InNewAccounts INT DEFAULT 0;
	
	SET InMonth = MONTH( CURRENT_DATE() );
	SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT 	IF( pkChart IS NULL, 0, pkChart), 
					IF(newUsers IS NULL,0, newUsers) 
	INTO InPkChart, InNewAccounts
	FROM as_chart
	WHERE chartMonth = InMonth AND chartYear = InYear LIMIT 0,1;
	
	IF InPkChart = 0 THEN
		
		INSERT INTO as_chart( newUsers, chartMonth, chartYear )
		VALUES(1, InMonth, InYear);
		
	ELSE
		SET InNewAccounts = ( InNewAccounts + 1 );
		UPDATE as_chart SET newUsers = InNewAccounts
		WHERE pkChart = InPkChart;
		
	END IF;


	RETURN InNewAccounts;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_addService
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_addService`;
delimiter ;;
CREATE FUNCTION `ch_fn_addService`()
 RETURNS int(11)
BEGIN
	#Funcion para contar los servicios registrados
	#asociado al procedure ts_sp_addService
	
	DECLARE InMonth TINYINT DEFAULT 0;
	DECLARE InYear, InPkChart, InServices INT DEFAULT 0;
	
	SET InMonth = MONTH( CURRENT_DATE() );
	SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT 	IF(pkChart IS NULL, 0, pkChart), 
					IF(taxiServices IS NULL,0, taxiServices) 
	INTO InPkChart, InServices
	FROM as_chart
	WHERE chartMonth = InMonth AND chartYear = InYear LIMIT 0,1;
	
	IF InPkChart = 0 THEN
		
		INSERT INTO as_chart( taxiServices, chartMonth, chartYear )
		VALUES(1, InMonth, InYear);
		
	ELSE
		SET InServices = ( InServices + 1 );
		UPDATE as_chart SET taxiServices = InServices
		WHERE pkChart = InPkChart;
		
	END IF;


	RETURN InServices;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_addTraffic
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_addTraffic`;
delimiter ;;
CREATE FUNCTION `ch_fn_addTraffic`()
 RETURNS int(11)
BEGIN
	#Funcion para contar el tráfico(inicio de sesión) de los usuarios
	#asociado al procedure as_sp_singSocket
	
	DECLARE InMonth TINYINT DEFAULT 0;
	DECLARE InYear, InPkChart, InTraffic INT DEFAULT 0;
	
	SET InMonth = MONTH( CURRENT_DATE() );
	SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT 	IF( pkChart IS NULL, 0, pkChart), 
					IF(traffic IS NULL,0, traffic) 
	INTO InPkChart, InTraffic
	FROM as_chart
	WHERE chartMonth = InMonth AND chartYear = InYear LIMIT 0,1;
	
	IF InPkChart = 0 THEN
		
		INSERT INTO as_chart( traffic, chartMonth, chartYear )
		VALUES(1, InMonth, InYear);
		
	ELSE
		SET InTraffic = ( InTraffic + 1 );
		UPDATE as_chart SET traffic = InTraffic
		WHERE pkChart = InPkChart;
		
	END IF;


	RETURN InTraffic;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_addVerified
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_addVerified`;
delimiter ;;
CREATE FUNCTION `ch_fn_addVerified`()
 RETURNS int(11)
BEGIN
	#Funcion para contar las cuentas de conductores verificadas
	#asociado al procedure as_sp_updateVerifDriver
	
	DECLARE InMonth TINYINT DEFAULT 0;
	DECLARE InYear, InPkChart, InVerified INT DEFAULT 0;
	
	SET InMonth = MONTH( CURRENT_DATE() );
	SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT 	IF( pkChart IS NULL, 0, pkChart), 
					IF( veriffiedDrivers IS NULL,0, veriffiedDrivers) 
	INTO InPkChart, InVerified
	FROM as_chart
	WHERE chartMonth = InMonth AND chartYear = InYear LIMIT 0,1;
	
	IF InPkChart = 0 THEN
		
		INSERT INTO as_chart( veriffiedDrivers, chartMonth, chartYear )
		VALUES(1, InMonth, InYear);
		
	ELSE
		SET  InVerified = ( InVerified + 1 );
		UPDATE as_chart SET veriffiedDrivers = InVerified
		WHERE pkChart = InPkChart;
		
	END IF;

	RETURN InVerified;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_countServices
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_countServices`;
delimiter ;;
CREATE FUNCTION `ch_fn_countServices`(`InStatus` tinyint,
`InMonth` tinyint,
`InYear` int)
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	DECLARE outCount INT DEFAULT 0;
	
	SELECT COUNT(*) INTO outCount
	FROM ts_service S
	WHERE S.statusService = InStatus AND MONTH( S.dateRegister ) = InMonth AND YEAR( S.dateRegister ) = InYear;

	RETURN outCount;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ch_fn_countUsers
-- ----------------------------
DROP FUNCTION IF EXISTS `ch_fn_countUsers`;
delimiter ;;
CREATE FUNCTION `ch_fn_countUsers`(`InRole` varchar(20),
`InMonth` tinyint,
`InYear` int)
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	DECLARE outCount INT DEFAULT 0;
	
	SELECT COUNT(*) INTO outCount
	FROM as_user
	WHERE role = InRole AND MONTH( dateRegister ) = InMonth AND YEAR( dateRegister ) = InYear;

	RETURN outCount;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ch_sp_getChartCards
-- ----------------------------
DROP PROCEDURE IF EXISTS `ch_sp_getChartCards`;
delimiter ;;
CREATE PROCEDURE `ch_sp_getChartCards`()
BEGIN
	#Routine body goes here...
	DECLARE InMonth, InYear, InMonthOld, InYearOld INT DEFAULT 0;
	DECLARE InTraffic, InNewUsers, InServices, InVerified INT DEFAULT 0;
	DECLARE InTrafficOld, InNewUsersOld, InServicesOld, InVerifiedOld INT DEFAULT 0;
	
	SET InMonth = MONTH( CURRENT_DATE() );
	SET InYear = YEAR( CURRENT_DATE() );
	
	SET InMonthOld = MONTH( CURRENT_DATE() ) - 1;
	SET InYearOld = YEAR( CURRENT_DATE() );
	
	IF InMonthOld = 0 THEN
	
		SET InMonthOld = 12;
		SET InYearOld = ( InMonth - 1 );
		
	END IF;
	
	SELECT  IF(traffic IS NULL, 0, traffic),
					IF(newUsers IS NULL, 0, newUsers),
					IF(taxiServices IS NULL, 0, taxiServices),
					IF(veriffiedDrivers IS NULL, 0, veriffiedDrivers)
	INTO InTraffic, InNewUsers, InServices, InVerified
	FROM as_chart
	WHERE chartMonth = InMonth AND chartYear = InYear;
	
	SELECT  IF(traffic IS NULL, 0, traffic),
					IF(newUsers IS NULL, 0, newUsers),
					IF(taxiServices IS NULL, 0, taxiServices),
					IF(veriffiedDrivers IS NULL, 0, veriffiedDrivers)
	INTO InTrafficOld, InNewUsersOld, InServicesOld, InVerifiedOld
	FROM as_chart
	WHERE chartMonth = InMonthOld AND chartYear = InYearOld;
	
	
	SELECT 	InTraffic AS 'currentTraffic' ,
					InTrafficOld AS 'oldTraffic',
					CAST( (( InTraffic * InTrafficOld ) / 1000) AS DECIMAL(10,2) ) AS 'percentTraffic',
					
					InNewUsers AS 'currentNewUsers' ,
					InNewUsersOld AS 'oldNewUsers',
					CAST( (( InNewUsers * InNewUsersOld ) / 100) AS DECIMAL(10,2) ) 'percentNewUsers',
					
					InServices AS 'currentServices' ,
					InServicesOld AS 'oldServices',
					CAST( (( InServices * InServicesOld ) / 100) AS DECIMAL(10,2) ) 'percentServices',
					
					InVerified AS 'currentVerified' ,
					InVerifiedOld AS 'oldVerified',
					CAST( (( InVerified * InVerifiedOld ) / 100) AS DECIMAL(10,2) ) 'percentVerified',
					
					CURRENT_DATE() AS 'currentDate',
					InMonthOld AS 'oldMonth',
					InYearOld AS 'oldYear',
					InMonth AS 'currentMonth', 
					InYear AS 'currentYear';


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ch_sp_getChartServices
-- ----------------------------
DROP PROCEDURE IF EXISTS `ch_sp_getChartServices`;
delimiter ;;
CREATE PROCEDURE `ch_sp_getChartServices`(IN `InMonth` TINYINT,
IN `InYear` INT)
BEGIN
	#Routine body goes here...
	-- DECLARE InMonth TINYINT DEFAULT 0;
	-- DECLARE InYear INT DEFAULT 0;
	
	-- SET InMonth = MONTH( CURRENT_DATE() );
	-- SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT ch_fn_countServices(1, InMonth, InYear) AS 'pending',
					ch_fn_countServices(2, InMonth, InYear) AS 'transit',
					ch_fn_countServices(3, InMonth, InYear) AS 'finished',
					ch_fn_countServices(0, InMonth, InYear) AS 'canceled';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ch_sp_getChartUsers
-- ----------------------------
DROP PROCEDURE IF EXISTS `ch_sp_getChartUsers`;
delimiter ;;
CREATE PROCEDURE `ch_sp_getChartUsers`(IN `InMonth` TINYINT,
IN `InYear` INT)
BEGIN
	#Routine body goes here...
	-- DECLARE InMonth TINYINT DEFAULT 0;
	-- DECLARE InYear INT DEFAULT 0;
	
	-- SET InMonth = MONTH( CURRENT_DATE() );
	-- SET InYear = YEAR( CURRENT_DATE() );
	
	SELECT 	ch_fn_countUsers('CLIENT_ROLE', InMonth, InYear) AS 'clients',
					ch_fn_countUsers('DRIVER_ROLE', InMonth, InYear) AS 'drivers';

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cu_fn_verify_updateProfile
-- ----------------------------
DROP FUNCTION IF EXISTS `cu_fn_verify_updateProfile`;
delimiter ;;
CREATE FUNCTION `cu_fn_verify_updateProfile`(`InPkUser` int,
`InPkPerson` int,
`InEmail` varchar(80))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrVerified, vErrStatus, vErrFound, vErrEmail TINYINT DEFAULT 0;
	
	SELECT	IF(pkUser IS NULL, 1, 0),
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vErrFound, vErrVerified, vErrStatus
	FROM as_user
	WHERE pkUser = InPkUser AND fkPerson = InPkPerson;
	
	SELECT	IF(pkPerson IS NULL, 0, 8) INTO vErrEmail
	FROM as_person
	WHERE pkPerson != InPkPerson AND email = InEmail LIMIT 0,1;
	
	SET outError = vErrFound + vErrVerified + vErrStatus + vErrEmail;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for cu_fn_verify_updateProfileDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `cu_fn_verify_updateProfileDriver`;
delimiter ;;
CREATE FUNCTION `cu_fn_verify_updateProfileDriver`(`InPkUser` int,
`InPkPerson` int,
`InEmail` varchar(80),
`InPkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrVerified, vErrStatus, vErrFound, vErrEmail, vErrDriver TINYINT DEFAULT 0;
	
	SELECT	IF(pkUser IS NULL, 1, 0),
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vErrFound, vErrVerified, vErrStatus
	FROM as_user
	WHERE pkUser = InPkUser AND fkPerson = InPkPerson;
	
	SELECT	IF(pkPerson IS NULL, 0, 8) INTO vErrEmail
	FROM as_person
	WHERE pkPerson != InPkPerson AND email = InEmail LIMIT 0,1;
	
	SELECT IF(pkDriver IS NULL, 16, 0) INTO vErrDriver
	FROM as_driver
	WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson;
	
	SET outError = vErrFound + vErrVerified + vErrStatus + vErrEmail + vErrDriver;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cu_sp_getProfileClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `cu_sp_getProfileClient`;
delimiter ;;
CREATE PROCEDURE `cu_sp_getProfileClient`(IN `InPkUser` int)
BEGIN
	#Routine body goes here...
	
	SELECT 	P.pkPerson,
					U.pkUser,
					P.fkNationality,
					P.fkTypeDocument,
					P.`name`,
					P.surname,
					P.nameComplete,
					P.document,
					P.phone,
					P.email,
					P.brithDate,
					IF(P.aboutMe IS NULL , '', P.aboutMe) AS aboutMe,
					IF(P.brithDate IS NOT NULL ,  YEAR( CURRENT_TIMESTAMP() ) - YEAR(P.brithDate), 0) AS yearsOld,
					P.sex,
					P.img,
					P.city,
					N.nameCountry,
					N.prefixPhone,
					TD.nameDocument,
					TD.prefix,
					U.dateVerified,
					U.dateRegister,
					U.userName
					
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
	LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
	WHERE pkUser = InPkUser;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cu_sp_getProfileDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `cu_sp_getProfileDriver`;
delimiter ;;
CREATE PROCEDURE `cu_sp_getProfileDriver`(IN `InPkUser` int)
BEGIN
	#Routine body goes here...
	
	SELECT 	P.pkPerson,
					U.pkUser,
					P.fkNationality,
					P.fkTypeDocument,
					P.`name`,
					P.surname,
					P.nameComplete,
					P.document,
					P.phone,
					P.email,
					P.brithDate,
					IF(P.aboutMe IS NULL , '', P.aboutMe) AS aboutMe,
					IF(P.brithDate IS NOT NULL ,  YEAR( CURRENT_TIMESTAMP() ) - YEAR(P.brithDate), 0) AS yearsOld,
					P.sex,
					P.img,
					P.city,
					N.nameCountry,
					N.prefixPhone,
					TD.nameDocument,
					TD.prefix,
					U.dateVerified,
					U.dateRegister,
					U.userName,
					
					D.pkDriver,
					D.dateLicenseExpiration,
					D.imgLicense,
					D.isEmployee,
					D.imgPhotoCheck,
					D.imgCriminalRecord,
					D.imgPolicialRecord
					
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	LEFT JOIN as_nationality N ON N.pkNationality = P.fkNationality
	LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
	LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson
	WHERE pkUser = InPkUser;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cu_sp_updateProfileClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `cu_sp_updateProfileClient`;
delimiter ;;
CREATE PROCEDURE `cu_sp_updateProfileClient`(IN `InPkUser` int,
IN `InPkPerson` int,
IN `InFkNationality` int,
IN `InFkTypeDoc` int,
IN `InDocument` varchar(20),
IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InPhone` varchar(20),
IN `InEmail` varchar(80),
IN `InSex` CHAR(1),
IN `InBirthDate` varchar(100),
IN `InAboutMe` varchar(100),
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = cu_fn_verify_updateProfile( InPkUser, InPkPerson, InEmail );
	
	IF outError = 0 THEN
	
		UPDATE as_person SET 	document = InDocument,
													`name` = InName,
													surname = InSurname,
													nameComplete = CONCAT(InSurname,", ",InName),
													phone = InPhone,
													email = InEmail,
													sex = InSex,
													brithDate = InBirthDate,
													aboutMe = InAboutMe,
													dateUpdate = CURRENT_TIMESTAMP(),
													ipUpdate = InIpUser
		WHERE pkPerson = InPkPerson;
	
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for cu_sp_updateProfileDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `cu_sp_updateProfileDriver`;
delimiter ;;
CREATE PROCEDURE `cu_sp_updateProfileDriver`(IN `InPkUser` int,
IN `InPkPerson` int,
IN `InPkDriver` int,
IN `InFkNationality` int,
IN `InFkTypeDoc` int,
IN `InDocument` varchar(20),
IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InPhone` varchar(20),
IN `InEmail` varchar(80),
IN `InSex` CHAR(1),
IN `InBirthDate` varchar(20),
IN `InAboutMe` varchar(100),
#data driver
IN `InDateLicense` varchar(20),
IN `InIsEmployee` tinyint,

IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = cu_fn_verify_updateProfileDriver( InPkUser, InPkPerson, InEmail, InPkDriver );
	
	IF outError = 0 THEN
	
		UPDATE as_person SET 	document = InDocument,
													`name` = InName,
													surname = InSurname,
													nameComplete = CONCAT(InSurname,", ",InName),
													phone = InPhone,
													email = InEmail,
													sex = InSex,
													brithDate = InBirthDate,
													aboutMe = InAboutMe,
													dateUpdate = CURRENT_TIMESTAMP(),
													ipUpdate = InIpUser
		WHERE pkPerson = InPkPerson;
		
		UPDATE as_driver SET dateLicenseExpiration = InDateLicense,
													isEmployee	= InIsEmployee,
													dateUpdate = CURRENT_TIMESTAMP(),
													ipUpdate = InIpUser
		WHERE pkDriver = InPkDriver AND fkPerson = InPkPerson;
	
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Function structure for rb_fn_verify_addCoupon
-- ----------------------------
DROP FUNCTION IF EXISTS `rb_fn_verify_addCoupon`;
delimiter ;;
CREATE FUNCTION `rb_fn_verify_addCoupon`(`InCode` varchar(10))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrExpired, vErrStatus TINYINT DEFAULT 0;
	
	SELECT  IF( pkCoupon IS NOT NULL , 1, 0),
					IF( statusRegister = 0, 2, 0)
	INTO vErrFound, vErrStatus
	FROM rb_coupon
	WHERE codeCoupon = InCode;
	
	SET outError = vErrFound + vErrStatus;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for rb_fn_verify_addCouponUser
-- ----------------------------
DROP FUNCTION IF EXISTS `rb_fn_verify_addCouponUser`;
delimiter ;;
CREATE FUNCTION `rb_fn_verify_addCouponUser`(`InCode` varchar(10),
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrExpired, vErrStatus, vErrRole, vErrRepit, vErrUsed TINYINT DEFAULT 0;
	DECLARE vRole VARCHAR(20) DEFAULT '';
	
	SELECT IF( role IS NULL, 'UNDEFINED' , role) INTO vRole
	FROM as_user
	WHERE pkUser = InFkUser;
	
	IF NOT EXISTS( SELECT pkCoupon FROM rb_coupon WHERE codeCoupon = InCode ) THEN
		
		SET vErrFound = 1;
	ELSE
		
		SELECT 
				 IF( dateExpiration <= CURRENT_DATE() , 2, 0),
				 IF( vRole != roleCoupon , 4, 0 ),
				 IF( statusRegister = 0 , 8, 0)
	
		INTO vErrExpired, vErrRole, vErrStatus
		FROM rb_coupon
		WHERE codeCoupon = InCode;
		
		SELECT IF( pkCouponUser IS NOT NULL , 16, 0),
						IF( isUsed = 1  ,32 , 0)
		INTO vErrRepit, vErrUsed
		FROM rb_coupon_user
		WHERE codeCoupon = InCode AND fkUser = InFkUser;
	
		
	END IF;

	
	
	SET outError = vErrFound + vErrExpired + vErrRole + vErrStatus + vErrRepit + vErrUsed;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for rb_fn_verify_deleteCoupon
-- ----------------------------
DROP FUNCTION IF EXISTS `rb_fn_verify_deleteCoupon`;
delimiter ;;
CREATE FUNCTION `rb_fn_verify_deleteCoupon`(`InPkCoupon` int,
`InCode` varchar(10))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrActivated TINYINT DEFAULT 0;
	
	SELECT IF( pkCoupon IS NULL, 1, 0) INTO vErrFound
	FROM rb_coupon
	WHERE pkCoupon = InPkCoupon AND codeCoupon = InCode;
	
	#verificar si algún usuario ha asociado el cupon
	
	SET outError = vErrFound;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for rb_fn_verify_updateCoupon
-- ----------------------------
DROP FUNCTION IF EXISTS `rb_fn_verify_updateCoupon`;
delimiter ;;
CREATE FUNCTION `rb_fn_verify_updateCoupon`(`InPkCoupon` int,
`InCode` varchar(10))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus TINYINT DEFAULT 0;
	
	SELECT IF( pkCoupon IS NULL , 4, 0),
					IF( statusRegister = 0, 2, 0)
	INTO vErrFound, vErrStatus
	FROM rb_coupon
	WHERE pkCoupon = InPkCoupon AND codeCoupon = InCode;
	
	SET outError = vErrFound + vErrStatus;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_addCoupon
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_addCoupon`;
delimiter ;;
CREATE PROCEDURE `rb_sp_addCoupon`(IN `InCode` varchar(10),
IN `InTitle` varchar(40),
IN `InDescription` varchar(100),
IN `InMinRate` float(5,2),
IN `InAmount` float(5,2),
IN `InDateExpiration` varchar(12),
IN `InDaysExpiration` tinyint,
IN `InRoleCoupon` char(11),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPk INT DEFAULT 0;
	
	SET outError = rb_fn_verify_addCoupon( InCode );
	
	IF outError = 0 THEN
		
		INSERT INTO rb_coupon ( codeCoupon,
														titleCoupon,
														descriptionCoupon,
														minRateService,
														amountCoupon,
														dateExpiration,
														daysExpiration,
														roleCoupon,
														statusRegister,
														fkUserRegister,
														dateRegister,
														ipRegister)
		VALUES( InCode,
						InTitle,
						InDescription,
						InMinRate,
						InAmount,
						InDateExpiration,
						InDaysExpiration,
						InRoleCoupon,
						1,
						InFkUser,
						CURRENT_TIMESTAMP(),
						InIpUser);
						
		SET outPk = LAST_INSERT_ID();
		
	END IF;
	
	SELECT outError AS 'showError', outPk AS 'pkCoupon';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_addCouponUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_addCouponUser`;
delimiter ;;
CREATE PROCEDURE `rb_sp_addCouponUser`(IN `InCode` varchar(10),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vDateExpiration date;
	DECLARE vBonus FLOAT(5,2) DEFAULT 0;
	DECLARE vOutPk BIGINT DEFAULT 0;
	
	SET outError = rb_fn_verify_addCouponUser( InCode, InFkUser );
	
	IF outError = 0 THEN
		
		SELECT DATE_ADD( CURRENT_DATE() , INTERVAL daysExpiration DAY),
					 amountCoupon 
		INTO vDateExpiration, vBonus
		FROM rb_coupon
		WHERE codeCoupon = InCode;
		
		INSERT INTO rb_coupon_user ( fkUser,
																	codeCoupon,
																	bonus,
																	dateExpiration,
																	statusRegister,
																	dateRegister,
																	fkUserRegister,
																	ipRegister)
		VALUES( InFkUser,
						InCode,
						vBonus,
						vDateExpiration,
						1,
						CURRENT_TIMESTAMP(),
						InFkUser,
						InIpUser);
		
		SET vOutPk = LAST_INSERT_ID();
		
	END IF;
	
	
		
	IF vOutPk != 0 AND outError = 0 THEN
		
		SELECT titleCoupon,
						descriptionCoupon,
						minRateService,
						CURRENT_TIMESTAMP() AS 'dateRegister',
						vBonus AS 'bonus',
						vDateExpiration AS 'dateExpiration',
						outError AS 'showError',
						vOutPk AS 'pkCouponUser',
						InCode AS 'codeCoupon'
		FROM rb_coupon
		WHERE codeCoupon = InCode;
	
	ELSE 
		
		SELECT outError AS 'showError', vOutPk AS 'pkCouponUser';
		
	END IF;

	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_deleteCoupon
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_deleteCoupon`;
delimiter ;;
CREATE PROCEDURE `rb_sp_deleteCoupon`(IN `InPkCoupon` int,
IN `InCode` varchar(10),
IN `InStatus` tinyint,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = rb_fn_verify_deleteCoupon( InPkCoupon, InCode );
	
	IF outError = 0 THEN
		
		IF InStatus = 0 THEN
			
			UPDATE rb_coupon SET statusRegister = 0,
														dateDelete = CURRENT_TIMESTAMP(),
														fkUserDelete = InFkUser,
														ipDelete = InIpUser
			WHERE pkCoupon = InPkCoupon AND codeCoupon = InCode;
			
		ELSE
		
			UPDATE rb_coupon SET statusRegister = 1,
														dateUpdate = CURRENT_TIMESTAMP(),
														fkUserUpdate = InFkUser,
														ipUpdate = InIpUser
			WHERE pkCoupon = InPkCoupon AND codeCoupon = InCode;
			 
		END IF;
		
	END IF;

	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_getConfig
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_getConfig`;
delimiter ;;
CREATE PROCEDURE `rb_sp_getConfig`()
BEGIN
	#Routine body goes here...
	SELECT 	amountClient,
					amountDriver,
					daysExpClient,
					daysExpDriver
	FROM rb_config_referal 
	LIMIT 0, 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_getCouponUser
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_getCouponUser`;
delimiter ;;
CREATE PROCEDURE `rb_sp_getCouponUser`(IN `InPkUser` int,
IN `InStatus` varchar(7))
BEGIN
	#Routine body goes here... OK, USED, EXPIRED
	
	DECLARE outWhere, outFields VARCHAR(400) DEFAULT '';
	
	SET outWhere = CONCAT( " WHERE CU.statusRegister = 1 AND CU.fkUser = ", InPkUser );
	
	CASE InStatus
		WHEN 'OK' THEN
			SET outWhere = CONCAT( outWhere, " AND CU.isUsed = 0 AND IF( CU.dateExpiration <= CURRENT_DATE() , 1, 0) = 0 " );
		
		WHEN 'USED' THEN
			SET outWhere = CONCAT( outWhere, " AND CU.isUsed = 1 " );
		
		WHEN 'EXPIRED' THEN
			SET outWhere = CONCAT( outWhere, " AND IF( CU.dateExpiration <= CURRENT_DATE() , 1, 0) = 1 " );
	END CASE;
	
	SET outFields =  "  CU.pkCouponUser,
	
											C.titleCoupon,
											C.descriptionCoupon,
											C.minRateService,
											CU.codeCoupon,
											CU.bonus,
											CU.dateExpiration,
											CU.dateRegister,
											CU.dateUsed ";
	
	SET @sql = CONCAT( "SELECT" 
										, outFields
										," FROM rb_coupon_user CU"
										," INNER JOIN rb_coupon C ON C.codeCoupon = CU.codeCoupon "
										, outWhere
										, " ORDER BY CU.dateRegister DESC"
										, " LIMIT 0, 5;");
	
	-- SELECT @sql;
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt ;
	
	DEALLOCATE PREPARE stmt;	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_getListCoupon
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_getListCoupon`;
delimiter ;;
CREATE PROCEDURE `rb_sp_getListCoupon`(IN `InPage` int,
IN `InRowsForPage` tinyint,
IN `InCode` varchar(50),
IN `InTitle` varchar(50),
IN `InRole` varchar(50),
IN `InLte` float(4,2),
IN `InGte` float(4,2),
IN `InEq` float(4,2),
IN `InStatusRegister` tinyint)
BEGIN
	#Routine body goes here...
	
	DECLARE outWhere, outFields VARCHAR(800) DEFAULT '';
	
	SET @InStart = ( InPage - 1 ) * InRowsForPage;
	
	
	SET outWhere = CONCAT( " WHERE C.statusRegister = ", InStatusRegister );
	
	IF InCode != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.codeCoupon LIKE '%", InCode, "%'" );
	END IF;
	
	IF InTitle != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.titleCoupon LIKE '%", InTitle, "%'" );
	END IF;
	
	IF InRole != 'ALL' THEN
		SET outWhere = CONCAT( outWhere, " AND C.roleCoupon = '", InRole, "'" );
	END IF;
	
	IF InLte != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon <= ", InLte );
	END IF;
	
	IF InGte != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon >= ", InGte );
	END IF;
	
	IF InEq != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon = ", InEq );
	END IF;
	
	SET outFields =  "  C.pkCoupon,
											C.titleCoupon,
											C.descriptionCoupon,
											C.codeCoupon,
											C.minRateService,
											C.amountCoupon,
											C.dateExpiration,
											C.daysExpiration,
											C.roleCoupon,
											C.statusRegister,
											C.dateRegister,
											IF( TIMESTAMPDIFF( DAY , CURRENT_TIMESTAMP(), C.dateExpiration ) <= 0 , 1, 0)  AS 'isExpired',
											IF( TIMESTAMPDIFF( DAY , CURRENT_TIMESTAMP(), C.dateExpiration ) BETWEEN 1 AND 3 , 1, 0) AS 'forExpired'
											";
	
	SET @sql = CONCAT( "SELECT" 
										, outFields
										," FROM rb_coupon C"
										, outWhere
										, " ORDER BY C.dateRegister DESC"
										, " LIMIT ?,", InRowsForPage);
	
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;	
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_overallPageCoupon
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_overallPageCoupon`;
delimiter ;;
CREATE PROCEDURE `rb_sp_overallPageCoupon`(IN `InCode` varchar(50),
IN `InTitle` varchar(50),
IN `InRole` varchar(50),
IN `InLte` float(4,2),
IN `InGte` float(4,2),
IN `InEq` float(4,2),
IN `InStatusRegister` tinyint)
BEGIN
	#Routine body goes here...
	
	DECLARE outWhere VARCHAR(400) DEFAULT '';
	
	SET outWhere = CONCAT( " WHERE C.statusRegister = ", InStatusRegister );
	
	IF InCode != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.codeCoupon LIKE '%", InCode, "%'" );
	END IF;
	
	IF InTitle != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.titleCoupon LIKE '%", InTitle, "%'" );
	END IF;
	
	IF InRole != 'ALL' THEN
		SET outWhere = CONCAT( outWhere, " AND C.roleCoupon = '", InRole, "'" );
	END IF;
	
	IF InLte != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon <= ", InLte );
	END IF;
	
	IF InGte != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon >= ", InGte );
	END IF;
	
	IF InEq != '' THEN
		SET outWhere = CONCAT( outWhere, " AND C.amountCoupon = ", InEq );
	END IF;
	
	SET @sql = CONCAT( "SELECT COUNT(*) AS total " 
										," FROM rb_coupon C"
										, outWhere);
	
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt ;
	
	DEALLOCATE PREPARE stmt;	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_updateConfig
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_updateConfig`;
delimiter ;;
CREATE PROCEDURE `rb_sp_updateConfig`(IN `InBnClient` float(4,2),
IN `InBnDriver` float(4,2),
IN `InDaysExpClient` tinyint,
IN `InDaysExpDriver` tinyint,
IN `InFkDriver` int,
IN `InIpDriver` varchar(20))
BEGIN
	#Routine body goes here...
	
	UPDATE rb_config_referal SET amountClient = InBnClient,
															 amountDriver = InBnDriver,
															 daysExpClient = InDaysExpClient,
															 daysExpDriver = InDaysExpDriver,
															 dateUpdate = CURRENT_TIMESTAMP(),
															 fkUserUpdate = InFkDriver,
															 ipUserUpdate = InIpDriver;
															 
 SELECT 0 AS showError;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for rb_sp_updateCoupon
-- ----------------------------
DROP PROCEDURE IF EXISTS `rb_sp_updateCoupon`;
delimiter ;;
CREATE PROCEDURE `rb_sp_updateCoupon`(IN `InPkCoupon` int,
IN `InCode` varchar(10),
IN `InTitle` varchar(40),
IN `InDescription` varchar(100),
IN `InAmount` float(5,2),
IN `InDateExpiration` varchar(12),
IN `InDaysExpiration` tinyint,
IN `InMinRate` float(5,2),
IN `InRole` CHAR(11),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = rb_fn_verify_updateCoupon( InPkCoupon, InCode );
	
	IF outError = 0 THEN
		
		UPDATE rb_coupon SET titleCoupon = InTitle,
												descriptionCoupon = InDescription,
												amountCoupon = InAmount,
												dateExpiration = InDateExpiration,
												daysExpiration = InDaysExpiration,
												minRateService = InMinRate,
												roleCoupon = InRole,
												dateUpdate = CURRENT_TIMESTAMP(),
												fkUserUpdate = InFkUser,
												ipUpdate = InIpUser
		WHERE pkCoupon = InPkCoupon AND codeCoupon = InCode;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_countDeclineOfer
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_countDeclineOfer`;
delimiter ;;
CREATE FUNCTION `ts_fn_countDeclineOfer`(`InPkService` int,
`InPkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outTotal TINYINT DEFAULT 0;
	
	SELECT COUNT(*) INTO outTotal 
	FROM ts_offer_service 
	WHERE fkService = InPkService AND declined = 1 AND fkDriver = InPkDriver;

	RETURN outTotal;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_countDriverZone
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_countDriverZone`;
delimiter ;;
CREATE FUNCTION `ts_fn_countDriverZone`(`InIndexHex` varchar(20))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outTotal TINYINT DEFAULT 0;
	
	SELECT COUNT(*) INTO outTotal
	FROM as_user
	WHERE statusSocket = 1 
	AND verified = 1 
	AND statusRegister = 1
	AND lat IS NOT NULL
	AND role = 'DRIVER_ROLE'
	AND indexHex = InIndexHex;

	RETURN outTotal;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_generate_codeJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_generate_codeJournal`;
delimiter ;;
CREATE FUNCTION `ts_fn_generate_codeJournal`(`InFkDriver` int)
 RETURNS char(5) CHARSET utf8mb4
BEGIN
	#Routine body goes here...
	DECLARE vCorre INT DEFAULT 0;
	DECLARE vCode varchar(10) DEFAULT '';
	
	SELECT COUNT(*) + 1 INTO vCorre
	FROM ts_journal_driver
	WHERE fkDriver = InFkDriver;

	SET vCode = CONCAT('00000', vCorre);

	SET vCode = SUBSTR( vCode,  -5 );

	RETURN vCode;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getDocumentUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getDocumentUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getDocumentUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200);
	SELECT If( P.document IS NULL, '', P.document ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getEmailUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getEmailUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getEmailUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200);
	SELECT If( P.email IS NULL, '', P.email ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getImgUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getImgUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getImgUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200);
	SELECT If( P.img IS NULL, '', P.img ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getNameCompleteUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getNameCompleteUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getNameCompleteUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200) DEFAULT 'undefined';
	SELECT If( P.nameComplete IS NULL, 'undefined', P.nameComplete ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getOsUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getOsUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getOsUser`(`InPkUser` int)
 RETURNS varchar(100) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(100) DEFAULT '';
	SELECT If( U.osId IS NULL, '', U.osId ) INTO outValue
	FROM as_user U
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getPhoneUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getPhoneUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getPhoneUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200);
	SELECT If( P.phone IS NULL, '', P.phone ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_getTypeDocUser
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_getTypeDocUser`;
delimiter ;;
CREATE FUNCTION `ts_fn_getTypeDocUser`(`InPkUser` int)
 RETURNS varchar(200) CHARSET utf8
BEGIN
	#Routine body goes here...
	DECLARE outValue VARCHAR(200);
	SELECT If( TD.prefix IS NULL, '', TD.prefix ) 
	INTO outValue
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	INNER JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
	WHERE pkUser = InPkUser;

	RETURN outValue;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_get_currentLat
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_get_currentLat`;
delimiter ;;
CREATE FUNCTION `ts_fn_get_currentLat`(`InPkUser` int)
 RETURNS float
BEGIN
	#Routine body goes here...
	DECLARE outLatitude FLOAT(30,20) DEFAULT 0;
	
	SELECT IF(lat IS NULL, 0, lat)
	INTO outLatitude
	FROM as_user
	WHERE pkUser = InPkUser;
	

	RETURN outLatitude;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_get_currentLng
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_get_currentLng`;
delimiter ;;
CREATE FUNCTION `ts_fn_get_currentLng`(`InPkUser` int)
 RETURNS float
BEGIN
	#Routine body goes here...
	DECLARE outLongitude FLOAT(30,20) DEFAULT 0;
	
	SELECT IF(lng IS NULL, 0, lng)
	INTO outLongitude
	FROM as_user
	WHERE pkUser = InPkUser;
	
	RETURN outLongitude;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_used_creditClient
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_used_creditClient`;
delimiter ;;
CREATE FUNCTION `ts_fn_used_creditClient`(`InRate` float(5,2), # S/ 15.00
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	
	DECLARE done TINYINT DEFAULT FALSE;

  DECLARE vPkReferal BIGINT DEFAULT 0;
	DECLARE vBonus, vBonusUsed FLOAT(5,2) DEFAULT '';
	DECLARE vDateExp DATE;
	DECLARE vCount TINYINT DEFAULT 0;
	
	DECLARE vBonusBalance, vRateBalance FLOAT(5,2) DEFAULT 0;
	
	-- SET vRateBalance = InRate;
	
  DECLARE CREDITCURSOR CURSOR FOR 
	SELECT RF.pkReferalUser, RF.bonus, RF.bonusUsed, RF.dateExpiration
	FROM rb_referal_user RF
	WHERE IF( RF.dateExpiration <= CURRENT_DATE() ,1 ,0) = 0 AND RF.isUsed = 0 AND RF.fkUser = InFkUser
	ORDER BY RF.dateRegister ASC;
	
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN CREDITCURSOR;

  read_loop: LOOP 
	FETCH CREDITCURSOR INTO vPkReferal, vBonus, vBonusUsed, vDateExp;
		
    IF done THEN
      LEAVE read_loop;
    END IF;
		
		IF vRateBalance > 0 THEN
			
			SET vBonusBalance = vBonus - vBonusUsed;
			
			IF vRateBalance >= vBonusBalance THEN
			
				SET vRateBalance = vRateBalance - vBonusBalance;
				
				UPDATE rb_referal_user SET isUsed = 1,
																	 bonusUsed = vBonus,
																	 dateUsed = CURRENT_TIMESTAMP()
				WHERE pkReferalUser = vPkReferal;
				
			ELSEIF vRateBalance < vBonusBalance  THEN
			
				SET vBonusUsed = vBonusUsed + vRateBalance;
				SET vRateBalance = 0;
				
				UPDATE rb_referal_user SET isUsed = 0,
																	 bonusUsed = vBonusUsed,
																	 dateUsed = CURRENT_TIMESTAMP()
				WHERE pkReferalUser = vPkReferal;
				
			END IF;
			
			SET vCount = vCount + 1;
			
		END IF;
    
  END LOOP;

  CLOSE CREDITCURSOR;
	
	RETURN vCount;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verifyUpdateTravelService
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verifyUpdateTravelService`;
delimiter ;;
CREATE FUNCTION `ts_fn_verifyUpdateTravelService`(`InPkService` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SELECT IF(pkService IS NULL, 1, 0) INTO outError
	FROM ts_service
	WHERE pkService = InPkService;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_acceptedOfferDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_acceptedOfferDriver`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_acceptedOfferDriver`(`InPkService` int,
`InPkDriver` int, -- pkuser del conductor
`InPkOffer` int)
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrService, vErrStatus, vErrVerified, vErrStatusDriver TINYINT DEFAULT 0;
	DECLARE vPkService, vPkDriver, vPkOffer INT;
	
	SELECT pkService,
					IF(statusService != 1, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vPkService, vErrService, vErrStatus
	FROM ts_service
	WHERE pkService = InPkService;
	
	
	SELECT  D.pkDriver,
					IF(U.verified = 0, 16, 0),
					IF(U.statusRegister = 0, 32, 0)
	INTO vPkDriver, vErrVerified, vErrStatusDriver 
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson
	WHERE U.pkUser = InPkDriver;
	
	IF InPkOffer != 0 THEN
		SELECT pkOfferService INTO vPkOffer
		FROM ts_offer_service
		WHERE pkOfferService = InPkOffer AND fkService = InPkService;
	END IF;
	
	IF vPkService IS NULL THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrService + vErrStatus;
	END IF;

	IF vPkDriver IS NULL THEN
		SET outError = outError + 8;
	ELSE
		SET outError = outError + vErrVerified + vErrStatusDriver;
	END IF;
	
	IF InPkOffer != 0 THEN
		IF vPkOffer IS NULL THEN
			SET outError = outError + 64;
		END IF;
	END IF;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_acceptOfferClient
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_acceptOfferClient`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_acceptOfferClient`(`InPkService` bigint,
`InPkOffer` bigint,
`InPkDriver` int)
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	DECLARE outError INT DEFAULT 0;
	DECLARE vErrDriver, vErrVerified, vErrStatusDriver TINYINT DEFAULT 0;
	DECLARE vErrDriverService, vErrStatusService TINYINT DEFAULT 0;
	DECLARE vErrDecline, vErrOffer TINYINT DEFAULT 0;
	
	#verificamos a conductor
	SELECT IF(pkUser IS NULL, 1,0),
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4 ,0)
	INTO vErrDriver, vErrVerified, vErrStatusDriver
	FROM as_user
	WHERE pkUser = InPkDriver;
	
	#verificar que el conductor no tenga un servicio en curso
	SELECT IF(pkService IS NULL, 0, 8) 
					-- IF(statusService != 1, 16, 0)
	INTO vErrDriverService
	FROM ts_service
	WHERE fkDriver = InPkDriver AND statusService = 2 AND statusRegister = 1 AND pkService != InPkService
	LIMIT 0,1;
	
	#verificar oferta de servicio
	SELECT IF(pkOfferService IS NULL, 16, 0),
					IF(declined = 1, 32, 0)
	INTO vErrOffer, vErrDecline
	FROM ts_offer_service
	WHERE pkOfferService = InPkOffer AND fkService = InPkService LIMIT 0, 1;
	
	SET outError = vErrDriver + vErrVerified + vErrStatusDriver + vErrDriverService + vErrOffer + vErrDecline ;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addAlert
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addAlert`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addAlert`(`InFkService` int,
`InFkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrRepit TINYINT DEFAULT 0;
	
	SELECT IF(pkAlertService IS NULL,0, 1) INTO vErrRepit
	FROM ts_alert_service
	WHERE fkService = InFkService AND fkPerson = InFkPerson
	LIMIT 0,1;
	
	SELECT IF(pkService IS NULL, 2 , 0) INTO vErrFound
	FROM ts_service 
	WHERE pkService = InFkService;

	SET outError = vErrFound + vErrRepit;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addAlertNotify
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addAlertNotify`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addAlertNotify`(`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus, vErrVerified TINYINT DEFAULT 0;
	
	SELECT IF(pkUser IS NULL, 1, 0),
					IF(statusRegister = 0 , 2, 0),
					IF(verified = 0, 4, 0)
	INTO vErrFound, vErrStatus, vErrVerified
	FROM as_user
	WHERE pkUser = InFkUser;
	
	SET outError = vErrFound + vErrStatus + vErrVerified;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addCalification
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addCalification`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addCalification`(`InPkService` bigint,
`InIsClient` tinyint,
`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrService TINYINT DEFAULT 0;
	
	SELECT IF(pkService IS NULL, 1,0 ) INTO vErrService
	FROM ts_service 
	WHERE pkService = InPkService;
	
	SELECT IF(pkCalification IS NOT NULL, 2, 0) INTO vErrFound
	FROM ts_calification_service
	WHERE fkService = InPkService  AND fkUserRegister = InPkUser;
	-- AND isClient = InIsClient
	
	SET outError = vErrService + vErrFound;	

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addCard
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addCard`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addCard`(`InFkPerson` int,
`InCardNumber` varchar(16),
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	
	DECLARE outError, vErrCard, vErrStatus TINYINT DEFAULT 0;
	DECLARE vPkCard, vPkUser INT;
	
	#verificamos duplicidad de tarjeta
	
	SELECT pkCard,
					IF(cardNumber = InCardNumber, 1, 0)
	INTO vPkCard, vErrCard
	FROM ts_card
	WHERE cardNumber = InCardNumber AND fkPerson != InFkPerson LIMIT 0,1;
	
	SELECT pkUser,
					IF(statusRegister = 0, 4, 0)
	INTO vPkUser, vErrStatus
	FROM as_user
	WHERE pkUser = InFkUser and fkPerson = InFkPerson;
	
	IF vPkCard IS NOT NULL THEN
		SET outError = outError + vErrCard;
	END IF;
	
	IF vPkUser IS NULL THEN
		SET outError = outError + 2;
	ELSE
		SET outError = outError + vErrStatus;
	END IF;


	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addContact
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addContact`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addContact`(`InEmail` varchar(100),
`InPhone` varchar(20),
`InFkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrEmail, vErrPhone, vErrStatus, vErrLimit TINYINT DEFAULT 0;
	
	SELECT IF(email = InEmail, 1, 0),
				 IF(phone = InPhone, 2, 0),
				 IF(statusRegister = 0, 4, 0)
	INTO vErrEmail, vErrPhone, vErrStatus
	FROM ts_contac
	WHERE (email = InEmail OR phone = InPhone) AND fkPerson = InFkPerson
	LIMIT 0,1;
	
	SELECT IF( COUNT(*) > 2 , 16, 0) INTO vErrLimit
	FROM ts_contac
	WHERE fkPerson = InFkPerson AND statusRegister = 1; 
	
	SET outError = vErrEmail + vErrPhone + vErrStatus + vErrLimit;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addJournalDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addJournalDriver`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addJournalDriver`(`InFkDriver` int,
`InFkConfJournal` tinyint,
`InFkUser` int,
`InCode` char(5))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrOpen, vErrCode ,vErrFound, vErrFoundConf TINYINT DEFAULT 0;

	SELECT IF(pkJournalDriver IS NOT NULL,1, 0) INTO vErrOpen
	FROM ts_journal_driver
	WHERE journalStatus = 1 LIMIT 0,1;
	
	SELECT IF(pkJournalDriver IS NOT NULL , 2, 0) INTO vErrCode
	FROM ts_journal_driver
	WHERE fkDriver = InFkDriver AND codeJournal = InCode;
	
	SELECT IF(pkDriver IS NULL ,4 , 0) INTO vErrFound
	FROM as_driver
	WHERE pkDriver = InFkDriver;
	
	SELECT IF(pkConfigJournal IS NULL, 8, 0) INTO vErrFoundConf
	FROM cc_config_journal
	WHERE pkConfigJournal = InFkConfJournal;
	
	SET outError = vErrOpen + vErrCode + vErrFound + vErrFoundConf;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addOfferService
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addOfferService`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addOfferService`(`InPkService` bigint,
`InPkOffer` bigint,
`InPkDriver` int, -- pkuser del conductor
`InFkVehicle` int,
`InFkJournal` bigint,
`InCodeJournal` varchar(5),
`InIsClient` tinyint)
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	DECLARE outError, vInPkDriver, vPkDriver INT DEFAULT 0;
	DECLARE vFoundService,
					vErrService,
					vErrStatus,
					vErrVerified,
					vErrStatusDriver,
					vFoundDriver,
					vFoundOffer,
					vFoundVehicle,
					vVerifiedVeh,
					vErrFoundJournal,
					vErrStatusJournal,
					vErrExpired INT DEFAULT 0;
					
	SELECT IF(D.pkDriver IS NULL ,0 , D.pkDriver) INTO vPkDriver
	FROM as_user U
	INNER JOIN as_person P ON U.fkPerson = P.pkPerson
	LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson
	WHERE U.pkUser = InPkDriver;
	
	SELECT IF(pkService IS NULL, 1, 0), -- service not found
					IF(statusService != 1, 2, 0), -- service not waiting
					IF(statusRegister = 0, 4, 0) -- service disposal
	INTO vFoundService, vErrService, vErrStatus
	FROM ts_service
	WHERE pkService = InPkService;
	
	SELECT  IF(D.pkDriver IS NULL, 8, 0), -- driver not found
					IF(U.verified = 0, 16, 0), -- driver pending verified
					IF(U.statusRegister = 0, 32, 0), -- driver enabled
					pkDriver
	INTO vFoundDriver, vErrVerified, vErrStatusDriver, vInPkDriver
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	LEFT JOIN as_driver D ON D.fkPerson = P.pkPerson
	WHERE U.pkUser = InPkDriver;
	
	
	
	IF (InPkOffer = 0 AND InIsClient = 0) THEN
		-- SELECT IF(pkOfferService IS NULL, 256, 0) INTO vFoundOffer
		-- FROM ts_offer_service
		-- WHERE pkOfferService = InPkOffer AND fkService = InPkService;
		
	-- ELSEIF( InIsClient = 0 )
	
		#verificamos el registro del vehículo
		SELECT IF( pkVehicle IS NULL, 64, 0),
						IF( verified = 0 , 128, 0)
		INTO vFoundVehicle, vVerifiedVeh
		FROM as_vehicle
		WHERE pkVehicle = InFkVehicle AND fkDriver = vPkDriver;
		
		# verificamos la jornada laboral del conductor
		SELECT  IF(pkJournalDriver IS NULL , 256, 0),
						IF( journalStatus = 0 , 512, 0),
						IF( TIMESTAMPDIFF( HOUR , dateStart ,CURRENT_TIMESTAMP()) > 23 , 1024, 0)
		INTO vErrFoundJournal, vErrStatusJournal, vErrExpired
		FROM ts_journal_driver
		WHERE pkJournalDriver = InFkJournal AND codeJournal = InCodeJournal;
		
	END IF;

	SET outError = vFoundService + vErrService + vErrStatus + vErrVerified + vErrStatusDriver + vFoundDriver + vFoundVehicle + vVerifiedVeh + vErrFoundJournal + vErrStatusJournal + vErrExpired;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_addService
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_addService`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_addService`(`InFkClient` int,
`InFkJournal` int,
`InFkRate` int,
`InRate` float(10,2),
`InFkUser` int,
`InFkCouponUser` bigint,
`InDiscountType` char(6))
 RETURNS int(11)
BEGIN
	#Routine body goes here...
	
	DECLARE outError, vErrFound, vErrStatus, vErrFoundRate, vErrStatusRate, vErrRateService INT DEFAULT 0 ;
	DECLARE vErrFoundCoupon, vErrExpired, vErrUsed, vErrInsuficient INT DEFAULT 0;
	
	#verificar cliente, si esta activo y se encuentra habilitado
	
	SELECT IF(pkUser IS NULL,1 ,0),
					IF(statusRegister = 0, 2, 0)
	INTO vErrFound, vErrStatus
	FROM as_user
	WHERE pkUser = InFkClient;
	
	#verificar la jornada
	
	#verificar la tarifa
	SELECT IF(pkRate IS NULL, 4, 0),
					IF(statusRegister = 0, 8, 0)
	INTO vErrFoundRate, vErrStatusRate
	FROM cc_rate
	WHERE pkRate = InFkRate;
	
	#verificar que el  monto de tarifa sea mayor a cero
	
	IF InRate <= 0 THEN	
		SET vErrRateService = 16;
	END IF;
	
	#verificar el descuento
	
	IF InDiscountType = 'COUPON' THEN
		
		SELECT  IF(pkCouponUser IS NULL, 32, 0),
							IF( dateExpiration <= CURRENT_DATE() , 64, 0),
							IF( isUsed = 1 , 128, 0)
		INTO vErrFoundCoupon, vErrExpired, vErrUsed
		FROM rb_coupon_user
		WHERE pkCouponUser = InFkCouponUser AND fkUser = InFkUser;
		
	ELSEIF InDiscountType = 'CREDIT' THEN
	
		SELECT IF( SUM( bonus ) - SUM( bonusUsed ) < InRate , 256, 0) INTO vErrInsuficient
		FROM rb_referal_user
		WHERE IF(dateExpiration <= CURRENT_DATE() ,1 ,0)  = 0 AND isUsed = 0 AND fkUser = InFkUser;
		
	END IF;



	
	SET outError = outError + vErrFound + vErrStatus + vErrFoundRate + vErrStatusRate + vErrRateService + vErrFoundCoupon + vErrExpired + vErrUsed + vErrInsuficient;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_closeJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_closeJournal`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_closeJournal`(`InPkJournal` bigint,
`InFkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrClose TINYINT DEFAULT 0;
	
	SELECT	IF(pkJournalDriver IS NULL, 1, 0),
					IF(journalStatus = 0, 2, 0)
	INTO vErrFound, vErrClose
	FROM ts_journal_driver
	WHERE pkJournalDriver = InPkJournal AND fkDriver = InFkDriver;
	
	SET outError = vErrFound + vErrClose;
	
	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_declineOfferDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_declineOfferDriver`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_declineOfferDriver`(`InPkOffer` bigint,
`InPkService` bigint,
`InPkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus TINYINT DEFAULT 0 ;
	
	SELECT IF(pkOfferService IS NULL , 1, 0),
					IF(declined = 1, 2, 0)
	INTO vErrFound, vErrStatus
	FROM ts_offer_service
	WHERE pkOfferService = InPkOffer AND fkService = InPkService AND fkDriver = InPkDriver;
	
	SET outError = vErrFound + vErrStatus;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_deleteContact
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_deleteContact`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_deleteContact`(`InPkContact` bigint,
`InFkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrLimit TINYINT DEFAULT 0;
	
	SELECT IF(pkContact IS NULL, 8, 0) INTO vErrFound
	FROM ts_contac
	WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
	
	
	
	SET outError = vErrFound + vErrLimit;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_deleteService
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_deleteService`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_deleteService`(`InPkService` int,
`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrService, vErrClient, vErrStatus TINYINT DEFAULT 0;
	
	SELECT IF(pkService IS NULL , 1, 0),
					IF(fkClient != InPkUser , 2, 0)
					-- IF(statusService = 0 OR statusService = 3 , 4, 0)
	INTO vErrService, vErrClient -- , vErrStatus
	FROM ts_service
	WHERE pkService = InPkService;
	
	SET outError = vErrService + vErrClient + vErrStatus;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_deleteServiceRun
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_deleteServiceRun`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_deleteServiceRun`(`InPkService` int,
`InIsClient` tinyint,
`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus TINYINT DEFAULT 0;
	
	IF InIsClient = 1 THEN
		
		SELECT IF(pkService IS NULL, 1, 0),
						IF(statusService = 0, 2, 0)
		INTO vErrFound, vErrStatus
		FROM ts_service
		WHERE pkService = InPkService AND fkClient = InPkUser;
		
	ELSE
		
		SELECT IF(pkService IS NULL, 1, 0),
						IF(statusService = 0, 2, 0)
		INTO vErrFound, vErrStatus
		FROM ts_service
		WHERE pkService = InPkService AND fkDriver = InPkUser;
		
	END IF;
	
	
	SET outError = vErrFound + vErrStatus;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_deleteVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_deleteVehicle`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_deleteVehicle`(`InPkVehicle` int,
`InPkDriver` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound TINYINT DEFAULT 0;
	
	SELECT IF(pkVehicle IS NULL, 1, 0) INTO vErrFound
	FROM as_vehicle
	WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
	
	SET outError = outError + vErrFound;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateCategoryDriver
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateCategoryDriver`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateCategoryDriver`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrStatus, vErrVerify, vErrRole TINYINT DEFAULT 0;
	DECLARE vPkUser INT;
	
	SELECT pkUser,
					IF(role != 'DRIVER_ROLE', 2, 0),
					IF(verified = 0, 4, 0),
					IF(statusRegister = 0, 8, 0)
	INTO vPkUser, vErrRole, vErrVerify, vErrStatus
	FROM as_user
	WHERE pkUser = InPkUser;
	
	IF vPkUser IS NULL THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrRole + vErrVerify + vErrStatus;
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateContact
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateContact`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateContact`(`InPkContact` bigint,
`InEmail` varchar(100),
`InPhone` varchar(20),
`InFkPerson` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrEmail, vErrPhone, vErrStatus, vErrLimit TINYINT DEFAULT 0;
	
	SELECT IF(email = InEmail, 1, 0),
				 IF(phone = InPhone, 2, 0),
				 IF(statusRegister = 0, 4, 0)
	INTO vErrEmail, vErrPhone, vErrStatus
	FROM ts_contac
	WHERE (email = InEmail OR phone = InPhone) AND fkPerson = InFkPerson AND pkContact != InPkContact
	LIMIT 0,1;
	
	SELECT IF(pkContact IS  NULL, 8, 0) INTO vErrFound
	FROM ts_contac
	WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
	
	SELECT IF( COUNT(*) > 2 , 16, 0) INTO vErrLimit
	FROM ts_contac
	WHERE fkPerson = InFkPerson AND statusRegister = 1; 
	
	SET outError = vErrEmail + vErrPhone + vErrStatus + vErrFound;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateJournal
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateJournal`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateJournal`(`InPkService` bigint,
	`InFkOffer` bigint,
	`InFkDriver` int,
	`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrStatus, vErrFoundOffer, vErrFoundJournal TINYINT DEFAULT 0;
	DECLARE pkJournal BIGINT DEFAULT 0;
	
	SELECT IF( pkService IS NULL ,1, 0),
					IF( statusService = 0 , 2, 0)
	INTO vErrFound, vErrStatus
	FROM ts_service 
	WHERE pkService = InPkService AND fkDriver = InFkUser;
	
	SELECT IF( pkOfferService IS NULL, 4, 0),
					IF( fkJournalDriver IS NULL OR fkJournalDriver = 0, 8, 0)
	INTO vErrFoundOffer, vErrFoundJournal
	FROM ts_offer_service
	WHERE fkService = InPkService AND pkOfferService = InFkOffer;
	
	SET outError = vErrFound + vErrStatus + vErrFoundOffer + vErrFoundJournal;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateOccupied
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateOccupied`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateOccupied`(`InPkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrRole, vErrVerified, vErrFound TINYINT DEFAULT 0;
	
	SELECT IF(pkUser IS NULL, 1, 0),
					IF(role != 'DRIVER_ROLE', 2 ,0),
					IF(verified = 0, 4, 0)
	INTO vErrFound, vErrRole, vErrVerified
	FROM as_user
	WHERE pkUser = InPkUser;
	
	SET outError = vErrFound + vErrRole + vErrVerified;	

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateOfferService
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateOfferService`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateOfferService`(`InFkService` bigint,
`InRate` float(10,2),
`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrStatusService, vErrStatusRegService, vErrVerified, vErrStatusUser TINYINT DEFAULT 0;
	DECLARE vPkService, vPkUser INT;
	
	SELECT	vPkService,
					IF( statusService = 0 , 2, 0),
					IF( statusRegister = 0 , 4, 0)
	INTO vPkService, vErrStatusService, vErrStatusRegService
	FROM ts_service
	WHERE pkService = InFkService;
	
	SELECT pkUser,
					IF(verified = 0, 16, 0),
					IF(statusRegister = 0, 32, 0)
	INTO vPkUser, vErrVerified, vErrStatusUser
	FROM as_user
	WHERE pkUser = InFkUser;
	
	IF vPkService IS NULL  THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrStatusService + vErrStatusRegService;
	END IF;
	
	
	IF vPkUser IS NULL  THEN
		SET outError = outError + 8;
	ELSE
		SET outError = outError + vErrVerified + vErrStatusUser;
	END IF;
	
	IF InRate <= 0 THEN
		SET outError = outError + 64;
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateUserCoords
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateUserCoords`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateUserCoords`(`InFkUser` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound,vErrStatus, vErrVerified TINYINT DEFAULT 0;
	DECLARE vPkUser INT;
	
	SELECT IF(pkUser IS NULL, 1, 0),
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vErrFound, vErrStatus, vErrVerified
	FROM as_user
	WHERE pkUser = InFkUser LIMIT 0, 1;
	
	SET outError = vErrFound + vErrVerified + vErrStatus ;

	RETURN outError;
	
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateUsingVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateUsingVehicle`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateUsingVehicle`(`InPkDriver` int,
`InPkVehicle` int)
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrDriver, vErrVehicle, vErrVerified, vErrStatusVehicle, vErrStatusDriver TINYINT DEFAULT 0;
	DECLARE vPkVehicle, vPkDriver INT;
	
	#verificamos existencia del vehículo
	SELECT 	pkVehicle,
					IF(verified = 0, 2, 0),
					IF(statusRegister = 0, 4, 0)
	INTO vPkVehicle, vErrVerified, vErrStatusVehicle
	FROM as_vehicle
	WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver
	LIMIT 0,1;
	
	SELECT  pkDriver,
					IF(statusRegister = 0, 16, 0)
	INTO vPkDriver, vErrStatusDriver
	FROM as_driver 
	WHERE pkDriver = InPkDriver
	LIMIT 0,1;
	
	IF vPkVehicle IS NULL THEN
		SET outError = outError + 1;
	ELSE
		SET outError = outError + vErrVerified + vErrStatusVehicle;
	END IF;
	
	IF vPkDriver IS NULL THEN
		SET outError = outError + 8;
	ELSE
		SET outError = outError + vErrStatusDriver;
	END IF;

	RETURN outError;
END
;;
delimiter ;

-- ----------------------------
-- Function structure for ts_fn_verify_updateVehicle
-- ----------------------------
DROP FUNCTION IF EXISTS `ts_fn_verify_updateVehicle`;
delimiter ;;
CREATE FUNCTION `ts_fn_verify_updateVehicle`(`InPkvehicle` int,
`InPkDriver` int,
`InNumberPlate` varchar(10))
 RETURNS tinyint(4)
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrFound, vErrFoundDriver, vErrNumber TINYINT DEFAULT 0;
	
	SELECT IF(pkVehicle IS NOT NULL, 1,0) INTO vErrNumber
	FROM as_vehicle
	WHERE numberPlate = InNumberPlate AND pkVehicle != InPkvehicle AND statusRegister = 1 LIMIT 0,1;
	
	SELECT IF(pkDriver IS NULL, 2, 0) INTO vErrFound
	FROM as_driver
	WHERE pkDriver = InPkDriver;
	
	SELECT IF(pkVehicle IS NULL, 8, 0) INTO vErrFound
	FROM as_vehicle
	WHERE pkVehicle = InPkvehicle AND fkDriver = InPkDriver;
	
	SET outError = vErrNumber + vErrFoundDriver + vErrFound;

	RETURN outError;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_acceptedOfferDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_acceptedOfferDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_acceptedOfferDriver`(IN `InPkService` int,
IN `InPkOffer` int,
IN `InRateOffer` float(10,2),
IN `InPkDriver` int)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_acceptedOfferDriver( InPkService, InPkDriver, InPkOffer );
	
	-- verificar si el pkoffer es 0 crear una nueva oferta
	
	IF outError = 0 THEN
	
	IF InPkOffer = 0 THEN
		UPDATE ts_offer_service SET acceptedDriver = 1,
																isClient = 0,
																dateOfferDriver = CURRENT_TIMESTAMP()
		WHERE pkOfferService = InPkOffer AND fkService = InPkService;
	END IF;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_acceptOfferClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_acceptOfferClient`;
delimiter ;;
CREATE PROCEDURE `ts_sp_acceptOfferClient`(IN `InPkService` bigint,
IN `InFkOffer` bigint,
IN `InFkDriver` int, #pkuser del conductor
IN `InRate` float(10,2),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError INT DEFAULT 0;
	DECLARE outPkUser, outPkvehicle, outPkDriver, outPkPerson INT DEFAULT 0;
	
	SET outError = ts_fn_verify_acceptOfferClient( InPkService, InFkOffer, InFkDriver );
	
	IF outError = 0 THEN
	
		SELECT fkPerson INTO outPkPerson
		FROM as_user
		WHERE pkUser = InFkDriver;
		
		SELECT pkDriver INTO outPkDriver
		FROM as_driver
		WHERE fkPerson = outPkPerson;
		
		SELECT IF(pkVehicle IS NULL, 0 ,pkVehicle) INTO outPkvehicle
		FROM as_vehicle
		WHERE fkDriver = outPkDriver AND driverUsing = 1;
		
		
		UPDATE ts_offer_service SET declined = 1,
																dateDeclined = CURRENT_TIMESTAMP(),
																declinedIsClient = 1,
																isClient = 1
		WHERE pkOfferService != InFkOffer AND fkService = InPkService AND declined = 0;
		
		UPDATE ts_offer_service SET acceptedClient = 1,
																dateAceptedClient = CURRENT_TIMESTAMP(),
																isClient = 1
		WHERE pkOfferService = InFkOffer AND fkService = InPkService;
		
		UPDATE ts_service SET statusService = 2,
													fkDriver = InFkDriver,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InFkUser,
													ipUpdate = InIpUser,
													dateStartService = CURRENT_TIMESTAMP(),
													fkOffer = InFkOffer,
													runOrigin = 0,
													finishOrigin = 0,
													runDestination = 0,
													finishDestination = 0,
													-- dateRunOrigin = CURRENT_TIMESTAMP()
													fkPkVehicle = outPkvehicle
		WHERE pkService = InPkService;
		
		SELECT fkClient INTO outPkUser
		FROM ts_service 
		WHERE pkService = InPkService;
		
		IF outPkUser != 0 THEN
			UPDATE as_user SET waiting = 0
			WHERE pkUser = outPkUser;
		END IF;
																
	END IF;
	
	
	SELECT outError AS 'showError', CURRENT_TIMESTAMP() AS 'dateStart';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addAlert
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addAlert`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addAlert`(IN `InFkService` int,
IN `InFkPerson` int,
IN `InIsClient` tinyint,
IN `InLat` float(30, 20),
IN `InLng` float(30, 20),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError, outPkAlert TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_addAlert( InFkService, InFkPerson );
	
	IF outError = 0 THEN
		
		INSERT INTO ts_alert_service( fkService,
																	fkPerson,
																	isClient,
																	lat, 
																	lng,
																	dateAlert,
																	fkUser,
																	ipUser)
		VALUES( InFkService,
						InFkPerson,
						InIsClient,
						InLat,
						InLng,
						CURRENT_TIMESTAMP(),
						InFkUser,
						InIpUser);
						
		SET outPkAlert = LAST_INSERT_ID();
		
	END IF;
	
	SELECT outError AS 'showError', outPkAlert AS 'pkAlert';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addAlertNotify
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addAlertNotify`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addAlertNotify`(IN `InHeader` varchar(100),
IN `InMsg` varchar(200),
IN `InUrl` varchar(300),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkNotify BIGINT DEFAULT 0;
	
	SET outError = ts_fn_verify_addAlertNotify( InFkUser );
	
	IF outError = 0 THEN
		
		INSERT INTO ts_alert_notify( header,
																message,
																url,
																dateAlert,
																fkUser,
																ipUser)
		VALUES( InHeader,
						InMsg,
						InUrl,
						CURRENT_TIMESTAMP(),
						InFkUser,
						InIpUser);
						
		SET outPkNotify = LAST_INSERT_ID();

	END IF;
	
	SELECT outError AS 'showError', outPkNotify AS 'pkAlertNotify';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addCalification
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addCalification`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addCalification`(IN `InFkservice` bigint,
IN `InIsClient` tinyint,
IN `InCalification` tinyint,
IN `InObservation` varchar(255),
IN `InFkUser` int,
IN `InIp` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkCalification BIGINT DEFAULT 0;
	
	SET outError = ts_fn_verify_addCalification( InFkservice, InIsClient, InFkUser  );
	
	IF outError = 0 THEN
		
		INSERT INTO ts_calification_service	( fkService,
																					isClient,
																					calification,
																					observation,
																					dateCalification,
																					statusRegister,
																					fkUserRegister,
																					dateRegister,
																					ipRegister)
		VALUES( InFkservice,
						InIsClient,
						InCalification,
						InObservation,
						CURRENT_TIMESTAMP(),
						1,
						InFkUser,
						CURRENT_TIMESTAMP(),
						InIp);
		
		SET outPkCalification = LAST_INSERT_ID();
		
		IF InIsClient = 1 THEN
		
			UPDATE ts_service SET calificatedClient = 1
			WHERE pkService = InFkservice;
	
		ELSE
		
			UPDATE ts_service SET calificatedDriver = 1
			WHERE pkService = InFkservice;
			
		END IF;

	
	END IF;
	
	SELECT outError AS 'showError', outPkCalification AS 'pkCalification';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addCard
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addCard`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addCard`(IN `InFkPerson` int,
IN `InIdCard` varchar(100),
IN `InIdClient` varchar(100),
IN `InCardNumber` varchar(16),
IN `InLastFour` char(4),
IN `InBank` varchar(100),
IN `InCardBrand` varchar(30),
IN `InCardType` varchar(30),
IN `InCountryBank` varchar(100),
IN `InCountryCodeBank` varchar(3),
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkCard INT DEFAULT 0;
	
	SET outError = ts_fn_verify_addCard( InFkPerson, InCardNumber, InFkUser );
	
	IF outError = 0 THEN
		 
		 INSERT INTO ts_card( fkPerson,
													idCardCulqui,
													idCustomerCulqui,
													cardNumber,
													lastFour,
													bankName,
													cardBrand,
													cardType,
													countryBank,
													countryCodeBank,
													statusRegister,
													fkUserRegister,
													dateRegister,
													ipRegister)
		VALUES( InFkPerson,
						InIdCard,
						InIdClient,
						InCardNumber,
						InLastFour,
						InBank,
						InCardBrand,
						InCardType,
						InCountryBank,
						InCountryCodeBank,
						1,
						InFkUser,
						CURRENT_TIMESTAMP(),
						InIpUser);
						
		 SET outPkCard = LAST_INSERT_ID();
		 
	END IF;

	SELECT outError AS 'showError', outPkCard AS 'pkCard';
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addContact
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addContact`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addContact`(IN `InFkNationality` int,
IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InEmail` varchar(100),
IN `InPhone` varchar(20),
IN `InFkPerson` int,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkContact INT DEFAULT 0;
	
	SET outError = ts_fn_verify_addContact( InEmail, InPhone, InFkPerson );
	
	IF outError = 0 THEN
		
		INSERT INTO ts_contac ( fkPerson,
														fkNationality,
														`name`,
														surname,
														nameComplete,
														email,
														phone,
														statusRegister,
														dateRegister,
														fkUserRegister,
														ipRegister)
		VALUES( InFkPerson,
						InFkNationality,
						InName,
						InSurname,
						CONCAT(InSurname, ", " ,InName),
						InEmail,
						InPhone,
						1,
						CURRENT_TIMESTAMP(),
						InPkUser,
						InIpUser
						);

		SET outPkContact = LAST_INSERT_ID();

	ELSE
	
		SELECT pkContact INTO outPkContact
		FROM ts_contac
		WHERE (email = InEmail OR phone = InPhone) AND fkPerson = InFkPerson
		LIMIT 0,1;
		
	END IF;
	
	SELECT outError AS 'showError', outPkContact AS 'pkContac';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addJournalDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addJournalDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addJournalDriver`(IN `InFkConfJournal` tinyint,
IN `InFkDriver` int,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outCode CHAR(5) DEFAULT '00000';
	DECLARE vNameConf, vModeConf VARCHAR(30);
	DECLARE outPkJournal INT DEFAULT 0;
	DECLARE vRateConf FLOAT(5,2) DEFAULT 0;
	DECLARE vDateStart datetime;
	
	SET outCode = ts_fn_generate_codeJournal( InFkDriver );
	
	SET outError = ts_fn_verify_addJournalDriver( InFkDriver, InFkConfJournal, InFkUser, outCode );
	
	IF outError = 0 THEN
	
		SELECT nameJournal,
						rateJournal,
						modeJournal
		INTO vNameConf, vRateConf, vModeConf
		FROM cc_config_journal
		WHERE pkConfigJournal = InFkConfJournal;
		
		SET vDateStart = CURRENT_TIMESTAMP();
		
		INSERT INTO ts_journal_driver( 	fkConfigJournal,
																		fkDriver,
																		codeJournal,
																		dateStart,
																		nameJournal,
																		rateJournal,
																		modeJournal,
																		journalStatus,
																		fkUserRegister,
																		dateRegister,
																		ipRegister)
		VALUES( InFkConfJournal,
						InFkDriver,
						outCode,
						vDateStart,
						vNameConf,
						vRateConf,
						vModeConf,
						1,
						InFkUser,
						vDateStart,
						InIpUser
		);

		SET outPkJournal = LAST_INSERT_ID();
		
	END IF;
	
	SELECT outError AS 'showError', outPkJournal AS 'pkJournal', outCode AS 'codeJournal', vDateStart AS 'dateStart';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addOfferService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addOfferService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addOfferService`(IN `InPkService` bigint,
IN `InPkOffer` bigint,
IN `InRateOffer` float(10,2),
IN `InIsClient` tinyint,
IN `InFkDriver` int, -- pkuser,
IN `InFkVehicle` int,

-- jornada conductor
IN `InFkJournal` bigint,
IN `InCodeJournal` varchar(5))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkOffer BIGINT DEFAULT 0;
	DECLARE outErrorVehicle TINYINT DEFAULT 0; 
	
	SET outError = ts_fn_verify_addOfferService( InPkService, InPkOffer, InFkDriver, InFkVehicle, InFkJournal, InCodeJournal, InIsClient );
	
	IF outError = 0 THEN
	
		IF InPkOffer = 0 THEN
		
			INSERT INTO ts_offer_service ( fkService,
																			fkDriver,
																			fkVehicle,
																			rateOffer,
																			isClient,
																			-- dateOffer,
																			declined,
																			acceptedClient,
																			acceptedDriver,
																			dateAceptedDriver,
																			dateOfferDriver,
																			fkJournalDriver,
																			codeJournal)
			VALUES (InPkService,
							InFkDriver,
							InFkVehicle,
							InRateOffer,
							0,
							-- CURRENT_TIMESTAMP(),
							0,
							0,
							1,
							CURRENT_TIMESTAMP(),
							CURRENT_TIMESTAMP(),
							InFkJournal,
							InCodeJournal);
			
			SET outPkOffer = LAST_INSERT_ID();
			
		ELSE
		
			SET outPkOffer = InPkOffer;
			
			IF InIsClient = 1 THEN
			
				UPDATE ts_offer_service SET rateOffer = InRateOffer,
																			acceptedDriver = 0,
																			acceptedClient = 1,
																			isClient = 1,
																			dateOfferClient = CURRENT_TIMESTAMP()
				WHERE pkOfferService = InPkOffer AND fkService = InPkService;
																		
			ELSE
				 
				 UPDATE ts_offer_service SET rateOffer = InRateOffer,
																		acceptedDriver = 1,
																		acceptedClient = 0,
																		isClient = 0,
																		dateOfferDriver = CURRENT_TIMESTAMP()
				WHERE pkOfferService = InPkOffer AND fkService = InPkService;
				 
			END IF;
			
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError', outPkOffer AS 'pkOffer', CURRENT_TIMESTAMP() AS 'dateOffer';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addService`(IN `InFkJournal` int,
IN `InFkRate` int,
IN `InFkCategory` int,
IN `InFkClient` int, #pkUser del cliente
IN `InLatOrigin` float(30,20),
IN `InLngOrigin` float(30,20),
IN `InStreetOrigin` varchar(200),
IN `InLatDestination` float(30,20),
IN `InLngDestination` float(30,20),
IN `InStreetDestination` varchar(200),
IN `InDistance` float(10,2),
IN `InDistanceText` varchar(20),
IN `InMinutes` float(10,2),
IN `InMinutesText` varchar(20),
IN `InRateHistory` float(10,2),
IN `InRateService` float(10,2),

IN `InMinRate` float(10,2),
IN `InMinRatePercent` float(10,2),
IN `InIsMinRate` tinyint,
IN `InPaymentType` char(4),
IN `InIndexHex` varchar(20),

#descuentos

IN `InFkCouponUser` bigint,
IN `InDiscount` float(5,2),
IN `InDiscountType` char(6),

IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError, outCountCredit TINYINT DEFAULT 0;
	DECLARE outPkService, outServices BIGINT DEFAULT 0;
	DECLARE outAliasCategory, outCodeCategory VARCHAR(20);
	
	SET outError = ts_fn_verify_addService( InFkClient, InFkJournal, InFkRate, InRateService, InFkUser, InFkCouponUser, InDiscountType);
	
	IF outError = 0 THEN
	
		SET outServices = ch_fn_addService();
		
		INSERT INTO ts_service ( 	fkJournal,
															fkRate,
															fkCategory,
															fkClient,
															latOrigin,
															lngOrigin,
															streetOrigin,
															latDestination,
															lngDestination,
															streetDestination,
															distance,
															distanceText,
															minutes,
															minutesText,
															rateHistory,
															rateService,
															
															minRate,
															minRatePercent,
															isMinRate,
															paymentType,
															indexHex,
															statusService,
															countOffer,
															
															statusRegister,
															dateRegister,
															fkUserRegister,															
															ipRegister,
															
															-- descuentos
															fkCouponUser,
															discount,
															discountType
														)
		VALUES( InFkJournal,
						InFkRate,
						InFkCategory,
						InFkClient,
						InLatOrigin,
						InLngOrigin,
						InStreetOrigin,
						InLatDestination,
						InLngDestination,
						InStreetDestination,
						InDistance,
						InDistanceText,
						InMinutes,
						InMinutesText,
						InRateHistory,
						InRateService,
						InMinRate,
						InMinRatePercent,
						InIsMinRate,
						InPaymentType,
						InIndexHex,
						1, # -> servicio pendiente
						0, # -> cantidad de veces en la que se cambio la tarifa
						1,
						CURRENT_TIMESTAMP(),
						InFkUser,						
						InIpUser,
						
						InFkCouponUser,
						InDiscount,
						InDiscountType
					);
		
		SET outPkService = LAST_INSERT_ID();
		
		# update field waiting = 1 to client
		
		UPDATE as_user SET waiting = 1,
											 dateWaiting = CURRENT_TIMESTAMP()
		WHERE pkUser = InFkClient;
		
	END IF;
	
	IF outError != 0 THEN
		SELECT outError AS 'showError', outPkService AS 'pkService';
	ELSE
		SELECT aliasCategory, codeCategory
		INTO outAliasCategory, outCodeCategory
		FROM as_category
		WHERE pkCategory = InFkCategory;
	
		SELECT outError AS 'showError',
					 outPkService AS 'pkService',
					 U.pkUser AS 'fkClient',
					 P.img,
					 P.nameComplete,
					 -- InRateHistory AS 'rateHistory',
					 -- InStreetOrigin AS 'streetOrigin',
					 -- InStreetDestination AS 'streetDestination',
					 -- InDistanceText AS 'distanceText',
					 -- InMinutesText AS 'minutesText',
					 -- InRateService AS 'rateService',
					 -- InRateService AS 'rateOfferHistory',
					 -- InRateService AS 'rateOffer',
					 InIndexHex AS 'indexHex',
					 -- InPaymentType AS 'paymentType',
					 -- InMinRatePercent AS 'minRatePercent',
					 -- InIsMinRate AS 'isMinRate',
					 -- 0 AS 'pkOfferService',
					 CURRENT_TIMESTAMP() AS 'created',
					 CURRENT_TIMESTAMP() AS 'dateOfferClient',
					 outAliasCategory AS 'aliasCategory',
					 outCodeCategory AS 'codeCategory',
					 outCountCredit AS 'credits'
		FROM as_user U
		LEFT JOIN as_person P ON P.pkPerson = U.fkPerson
		WHERE U.pkUser = InFkClient;
	END IF;
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_addVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_addVehicle`;
delimiter ;;
CREATE PROCEDURE `ts_sp_addVehicle`(IN `InPkDriver` int,
IN `InFkPerson` int,
IN `InIsProper` tinyint,
IN `InNumberPlate` varchar(10),
IN `InYear` int,
IN `InColor` varchar(10),
IN `InDateSoatExp` varchar(50),
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	
	DECLARE outShowError, outPkVehicle, outPkLog INT DEFAULT 0;
	
	SET outShowError = as_fn_verify_addVehicle( InPkDriver, InFkPerson , InNumberPlate );
	
	IF outShowError = 0 THEN
		INSERT INTO as_vehicle(
				fkDriver,
				isProper,
				numberPlate,
				`year`,
				color,
				dateSoatExpiration,
				statusRegister,
				verified,
				fkUserRegister,
				dateRegister,
				ipRegister
		) VALUES(
			InPkDriver,
			InIsProper,
			InNumberPlate,
			InYear,
			InColor,
			InDateSoatExp,
			1,
			0,
			InPkUser,
			CURRENT_TIMESTAMP(),
			InIpUser
		);
		SET outPkVehicle = LAST_INSERT_ID();
		
		SET outPkLog = as_fn_add_logActivity( InFkPerson,
																						CONCAT('Vehiculo con placa ',InNumberPlate,' registrado desde app'),
																						CONCAT('Vehículo registrado por:', as_fn_getNamesUser(InPkUser),'.'),
																						'success',
																						InPkUser,
																						InIpUser);

		
		
	END IF;
	
	
	SELECT outShowError AS 'showError', outPkVehicle AS 'pkVehicleDriver', outPkLog AS 'pkLog' ;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_closeJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_closeJournal`;
delimiter ;;
CREATE PROCEDURE `ts_sp_closeJournal`(IN `InPkJournal` bigint,
IN `InFkDriver` int,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outCloseDate datetime;
	
	SET outError = ts_fn_verify_closeJournal( InPkJournal, InFkDriver );
	
	IF outError = 0 THEN
		
		SET outCloseDate = CURRENT_TIMESTAMP();
		
		UPDATE ts_journal_driver SET journalStatus = 0,
																	dateEnd = outCloseDate
		WHERE pkJournalDriver = InPkJournal AND fkDriver = InFkDriver;
		
	END IF;
	
	SELECT outError AS 'showError', outCloseDate AS 'dateEnd';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_declineOfferDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_declineOfferDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_declineOfferDriver`(IN `InPkOffer` bigint,
IN `InPkService` bigint,
IN `InPkDriver` int,
IN `InIsClient` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkVehicle, vPkDriver INT DEFAULT 0;
	DECLARE vRateOffer FLOAT(10,2) DEFAULT 0;
	
	
	SET outError = ts_fn_verify_declineOfferDriver( InPkOffer, InPkService, InPkDriver );
	
	IF outError = 0 THEN
	
		IF InIsClient = 0 THEN
			
			IF InPkOffer = 0 THEN
			
				SELECT D.pkDriver , V.pkVehicle
				INTO vPkDriver, vPkVehicle
				FROM as_user U
				INNER JOIN as_person P ON P.pkPerson = U.fkPerson
				INNER JOIN as_driver D ON D.fkPerson = P.pkPerson
				INNER JOIN as_vehicle V ON V.fkDriver = D.pkDriver AND driverUsing = 1 
				WHERE U.pkUser = vPkDriver;
				
				/**SELECT pkVehicle INTO vPkVehicle
				FROM as_vehicle
				WHERE fkDriver = vPkDriver AND driverUsing = 1 LIMIT 0, 1;*/
				
				SELECT rateService	INTO vRateOffer
				FROM ts_service
				WHERE pkService = InPkService;
			
				INSERT INTO ts_offer_service ( fkService,
																				fkDriver,
																				fkVehicle,
																				rateOffer,
																				isClient,
																				-- dateOffer,
																				declined,
																				acceptedClient,
																				acceptedDriver,
																				declinedIsClient,
																				dateDeclined,
																				dateOfferDriver)
				VALUES (InPkService,
								InPkDriver,
								vPkVehicle,
								vRateOffer,
								0,
								-- CURRENT_TIMESTAMP(),
								1,
								0,
								0,
								0,
								CURRENT_TIMESTAMP(),
								CURRENT_TIMESTAMP() );
			
				
			ELSE
				UPDATE ts_offer_service SET declined = 1,
																isClient = 0,
																dateDeclined = CURRENT_TIMESTAMP(),
																declinedIsClient = 0
				WHERE pkOfferService = InPkOffer AND fkService = InPkService AND fkDriver  = InPkDriver;
			END IF;

		ELSE
		
			UPDATE ts_offer_service SET declined = 1,
																dateDeclined = CURRENT_TIMESTAMP(),
																declinedIsClient = 1
			WHERE pkOfferService = InPkOffer AND fkService = InPkService;
			
		END IF;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_deleteContact
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_deleteContact`;
delimiter ;;
CREATE PROCEDURE `ts_sp_deleteContact`(IN `InPkContact` bigint,
IN `InFkPerson` int,
IN `InStatus` tinyint,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError, vErrLimit TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_deleteContact( InPkContact, InFkPerson );
	
	IF outError = 0 THEN
	
		IF InStatus = 0 THEN
		
			UPDATE ts_contac SET 	statusRegister = InStatus,
														dateDelete = CURRENT_TIMESTAMP(),
														fkUserDelete = InPkUser,
														ipDelete = InIpUser

			WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
			
		ELSE
		
			SELECT IF( COUNT(*) > 2 , 16, 0) INTO vErrLimit
			FROM ts_contac
			WHERE fkPerson = InFkPerson AND statusRegister = 1; 
			
			IF vErrLimit = 0 THEN
				
				UPDATE ts_contac SET 	statusRegister = InStatus,
														dateUpdate = CURRENT_TIMESTAMP(),
														fkUserUpdate = InPkUser,
														ipUpdate = InIpUser

				WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
				
			END IF;
			
		END IF;
		
	END IF;
	
	SET outError = outError + vErrLimit;
	
	IF InStatus = 0 THEN
		SELECT outError AS 'showError';
	ELSE
		SELECT C.pkContact,
						C.fkNationality,
						C.`name`,
						C.surname,
						C.nameComplete,
						C.email,
						C.phone,
						N.prefixPhone,
						outError AS 'showError'
		FROM ts_contac C
		INNER JOIN as_nationality N ON N.pkNationality = C.fkNationality
		WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
	END IF;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_deleteService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_deleteService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_deleteService`(IN `InPkService` int,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkUser INT DEFAULT 0;
	
	SET outError = ts_fn_verify_deleteService(InPkService, InPkUser);
	
	IF outError = 0 THEN
	
		SELECT fkClient INTO outPkUser
		FROM ts_service 
		WHERE pkService = InPkService;
		
		IF outPkUser != 0 THEN
			UPDATE as_user SET waiting = 0
			WHERE pkUser = outPkUser;
		END IF;

		
		UPDATE ts_service SET statusService = 0,
													fkUserDelete = InPkUser,
													dateDelete = CURRENT_TIMESTAMP(),
													ipDelete = InIpUser,
													deleteIsClient = 1
		WHERE pkService = InPkService;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_deleteServiceRun
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_deleteServiceRun`;
delimiter ;;
CREATE PROCEDURE `ts_sp_deleteServiceRun`(IN `InPkService` int,
IN `InIsClient` tinyint,
IN `InPkUser` int,
IN `InIp` varchar(20))
BEGIN
	#Routine body goes here...
	#Agregar campo deleteIsClient a tabla ts_service
	DECLARE outIndexHex VARCHAR(20) DEFAULT '';
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkUser INT DEFAULT 0;
	
	SET outError = ts_fn_verify_deleteServiceRun( InPkService, InIsClient, InPkUser );
	
	IF outError = 0 THEN
	
		SELECT fkClient INTO outPkUser
		FROM ts_service 
		WHERE pkService = InPkService;
		
		IF outPkUser != 0 THEN
			UPDATE as_user SET waiting = 0
			WHERE pkUser = outPkUser;
		END IF;
	
		SELECT indexHex INTO outIndexHex
		FROM ts_service
		WHERE pkService = InPkService;
		
		UPDATE ts_service SET statusService = 0,
													dateDelete = CURRENT_TIMESTAMP(),
													ipDelete = CURRENT_TIMESTAMP(),
													deleteIsClient = InIsClient
		WHERE pkService = InPkService;
		
	END IF;
	
	SELECT  outError AS 'showError', outIndexHex AS 'indexHex';
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_deleteVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_deleteVehicle`;
delimiter ;;
CREATE PROCEDURE `ts_sp_deleteVehicle`(IN `InPkVehicle` int,
IN `InPkDriver` int,
IN `InPkPerson` int,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	DECLARE vNumberPlate VARCHAR(20) DEFAULT '';
	
	SET outError = ts_fn_verify_deleteVehicle( InPkVehicle, InPkDriver );
	
	IF outError = 0 THEN
		
		UPDATE as_vehicle SET statusRegister = 0,
													fkUserDelete = InPkUser,
													dateDelete = CURRENT_TIMESTAMP(),
													ipDelete = InIpUser
		WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
		
		SELECT numberPlate INTO vNumberPlate
		FROM as_vehicle
		WHERE pkVehicle = InPkVehicle; 
		
		SET outPkLog = as_fn_add_logActivity( InPkPerson,
						CONCAT('Vehiculo con placa ',vNumberPlate,' eliminado desde app'),
						CONCAT('Vehículo eliminado por:', as_fn_getNamesUser(InPkUser),'.'),
						'success',
						InPkUser,
						InIpUser);
		
	END IF;
	
	SELECT outError AS 'showError', outPkLog AS 'pkLog';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getConactsForAlert
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getConactsForAlert`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getConactsForAlert`(IN `InPkPerson` int,
IN `InPkService` bigint,
IN `InIsClient` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outMsg VARCHAR(200) DEFAULT '';
	DECLARE outNameComplete, outNameRef, outDocument, outDestination VARCHAR(100) DEFAULT '';
	
	SELECT IF(`name` IS NULL, '' , `name`) INTO outNameComplete
	FROM as_person
	WHERE pkPerson = InPkPerson;
	
	IF InIsClient = 1 THEN
		
		SELECT as_fn_getNamesUser( S.fkDriver ),
					CONCAT(ts_fn_getTypeDocUser( S.fkDriver ) , " Nro ", ts_fn_getDocumentUser( S.fkDriver ) ),
					S.streetDestination
		INTO outNameRef, outDocument, outDestination
		FROM ts_service S
		WHERE S.pkService = InPkService;
		
		SET outMsg = CONCAT( outNameComplete, " con destino a ",
													outDestination, ", con conductor ",
												outNameRef, " con ", outDocument, ". ",
													" podría estar en peligro. ");
		
	ELSE
		
		SELECT as_fn_getNamesUser( S.fkClient ),
					CONCAT(ts_fn_getTypeDocUser( S.fkClient ) , " Nro ", ts_fn_getDocumentUser( S.fkClient ) ),
					S.streetDestination
		INTO outNameRef, outDocument, outDestination
		FROM ts_service S
		WHERE S.pkService = InPkService;
		
		SET outMsg = CONCAT( outNameComplete, " con destino a ",
													outDestination, ", con pasajero ",
												outNameRef, " con ", outDocument, ". ",
													" podría estar en peligro. ");
		 
	END IF;
	
	SELECT C.pkContact, C.email, N.prefixPhone, C.phone, outMsg AS 'msg'
	
	FROM ts_contac C
	LEFT JOIN as_nationality N ON N.pkNationality = C.fkNationality 
	WHERE C.fkPerson = InPkPerson AND C.statusRegister = 1
	ORDER BY C.dateRegister DESC;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getDetailService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getDetailService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getDetailService`(IN `InPkService` bigint)
BEGIN
	#Routine body goes here...
	
	SELECT 	-- ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameClient',
					-- ts_fn_getImgUser( S.fkClient ) AS 'imgClient',
					
					-- ts_fn_getNameCompleteUser( S.fkDriver ) AS 'nameDriver',
					-- ts_fn_getImgUser( S.fkDriver ) AS 'imgDriver',
					
					S.latOrigin,
					S.lngOrigin,
					S.latDestination,
					S.lngDestination,
					S.streetOrigin,
					S.streetDestination,
					S.distanceText,
					S.minutesText,
					S.paymentType,	 
					
					V.numberPlate,
					V.`year`,
					V.color,

					V.imgTaxiFrontal, 
					OF.fkVehicle,			
					M.nameModel,			
					B.nameBrand,			
					
					S.dateRunOrigin,
					S.dateFinishOrigin,
					S.dateRunDestination,
					S.dateFinishDestination
					
	FROM ts_service S
	INNER JOIN ts_offer_service OF ON OF.pkOfferService = S.fkOffer
	LEFT JOIN as_vehicle V ON V.pkVehicle = OF.fkVehicle
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	WHERE pkService = InPkService;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getDriversWaiting
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getDriversWaiting`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getDriversWaiting`(IN `InWhereIndex` varchar(400),
IN `InFkCategory` tinyint)
BEGIN
	#Routine body goes here...
	
	DECLARE outWhere VARCHAR(500) DEFAULT '';
	
	IF InWhereIndex != '' THEN
		SET outWhere = CONCAT(outWhere, ' AND U.indexHex IN ', InWhereIndex);
	END IF;
	
	IF InFkCategory = 1 THEN
		SET outWhere = CONCAT( outWhere, ' AND U.category BETWEEN 1 AND 3 ');
	ELSEIF InFkCategory = 2 THEN
		SET outWhere = CONCAT( outWhere, ' AND U.category BETWEEN 2 AND 3 ');
	ELSE
		SET outWhere = CONCAT( outWhere, ' AND U.category = 3 ');
	END IF;

	
	SET @sql = CONCAT( "SELECT U.pkUser, U.lat, U.lng "
							,"FROM as_user U " 
							,"WHERE U.role = 'DRIVER_ROLE' "
							," AND U.verified = 1 "
							," AND U.statusRegister = 1 "
							," AND U.statusSocket = 1 "
							," AND U.occupied = 0"
							," AND U.lat IS NOT NULL"
							," AND U.playGeo = 1"
							,outWhere , ' ;');
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getHistoryClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getHistoryClient`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getHistoryClient`(IN `InPkUser` int,
IN `InPage` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outStart INT DEFAULT 0;
	
	SET outStart = ( InPage - 1 ) * 8;
	
	SELECT S.pkService,
				 ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameClient',
				 ts_fn_getImgUser( S.fkClient ) AS 'imgClient',
				 C.aliasCategory,
				 S.distanceText,
				 S.minutesText,
				 S.streetOrigin,
				 S.streetDestination,
				 S.dateRegister,
				 S.statusService,
				 S.calificatedDriver,
				 S.rateService,
				 S.rateService AS 'rateOffer',
				 S.paymentType,
				 IF(CS.calification IS NULL, 0, CS.calification) AS 'calification'
				 
	FROM ts_service S
	INNER JOIN as_category C ON C.pkCategory = S.fkCategory
	LEFT JOIN ts_calification_service CS ON CS.fkService = S.pkService AND CS.isClient = 0
	WHERE S.statusRegister  = 1 AND S.fkClient = InPkUser
	ORDER BY S.dateRegister DESC
	LIMIT outStart, 8;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getHistoryDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getHistoryDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getHistoryDriver`(IN `InPkUser` int,
In `InPage` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outStart INT DEFAULT 0;
	
	SET outStart = ( InPage - 1 ) * 8;
	
	SELECT S.pkService,
				 ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameClient',
				 ts_fn_getImgUser( S.fkClient ) AS 'imgClient',
				 C.aliasCategory,
				 S.distanceText,
				 S.minutesText,
				 S.streetOrigin,
				 S.streetDestination,
				 S.dateRegister,
				 S.statusService,
				 S.calificatedDriver,
				 S.rateService,
				 S.rateService AS 'rateOffer',
				 S.paymentType,
				 IF(CS.calification IS NULL, 0, CS.calification) AS 'calification'
				 
	FROM ts_service S
	INNER JOIN as_category C ON C.pkCategory = S.fkCategory
	LEFT JOIN ts_calification_service CS ON CS.fkService = S.pkService AND CS.isClient = 0
	WHERE S.statusRegister  = 1 AND S.fkDriver = InPkUser
	ORDER BY S.dateRegister DESC
	LIMIT outStart, 8;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getInfoMonitor
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getInfoMonitor`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getInfoMonitor`(IN `InPkService` int)
BEGIN
	#Routine body goes here...

	SELECT 	S.pkService AS 'abduzcan',
					ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameClient',
					ts_fn_getImgUser( S.fkClient ) AS 'imgClient',
					ts_fn_getDocumentUser( S.fkClient ) AS 'documentClient',
					ts_fn_getTypeDocUser( S.fkClient ) AS 'typeDocClient',
					
					ts_fn_getNameCompleteUser( S.fkDriver ) AS 'nameDriver',
					ts_fn_getImgUser( S.fkDriver ) AS 'imgDriver',
					ts_fn_getDocumentUser( S.fkDriver ) AS 'documentDriver',
					ts_fn_getTypeDocUser( S.fkDriver ) AS 'typeDocDriver',
					
					S.latOrigin,
					S.lngOrigin,
					S.latDestination,
					S.lngDestination,
					S.streetOrigin,
					S.streetDestination,
					S.distanceText,
					S.minutesText,
					S.paymentType,	 #
					OF.rateOffer,
					
					V.numberPlate,
					V.`year`,
					V.color,
					C.aliasCategory,

					V.imgTaxiFrontal, #
					M.nameModel,			#
					B.nameBrand,			#
					
					S.runOrigin,
					S.finishOrigin,
					S.runDestination,
					S.finishDestination,
					S.dateRunOrigin,
					S.dateFinishOrigin,
					S.dateRunDestination,
					S.dateFinishDestination
					
	FROM ts_service S
	INNER JOIN ts_offer_service OF ON OF.pkOfferService = S.fkOffer
	LEFT JOIN as_vehicle V ON V.pkVehicle = OF.fkVehicle
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	LEFT JOIN as_category C ON C.pkCategory = S.fkCategory
	WHERE pkService = InPkService;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getInfoService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getInfoService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getInfoService`(IN `InPkService` bigint)
BEGIN
	#Routine body goes here...
	SELECT S.pkService,
					S.fkClient,
					S.fkDriver,
					ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameClient',
					ts_fn_getImgUser( S.fkClient ) AS 'imgClient',
					ts_fn_getPhoneUser( S.fkClient ) AS 'phoneClient',
					ts_fn_getEmailUser( S.fkClient ) AS 'emailClient',
					ts_fn_getDocumentUser( S.fkClient ) AS 'documentClient',
					ts_fn_getTypeDocUser( S.fkClient ) AS 'typeDocClient',
					ts_fn_getOsUser( S.fkClient ) AS 'osIdClient',
					
					ts_fn_getNameCompleteUser( S.fkDriver ) AS 'nameDriver',
					ts_fn_getImgUser( S.fkDriver ) AS 'imgDriver',
					ts_fn_getPhoneUser( S.fkDriver ) AS 'phoneDriver',
					ts_fn_getEmailUser( S.fkDriver ) AS 'emailDriver',
					ts_fn_getDocumentUser( S.fkDriver ) AS 'documentDriver',
					ts_fn_getTypeDocUser( S.fkDriver ) AS 'typeDocDriver',
					ts_fn_getOsUser( S.fkDriver ) AS 'osIdDriver',
					
					ts_fn_get_currentLat( S.fkDriver ) AS 'latDriver',
					ts_fn_get_currentLng( S.fkDriver ) AS 'lngDriver',
					
					S.latOrigin,
					S.lngOrigin,
					S.latDestination,
					S.lngDestination,
					S.streetOrigin,
					S.streetDestination,
					S.distanceText,
					S.minutesText,
					S.paymentType,	 #
					OF.rateOffer,
					
					V.numberPlate,
					V.`year`,
					V.color,
					C.aliasCategory,
					V.fkDriver AS 'pkDriver',
					V.imgTaxiFrontal, #
					OF.fkVehicle,			#
					M.nameModel,			#
					B.nameBrand,			#
					
					S.runOrigin,
					S.finishOrigin,
					S.runDestination,
					S.finishDestination,
					S.dateRunOrigin,
					S.dateFinishOrigin,
					S.dateRunDestination,
					S.dateFinishDestination,
					S.fkOffer
					
	FROM ts_service S
	INNER JOIN ts_offer_service OF ON OF.pkOfferService = S.fkOffer
	LEFT JOIN as_vehicle V ON V.pkVehicle = OF.fkVehicle
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	LEFT JOIN as_category C ON C.pkCategory = S.fkCategory
	WHERE pkService = InPkService;
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getJournal`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getJournal`(IN `InHour` int)
BEGIN
	
	SELECT pkJournal,
				nameJournal
	FROM cc_journal
	WHERE InHour BETWEEN hourStart AND hourEnd;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getJurnalAll
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getJurnalAll`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getJurnalAll`()
BEGIN
	
	SELECT pkJournal,
				nameJournal,
				codeJournal,
				hourStart,
				hourEnd
	FROM cc_journal
	WHERE statusRegister = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getListAllCJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getListAllCJournal`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getListAllCJournal`()
BEGIN
	#Routine body goes here...
	
	SELECT pkConfigJournal,
					nameJournal,
					rateJournal,
					modeJournal
	FROM cc_config_journal
	WHERE statusRegister = 1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getListContacts
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getListContacts`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getListContacts`(IN `InPkPerson` int)
BEGIN
	#Routine body goes here...
	
	SELECT C.pkContact,
					C.fkNationality,
					C.`name`,
					C.surname,
					C.nameComplete,
					C.email,
					C.phone,
					N.prefixPhone
	FROM ts_contac C
	INNER JOIN as_nationality N ON N.pkNationality = C.fkNationality
	WHERE C.fkPerson = InPkPerson AND C.statusRegister = 1
	
	ORDER BY C.dateRegister DESC
	LIMIT 0, 5;
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getListJournalDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getListJournalDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getListJournalDriver`(IN `InStatus` tinyint,
IN `InFkDriver` int)
BEGIN
	#Routine body goes here...
	DECLARE outWhere VARCHAR(400) DEFAULT '';
	
	SET outWhere = CONCAT( ' WHERE JD.statusRegister = 1 AND JD.journalStatus = ',InStatus );
	
	SET @sql = CONCAT("SELECT JD.pkJournalDriver,
														JD.fkConfigJournal,
														JD.codeJournal,
														JD.dateStart,
														JD.dateEnd,
														JD.totalCash,
														JD.totalCard,
														JD.totalCredit,
														JD.totalDiscount,
														JD.countService,
														JD.nameJournal,
														JD.rateJournal,
														JD.modeJournal "
				,"FROM ts_journal_driver JD  "
				,outWhere,
				" ORDER BY JD.dateRegister DESC",
				" LIMIT 0, 5;");
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getPercentRate
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getPercentRate`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getPercentRate`()
BEGIN
	#Routine body goes here...
	
	SELECT pkConfig, percentRate
	FROM cc_config;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getRateForJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getRateForJournal`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getRateForJournal`(IN `InPkJournal` int)
BEGIN
	#Routine body goes here...
	
	SELECT R.pkRate,
					R.priceRate,
					R.priceMin,
					C.pkCategory,
					C.aliasCategory,
					C.codeCategory
	FROM cc_rate R
	INNER JOIN as_category C ON C.pkCategory = R.fkCategory
	WHERE R.fkJournal = InPkJournal AND R.statusRegister
	ORDER BY C.pkCategory;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getServicesForClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getServicesForClient`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getServicesForClient`(IN `InPage` int,
IN `InPkClient` int)
BEGIN
	#Routine body goes here...
	DECLARE InStart TINYINT DEFAULT 0;
	
	SET InStart = ( InPage - 1 ) * 5;
	
	/**
	P.img, // cambiar antes de enviar por socket
	P.nameComplete,
	U.osId 
	**/
	
	SELECT 	O.pkOfferService,
					S.pkService, #
					S.fkClient, #
					O.dateOfferDriver,
					O.fkDriver,
					S.latOrigin,
					S.lngOrigin,
					S.streetOrigin, #
					S.streetDestination, #
					S.distanceText, #
					S.minutesText, #
					S.minRate,
					S.rateHistory, #
					S.rateService, #
					S.minRate,
					S.isMinRate, #
					S.fkCouponUser,
					S.discount,
					S.discountType,
					S.minRatePercent, #
					O.rateOffer AS 'rateOfferHistory',
					S.paymentType,
					U.osId,
					P.img,
					P.nameComplete,
					-- ts_fn_getOsUser( O.fkDriver ) AS 'osId',
					-- TD.prefix,
					-- N.nameCountry,
					-- N.prefixPhone,
					O.rateOffer,
					0 AS 'changeRate', #

					#cambiar estos datos al ser enviado desde el conductor
					C.pkCategory,
					C.aliasCategory, #
					C.codeCategory,
					V.color,
					V.numberPlate,
					V.`year`,
					B.nameBrand,
					M.nameModel,
					D.pkDriver,
					V.pkVehicle,
					V.imgTaxiFrontal
					
	
	FROM ts_offer_service O
	LEFT JOIN ts_service S ON S.pkService = O.fkService
	INNER JOIN as_user U ON U.pkUser = O.fkDriver
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	
	-- INNER JOIN as_nationality N ON N.pkNationality = P.fkNationality
	-- INNER JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument
	LEFT JOIN as_category C ON C.pkCategory = U.category
	LEFT JOIN as_driver D ON D.fkPerson = U.fkPerson
	LEFT JOIN as_vehicle V ON V.pkVehicle =  D.fkVehicleUsing
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	
	WHERE O.declined = 0 AND S.statusService = 1 AND S.fkClient = InPkClient AND O.acceptedDriver = 1
	ORDER BY O.dateOfferDriver DESC
	LIMIT InStart, 5;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getServicesForDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getServicesForDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getServicesForDriver`(IN `InPage` int,
IN `InPkDriver` int)
BEGIN
	#Routine body goes here...
	DECLARE InIndexUser VARCHAR(20) DEFAULT '';
	DECLARE InWhere, InFields VARCHAR(1500);
	DECLARE InCategory TINYINT DEFAULT 1;
	
	SELECT indexHex, category
	INTO InIndexUser, InCategory
	FROM as_user
	WHERE pkUser = InPkDriver;
	
	SET InWhere = CONCAT(" WHERE S.statusService = 1 AND S.statusRegister = 1 AND S.indexHex = '",InIndexUser,"' ");
	
	IF InCategory = 2 THEN
		SET InWhere = CONCAT(InWhere, " AND S.fkCategory BETWEEN 1 AND 2 ");
	ELSEIF InCategory = 3 THEN
		SET InWhere = CONCAT(InWhere, " AND S.fkCategory BETWEEN 1 AND 3  ");
	ELSE
		 SET InWhere = CONCAT(InWhere, " AND S.fkCategory = 1 ");
	END IF;
	
	SET @InStart = ( InPage - 1 ) * 5;
	-- IF(O.dateOfferDriver IS NULL, S.dateRegister, O.dateOfferDriver) AS 'dateOfferDriver',
	SET InFields = "S.pkService,
									S.fkClient,
									IF(O.dateOfferClient IS NULL, CURRENT_TIMESTAMP(), O.dateOfferClient) AS 'dateOfferClient',
									
									IF(O.fkDriver IS NULL,0 , O.fkDriver) AS fkDriver,
									S.fkCategory,
									C.codeCategory,
									C.aliasCategory,									
									S.latOrigin,
									S.lngOrigin,
									S.streetOrigin,
									S.streetDestination,
									S.distanceText,
									S.minutesText,
									S.rateHistory,
									S.rateService,
									S.minRate,
									S.isMinRate,
									S.minRatePercent,
									S.indexHex,
									S.fkCouponUser,
									S.discount,
									S.discountType,
									IF(O.rateOffer IS NULL, S.rateService, O.rateOffer) AS 'rateOfferHistory',
									S.paymentType,
									ts_fn_getImgUser( S.fkClient ) AS 'img',
									ts_fn_getNameCompleteUser( S.fkClient ) AS 'nameComplete',
									
									0 AS 'changeRate',
									IF(O.rateOffer IS NULL, S.rateService, O.rateOffer) AS 'rateOffer',
									ts_fn_getOsUser( S.fkClient ) AS 'osId',
									IF(O.pkOfferService IS NULL, 0, O.pkOfferService) AS 'pkOfferService'
									 ";
									 
									 -- TD.prefix,
									
	SET @sql = CONCAT(" SELECT ",
										InFields,
										"FROM ts_service S ",
										-- "INNER JOIN as_user U ON U.pkUser = S.fkClient ",
										-- "INNER JOIN as_person P ON P.pkPerson = U.fkPerson ",
										
										"LEFT JOIN as_category C ON C.pkCategory = S.fkCategory ",
										"LEFT JOIN ts_offer_service O ON O.fkService = S.pkService AND O.fkDriver = ", InPkDriver,
										InWhere,
										" AND ts_fn_countDeclineOfer( S.pkService, ", InPkDriver," ) = 0 ",
										" AND IF(O.acceptedDriver IS NULL, 0, O.acceptedDriver) = 0 ",
										" ORDER BY S.dateRegister DESC "
										"LIMIT ?, 5;");
							-- "LEFT JOIN as_type_document TD ON TD.pkTypeDocument = P.fkTypeDocument ",
	
	--  SELECT @sql;
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt USING @InStart;
	
	DEALLOCATE PREPARE stmt;


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getStatisticsDay
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getStatisticsDay`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getStatisticsDay`(IN `InPkUser` int,
IN `InDate` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outFinaliced, outCanceled INT DEFAULT 0;
	
	SELECT COUNT( * ) INTO outFinaliced				 
	FROM ts_service S
	WHERE S.statusRegister  = 1 AND S.fkDriver = 2
	AND DATE(S.dateRegister) = InDate AND  S.statusService = 3;
	
	SELECT COUNT( * ) INTO outCanceled				 
	FROM ts_service S
	WHERE S.statusRegister  = 1 AND S.fkDriver = 2
	AND DATE(S.dateRegister) = InDate AND  S.statusService = 0;
	
	SELECT outFinaliced AS 'totalFinaliced' , outCanceled AS 'totalCanceled'; 

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getStatisticsWeek
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getStatisticsWeek`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getStatisticsWeek`(IN `InPkUser` int,
IN `InWeekStart` varchar(20),
IN `InWeekEnd` varchar(20))
BEGIN
	#Routine body goes here...
	
	SELECT COUNT( * ) AS 'totalFinaliced',
					-- COUNT( S.statusService = 0 ) AS 'totalCanceled',
					DATE(S.dateRegister) AS 'day'
				 
	FROM ts_service S
	WHERE S.statusRegister  = 1 AND S.fkDriver = InPkUser AND S.statusService = 3
	AND S.dateRegister BETWEEN InWeekStart AND InWeekEnd
	GROUP BY DATE(S.dateRegister)
	ORDER BY DATE(S.dateRegister) ASC;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getUsingDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getUsingDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getUsingDriver`(IN `InPkDriver` int)
BEGIN
	#Routine body goes here...
	
	SELECT 	V.pkVehicle,
					B.nameBrand,
					M.nameModel,
					V.numberPlate,
					V.`year`,
					V.color,
					C.aliasCategory,
					C.codeCategory,
					C.pkCategory
	FROM as_vehicle V
	LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
	LEFT JOIN as_model M ON M.pkModel = V.fkModel
	LEFT JOIN as_category C ON C.pkCategory = V.fkCategory
	WHERE V.fkDriver = InPkDriver AND V.driverUsing = 1
	LIMIT 0,1;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_getZonesDemand
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_getZonesDemand`;
delimiter ;;
CREATE PROCEDURE `ts_sp_getZonesDemand`(IN `InPkUser` int,
IN `InWhereIndex` varchar(1000))
BEGIN
	#Routine body goes here...
	DECLARE vPkCategory INT DEFAULT 0;
	DECLARE InWhere VARCHAR(1500);
	
	SELECT IF(category IS NULL, 0, category) INTO vPkCategory
	FROM as_user 
	WHERE pkUser = InPkUser;
	
	SET InWhere = " WHERE statusRegister = 1 AND statusService = 1";
	
	IF vPkCategory = 2 THEN
		SET InWhere = CONCAT(InWhere, " AND fkCategory BETWEEN 1 AND 2 ");
	ELSEIF vPkCategory = 3 THEN
		SET InWhere = CONCAT(InWhere, " AND fkCategory BETWEEN 1 AND 3 ");
	ELSE
		SET InWhere = CONCAT(InWhere, " AND fkCategory = 1 ");
	END IF;
	
	IF InWhereIndex != '' THEN
		
		SET InWhere = CONCAT(InWhere, " AND indexHex IN ", InWhereIndex );
	
	END IF;

	
	SET @sql = CONCAT(" SELECT indexHex, COUNT(*) AS 'total', ts_fn_countDriverZone( indexHex ) AS 'totalDrivers' ",
										" FROM ts_service",
										InWhere,
										" AND ts_fn_countDeclineOfer( ts_service.pkService, ", InPkUser , ") = 0 ",
										" GROUP BY indexHex ",
										" ORDER BY COUNT(*) DESC, ts_fn_countDriverZone( indexHex ) ASC;");
	-- select @sql;
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;
	
END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_overallPageServicesforClient
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_overallPageServicesforClient`;
delimiter ;;
CREATE PROCEDURE `ts_sp_overallPageServicesforClient`(IN `InPkClient` int)
BEGIN
	#Routine body goes here...
	
	SELECT 	COUNT(*) AS 'total'
	FROM ts_offer_service O
	INNER JOIN ts_service S ON S.pkService = O.fkService
	WHERE O.declined = 0 AND S.statusService = 1 AND S.fkClient = InPkClient;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_overallPageServicesForDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_overallPageServicesForDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_overallPageServicesForDriver`(IN `InPkDriver` int)
BEGIN
	#Routine body goes here...
	DECLARE InIndexUser, InCategory VARCHAR(20) DEFAULT '';
	DECLARE InWhere VARCHAR(500);
	
	SELECT indexHex, category 
	INTO InIndexUser, InCategory
	FROM as_user
	WHERE pkUser = InPkDriver;
	
	SET InWhere = CONCAT(" WHERE S.statusService = 1 AND S.statusRegister = 1 AND S.indexHex = '",InIndexUser,"' ");
	
	IF InCategory = 2 THEN
		SET InWhere = CONCAT(InWhere, " AND S.fkCategory BETWEEN 1 AND 2 ");
	ELSEIF InCategory = 1 THEN
		SET InWhere = CONCAT(InWhere, " AND S.fkCategory = 1 ");
	ELSE
		SET InWhere = CONCAT(" WHERE S.statusService = 1 AND S.statusRegister = 1 AND S.indexHex = '",InIndexUser,"' ");
	END IF;
	
									
	SET @sql = CONCAT(" SELECT COUNT(*) AS 'total'",
										"FROM ts_service S ",
										-- "INNER JOIN as_user U ON U.pkUser = S.fkClient ",
										-- "INNER JOIN as_person P ON P.pkPerson = U.fkPerson ",
										"LEFT JOIN ts_offer_service O ON O.fkService = S.pkService AND O.fkDriver = ", InPkDriver,
										InWhere,
										"AND ts_fn_countDeclineOfer( S.pkService, ", InPkDriver," ) = 0 ",
										"AND IF(O.acceptedDriver IS NULL, 0, O.acceptedDriver) = 0 ;");
				
	
	PREPARE stmt FROM @sql;
	EXECUTE stmt;
	
	DEALLOCATE PREPARE stmt;

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateCategoryDriver
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateCategoryDriver`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateCategoryDriver`(IN `InPkUser` int,
IN `InFkCategory` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_updateCategoryDriver( InPkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET category = InFkCategory
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateContact
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateContact`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateContact`(IN `InPkContact` bigint,
IN `InFkNationality` int,
IN `InName` varchar(50),
IN `InSurname` varchar(50),
IN `InEmail` varchar(100),
IN `InPhone` varchar(20),
IN `InFkPerson` int,
IN `InPkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkContact INT DEFAULT 0;
	
	SET outError = ts_fn_verify_updateContact( InPkContact, InEmail, InPhone, InFkPerson );
	
	IF outError = 0 THEN
	
		UPDATE ts_contac SET 	fkNationality = InFkNationality,
													`name` = InName,
													surname = InSurname,
													nameComplete = CONCAT(InSurname, ", ", InName),
													email = InEmail,
													phone = InPhone,
													dateUpdate = CURRENT_TIMESTAMP(),
													fkUserUpdate = InPkUser,
													ipUpdate = InIpUser

		WHERE pkContact = InPkContact AND fkPerson = InFkPerson;
		
	ELSE
		
		SELECT pkContact INTO outPkContact
		FROM ts_contac
		WHERE (email = InEmail OR phone = InPhone) AND fkPerson = InFkPerson
		LIMIT 0,1;
		
	END IF;
	
	SELECT outError AS 'showError', outPkContact AS 'pkContac';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateJournal
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateJournal`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateJournal`(IN `InPkService` bigint,
IN `InFkOffer` bigint,
IN `InFkDriver` int,
IN `InFkUser` int)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE vPkJournal, vCountService BIGINT DEFAULT 0;
	DECLARE vCodeJournal, vPayment varchar(5) DEFAULT '';
	DECLARE vRateService, vDiscount, vTotalCash, vTotalCard, vTotalCredit, vTotalDiscount FLOAT(10,2) DEFAULT 0;
	
	SET outError = ts_fn_verify_updateJournal( InPkService,InFkOffer,InFkDriver,InFkUser );
	
	IF outError = 0 THEN
		
		SELECT fkJournalDriver, codeJournal
		INTO vPkJournal, vCodeJournal
		FROM ts_offer_service
		WHERE pkOfferService = InFkOffer AND fkService = InPkService;
		
		SELECT rateHistory, discount, paymentType
		INTO vRateService, vDiscount, vPayment
		FROM ts_service
		WHERE pkService = InPkService;
		
		SELECT totalCash, totalCard, totalCredit, totalDiscount, countService
		INTO vTotalCash, vTotalCard, vTotalCredit, vTotalDiscount, vCountService
		FROM ts_journal_driver
		WHERE pkJournalDriver = vPkJournal AND codeJournal = vCodeJournal;

		SET vTotalDiscount = vTotalDiscount + vDiscount;
		
		CASE vPayment
			WHEN 'CASH' THEN
				SET vTotalCash = vTotalCash + (vRateService - vDiscount);
				
			WHEN 'CARD' THEN
				SET vTotalCard =  vTotalCard + (vRateService - vDiscount);
			 WHEN 'CRED' THEN # servicios pagados con llama créditos
				SET vTotalCredit = vTotalCredit + vRateService;
				
		END CASE;
		
		SET vCountService = vCountService + 1;
		
		UPDATE ts_journal_driver SET 	totalCash = vTotalCash, 
																	totalCard = vTotalCard, 
																	totalCredit = vTotalCredit,
																	totalDiscount = vTotalDiscount,
																	countService = vCountService
		WHERE pkJournalDriver = vPkJournal AND codeJournal = vCodeJournal;
		
		
	END IF;
	
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateOccupied
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateOccupied`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateOccupied`(IN `InPkUser` int,
IN `InOccupied` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_updateOccupied( InPkUser );
	
	IF outError = 0 THEN
		
		UPDATE as_user SET occupied = InOccupied
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateOfferService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateOfferService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateOfferService`(IN `InPkOffer` bigint,
IN `InFkService` bigint,
IN `InIsClient` tinyint,
IN `InRate` float(10,2),
IN `InFkUser` int,
IN `InAcepted` tinyint)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkOffer BIGINT;
	
	SET outError = ts_fn_verify_updateOfferService( InFkService, InRate, InFkUser );
	
	IF outError = 0 THEN
	
		IF InPkOffer = 0 THEN
			
			INSERT INTO ts_offer_service(
					fkService,
					fkDriver,
					rateOffer,
					dateOffer,
					declined,
					acceptedClient,
					acceptedDriver
			) VALUES(
					InFkService,
					InFkUser,
					InRate,
					CURRENT_TIMESTAMP(),
					0,
					0,
					1
			);
			
			SET outPkOffer = LAST_INSERT_ID();
			
		ELSE
		
			UPDATE ts_offer_service SET rateOffer = InRate,
																	dateOffer = CURRENT_TIMESTAMP(),
																	acceptedDriver = InAcepted
																	
			WHERE pkOfferService = InPkOffer AND fkService = InFkService;
		
		END IF;
			
		
	END IF;
	
	SELECT outError AS 'showError', outPkOffer AS 'pkOffer';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateTravelService
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateTravelService`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateTravelService`(IN `InPkService` int,
IN `InRunOrigin` tinyint,
IN `InFinishOrigin` tinyint,
IN `InRunDestination` tinyint,
IN `InFinishDestination` tinyint,
IN `InPkUser` int)
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLogClient, outPkLogDriver BIGINT DEFAULT 0;
	DECLARE vPkPersonClient, vPkPersonDriver INT DEFAULT 0;
	DECLARE vDescription, vTitle VARCHAR(250) DEFAULT '';
	DECLARE InDiscountType CHAR(6) DEFAULT 'NONEDD';
	DECLARE InFkCouponUser BIGINT DEFAULT 0;
	DECLARE InRateService FLOAT(5, 2) DEFAULT 0;
	DECLARE outCountCredit TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verifyUpdateTravelService( InPkService );
	IF outError = 0 THEN
		
		IF InRunOrigin = 1 AND InFinishOrigin = 0 THEN
		
			UPDATE ts_service SET dateRunOrigin = CURRENT_TIMESTAMP(),
															runOrigin = 1
			 WHERE pkService = InPkService;

		
		ELSEIF InRunDestination = 1 AND InFinishDestination = 0 THEN
			 
			UPDATE ts_service SET 	finishOrigin = 1,
															dateFinishOrigin = CURRENT_TIMESTAMP(),
															runDestination = 1,
															dateRunDestination = CURRENT_TIMESTAMP()
			WHERE pkService = InPkService;
			 
			#update used coupon or credit
			SELECT rateService, discountType, fkCouponUser
			INTO InRateService, InDiscountType, InFkCouponUser
			FROM ts_service
			WHERE pkService = InPkService;
		
			CASE InDiscountType
				WHEN 'COUPON' THEN
				
					UPDATE rb_coupon_user SET isUsed = 1,
																		dateUsed = CURRENT_TIMESTAMP()
					WHERE pkCouponUser = InFkCouponUser AND fkUser = InPkUser;
					
				WHEN 'CREDIT' THEN
					# llamamos a la funcion que ejecuta un cursor para usar llamacreditos
					SET outCountCredit = ts_fn_used_creditClient( InRateService, InPkUser );
					
			END CASE;
			 
			 
		ELSEIF InFinishDestination = 1 THEN
		
			 UPDATE ts_service SET dateFinishDestination = CURRENT_TIMESTAMP(),
															finishDestination = 1,
															statusService = 3,
															dateFinishService = CURRENT_TIMESTAMP()
			 WHERE pkService = InPkService;
			 
			SELECT 	UC.fkPerson, UD.fkPerson, 
							CONCAT("Desde ",S.streetOrigin, 
											", hasta ", S.streetDestination, 
											" por S/ ", S.rateService, " (", S.distanceText, " - ", S.minutesText, ")." )
			
			INTO vPkPersonClient, vPkPersonDriver, vDescription
			FROM ts_service S

			LEFT JOIN as_user UC ON UC.pkUser = S.fkClient
			LEFT JOIN as_user UD ON UD.pkUser = S.fkDriver
			WHERE pkService = InPkService;
			
			SET vTitle = 'Servicio de taxi completado';
			 
			 -- agregar en historial del conductor y cliente
			 SET outPkLogClient = as_fn_add_logActivity( vPkPersonClient, vTitle, vDescription, 'info', InPkUser, 'app.movil' );
			 SET outPkLogDriver = as_fn_add_logActivity( vPkPersonDriver, vTitle, vDescription, 'info', InPkUser, 'app.movil' );
			 
		END IF;

		
	END IF;
	
	SELECT outError AS 'showError', outPkLogClient AS 'pkLogClient', outPkLogDriver AS 'pkLogDriver';


END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateUserCoords
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateUserCoords`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateUserCoords`(IN `InPkUser` int,
IN `InIndexHex` varchar(20),
IN `InLat` float(30,20),
IN `InLng` float(30,20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	
	SET outError = ts_fn_verify_updateUserCoords(InPkUser);
	
	IF outError = 0 THEN
		
		UPDATE as_user SET 	indexHex = InIndexHex,
												lat = InLat,
												lng = InLng
		WHERE pkUser = InPkUser;
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateUsingVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateUsingVehicle`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateUsingVehicle`(IN `InPkDriver` int,
IN `InPkVehicle` int,
IN `InPkPerson` int,
IN `InFkUser` int,
IN `InIpUser` varchar(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outNumberPlate, outBrand, outModel, outYear, outColor, outCategory, outCodeCategory, outTaxiImg VARCHAR(100);
	DECLARE outPkLog, outPkCategory BIGINT;
	
	SET outError = ts_fn_verify_updateUsingVehicle( InPkDriver, InPkVehicle );
	
	IF outError = 0 THEN
		
		UPDATE as_vehicle SET driverUsing = 1
		WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
		
		UPDATE as_vehicle SET driverUsing = 0
		WHERE pkVehicle != InPkVehicle AND fkDriver = InPkDriver;
		
		UPDATE as_driver SET fkVehicleUsing = InPkVehicle
		WHERE pkDriver = InPkDriver;
		
		SELECT 	V.numberPlate,
						B.nameBrand,
						M.nameModel,
						V.`year`,
						V.color,
						V.imgTaxiFrontal,
						C.aliasCategory,
						C.pkCategory,
						C.codeCategory
		INTO outNumberPlate, outBrand, outModel, outYear, outColor, outTaxiImg, outCategory, outPkCategory, outCodeCategory
		FROM as_vehicle V
		LEFT JOIN as_category C ON C.pkCategory = V.fkCategory
		LEFT JOIN as_brand B ON B.pkBrand = V.fkBrand
		LEFT JOIN as_model M ON M.pkModel = V.fkModel
		WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
		
		SET outPkLog = as_fn_add_logActivity( 
		InPkPerson, 
		"Cambio de vehículo", 
		CONCAT("Conductor pasó a usar el vehículo ",outBrand, '-', outNumberPlate ,"."),
		'success',
		InFkUser,
		InIpUser);
		
	END IF;
	
	SELECT outError AS 'showError',
				outPkLog AS 'pkLog',
				InPkVehicle AS 'pkVehicle',
				outPkCategory AS 'pkCategory',
				outCodeCategory AS 'codeCategory',
				outNumberPlate AS 'numberPlate',
				outBrand AS 'nameBrand',
				outModel AS 'nameModel',
				outCategory AS 'aliasCategory',
				outYear AS 'year',
				outColor AS 'color',
				outTaxiImg AS 'imgTaxiFrontal';
	

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ts_sp_updateVehicle
-- ----------------------------
DROP PROCEDURE IF EXISTS `ts_sp_updateVehicle`;
delimiter ;;
CREATE PROCEDURE `ts_sp_updateVehicle`(IN `InPkVehicle` INT, 
IN `InPkDriver` INT, 
IN `InFkPerson` INT, 
IN `InIsProper` TINYINT, 
IN `InNumberPlate` VARCHAR(15), 
IN `InYear` INT, 
IN `InColor` VARCHAR(20), 
IN `InDateSoatExpiration` VARCHAR(20), 
IN `InPkUser` INT, 
IN `InIpUser` VARCHAR(20))
BEGIN
	#Routine body goes here...
	DECLARE outError TINYINT DEFAULT 0;
	DECLARE outPkLog BIGINT DEFAULT 0;
	
	
	SET outError = ts_fn_verify_updateVehicle( InPkVehicle, InPkDriver, InNumberPlate );
	
	IF outError = 0 THEN
		
		UPDATE as_vehicle SET 
						isProper		= InIsProper,
						numberPlate	= InNumberPlate,
						`year`			= InYear,
						color 			= InColor,
						dateSoatExpiration	= InDateSoatExpiration,
						dateUpdate = CURRENT_TIMESTAMP(),
						fkUserUpdate = InPkUser,
						ipUpdate = InIpUser
		WHERE pkVehicle = InPkVehicle AND fkDriver = InPkDriver;
		
		SET outPkLog = as_fn_add_logActivity( InFkPerson,
																						CONCAT('Vehiculo con placa ',InNumberPlate,' actualizado desde app'),
																						CONCAT('Vehículo actualizado por:', as_fn_getNamesUser(InPkUser),'.'),
																						'success',
																						InPkUser,
																						InIpUser);
		
	END IF;
	
	SELECT outError AS 'showError';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ut_sp_cursorCodeRef
-- ----------------------------
DROP PROCEDURE IF EXISTS `ut_sp_cursorCodeRef`;
delimiter ;;
CREATE PROCEDURE `ut_sp_cursorCodeRef`()
BEGIN
	#Routine body goes here...
	
	DECLARE done TINYINT DEFAULT FALSE;

  DECLARE vPkUser INT DEFAULT 0;
	DECLARE vName, vSurname VARCHAR(50) DEFAULT '';
	DECLARE vConcatCodes VARCHAR(200) DEFAULT '';
	
  DECLARE cur1 CURSOR FOR 
	SELECT U.pkUser, P.`name`, P.surname
	FROM as_user U
	LEFT JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE  U.role IN ('CLIENT_ROLE', 'DRIVER_ROLE') LIMIT 0, 10;
	
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP FETCH cur1 INTO vPkUser, vName, vSurname;
		
    IF done THEN
      LEAVE read_loop;
    END IF;
		
		SET vConcatCodes = CONCAT( vConcatCodes , as_sp_generateCode( vName, vSurname, vPkUser ), '-');
		
		/**UPDATE as_user SET codeReferal = CONCAT( vConcatCodes , as_sp_generateCode( vName, vSurname, vPkUser )
		WHERE pkUser = vPkUser;*/
    
		
  END LOOP;

  CLOSE cur1;
	
	SELECT vConcatCodes AS 'CODES';

END
;;
delimiter ;

-- ----------------------------
-- Procedure structure for ut_sp_cursorPrefix
-- ----------------------------
DROP PROCEDURE IF EXISTS `ut_sp_cursorPrefix`;
delimiter ;;
CREATE PROCEDURE `ut_sp_cursorPrefix`()
BEGIN
	
	
	DECLARE done INT DEFAULT FALSE;

  DECLARE vPkPerson, vPkUser INT DEFAULT 0;
	DECLARE vUser, vPass, vEmail VARCHAR(100) DEFAULT '';
	
  DECLARE cur1 CURSOR FOR 
	SELECT U.pkUser, P.pkPerson, U.userName, U.userPassword, P.email
	FROM as_user U
	INNER JOIN as_person P ON P.pkPerson = U.fkPerson
	WHERE  U.userPassword = '$2b$10$ZhQr5rwz2nYnBfmmHfTWGefV8tzZxqv5LpLpyWKHctKOUV3Eg4VQO';
	
  DECLARE CONTINUE HANDLER FOR NOT FOUND SET done = TRUE;

  OPEN cur1;

  read_loop: LOOP FETCH cur1 INTO vPkUser, vPkPerson, vUser, vPass, vEmail;
		
    IF done THEN
      LEAVE read_loop;
    END IF;
		
    UPDATE as_user SET userName = vEmail,
												userPassword = '$2b$10$vBpziSLvLJRyGaQ1NC14f.aJL9itBId6Zh2R0hxv2ogSVcm6FyHDu'
		WHERE pkUser = vPkUser AND fkPerson = vPkPerson;
		
  END LOOP;

  CLOSE cur1;

END
;;
delimiter ;

SET FOREIGN_KEY_CHECKS = 1;
