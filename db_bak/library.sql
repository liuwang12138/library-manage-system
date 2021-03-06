-- ----------------------------
-- Table structure for blacklist
-- ----------------------------
DROP TABLE IF EXISTS `blacklist`;
CREATE TABLE `blacklist`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `deadline` datetime NOT NULL COMMENT '截止时间',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB ;

-- ----------------------------
-- Records of blacklist
-- ----------------------------
INSERT INTO `blacklist` VALUES (1, 1, '2020-04-16 22:53:32', '2020-04-13 22:53:50', '2020-04-13 22:53:50');
INSERT INTO `blacklist` VALUES (2, 2, '2020-04-24 22:54:02', '2020-04-13 22:54:05', '2020-04-13 22:54:05');
INSERT INTO `blacklist` VALUES (3, 3, '2020-04-22 22:54:16', '2020-04-13 22:54:18', '2020-04-13 22:54:18');
INSERT INTO `blacklist` VALUES (4, 4, '2020-04-22 22:54:25', '2020-04-13 22:54:26', '2020-04-13 22:54:26');

-- ----------------------------
-- Table structure for notice
-- ----------------------------
DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `title` varchar(50) NOT NULL COMMENT '标题',
  `content` varchar(500) NOT NULL COMMENT '内容',
  `sort` int(2) NOT NULL COMMENT '排序字段',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB;

-- ----------------------------
-- Records of notice
-- ----------------------------
INSERT INTO `notice` VALUES (2, 'aaa', 'fjsdklfjsdlkfjdsklfjkdsljfkdslfjdsklfjlskdfj', 1, '2020-04-07 14:37:14', '2020-04-07 14:37:14');
INSERT INTO `notice` VALUES (18, '我校学生获评“第十四届中国大学生年度人物”', '我校学生获评“第十四届中国大学生年度人物”', 2, '2020-04-13 22:47:23', '2020-04-13 22:47:23');
INSERT INTO `notice` VALUES (19, '基于SSM框架的 “爱吃网”在线商城管理系统的设计与实现', '基于SSM框架的 “爱吃网”在线商城管理系统的设计与实现', 3, '2020-04-13 22:48:13', '2020-04-13 22:48:13');
INSERT INTO `notice` VALUES (20, 'delWhiteStaffById', 'delWhiteStaffByIddelWhiteStaffByIddel', 4, '2020-04-13 22:48:48', '2020-04-13 22:48:48');
INSERT INTO `notice` VALUES (21, 'qwer', 'qwerqwerqwerqwerqwerqwer', 5, '2020-04-13 22:49:01', '2020-04-13 22:49:01');
INSERT INTO `notice` VALUES (22, 'lj is pig', 'lj is piglj is piglj is pig', 6, '2020-04-13 23:00:28', '2020-04-13 23:00:28');

-- ----------------------------
-- Table structure for reservation_info
-- ----------------------------
DROP TABLE IF EXISTS `reservation_info`;
CREATE TABLE `reservation_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `reservation_date` date NOT NULL COMMENT '预约日期',
  `time_quantum` tinyint(2) NOT NULL COMMENT '时间段：1 - 8:00-12:00，2 - 12:00-17:00，3-17:00-22:00',
  `seat_id` int(11) NOT NULL COMMENT '座位id',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '1-待签到，2-签到待审核，3-待签退/暂时签退，4-待暂签退审核，5-已暂时签退，待回，6-暂时签回待审核，7-签退待审核，8-签退已审核',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB;

-- ----------------------------
-- Records of reservation_info
-- ----------------------------
INSERT INTO `reservation_info` VALUES (45, 1, '2020-04-13', 1, 2, 1, '2020-04-13 15:17:04', '2020-04-13 15:21:55');
INSERT INTO `reservation_info` VALUES (46, 1, '2020-04-13', 3, 2, 3, '2020-04-13 15:17:24', '2020-04-14 00:18:25');
INSERT INTO `reservation_info` VALUES (49, 1, '2020-04-13', 1, 3, 1, '2020-04-13 16:54:05', '2020-04-13 16:54:05');
INSERT INTO `reservation_info` VALUES (50, 1, '2020-04-13', 1, 4, 1, '2020-04-13 16:57:26', '2020-04-13 16:57:26');
INSERT INTO `reservation_info` VALUES (51, 1, '2020-04-13', 1, 5, 1, '2020-04-13 17:12:56', '2020-04-13 17:12:56');
INSERT INTO `reservation_info` VALUES (52, 1, '2020-04-13', 1, 6, 1, '2020-04-13 17:14:26', '2020-04-13 17:14:26');
INSERT INTO `reservation_info` VALUES (54, 1, '2020-04-14', 3, 53, 1, '2020-04-13 22:24:17', '2020-04-13 22:24:20');
INSERT INTO `reservation_info` VALUES (55, 15, '2020-04-14', 1, 2, 1, '2020-04-14 23:29:32', '2020-04-14 23:29:32');
INSERT INTO `reservation_info` VALUES (56, 15, '2020-04-15', 1, 2, 1, '2020-04-14 23:29:54', '2020-04-14 23:29:54');
INSERT INTO `reservation_info` VALUES (57, 15, '2020-04-16', 1, 2, 1, '2020-04-14 23:30:13', '2020-04-14 23:30:13');

-- ----------------------------
-- Table structure for seat
-- ----------------------------
DROP TABLE IF EXISTS `seat`;
CREATE TABLE `seat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `storey` tinyint(5) NOT NULL COMMENT '楼层：1，2，3，4，5',
  `room_num` varchar(10) NOT NULL COMMENT '自习室房间号',
  `seat_num` tinyint(5) NOT NULL COMMENT '座位号：1，2，3，...，30',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB;

