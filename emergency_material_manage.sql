/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80036 (8.0.36)
 Source Host           : localhost:3306
 Source Schema         : emergency_material_manage

 Target Server Type    : MySQL
 Target Server Version : 80036 (8.0.36)
 File Encoding         : 65001

 Date: 05/09/2024 21:33:37
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
) ENGINE = InnoDB AUTO_INCREMENT = 6 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of apply_info
-- ----------------------------
INSERT INTO `apply_info` VALUES (1, 163, 1, 3, 'Transporting', '2024-09-05 18:34:44', '感冒了', '2024-09-05 20:34:04', '已分配到司机，GGBond正在运输中', '家', 58);
INSERT INTO `apply_info` VALUES (2, 163, 11, 1, 'Approved', '2024-09-05 20:34:46', '迷路了', '2024-09-05 20:35:10', '已通过审批，等待运输分配司机中', '沙漠', 59);
INSERT INTO `apply_info` VALUES (3, 163, 3, 1, 'Rejected', '2024-09-05 20:35:33', '玩', '2024-09-05 20:36:17', '请以正当理由申请物资', '家', NULL);
INSERT INTO `apply_info` VALUES (4, 163, 10, 1, 'Pending', '2024-09-05 20:36:58', '监控家', NULL, NULL, '家', NULL);
INSERT INTO `apply_info` VALUES (5, 163, 2, 2, 'Completed', '2024-09-05 20:43:01', '家里着火啦', '2024-09-05 20:43:19', 'Anya已到达，运输完成，到达时间：2024-09-05T20:43:41.419', '家', 60);

