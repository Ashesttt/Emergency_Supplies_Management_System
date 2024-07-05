/*
 Navicat Premium Data Transfer

 Source Server         : 本机
 Source Server Type    : MySQL
 Source Server Version : 80032 (8.0.32)
 Source Host           : localhost:3306
 Source Schema         : emergency_material_manage

 Target Server Type    : MySQL
 Target Server Version : 80032 (8.0.32)
 File Encoding         : 65001

 Date: 06/05/2024 00:13:48
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for apply_info
-- ----------------------------
DROP TABLE IF EXISTS `apply_info`;
CREATE TABLE `apply_info`  (
  `application_id` int NOT NULL AUTO_INCREMENT COMMENT '申请id',
  `user_id` int NULL DEFAULT NULL COMMENT '申请人id',
  `material_id` int NULL DEFAULT NULL COMMENT '申请物资id',
  `apply_quantity` int NULL DEFAULT NULL COMMENT '申请数量',
  `approval_status` enum('Pending','Approved','Rejected','Canceled','Completed','Processing','InsufficientStock','Transporting') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Pending' COMMENT '申批状态',
  `apply_time` datetime NULL DEFAULT NULL COMMENT '申请时间',
  `apply_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '申请原因',
  `approval_time` datetime NULL DEFAULT NULL COMMENT '审批时间',
  `approval_comment` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '审批备注',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '发送的目的地',
  `transport_id` int NULL DEFAULT NULL COMMENT '运输单号id',
  PRIMARY KEY (`application_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 155 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of apply_info
-- ----------------------------
INSERT INTO `apply_info` VALUES (140, 163, 1, 1, 'Completed', '2024-05-05 01:13:45', '1', '2024-05-05 01:26:31', 'GGBond已到达，运输完成，到达时间：2024-05-05T01:27:11.874', '家', 40);
INSERT INTO `apply_info` VALUES (141, 163, 2, 1, 'Completed', '2024-05-05 10:38:40', '1', '2024-05-05 10:39:29', 'GGBond已到达，运输完成，到达时间：2024-05-05T10:43:25.252', '家', 41);
INSERT INTO `apply_info` VALUES (142, 163, 3, 2, 'Transporting', '2024-05-05 10:38:45', '3', '2024-05-05 10:39:31', '已分配到司机，Anya正在运输中', '家', 42);
INSERT INTO `apply_info` VALUES (143, 163, 10, 4, 'Completed', '2024-05-05 10:38:50', '4', '2024-05-05 10:39:34', 'GGBond已到达，运输完成，到达时间：2024-05-05T10:43:26.593', '家', 43);
INSERT INTO `apply_info` VALUES (144, 163, 11, 1, 'Completed', '2024-05-05 10:45:08', '2', '2024-05-05 10:45:14', 'GGBond已到达，运输完成，到达时间：2024-05-05T10:45:46.342', '家', 44);
INSERT INTO `apply_info` VALUES (145, 163, 10, 1, 'Transporting', '2024-05-05 10:50:01', '1', '2024-05-05 10:50:05', '已分配到司机，Anya正在运输中', '家', 45);
INSERT INTO `apply_info` VALUES (146, 163, 10, 2, 'Completed', '2024-05-05 10:50:26', '2', '2024-05-05 10:50:33', 'GGBond已到达，运输完成，到达时间：2024-05-05T10:50:57.030', '家', 46);
INSERT INTO `apply_info` VALUES (147, 163, 12, 1, 'Completed', '2024-05-05 10:51:31', '1', '2024-05-05 10:53:26', 'GGBond已到达，运输完成，到达时间：2024-05-05T10:54:48.730', '家', 47);
INSERT INTO `apply_info` VALUES (148, 163, 1, 1, 'Rejected', '2024-05-05 11:08:12', '3', '2024-05-05 11:08:44', '不给', '家', NULL);
INSERT INTO `apply_info` VALUES (149, 163, 3, 3, 'Approved', '2024-05-05 11:08:17', '553342', '2024-05-05 11:08:58', '已通过审批，等待运输分配司机中', '家', 48);
INSERT INTO `apply_info` VALUES (150, 163, 10, 3, 'Rejected', '2024-05-05 11:08:21', '555', '2024-05-05 11:09:08', '33', '家', NULL);
INSERT INTO `apply_info` VALUES (151, 163, 1, 3, 'Rejected', '2024-05-05 11:08:28', '432rr', '2024-05-05 11:09:10', '434', '家', NULL);
INSERT INTO `apply_info` VALUES (152, 163, 12, 1, 'InsufficientStock', '2024-05-05 11:08:51', '1', '2024-05-05 11:09:04', '仓库库存不足', '家', NULL);
INSERT INTO `apply_info` VALUES (153, 163, 3, 1, 'Approved', '2024-05-05 11:28:12', '1', '2024-05-05 12:00:49', '已通过审批，等待运输分配司机中', '家', 49);
INSERT INTO `apply_info` VALUES (154, 163, 10, 3, 'Pending', '2024-05-05 11:28:16', '3', NULL, NULL, '家', NULL);

-- ----------------------------
-- Table structure for dict_info
-- ----------------------------
DROP TABLE IF EXISTS `dict_info`;
CREATE TABLE `dict_info`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of dict_info
-- ----------------------------
INSERT INTO `dict_info` VALUES ('platform-eleme', 'el-icon-platform-eleme', 'icon');
INSERT INTO `dict_info` VALUES ('eleme', 'el-icon-eleme', 'icon');
INSERT INTO `dict_info` VALUES ('delete-solid', 'el-icon-delete-solid', 'icon');
INSERT INTO `dict_info` VALUES ('delete', 'el-icon-delete', 'icon');
INSERT INTO `dict_info` VALUES ('s-tools', 'el-icon-s-tools', 'icon');
INSERT INTO `dict_info` VALUES ('setting', 'el-icon-setting', 'icon');
INSERT INTO `dict_info` VALUES ('user-solid', 'el-icon-user-solid', 'icon');
INSERT INTO `dict_info` VALUES ('user', 'el-icon-user', 'icon');
INSERT INTO `dict_info` VALUES ('phone', 'el-icon-phone', 'icon');
INSERT INTO `dict_info` VALUES ('phone-outline', 'el-icon-phone-outline', 'icon');
INSERT INTO `dict_info` VALUES ('more', 'el-icon-more', 'icon');
INSERT INTO `dict_info` VALUES ('more-outline', 'el-icon-more-outline', 'icon');
INSERT INTO `dict_info` VALUES ('star-on', 'el-icon-star-on', 'icon');
INSERT INTO `dict_info` VALUES ('star-off', 'el-icon-star-off', 'icon');
INSERT INTO `dict_info` VALUES ('s-goods', 'el-icon-s-goods', 'icon');
INSERT INTO `dict_info` VALUES ('goods', 'el-icon-goods', 'icon');
INSERT INTO `dict_info` VALUES ('warning', 'el-icon-warning', 'icon');
INSERT INTO `dict_info` VALUES ('warning-outline', 'el-icon-warning-outline', 'icon');
INSERT INTO `dict_info` VALUES ('question', 'el-icon-question', 'icon');
INSERT INTO `dict_info` VALUES ('info', 'el-icon-info', 'icon');
INSERT INTO `dict_info` VALUES ('remove', 'el-icon-remove', 'icon');
INSERT INTO `dict_info` VALUES ('circle-plus', 'el-icon-circle-plus', 'icon');
INSERT INTO `dict_info` VALUES ('success', 'el-icon-success', 'icon');
INSERT INTO `dict_info` VALUES ('error', 'el-icon-error', 'icon');
INSERT INTO `dict_info` VALUES ('zoom-in', 'el-icon-zoom-in', 'icon');
INSERT INTO `dict_info` VALUES ('zoom-out', 'el-icon-zoom-out', 'icon');
INSERT INTO `dict_info` VALUES ('remove-outline', 'el-icon-remove-outline', 'icon');
INSERT INTO `dict_info` VALUES ('circle-plus-outline', 'el-icon-circle-plus-outline', 'icon');
INSERT INTO `dict_info` VALUES ('circle-check', 'el-icon-circle-check', 'icon');
INSERT INTO `dict_info` VALUES ('circle-close', 'el-icon-circle-close', 'icon');
INSERT INTO `dict_info` VALUES ('s-help', 'el-icon-s-help', 'icon');
INSERT INTO `dict_info` VALUES ('help', 'el-icon-help', 'icon');
INSERT INTO `dict_info` VALUES ('minus', 'el-icon-minus', 'icon');
INSERT INTO `dict_info` VALUES ('plus', 'el-icon-plus', 'icon');
INSERT INTO `dict_info` VALUES ('check', 'el-icon-check', 'icon');
INSERT INTO `dict_info` VALUES ('close', 'el-icon-close', 'icon');
INSERT INTO `dict_info` VALUES ('picture', 'el-icon-picture', 'icon');
INSERT INTO `dict_info` VALUES ('picture-outline', 'el-icon-picture-outline', 'icon');
INSERT INTO `dict_info` VALUES ('picture-outline-round', 'el-icon-picture-outline-round', 'icon');
INSERT INTO `dict_info` VALUES ('upload', 'el-icon-upload', 'icon');
INSERT INTO `dict_info` VALUES ('upload2', 'el-icon-upload2', 'icon');
INSERT INTO `dict_info` VALUES ('download', 'el-icon-download', 'icon');
INSERT INTO `dict_info` VALUES ('camera-solid', 'el-icon-camera-solid', 'icon');
INSERT INTO `dict_info` VALUES ('camera', 'el-icon-camera', 'icon');
INSERT INTO `dict_info` VALUES ('video-camera-solid', 'el-icon-video-camera-solid', 'icon');
INSERT INTO `dict_info` VALUES ('video-camera', 'el-icon-video-camera', 'icon');
INSERT INTO `dict_info` VALUES ('message-solid', 'el-icon-message-solid', 'icon');
INSERT INTO `dict_info` VALUES ('bell', 'el-icon-bell', 'icon');
INSERT INTO `dict_info` VALUES ('s-cooperation', 'el-icon-s-cooperation', 'icon');
INSERT INTO `dict_info` VALUES ('s-order', 'el-icon-s-order', 'icon');
INSERT INTO `dict_info` VALUES ('s-platform', 'el-icon-s-platform', 'icon');
INSERT INTO `dict_info` VALUES ('s-fold', 'el-icon-s-fold', 'icon');
INSERT INTO `dict_info` VALUES ('s-unfold', 'el-icon-s-unfold', 'icon');
INSERT INTO `dict_info` VALUES ('s-operation', 'el-icon-s-operation', 'icon');
INSERT INTO `dict_info` VALUES ('s-promotion', 'el-icon-s-promotion', 'icon');
INSERT INTO `dict_info` VALUES ('s-home', 'el-icon-s-home', 'icon');
INSERT INTO `dict_info` VALUES ('s-release', 'el-icon-s-release', 'icon');
INSERT INTO `dict_info` VALUES ('s-ticket', 'el-icon-s-ticket', 'icon');
INSERT INTO `dict_info` VALUES ('s-management', 'el-icon-s-management', 'icon');
INSERT INTO `dict_info` VALUES ('s-open', 'el-icon-s-open', 'icon');
INSERT INTO `dict_info` VALUES ('s-shop', 'el-icon-s-shop', 'icon');
INSERT INTO `dict_info` VALUES ('s-marketing', 'el-icon-s-marketing', 'icon');
INSERT INTO `dict_info` VALUES ('s-flag', 'el-icon-s-flag', 'icon');
INSERT INTO `dict_info` VALUES ('s-comment', 'el-icon-s-comment', 'icon');
INSERT INTO `dict_info` VALUES ('s-finance', 'el-icon-s-finance', 'icon');
INSERT INTO `dict_info` VALUES ('s-claim', 'el-icon-s-claim', 'icon');
INSERT INTO `dict_info` VALUES ('s-custom', 'el-icon-s-custom', 'icon');
INSERT INTO `dict_info` VALUES ('s-opportunity', 'el-icon-s-opportunity', 'icon');
INSERT INTO `dict_info` VALUES ('s-data', 'el-icon-s-data', 'icon');
INSERT INTO `dict_info` VALUES ('s-check', 'el-icon-s-check', 'icon');
INSERT INTO `dict_info` VALUES ('s-grid', 'el-icon-s-grid', 'icon');
INSERT INTO `dict_info` VALUES ('menu', 'el-icon-menu', 'icon');
INSERT INTO `dict_info` VALUES ('share', 'el-icon-share', 'icon');
INSERT INTO `dict_info` VALUES ('d-caret', 'el-icon-d-caret', 'icon');
INSERT INTO `dict_info` VALUES ('caret-left', 'el-icon-caret-left', 'icon');
INSERT INTO `dict_info` VALUES ('caret-right', 'el-icon-caret-right', 'icon');
INSERT INTO `dict_info` VALUES ('caret-bottom', 'el-icon-caret-bottom', 'icon');
INSERT INTO `dict_info` VALUES ('caret-top', 'el-icon-caret-top', 'icon');
INSERT INTO `dict_info` VALUES ('bottom-left', 'el-icon-bottom-left', 'icon');
INSERT INTO `dict_info` VALUES ('bottom-right', 'el-icon-bottom-right', 'icon');
INSERT INTO `dict_info` VALUES ('back', 'el-icon-back', 'icon');
INSERT INTO `dict_info` VALUES ('right', 'el-icon-right', 'icon');
INSERT INTO `dict_info` VALUES ('bottom', 'el-icon-bottom', 'icon');
INSERT INTO `dict_info` VALUES ('top', 'el-icon-top', 'icon');
INSERT INTO `dict_info` VALUES ('top-left', 'el-icon-top-left', 'icon');
INSERT INTO `dict_info` VALUES ('top-right', 'el-icon-top-right', 'icon');
INSERT INTO `dict_info` VALUES ('arrow-left', 'el-icon-arrow-left', 'icon');
INSERT INTO `dict_info` VALUES ('arrow-right', 'el-icon-arrow-right', 'icon');
INSERT INTO `dict_info` VALUES ('arrow-down', 'el-icon-arrow-down', 'icon');
INSERT INTO `dict_info` VALUES ('arrow-up', 'el-icon-arrow-up', 'icon');
INSERT INTO `dict_info` VALUES ('d-arrow-left', 'el-icon-d-arrow-left', 'icon');
INSERT INTO `dict_info` VALUES ('d-arrow-right', 'el-icon-d-arrow-right', 'icon');
INSERT INTO `dict_info` VALUES ('video-pause', 'el-icon-video-pause', 'icon');
INSERT INTO `dict_info` VALUES ('video-play', 'el-icon-video-play', 'icon');
INSERT INTO `dict_info` VALUES ('refresh', 'el-icon-refresh', 'icon');
INSERT INTO `dict_info` VALUES ('refresh-right', 'el-icon-refresh-right', 'icon');
INSERT INTO `dict_info` VALUES ('refresh-left', 'el-icon-refresh-left', 'icon');
INSERT INTO `dict_info` VALUES ('finished', 'el-icon-finished', 'icon');
INSERT INTO `dict_info` VALUES ('sort', 'el-icon-sort', 'icon');
INSERT INTO `dict_info` VALUES ('sort-up', 'el-icon-sort-up', 'icon');
INSERT INTO `dict_info` VALUES ('sort-down', 'el-icon-sort-down', 'icon');
INSERT INTO `dict_info` VALUES ('rank', 'el-icon-rank', 'icon');
INSERT INTO `dict_info` VALUES ('loading', 'el-icon-loading', 'icon');
INSERT INTO `dict_info` VALUES ('view', 'el-icon-view', 'icon');
INSERT INTO `dict_info` VALUES ('c-scale-to-original', 'el-icon-c-scale-to-original', 'icon');
INSERT INTO `dict_info` VALUES ('date', 'el-icon-date', 'icon');
INSERT INTO `dict_info` VALUES ('edit', 'el-icon-edit', 'icon');
INSERT INTO `dict_info` VALUES ('edit-outline', 'el-icon-edit-outline', 'icon');
INSERT INTO `dict_info` VALUES ('folder', 'el-icon-folder', 'icon');
INSERT INTO `dict_info` VALUES ('folder-opened', 'el-icon-folder-opened', 'icon');
INSERT INTO `dict_info` VALUES ('folder-add', 'el-icon-folder-add', 'icon');
INSERT INTO `dict_info` VALUES ('folder-remove', 'el-icon-folder-remove', 'icon');
INSERT INTO `dict_info` VALUES ('folder-delete', 'el-icon-folder-delete', 'icon');
INSERT INTO `dict_info` VALUES ('folder-checked', 'el-icon-folder-checked', 'icon');
INSERT INTO `dict_info` VALUES ('tickets', 'el-icon-tickets', 'icon');
INSERT INTO `dict_info` VALUES ('document-remove', 'el-icon-document-remove', 'icon');
INSERT INTO `dict_info` VALUES ('document-delete', 'el-icon-document-delete', 'icon');
INSERT INTO `dict_info` VALUES ('document-copy', 'el-icon-document-copy', 'icon');
INSERT INTO `dict_info` VALUES ('document-checked', 'el-icon-document-checked', 'icon');
INSERT INTO `dict_info` VALUES ('document', 'el-icon-document', 'icon');
INSERT INTO `dict_info` VALUES ('document-add', 'el-icon-document-add', 'icon');
INSERT INTO `dict_info` VALUES ('printer', 'el-icon-printer', 'icon');
INSERT INTO `dict_info` VALUES ('paperclip', 'el-icon-paperclip', 'icon');
INSERT INTO `dict_info` VALUES ('takeaway-box', 'el-icon-takeaway-box', 'icon');
INSERT INTO `dict_info` VALUES ('search', 'el-icon-search', 'icon');
INSERT INTO `dict_info` VALUES ('monitor', 'el-icon-monitor', 'icon');
INSERT INTO `dict_info` VALUES ('attract', 'el-icon-attract', 'icon');
INSERT INTO `dict_info` VALUES ('mobile', 'el-icon-mobile', 'icon');
INSERT INTO `dict_info` VALUES ('scissors', 'el-icon-scissors', 'icon');
INSERT INTO `dict_info` VALUES ('umbrella', 'el-icon-umbrella', 'icon');
INSERT INTO `dict_info` VALUES ('headset', 'el-icon-headset', 'icon');
INSERT INTO `dict_info` VALUES ('brush', 'el-icon-brush', 'icon');
INSERT INTO `dict_info` VALUES ('mouse', 'el-icon-mouse', 'icon');
INSERT INTO `dict_info` VALUES ('coordinate', 'el-icon-coordinate', 'icon');
INSERT INTO `dict_info` VALUES ('magic-stick', 'el-icon-magic-stick', 'icon');
INSERT INTO `dict_info` VALUES ('reading', 'el-icon-reading', 'icon');
INSERT INTO `dict_info` VALUES ('data-line', 'el-icon-data-line', 'icon');
INSERT INTO `dict_info` VALUES ('data-board', 'el-icon-data-board', 'icon');
INSERT INTO `dict_info` VALUES ('pie-chart', 'el-icon-pie-chart', 'icon');
INSERT INTO `dict_info` VALUES ('data-analysis', 'el-icon-data-analysis', 'icon');
INSERT INTO `dict_info` VALUES ('collection-tag', 'el-icon-collection-tag', 'icon');
INSERT INTO `dict_info` VALUES ('film', 'el-icon-film', 'icon');
INSERT INTO `dict_info` VALUES ('suitcase', 'el-icon-suitcase', 'icon');
INSERT INTO `dict_info` VALUES ('suitcase-1', 'el-icon-suitcase-1', 'icon');
INSERT INTO `dict_info` VALUES ('receiving', 'el-icon-receiving', 'icon');
INSERT INTO `dict_info` VALUES ('collection', 'el-icon-collection', 'icon');
INSERT INTO `dict_info` VALUES ('files', 'el-icon-files', 'icon');
INSERT INTO `dict_info` VALUES ('notebook-1', 'el-icon-notebook-1', 'icon');
INSERT INTO `dict_info` VALUES ('notebook-2', 'el-icon-notebook-2', 'icon');
INSERT INTO `dict_info` VALUES ('toilet-paper', 'el-icon-toilet-paper', 'icon');
INSERT INTO `dict_info` VALUES ('office-building', 'el-icon-office-building', 'icon');
INSERT INTO `dict_info` VALUES ('school', 'el-icon-school', 'icon');
INSERT INTO `dict_info` VALUES ('table-lamp', 'el-icon-table-lamp', 'icon');
INSERT INTO `dict_info` VALUES ('house', 'el-icon-house', 'icon');
INSERT INTO `dict_info` VALUES ('no-smoking', 'el-icon-no-smoking', 'icon');
INSERT INTO `dict_info` VALUES ('smoking', 'el-icon-smoking', 'icon');
INSERT INTO `dict_info` VALUES ('shopping-cart-full', 'el-icon-shopping-cart-full', 'icon');
INSERT INTO `dict_info` VALUES ('shopping-cart-1', 'el-icon-shopping-cart-1', 'icon');
INSERT INTO `dict_info` VALUES ('shopping-cart-2', 'el-icon-shopping-cart-2', 'icon');
INSERT INTO `dict_info` VALUES ('shopping-bag-1', 'el-icon-shopping-bag-1', 'icon');
INSERT INTO `dict_info` VALUES ('shopping-bag-2', 'el-icon-shopping-bag-2', 'icon');
INSERT INTO `dict_info` VALUES ('sold-out', 'el-icon-sold-out', 'icon');
INSERT INTO `dict_info` VALUES ('sell', 'el-icon-sell', 'icon');
INSERT INTO `dict_info` VALUES ('present', 'el-icon-present', 'icon');
INSERT INTO `dict_info` VALUES ('box', 'el-icon-box', 'icon');
INSERT INTO `dict_info` VALUES ('bank-card', 'el-icon-bank-card', 'icon');
INSERT INTO `dict_info` VALUES ('money', 'el-icon-money', 'icon');
INSERT INTO `dict_info` VALUES ('coin', 'el-icon-coin', 'icon');
INSERT INTO `dict_info` VALUES ('wallet', 'el-icon-wallet', 'icon');
INSERT INTO `dict_info` VALUES ('discount', 'el-icon-discount', 'icon');
INSERT INTO `dict_info` VALUES ('price-tag', 'el-icon-price-tag', 'icon');
INSERT INTO `dict_info` VALUES ('news', 'el-icon-news', 'icon');
INSERT INTO `dict_info` VALUES ('guide', 'el-icon-guide', 'icon');
INSERT INTO `dict_info` VALUES ('male', 'el-icon-male', 'icon');
INSERT INTO `dict_info` VALUES ('female', 'el-icon-female', 'icon');
INSERT INTO `dict_info` VALUES ('thumb', 'el-icon-thumb', 'icon');
INSERT INTO `dict_info` VALUES ('cpu', 'el-icon-cpu', 'icon');
INSERT INTO `dict_info` VALUES ('link', 'el-icon-link', 'icon');
INSERT INTO `dict_info` VALUES ('connection', 'el-icon-connection', 'icon');
INSERT INTO `dict_info` VALUES ('open', 'el-icon-open', 'icon');
INSERT INTO `dict_info` VALUES ('turn-off', 'el-icon-turn-off', 'icon');
INSERT INTO `dict_info` VALUES ('set-up', 'el-icon-set-up', 'icon');
INSERT INTO `dict_info` VALUES ('chat-round', 'el-icon-chat-round', 'icon');
INSERT INTO `dict_info` VALUES ('chat-line-round', 'el-icon-chat-line-round', 'icon');
INSERT INTO `dict_info` VALUES ('chat-square', 'el-icon-chat-square', 'icon');
INSERT INTO `dict_info` VALUES ('chat-dot-round', 'el-icon-chat-dot-round', 'icon');
INSERT INTO `dict_info` VALUES ('chat-dot-square', 'el-icon-chat-dot-square', 'icon');
INSERT INTO `dict_info` VALUES ('chat-line-square', 'el-icon-chat-line-square', 'icon');
INSERT INTO `dict_info` VALUES ('message', 'el-icon-message', 'icon');
INSERT INTO `dict_info` VALUES ('postcard', 'el-icon-postcard', 'icon');
INSERT INTO `dict_info` VALUES ('position', 'el-icon-position', 'icon');
INSERT INTO `dict_info` VALUES ('turn-off-microphone', 'el-icon-turn-off-microphone', 'icon');
INSERT INTO `dict_info` VALUES ('microphone', 'el-icon-microphone', 'icon');
INSERT INTO `dict_info` VALUES ('close-notification', 'el-icon-close-notification', 'icon');
INSERT INTO `dict_info` VALUES ('bangzhu', 'el-icon-bangzhu', 'icon');
INSERT INTO `dict_info` VALUES ('time', 'el-icon-time', 'icon');
INSERT INTO `dict_info` VALUES ('odometer', 'el-icon-odometer', 'icon');
INSERT INTO `dict_info` VALUES ('crop', 'el-icon-crop', 'icon');
INSERT INTO `dict_info` VALUES ('aim', 'el-icon-aim', 'icon');
INSERT INTO `dict_info` VALUES ('switch-button', 'el-icon-switch-button', 'icon');
INSERT INTO `dict_info` VALUES ('full-screen', 'el-icon-full-screen', 'icon');
INSERT INTO `dict_info` VALUES ('copy-document', 'el-icon-copy-document', 'icon');
INSERT INTO `dict_info` VALUES ('mic', 'el-icon-mic', 'icon');
INSERT INTO `dict_info` VALUES ('stopwatch', 'el-icon-stopwatch', 'icon');
INSERT INTO `dict_info` VALUES ('medal-1', 'el-icon-medal-1', 'icon');
INSERT INTO `dict_info` VALUES ('medal', 'el-icon-medal', 'icon');
INSERT INTO `dict_info` VALUES ('trophy', 'el-icon-trophy', 'icon');
INSERT INTO `dict_info` VALUES ('trophy-1', 'el-icon-trophy-1', 'icon');
INSERT INTO `dict_info` VALUES ('first-aid-kit', 'el-icon-first-aid-kit', 'icon');
INSERT INTO `dict_info` VALUES ('discover', 'el-icon-discover', 'icon');
INSERT INTO `dict_info` VALUES ('place', 'el-icon-place', 'icon');
INSERT INTO `dict_info` VALUES ('location', 'el-icon-location', 'icon');
INSERT INTO `dict_info` VALUES ('location-outline', 'el-icon-location-outline', 'icon');
INSERT INTO `dict_info` VALUES ('location-information', 'el-icon-location-information', 'icon');
INSERT INTO `dict_info` VALUES ('add-location', 'el-icon-add-location', 'icon');
INSERT INTO `dict_info` VALUES ('delete-location', 'el-icon-delete-location', 'icon');
INSERT INTO `dict_info` VALUES ('map-location', 'el-icon-map-location', 'icon');
INSERT INTO `dict_info` VALUES ('alarm-clock', 'el-icon-alarm-clock', 'icon');
INSERT INTO `dict_info` VALUES ('timer', 'el-icon-timer', 'icon');
INSERT INTO `dict_info` VALUES ('watch-1', 'el-icon-watch-1', 'icon');
INSERT INTO `dict_info` VALUES ('watch', 'el-icon-watch', 'icon');
INSERT INTO `dict_info` VALUES ('lock', 'el-icon-lock', 'icon');
INSERT INTO `dict_info` VALUES ('unlock', 'el-icon-unlock', 'icon');
INSERT INTO `dict_info` VALUES ('key', 'el-icon-key', 'icon');
INSERT INTO `dict_info` VALUES ('service', 'el-icon-service', 'icon');
INSERT INTO `dict_info` VALUES ('mobile-phone', 'el-icon-mobile-phone', 'icon');
INSERT INTO `dict_info` VALUES ('bicycle', 'el-icon-bicycle', 'icon');
INSERT INTO `dict_info` VALUES ('truck', 'el-icon-truck', 'icon');
INSERT INTO `dict_info` VALUES ('ship', 'el-icon-ship', 'icon');
INSERT INTO `dict_info` VALUES ('basketball', 'el-icon-basketball', 'icon');
INSERT INTO `dict_info` VALUES ('football', 'el-icon-football', 'icon');
INSERT INTO `dict_info` VALUES ('soccer', 'el-icon-soccer', 'icon');
INSERT INTO `dict_info` VALUES ('baseball', 'el-icon-baseball', 'icon');
INSERT INTO `dict_info` VALUES ('wind-power', 'el-icon-wind-power', 'icon');
INSERT INTO `dict_info` VALUES ('light-rain', 'el-icon-light-rain', 'icon');
INSERT INTO `dict_info` VALUES ('lightning', 'el-icon-lightning', 'icon');
INSERT INTO `dict_info` VALUES ('heavy-rain', 'el-icon-heavy-rain', 'icon');
INSERT INTO `dict_info` VALUES ('sunrise', 'el-icon-sunrise', 'icon');
INSERT INTO `dict_info` VALUES ('sunrise-1', 'el-icon-sunrise-1', 'icon');
INSERT INTO `dict_info` VALUES ('sunset', 'el-icon-sunset', 'icon');
INSERT INTO `dict_info` VALUES ('sunny', 'el-icon-sunny', 'icon');
INSERT INTO `dict_info` VALUES ('cloudy', 'el-icon-cloudy', 'icon');
INSERT INTO `dict_info` VALUES ('partly-cloudy', 'el-icon-partly-cloudy', 'icon');
INSERT INTO `dict_info` VALUES ('cloudy-and-sunny', 'el-icon-cloudy-and-sunny', 'icon');
INSERT INTO `dict_info` VALUES ('moon', 'el-icon-moon', 'icon');
INSERT INTO `dict_info` VALUES ('moon-night', 'el-icon-moon-night', 'icon');
INSERT INTO `dict_info` VALUES ('dish', 'el-icon-dish', 'icon');
INSERT INTO `dict_info` VALUES ('dish-1', 'el-icon-dish-1', 'icon');
INSERT INTO `dict_info` VALUES ('food', 'el-icon-food', 'icon');
INSERT INTO `dict_info` VALUES ('chicken', 'el-icon-chicken', 'icon');
INSERT INTO `dict_info` VALUES ('fork-spoon', 'el-icon-fork-spoon', 'icon');
INSERT INTO `dict_info` VALUES ('knife-fork', 'el-icon-knife-fork', 'icon');
INSERT INTO `dict_info` VALUES ('burger', 'el-icon-burger', 'icon');
INSERT INTO `dict_info` VALUES ('tableware', 'el-icon-tableware', 'icon');
INSERT INTO `dict_info` VALUES ('sugar', 'el-icon-sugar', 'icon');
INSERT INTO `dict_info` VALUES ('dessert', 'el-icon-dessert', 'icon');
INSERT INTO `dict_info` VALUES ('ice-cream', 'el-icon-ice-cream', 'icon');
INSERT INTO `dict_info` VALUES ('hot-water', 'el-icon-hot-water', 'icon');
INSERT INTO `dict_info` VALUES ('water-cup', 'el-icon-water-cup', 'icon');
INSERT INTO `dict_info` VALUES ('coffee-cup', 'el-icon-coffee-cup', 'icon');
INSERT INTO `dict_info` VALUES ('cold-drink', 'el-icon-cold-drink', 'icon');
INSERT INTO `dict_info` VALUES ('goblet', 'el-icon-goblet', 'icon');
INSERT INTO `dict_info` VALUES ('goblet-full', 'el-icon-goblet-full', 'icon');
INSERT INTO `dict_info` VALUES ('goblet-square', 'el-icon-goblet-square', 'icon');
INSERT INTO `dict_info` VALUES ('goblet-square-full', 'el-icon-goblet-square-full', 'icon');
INSERT INTO `dict_info` VALUES ('refrigerator', 'el-icon-refrigerator', 'icon');
INSERT INTO `dict_info` VALUES ('grape', 'el-icon-grape', 'icon');
INSERT INTO `dict_info` VALUES ('watermelon', 'el-icon-watermelon', 'icon');
INSERT INTO `dict_info` VALUES ('cherry', 'el-icon-cherry', 'icon');
INSERT INTO `dict_info` VALUES ('apple', 'el-icon-apple', 'icon');
INSERT INTO `dict_info` VALUES ('pear', 'el-icon-pear', 'icon');
INSERT INTO `dict_info` VALUES ('orange', 'el-icon-orange', 'icon');
INSERT INTO `dict_info` VALUES ('coffee', 'el-icon-coffee', 'icon');
INSERT INTO `dict_info` VALUES ('ice-tea', 'el-icon-ice-tea', 'icon');
INSERT INTO `dict_info` VALUES ('ice-drink', 'el-icon-ice-drink', 'icon');
INSERT INTO `dict_info` VALUES ('milk-tea', 'el-icon-milk-tea', 'icon');
INSERT INTO `dict_info` VALUES ('potato-strips', 'el-icon-potato-strips', 'icon');
INSERT INTO `dict_info` VALUES ('lollipop', 'el-icon-lollipop', 'icon');
INSERT INTO `dict_info` VALUES ('ice-cream-square', 'el-icon-ice-cream-square', 'icon');
INSERT INTO `dict_info` VALUES ('ice-cream-round', 'el-icon-ice-cream-round', 'icon');

-- ----------------------------
-- Table structure for file_info
-- ----------------------------
DROP TABLE IF EXISTS `file_info`;
CREATE TABLE `file_info`  (
  `file_id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `filename` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件名称',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '文件类型',
  `size` bigint NULL DEFAULT NULL COMMENT '文件大小(kb)',
  `url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '下载连接',
  `md5` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `is_delete` int NOT NULL DEFAULT 0 COMMENT '是否已经删除',
  `enable` int NOT NULL DEFAULT 1 COMMENT '链接是否可用',
  PRIMARY KEY (`file_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 78 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of file_info
-- ----------------------------
INSERT INTO `file_info` VALUES (5, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 1, 1);
INSERT INTO `file_info` VALUES (14, '微信图片_20240110214409.jpg', 'jpg', 193, 'http://localhost:9090/file/999704a38e4244e2bcf2acd1afea76fe.jpg', '255065aff938a00c8c3e2a24c36e52a5', 1, 0);
INSERT INTO `file_info` VALUES (17, '微信图片_20240110214409.jpg', 'jpg', 193, 'http://localhost:9090/file/999704a38e4244e2bcf2acd1afea76fe.jpg', '255065aff938a00c8c3e2a24c36e52a5', 1, 1);
INSERT INTO `file_info` VALUES (21, '微信图片_20240110214409.jpg', 'jpg', 193, 'http://localhost:9090/file/999704a38e4244e2bcf2acd1afea76fe.jpg', '255065aff938a00c8c3e2a24c36e52a5', 1, 0);
INSERT INTO `file_info` VALUES (22, '用户信息.xlsx', 'xlsx', 10, 'http://localhost:9090/file/58001d0cfcff46b3bff0bf97c83cdb92.xlsx', '39eedc87dce102e5d5b0d8f0b8931acd', 1, 1);
INSERT INTO `file_info` VALUES (26, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (27, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (28, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (29, '微信图片_20240114141701.jpg', 'jpg', 41, 'http://localhost:9090/file/6bf52a77e32f4e84b4bfbe50dc604a1c.jpg', '5a7e725b2e38ec086aacad721a435aa2', 0, 1);
INSERT INTO `file_info` VALUES (30, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (31, 'qq.jpg', 'jpg', 5, 'http://localhost:9090/file/3e306b759ef84d43a60e0c94e56859b3.jpg', '25d2272072d928d3387cecb16bf20f8b', 0, 1);
INSERT INTO `file_info` VALUES (32, 'qq.jpg', 'jpg', 5, 'http://localhost:9090/file/3e306b759ef84d43a60e0c94e56859b3.jpg', '25d2272072d928d3387cecb16bf20f8b', 0, 1);
INSERT INTO `file_info` VALUES (33, '微信图片_20240114141701.jpg', 'jpg', 41, 'http://localhost:9090/file/6bf52a77e32f4e84b4bfbe50dc604a1c.jpg', '5a7e725b2e38ec086aacad721a435aa2', 0, 1);
INSERT INTO `file_info` VALUES (34, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (35, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (36, 'qq.jpg', 'jpg', 5, 'http://localhost:9090/file/3e306b759ef84d43a60e0c94e56859b3.jpg', '25d2272072d928d3387cecb16bf20f8b', 0, 1);
INSERT INTO `file_info` VALUES (37, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (38, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (39, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (40, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (41, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (42, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (43, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (44, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (45, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (46, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (47, '微信图片_20240110214409.jpg', 'jpg', 193, 'http://localhost:9090/file/999704a38e4244e2bcf2acd1afea76fe.jpg', '255065aff938a00c8c3e2a24c36e52a5', 0, 1);
INSERT INTO `file_info` VALUES (48, '68a1291ab051f8197896e8949fb44aed2c73e7f7.jpg', 'jpg', 24, 'http://localhost:9090/file/0206959401b94860a7033476404c5a10.jpg', '9b1e938960cf82da1cd6aac2bbff3bd0', 0, 1);
INSERT INTO `file_info` VALUES (49, 'qq.jpg', 'jpg', 5, 'http://localhost:9090/file/3e306b759ef84d43a60e0c94e56859b3.jpg', '25d2272072d928d3387cecb16bf20f8b', 0, 1);
INSERT INTO `file_info` VALUES (50, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (51, 'logo.e33fafc4[1].jpg', 'jpg', 50, 'http://localhost:9090/file/f103babb6f3e47bf8e0566dd466ec7d2.jpg', '12b68c32e1fc9337196e2814866bda6b', 0, 1);
INSERT INTO `file_info` VALUES (52, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (53, 'qq.jpg', 'jpg', 5, 'http://localhost:9090/file/3e306b759ef84d43a60e0c94e56859b3.jpg', '25d2272072d928d3387cecb16bf20f8b', 0, 1);
INSERT INTO `file_info` VALUES (54, 'v2-65edf66d4f7b2a146a899a0782963d35_r.jpg', 'jpg', 287, 'http://localhost:9090/file/455cf248c4d34b8aa7592569ac6e7ffe.jpg', '4919b226184396c615d5cafd9c926f4a', 0, 1);
INSERT INTO `file_info` VALUES (55, 'v2-1f64d1fa0021a73d07ac113f329160e8_r.jpg', 'jpg', 189, 'http://localhost:9090/file/d1676c33a7a74c0ea50fb9f7eb07cede.jpg', '1f64d1fa0021a73d07ac113f329160e8', 0, 1);
INSERT INTO `file_info` VALUES (56, 'v2-4c1a746b0ddd1aa9fdc24dfe7b19026e_r.jpg', 'jpg', 549, 'http://localhost:9090/file/9e7c7211a44d4a5ab34834d1a51d25c5.jpg', 'dd2db5544b71fc49225baa691d659183', 0, 1);
INSERT INTO `file_info` VALUES (57, '新建 文本文档.txt', 'txt', 11, 'http://localhost:9090/file/37d4729575c24369a1dcf29f6efa91eb.txt', '10fa96bd4e3227d48165fad912b5e76a', 0, 1);
INSERT INTO `file_info` VALUES (58, '用户信息_2.xlsx', 'xlsx', 4, 'http://localhost:9090/file/2199b91a87f944f78e7be424db1ab944.xlsx', '56e5d0b12b73f7a328b53730d4dac0ad', 0, 1);
INSERT INTO `file_info` VALUES (59, 'v2-1bf313706ee2b2d15a365ab9eb713f63_r.jpg', 'jpg', 514, 'http://localhost:9090/file/db876591fe2141ed8f946faea3a8e2d5.jpg', 'b64ea1afd53b49c7cc5201dbc488a5f6', 0, 1);
INSERT INTO `file_info` VALUES (60, 'v2-6acd3fdd0fe3373a4d341aa1e7756c74_r.jpg', 'jpg', 300, 'http://localhost:9090/file/8ecdd433d1984b298bc7a14150d48925.jpg', '6acd3fdd0fe3373a4d341aa1e7756c74', 0, 1);
INSERT INTO `file_info` VALUES (61, 'v2-4ca47dda7850d98adeb0bdae19add01c_r.jpg', 'jpg', 416, 'http://localhost:9090/file/7ad04a83eed14ae9a718817cad84c9eb.jpg', '4ca47dda7850d98adeb0bdae19add01c', 0, 1);
INSERT INTO `file_info` VALUES (62, 'v2-0caf9a37c8aafae8b4b3aa5d70f1a704_r.jpg', 'jpg', 668, 'http://localhost:9090/file/679840e05b0143ce9f76fc370168940a.jpg', '0caf9a37c8aafae8b4b3aa5d70f1a704', 0, 1);
INSERT INTO `file_info` VALUES (63, 'v2-c14907c373156d121f0809cb15bd6c83_r.jpg', 'jpg', 223, 'http://localhost:9090/file/3b2bc97b1e614902abd456ca82da689c.jpg', 'e9dc0e0bcec32377da9c6c63eaa00765', 0, 1);
INSERT INTO `file_info` VALUES (64, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (65, '微信图片_20240114141701.jpg', 'jpg', 41, 'http://localhost:9090/file/6bf52a77e32f4e84b4bfbe50dc604a1c.jpg', '5a7e725b2e38ec086aacad721a435aa2', 0, 1);
INSERT INTO `file_info` VALUES (66, '微信图片_20240114141701.jpg', 'jpg', 41, 'http://localhost:9090/file/6bf52a77e32f4e84b4bfbe50dc604a1c.jpg', '5a7e725b2e38ec086aacad721a435aa2', 0, 1);
INSERT INTO `file_info` VALUES (67, 'v2-4a415e396121f9fe502c33ed893f75f1_r.jpg', 'jpg', 1003, 'http://localhost:9090/file/a3facb30ab294107873dfa1520df9c90.jpg', 'c3a8716f553b585a2b85419f1fc39488', 0, 1);
INSERT INTO `file_info` VALUES (68, 'OIP-C.jpeg', 'jpeg', 9, 'http://localhost:9090/file/233d3d7f22e54cc1b1a0c4df18397d1a.jpeg', '83c5e201019e279873dc18308b310db0', 0, 1);
INSERT INTO `file_info` VALUES (69, 'v2-8f26cb7031c5ca03aac7ba4638a71d5c_r.jpg', 'jpg', 195, 'http://localhost:9090/file/3d5288ae94c44b80b277a86e4d10c64d.jpg', '8f26cb7031c5ca03aac7ba4638a71d5c', 0, 1);
INSERT INTO `file_info` VALUES (70, '微信图.jpg', 'jpg', 428, 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg', '0719e55b52821f16c0fa3ea121b359b0', 0, 1);
INSERT INTO `file_info` VALUES (71, '637787172363090900375.jpg', 'jpg', 5, 'http://localhost:9090/file/184c06408fe6476b9fb1c19baf96e048.jpg', '215cba8b58ab4cea0d95ae00abf51f53', 0, 1);
INSERT INTO `file_info` VALUES (72, 'Z.jpeg', 'jpeg', 24, 'http://localhost:9090/file/d9aefa4532f0431fbdc55be5e50ab7bd.jpeg', '82f9736fae05256951ff01ed0934548e', 0, 1);
INSERT INTO `file_info` VALUES (73, '9k=.jpeg', 'jpeg', 42, 'http://localhost:9090/file/6668e4fb7ff24cd7ac38455bcf58380f.jpeg', 'a651904005d6347b030169aad542b690', 0, 1);
INSERT INTO `file_info` VALUES (74, 'Z (1).jpeg', 'jpeg', 63, 'http://localhost:9090/file/cae480eabd48428fae01145522a30140.jpeg', '89368d3119680b814dea20ca55b7dd4a', 0, 1);
INSERT INTO `file_info` VALUES (75, 'u=556534690,161459109&fm=253&fmt=auto&app=138&f=JPEG.jpeg', 'jpeg', 52, 'http://localhost:9090/file/6197336eb7f94f72af2a762bd18a0a63.jpeg', '4f5133f7f70b9e98f373cfff2e15ddb1', 0, 1);
INSERT INTO `file_info` VALUES (76, 'u=556534690,161459109&fm=253&fmt=auto&app=138&f=JPEG.jpeg', 'jpeg', 52, 'http://localhost:9090/file/6197336eb7f94f72af2a762bd18a0a63.jpeg', '4f5133f7f70b9e98f373cfff2e15ddb1', 0, 1);
INSERT INTO `file_info` VALUES (77, 'u=1055917622,3640099661&fm=253&fmt=auto&app=120&f=JPEG.jpeg', 'jpeg', 35, 'http://localhost:9090/file/0a863f96b10c456a8b30a5abd39ee43f.jpeg', 'd90bf3e24165bbc541a14a105555c97c', 0, 1);

-- ----------------------------
-- Table structure for material_info
-- ----------------------------
DROP TABLE IF EXISTS `material_info`;
CREATE TABLE `material_info`  (
  `material_id` int NOT NULL AUTO_INCREMENT COMMENT '物资id',
  `material_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物资名字',
  `material_type` enum('Medical','Fire_Rescue','Protection','Communication','Alarm','Engineering_Rescue') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '物资类型',
  `quantity` int NOT NULL COMMENT '数量',
  `material_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '物资的照片url',
  `production_date` date NULL DEFAULT NULL COMMENT '生产日期',
  `expiry_date` date NULL DEFAULT NULL COMMENT '到期日期',
  `status` enum('Available','Damaged','Repairing','Expired') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Available' COMMENT '目前状态',
  `threshold` int NULL DEFAULT 10 COMMENT '预警阈值',
  PRIMARY KEY (`material_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of material_info
-- ----------------------------
INSERT INTO `material_info` VALUES (1, '口罩', 'Protection', 958, 'https://img0.baidu.com/it/u=272206660,3551480946&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', '2024-04-26', '2025-04-26', 'Available', 10);
INSERT INTO `material_info` VALUES (2, '灭火器', 'Fire_Rescue', 444, 'https://ts1.cn.mm.bing.net/th/id/R-C.78c6f879878cfe42a9889e47250727f0?rik=pnEs1tNolKI%2b3w&riu=http%3a%2f%2fywxf119.com%2fApp%2fTpl%2fHome%2fUploads%2f5c4978d81484a.jpg&ehk=5YmU7CGqtp%2beTts9wU4z%2fbsOFQ4j166Vkvt7fQ92nB8%3d&risl=&pid=ImgRaw&r=0', '2024-04-18', '2024-04-17', 'Expired', 10);
INSERT INTO `material_info` VALUES (3, '呼吸机', 'Medical', 159, 'https://img0.baidu.com/it/u=2118588821,504418275&fm=253&fmt=auto&app=138&f=JPEG?w=375&h=500', '2024-03-19', '2024-06-13', 'Available', 10000);
INSERT INTO `material_info` VALUES (10, '报警装备', 'Alarm', 22, 'http://localhost:9090/file/184c06408fe6476b9fb1c19baf96e048.jpg', '2024-05-03', '2025-05-01', 'Available', 10);
INSERT INTO `material_info` VALUES (11, '卫星通讯装备', 'Communication', 16, 'http://localhost:9090/file/d9aefa4532f0431fbdc55be5e50ab7bd.jpeg', '2024-05-22', '2025-05-22', 'Available', 10);
INSERT INTO `material_info` VALUES (12, '挖掘机', 'Engineering_Rescue', 0, 'http://localhost:9090/file/6668e4fb7ff24cd7ac38455bcf58380f.jpeg', '2024-05-22', '2025-05-27', 'Available', 5);

-- ----------------------------
-- Table structure for menu_info
-- ----------------------------
DROP TABLE IF EXISTS `menu_info`;
CREATE TABLE `menu_info`  (
  `menu_id` int NOT NULL AUTO_INCREMENT COMMENT '菜单id',
  `menuname` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '菜单名字',
  `path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路径',
  `icon` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '图标',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  `pid` int NULL DEFAULT NULL COMMENT '父级id',
  `page_path` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '页面路径',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of menu_info
-- ----------------------------
INSERT INTO `menu_info` VALUES (1, '主页', '/home', 'el-icon-ice-tea', 'All', NULL, 'Home');
INSERT INTO `menu_info` VALUES (4, '用户管理', '/user', 'el-icon-user', '用户管理', 7, 'User');
INSERT INTO `menu_info` VALUES (5, '文件管理', '/file', 'el-icon-house', '文件管理', 7, 'File');
INSERT INTO `menu_info` VALUES (6, '角色管理', '/role', 'el-icon-user-solid', '角色管理', 7, 'Role');
INSERT INTO `menu_info` VALUES (7, '系统管理', '', 'el-icon-setting', '系统管理', NULL, NULL);
INSERT INTO `menu_info` VALUES (8, '菜单管理', '/menu', 'el-icon-menu', '菜单管理', 7, 'Menu');
INSERT INTO `menu_info` VALUES (34, '应急物资管理', '', 'el-icon-suitcase', '应急物资管理', NULL, '');
INSERT INTO `menu_info` VALUES (35, '设备跟踪模块', NULL, 'el-icon-s-promotion', '设备跟踪模块', NULL, NULL);
INSERT INTO `menu_info` VALUES (37, '应急物资', '/material', 'el-icon-first-aid-kit', '应急物资', 34, 'Material');
INSERT INTO `menu_info` VALUES (41, '仓库的出库记录', '/usage_record', 'el-icon-s-marketing', '使用记录', 35, 'UsageRecord');
INSERT INTO `menu_info` VALUES (42, '用户物资信息', '', 'el-icon-s-claim', '用户物资信息', NULL, NULL);
INSERT INTO `menu_info` VALUES (43, '用户物资管理', '/user_material', 'el-icon-box', '用户物资管理（管理员专用）', 42, 'UserMaterial');
INSERT INTO `menu_info` VALUES (52, '个人物资管理', '/personal_material', 'el-icon-notebook-1', 'All', 42, 'PersonMaterial');
INSERT INTO `menu_info` VALUES (53, '物资申请审批', '/approval', 'el-icon-check', '物资申请审批(管理员专用)', 42, 'Approval');
INSERT INTO `menu_info` VALUES (55, '物资运输信息', '', 'el-icon-truck', '物资运输信息', NULL, NULL);
INSERT INTO `menu_info` VALUES (71, '用户使用记录', '/user_usage_Record', 'el-icon-discover', '用户使用记录', 35, 'UserUsageRecord');
INSERT INTO `menu_info` VALUES (72, '物资运输管理', '/transport', 'el-icon-service', '物资运输管理', 55, 'Transport');
INSERT INTO `menu_info` VALUES (73, '司机拉货小程序', '/driver', 'el-icon-mobile-phone', '司机拉货小程序', 55, 'Driver');
INSERT INTO `menu_info` VALUES (74, '信息接收中心', NULL, 'el-icon-message', NULL, NULL, NULL);
INSERT INTO `menu_info` VALUES (75, '申请信息', '/personal_apply', 'el-icon-s-comment', '个人申请信息', 74, 'PersonalApply');
INSERT INTO `menu_info` VALUES (78, '系统日志', '/system_message', 'el-icon-wind-power', '系统信息', 74, 'SystemMessage');
INSERT INTO `menu_info` VALUES (79, '个人日志', '/person_message', 'el-icon-s-custom', '个人日志', 74, 'PersonMessage');

-- ----------------------------
-- Table structure for message_info
-- ----------------------------
DROP TABLE IF EXISTS `message_info`;
CREATE TABLE `message_info`  (
  `message_id` int NOT NULL AUTO_INCREMENT COMMENT '消息id',
  `receiver_id` int NULL DEFAULT NULL COMMENT '接收者id',
  `title` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '信息标题',
  `content` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '信息',
  `send_time` datetime NULL DEFAULT NULL COMMENT '发送时间',
  `read_status` enum('YES','NO') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'NO' COMMENT '消息的阅读状态',
  `type` enum('Warning','Error','Info','Emergency','Success') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'Info' COMMENT '信息重要程度',
  PRIMARY KEY (`message_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 954 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of message_info
-- ----------------------------
INSERT INTO `message_info` VALUES (138, 157, '新的申请', '用户 薯仔 申请了 1 个 口罩 ，请尽快审批', '2024-05-05 01:13:45', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (139, 163, '申请信息发送成功', '您申请了 1 个 口罩 ，请等待管理员审批', '2024-05-05 01:13:45', 'YES', 'Info');
INSERT INTO `message_info` VALUES (140, 163, '申请通过', '您申请的 口罩 已通过审批，等待运输分配司机中', '2024-05-05 01:26:31', 'YES', 'Success');
INSERT INTO `message_info` VALUES (141, 158, '新的运输任务', '您有一条新的运输任务，物资：口罩，数量：1，请尽快运输', '2024-05-05 01:27:00', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (142, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 01:27:00', 'YES', 'Info');
INSERT INTO `message_info` VALUES (143, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 01:27:12', 'YES', 'Success');
INSERT INTO `message_info` VALUES (144, 163, '物资使用通知', '您使用了 口罩，使用数量为 1，使用原因为 1', '2024-05-05 01:33:10', 'NO', 'Info');
INSERT INTO `message_info` VALUES (145, 157, '新的申请', '用户 薯仔 申请了 1 个 灭火器 ，请尽快审批', '2024-05-05 10:38:40', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (146, 163, '申请信息发送成功', '您申请了 1 个 灭火器 ，请等待管理员审批', '2024-05-05 10:38:40', 'NO', 'Info');
INSERT INTO `message_info` VALUES (147, 157, '新的申请', '用户 薯仔 申请了 2 个 呼吸机 ，请尽快审批', '2024-05-05 10:38:45', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (148, 163, '申请信息发送成功', '您申请了 2 个 呼吸机 ，请等待管理员审批', '2024-05-05 10:38:45', 'NO', 'Info');
INSERT INTO `message_info` VALUES (149, 157, '新的申请', '用户 薯仔 申请了 4 个 报警装备 ，请尽快审批', '2024-05-05 10:38:50', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (150, 163, '申请信息发送成功', '您申请了 4 个 报警装备 ，请等待管理员审批', '2024-05-05 10:38:50', 'NO', 'Info');
INSERT INTO `message_info` VALUES (151, 163, '申请通过', '您申请的 灭火器 已通过审批，等待运输分配司机中', '2024-05-05 10:39:29', 'NO', 'Success');
INSERT INTO `message_info` VALUES (152, 163, '申请通过', '您申请的 呼吸机 已通过审批，等待运输分配司机中', '2024-05-05 10:39:31', 'NO', 'Success');
INSERT INTO `message_info` VALUES (153, 163, '申请通过', '您申请的 报警装备 已通过审批，等待运输分配司机中', '2024-05-05 10:39:34', 'NO', 'Success');
INSERT INTO `message_info` VALUES (154, 158, '新的运输任务', '您有一条新的运输任务，物资：灭火器，数量：1，请尽快运输', '2024-05-05 10:39:54', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (155, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 10:39:54', 'NO', 'Info');
INSERT INTO `message_info` VALUES (156, 186, '新的运输任务', '您有一条新的运输任务，物资：呼吸机，数量：2，请尽快运输', '2024-05-05 10:42:47', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (157, 163, '已分配到司机', '您的运输任务已分配到司机，Anya 司机正在努力运输中', '2024-05-05 10:42:47', 'NO', 'Info');
INSERT INTO `message_info` VALUES (158, 158, '新的运输任务', '您有一条新的运输任务，物资：报警装备，数量：4，请尽快运输', '2024-05-05 10:42:55', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (159, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 10:42:55', 'NO', 'Info');
INSERT INTO `message_info` VALUES (160, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 10:43:25', 'NO', 'Success');
INSERT INTO `message_info` VALUES (161, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 10:43:27', 'NO', 'Success');
INSERT INTO `message_info` VALUES (162, 157, '新的申请', '用户 薯仔 申请了 1 个 卫星通讯装备 ，请尽快审批', '2024-05-05 10:45:08', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (163, 163, '申请信息发送成功', '您申请了 1 个 卫星通讯装备 ，请等待管理员审批', '2024-05-05 10:45:08', 'NO', 'Info');
INSERT INTO `message_info` VALUES (164, 163, '申请通过', '您申请的 卫星通讯装备 已通过审批，等待运输分配司机中', '2024-05-05 10:45:14', 'NO', 'Success');
INSERT INTO `message_info` VALUES (165, 158, '新的运输任务', '您有一条新的运输任务，物资：卫星通讯装备，数量：1，请尽快运输', '2024-05-05 10:45:27', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (166, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 10:45:27', 'NO', 'Info');
INSERT INTO `message_info` VALUES (167, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 10:45:46', 'NO', 'Success');
INSERT INTO `message_info` VALUES (168, 157, '新的申请', '用户 薯仔 申请了 1 个 报警装备 ，请尽快审批', '2024-05-05 10:50:01', 'YES', 'Emergency');
INSERT INTO `message_info` VALUES (169, 163, '申请信息发送成功', '您申请了 1 个 报警装备 ，请等待管理员审批', '2024-05-05 10:50:01', 'NO', 'Info');
INSERT INTO `message_info` VALUES (170, 163, '申请通过', '您申请的 报警装备 已通过审批，等待运输分配司机中', '2024-05-05 10:50:05', 'NO', 'Success');
INSERT INTO `message_info` VALUES (171, 186, '新的运输任务', '您有一条新的运输任务，物资：报警装备，数量：1，请尽快运输', '2024-05-05 10:50:11', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (172, 163, '已分配到司机', '您的运输任务已分配到司机，Anya 司机正在努力运输中', '2024-05-05 10:50:11', 'NO', 'Info');
INSERT INTO `message_info` VALUES (173, 157, '新的申请', '用户 薯仔 申请了 2 个 报警装备 ，请尽快审批', '2024-05-05 10:50:26', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (174, 163, '申请信息发送成功', '您申请了 2 个 报警装备 ，请等待管理员审批', '2024-05-05 10:50:26', 'NO', 'Info');
INSERT INTO `message_info` VALUES (175, 163, '申请通过', '您申请的 报警装备 已通过审批，等待运输分配司机中', '2024-05-05 10:50:33', 'NO', 'Success');
INSERT INTO `message_info` VALUES (176, 158, '新的运输任务', '您有一条新的运输任务，物资：报警装备，数量：2，请尽快运输', '2024-05-05 10:50:41', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (177, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 10:50:41', 'NO', 'Info');
INSERT INTO `message_info` VALUES (178, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 10:50:57', 'NO', 'Success');
INSERT INTO `message_info` VALUES (179, 157, '新的申请', '用户 薯仔 申请了 1 个 挖掘机 ，请尽快审批', '2024-05-05 10:51:31', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (180, 163, '申请信息发送成功', '您申请了 1 个 挖掘机 ，请等待管理员审批', '2024-05-05 10:51:31', 'NO', 'Info');
INSERT INTO `message_info` VALUES (181, 163, '申请通过', '您申请的 挖掘机 已通过审批，等待运输分配司机中', '2024-05-05 10:53:26', 'NO', 'Success');
INSERT INTO `message_info` VALUES (182, 157, '仓库预警', '仓库中的 挖掘机 还剩 0 ，需要增加库存啦！', '2024-05-05 10:53:26', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (183, 158, '新的运输任务', '您有一条新的运输任务，物资：挖掘机，数量：1，请尽快运输', '2024-05-05 10:54:22', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (184, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-05-05 10:54:22', 'NO', 'Info');
INSERT INTO `message_info` VALUES (185, 163, '运输完成', '您的运输任务已完成，GGBond 司机已到达。', '2024-05-05 10:54:49', 'NO', 'Success');
INSERT INTO `message_info` VALUES (186, 163, '物资使用通知', '您使用了 报警装备，使用数量为 1，使用原因为 1', '2024-05-05 10:57:39', 'NO', 'Info');
INSERT INTO `message_info` VALUES (187, 157, '新的申请', '用户 薯仔 申请了 1 个 口罩 ，请尽快审批', '2024-05-05 11:08:12', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (188, 163, '申请信息发送成功', '您申请了 1 个 口罩 ，请等待管理员审批', '2024-05-05 11:08:12', 'NO', 'Info');
INSERT INTO `message_info` VALUES (189, 157, '新的申请', '用户 薯仔 申请了 3 个 呼吸机 ，请尽快审批', '2024-05-05 11:08:17', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (190, 163, '申请信息发送成功', '您申请了 3 个 呼吸机 ，请等待管理员审批', '2024-05-05 11:08:17', 'NO', 'Info');
INSERT INTO `message_info` VALUES (191, 157, '新的申请', '用户 薯仔 申请了 3 个 报警装备 ，请尽快审批', '2024-05-05 11:08:21', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (192, 163, '申请信息发送成功', '您申请了 3 个 报警装备 ，请等待管理员审批', '2024-05-05 11:08:21', 'NO', 'Info');
INSERT INTO `message_info` VALUES (193, 157, '新的申请', '用户 薯仔 申请了 3 个 口罩 ，请尽快审批', '2024-05-05 11:08:28', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (194, 163, '申请信息发送成功', '您申请了 3 个 口罩 ，请等待管理员审批', '2024-05-05 11:08:28', 'NO', 'Info');
INSERT INTO `message_info` VALUES (195, 163, '申请被拒绝', '您申请的 口罩 已被管理员拒绝', '2024-05-05 11:08:44', 'NO', 'Error');
INSERT INTO `message_info` VALUES (196, 157, '新的申请', '用户 薯仔 申请了 1 个 挖掘机 ，请尽快审批', '2024-05-05 11:08:51', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (197, 163, '申请信息发送成功', '您申请了 1 个 挖掘机 ，请等待管理员审批', '2024-05-05 11:08:51', 'NO', 'Info');
INSERT INTO `message_info` VALUES (198, 163, '申请通过', '您申请的 呼吸机 已通过审批，等待运输分配司机中', '2024-05-05 11:08:58', 'NO', 'Success');
INSERT INTO `message_info` VALUES (199, 157, '库存不足', '仓库中的 挖掘机 不足 1 ，请补充库存', '2024-05-05 11:09:04', 'NO', 'Error');
INSERT INTO `message_info` VALUES (200, 163, '已通过审批，但库存不足，请等待', '仓库中的 挖掘机 不足 1 ，请等待管理员补充库存，再发放', '2024-05-05 11:09:04', 'NO', 'Error');
INSERT INTO `message_info` VALUES (201, 163, '申请被拒绝', '您申请的 报警装备 已被管理员拒绝', '2024-05-05 11:09:08', 'NO', 'Error');
INSERT INTO `message_info` VALUES (202, 163, '申请被拒绝', '您申请的 口罩 已被管理员拒绝', '2024-05-05 11:09:10', 'NO', 'Error');
INSERT INTO `message_info` VALUES (203, 157, '新的申请', '用户 薯仔 申请了 1 个 呼吸机 ，请尽快审批', '2024-05-05 11:28:12', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (204, 163, '申请信息发送成功', '您申请了 1 个 呼吸机 ，请等待管理员审批', '2024-05-05 11:28:12', 'NO', 'Info');
INSERT INTO `message_info` VALUES (205, 157, '新的申请', '用户 薯仔 申请了 3 个 报警装备 ，请尽快审批', '2024-05-05 11:28:16', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (206, 163, '申请信息发送成功', '您申请了 3 个 报警装备 ，请等待管理员审批', '2024-05-05 11:28:16', 'NO', 'Info');
INSERT INTO `message_info` VALUES (207, 163, '申请通过', '您申请的 呼吸机 已通过审批，等待运输分配司机中', '2024-05-05 12:00:49', 'NO', 'Success');
INSERT INTO `message_info` VALUES (234, 157, '每日库存警告报告', '物料：呼吸机当前库存数量：159 ，低于阈值： 10000<br>物料：挖掘机当前库存数量：0 ，低于阈值： 5<br>请及时补充库存！', '2024-05-05 19:44:34', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (235, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (236, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (237, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (238, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (239, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (240, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (241, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (242, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (243, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:06:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (244, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:07:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (245, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:07:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (246, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:07:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (247, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:07:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (248, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:23:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (249, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:23:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (250, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (251, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (252, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (253, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (254, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (255, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (256, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (257, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (258, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (259, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (260, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (261, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:24:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (262, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (263, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (264, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (265, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (266, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (267, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (268, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (269, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (270, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (271, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (272, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (273, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:25:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (274, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (275, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (276, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (277, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (278, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (279, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (280, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (281, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (282, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (283, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:26:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (284, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (285, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (286, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (287, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (288, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (289, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (290, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (291, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (292, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (293, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (294, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (295, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:27:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (296, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (297, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (298, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (299, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (300, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (301, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (302, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (303, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (304, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (305, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (306, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (307, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:28:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (308, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (309, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (310, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (311, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (312, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (313, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (314, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (315, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (316, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (317, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (318, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (319, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:29:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (320, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (321, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (322, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (323, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (324, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (325, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (326, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (327, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (328, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (329, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (330, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (331, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:30:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (332, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (333, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (334, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (335, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (336, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (337, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (338, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (339, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (340, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (341, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (342, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (343, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:31:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (344, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (345, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (346, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (347, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (348, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (349, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (350, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (351, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (352, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (353, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (354, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (355, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:32:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (356, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (357, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (358, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (359, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (360, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (361, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (362, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (363, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (364, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (365, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (366, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (367, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:33:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (368, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (369, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (370, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (371, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (372, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (373, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (374, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (375, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (376, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (377, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (378, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (379, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:34:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (380, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (381, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (382, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (383, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (384, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (385, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (386, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (387, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (388, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (389, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (390, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (391, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:35:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (392, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (393, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (394, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (395, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (396, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (397, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (398, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (399, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (400, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (401, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (402, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (403, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:36:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (404, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (405, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (406, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (407, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (408, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (409, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (410, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (411, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (412, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (413, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (414, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (415, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:37:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (416, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (417, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (418, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (419, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (420, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (421, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (422, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (423, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (424, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (425, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (426, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (427, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:38:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (428, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (429, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (430, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (431, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (432, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (433, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (434, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (435, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (436, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (437, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (438, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (439, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:39:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (440, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (441, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (442, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (443, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (444, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (445, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (446, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (447, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (448, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (449, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (450, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (451, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:40:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (452, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (453, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (454, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (455, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (456, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (457, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (458, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (459, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (460, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (461, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (462, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (463, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:41:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (464, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (465, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (466, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (467, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (468, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (469, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (470, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (471, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (472, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (473, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (474, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (475, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:42:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (476, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (477, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (478, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (479, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (480, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (481, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (482, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (483, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (484, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (485, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (486, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (487, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:43:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (488, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (489, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (490, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (491, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (492, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (493, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (494, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (495, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (496, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (497, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (498, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (499, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:44:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (500, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (501, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (502, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (503, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (504, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (505, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (506, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (507, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (508, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (509, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (510, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (511, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:45:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (512, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (513, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (514, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (515, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (516, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (517, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (518, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (519, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (520, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (521, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (522, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (523, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:46:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (524, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (525, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (526, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (527, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (528, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (529, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (530, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (531, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (532, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (533, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (534, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (535, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:47:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (536, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (537, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (538, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (539, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (540, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (541, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (542, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (543, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (544, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (545, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (546, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (547, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:48:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (548, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (549, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (550, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (551, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (552, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (553, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (554, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (555, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (556, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (557, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (558, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (559, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:49:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (560, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (561, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (562, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (563, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (564, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (565, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (566, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (567, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (568, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (569, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (570, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (571, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:50:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (572, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (573, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (574, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (575, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (576, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (577, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (578, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (579, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (580, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (581, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (582, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (583, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:51:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (584, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (585, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (586, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (587, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (588, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (589, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (590, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (591, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (592, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (593, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (594, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (595, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:52:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (596, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (597, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (598, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (599, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (600, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (601, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (602, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (603, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (604, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (605, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (606, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (607, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:53:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (608, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (609, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (610, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (611, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (612, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (613, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (614, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (615, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (616, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (617, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (618, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (619, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:54:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (620, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (621, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (622, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (623, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (624, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (625, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (626, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (627, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (628, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (629, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (630, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (631, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:55:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (632, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (633, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (634, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (635, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (636, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (637, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (638, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (639, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (640, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (641, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (642, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (643, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:56:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (644, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (645, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (646, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (647, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (648, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (649, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (650, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (651, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (652, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (653, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (654, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (655, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:57:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (656, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (657, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (658, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (659, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (660, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (661, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (662, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (663, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (664, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (665, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (666, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (667, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:58:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (668, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (669, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (670, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (671, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (672, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (673, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (674, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (675, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (676, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (677, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (678, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (679, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 20:59:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (680, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (681, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (682, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (683, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (684, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (685, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (686, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (687, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (688, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (689, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (690, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (691, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:00:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (692, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (693, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (694, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (695, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (696, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (697, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (698, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (699, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (700, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (701, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (702, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (703, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:01:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (704, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (705, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (706, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (707, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (708, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (709, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (710, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (711, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (712, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (713, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (714, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (715, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:02:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (716, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (717, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (718, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (719, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (720, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (721, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (722, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (723, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (724, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (725, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (726, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (727, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:03:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (728, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (729, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (730, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (731, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (732, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (733, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (734, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (735, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (736, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (737, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (738, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (739, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:04:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (740, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (741, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (742, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (743, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (744, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (745, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (746, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (747, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (748, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (749, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (750, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (751, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:05:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (752, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (753, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (754, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (755, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (756, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (757, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (758, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (759, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (760, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (761, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (762, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (763, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:06:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (764, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (765, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (766, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (767, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (768, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (769, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (770, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (771, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (772, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (773, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (774, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (775, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:07:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (776, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (777, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (778, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (779, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (780, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (781, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (782, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (783, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (784, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (785, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (786, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (787, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:08:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (788, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (789, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (790, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (791, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (792, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (793, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (794, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (795, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (796, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (797, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (798, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (799, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:09:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (800, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (801, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (802, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (803, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (804, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (805, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (806, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (807, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (808, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (809, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (810, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (811, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:10:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (812, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (813, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (814, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (815, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (816, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (817, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (818, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (819, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (820, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (821, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (822, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (823, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:11:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (824, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (825, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (826, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (827, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (828, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (829, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (830, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (831, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (832, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (833, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (834, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (835, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:12:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (836, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (837, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (838, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (839, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (840, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (841, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (842, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (843, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (844, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (845, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (846, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (847, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:13:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (848, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (849, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (850, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (851, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (852, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (853, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (854, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (855, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (856, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (857, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (858, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (859, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:14:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (860, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (861, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (862, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (863, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (864, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (865, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (866, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (867, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (868, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (869, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (870, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (871, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:15:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (872, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (873, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (874, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (875, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (876, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (877, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (878, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (879, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (880, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (881, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (882, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (883, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:16:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (884, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (885, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (886, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (887, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (888, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (889, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (890, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (891, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (892, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (893, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (894, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (895, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:17:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (896, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (897, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (898, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (899, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (900, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (901, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (902, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (903, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (904, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (905, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (906, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (907, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:18:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (908, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (909, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (910, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (911, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (912, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (913, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (914, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (915, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (916, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (917, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (918, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (919, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:19:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (920, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (921, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (922, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (923, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (924, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (925, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (926, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (927, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (928, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (929, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (930, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (931, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:20:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (932, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (933, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (934, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (935, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (936, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (937, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (938, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (939, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (940, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (941, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:45', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (942, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:50', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (943, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:21:55', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (944, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:00', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (945, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:05', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (946, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:10', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (947, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:15', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (948, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:20', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (949, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:25', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (950, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:30', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (951, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:35', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (952, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:40', 'NO', 'Warning');
INSERT INTO `message_info` VALUES (953, 157, '每日过期物料提醒', '物料：灭火器已过期，过期时间：2024-04-17<br>请及时处理！', '2024-05-05 21:22:45', 'NO', 'Warning');

-- ----------------------------
-- Table structure for role_info
-- ----------------------------
DROP TABLE IF EXISTS `role_info`;
CREATE TABLE `role_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rolename` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10091 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_info
-- ----------------------------
INSERT INTO `role_info` VALUES (1, 'Admin', '管理员');
INSERT INTO `role_info` VALUES (3, 'Rescue_Workers', '救援人员');
INSERT INTO `role_info` VALUES (10089, 'Driver', '司机');
INSERT INTO `role_info` VALUES (10090, 'User', '用户');

-- ----------------------------
-- Table structure for role_menu_relation
-- ----------------------------
DROP TABLE IF EXISTS `role_menu_relation`;
CREATE TABLE `role_menu_relation`  (
  `role_id` int NOT NULL COMMENT '角色id',
  `menu_id` int NOT NULL COMMENT '菜单id',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of role_menu_relation
-- ----------------------------
INSERT INTO `role_menu_relation` VALUES (1, 1);
INSERT INTO `role_menu_relation` VALUES (1, 4);
INSERT INTO `role_menu_relation` VALUES (1, 5);
INSERT INTO `role_menu_relation` VALUES (1, 6);
INSERT INTO `role_menu_relation` VALUES (1, 7);
INSERT INTO `role_menu_relation` VALUES (1, 8);
INSERT INTO `role_menu_relation` VALUES (1, 34);
INSERT INTO `role_menu_relation` VALUES (1, 35);
INSERT INTO `role_menu_relation` VALUES (1, 37);
INSERT INTO `role_menu_relation` VALUES (1, 41);
INSERT INTO `role_menu_relation` VALUES (1, 42);
INSERT INTO `role_menu_relation` VALUES (1, 43);
INSERT INTO `role_menu_relation` VALUES (1, 52);
INSERT INTO `role_menu_relation` VALUES (1, 53);
INSERT INTO `role_menu_relation` VALUES (1, 55);
INSERT INTO `role_menu_relation` VALUES (1, 71);
INSERT INTO `role_menu_relation` VALUES (1, 72);
INSERT INTO `role_menu_relation` VALUES (1, 73);
INSERT INTO `role_menu_relation` VALUES (1, 74);
INSERT INTO `role_menu_relation` VALUES (1, 75);
INSERT INTO `role_menu_relation` VALUES (1, 78);
INSERT INTO `role_menu_relation` VALUES (1, 79);
INSERT INTO `role_menu_relation` VALUES (2, 1);
INSERT INTO `role_menu_relation` VALUES (2, 4);
INSERT INTO `role_menu_relation` VALUES (2, 5);
INSERT INTO `role_menu_relation` VALUES (2, 6);
INSERT INTO `role_menu_relation` VALUES (2, 7);
INSERT INTO `role_menu_relation` VALUES (2, 8);
INSERT INTO `role_menu_relation` VALUES (2, 34);
INSERT INTO `role_menu_relation` VALUES (2, 35);
INSERT INTO `role_menu_relation` VALUES (2, 37);
INSERT INTO `role_menu_relation` VALUES (2, 41);
INSERT INTO `role_menu_relation` VALUES (2, 42);
INSERT INTO `role_menu_relation` VALUES (2, 43);
INSERT INTO `role_menu_relation` VALUES (2, 52);
INSERT INTO `role_menu_relation` VALUES (2, 53);
INSERT INTO `role_menu_relation` VALUES (2, 55);
INSERT INTO `role_menu_relation` VALUES (2, 70);
INSERT INTO `role_menu_relation` VALUES (2, 71);
INSERT INTO `role_menu_relation` VALUES (2, 72);
INSERT INTO `role_menu_relation` VALUES (2, 73);
INSERT INTO `role_menu_relation` VALUES (2, 74);
INSERT INTO `role_menu_relation` VALUES (3, 1);
INSERT INTO `role_menu_relation` VALUES (3, 52);
INSERT INTO `role_menu_relation` VALUES (3, 75);
INSERT INTO `role_menu_relation` VALUES (3, 79);
INSERT INTO `role_menu_relation` VALUES (10089, 1);
INSERT INTO `role_menu_relation` VALUES (10089, 73);
INSERT INTO `role_menu_relation` VALUES (10089, 79);
INSERT INTO `role_menu_relation` VALUES (10090, 1);
INSERT INTO `role_menu_relation` VALUES (10090, 52);
INSERT INTO `role_menu_relation` VALUES (10090, 75);
INSERT INTO `role_menu_relation` VALUES (10090, 79);

-- ----------------------------
-- Table structure for transport_info
-- ----------------------------
DROP TABLE IF EXISTS `transport_info`;
CREATE TABLE `transport_info`  (
  `transport_id` int NOT NULL AUTO_INCREMENT COMMENT '运输id',
  `user_id` int NULL DEFAULT NULL COMMENT '接收用户id',
  `material_id` int NULL DEFAULT NULL COMMENT '要运输的物资id',
  `quantity` int NULL DEFAULT NULL COMMENT '物资数量',
  `destination` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '目的地',
  `transport_status` enum('Transporting','Arrived','Assign') CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '运输状态',
  `start_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '订单开始时间',
  `end_time` datetime NULL DEFAULT NULL COMMENT '订单结束时间',
  `driver_id` int NULL DEFAULT NULL COMMENT '司机id',
  PRIMARY KEY (`transport_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 50 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of transport_info
-- ----------------------------
INSERT INTO `transport_info` VALUES (40, 163, 1, 1, '家', 'Arrived', '2024-05-05 01:26:31', '2024-05-05 01:27:12', 158);
INSERT INTO `transport_info` VALUES (41, 163, 2, 1, '家', 'Arrived', '2024-05-05 10:39:29', '2024-05-05 10:43:25', 158);
INSERT INTO `transport_info` VALUES (42, 163, 3, 2, '家', 'Transporting', '2024-05-05 10:39:31', NULL, 186);
INSERT INTO `transport_info` VALUES (43, 163, 10, 4, '家', 'Arrived', '2024-05-05 10:39:34', '2024-05-05 10:43:27', 158);
INSERT INTO `transport_info` VALUES (44, 163, 11, 1, '家', 'Arrived', '2024-05-05 10:45:14', '2024-05-05 10:45:46', 158);
INSERT INTO `transport_info` VALUES (45, 163, 10, 1, '家', 'Transporting', '2024-05-05 10:50:05', NULL, 186);
INSERT INTO `transport_info` VALUES (46, 163, 10, 2, '家', 'Arrived', '2024-05-05 10:50:33', '2024-05-05 10:50:57', 158);
INSERT INTO `transport_info` VALUES (47, 163, 12, 1, '家', 'Arrived', '2024-05-05 10:53:26', '2024-05-05 10:54:49', 158);
INSERT INTO `transport_info` VALUES (48, 163, 3, 3, '家', 'Assign', '2024-05-05 11:08:58', NULL, NULL);
INSERT INTO `transport_info` VALUES (49, 163, 3, 1, '家', 'Assign', '2024-05-05 12:00:49', NULL, NULL);

-- ----------------------------
-- Table structure for usage_record
-- ----------------------------
DROP TABLE IF EXISTS `usage_record`;
CREATE TABLE `usage_record`  (
  `usage_record_id` int NOT NULL AUTO_INCREMENT COMMENT '使用记录id',
  `material_id` int NULL DEFAULT NULL COMMENT '物资id',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `record_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '记录时间',
  `usage_quantity` int NULL DEFAULT NULL COMMENT '使用的数量',
  `quantity_before_application` int NULL DEFAULT NULL COMMENT '申请使用之前的仓库数量',
  `usage_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '使用原因',
  `transport_id` int NULL DEFAULT NULL COMMENT '运输单号',
  PRIMARY KEY (`usage_record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 109 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of usage_record
-- ----------------------------
INSERT INTO `usage_record` VALUES (99, 1, 163, '2024-05-05 01:26:31', 1, 959, '1', 40);
INSERT INTO `usage_record` VALUES (100, 2, 163, '2024-05-05 10:39:29', 1, 445, '1', 41);
INSERT INTO `usage_record` VALUES (101, 3, 163, '2024-05-05 10:39:31', 2, 165, '3', 42);
INSERT INTO `usage_record` VALUES (102, 10, 163, '2024-05-05 10:39:34', 4, 29, '4', 43);
INSERT INTO `usage_record` VALUES (103, 11, 163, '2024-05-05 10:45:14', 1, 17, '2', 44);
INSERT INTO `usage_record` VALUES (104, 10, 163, '2024-05-05 10:50:05', 1, 25, '1', 45);
INSERT INTO `usage_record` VALUES (105, 10, 163, '2024-05-05 10:50:33', 2, 24, '2', 46);
INSERT INTO `usage_record` VALUES (106, 12, 163, '2024-05-05 10:53:26', 1, 1, '1', 47);
INSERT INTO `usage_record` VALUES (107, 3, 163, '2024-05-05 11:08:58', 3, 163, '553342', 48);
INSERT INTO `usage_record` VALUES (108, 3, 163, '2024-05-05 12:00:49', 1, 160, '1', 49);

-- ----------------------------
-- Table structure for user_info
-- ----------------------------
DROP TABLE IF EXISTS `user_info`;
CREATE TABLE `user_info`  (
  `user_id` int NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户密码',
  `role` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'User' COMMENT '用户身份',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '电话',
  `address` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '地址',
  `unit_info` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL,
  `create_time` timestamp NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '创建时间',
  `avatarurl` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '头像url',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 188 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (157, '马秀影', '111111', 'Admin', '666666699999', '1601', '哈尔滨', NULL, '2024-04-18 10:34:54', 'http://localhost:9090/file/6bf52a77e32f4e84b4bfbe50dc604a1c.jpg');
INSERT INTO `user_info` VALUES (158, 'GGBond', '22222', 'Driver', 'GGBond@qq.com', '110110', '羊村', NULL, '2024-04-18 11:29:39', 'http://localhost:9090/file/cae480eabd48428fae01145522a30140.jpeg');
INSERT INTO `user_info` VALUES (163, '薯仔', '22222', 'Rescue_Workers', '薯仔@qq.com', '110110', '家', NULL, '2024-10-01 15:24:18', 'http://localhost:9090/file/f05355672ecc4f07b6366e0c85ff95c7.jpg');
INSERT INTO `user_info` VALUES (184, '小灰灰', '2222', 'Rescue_Workers', '小灰灰@qq.com', '123456', '狼堡', NULL, '2024-04-27 13:00:28', 'http://localhost:9090/file/233d3d7f22e54cc1b1a0c4df18397d1a.jpeg');
INSERT INTO `user_info` VALUES (186, 'Anya', '111111', 'Driver', 'Anya@spy.com', '666666', '东人民共和国首都巴林特公园路128号公寓', NULL, '2024-05-31 08:00:00', 'http://localhost:9090/file/6197336eb7f94f72af2a762bd18a0a63.jpeg');
INSERT INTO `user_info` VALUES (187, '宇智波斑', '999999', 'Rescue_Workers', 'madala@qq.com', '888888', '木叶村', NULL, '2023-05-10 08:00:00', 'http://localhost:9090/file/0a863f96b10c456a8b30a5abd39ee43f.jpeg');

-- ----------------------------
-- Table structure for user_material
-- ----------------------------
DROP TABLE IF EXISTS `user_material`;
CREATE TABLE `user_material`  (
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `material_id` int NULL DEFAULT NULL COMMENT '物资id',
  `quantity` int NULL DEFAULT NULL COMMENT '拥有的数量'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_material
-- ----------------------------
INSERT INTO `user_material` VALUES (163, 1, 0);
INSERT INTO `user_material` VALUES (163, 2, 1);
INSERT INTO `user_material` VALUES (163, 10, 5);
INSERT INTO `user_material` VALUES (163, 11, 1);
INSERT INTO `user_material` VALUES (163, 12, 1);

-- ----------------------------
-- Table structure for user_usage_record
-- ----------------------------
DROP TABLE IF EXISTS `user_usage_record`;
CREATE TABLE `user_usage_record`  (
  `user_usage_record_id` int NOT NULL AUTO_INCREMENT COMMENT '用户使用记录',
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `material_id` int NULL DEFAULT NULL COMMENT '物资id',
  `record_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '记录时间',
  `user_usage_quantity` int NULL DEFAULT NULL COMMENT '用户使用数量',
  `quantity_before_use` int NULL DEFAULT NULL COMMENT '使用前个人仓库数量',
  `usage_reason` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '用户使用原因',
  PRIMARY KEY (`user_usage_record_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user_usage_record
-- ----------------------------
INSERT INTO `user_usage_record` VALUES (18, 163, 1, '2024-05-05 01:33:10', 1, 1, '1');
INSERT INTO `user_usage_record` VALUES (19, 163, 10, '2024-05-05 10:57:39', 1, 6, '1');

SET FOREIGN_KEY_CHECKS = 1;