-- ----------------------------
-- Records of seat
-- ----------------------------
INSERT INTO `seat` VALUES (2, 1, '101', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (3, 1, '101', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (4, 1, '101', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (5, 1, '101', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (6, 1, '101', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (7, 1, '101', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (8, 1, '101', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (9, 1, '101', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (10, 1, '101', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (11, 1, '101', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (12, 1, '102', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (13, 1, '102', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (14, 1, '102', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (15, 1, '102', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (16, 1, '102', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (17, 1, '102', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (18, 1, '102', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (19, 1, '102', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (20, 1, '102', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (21, 1, '102', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (22, 1, '103', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (23, 1, '103', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (24, 1, '103', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (25, 1, '103', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (26, 1, '103', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (27, 1, '103', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (28, 1, '103', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (29, 1, '103', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (30, 1, '103', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (31, 1, '103', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (32, 2, '201', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (33, 2, '201', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (34, 2, '201', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (35, 2, '201', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (36, 2, '201', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (37, 2, '201', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (38, 2, '201', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (39, 2, '201', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (40, 2, '201', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (41, 2, '201', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (42, 2, '202', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (43, 2, '202', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (44, 2, '202', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (45, 2, '202', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (46, 2, '202', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (47, 2, '202', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (48, 2, '202', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (49, 2, '202', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (50, 2, '202', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (51, 2, '202', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (52, 2, '203', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (53, 2, '203', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (54, 2, '203', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (55, 2, '203', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (56, 2, '203', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (57, 2, '203', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (58, 2, '203', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (59, 2, '203', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (60, 2, '203', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (61, 2, '203', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (62, 3, '301', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (63, 3, '301', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (64, 3, '301', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (65, 3, '301', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (66, 3, '301', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (67, 3, '301', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (68, 3, '301', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (69, 3, '301', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (70, 3, '301', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (71, 3, '301', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (72, 3, '302', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (73, 3, '302', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (74, 3, '302', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (75, 3, '302', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (76, 3, '302', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (77, 3, '302', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (78, 3, '302', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (79, 3, '302', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (80, 3, '302', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (81, 3, '302', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (82, 3, '303', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (83, 3, '303', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (84, 3, '303', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (85, 3, '303', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (86, 3, '303', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (87, 3, '303', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (88, 3, '303', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (89, 3, '303', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (90, 3, '303', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (91, 3, '303', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (92, 4, '401', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (93, 4, '401', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (94, 4, '401', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (95, 4, '401', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (96, 4, '401', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (97, 4, '401', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (98, 4, '401', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (99, 4, '401', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (100, 4, '401', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (101, 4, '401', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (102, 4, '402', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (103, 4, '402', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (104, 4, '402', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (105, 4, '402', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (106, 4, '402', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (107, 4, '402', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (108, 4, '402', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (109, 4, '402', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (110, 4, '402', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (111, 4, '402', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (112, 4, '403', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (113, 4, '403', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (114, 4, '403', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (115, 4, '403', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (116, 4, '403', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (117, 4, '403', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (118, 4, '403', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (119, 4, '403', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (120, 4, '403', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (121, 4, '403', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (122, 5, '501', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (123, 5, '501', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (124, 5, '501', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (125, 5, '501', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (126, 5, '501', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (127, 5, '501', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (128, 5, '501', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (129, 5, '501', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (130, 5, '501', 9, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (131, 5, '501', 10, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (132, 5, '502', 1, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (133, 5, '502', 2, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (134, 5, '502', 3, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (135, 5, '502', 4, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (136, 5, '502', 5, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (137, 5, '502', 6, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (138, 5, '502', 7, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (139, 5, '502', 8, '2020-04-07 14:58:44', '2020-04-07 14:58:44');
INSERT INTO `seat` VALUES (140, 5, '502', 9, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (141, 5, '502', 10, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (142, 5, '503', 1, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (143, 5, '503', 2, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (144, 5, '503', 3, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (145, 5, '503', 4, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (146, 5, '503', 5, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (147, 5, '503', 6, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (148, 5, '503', 7, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (149, 5, '503', 8, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (150, 5, '503', 9, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (151, 5, '503', 10, '2020-04-07 14:58:45', '2020-04-07 14:58:45');
INSERT INTO `seat` VALUES (154, 6, '601', 1, '2020-04-15 15:09:16', '2020-04-15 15:09:16');

-- ----------------------------
-- Table structure for sign_info
-- ----------------------------
DROP TABLE IF EXISTS `sign_info`;
CREATE TABLE `sign_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态：1-待审核，2-已审核',
  `type` tinyint(2) NOT NULL COMMENT '1-签到，2-临时签退，3-临时签退回馆，4-签退',
  `reservation_id` int(11) NOT NULL COMMENT '预约id',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB;

-- ----------------------------
-- Records of sign_info
-- ----------------------------
INSERT INTO `sign_info` VALUES (15, 1, 2, 1, 46, '2020-04-14 15:36:11', '2020-04-14 00:08:35');
INSERT INTO `sign_info` VALUES (17, 1, 1, 2, 46, '2020-04-14 15:37:03', '2020-04-14 00:08:37');
INSERT INTO `sign_info` VALUES (19, 1, 1, 3, 46, '2020-04-14 15:37:28', '2020-04-14 00:08:12');
INSERT INTO `sign_info` VALUES (21, 1, 1, 4, 46, '2020-04-14 15:37:37', '2020-04-14 00:08:19');

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `card_num` varchar(20) NOT NULL COMMENT '用户卡号：随机生成，年月日时分秒+随机四位数',
  `username` varchar(50) NOT NULL COMMENT '用户名',
  `password` varchar(255) NOT NULL COMMENT '密码',
  `real_name` varchar(50) NOT NULL COMMENT '真实姓名',
  `phone` varchar(20) NOT NULL COMMENT '手机号',
  `type` tinyint(2) NOT NULL COMMENT '1-普通用户, 2-common admin',
  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `card_num`(`card_num`) USING BTREE COMMENT '卡号不能相同'
) ENGINE = InnoDB;

-- ----------------------------
-- Records of user
-- ----------------------------
INSERT INTO `user` VALUES (1, '202004071314518048', 'zhangsan', '111111', '张三', '111111111111', 1, '2020-04-07 13:14:47', '2020-04-12 14:19:10');
INSERT INTO `user` VALUES (2, '202004091019425124', 'godric', 'godric', '啊哈哈', '13223232323', 1, '2020-04-09 10:19:42', '2020-04-09 10:19:42');
INSERT INTO `user` VALUES (6, '202004121315295335', 'liuwang', '111111', '李四', '13000000000', 1, '2020-04-12 13:15:26', '2020-04-12 13:15:26');
INSERT INTO `user` VALUES (7, '202004121423321638', 'qwe', 'qwe', '李四', '13000000000', 1, '2020-04-12 14:23:30', '2020-04-12 14:23:30');
INSERT INTO `user` VALUES (8, '202004121459441000', 'liuw', '111111', '李四', '13000000000', 1, '2020-04-12 14:59:41', '2020-04-12 14:59:41');
INSERT INTO `user` VALUES (9, '202004121506358143', '111', '222', '111', '222', 1, '2020-04-12 15:06:33', '2020-04-12 15:06:33');
INSERT INTO `user` VALUES (10, '202004121510132928', '1', '1', '1', '1', 1, '2020-04-12 15:10:11', '2020-04-12 15:10:11');
INSERT INTO `user` VALUES (11, '202004121511532615', 'asd', 'asd', '王五', '13000000000', 1, '2020-04-12 15:11:51', '2020-04-12 15:11:51');
INSERT INTO `user` VALUES (12, '202004121529247946', 'vvv', 'aaa', 'aaa', 'aaa', 1, '2020-04-12 15:29:22', '2020-04-12 15:29:22');
INSERT INTO `user` VALUES (13, '202004121532572149', 'yuyuyu', 'lll', '李四', '13000000000', 1, '2020-04-12 15:32:54', '2020-04-12 15:32:54');
INSERT INTO `user` VALUES (14, '202004132324016735', 'admin1', '123456', '飞机迪斯科', '222', 2, '2020-04-13 23:24:00', '2020-04-13 23:24:00');
INSERT INTO `user` VALUES (15, '202004142328469488', 'dundongdoufu', '111111', '炖冻豆腐', '1323232323', 1, '2020-04-14 23:28:45', '2020-04-14 23:28:45');