-- ----------------------------
-- Table structure for dict_info
-- ----------------------------
DROP TABLE IF EXISTS `dict_info`;
CREATE TABLE `dict_info`  (
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '名称',
  `value` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '内容',
  `type` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '类型'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 7 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of file_info
-- ----------------------------

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
) ENGINE = InnoDB AUTO_INCREMENT = 14 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of material_info
-- ----------------------------
INSERT INTO `material_info` VALUES (1, '口罩', 'Protection', 949, 'https://img0.baidu.com/it/u=272206660,3551480946&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500', '2024-04-26', '2025-04-27', 'Available', 10);
INSERT INTO `material_info` VALUES (2, '灭火器', 'Fire_Rescue', 442, 'https://ts1.cn.mm.bing.net/th/id/R-C.78c6f879878cfe42a9889e47250727f0?rik=pnEs1tNolKI%2b3w&riu=http%3a%2f%2fywxf119.com%2fApp%2fTpl%2fHome%2fUploads%2f5c4978d81484a.jpg&ehk=5YmU7CGqtp%2beTts9wU4z%2fbsOFQ4j166Vkvt7fQ92nB8%3d&risl=&pid=ImgRaw&r=0', '2024-04-18', '2025-05-30', 'Available', 10);
INSERT INTO `material_info` VALUES (3, '呼吸机', 'Medical', 158, 'https://img0.baidu.com/it/u=2118588821,504418275&fm=253&fmt=auto&app=138&f=JPEG?w=375&h=500', '2024-03-19', '2024-06-13', 'Available', 10);
INSERT INTO `material_info` VALUES (10, '报警装备', 'Alarm', 19, 'https://th.bing.com/th/id/OIP.uIA8v3fYinId5cnQWWPIqAHaEw?rs=1&pid=ImgDetMain', '2024-05-03', '2025-05-01', 'Available', 10);
INSERT INTO `material_info` VALUES (11, '卫星通讯装备', 'Communication', 15, 'https://th.bing.com/th/id/R.0e590e4c61a97f09f9c2c7249747985e?rik=fSm33P%2foIJkNSg&riu=http%3a%2f%2fwww.nstarlink.com%2fresources%2fupload%2fa3328a4571a9ca7%2f1666690557288.jpeg&ehk=4fQNs7oIxxoVSZw9mQQfiwLIsAEBCpqHfeSap3b8fmg%3d&risl=&pid=ImgRaw&r=0', '2024-05-22', '2025-05-22', 'Available', 10);

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
) ENGINE = InnoDB AUTO_INCREMENT = 80 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 20 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of message_info
-- ----------------------------
INSERT INTO `message_info` VALUES (1, 188, '新的申请', '用户 薯仔 申请了 3 个 口罩 ，请尽快审批', '2024-09-05 18:34:44', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (2, 163, '申请信息发送成功', '您申请了 3 个 口罩 ，请等待管理员审批', '2024-09-05 18:34:44', 'NO', 'Info');
INSERT INTO `message_info` VALUES (3, 163, '申请通过', '您申请的 口罩 已通过审批，等待运输分配司机中', '2024-09-05 20:34:04', 'NO', 'Success');
INSERT INTO `message_info` VALUES (4, 158, '新的运输任务', '您有一条新的运输任务，物资：口罩，数量：3，请尽快运输', '2024-09-05 20:34:13', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (5, 163, '已分配到司机', '您的运输任务已分配到司机，GGBond 司机正在努力运输中', '2024-09-05 20:34:13', 'NO', 'Info');
INSERT INTO `message_info` VALUES (6, 188, '新的申请', '用户 薯仔 申请了 1 个 卫星通讯装备 ，请尽快审批', '2024-09-05 20:34:46', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (7, 163, '申请信息发送成功', '您申请了 1 个 卫星通讯装备 ，请等待管理员审批', '2024-09-05 20:34:46', 'NO', 'Info');
INSERT INTO `message_info` VALUES (8, 163, '申请通过', '您申请的 卫星通讯装备 已通过审批，等待运输分配司机中', '2024-09-05 20:35:10', 'NO', 'Success');
INSERT INTO `message_info` VALUES (9, 188, '新的申请', '用户 薯仔 申请了 1 个 呼吸机 ，请尽快审批', '2024-09-05 20:35:33', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (10, 163, '申请信息发送成功', '您申请了 1 个 呼吸机 ，请等待管理员审批', '2024-09-05 20:35:33', 'NO', 'Info');
INSERT INTO `message_info` VALUES (11, 163, '申请被拒绝', '您申请的 呼吸机 已被管理员拒绝', '2024-09-05 20:36:17', 'NO', 'Error');
INSERT INTO `message_info` VALUES (12, 188, '新的申请', '用户 薯仔 申请了 1 个 报警装备 ，请尽快审批', '2024-09-05 20:36:58', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (13, 163, '申请信息发送成功', '您申请了 1 个 报警装备 ，请等待管理员审批', '2024-09-05 20:36:58', 'NO', 'Info');
INSERT INTO `message_info` VALUES (14, 188, '新的申请', '用户 薯仔 申请了 2 个 灭火器 ，请尽快审批', '2024-09-05 20:43:01', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (15, 163, '申请信息发送成功', '您申请了 2 个 灭火器 ，请等待管理员审批', '2024-09-05 20:43:01', 'NO', 'Info');
INSERT INTO `message_info` VALUES (16, 163, '申请通过', '您申请的 灭火器 已通过审批，等待运输分配司机中', '2024-09-05 20:43:19', 'NO', 'Success');
INSERT INTO `message_info` VALUES (17, 186, '新的运输任务', '您有一条新的运输任务，物资：灭火器，数量：2，请尽快运输', '2024-09-05 20:43:26', 'NO', 'Emergency');
INSERT INTO `message_info` VALUES (18, 163, '已分配到司机', '您的运输任务已分配到司机，Anya 司机正在努力运输中', '2024-09-05 20:43:26', 'NO', 'Info');
INSERT INTO `message_info` VALUES (19, 163, '运输完成', '您的运输任务已完成，Anya 司机已到达。', '2024-09-05 20:43:41', 'NO', 'Success');

-- ----------------------------
-- Table structure for role_info
-- ----------------------------
DROP TABLE IF EXISTS `role_info`;
CREATE TABLE `role_info`  (
  `id` int NOT NULL AUTO_INCREMENT COMMENT 'id',
  `rolename` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '角色名称',
  `description` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '描述',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10091 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

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
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of transport_info
-- ----------------------------
INSERT INTO `transport_info` VALUES (58, 163, 1, 3, '家', 'Transporting', '2024-09-05 20:34:04', NULL, 158);
INSERT INTO `transport_info` VALUES (59, 163, 11, 1, '沙漠', 'Assign', '2024-09-05 20:35:10', NULL, NULL);
INSERT INTO `transport_info` VALUES (60, 163, 2, 2, '家', 'Arrived', '2024-09-05 20:43:19', '2024-09-05 20:43:41', 186);

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
) ENGINE = InnoDB AUTO_INCREMENT = 4 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of usage_record
-- ----------------------------
INSERT INTO `usage_record` VALUES (1, 1, 163, '2024-09-05 20:34:04', 3, 952, '感冒了', 58);
INSERT INTO `usage_record` VALUES (2, 11, 163, '2024-09-05 20:35:10', 1, 16, '迷路了', 59);
INSERT INTO `usage_record` VALUES (3, 2, 163, '2024-09-05 20:43:19', 2, 444, '家里着火啦', 60);

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
) ENGINE = InnoDB AUTO_INCREMENT = 189 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_info
-- ----------------------------
INSERT INTO `user_info` VALUES (158, 'GGBond', '22222', 'Driver', 'GGBond@qq.com', '110110', '羊村', NULL, '2024-09-05 20:50:54', 'https://pic1.zhimg.com/v2-a04532b39df49498f5725e898a40d8c4_r.jpg');
INSERT INTO `user_info` VALUES (163, '薯仔', '22222', 'Rescue_Workers', '薯仔@qq.com', '110110', '家', NULL, '2024-09-05 21:12:35', 'https://github.com/Ashesttt/Ashesttt.github.io/blob/main/images/shuzai.jpg?raw=true');
INSERT INTO `user_info` VALUES (186, 'Anya', '111111', 'Driver', 'Anya@spy.com', '666666', '东人民共和国首都巴林特公园路128号公寓', NULL, '2024-09-05 20:49:02', 'https://th.bing.com/th/id/OIP.FAAvMYvVuxw0UrueHwHcKgHaHa?rs=1&pid=ImgDetMain');
INSERT INTO `user_info` VALUES (188, 'admin', 'admin', 'Admin', 'admin@qq.com', '888888', '北京市', NULL, '2024-09-05 20:49:03', 'https://th.bing.com/th/id/R.4502189e221de05b7a269dcdd1783dd8?rik=wCdKOgr3Lv4UDA&riu=http%3a%2f%2fn.sinaimg.cn%2fsinacn08%2f272%2fw1152h720%2f20180807%2f7ede-hhkusks8050034.jpg&ehk=9WT0eyfXvjPvAP6cYg6MdImLBj7%2bfDgX5MuASG8FnTo%3d&risl=&pid=ImgRaw&r=0');

-- ----------------------------
-- Table structure for user_material
-- ----------------------------
DROP TABLE IF EXISTS `user_material`;
CREATE TABLE `user_material`  (
  `user_id` int NULL DEFAULT NULL COMMENT '用户id',
  `material_id` int NULL DEFAULT NULL COMMENT '物资id',
  `quantity` int NULL DEFAULT NULL COMMENT '拥有的数量'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_material
-- ----------------------------
INSERT INTO `user_material` VALUES (163, 2, 2);

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
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of user_usage_record
-- ----------------------------

SET FOREIGN_KEY_CHECKS = 1;
