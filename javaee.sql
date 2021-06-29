/*
 Navicat Premium Data Transfer

 Source Server         : Anchovy
 Source Server Type    : MySQL
 Source Server Version : 50734
 Source Host           : localhost:3306
 Source Schema         : javaee

 Target Server Type    : MySQL
 Target Server Version : 50734
 File Encoding         : 65001

 Date: 14/06/2021 13:10:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for activity
-- ----------------------------
DROP TABLE IF EXISTS `activity`;
CREATE TABLE `activity`  (
  `activityId` int(11) NOT NULL AUTO_INCREMENT,
  `activityRange` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityIntroduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityStartTime` datetime(0) NOT NULL,
  `activityEndTime` datetime(0) NOT NULL,
  `activityReleaseTime` datetime(0) NOT NULL,
  `activityDeadLine` datetime(0) NOT NULL,
  `activityPalce` int(11) NOT NULL,
  `associationsId` int(11) NOT NULL,
  `departmentId` int(11) NOT NULL,
  `activitiesApplicationTime` datetime(0) NOT NULL,
  `activitiesApplicationState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`activityId`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  INDEX `activityPalce`(`activityPalce`) USING BTREE,
  CONSTRAINT `activity_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `activity_ibfk_2` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `activity_ibfk_3` FOREIGN KEY (`activityPalce`) REFERENCES `palce` (`palceId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 39 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activity
-- ----------------------------
INSERT INTO `activity` VALUES (27, '全校', '下周打篮球比赛', '来来来', '2021-06-04 00:00:01', '2021-06-08 00:00:00', '2021-06-01 20:25:17', '2021-06-02 00:00:00', 2, 25, 999999, '2020-06-01 20:16:31', '审核通过');
INSERT INTO `activity` VALUES (28, '社团', '篮球社开会', '来', '2021-06-04 00:00:01', '2021-06-08 00:00:00', '2021-06-01 20:17:18', '2021-06-02 00:00:00', 5, 25, 999999, '2020-06-01 20:17:18', '审核通过');
INSERT INTO `activity` VALUES (29, '社团', '操场跑步', '来', '2021-06-04 00:00:01', '2021-06-08 00:00:00', '2021-06-01 20:19:52', '2021-06-02 00:00:00', 3, 25, 999999, '2020-06-01 20:19:52', '审核通过');
INSERT INTO `activity` VALUES (30, '社团', '聚餐', '聚餐,是最容易促进社团成员彼此之间的感情的一个契机,通过聚餐来拉近彼此的距离,加强沟通。下周一的聚餐，请大家积极参加。', '2021-06-10 00:00:01', '2021-06-11 00:00:00', '2021-06-01 23:18:24', '2021-06-10 00:00:00', 1, 27, 999999, '2020-06-01 23:18:24', '审核通过');
INSERT INTO `activity` VALUES (31, '全校', '演讲', '目的：推广电竞活动。\n时间：2020.6.29 \n地点：风雨操场', '2021-06-28 00:00:01', '2021-06-29 00:00:00', '2021-06-01 23:20:12', '2021-06-28 00:00:00', 4, 27, 999999, '2020-06-01 23:20:12', '审核拒绝');
INSERT INTO `activity` VALUES (32, '全校', '爱心募捐', '为山区留守儿童献爱心。', '2021-06-04 00:00:01', '2021-06-13 00:00:00', '2021-06-03 15:09:39', '2021-06-03 00:00:00', 4, 30, 999999, '2020-06-03 15:04:28', '审核通过');
INSERT INTO `activity` VALUES (33, '全校', '花式篮球', '花式篮球大赛开始啦，奖励多多！', '2021-06-06 00:00:01', '2021-06-10 00:00:00', '2021-06-03 15:24:19', '2021-06-06 00:00:00', 6, 25, 999999, '2020-06-03 15:24:19', '等待审核');
INSERT INTO `activity` VALUES (35, '全校', '植树', '绿化校园', '2021-06-03 23:40:16', '2021-06-10 15:40:23', '2021-06-07 19:42:34', '2021-06-03 22:40:06', 7, 30, 999999, '2020-06-03 15:45:07', '审核通过');
INSERT INTO `activity` VALUES (36, '全校', '第一次心理讲座', '三天后教3心理讲座， 欢迎大家报名', '2021-06-07 22:48:18', '2021-06-11 22:48:20', '2021-06-07 19:42:31', '2021-06-07 22:48:22', 8, 34, 999999, '2020-06-04 22:48:50', '审核通过');
INSERT INTO `activity` VALUES (37, '全校', '篮球比赛', '篮球比赛', '2021-06-08 09:15:24', '2021-06-12 09:15:06', '2021-06-05 09:15:55', '2021-06-08 09:15:25', 6, 25, 999999, '2020-06-05 09:15:34', '审核通过');
INSERT INTO `activity` VALUES (38, '全校', '第一次集会', '快来呀', '2021-06-24 08:53:12', '2021-06-30 00:00:00', '2021-06-14 08:53:58', '2021-06-22 00:00:00', 1, 36, 999999, '2021-06-14 08:53:45', '审核通过');

-- ----------------------------
-- Table structure for activitysign
-- ----------------------------
DROP TABLE IF EXISTS `activitysign`;
CREATE TABLE `activitysign`  (
  `activitySignId` int(11) NOT NULL AUTO_INCREMENT,
  `studentSignTime` datetime(0) NOT NULL,
  `activitySignState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `activityId` int(11) NOT NULL,
  PRIMARY KEY (`activitySignId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `activityId`(`activityId`) USING BTREE,
  CONSTRAINT `activitysign_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `activitysign_ibfk_2` FOREIGN KEY (`activityId`) REFERENCES `activity` (`activityId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of activitysign
-- ----------------------------
INSERT INTO `activitysign` VALUES (6, '2021-06-01 20:20:51', '审核通过', '0', 28);
INSERT INTO `activitysign` VALUES (7, '2021-06-01 23:55:32', '审核通过', '0', 27);
INSERT INTO `activitysign` VALUES (8, '2021-06-01 23:59:44', '审核通过', '0', 27);
INSERT INTO `activitysign` VALUES (9, '2021-06-05 09:16:33', '审核通过', '0', 37);
INSERT INTO `activitysign` VALUES (10, '2021-06-07 19:38:58', '审核通过', '31801341', 37);
INSERT INTO `activitysign` VALUES (11, '2021-06-14 09:30:23', '审核通过', '31801341', 38);

-- ----------------------------
-- Table structure for associations
-- ----------------------------
DROP TABLE IF EXISTS `associations`;
CREATE TABLE `associations`  (
  `associationsId` int(11) NOT NULL AUTO_INCREMENT,
  `associationsName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsTime` datetime(0) NOT NULL,
  `associationsType` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsIntroduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsNumber` int(11) NOT NULL,
  `associationsLeader` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsApplicationTime` datetime(0) NOT NULL,
  `associationsApplicationState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`associationsId`) USING BTREE,
  INDEX `associationsLeader`(`associationsLeader`) USING BTREE,
  CONSTRAINT `associations_ibfk_1` FOREIGN KEY (`associationsLeader`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 37 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of associations
-- ----------------------------
INSERT INTO `associations` VALUES (25, '篮球社', '2021-06-01 17:41:47', '体育类', '篮球（basketball），是奥运会核心比赛项目，是以手为中心的身体对抗性体育运动。篮球运动是1891年由美国人詹姆斯·奈史密斯发明的。当时，他在马萨诸塞州斯普林菲尔德基督教青年会国际训练学校任教。由于当地盛产桃子，这里的儿童又非常喜欢玩将球投入桃子筐的游戏。这使他从中得到启发，并博采足球、曲棍球等其他球类项目的特点，创编了篮球游戏。', 2, '31801341', '2021-06-01 17:40:14', '审核通过');
INSERT INTO `associations` VALUES (26, '学习会', '2021-06-01 17:41:50', '学术类', '学习，是指通过阅读、听讲、思考、研究、实践等途径获得知识和技能的过程。学习分为狭义与广义两种：\n狭义：通过阅读、听讲、研究、观察、理解、探索、实验、实践等手段获得知识或技能的过程，是一种使个体可以得到持续变化（知识和技能，方法与过程，情感与价值的改善和升华）的行为方式。例如通过学校教育获得知识的过程。\n广义：是人在生活过程中，通过获得经验而产生的行为或行为潜能的相对持久的行为方式。', 1, '31801327', '2021-06-01 17:41:29', '审核通过');
INSERT INTO `associations` VALUES (27, '电竞社', '2021-06-01 23:08:43', '体育类', '电子竞技（Electronic Sports）是电子游戏比赛达到“竞技”层面的体育项目。电子竞技运动就是利用电子设备作为运动器械进行的、人与人之间的智力对抗运动。通过运动，可以锻炼和提高参与者的思维能力、反应能力、四肢协调能力和意志力，培养团队精神。电子竞技也是一种职业，和棋艺等非电子游戏比赛类似。', 1, '31801338', '2021-06-01 23:04:57', '审核通过');
INSERT INTO `associations` VALUES (28, '轮滑团', '2021-06-03 13:50:22', '体育类', '轮滑（Roller skating），有很多汉化版本叫法，如旱冰、溜冰、滑冰、滚轴溜冰，但是到现在，统一叫轮滑，但并不否定之前的叫法，因为这些都是正确的。\n轮滑是很棒的代步工具，如果选对了类型，双排轮滑（quad roller skating）和单排轮滑（inline roller skating）都是可以刷街的，但是双排轮滑轮子直径较小，而且硬度高，对路面的容忍度较差，想要舒服的刷街需要换专门的', 1, '31801340', '2021-06-01 23:05:35', '审核通过');
INSERT INTO `associations` VALUES (29, 'Google', '2021-06-03 13:50:23', '科技类', 'Google实验室', 1, '31801340', '2021-06-01 23:59:14', '审核通过');
INSERT INTO `associations` VALUES (30, '公益爱心', '2021-06-03 13:50:26', '公益类', '爱心社团是表现爱心的一种介质,尤其是在大学里能够培养大学生的良好的素质,培养个人的良好习惯,尤其是培养责任心的一个组织。', 1, '31801341', '2021-06-03 13:47:57', '审核通过');
INSERT INTO `associations` VALUES (31, '高数协会', '2021-06-03 13:50:25', '学术类', '作为一门基础科学，高等数学有其固有的特点，这就是高度的抽象性、严密的逻辑性和广泛的应用性。', 1, '31801327', '2021-06-03 13:50:06', '审核通过');
INSERT INTO `associations` VALUES (32, '吉他社', '2021-06-03 15:35:05', '艺术类', '吉他（意大利语：Chitarra），又译为结他或六弦琴。是一种弹拨乐器，通常有六条弦，形状与提琴相似。\n吉他在流行音乐、摇滚音乐、蓝调、民歌、佛朗明哥中，常被视为主要乐器。而在古典音乐的领域里，吉他常以独奏或二重奏的型式演出；当然，在室内乐和管弦乐中，吉他亦扮演着相当程度的陪衬角色。\n古典吉他与小提琴、钢琴并列为世界著名三大乐器。', 1, '31801338', '2021-06-03 15:14:51', '审核通过');
INSERT INTO `associations` VALUES (33, '网球社', '2021-06-03 15:45:34', '体育类', '网球运动是一种球类运动，通常在两个单打球员或两对组合之间进行。球员在网球场上隔着球网用网球拍击打网球。网球运动的由来和发展可以用四句话来概括：孕育在法国，诞生在英国，开始普及和形成高潮在美国，盛行全世界，被称为世界第二大球。', 1, '31801338', '2021-06-03 15:37:31', '审核通过');
INSERT INTO `associations` VALUES (34, '心理协会', '2021-06-04 22:45:57', '公益类', '关注心理问题， 培养良好心态', 1, '31801341', '2021-06-04 22:45:06', '审核通过');
INSERT INTO `associations` VALUES (36, '色图分享社', '2021-06-14 08:52:01', '科技类', '弘扬中华传统美德', 1, '31801341', '2021-06-14 08:51:11', '审核通过');

-- ----------------------------
-- Table structure for collectpost
-- ----------------------------
DROP TABLE IF EXISTS `collectpost`;
CREATE TABLE `collectpost`  (
  `collectPostId` int(11) NOT NULL AUTO_INCREMENT,
  `collectPostTime` datetime(0) NOT NULL,
  `subjectPostId` int(11) NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`collectPostId`) USING BTREE,
  INDEX `subjectPostId`(`subjectPostId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `collectpost_ibfk_1` FOREIGN KEY (`subjectPostId`) REFERENCES `subjectpost` (`subjectPostId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `collectpost_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of collectpost
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department`  (
  `departmentId` int(11) NOT NULL AUTO_INCREMENT,
  `departmentName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `departmentLeader` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsId` int(11) NOT NULL,
  PRIMARY KEY (`departmentId`) USING BTREE,
  INDEX `departmentLeader`(`departmentLeader`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  CONSTRAINT `department_ibfk_1` FOREIGN KEY (`departmentLeader`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `department_ibfk_2` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1000000 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES (1, '0', '0', 0);
INSERT INTO `department` VALUES (999999, '管理员', '0', 0);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS `log`;
CREATE TABLE `log`  (
  `logId` int(11) NOT NULL AUTO_INCREMENT,
  `logName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`logId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of log
-- ----------------------------

-- ----------------------------
-- Table structure for manager
-- ----------------------------
DROP TABLE IF EXISTS `manager`;
CREATE TABLE `manager`  (
  `managerId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `managerPwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `managerName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `managerPalce` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `managerTel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`managerId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of manager
-- ----------------------------
INSERT INTO `manager` VALUES ('admin', '21232f297a57a5a743894a0e4a801fc3', '0', '0', '0');

-- ----------------------------
-- Table structure for member
-- ----------------------------
DROP TABLE IF EXISTS `member`;
CREATE TABLE `member`  (
  `memberId` int(11) NOT NULL AUTO_INCREMENT,
  `memberPost` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `memberTime` datetime(0) NOT NULL,
  `memberIntroduction` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsId` int(11) NOT NULL,
  `departmentId` int(11) NOT NULL,
  PRIMARY KEY (`memberId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  CONSTRAINT `member_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_ibfk_2` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `member_ibfk_3` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 30 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of member
-- ----------------------------
INSERT INTO `member` VALUES (14, '社长', '2021-06-01 17:41:47', 'Leader', '31801327', 25, 999999);
INSERT INTO `member` VALUES (15, '社长', '2021-06-01 17:41:50', 'Leader', '31801327', 26, 999999);
INSERT INTO `member` VALUES (16, '社员', '2021-06-01 20:26:30', '这是个人介绍', '31801341', 25, 999999);
INSERT INTO `member` VALUES (17, '社长', '2021-06-01 23:08:43', 'Leader', '31801338', 27, 999999);
INSERT INTO `member` VALUES (18, '社长', '2021-06-03 13:50:22', 'Leader', '31801340', 28, 999999);
INSERT INTO `member` VALUES (19, '社长', '2021-06-03 13:50:23', 'Leader', '31801327', 29, 999999);
INSERT INTO `member` VALUES (20, '社长', '2021-06-03 13:50:25', 'Leader', '31801340', 31, 999999);
INSERT INTO `member` VALUES (21, '社长', '2021-06-03 13:50:26', 'Leader', '31801338', 30, 999999);
INSERT INTO `member` VALUES (22, '社长', '2021-06-03 15:26:12', 'Leader', '31801341', 32, 999999);
INSERT INTO `member` VALUES (27, '社长', '2021-06-03 15:45:34', 'Leader', '31801338', 33, 999999);
INSERT INTO `member` VALUES (28, '社长', '2021-06-04 22:45:57', 'Leader', '31801341', 34, 999999);
INSERT INTO `member` VALUES (29, '社长', '2021-06-14 08:52:01', 'Leader', '31801341', 36, 999999);

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `noticeId` int(11) NOT NULL AUTO_INCREMENT,
  `noticeRange` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `noticeName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `noticeContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `noticeTime` datetime(0) NOT NULL,
  `associationsId` int(11) NOT NULL,
  `departmentId` int(11) NOT NULL,
  `noticeState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`noticeId`) USING BTREE,
  INDEX `departmentId`(`departmentId`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  CONSTRAINT `notice_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`departmentId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `notice_ibfk_2` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 61 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (49, '全校', '篮球社明天招新', '篮球社明天招新， 来来来', '2021-06-01 17:51:05', 25, 999999, '审核通过');
INSERT INTO `notice` VALUES (50, '全社', '篮球社内部聚餐', '来来来', '2021-06-01 20:04:43', 25, 999999, '审核通过');
INSERT INTO `notice` VALUES (51, '全校', '系统维护', '今晚系统维护， 9-10点', '2021-06-01 20:25:43', 0, 999999, '审核通过');
INSERT INTO `notice` VALUES (52, '全社', '即将举行社长选举', '我们社团即将举行社长选举，时间预计为半个月后，具体时间另行通知，请有意向的社员做好充足准备。', '2021-06-01 23:16:10', 27, 999999, '审核通过');
INSERT INTO `notice` VALUES (53, '全校', '失物招领', '有一同学在教三，捡到一个棕色钱包。请速来认领。', '2021-06-01 23:24:36', 27, 999999, '审核通过');
INSERT INTO `notice` VALUES (54, '全校', '疫情防控', '请同学们自觉佩戴控制，勤洗手，勤通风，做好疫情防控措施。', '2021-06-03 13:52:03', 0, 999999, '审核通过');
INSERT INTO `notice` VALUES (55, '全社', 'Google融资', 'Google融资成功', '2021-06-03 15:10:23', 29, 999999, '审核通过');
INSERT INTO `notice` VALUES (56, '全校', '学习会开始招新', '学习会开始招新', '2021-06-03 15:25:49', 26, 999999, '等待审核');
INSERT INTO `notice` VALUES (57, '全校', '下周数学讲座', '下周数学讲座， 有二课分', '2021-06-04 22:46:42', 0, 999999, '审核通过');
INSERT INTO `notice` VALUES (58, '全校', '心理社创建', '心理社正式成立，欢迎大家踊跃报名', '2021-06-04 22:47:54', 34, 999999, '审核拒绝');
INSERT INTO `notice` VALUES (59, '全校', '心理社创建', '心理社创建， 欢迎大叫报名', '2021-06-06 22:49:56', 34, 999999, '审核通过');
INSERT INTO `notice` VALUES (60, '全校', '招新啦', '大家快来报名啊', '2021-06-14 08:52:49', 36, 999999, '等待审核');

-- ----------------------------
-- Table structure for palce
-- ----------------------------
DROP TABLE IF EXISTS `palce`;
CREATE TABLE `palce`  (
  `palceId` int(11) NOT NULL AUTO_INCREMENT,
  `palceName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `palceState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`palceId`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of palce
-- ----------------------------
INSERT INTO `palce` VALUES (1, '理四1楼大教室', '室内');
INSERT INTO `palce` VALUES (2, '南校操场', '室外');
INSERT INTO `palce` VALUES (3, '北校操场', '室外');
INSERT INTO `palce` VALUES (4, '风雨操场', '室内');
INSERT INTO `palce` VALUES (5, '科技楼', '室内');
INSERT INTO `palce` VALUES (6, '篮球场', '室外');
INSERT INTO `palce` VALUES (7, '网球场', '室外');
INSERT INTO `palce` VALUES (8, '教3', '室内');
INSERT INTO `palce` VALUES (9, '教5', '室内');

-- ----------------------------
-- Table structure for recruitnotice
-- ----------------------------
DROP TABLE IF EXISTS `recruitnotice`;
CREATE TABLE `recruitnotice`  (
  `recruitNoticeId` int(11) NOT NULL AUTO_INCREMENT,
  `recruitNoticeContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recruitNoticeStartTime` datetime(0) NOT NULL,
  `recruitNoticeEndTime` datetime(0) NOT NULL,
  `recruitNoticeReleaseTime` datetime(0) NOT NULL,
  `associationsId` int(11) NOT NULL,
  PRIMARY KEY (`recruitNoticeId`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  CONSTRAINT `recruitnotice_ibfk_1` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 12 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitnotice
-- ----------------------------
INSERT INTO `recruitnotice` VALUES (5, '篮球社招新', '2021-06-02 00:00:00', '2021-06-24 00:00:00', '2021-06-01 17:50:32', 25);
INSERT INTO `recruitnotice` VALUES (6, '电竞社，气氛活跃，活动丰富，期待大家加入！', '2021-06-01 00:00:00', '2021-06-24 00:00:00', '2021-06-01 23:22:27', 27);
INSERT INTO `recruitnotice` VALUES (7, 'google实验室期待你的加入。', '2021-06-04 00:00:00', '2021-06-30 00:00:00', '2021-06-03 15:11:27', 29);
INSERT INTO `recruitnotice` VALUES (9, '在这里，你可以畅所欲言，结交新友，取长补短。期待你的加入。', '2021-06-04 00:00:00', '2021-06-30 00:00:00', '2021-06-03 15:25:12', 26);
INSERT INTO `recruitnotice` VALUES (10, '寻找你的音乐梦', '2021-06-03 00:00:00', '2021-06-30 00:00:00', '2021-06-03 15:49:03', 32);
INSERT INTO `recruitnotice` VALUES (11, '心理社招生， 欢迎大家报名', '2021-06-07 00:00:00', '2021-07-01 00:00:00', '2021-06-04 22:51:11', 34);

-- ----------------------------
-- Table structure for recruitsign
-- ----------------------------
DROP TABLE IF EXISTS `recruitsign`;
CREATE TABLE `recruitsign`  (
  `recruitSignId` int(11) NOT NULL AUTO_INCREMENT,
  `recruitSignTime` datetime(0) NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `associationsId` int(11) NOT NULL,
  `recruitSignContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `recruitSignApplicationState` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`recruitSignId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  INDEX `associationsId`(`associationsId`) USING BTREE,
  CONSTRAINT `recruitsign_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `recruitsign_ibfk_2` FOREIGN KEY (`associationsId`) REFERENCES `associations` (`associationsId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 13 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of recruitsign
-- ----------------------------
INSERT INTO `recruitsign` VALUES (3, '2021-06-01 20:24:23', '31801327', 25, '这是个人介绍', '审核通过');
INSERT INTO `recruitsign` VALUES (4, '2021-06-01 23:03:23', '31801338', 25, '这是个人介绍', '等待审核');
INSERT INTO `recruitsign` VALUES (6, '2021-06-01 23:31:28', '31801340', 27, '这是个人介绍', '等待审核');
INSERT INTO `recruitsign` VALUES (7, '2021-06-03 13:45:16', '31801338', 27, '我想入社', '等待审核');
INSERT INTO `recruitsign` VALUES (8, '2021-06-03 15:49:23', '31801341', 25, '这是个人介绍', '等待审核');
INSERT INTO `recruitsign` VALUES (10, '2021-06-04 22:44:00', '31801338', 31, '这是个人介绍', '等待审核');
INSERT INTO `recruitsign` VALUES (11, '2021-06-05 09:12:53', '31801340', 29, '我想入社', '等待审核');
INSERT INTO `recruitsign` VALUES (12, '2021-06-05 09:13:00', '31801340', 31, '我想入社', '等待审核');

-- ----------------------------
-- Table structure for replaytpost
-- ----------------------------
DROP TABLE IF EXISTS `replaytpost`;
CREATE TABLE `replaytpost`  (
  `replayPostId` int(11) NOT NULL AUTO_INCREMENT,
  `replayPostContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `replayPostTime` datetime(0) NOT NULL,
  `likeNum` int(11) NOT NULL,
  `subjectPostId` int(11) NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`replayPostId`) USING BTREE,
  INDEX `subjectPostId`(`subjectPostId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `replaytpost_ibfk_1` FOREIGN KEY (`subjectPostId`) REFERENCES `subjectpost` (`subjectPostId`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `replaytpost_ibfk_2` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of replaytpost
-- ----------------------------

-- ----------------------------
-- Table structure for subjectpost
-- ----------------------------
DROP TABLE IF EXISTS `subjectpost`;
CREATE TABLE `subjectpost`  (
  `subjectPostId` int(11) NOT NULL AUTO_INCREMENT,
  `subjectPostTitle` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subjectPostContent` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `subjectPostTime` datetime(0) NOT NULL,
  `collectNum` int(11) NOT NULL,
  `lookNum` int(11) NOT NULL,
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`subjectPostId`) USING BTREE,
  INDEX `userId`(`userId`) USING BTREE,
  CONSTRAINT `subjectpost_ibfk_1` FOREIGN KEY (`userId`) REFERENCES `user` (`userId`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB AUTO_INCREMENT = 1 CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of subjectpost
-- ----------------------------

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `userId` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userName` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userPwd` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userSex` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userMajor` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userClass` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  `userTel` varchar(255) CHARACTER SET utf8 COLLATE utf8_general_ci NOT NULL,
  PRIMARY KEY (`userId`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8 COLLATE = utf8_general_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES ('0', '0', 'cfcd208495d565ef66e7dff9f98764da', '0', '0', '0', '0');
INSERT INTO `user` VALUES ('31801327', '小徐', 'e10adc3949ba59abbe56e057f20f883e', '女', '软工', '软工1802', '18857533745');
INSERT INTO `user` VALUES ('31801338', '色图庄', 'e10adc3949ba59abbe56e057f20f883e', '男', '软工', '1802', '13429490334');
INSERT INTO `user` VALUES ('31801340', '杨某黑', 'e10adc3949ba59abbe56e057f20f883e', '男', '软工', '软件工程1802', '17306422238');
INSERT INTO `user` VALUES ('31801341', '童峻涛', 'e10adc3949ba59abbe56e057f20f883e', '男', '软工', '软工1802', '13588631227');

SET FOREIGN_KEY_CHECKS = 1;
