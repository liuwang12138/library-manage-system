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
