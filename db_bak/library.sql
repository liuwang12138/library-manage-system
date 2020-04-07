DROP TABLE IF EXISTS `notice`;
CREATE TABLE `notice`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '标题',
  `content` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '内容',
  `sort` int(2) NOT NULL COMMENT '排序字段',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `reservation_info`;
CREATE TABLE `reservation_info`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `reservation_date` date NOT NULL COMMENT '预约日期',
  `time_quantum` tinyint(2) NOT NULL COMMENT '时间段：1 - 8:00-12:00，2 - 12:00-17:00，3-17:00-22:00',
  `seat_id` int(11) NOT NULL COMMENT '座位id',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `seat`;
CREATE TABLE `seat`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `storey` tinyint(2) NOT NULL COMMENT '楼层：1，2，3，4，5',
  `room_num` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '自习室房间号',
  `seat_num` tinyint(5) NOT NULL COMMENT '座位号：1，2，3，...，30',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

DROP TABLE IF EXISTS `sign_info`;
CREATE TABLE `sign_info`  (
  `id` int(11) NOT NULL COMMENT '唯一主键',
  `user_id` int(11) NOT NULL COMMENT '用户id',
  `status` tinyint(2) NOT NULL DEFAULT 1 COMMENT '状态：1-待审核，2-已审核',
  `type` tinyint(2) NOT NULL COMMENT '1-签到，2-临时签退，3-临时签退回馆，4-签退',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Table structure for user
-- ----------------------------
DROP TABLE IF EXISTS `user`;
CREATE TABLE `user`  (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '唯一主键',
  `card_num` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户卡号：随机生成，年月日时分秒+随机四位数',
  `username` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户名',
  `password` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '密码',
  `blacklist` tinyint(1) NOT NULL DEFAULT 0 COMMENT '是否黑名单',
  `blacklist_deadline` datetime(0) DEFAULT NULL COMMENT '黑名单截止时间：如果不是黑名单，则为空',
  `create_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_time` datetime(0) NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP(0) COMMENT '更新时间',
  PRIMARY KEY (`id`) USING BTREE,
  UNIQUE INDEX `card_num`(`card_num`) USING BTREE COMMENT '卡号不能相同'
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- data
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '101', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '102', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (1, '103', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '201', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '202', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (2, '203', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '301', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '302', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (3, '303', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '401', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '402', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (4, '403', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '501', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '502', 10);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 1);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 2);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 3);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 4);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 5);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 6);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 7);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 8);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 9);
insert into `seat` (`storey`, `room_num`, `seat_num`) values (5, '503', 10);
