/*
 Navicat Premium Data Transfer

 Source Server         : localhost
 Source Server Type    : MySQL
 Source Server Version : 100121
 Source Schema         : llamataxi_db

 Target Server Type    : MySQL
 Target Server Version : 100121
 File Encoding         : 65001

 Date: 03/12/2020 09:24:35
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = latin1 COLLATE = latin1_spanish_ci ROW_FORMAT = Compact;

-- ----------------------------
-- Records of as_nav_children
-- ----------------------------
INSERT INTO `as_nav_children` VALUES (1, 4, 'Menú padre', '/admin/navFather', ' fa-list-alt', 1, 1, '2020-05-01 10:51:07', '::1', 1, '2020-05-20 16:13:06', '::ffff:192.168.1.40', 1, '2020-05-01 16:25:09', '::1', 1);
INSERT INTO `as_nav_children` VALUES (2, 4, 'Aplicaciones', '/admin/application', 'fa-rocket', 1, 1, '2020-05-10 10:39:49', '::1', 1, '2020-05-20 11:53:31', '::ffff:192.168.1.40', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (3, 4, 'Usuario', '/admin/accountUser', 'fa-user-circle', 1, 1, '2020-05-10 10:42:00', '::1', 1, '2020-10-26 09:33:22', '::1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (4, 4, 'Menú hijo', '/admin/navChildren', 'fa-list-ul', 1, 1, '2020-05-20 11:57:14', '::ffff:192.168.1.40', 1, '2020-05-20 12:01:34', '::ffff:192.168.1.40', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (5, 6, 'Marca', '/admin/brand', 'fa-copyright', 1, 1, '2020-05-20 14:57:31', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (6, 6, 'Modelo', '/admin/model', 'fa-palette', 1, 1, '2020-05-20 14:58:31', '::ffff:192.168.1.40', 1, '2020-05-20 14:59:47', '::ffff:192.168.1.40', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (7, 6, 'Categoría', '/admin/category', 'fa-trophy', 1, 1, '2020-05-20 15:00:47', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (8, 3, 'Perfil conductor', '/admin/profileDriver', 'fa-user', 1, 1, '2020-05-20 15:22:32', '::ffff:192.168.1.40', 1, '2020-05-20 22:03:54', '::ffff:192.168.1.40', NULL, NULL, NULL, 0);
INSERT INTO `as_nav_children` VALUES (9, 3, 'Perfil usuario', '/admin/profileUser', 'fa-user', 1, 3, '2020-05-20 15:28:01', '::ffff:192.168.1.40', 1, '2020-05-20 22:51:24', '::ffff:192.168.1.40', NULL, NULL, NULL, 0);
INSERT INTO `as_nav_children` VALUES (10, 6, 'Menú rol', '/admin/menuRole', 'fa-user-shield', 1, 3, '2020-05-20 16:27:15', '::ffff:192.168.1.40', 1, '2020-10-26 09:34:56', '::1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (11, 6, 'Jornada', '/admin/journal', 'fa-clock', 1, 3, '2020-05-26 18:15:52', '::1', 1, '2020-09-10 12:03:29', '::ffff:127.0.0.1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (12, 6, 'Tarifa', '/admin/rate', 'fa-hand-holding-usd', 1, 3, '2020-05-26 18:16:25', '::1', 1, '2020-05-28 13:08:45', '::ffff:127.0.0.1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (13, 4, 'Monitorear', '/admin/monitorDrivers', 'fa-map-marked-alt', 1, 3, '2020-08-15 20:16:10', '::ffff:127.0.0.1', 1, '2020-10-28 09:26:34', '::1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (14, 4, 'Referidos', '/admin/configReferal', 'fa-user-tag', 1, 3, '2020-10-26 09:32:55', '::1', 1, '2020-10-26 09:35:18', '::1', NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (15, 4, 'Cupón', '/admin/coupon', 'fa-ticket-alt', 1, 3, '2020-10-26 11:59:05', '::1', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (16, 2, 'Conf Jornada', '/admin/ccJournal', ' fa-cog', 1, 3, '2020-10-30 16:05:27', '::1', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (17, 3, 'Liquidaciones', '/admin/liquidation', ' fa-receipt', 1, 3, '2020-11-18 09:42:49', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (18, 4, 'Premios', '/admin/awards', 'fa-trophy', 1, 3, '2020-11-19 10:43:49', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL, 1);
INSERT INTO `as_nav_children` VALUES (19, 4, 'Perfil', '/admin/profile', 'lorem', 1, 3, '2020-11-30 09:42:51', '::ffff:192.168.1.40', NULL, NULL, NULL, NULL, NULL, NULL, 0);

SET FOREIGN_KEY_CHECKS = 1;
