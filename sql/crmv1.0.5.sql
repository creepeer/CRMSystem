/*
 Navicat Premium Data Transfer

 Source Server         : mysql
 Source Server Type    : MySQL
 Source Server Version : 80043 (8.0.43)
 Source Host           : localhost:3306
 Source Schema         : crm

 Target Server Type    : MySQL
 Target Server Version : 80043 (8.0.43)
 File Encoding         : 65001

 Date: 14/12/2025 15:37:55
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for gen_table
-- ----------------------------
DROP TABLE IF EXISTS `gen_table`;
CREATE TABLE `gen_table`  (
  `table_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表名称',
  `table_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '表描述',
  `sub_table_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '关联子表的表名',
  `sub_table_fk_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '子表关联的外键名',
  `class_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '实体类名称',
  `tpl_category` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'crud' COMMENT '使用的模板（crud单表操作 tree树表操作）',
  `tpl_web_type` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '前端模板类型（element-ui模版 element-plus模版）',
  `package_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成包路径',
  `module_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成模块名',
  `business_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成业务名',
  `function_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能名',
  `function_author` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '生成功能作者',
  `gen_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '生成代码方式（0zip压缩包 1自定义路径）',
  `gen_path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '/' COMMENT '生成路径（不填默认项目路径）',
  `options` varchar(1000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '其它生成选项',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`table_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table
-- ----------------------------
INSERT INTO `gen_table` VALUES (1, 'n_company', '企业信息表', NULL, NULL, 'NCompany', 'crud', 'element-plus', 'com.ruoyi.system', 'system', 'company', '企业信息', 'ruoyi', '0', '/', '{}', 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', NULL, 1);

-- ----------------------------
-- Table structure for gen_table_column
-- ----------------------------
DROP TABLE IF EXISTS `gen_table_column`;
CREATE TABLE `gen_table_column`  (
  `column_id` bigint NOT NULL AUTO_INCREMENT COMMENT '编号',
  `table_id` bigint NULL DEFAULT NULL COMMENT '归属表编号',
  `column_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列名称',
  `column_comment` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列描述',
  `column_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '列类型',
  `java_type` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA类型',
  `java_field` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'JAVA字段名',
  `is_pk` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否主键（1是）',
  `is_increment` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否自增（1是）',
  `is_required` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否必填（1是）',
  `is_insert` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否为插入字段（1是）',
  `is_edit` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否编辑字段（1是）',
  `is_list` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否列表字段（1是）',
  `is_query` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否查询字段（1是）',
  `query_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'EQ' COMMENT '查询方式（等于、不等于、大于、小于、范围）',
  `html_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '显示类型（文本框、文本域、下拉框、复选框、单选框、日期控件）',
  `dict_type` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `sort` int NULL DEFAULT NULL COMMENT '排序',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`column_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 17 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '代码生成业务表字段' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of gen_table_column
-- ----------------------------
INSERT INTO `gen_table_column` VALUES (1, 1, 'id', '企业编号', 'bigint', 'Long', 'id', '1', '1', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 1, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (2, 1, 'name', '企业名称', 'varchar(255)', 'String', 'name', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 2, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (3, 1, 'address', '企业地址', 'varchar(500)', 'String', 'address', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'textarea', '', 3, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (4, 1, 'cplicense', '营业执照', 'varchar(100)', 'String', 'cplicense', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 4, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (5, 1, 'lename', '法人姓名', 'varchar(100)', 'String', 'lename', '0', '0', '0', '1', '1', '1', '1', 'LIKE', 'input', '', 5, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (6, 1, 'leage', '法人年龄', 'int', 'Long', 'leage', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 6, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (7, 1, 'leemail', '法人邮箱', 'varchar(100)', 'String', 'leemail', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 7, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (8, 1, 'lephone', '法人电话', 'varchar(30)', 'String', 'lephone', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 8, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (9, 1, 'lecard', '法人身份证号', 'varchar(30)', 'String', 'lecard', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 9, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (10, 1, 'state', '企业状态：1-待审核 2-已通过 3-已拒绝 4-停用', 'tinyint', 'Long', 'state', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 10, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (11, 1, 'remark', '企业审批备注', 'varchar(255)', 'String', 'remark', '0', '0', '0', '1', '1', '1', NULL, 'EQ', 'input', '', 11, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (12, 1, 'create_by', '创建人', 'varchar(50)', 'String', 'createBy', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'input', '', 12, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (13, 1, 'create_time', '创建时间', 'datetime', 'Date', 'createTime', '0', '0', '0', '1', NULL, NULL, NULL, 'EQ', 'datetime', '', 13, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (14, 1, 'update_by', '更新人', 'varchar(50)', 'String', 'updateBy', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'input', '', 14, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (15, 1, 'update_time', '更新时间', 'datetime', 'Date', 'updateTime', '0', '0', '0', '1', '1', NULL, NULL, 'EQ', 'datetime', '', 15, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);
INSERT INTO `gen_table_column` VALUES (16, 1, 'is_deleted', '删除标记：0-正常 1-删除', 'tinyint(1)', 'Integer', 'isDeleted', '0', '0', '0', '1', '1', '1', '1', 'EQ', 'input', '', 16, 'admin', '2025-11-25 14:30:18', '', '2025-11-25 14:30:31', 1);

-- ----------------------------
-- Table structure for n_company
-- ----------------------------
DROP TABLE IF EXISTS `n_company`;
CREATE TABLE `n_company`  (
  `id` bigint NOT NULL AUTO_INCREMENT COMMENT '企业编号',
  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业名称',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业地址',
  `cplicense` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '营业执照',
  `lename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人姓名',
  `leage` int NULL DEFAULT NULL COMMENT '法人年龄',
  `leemail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人邮箱',
  `lephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人电话',
  `lecard` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '法人身份证号',
  `state` int NULL DEFAULT 1 COMMENT '企业状态：1-待审核 2-已通过 3-已拒绝 4-停用',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '企业审批备注',
  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '创建人',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '更新人',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT '删除标记：0-正常 1-删除',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`id`) USING BTREE,
  INDEX `idx_name`(`name` ASC) USING BTREE,
  INDEX `idx_cplicense`(`cplicense` ASC) USING BTREE,
  INDEX `idx_state`(`state` ASC) USING BTREE,
  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,
  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,
  INDEX `idx_lename`(`lename` ASC) USING BTREE,
  INDEX `idx_lephone`(`lephone` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '企业信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of n_company
-- ----------------------------
INSERT INTO `n_company` VALUES (1, '租户A公司1', '地址A1', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-11-26 17:37:53', NULL, NULL, 0, 1001);
INSERT INTO `n_company` VALUES (2, '租户A公司2', '地址A2', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-11-26 17:37:53', NULL, NULL, 0, 1001);
INSERT INTO `n_company` VALUES (3, '租户B公司1', '地址B1', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-11-26 17:37:53', NULL, NULL, 0, 1002);
INSERT INTO `n_company` VALUES (4, '租户B公司2', '地址B2', NULL, NULL, NULL, NULL, NULL, NULL, 1, NULL, NULL, '2025-11-26 17:37:53', NULL, NULL, 0, 1002);

-- ----------------------------
-- Table structure for n_customer
-- ----------------------------
DROP TABLE IF EXISTS `n_customer`;
CREATE TABLE `n_customer`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `c_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户编码',
  `name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '客户名称',
  `type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'enterprise' COMMENT '客户类型:enterprise-企业,personal-个人',
  `age` int NULL DEFAULT NULL COMMENT '客户年龄',
  `phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户电话',
  `email` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '客户邮箱',
  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '详细地址',
  `team_id` bigint NULL DEFAULT NULL COMMENT '负责团队ID',
  `status` tinyint NULL DEFAULT 1 COMMENT '状态:1-正常,0-禁用',
  `remark` text CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL COMMENT '备注',
  `created_by` bigint NOT NULL COMMENT '创建人ID',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  `updated_by` bigint NULL DEFAULT NULL COMMENT '更新人ID',
  `is_deleted` tinyint NULL DEFAULT 0 COMMENT '逻辑删除',
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of n_customer
-- ----------------------------

-- ----------------------------
-- Table structure for n_user_guest
-- ----------------------------
DROP TABLE IF EXISTS `n_user_guest`;
CREATE TABLE `n_user_guest`  (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `tenant_id` bigint NOT NULL COMMENT '租户ID',
  `customer_id` bigint NOT NULL COMMENT '客户ID',
  `user_id` bigint NOT NULL COMMENT '员工ID',
  `relation_type` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'responsible' COMMENT '关系类型:responsible-负责人,support-协助人',
  `is_primary` tinyint NULL DEFAULT 1 COMMENT '是否主要负责人:1-是,0-否',
  `created_by` bigint NOT NULL COMMENT '创建人',
  `created_at` datetime NULL DEFAULT CURRENT_TIMESTAMP,
  `updated_at` datetime NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '客户-员工关联表' ROW_FORMAT = Dynamic;

-- ----------------------------
-- Records of n_user_guest
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_blob_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_blob_triggers`;
CREATE TABLE `qrtz_blob_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `blob_data` blob NULL COMMENT '存放持久化Trigger对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_blob_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Blob类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_blob_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_calendars
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_calendars`;
CREATE TABLE `qrtz_calendars`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '日历名称',
  `calendar` blob NOT NULL COMMENT '存放持久化calendar对象',
  PRIMARY KEY (`sched_name`, `calendar_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '日历信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_calendars
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_cron_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_cron_triggers`;
CREATE TABLE `qrtz_cron_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `cron_expression` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'cron表达式',
  `time_zone_id` varchar(80) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '时区',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_cron_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = 'Cron类型的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_cron_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_fired_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_fired_triggers`;
CREATE TABLE `qrtz_fired_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `entry_id` varchar(95) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例id',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度器实例名',
  `fired_time` bigint NOT NULL COMMENT '触发的时间',
  `sched_time` bigint NOT NULL COMMENT '定时器制定的时间',
  `priority` int NOT NULL COMMENT '优先级',
  `state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '任务组名',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否并发',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '是否接受恢复执行',
  PRIMARY KEY (`sched_name`, `entry_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '已触发的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_fired_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_job_details
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_job_details`;
CREATE TABLE `qrtz_job_details`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `job_class_name` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '执行任务类名称',
  `is_durable` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否持久化',
  `is_nonconcurrent` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否并发',
  `is_update_data` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否更新数据',
  `requests_recovery` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '是否接受恢复执行',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '任务详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_job_details
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_locks
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_locks`;
CREATE TABLE `qrtz_locks`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `lock_name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '悲观锁名称',
  PRIMARY KEY (`sched_name`, `lock_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '存储的悲观锁信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_locks
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_paused_trigger_grps
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_paused_trigger_grps`;
CREATE TABLE `qrtz_paused_trigger_grps`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  PRIMARY KEY (`sched_name`, `trigger_group`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '暂停的触发器表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_paused_trigger_grps
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_scheduler_state
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_scheduler_state`;
CREATE TABLE `qrtz_scheduler_state`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `instance_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '实例名称',
  `last_checkin_time` bigint NOT NULL COMMENT '上次检查时间',
  `checkin_interval` bigint NOT NULL COMMENT '检查间隔时间',
  PRIMARY KEY (`sched_name`, `instance_name`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '调度器状态表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_scheduler_state
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simple_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simple_triggers`;
CREATE TABLE `qrtz_simple_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `repeat_count` bigint NOT NULL COMMENT '重复的次数统计',
  `repeat_interval` bigint NOT NULL COMMENT '重复的间隔时间',
  `times_triggered` bigint NOT NULL COMMENT '已经触发的次数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simple_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '简单触发器的信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simple_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_simprop_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_simprop_triggers`;
CREATE TABLE `qrtz_simprop_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_name的外键',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_triggers表trigger_group的外键',
  `str_prop_1` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第一个参数',
  `str_prop_2` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第二个参数',
  `str_prop_3` varchar(512) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'String类型的trigger的第三个参数',
  `int_prop_1` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第一个参数',
  `int_prop_2` int NULL DEFAULT NULL COMMENT 'int类型的trigger的第二个参数',
  `long_prop_1` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第一个参数',
  `long_prop_2` bigint NULL DEFAULT NULL COMMENT 'long类型的trigger的第二个参数',
  `dec_prop_1` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第一个参数',
  `dec_prop_2` decimal(13, 4) NULL DEFAULT NULL COMMENT 'decimal类型的trigger的第二个参数',
  `bool_prop_1` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第一个参数',
  `bool_prop_2` varchar(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT 'Boolean类型的trigger的第二个参数',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  CONSTRAINT `qrtz_simprop_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `trigger_name`, `trigger_group`) REFERENCES `qrtz_triggers` (`sched_name`, `trigger_name`, `trigger_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '同步机制的行锁表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_simprop_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for qrtz_triggers
-- ----------------------------
DROP TABLE IF EXISTS `qrtz_triggers`;
CREATE TABLE `qrtz_triggers`  (
  `sched_name` varchar(120) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调度名称',
  `trigger_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的名字',
  `trigger_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器所属组的名字',
  `job_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_name的外键',
  `job_group` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT 'qrtz_job_details表job_group的外键',
  `description` varchar(250) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '相关介绍',
  `next_fire_time` bigint NULL DEFAULT NULL COMMENT '上一次触发时间（毫秒）',
  `prev_fire_time` bigint NULL DEFAULT NULL COMMENT '下一次触发时间（默认为-1表示不触发）',
  `priority` int NULL DEFAULT NULL COMMENT '优先级',
  `trigger_state` varchar(16) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器状态',
  `trigger_type` varchar(8) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '触发器的类型',
  `start_time` bigint NOT NULL COMMENT '开始时间',
  `end_time` bigint NULL DEFAULT NULL COMMENT '结束时间',
  `calendar_name` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日程表名称',
  `misfire_instr` smallint NULL DEFAULT NULL COMMENT '补偿执行的策略',
  `job_data` blob NULL COMMENT '存放持久化job对象',
  PRIMARY KEY (`sched_name`, `trigger_name`, `trigger_group`) USING BTREE,
  INDEX `sched_name`(`sched_name` ASC, `job_name` ASC, `job_group` ASC) USING BTREE,
  CONSTRAINT `qrtz_triggers_ibfk_1` FOREIGN KEY (`sched_name`, `job_name`, `job_group`) REFERENCES `qrtz_job_details` (`sched_name`, `job_name`, `job_group`) ON DELETE RESTRICT ON UPDATE RESTRICT
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '触发器详细信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of qrtz_triggers
-- ----------------------------

-- ----------------------------
-- Table structure for sys_config
-- ----------------------------
DROP TABLE IF EXISTS `sys_config`;
CREATE TABLE `sys_config`  (
  `config_id` int NOT NULL AUTO_INCREMENT COMMENT '参数主键',
  `config_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数名称',
  `config_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键名',
  `config_value` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '参数键值',
  `config_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '系统内置（Y是 N否）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`config_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '参数配置表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_config
-- ----------------------------
INSERT INTO `sys_config` VALUES (1, '主框架页-默认皮肤样式名称', 'sys.index.skinName', 'skin-blue', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '蓝色 skin-blue、绿色 skin-green、紫色 skin-purple、红色 skin-red、黄色 skin-yellow', 1);
INSERT INTO `sys_config` VALUES (2, '用户管理-账号初始密码', 'sys.user.initPassword', '123456', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '初始化密码 123456', 1);
INSERT INTO `sys_config` VALUES (3, '主框架页-侧边栏主题', 'sys.index.sideTheme', 'theme-dark', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '深色主题theme-dark，浅色主题theme-light', 1);
INSERT INTO `sys_config` VALUES (4, '账号自助-验证码开关', 'sys.account.captchaEnabled', 'false', 'Y', 'admin', '2025-11-06 13:59:56', 'admin', '2025-12-01 15:20:05', '是否开启验证码功能（true开启，false关闭）', 1);
INSERT INTO `sys_config` VALUES (5, '账号自助-是否开启用户注册功能', 'sys.account.registerUser', 'true', 'Y', 'admin', '2025-11-06 13:59:56', 'admin', '2025-11-26 18:43:10', '是否开启注册用户功能（true开启，false关闭）', 1);
INSERT INTO `sys_config` VALUES (6, '用户登录-黑名单列表', 'sys.login.blackIPList', '', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '设置登录IP黑名单限制，多个匹配项以;分隔，支持匹配（*通配、网段）', 1);
INSERT INTO `sys_config` VALUES (7, '用户管理-初始密码修改策略', 'sys.account.initPasswordModify', '1', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '0：初始密码修改策略关闭，没有任何提示，1：提醒用户，如果未修改初始密码，则在登录时就会提醒修改密码对话框', 1);
INSERT INTO `sys_config` VALUES (8, '用户管理-账号密码更新周期', 'sys.account.passwordValidateDays', '0', 'Y', 'admin', '2025-11-06 13:59:56', '', NULL, '密码更新周期（填写数字，数据初始化值为0不限制，若修改必须为大于0小于365的正整数），如果超过这个周期登录系统时，则在登录时就会提醒修改密码对话框', 1);

-- ----------------------------
-- Table structure for sys_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_dept`;
CREATE TABLE `sys_dept`  (
  `dept_id` bigint NOT NULL AUTO_INCREMENT COMMENT '部门id',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父部门id',
  `ancestors` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '祖级列表',
  `dept_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `leader_id` int NULL DEFAULT NULL COMMENT '负责人id',
  `leader` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '负责人',
  `phone` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '邮箱',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '团队信息备注',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '部门状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`dept_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 208 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '部门表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dept
-- ----------------------------
INSERT INTO `sys_dept` VALUES (100, 0, '0', '若依科技', 0, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (101, 100, '0,100', '深圳总公司', 1, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (102, 100, '0,100', '长沙分公司', 2, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (103, 101, '0,100,101', '研发部门', 1, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (104, 101, '0,100,101', '市场部门', 2, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (105, 101, '0,100,101', '测试部门', 3, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (106, 101, '0,100,101', '财务部门', 4, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (107, 101, '0,100,101', '运维部门', 5, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (108, 102, '0,100,102', '市场部门', 1, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (109, 102, '0,100,102', '财务部门', 2, NULL, '若依', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (110, 0, '0', '杭州电气', 0, NULL, '电气', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '11', '2025-12-13 16:44:12', 110);
INSERT INTO `sys_dept` VALUES (111, 0, '0', '杭州科技', 0, NULL, '杭科', '15888888888', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, 111);
INSERT INTO `sys_dept` VALUES (200, 110, '0,110', '研发部门', 0, NULL, 'Leland', '13888888888', '123@qq.com', NULL, '0', '0', 'admin', '2025-11-11 16:19:12', '', NULL, 110);
INSERT INTO `sys_dept` VALUES (201, 111, '0,111', '研发', 0, NULL, 'yanfa', '13888888888', '123@qq.com', NULL, '0', '0', 'admin', '2025-11-11 16:20:00', '', NULL, 111);
INSERT INTO `sys_dept` VALUES (202, 100, '0,100', '杭州分公司', 1, NULL, '阿巴', '18978723412', '123@qq.com', NULL, '0', '0', 'admin', '2025-11-26 16:59:08', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (203, 101, '0,100,101', '研发部11', 6, NULL, '若依', '15666666666', 'ry@qq.com', NULL, '0', '0', 'admin', '2025-12-11 14:50:28', '', NULL, 1);
INSERT INTO `sys_dept` VALUES (207, 200, '0,110,200', '研发一部112', 1, NULL, '11', '13800138000', 'zhangsan@example.com', '112', '0', '2', '11', '2025-12-13 17:10:02', '11', '2025-12-13 17:20:36', 110);

-- ----------------------------
-- Table structure for sys_dict_data
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_data`;
CREATE TABLE `sys_dict_data`  (
  `dict_code` bigint NOT NULL AUTO_INCREMENT COMMENT '字典编码',
  `dict_sort` int NULL DEFAULT 0 COMMENT '字典排序',
  `dict_label` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典标签',
  `dict_value` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典键值',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `css_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '样式属性（其他样式扩展）',
  `list_class` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '表格回显样式',
  `is_default` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT 'N' COMMENT '是否默认（Y是 N否）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`dict_code`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典数据表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_data
-- ----------------------------
INSERT INTO `sys_dict_data` VALUES (1, 1, '男', '0', 'sys_user_sex', '', '', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '性别男', 1);
INSERT INTO `sys_dict_data` VALUES (2, 2, '女', '1', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '性别女', 1);
INSERT INTO `sys_dict_data` VALUES (3, 3, '未知', '2', 'sys_user_sex', '', '', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '性别未知', 1);
INSERT INTO `sys_dict_data` VALUES (4, 1, '显示', '0', 'sys_show_hide', '', 'primary', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '显示菜单', 1);
INSERT INTO `sys_dict_data` VALUES (5, 2, '隐藏', '1', 'sys_show_hide', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '隐藏菜单', 1);
INSERT INTO `sys_dict_data` VALUES (6, 1, '正常', '0', 'sys_normal_disable', '', 'primary', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '正常状态', 1);
INSERT INTO `sys_dict_data` VALUES (7, 2, '停用', '1', 'sys_normal_disable', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '停用状态', 1);
INSERT INTO `sys_dict_data` VALUES (8, 1, '正常', '0', 'sys_job_status', '', 'primary', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '正常状态', 1);
INSERT INTO `sys_dict_data` VALUES (9, 2, '暂停', '1', 'sys_job_status', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '停用状态', 1);
INSERT INTO `sys_dict_data` VALUES (10, 1, '默认', 'DEFAULT', 'sys_job_group', '', '', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '默认分组', 1);
INSERT INTO `sys_dict_data` VALUES (11, 2, '系统', 'SYSTEM', 'sys_job_group', '', '', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '系统分组', 1);
INSERT INTO `sys_dict_data` VALUES (12, 1, '是', 'Y', 'sys_yes_no', '', 'primary', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '系统默认是', 1);
INSERT INTO `sys_dict_data` VALUES (13, 2, '否', 'N', 'sys_yes_no', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '系统默认否', 1);
INSERT INTO `sys_dict_data` VALUES (14, 1, '通知', '1', 'sys_notice_type', '', 'warning', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '通知', 1);
INSERT INTO `sys_dict_data` VALUES (15, 2, '公告', '2', 'sys_notice_type', '', 'success', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '公告', 1);
INSERT INTO `sys_dict_data` VALUES (16, 1, '正常', '0', 'sys_notice_status', '', 'primary', 'Y', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '正常状态', 1);
INSERT INTO `sys_dict_data` VALUES (17, 2, '关闭', '1', 'sys_notice_status', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '关闭状态', 1);
INSERT INTO `sys_dict_data` VALUES (18, 99, '其他', '0', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '其他操作', 1);
INSERT INTO `sys_dict_data` VALUES (19, 1, '新增', '1', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '新增操作', 1);
INSERT INTO `sys_dict_data` VALUES (20, 2, '修改', '2', 'sys_oper_type', '', 'info', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '修改操作', 1);
INSERT INTO `sys_dict_data` VALUES (21, 3, '删除', '3', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '删除操作', 1);
INSERT INTO `sys_dict_data` VALUES (22, 4, '授权', '4', 'sys_oper_type', '', 'primary', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '授权操作', 1);
INSERT INTO `sys_dict_data` VALUES (23, 5, '导出', '5', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '导出操作', 1);
INSERT INTO `sys_dict_data` VALUES (24, 6, '导入', '6', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '导入操作', 1);
INSERT INTO `sys_dict_data` VALUES (25, 7, '强退', '7', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '强退操作', 1);
INSERT INTO `sys_dict_data` VALUES (26, 8, '生成代码', '8', 'sys_oper_type', '', 'warning', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '生成操作', 1);
INSERT INTO `sys_dict_data` VALUES (27, 9, '清空数据', '9', 'sys_oper_type', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '清空操作', 1);
INSERT INTO `sys_dict_data` VALUES (28, 1, '成功', '0', 'sys_common_status', '', 'primary', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '正常状态', 1);
INSERT INTO `sys_dict_data` VALUES (29, 2, '失败', '1', 'sys_common_status', '', 'danger', 'N', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '停用状态', 1);

-- ----------------------------
-- Table structure for sys_dict_type
-- ----------------------------
DROP TABLE IF EXISTS `sys_dict_type`;
CREATE TABLE `sys_dict_type`  (
  `dict_id` bigint NOT NULL AUTO_INCREMENT COMMENT '字典主键',
  `dict_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典名称',
  `dict_type` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '字典类型',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`dict_id`) USING BTREE,
  UNIQUE INDEX `dict_type`(`dict_type` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '字典类型表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_dict_type
-- ----------------------------
INSERT INTO `sys_dict_type` VALUES (1, '用户性别', 'sys_user_sex', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '用户性别列表', 1);
INSERT INTO `sys_dict_type` VALUES (2, '菜单状态', 'sys_show_hide', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '菜单状态列表', 1);
INSERT INTO `sys_dict_type` VALUES (3, '系统开关', 'sys_normal_disable', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '系统开关列表', 1);
INSERT INTO `sys_dict_type` VALUES (4, '任务状态', 'sys_job_status', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '任务状态列表', 1);
INSERT INTO `sys_dict_type` VALUES (5, '任务分组', 'sys_job_group', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '任务分组列表', 1);
INSERT INTO `sys_dict_type` VALUES (6, '系统是否', 'sys_yes_no', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '系统是否列表', 1);
INSERT INTO `sys_dict_type` VALUES (7, '通知类型', 'sys_notice_type', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '通知类型列表', 1);
INSERT INTO `sys_dict_type` VALUES (8, '通知状态', 'sys_notice_status', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '通知状态列表', 1);
INSERT INTO `sys_dict_type` VALUES (9, '操作类型', 'sys_oper_type', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '操作类型列表', 1);
INSERT INTO `sys_dict_type` VALUES (10, '系统状态', 'sys_common_status', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '登录状态列表', 1);

-- ----------------------------
-- Table structure for sys_job
-- ----------------------------
DROP TABLE IF EXISTS `sys_job`;
CREATE TABLE `sys_job`  (
  `job_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT '' COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL DEFAULT 'DEFAULT' COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `cron_expression` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT 'cron执行表达式',
  `misfire_policy` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '3' COMMENT '计划执行错误策略（1立即执行 2执行一次 3放弃执行）',
  `concurrent` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '是否并发执行（0允许 1禁止）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1暂停）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注信息',
  `tenant_id` int NULL DEFAULT NULL COMMENT '租户ID',
  PRIMARY KEY (`job_id`, `job_name`, `job_group`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 100 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job
-- ----------------------------
INSERT INTO `sys_job` VALUES (1, '系统默认（无参）', 'DEFAULT', 'ryTask.ryNoParams', '0/10 * * * * ?', '3', '1', '1', 'admin', '2025-11-06 13:59:56', '', NULL, '', NULL);
INSERT INTO `sys_job` VALUES (2, '系统默认（有参）', 'DEFAULT', 'ryTask.ryParams(\'ry\')', '0/15 * * * * ?', '3', '1', '1', 'admin', '2025-11-06 13:59:56', '', NULL, '', NULL);
INSERT INTO `sys_job` VALUES (3, '系统默认（多参）', 'DEFAULT', 'ryTask.ryMultipleParams(\'ry\', true, 2000L, 316.50D, 100)', '0/20 * * * * ?', '3', '1', '1', 'admin', '2025-11-06 13:59:56', '', NULL, '', NULL);

-- ----------------------------
-- Table structure for sys_job_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_job_log`;
CREATE TABLE `sys_job_log`  (
  `job_log_id` bigint NOT NULL AUTO_INCREMENT COMMENT '任务日志ID',
  `job_name` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务名称',
  `job_group` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '任务组名',
  `invoke_target` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '调用目标字符串',
  `job_message` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '日志信息',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '执行状态（0正常 1失败）',
  `exception_info` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '异常信息',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`job_log_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '定时任务调度日志表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_job_log
-- ----------------------------

-- ----------------------------
-- Table structure for sys_logininfor
-- ----------------------------
DROP TABLE IF EXISTS `sys_logininfor`;
CREATE TABLE `sys_logininfor`  (
  `info_id` bigint NOT NULL AUTO_INCREMENT COMMENT '访问ID',
  `user_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户账号',
  `ipaddr` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录IP地址',
  `login_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '登录地点',
  `browser` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '浏览器类型',
  `os` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作系统',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '登录状态（0成功 1失败）',
  `msg` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '提示消息',
  `login_time` datetime NULL DEFAULT NULL COMMENT '访问时间',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`info_id`) USING BTREE,
  INDEX `idx_sys_logininfor_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_logininfor_lt`(`login_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 504 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '系统访问记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_logininfor
-- ----------------------------
INSERT INTO `sys_logininfor` VALUES (100, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-11-06 14:00:23', 1);
INSERT INTO `sys_logininfor` VALUES (101, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-06 14:00:26', 1);
INSERT INTO `sys_logininfor` VALUES (102, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-06 14:00:29', 1);
INSERT INTO `sys_logininfor` VALUES (103, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-06 15:32:20', 1);
INSERT INTO `sys_logininfor` VALUES (104, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-06 16:27:39', 1);
INSERT INTO `sys_logininfor` VALUES (105, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-06 16:27:53', 1);
INSERT INTO `sys_logininfor` VALUES (106, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-06 16:29:28', 1);
INSERT INTO `sys_logininfor` VALUES (107, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-06 16:33:36', 1);
INSERT INTO `sys_logininfor` VALUES (108, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-06 16:33:42', 1);
INSERT INTO `sys_logininfor` VALUES (109, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-06 16:33:45', 1);
INSERT INTO `sys_logininfor` VALUES (110, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:37:02', 1);
INSERT INTO `sys_logininfor` VALUES (111, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:42:36', 1);
INSERT INTO `sys_logininfor` VALUES (112, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:42:40', 1);
INSERT INTO `sys_logininfor` VALUES (113, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:43:49', 1);
INSERT INTO `sys_logininfor` VALUES (114, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-11 15:43:53', 1);
INSERT INTO `sys_logininfor` VALUES (115, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:43:57', 1);
INSERT INTO `sys_logininfor` VALUES (116, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:44:14', 1);
INSERT INTO `sys_logininfor` VALUES (117, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:44:20', 1);
INSERT INTO `sys_logininfor` VALUES (118, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:56:45', 1);
INSERT INTO `sys_logininfor` VALUES (119, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:56:48', 1);
INSERT INTO `sys_logininfor` VALUES (120, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:57:48', 1);
INSERT INTO `sys_logininfor` VALUES (121, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:57:54', 1);
INSERT INTO `sys_logininfor` VALUES (122, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:58:09', 1);
INSERT INTO `sys_logininfor` VALUES (123, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:58:12', 1);
INSERT INTO `sys_logininfor` VALUES (124, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 15:58:50', 1);
INSERT INTO `sys_logininfor` VALUES (125, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 15:58:55', 1);
INSERT INTO `sys_logininfor` VALUES (126, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 16:00:08', 1);
INSERT INTO `sys_logininfor` VALUES (127, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 16:00:18', 1);
INSERT INTO `sys_logininfor` VALUES (128, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 16:22:01', 1);
INSERT INTO `sys_logininfor` VALUES (129, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:22:07', 1);
INSERT INTO `sys_logininfor` VALUES (130, '222', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:22:10', 1);
INSERT INTO `sys_logininfor` VALUES (131, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:22:15', 1);
INSERT INTO `sys_logininfor` VALUES (132, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 16:22:22', 1);
INSERT INTO `sys_logininfor` VALUES (133, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 16:23:11', 1);
INSERT INTO `sys_logininfor` VALUES (134, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:23:15', 1);
INSERT INTO `sys_logininfor` VALUES (135, '1234', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:23:21', 1);
INSERT INTO `sys_logininfor` VALUES (136, 'hangke', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:23:53', 1);
INSERT INTO `sys_logininfor` VALUES (137, 'hangke', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-11 16:23:56', 1);
INSERT INTO `sys_logininfor` VALUES (138, 'hangke', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-11 16:23:59', 1);
INSERT INTO `sys_logininfor` VALUES (139, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-11 16:24:44', 1);
INSERT INTO `sys_logininfor` VALUES (140, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 16:24:47', 1);
INSERT INTO `sys_logininfor` VALUES (141, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-11 16:27:16', 1);
INSERT INTO `sys_logininfor` VALUES (142, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-11 16:27:19', 1);
INSERT INTO `sys_logininfor` VALUES (143, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2025-11-24 16:22:02', 1);
INSERT INTO `sys_logininfor` VALUES (144, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 16:22:08', 1);
INSERT INTO `sys_logininfor` VALUES (145, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:48:58', 1);
INSERT INTO `sys_logininfor` VALUES (146, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-24 17:53:38', 1);
INSERT INTO `sys_logininfor` VALUES (147, '1234', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-24 17:53:43', 1);
INSERT INTO `sys_logininfor` VALUES (148, '1234', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '验证码错误', '2025-11-24 17:53:48', 1);
INSERT INTO `sys_logininfor` VALUES (149, '1234', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-24 17:53:51', 1);
INSERT INTO `sys_logininfor` VALUES (150, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:54:08', 1);
INSERT INTO `sys_logininfor` VALUES (151, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-24 17:54:39', 1);
INSERT INTO `sys_logininfor` VALUES (152, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:54:44', 1);
INSERT INTO `sys_logininfor` VALUES (153, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-24 17:55:06', 1);
INSERT INTO `sys_logininfor` VALUES (154, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-24 17:55:10', 1);
INSERT INTO `sys_logininfor` VALUES (155, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-24 17:55:13', 1);
INSERT INTO `sys_logininfor` VALUES (156, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-24 17:55:18', 1);
INSERT INTO `sys_logininfor` VALUES (157, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:55:26', 1);
INSERT INTO `sys_logininfor` VALUES (158, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-24 17:55:29', 1);
INSERT INTO `sys_logininfor` VALUES (159, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:55:36', 1);
INSERT INTO `sys_logininfor` VALUES (160, '222', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '退出成功', '2025-11-24 17:56:38', 1);
INSERT INTO `sys_logininfor` VALUES (161, 'admin', '127.0.0.1', '内网IP', 'Chrome 12', 'Windows 10', '0', '登录成功', '2025-11-24 17:56:41', 1);
INSERT INTO `sys_logininfor` VALUES (162, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 14:13:55', 1);
INSERT INTO `sys_logininfor` VALUES (163, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 14:16:22', 1);
INSERT INTO `sys_logininfor` VALUES (164, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 14:17:09', 1);
INSERT INTO `sys_logininfor` VALUES (165, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:17:59', 1);
INSERT INTO `sys_logininfor` VALUES (166, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:18:13', 1);
INSERT INTO `sys_logininfor` VALUES (167, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:18:19', 1);
INSERT INTO `sys_logininfor` VALUES (168, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 14:18:31', 1);
INSERT INTO `sys_logininfor` VALUES (169, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:18:43', 1);
INSERT INTO `sys_logininfor` VALUES (170, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 14:24:19', 1);
INSERT INTO `sys_logininfor` VALUES (171, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 14:24:23', 1);
INSERT INTO `sys_logininfor` VALUES (172, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 14:24:26', 1);
INSERT INTO `sys_logininfor` VALUES (173, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:24:45', 1);
INSERT INTO `sys_logininfor` VALUES (174, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:24:47', 1);
INSERT INTO `sys_logininfor` VALUES (175, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '1', '验证码已失效', '2025-11-26 14:24:47', 1);
INSERT INTO `sys_logininfor` VALUES (176, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 14:27:53', 1);
INSERT INTO `sys_logininfor` VALUES (177, 'admin', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '登录成功', '2025-11-26 14:28:22', 1);
INSERT INTO `sys_logininfor` VALUES (178, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-11-26 14:30:21', 1);
INSERT INTO `sys_logininfor` VALUES (179, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 14:30:24', 1);
INSERT INTO `sys_logininfor` VALUES (180, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 14:30:37', 1);
INSERT INTO `sys_logininfor` VALUES (181, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 14:30:40', 1);
INSERT INTO `sys_logininfor` VALUES (182, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 15:44:28', 1);
INSERT INTO `sys_logininfor` VALUES (183, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 15:44:32', 1);
INSERT INTO `sys_logininfor` VALUES (184, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 15:44:34', 1);
INSERT INTO `sys_logininfor` VALUES (185, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 15:44:36', 1);
INSERT INTO `sys_logininfor` VALUES (186, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 16:05:36', 1);
INSERT INTO `sys_logininfor` VALUES (187, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 16:05:39', 1);
INSERT INTO `sys_logininfor` VALUES (188, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 17:44:03', 1);
INSERT INTO `sys_logininfor` VALUES (189, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 18:27:50', 1);
INSERT INTO `sys_logininfor` VALUES (190, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:27:52', 1);
INSERT INTO `sys_logininfor` VALUES (191, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:32:13', 1);
INSERT INTO `sys_logininfor` VALUES (192, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-11-26 18:35:20', 1);
INSERT INTO `sys_logininfor` VALUES (193, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 18:35:23', 1);
INSERT INTO `sys_logininfor` VALUES (194, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:35:26', 1);
INSERT INTO `sys_logininfor` VALUES (195, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:38:24', 1);
INSERT INTO `sys_logininfor` VALUES (196, 'user_a1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 18:38:45', 1);
INSERT INTO `sys_logininfor` VALUES (197, 'user_a2', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 18:39:06', 1);
INSERT INTO `sys_logininfor` VALUES (198, '用户A2', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 18:39:15', 1);
INSERT INTO `sys_logininfor` VALUES (199, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-26 18:39:26', 1);
INSERT INTO `sys_logininfor` VALUES (200, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:39:29', 1);
INSERT INTO `sys_logininfor` VALUES (201, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:39:34', 1);
INSERT INTO `sys_logininfor` VALUES (202, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:39:52', 1);
INSERT INTO `sys_logininfor` VALUES (203, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:40:23', 1);
INSERT INTO `sys_logininfor` VALUES (204, 'user_a1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 18:40:34', 1);
INSERT INTO `sys_logininfor` VALUES (205, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:41:23', 1);
INSERT INTO `sys_logininfor` VALUES (206, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:42:31', 1);
INSERT INTO `sys_logininfor` VALUES (207, 'user_a1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 18:42:46', 1);
INSERT INTO `sys_logininfor` VALUES (208, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:42:52', 1);
INSERT INTO `sys_logininfor` VALUES (209, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:43:21', 1);
INSERT INTO `sys_logininfor` VALUES (210, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-11-26 18:46:40', 1);
INSERT INTO `sys_logininfor` VALUES (211, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:46:51', 1);
INSERT INTO `sys_logininfor` VALUES (212, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:47:28', 1);
INSERT INTO `sys_logininfor` VALUES (213, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:47:36', 1);
INSERT INTO `sys_logininfor` VALUES (214, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 18:48:00', 1);
INSERT INTO `sys_logininfor` VALUES (215, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 18:48:05', 1);
INSERT INTO `sys_logininfor` VALUES (216, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 19:01:17', 1);
INSERT INTO `sys_logininfor` VALUES (217, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 19:01:21', 1);
INSERT INTO `sys_logininfor` VALUES (218, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-26 19:39:23', 1);
INSERT INTO `sys_logininfor` VALUES (219, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-26 19:39:29', 1);
INSERT INTO `sys_logininfor` VALUES (220, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-26 19:39:33', 1);
INSERT INTO `sys_logininfor` VALUES (221, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:25:57', 1);
INSERT INTO `sys_logininfor` VALUES (222, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-28 17:26:58', 1);
INSERT INTO `sys_logininfor` VALUES (223, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:27:02', 1);
INSERT INTO `sys_logininfor` VALUES (224, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:47:47', 1);
INSERT INTO `sys_logininfor` VALUES (225, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-28 17:48:34', 1);
INSERT INTO `sys_logininfor` VALUES (226, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-28 17:48:40', 1);
INSERT INTO `sys_logininfor` VALUES (227, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-28 17:48:57', 1);
INSERT INTO `sys_logininfor` VALUES (228, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-28 17:49:48', 1);
INSERT INTO `sys_logininfor` VALUES (229, '123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-28 17:50:03', 1);
INSERT INTO `sys_logininfor` VALUES (230, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-28 17:50:07', 1);
INSERT INTO `sys_logininfor` VALUES (231, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:50:09', 1);
INSERT INTO `sys_logininfor` VALUES (232, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-28 17:50:50', 1);
INSERT INTO `sys_logininfor` VALUES (233, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-11-28 17:51:05', 1);
INSERT INTO `sys_logininfor` VALUES (234, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:51:11', 1);
INSERT INTO `sys_logininfor` VALUES (235, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-28 17:52:11', 1);
INSERT INTO `sys_logininfor` VALUES (236, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:52:17', 1);
INSERT INTO `sys_logininfor` VALUES (237, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-28 17:52:54', 1);
INSERT INTO `sys_logininfor` VALUES (238, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-28 17:53:05', 1);
INSERT INTO `sys_logininfor` VALUES (239, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 16:33:57', 1);
INSERT INTO `sys_logininfor` VALUES (240, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 16:34:24', 1);
INSERT INTO `sys_logininfor` VALUES (241, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 16:34:31', 1);
INSERT INTO `sys_logininfor` VALUES (242, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:37:36', 1);
INSERT INTO `sys_logininfor` VALUES (243, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:37:44', 1);
INSERT INTO `sys_logininfor` VALUES (244, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:40:14', 1);
INSERT INTO `sys_logininfor` VALUES (245, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:45:38', 1);
INSERT INTO `sys_logininfor` VALUES (246, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:45:46', 1);
INSERT INTO `sys_logininfor` VALUES (247, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:45:49', 1);
INSERT INTO `sys_logininfor` VALUES (248, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 16:45:53', 1);
INSERT INTO `sys_logininfor` VALUES (249, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:45:57', 1);
INSERT INTO `sys_logininfor` VALUES (250, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:46:18', 1);
INSERT INTO `sys_logininfor` VALUES (251, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:47:30', 1);
INSERT INTO `sys_logininfor` VALUES (252, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:52:04', 1);
INSERT INTO `sys_logininfor` VALUES (253, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:52:09', 1);
INSERT INTO `sys_logininfor` VALUES (254, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 16:53:00', 1);
INSERT INTO `sys_logininfor` VALUES (255, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:53:39', 1);
INSERT INTO `sys_logininfor` VALUES (256, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-29 16:53:51', 1);
INSERT INTO `sys_logininfor` VALUES (257, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 16:54:19', 1);
INSERT INTO `sys_logininfor` VALUES (258, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:00:04', 1);
INSERT INTO `sys_logininfor` VALUES (259, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:00:47', 1);
INSERT INTO `sys_logininfor` VALUES (260, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:00:51', 1);
INSERT INTO `sys_logininfor` VALUES (261, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:02:16', 1);
INSERT INTO `sys_logininfor` VALUES (262, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:03:15', 1);
INSERT INTO `sys_logininfor` VALUES (263, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:03:53', 1);
INSERT INTO `sys_logininfor` VALUES (264, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:05:20', 1);
INSERT INTO `sys_logininfor` VALUES (265, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:07:06', 1);
INSERT INTO `sys_logininfor` VALUES (266, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:07:51', 1);
INSERT INTO `sys_logininfor` VALUES (267, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:07:55', 1);
INSERT INTO `sys_logininfor` VALUES (268, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:08:27', 1);
INSERT INTO `sys_logininfor` VALUES (269, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:08:31', 1);
INSERT INTO `sys_logininfor` VALUES (270, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:09:30', 1);
INSERT INTO `sys_logininfor` VALUES (271, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:09:32', 1);
INSERT INTO `sys_logininfor` VALUES (272, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:15:28', 1);
INSERT INTO `sys_logininfor` VALUES (273, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:15:36', 1);
INSERT INTO `sys_logininfor` VALUES (274, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:17:23', 1);
INSERT INTO `sys_logininfor` VALUES (275, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:17:28', 1);
INSERT INTO `sys_logininfor` VALUES (276, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:24:44', 1);
INSERT INTO `sys_logininfor` VALUES (277, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:24:48', 1);
INSERT INTO `sys_logininfor` VALUES (278, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:28:07', 1);
INSERT INTO `sys_logininfor` VALUES (279, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:28:13', 1);
INSERT INTO `sys_logininfor` VALUES (280, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:30:05', 1);
INSERT INTO `sys_logininfor` VALUES (281, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:30:07', 1);
INSERT INTO `sys_logininfor` VALUES (282, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:31:28', 1);
INSERT INTO `sys_logininfor` VALUES (283, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:31:32', 1);
INSERT INTO `sys_logininfor` VALUES (284, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:40:27', 1);
INSERT INTO `sys_logininfor` VALUES (285, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:40:31', 1);
INSERT INTO `sys_logininfor` VALUES (286, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:43:41', 1);
INSERT INTO `sys_logininfor` VALUES (287, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:43:45', 1);
INSERT INTO `sys_logininfor` VALUES (288, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:45:30', 1);
INSERT INTO `sys_logininfor` VALUES (289, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:45:33', 1);
INSERT INTO `sys_logininfor` VALUES (290, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:47:07', 1);
INSERT INTO `sys_logininfor` VALUES (291, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:48:04', 1);
INSERT INTO `sys_logininfor` VALUES (292, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:50:09', 1);
INSERT INTO `sys_logininfor` VALUES (293, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:50:13', 1);
INSERT INTO `sys_logininfor` VALUES (294, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:52:01', 1);
INSERT INTO `sys_logininfor` VALUES (295, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:52:04', 1);
INSERT INTO `sys_logininfor` VALUES (296, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:53:18', 1);
INSERT INTO `sys_logininfor` VALUES (297, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:53:22', 1);
INSERT INTO `sys_logininfor` VALUES (298, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:54:27', 1);
INSERT INTO `sys_logininfor` VALUES (299, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:54:34', 1);
INSERT INTO `sys_logininfor` VALUES (300, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 17:56:44', 1);
INSERT INTO `sys_logininfor` VALUES (301, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 17:56:47', 1);
INSERT INTO `sys_logininfor` VALUES (302, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:14:47', 1);
INSERT INTO `sys_logininfor` VALUES (303, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:14:51', 1);
INSERT INTO `sys_logininfor` VALUES (304, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:15:03', 1);
INSERT INTO `sys_logininfor` VALUES (305, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:15:19', 1);
INSERT INTO `sys_logininfor` VALUES (306, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:20:18', 1);
INSERT INTO `sys_logininfor` VALUES (307, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:20:21', 1);
INSERT INTO `sys_logininfor` VALUES (308, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-11-29 18:28:44', 1);
INSERT INTO `sys_logininfor` VALUES (309, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 18:28:48', 1);
INSERT INTO `sys_logininfor` VALUES (310, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 18:41:34', 1);
INSERT INTO `sys_logininfor` VALUES (311, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:41:37', 1);
INSERT INTO `sys_logininfor` VALUES (312, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:53:32', 1);
INSERT INTO `sys_logininfor` VALUES (313, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 18:53:38', 1);
INSERT INTO `sys_logininfor` VALUES (314, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 19:01:12', 1);
INSERT INTO `sys_logininfor` VALUES (315, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 19:01:51', 1);
INSERT INTO `sys_logininfor` VALUES (316, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 19:02:23', 1);
INSERT INTO `sys_logininfor` VALUES (317, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-29 19:09:47', 1);
INSERT INTO `sys_logininfor` VALUES (318, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 19:09:53', 1);
INSERT INTO `sys_logininfor` VALUES (319, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-11-29 19:12:57', 1);
INSERT INTO `sys_logininfor` VALUES (320, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 19:14:04', 1);
INSERT INTO `sys_logininfor` VALUES (321, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 19:14:09', 1);
INSERT INTO `sys_logininfor` VALUES (322, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 19:14:17', 1);
INSERT INTO `sys_logininfor` VALUES (323, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 19:14:25', 1);
INSERT INTO `sys_logininfor` VALUES (324, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-11-29 19:14:37', 1);
INSERT INTO `sys_logininfor` VALUES (325, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 19:14:40', 1);
INSERT INTO `sys_logininfor` VALUES (326, 'ry', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 19:14:45', 1);
INSERT INTO `sys_logininfor` VALUES (327, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 19:14:55', 1);
INSERT INTO `sys_logininfor` VALUES (328, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 19:17:46', 1);
INSERT INTO `sys_logininfor` VALUES (329, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-11-29 19:17:52', 1);
INSERT INTO `sys_logininfor` VALUES (330, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-11-29 19:17:58', 1);
INSERT INTO `sys_logininfor` VALUES (331, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:00:43', 1);
INSERT INTO `sys_logininfor` VALUES (332, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:00:49', 1);
INSERT INTO `sys_logininfor` VALUES (333, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-12-01 15:00:54', 1);
INSERT INTO `sys_logininfor` VALUES (334, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码错误', '2025-12-01 15:00:58', 1);
INSERT INTO `sys_logininfor` VALUES (335, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:01:01', 1);
INSERT INTO `sys_logininfor` VALUES (336, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:05:13', 1);
INSERT INTO `sys_logininfor` VALUES (337, '123123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-12-01 15:07:03', 1);
INSERT INTO `sys_logininfor` VALUES (338, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '验证码已失效', '2025-12-01 15:19:42', 1);
INSERT INTO `sys_logininfor` VALUES (339, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:19:47', 1);
INSERT INTO `sys_logininfor` VALUES (340, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:20:10', 1);
INSERT INTO `sys_logininfor` VALUES (341, '123456', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-01 15:20:26', 1);
INSERT INTO `sys_logininfor` VALUES (342, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:21:15', 1);
INSERT INTO `sys_logininfor` VALUES (343, '123456', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-01 15:21:42', 1);
INSERT INTO `sys_logininfor` VALUES (344, '123789', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-01 15:23:05', 1);
INSERT INTO `sys_logininfor` VALUES (345, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:24:44', 1);
INSERT INTO `sys_logininfor` VALUES (346, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:24:48', 1);
INSERT INTO `sys_logininfor` VALUES (347, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:25:53', 1);
INSERT INTO `sys_logininfor` VALUES (348, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:25:59', 1);
INSERT INTO `sys_logininfor` VALUES (349, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:26:09', 1);
INSERT INTO `sys_logininfor` VALUES (350, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:26:19', 1);
INSERT INTO `sys_logininfor` VALUES (351, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:29:10', 1);
INSERT INTO `sys_logininfor` VALUES (352, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:29:20', 1);
INSERT INTO `sys_logininfor` VALUES (353, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:30:41', 1);
INSERT INTO `sys_logininfor` VALUES (354, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:30:42', 1);
INSERT INTO `sys_logininfor` VALUES (355, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:38:11', 1);
INSERT INTO `sys_logininfor` VALUES (356, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:38:18', 1);
INSERT INTO `sys_logininfor` VALUES (357, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:38:42', 1);
INSERT INTO `sys_logininfor` VALUES (358, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:38:50', 1);
INSERT INTO `sys_logininfor` VALUES (359, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:41:19', 1);
INSERT INTO `sys_logininfor` VALUES (360, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:41:21', 1);
INSERT INTO `sys_logininfor` VALUES (361, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 15:55:52', 1);
INSERT INTO `sys_logininfor` VALUES (362, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 15:56:00', 1);
INSERT INTO `sys_logininfor` VALUES (363, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:01:06', 1);
INSERT INTO `sys_logininfor` VALUES (364, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:01:10', 1);
INSERT INTO `sys_logininfor` VALUES (365, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:08:12', 1);
INSERT INTO `sys_logininfor` VALUES (366, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:08:21', 1);
INSERT INTO `sys_logininfor` VALUES (367, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:09:51', 1);
INSERT INTO `sys_logininfor` VALUES (368, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:09:54', 1);
INSERT INTO `sys_logininfor` VALUES (369, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:10:08', 1);
INSERT INTO `sys_logininfor` VALUES (370, 'admin123', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-12-01 16:10:14', 1);
INSERT INTO `sys_logininfor` VALUES (371, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:10:21', 1);
INSERT INTO `sys_logininfor` VALUES (372, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:10:49', 1);
INSERT INTO `sys_logininfor` VALUES (373, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:10:55', 1);
INSERT INTO `sys_logininfor` VALUES (374, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:10:58', 1);
INSERT INTO `sys_logininfor` VALUES (375, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:11:04', 1);
INSERT INTO `sys_logininfor` VALUES (376, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:11:54', 1);
INSERT INTO `sys_logininfor` VALUES (377, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:12:04', 1);
INSERT INTO `sys_logininfor` VALUES (378, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:13:08', 1);
INSERT INTO `sys_logininfor` VALUES (379, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:13:14', 1);
INSERT INTO `sys_logininfor` VALUES (380, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:13:26', 1);
INSERT INTO `sys_logininfor` VALUES (381, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:13:31', 1);
INSERT INTO `sys_logininfor` VALUES (382, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:42:59', 1);
INSERT INTO `sys_logininfor` VALUES (383, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:43:06', 1);
INSERT INTO `sys_logininfor` VALUES (384, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:48:03', 1);
INSERT INTO `sys_logininfor` VALUES (385, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-01 16:48:08', 1);
INSERT INTO `sys_logininfor` VALUES (386, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-01 16:49:46', 1);
INSERT INTO `sys_logininfor` VALUES (387, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-12-08 14:19:40', 1);
INSERT INTO `sys_logininfor` VALUES (388, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 14:19:43', 1);
INSERT INTO `sys_logininfor` VALUES (389, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 14:54:23', 1);
INSERT INTO `sys_logininfor` VALUES (390, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 14:57:01', 1);
INSERT INTO `sys_logininfor` VALUES (391, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 14:57:06', 1);
INSERT INTO `sys_logininfor` VALUES (392, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:26:19', 1);
INSERT INTO `sys_logininfor` VALUES (393, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:26:25', 1);
INSERT INTO `sys_logininfor` VALUES (394, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:27:22', 1);
INSERT INTO `sys_logininfor` VALUES (395, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:27:33', 1);
INSERT INTO `sys_logininfor` VALUES (396, '111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:31:13', 1);
INSERT INTO `sys_logininfor` VALUES (397, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:31:15', 1);
INSERT INTO `sys_logininfor` VALUES (398, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:35:18', 1);
INSERT INTO `sys_logininfor` VALUES (399, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:35:32', 1);
INSERT INTO `sys_logininfor` VALUES (400, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:36:50', 1);
INSERT INTO `sys_logininfor` VALUES (401, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:36:55', 1);
INSERT INTO `sys_logininfor` VALUES (402, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:38:37', 1);
INSERT INTO `sys_logininfor` VALUES (403, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:38:46', 1);
INSERT INTO `sys_logininfor` VALUES (404, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:44:05', 1);
INSERT INTO `sys_logininfor` VALUES (405, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:44:11', 1);
INSERT INTO `sys_logininfor` VALUES (406, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:48:07', 1);
INSERT INTO `sys_logininfor` VALUES (407, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:48:13', 1);
INSERT INTO `sys_logininfor` VALUES (408, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:48:39', 1);
INSERT INTO `sys_logininfor` VALUES (409, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:48:45', 1);
INSERT INTO `sys_logininfor` VALUES (410, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:48:50', 1);
INSERT INTO `sys_logininfor` VALUES (411, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:49:02', 1);
INSERT INTO `sys_logininfor` VALUES (412, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:49:56', 1);
INSERT INTO `sys_logininfor` VALUES (413, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:50:00', 1);
INSERT INTO `sys_logininfor` VALUES (414, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:53:11', 1);
INSERT INTO `sys_logininfor` VALUES (415, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:53:19', 1);
INSERT INTO `sys_logininfor` VALUES (416, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:57:24', 1);
INSERT INTO `sys_logininfor` VALUES (417, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:57:28', 1);
INSERT INTO `sys_logininfor` VALUES (418, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:57:34', 1);
INSERT INTO `sys_logininfor` VALUES (419, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:57:40', 1);
INSERT INTO `sys_logininfor` VALUES (420, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:57:54', 1);
INSERT INTO `sys_logininfor` VALUES (421, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:58:01', 1);
INSERT INTO `sys_logininfor` VALUES (422, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:58:05', 1);
INSERT INTO `sys_logininfor` VALUES (423, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:58:12', 1);
INSERT INTO `sys_logininfor` VALUES (424, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 15:58:30', 1);
INSERT INTO `sys_logininfor` VALUES (425, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 15:58:35', 1);
INSERT INTO `sys_logininfor` VALUES (426, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:12:18', 1);
INSERT INTO `sys_logininfor` VALUES (427, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:12:23', 1);
INSERT INTO `sys_logininfor` VALUES (428, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:14:18', 1);
INSERT INTO `sys_logininfor` VALUES (429, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:14:24', 1);
INSERT INTO `sys_logininfor` VALUES (430, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:14:28', 1);
INSERT INTO `sys_logininfor` VALUES (431, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:14:35', 1);
INSERT INTO `sys_logininfor` VALUES (432, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:17:18', 1);
INSERT INTO `sys_logininfor` VALUES (433, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:17:21', 1);
INSERT INTO `sys_logininfor` VALUES (434, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:17:46', 1);
INSERT INTO `sys_logininfor` VALUES (435, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:17:52', 1);
INSERT INTO `sys_logininfor` VALUES (436, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:18:05', 1);
INSERT INTO `sys_logininfor` VALUES (437, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:18:09', 1);
INSERT INTO `sys_logininfor` VALUES (438, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:18:28', 1);
INSERT INTO `sys_logininfor` VALUES (439, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:18:34', 1);
INSERT INTO `sys_logininfor` VALUES (440, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:19:17', 1);
INSERT INTO `sys_logininfor` VALUES (441, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:19:24', 1);
INSERT INTO `sys_logininfor` VALUES (442, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:32:50', 1);
INSERT INTO `sys_logininfor` VALUES (443, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:32:56', 1);
INSERT INTO `sys_logininfor` VALUES (444, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 16:58:51', 1);
INSERT INTO `sys_logininfor` VALUES (445, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 16:58:55', 1);
INSERT INTO `sys_logininfor` VALUES (446, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 17:00:31', 1);
INSERT INTO `sys_logininfor` VALUES (447, '1111', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-12-08 17:02:03', 1);
INSERT INTO `sys_logininfor` VALUES (448, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 17:05:28', 1);
INSERT INTO `sys_logininfor` VALUES (449, '123789', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-08 17:09:07', 1);
INSERT INTO `sys_logininfor` VALUES (450, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 17:17:02', 1);
INSERT INTO `sys_logininfor` VALUES (451, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 17:17:04', 1);
INSERT INTO `sys_logininfor` VALUES (452, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 17:17:06', 1);
INSERT INTO `sys_logininfor` VALUES (453, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 17:17:12', 1);
INSERT INTO `sys_logininfor` VALUES (454, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-08 17:17:40', 1);
INSERT INTO `sys_logininfor` VALUES (455, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 17:17:45', 1);
INSERT INTO `sys_logininfor` VALUES (456, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-08 18:56:29', 1);
INSERT INTO `sys_logininfor` VALUES (457, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 14:23:31', 1);
INSERT INTO `sys_logininfor` VALUES (458, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 14:23:34', 1);
INSERT INTO `sys_logininfor` VALUES (459, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 14:25:58', 1);
INSERT INTO `sys_logininfor` VALUES (460, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 14:26:00', 1);
INSERT INTO `sys_logininfor` VALUES (461, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 14:26:04', 1);
INSERT INTO `sys_logininfor` VALUES (462, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 14:46:46', 1);
INSERT INTO `sys_logininfor` VALUES (463, 'admin123556', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 14:46:57', 1);
INSERT INTO `sys_logininfor` VALUES (464, 'admin123556', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 14:47:05', 1);
INSERT INTO `sys_logininfor` VALUES (465, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 14:47:15', 1);
INSERT INTO `sys_logininfor` VALUES (466, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 16:05:40', 1);
INSERT INTO `sys_logininfor` VALUES (467, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 16:17:32', 1);
INSERT INTO `sys_logininfor` VALUES (468, 'aaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-12-09 16:17:46', 1);
INSERT INTO `sys_logininfor` VALUES (469, 'aaaa', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '注册成功', '2025-12-09 16:18:51', 1);
INSERT INTO `sys_logininfor` VALUES (470, 'aaa1', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-09 16:19:39', 1);
INSERT INTO `sys_logininfor` VALUES (471, 'aaa1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 16:20:09', 1);
INSERT INTO `sys_logininfor` VALUES (472, 'aaa1', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 16:20:12', 1);
INSERT INTO `sys_logininfor` VALUES (473, 'aaa2', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-09 16:26:18', 1);
INSERT INTO `sys_logininfor` VALUES (474, 'aaa2', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-09 16:27:15', 1);
INSERT INTO `sys_logininfor` VALUES (475, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-09 16:32:49', 1);
INSERT INTO `sys_logininfor` VALUES (476, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-09 16:34:14', 1);
INSERT INTO `sys_logininfor` VALUES (477, 'aaa3', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-09 16:40:00', 1);
INSERT INTO `sys_logininfor` VALUES (478, 'aaa4', '127.0.0.1', '内网IP', 'Unknown', 'Unknown', '0', '注册成功', '2025-12-09 16:43:38', 1);
INSERT INTO `sys_logininfor` VALUES (479, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 13:46:50', 1);
INSERT INTO `sys_logininfor` VALUES (480, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 14:52:50', 1);
INSERT INTO `sys_logininfor` VALUES (481, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 14:52:56', 1);
INSERT INTO `sys_logininfor` VALUES (482, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 14:53:07', 1);
INSERT INTO `sys_logininfor` VALUES (483, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 14:53:15', 1);
INSERT INTO `sys_logininfor` VALUES (484, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 14:53:47', 1);
INSERT INTO `sys_logininfor` VALUES (485, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 14:53:51', 1);
INSERT INTO `sys_logininfor` VALUES (486, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 14:56:11', 1);
INSERT INTO `sys_logininfor` VALUES (487, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 14:56:16', 1);
INSERT INTO `sys_logininfor` VALUES (488, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:09:54', 1);
INSERT INTO `sys_logininfor` VALUES (489, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 16:10:12', 1);
INSERT INTO `sys_logininfor` VALUES (490, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:10:30', 1);
INSERT INTO `sys_logininfor` VALUES (491, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 16:10:55', 1);
INSERT INTO `sys_logininfor` VALUES (492, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:10:57', 1);
INSERT INTO `sys_logininfor` VALUES (493, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 16:11:35', 1);
INSERT INTO `sys_logininfor` VALUES (494, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '1', '用户不存在/密码错误', '2025-12-11 16:11:43', 1);
INSERT INTO `sys_logininfor` VALUES (495, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:11:48', 1);
INSERT INTO `sys_logininfor` VALUES (496, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 16:12:47', 1);
INSERT INTO `sys_logininfor` VALUES (497, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:15:09', 1);
INSERT INTO `sys_logininfor` VALUES (498, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-11 16:19:05', 1);
INSERT INTO `sys_logininfor` VALUES (499, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-11 16:19:10', 1);
INSERT INTO `sys_logininfor` VALUES (500, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-13 16:05:29', 1);
INSERT INTO `sys_logininfor` VALUES (501, 'admin', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '退出成功', '2025-12-13 16:05:35', 1);
INSERT INTO `sys_logininfor` VALUES (502, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-13 16:05:52', 1);
INSERT INTO `sys_logininfor` VALUES (503, '11', '127.0.0.1', '内网IP', 'Chrome 14', 'Windows 10', '0', '登录成功', '2025-12-13 16:43:32', 1);

-- ----------------------------
-- Table structure for sys_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_menu`;
CREATE TABLE `sys_menu`  (
  `menu_id` bigint NOT NULL AUTO_INCREMENT COMMENT '菜单ID',
  `menu_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '菜单名称',
  `parent_id` bigint NULL DEFAULT 0 COMMENT '父菜单ID',
  `order_num` int NULL DEFAULT 0 COMMENT '显示顺序',
  `path` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由地址',
  `component` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '组件路径',
  `query` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '路由参数',
  `route_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '路由名称',
  `is_frame` int NULL DEFAULT 1 COMMENT '是否为外链（0是 1否）',
  `is_cache` int NULL DEFAULT 0 COMMENT '是否缓存（0缓存 1不缓存）',
  `menu_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '菜单类型（M目录 C菜单 F按钮）',
  `visible` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0显示 1隐藏）',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '菜单状态（0正常 1停用）',
  `perms` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '权限标识',
  `icon` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '#' COMMENT '菜单图标',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`menu_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 2005 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '菜单权限表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_menu
-- ----------------------------
INSERT INTO `sys_menu` VALUES (1, '系统管理', 0, 1, 'system', NULL, '', '', 1, 0, 'M', '0', '0', '', 'system', 'admin', '2025-11-06 13:59:56', '', NULL, '系统管理目录', 1);
INSERT INTO `sys_menu` VALUES (2, '系统监控', 0, 2, 'monitor', NULL, '', '', 1, 0, 'M', '0', '0', '', 'monitor', 'admin', '2025-11-06 13:59:56', '', NULL, '系统监控目录', 1);
INSERT INTO `sys_menu` VALUES (3, '系统工具', 0, 3, 'tool', NULL, '', '', 1, 0, 'M', '0', '0', '', 'tool', 'admin', '2025-11-06 13:59:56', '', NULL, '系统工具目录', 1);
INSERT INTO `sys_menu` VALUES (100, '用户管理', 1, 1, 'user', 'system/user/index', '', '', 1, 0, 'C', '0', '0', 'system:user:list', 'user', 'admin', '2025-11-06 13:59:56', '', NULL, '用户管理菜单', 1);
INSERT INTO `sys_menu` VALUES (101, '角色管理', 1, 2, 'role', 'system/role/index', '', '', 1, 0, 'C', '0', '0', 'system:role:list', 'peoples', 'admin', '2025-11-06 13:59:56', '', NULL, '角色管理菜单', 1);
INSERT INTO `sys_menu` VALUES (102, '菜单管理', 1, 3, 'menu', 'system/menu/index', '', '', 1, 0, 'C', '0', '0', 'system:menu:list', 'tree-table', 'admin', '2025-11-06 13:59:56', '', NULL, '菜单管理菜单', 1);
INSERT INTO `sys_menu` VALUES (103, '部门管理', 1, 4, 'dept', 'system/dept/index', '', '', 1, 0, 'C', '0', '0', 'system:dept:list', 'tree', 'admin', '2025-11-06 13:59:56', '', NULL, '部门管理菜单', 1);
INSERT INTO `sys_menu` VALUES (104, '岗位管理', 1, 5, 'post', 'system/post/index', '', '', 1, 0, 'C', '0', '0', 'system:post:list', 'post', 'admin', '2025-11-06 13:59:56', '', NULL, '岗位管理菜单', 1);
INSERT INTO `sys_menu` VALUES (105, '字典管理', 1, 6, 'dict', 'system/dict/index', '', '', 1, 0, 'C', '0', '0', 'system:dict:list', 'dict', 'admin', '2025-11-06 13:59:56', '', NULL, '字典管理菜单', 1);
INSERT INTO `sys_menu` VALUES (106, '参数设置', 1, 7, 'config', 'system/config/index', '', '', 1, 0, 'C', '0', '0', 'system:config:list', 'edit', 'admin', '2025-11-06 13:59:56', '', NULL, '参数设置菜单', 1);
INSERT INTO `sys_menu` VALUES (107, '通知公告', 1, 8, 'notice', 'system/notice/index', '', '', 1, 0, 'C', '0', '0', 'system:notice:list', 'message', 'admin', '2025-11-06 13:59:56', '', NULL, '通知公告菜单', 1);
INSERT INTO `sys_menu` VALUES (108, '日志管理', 1, 9, 'log', '', '', '', 1, 0, 'M', '0', '0', '', 'log', 'admin', '2025-11-06 13:59:56', '', NULL, '日志管理菜单', 1);
INSERT INTO `sys_menu` VALUES (109, '在线用户', 2, 1, 'online', 'monitor/online/index', '', '', 1, 0, 'C', '0', '0', 'monitor:online:list', 'online', 'admin', '2025-11-06 13:59:56', '', NULL, '在线用户菜单', 1);
INSERT INTO `sys_menu` VALUES (110, '定时任务', 2, 2, 'job', 'monitor/job/index', '', '', 1, 0, 'C', '0', '0', 'monitor:job:list', 'job', 'admin', '2025-11-06 13:59:56', '', NULL, '定时任务菜单', 1);
INSERT INTO `sys_menu` VALUES (111, '数据监控', 2, 3, 'druid', 'monitor/druid/index', '', '', 1, 0, 'C', '0', '0', 'monitor:druid:list', 'druid', 'admin', '2025-11-06 13:59:56', '', NULL, '数据监控菜单', 1);
INSERT INTO `sys_menu` VALUES (112, '服务监控', 2, 4, 'server', 'monitor/server/index', '', '', 1, 0, 'C', '0', '0', 'monitor:server:list', 'server', 'admin', '2025-11-06 13:59:56', '', NULL, '服务监控菜单', 1);
INSERT INTO `sys_menu` VALUES (113, '缓存监控', 2, 5, 'cache', 'monitor/cache/index', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis', 'admin', '2025-11-06 13:59:56', '', NULL, '缓存监控菜单', 1);
INSERT INTO `sys_menu` VALUES (114, '缓存列表', 2, 6, 'cacheList', 'monitor/cache/list', '', '', 1, 0, 'C', '0', '0', 'monitor:cache:list', 'redis-list', 'admin', '2025-11-06 13:59:56', '', NULL, '缓存列表菜单', 1);
INSERT INTO `sys_menu` VALUES (115, '表单构建', 3, 1, 'build', 'tool/build/index', '', '', 1, 0, 'C', '0', '0', 'tool:build:list', 'build', 'admin', '2025-11-06 13:59:56', '', NULL, '表单构建菜单', 1);
INSERT INTO `sys_menu` VALUES (116, '代码生成', 3, 2, 'gen', 'tool/gen/index', '', '', 1, 0, 'C', '0', '0', 'tool:gen:list', 'code', 'admin', '2025-11-06 13:59:56', '', NULL, '代码生成菜单', 1);
INSERT INTO `sys_menu` VALUES (117, '系统接口', 3, 3, 'swagger', 'tool/swagger/index', '', '', 1, 0, 'C', '0', '0', 'tool:swagger:list', 'swagger', 'admin', '2025-11-06 13:59:56', '', NULL, '系统接口菜单', 1);
INSERT INTO `sys_menu` VALUES (500, '操作日志', 108, 1, 'operlog', 'monitor/operlog/index', '', '', 1, 0, 'C', '0', '0', 'monitor:operlog:list', 'form', 'admin', '2025-11-06 13:59:56', '', NULL, '操作日志菜单', 1);
INSERT INTO `sys_menu` VALUES (501, '登录日志', 108, 2, 'logininfor', 'monitor/logininfor/index', '', '', 1, 0, 'C', '0', '0', 'monitor:logininfor:list', 'logininfor', 'admin', '2025-11-06 13:59:56', '', NULL, '登录日志菜单', 1);
INSERT INTO `sys_menu` VALUES (1000, '用户查询', 100, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1001, '用户新增', 100, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1002, '用户修改', 100, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1003, '用户删除', 100, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1004, '用户导出', 100, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1005, '用户导入', 100, 6, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:import', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1006, '重置密码', 100, 7, '', '', '', '', 1, 0, 'F', '0', '0', 'system:user:resetPwd', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1007, '角色查询', 101, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1008, '角色新增', 101, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1009, '角色修改', 101, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1010, '角色删除', 101, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1011, '角色导出', 101, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:role:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1012, '菜单查询', 102, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1013, '菜单新增', 102, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1014, '菜单修改', 102, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1015, '菜单删除', 102, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:menu:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1016, '部门查询', 103, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1017, '部门新增', 103, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1018, '部门修改', 103, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1019, '部门删除', 103, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:dept:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1020, '岗位查询', 104, 1, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1021, '岗位新增', 104, 2, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1022, '岗位修改', 104, 3, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1023, '岗位删除', 104, 4, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1024, '岗位导出', 104, 5, '', '', '', '', 1, 0, 'F', '0', '0', 'system:post:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1025, '字典查询', 105, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1026, '字典新增', 105, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1027, '字典修改', 105, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1028, '字典删除', 105, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1029, '字典导出', 105, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:dict:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1030, '参数查询', 106, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1031, '参数新增', 106, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1032, '参数修改', 106, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1033, '参数删除', 106, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1034, '参数导出', 106, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:config:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1035, '公告查询', 107, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1036, '公告新增', 107, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1037, '公告修改', 107, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1038, '公告删除', 107, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'system:notice:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1039, '操作查询', 500, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1040, '操作删除', 500, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1041, '日志导出', 500, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:operlog:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1042, '登录查询', 501, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1043, '登录删除', 501, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1044, '日志导出', 501, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1045, '账户解锁', 501, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:logininfor:unlock', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1046, '在线查询', 109, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1047, '批量强退', 109, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:batchLogout', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1048, '单条强退', 109, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:online:forceLogout', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1049, '任务查询', 110, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1050, '任务新增', 110, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:add', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1051, '任务修改', 110, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1052, '任务删除', 110, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1053, '状态修改', 110, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:changeStatus', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1054, '任务导出', 110, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'monitor:job:export', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1055, '生成查询', 116, 1, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:query', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1056, '生成修改', 116, 2, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:edit', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1057, '生成删除', 116, 3, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:remove', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1058, '导入代码', 116, 4, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:import', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1059, '预览代码', 116, 5, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:preview', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (1060, '生成代码', 116, 6, '#', '', '', '', 1, 0, 'F', '0', '0', 'tool:gen:code', '#', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (2000, '客户管理', 0, 4, 'customer', 'customer/guest/index', NULL, '', 1, 0, 'C', '0', '0', 'customer:guest:list', 'cascader', 'admin', '2025-11-06 14:07:35', 'admin', '2025-11-25 14:31:13', '', 1);
INSERT INTO `sys_menu` VALUES (2001, '公司架构', 0, 5, 'company', NULL, NULL, '', 1, 0, 'M', '0', '0', '', 'github', 'admin', '2025-11-25 14:31:42', 'admin', '2025-11-26 16:41:54', '', 1);
INSERT INTO `sys_menu` VALUES (2002, '团队', 2001, 1, 'teams', 'company/teams/index', NULL, '', 1, 0, 'C', '0', '0', 'company:teams:list', 'peoples', 'admin', '2025-11-25 14:32:38', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (2003, '人员', 2001, 2, 'staff', 'company/staff/index', NULL, '', 1, 0, 'C', '0', '0', 'company:staff:list', 'people', 'admin', '2025-11-25 14:33:18', '', NULL, '', 1);
INSERT INTO `sys_menu` VALUES (2004, '公司视图', 0, 6, 'manage', 'company/manage/index', NULL, '', 1, 0, 'C', '0', '0', 'company:manange', 'list', 'admin', '2025-12-11 16:20:15', 'admin', '2025-12-11 16:22:31', '', 1);

-- ----------------------------
-- Table structure for sys_notice
-- ----------------------------
DROP TABLE IF EXISTS `sys_notice`;
CREATE TABLE `sys_notice`  (
  `notice_id` int NOT NULL AUTO_INCREMENT COMMENT '公告ID',
  `notice_title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告标题',
  `notice_type` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '公告类型（1通知 2公告）',
  `notice_content` longblob NULL COMMENT '公告内容',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '公告状态（0正常 1关闭）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`notice_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 10 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '通知公告表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_notice
-- ----------------------------
INSERT INTO `sys_notice` VALUES (1, '温馨提醒：2018-07-01 若依新版本发布啦', '2', 0xE696B0E78988E69CACE58685E5AEB9, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '管理员', 0);
INSERT INTO `sys_notice` VALUES (2, '维护通知：2018-07-01 若依系统凌晨维护', '1', 0xE7BBB4E68AA4E58685E5AEB9, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '管理员', 0);

-- ----------------------------
-- Table structure for sys_oper_log
-- ----------------------------
DROP TABLE IF EXISTS `sys_oper_log`;
CREATE TABLE `sys_oper_log`  (
  `oper_id` bigint NOT NULL AUTO_INCREMENT COMMENT '日志主键',
  `title` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '模块标题',
  `business_type` int NULL DEFAULT 0 COMMENT '业务类型（0其它 1新增 2修改 3删除）',
  `method` varchar(200) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '方法名称',
  `request_method` varchar(10) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求方式',
  `operator_type` int NULL DEFAULT 0 COMMENT '操作类别（0其它 1后台用户 2手机端用户）',
  `oper_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作人员',
  `dept_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '部门名称',
  `oper_url` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求URL',
  `oper_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '主机地址',
  `oper_location` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '操作地点',
  `oper_param` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '请求参数',
  `json_result` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '返回参数',
  `status` int NULL DEFAULT 0 COMMENT '操作状态（0正常 1异常）',
  `error_msg` varchar(2000) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '错误消息',
  `oper_time` datetime NULL DEFAULT NULL COMMENT '操作时间',
  `cost_time` bigint NULL DEFAULT 0 COMMENT '消耗时间',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`oper_id`) USING BTREE,
  INDEX `idx_sys_oper_log_bt`(`business_type` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_s`(`status` ASC) USING BTREE,
  INDEX `idx_sys_oper_log_ot`(`oper_time` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 239 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '操作日志记录' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_oper_log
-- ----------------------------
INSERT INTO `sys_oper_log` VALUES (100, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-11-06 14:00:48', 30, 1);
INSERT INTO `sys_oper_log` VALUES (101, '菜单管理', 3, 'com.ruoyi.web.controller.system.SysMenuController.remove()', 'DELETE', 1, 'admin', '研发部门', '/system/menu/4', '127.0.0.1', '内网IP', '4', '{\"msg\":\"菜单已分配,不允许删除\",\"code\":601}', 0, NULL, '2025-11-06 14:01:05', 8, 1);
INSERT INTO `sys_oper_log` VALUES (102, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"企业角色\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:05:42', 80, 1);
INSERT INTO `sys_oper_log` VALUES (103, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:05:53', 38, 1);
INSERT INTO `sys_oper_log` VALUES (104, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:06:41', 33, 1);
INSERT INTO `sys_oper_log` VALUES (105, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"/custermor\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:07:35', 32, 1);
INSERT INTO `sys_oper_log` VALUES (106, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:08:05', 17, 1);
INSERT INTO `sys_oper_log` VALUES (107, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"tool:\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:08:29', 15, 1);
INSERT INTO `sys_oper_log` VALUES (108, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"tool:customer:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:08:42', 21, 1);
INSERT INTO `sys_oper_log` VALUES (109, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"\",\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"system:customer:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-06 14:10:05', 13, 1);
INSERT INTO `sys_oper_log` VALUES (110, '字典类型', 9, 'com.ruoyi.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:38:41', 12, 1);
INSERT INTO `sys_oper_log` VALUES (111, '字典类型', 9, 'com.ruoyi.web.controller.system.SysDictTypeController.refreshCache()', 'DELETE', 1, 'admin', '研发部门', '/system/dict/type/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:38:41', 8, 1);
INSERT INTO `sys_oper_log` VALUES (112, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:39:33', 25, 1);
INSERT INTO `sys_oper_log` VALUES (113, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,2,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,109,1046,1047,1048,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:40:54', 14, 1);
INSERT INTO `sys_oper_log` VALUES (114, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":108,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-11 15:44:20\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-11-06 13:59:56\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:57:39', 13, 1);
INSERT INTO `sys_oper_log` VALUES (115, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,102\",\"children\":[],\"deptId\":108,\"deptName\":\"市场部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":102,\"status\":\"0\"},\"deptId\":101,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-11 15:57:54\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-11-06 13:59:56\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:58:26', 15, 1);
INSERT INTO `sys_oper_log` VALUES (116, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100\",\"children\":[],\"deptId\":101,\"deptName\":\"深圳总公司\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"status\":\"0\"},\"deptId\":103,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-11 15:57:54\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-11-06 13:59:56\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:58:38', 15, 1);
INSERT INTO `sys_oper_log` VALUES (117, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":103,\"deptName\":\"研发部门\",\"leader\":\"若依\",\"orderNum\":1,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-11 15:57:54\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-11-06 13:59:56\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"杭州分公司\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 15:58:43', 14, 1);
INSERT INTO `sys_oper_log` VALUES (118, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,2,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,109,1046,1047,1048,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:11:39', 6, 1);
INSERT INTO `sys_oper_log` VALUES (119, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:12:57', 13, 1);
INSERT INTO `sys_oper_log` VALUES (120, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:13:10', 19, 1);
INSERT INTO `sys_oper_log` VALUES (121, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:13:35', 13, 1);
INSERT INTO `sys_oper_log` VALUES (122, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"command\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:14:03', 16, 1);
INSERT INTO `sys_oper_log` VALUES (123, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"roleKey\":\"common\",\"roleName\":\"杭电电气\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"新增角色\'杭电电气\'失败，角色权限已存在\",\"code\":500}', 0, NULL, '2025-11-11 16:14:48', 6, 1);
INSERT INTO `sys_oper_log` VALUES (124, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:15:01', 14, 1);
INSERT INTO `sys_oper_log` VALUES (125, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:14:03\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:15:21', 14, 1);
INSERT INTO `sys_oper_log` VALUES (126, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:14:03\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[111],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:16:14', 13, 1);
INSERT INTO `sys_oper_log` VALUES (127, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', '研发部门', '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:15:01\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[110],\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":0,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:16:24', 12, 1);
INSERT INTO `sys_oper_log` VALUES (128, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:17:52', 14, 1);
INSERT INTO `sys_oper_log` VALUES (129, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:14:03\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:17:54', 18, 1);
INSERT INTO `sys_oper_log` VALUES (130, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:15:01\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":4,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:17:57', 15, 1);
INSERT INTO `sys_oper_log` VALUES (131, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"研发部门\",\"email\":\"123@qq.com\",\"leader\":\"Leland\",\"orderNum\":0,\"params\":{},\"parentId\":110,\"phone\":\"13888888888\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:19:12', 14, 1);
INSERT INTO `sys_oper_log` VALUES (132, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,111\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"研发\",\"email\":\"123@qq.com\",\"leader\":\"yanfa\",\"orderNum\":0,\"params\":{},\"parentId\":111,\"phone\":\"13888888888\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:20:00', 3, 1);
INSERT INTO `sys_oper_log` VALUES (133, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":200,\"email\":\"123@qq.com\",\"nickName\":\"123\",\"params\":{},\"phonenumber\":\"13333333333\",\"postIds\":[4],\"remark\":\"123\",\"roleIds\":[101],\"sex\":\"0\",\"status\":\"0\",\"userId\":100,\"userName\":\"111\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:20:56', 105, 1);
INSERT INTO `sys_oper_log` VALUES (134, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":201,\"email\":\"123@qq.com\",\"nickName\":\"杭电科技\",\"params\":{},\"phonenumber\":\"13333333333\",\"postIds\":[4],\"remark\":\"1234\",\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"222\"}', '{\"msg\":\"新增用户\'222\'失败，手机号码已存在\",\"code\":500}', 0, NULL, '2025-11-11 16:21:44', 1, 1);
INSERT INTO `sys_oper_log` VALUES (135, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"deptId\":201,\"email\":\"123@qq.com\",\"nickName\":\"杭电科技\",\"params\":{},\"phonenumber\":\"13333333334\",\"postIds\":[4],\"remark\":\"1234\",\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userName\":\"222\"}', '{\"msg\":\"新增用户\'222\'失败，邮箱账号已存在\",\"code\":500}', 0, NULL, '2025-11-11 16:21:52', 7, 1);
INSERT INTO `sys_oper_log` VALUES (136, '用户管理', 1, 'com.ruoyi.web.controller.system.SysUserController.add()', 'POST', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptId\":201,\"email\":\"1234@qq.com\",\"nickName\":\"杭电科技\",\"params\":{},\"phonenumber\":\"13333333334\",\"postIds\":[4],\"remark\":\"1234\",\"roleIds\":[100],\"sex\":\"0\",\"status\":\"0\",\"userId\":101,\"userName\":\"222\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:21:56', 110, 1);
INSERT INTO `sys_oper_log` VALUES (137, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-11 16:21:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,111\",\"children\":[],\"deptId\":201,\"deptName\":\"研发\",\"leader\":\"yanfa\",\"orderNum\":0,\"params\":{},\"parentId\":111,\"status\":\"0\"},\"deptId\":201,\"email\":\"1234@qq.com\",\"loginIp\":\"\",\"nickName\":\"1234\",\"params\":{},\"phonenumber\":\"13333333334\",\"postIds\":[4],\"remark\":\"1234\",\"roleIds\":[100],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":101,\"userName\":\"222\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-11 16:23:08', 12, 1);
INSERT INTO `sys_oper_log` VALUES (138, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,2000],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-24 17:49:47', 125, 1);
INSERT INTO `sys_oper_log` VALUES (139, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:14:03\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-24 17:53:12', 27, 1);
INSERT INTO `sys_oper_log` VALUES (140, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-11 16:14:03\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,103,1000,1016,1017,1019,104,1020,1021,1022,1023,1024,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114],\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-24 17:55:03', 26, 1);
INSERT INTO `sys_oper_log` VALUES (141, '代码生成', 6, 'com.ruoyi.generator.controller.GenController.importTableSave()', 'POST', 1, 'admin', '研发部门', '/tool/gen/importTable', '127.0.0.1', '内网IP', '{\"tables\":\"n_company\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:30:18', 66, 1);
INSERT INTO `sys_oper_log` VALUES (142, '代码生成', 2, 'com.ruoyi.generator.controller.GenController.editSave()', 'PUT', 1, 'admin', '研发部门', '/tool/gen', '127.0.0.1', '内网IP', '{\"businessName\":\"company\",\"className\":\"NCompany\",\"columns\":[{\"capJavaField\":\"Id\",\"columnComment\":\"企业编号\",\"columnId\":1,\"columnName\":\"id\",\"columnType\":\"bigint\",\"createBy\":\"admin\",\"createTime\":\"2025-11-25 14:30:18\",\"dictType\":\"\",\"edit\":false,\"htmlType\":\"input\",\"increment\":true,\"insert\":true,\"isIncrement\":\"1\",\"isInsert\":\"1\",\"isPk\":\"1\",\"isRequired\":\"0\",\"javaField\":\"id\",\"javaType\":\"Long\",\"list\":false,\"params\":{},\"pk\":true,\"query\":false,\"queryType\":\"EQ\",\"required\":false,\"sort\":1,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Name\",\"columnComment\":\"企业名称\",\"columnId\":2,\"columnName\":\"name\",\"columnType\":\"varchar(255)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-25 14:30:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"name\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"LIKE\",\"required\":false,\"sort\":2,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Address\",\"columnComment\":\"企业地址\",\"columnId\":3,\"columnName\":\"address\",\"columnType\":\"varchar(500)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-25 14:30:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"textarea\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"address\",\"javaType\":\"String\",\"list\":true,\"params\":{},\"pk\":false,\"query\":true,\"queryType\":\"EQ\",\"required\":false,\"sort\":3,\"superColumn\":false,\"tableId\":1,\"updateBy\":\"\",\"usableColumn\":false},{\"capJavaField\":\"Cplicense\",\"columnComment\":\"营业执照\",\"columnId\":4,\"columnName\":\"cplicense\",\"columnType\":\"varchar(100)\",\"createBy\":\"admin\",\"createTime\":\"2025-11-25 14:30:18\",\"dictType\":\"\",\"edit\":true,\"htmlType\":\"input\",\"increment\":false,\"insert\":true,\"isEdit\":\"1\",\"isIncrement\":\"0\",\"isInsert\":\"1\",\"isList\":\"1\",\"isPk\":\"0\",\"isQuery\":\"1\",\"isRequired\":\"0\",\"javaField\":\"cplice', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:30:31', 39, 1);
INSERT INTO `sys_oper_log` VALUES (143, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"company/customer/index\",\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"company:customer:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:31:00', 5, 1);
INSERT INTO `sys_oper_log` VALUES (144, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"customer/guest/index\",\"createTime\":\"2025-11-06 14:07:35\",\"icon\":\"cascader\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2000,\"menuName\":\"客户管理\",\"menuType\":\"C\",\"orderNum\":4,\"params\":{},\"parentId\":0,\"path\":\"customer\",\"perms\":\"customer:guest:list\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:31:13', 37, 1);
INSERT INTO `sys_oper_log` VALUES (145, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"公司架构\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"company\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:31:43', 9, 1);
INSERT INTO `sys_oper_log` VALUES (146, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"company/teams/index\",\"createBy\":\"admin\",\"icon\":\"peoples\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"团队\",\"menuType\":\"C\",\"orderNum\":1,\"params\":{},\"parentId\":2001,\"path\":\"teams\",\"perms\":\"company:teams:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:32:38', 8, 1);
INSERT INTO `sys_oper_log` VALUES (147, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"company/staff/index\",\"createBy\":\"admin\",\"icon\":\"people\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"人员\",\"menuType\":\"C\",\"orderNum\":2,\"params\":{},\"parentId\":2001,\"path\":\"staff\",\"perms\":\"company:staff:list\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-25 14:33:18', 9, 1);
INSERT INTO `sys_oper_log` VALUES (148, '代码生成', 8, 'com.ruoyi.generator.controller.GenController.batchGenCode()', 'GET', 1, 'admin', '研发部门', '/tool/gen/batchGenCode', '127.0.0.1', '内网IP', '{\"tables\":\"n_company\"}', NULL, 0, NULL, '2025-11-26 15:48:41', 35, 1);
INSERT INTO `sys_oper_log` VALUES (149, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-11-25 14:31:42\",\"icon\":\"github\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2001,\"menuName\":\"公司架构\",\"menuType\":\"M\",\"orderNum\":5,\"params\":{},\"parentId\":0,\"path\":\"company\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 16:41:54', 46, 1);
INSERT INTO `sys_oper_log` VALUES (150, '部门管理', 1, 'com.ruoyi.web.controller.system.SysDeptController.add()', 'POST', 1, 'admin', '研发部门', '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100\",\"children\":[],\"createBy\":\"admin\",\"deptName\":\"杭州分公司\",\"email\":\"123@qq.com\",\"leader\":\"阿巴\",\"orderNum\":1,\"params\":{},\"parentId\":100,\"phone\":\"18978723412\",\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 16:59:08', 12, 1);
INSERT INTO `sys_oper_log` VALUES (151, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2001,2002,2003],\"params\":{},\"remark\":\"11\",\"roleId\":102,\"roleKey\":\"1\",\"roleName\":\"多租户\",\"roleSort\":5,\"status\":\"0\",\"tenantId\":1}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 18:28:39', 156, 1);
INSERT INTO `sys_oper_log` VALUES (152, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-26 18:28:39\",\"dataScope\":\"1\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2001,2002,2003],\"params\":{},\"remark\":\"11\",\"roleId\":102,\"roleKey\":\"duozuhu\",\"roleName\":\"多租户\",\"roleSort\":5,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 18:28:52', 51, 1);
INSERT INTO `sys_oper_log` VALUES (153, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 18:42:28', 40, 1);
INSERT INTO `sys_oper_log` VALUES (154, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/config', '127.0.0.1', '内网IP', '{\"configId\":5,\"configKey\":\"sys.account.registerUser\",\"configName\":\"账号自助-是否开启用户注册功能\",\"configType\":\"Y\",\"configValue\":\"true\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"params\":{},\"remark\":\"是否开启注册用户功能（true开启，false关闭）\",\"updateBy\":\"admin\",\"updateTime\":\"2025-11-26 18:42:28\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 18:43:10', 11, 1);
INSERT INTO `sys_oper_log` VALUES (155, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-26 18:46:40\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-11-26 18:46:52\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"123\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-26 18:46:40\",\"roleIds\":[102],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":1005,\"userName\":\"123\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-26 18:47:57', 34, 1);
INSERT INTO `sys_oper_log` VALUES (156, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-11-28 17:51:12\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-28 17:52:46', 20, 1);
INSERT INTO `sys_oper_log` VALUES (157, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, '11', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"delFlag\":\"0\",\"dept\":{\"ancestors\":\"0,100,101\",\"children\":[],\"deptId\":105,\"deptName\":\"测试部门\",\"leader\":\"若依\",\"orderNum\":3,\"params\":{},\"parentId\":101,\"status\":\"0\"},\"deptId\":105,\"email\":\"ry@qq.com\",\"loginDate\":\"2025-11-28 17:50:10\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"若依\",\"params\":{},\"phonenumber\":\"15666666666\",\"postIds\":[2],\"pwdUpdateDate\":\"2025-11-06 13:59:56\",\"remark\":\"测试员\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"1\",\"status\":\"0\",\"updateBy\":\"11\",\"userId\":2,\"userName\":\"ry\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-11-28 17:54:14', 13, 1);
INSERT INTO `sys_oper_log` VALUES (158, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-11-29 19:14:17\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2,102],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserRoleMapper.batchUserRole\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-11-29 19:15:34', 34, 1);
INSERT INTO `sys_oper_log` VALUES (159, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-11-29 19:14:17\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserRoleMapper.batchUserRole\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-11-29 19:15:37', 16, 1);
INSERT INTO `sys_oper_log` VALUES (160, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"email\":\"\",\"loginDate\":\"2025-11-29 19:14:17\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysUserRoleMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysUserRoleMapper.batchUserRole\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-11-29 19:15:39', 16, 1);
INSERT INTO `sys_oper_log` VALUES (161, '参数管理', 2, 'com.ruoyi.web.controller.system.SysConfigController.edit()', 'PUT', 1, 'admin', NULL, '/system/config', '127.0.0.1', '内网IP', '{\"configId\":4,\"configKey\":\"sys.account.captchaEnabled\",\"configName\":\"账号自助-验证码开关\",\"configType\":\"Y\",\"configValue\":\"false\",\"createBy\":\"admin\",\"createTime\":\"2025-11-06 13:59:56\",\"params\":{},\"remark\":\"是否开启验证码功能（true开启，false关闭）\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 15:20:05', 22, 1);
INSERT INTO `sys_oper_log` VALUES (162, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', NULL, '/system/user/1007', '127.0.0.1', '内网IP', '[1007]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 15:21:25', 38, 1);
INSERT INTO `sys_oper_log` VALUES (163, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, 'admin', NULL, '/system/user/1008', '127.0.0.1', '内网IP', '[1008]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 15:21:27', 14, 1);
INSERT INTO `sys_oper_log` VALUES (164, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":200,\"params\":{}},\"deptId\":200,\"email\":\"\",\"loginDate\":\"2025-12-01 16:01:10\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[101,100],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:08:43', 22, 1);
INSERT INTO `sys_oper_log` VALUES (165, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":200,\"params\":{}},\"deptId\":200,\"email\":\"\",\"loginDate\":\"2025-12-01 16:01:10\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[100,101],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":4,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:09:34', 13, 1);
INSERT INTO `sys_oper_log` VALUES (166, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":200,\"params\":{}},\"deptId\":200,\"email\":\"\",\"loginDate\":\"2025-12-01 16:01:10\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[100,101],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":4,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:09:41', 12, 1);
INSERT INTO `sys_oper_log` VALUES (167, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":200,\"params\":{}},\"deptId\":200,\"email\":\"\",\"loginDate\":\"2025-12-01 16:09:55\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[100,101,2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"},{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":101,\"roleKey\":\"hangqi\",\"roleName\":\"杭电电气\",\"roleSort\":4,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:10:46', 17, 1);
INSERT INTO `sys_oper_log` VALUES (168, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":200,\"params\":{}},\"deptId\":200,\"email\":\"\",\"loginDate\":\"2025-12-01 16:12:04\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":100,\"roleKey\":\"hangke\",\"roleName\":\"杭电科技\",\"roleSort\":3,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:13:22', 35, 1);
INSERT INTO `sys_oper_log` VALUES (169, '参数管理', 9, 'com.ruoyi.web.controller.system.SysConfigController.refreshCache()', 'DELETE', 1, '11', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:42:36', 19, 1);
INSERT INTO `sys_oper_log` VALUES (170, '参数管理', 9, 'com.ruoyi.web.controller.system.SysConfigController.refreshCache()', 'DELETE', 1, '11', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:42:37', 9, 1);
INSERT INTO `sys_oper_log` VALUES (171, '参数管理', 9, 'com.ruoyi.web.controller.system.SysConfigController.refreshCache()', 'DELETE', 1, '11', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:42:37', 7, 1);
INSERT INTO `sys_oper_log` VALUES (172, '参数管理', 9, 'com.ruoyi.web.controller.system.SysConfigController.refreshCache()', 'DELETE', 1, '11', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:42:37', 9, 1);
INSERT INTO `sys_oper_log` VALUES (173, '参数管理', 9, 'com.ruoyi.web.controller.system.SysConfigController.refreshCache()', 'DELETE', 1, '11', NULL, '/system/config/refreshCache', '127.0.0.1', '内网IP', '', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-01 16:42:38', 9, 1);
INSERT INTO `sys_oper_log` VALUES (174, '参数管理', 5, 'com.ruoyi.web.controller.system.SysConfigController.export()', 'POST', 1, '11', NULL, '/system/config/export', '127.0.0.1', '内网IP', '{\"pageSize\":\"20\",\"pageNum\":\"1\"}', NULL, 0, NULL, '2025-12-01 16:42:41', 649, 1);
INSERT INTO `sys_oper_log` VALUES (175, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":18,\"status\":\"1\",\"updateBy\":\"admin\"}', NULL, 1, 'Cannot read the array length because \"<local4>\" is null', '2025-12-08 14:20:25', 35, 1);
INSERT INTO `sys_oper_log` VALUES (176, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"\",\"loginDate\":\"2025-12-08 15:44:12\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:48:29', 46, 1);
INSERT INTO `sys_oper_log` VALUES (177, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"\",\"loginDate\":\"2025-12-08 15:44:12\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:48:33', 26, 1);
INSERT INTO `sys_oper_log` VALUES (178, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"\",\"loginDate\":\"2025-12-08 15:48:46\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:49:11', 16, 1);
INSERT INTO `sys_oper_log` VALUES (179, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:49:40', 32, 1);
INSERT INTO `sys_oper_log` VALUES (180, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"1987379318@qq.com\",\"loginDate\":\"2025-12-08 15:48:46\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:49:53', 22, 1);
INSERT INTO `sys_oper_log` VALUES (181, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,102,1012,1013,1014,1015,103,1016,1017,1018,1019,104,1020,1021,1022,1023,1024,105,1025,1026,1027,1028,1029,106,1030,1031,1032,1033,1034,107,1035,1036,1037,1038,108,500,1039,1040,1041,501,1042,1043,1044,1045,2,109,1046,1047,1048,110,1049,1050,1051,1052,1053,1054,111,112,113,114,3,115,116,1055,1056,1057,1058,1059,1060,117,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:57:48', 24, 1);
INSERT INTO `sys_oper_log` VALUES (182, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"1987379318@qq.com\",\"loginDate\":\"2025-12-08 15:57:29\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:57:52', 17, 1);
INSERT INTO `sys_oper_log` VALUES (183, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"1987379318@qq.com\",\"loginDate\":\"2025-12-08 15:58:01\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 15:58:23', 18, 1);
INSERT INTO `sys_oper_log` VALUES (184, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', '研发部门', '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"1987379318@qq.com\",\"loginDate\":\"2025-12-08 15:58:35\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 16:14:15', 19, 1);
INSERT INTO `sys_oper_log` VALUES (185, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2000,2001],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 16:14:56', 31, 1);
INSERT INTO `sys_oper_log` VALUES (186, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.dataScope()', 'PUT', 1, 'admin', NULL, '/system/role/dataScope', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"deptIds\":[100,101,103,104,105,106,107,202,102,108,109],\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 16:15:04', 14, 1);
INSERT INTO `sys_oper_log` VALUES (187, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"若依\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 16:18:02', 40, 1);
INSERT INTO `sys_oper_log` VALUES (188, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[100,101,103,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 16:19:13', 19, 1);
INSERT INTO `sys_oper_log` VALUES (189, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-08 17:17:37', 31, 1);
INSERT INTO `sys_oper_log` VALUES (190, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, '11', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":20,\"status\":\"1\",\"updateBy\":\"11\"}', NULL, 1, 'Cannot read the array length because \"<local4>\" is null', '2025-12-08 17:35:28', 26, 1);
INSERT INTO `sys_oper_log` VALUES (191, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, '11', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":true,\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":20,\"status\":\"1\",\"updateBy\":\"11\"}', NULL, 1, 'Cannot read the array length because \"<local4>\" is null', '2025-12-08 17:35:43', 24, 1);
INSERT INTO `sys_oper_log` VALUES (192, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":12,\"deptId\":7,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":21,\"tenantId\":63,\"userId\":32,\"userName\":\"admin123556\"}', NULL, 1, '没有权限访问部门数据！', '2025-12-09 14:37:23', 28, 1);
INSERT INTO `sys_oper_log` VALUES (193, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"tenantId\":110,\"userId\":1006,\"userName\":\"admin123556\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 14:39:39', 12, 1);
INSERT INTO `sys_oper_log` VALUES (194, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"tenantId\":110,\"userId\":1,\"userName\":\"admin123556\"}', NULL, 1, 'rawPassword cannot be null', '2025-12-09 14:44:19', 42, 1);
INSERT INTO `sys_oper_log` VALUES (195, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"tenantId\":110,\"userId\":1,\"userName\":\"admin123556\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 14:45:52', 228, 1);
INSERT INTO `sys_oper_log` VALUES (196, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"userName\":\"admin321\"}', '{\"msg\":\"新增用户\'admin321\'失败，邮箱账号已存在\",\"code\":500}', 0, NULL, '2025-12-09 15:19:21', 13, 1);
INSERT INTO `sys_oper_log` VALUES (197, '用户管理', 1, 'com.ruoyi.CRM.controller.UserController.add()', 'POST', 1, '11', NULL, '/company/staff/add', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"12342@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"userName\":\"ad33\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 15:19:50', 98, 1);
INSERT INTO `sys_oper_log` VALUES (198, '用户管理', 3, 'com.ruoyi.web.controller.system.SysUserController.remove()', 'DELETE', 1, '11', NULL, '/system/user/1014', '127.0.0.1', '内网IP', '[1014]', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 15:20:28', 30, 1);
INSERT INTO `sys_oper_log` VALUES (199, '用户管理', 2, 'com.ruoyi.CRM.controller.UserController.edit()', 'PUT', 1, '11', NULL, '/company/staff/update', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"123541234@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"11 veniam do irure deserunt\",\"roleId\":2,\"userId\":1013,\"userName\":\"admin12331\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 15:26:37', 39, 1);
INSERT INTO `sys_oper_log` VALUES (200, '用户管理', 2, 'com.ruoyi.CRM.controller.UserController.edit()', 'PUT', 1, '11', NULL, '/company/staff/update', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"123541234@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"11 veniam do irure deserunt\",\"roleId\":2,\"userId\":1013,\"userName\":\"admin12331\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 15:28:11', 69, 1);
INSERT INTO `sys_oper_log` VALUES (201, '用户管理', 2, 'com.ruoyi.CRM.controller.UserController.edit()', 'PUT', 1, '11', NULL, '/company/staff/update', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"123541234@sina.com\",\"nickName\":\"赛雅鑫\",\"phone\":\"17858704458\",\"remark\":\"11 veniam do irure deserunt\",\"roleId\":2,\"userId\":1013,\"userName\":\"admin12331\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 15:29:37', 126, 1);
INSERT INTO `sys_oper_log` VALUES (202, '角色管理', 1, 'com.ruoyi.web.controller.system.SysRoleController.add()', 'POST', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createBy\":\"admin\",\"deptCheckStrictly\":true,\"deptIds\":[],\"flag\":false,\"menuCheckStrictly\":true,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,2000,2001,2002,2003],\"params\":{},\"roleId\":103,\"roleKey\":\"staff\",\"roleName\":\"公司普通员工\",\"roleSort\":3,\"status\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-09 16:34:11', 38, 1);
INSERT INTO `sys_oper_log` VALUES (203, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:26:11', 39, 1);
INSERT INTO `sys_oper_log` VALUES (204, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:28:03', 23, 1);
INSERT INTO `sys_oper_log` VALUES (205, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:28:42', 26, 1);
INSERT INTO `sys_oper_log` VALUES (206, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:29:25', 39, 1);
INSERT INTO `sys_oper_log` VALUES (207, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:35:09', 32, 1);
INSERT INTO `sys_oper_log` VALUES (208, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:41:44', 43, 1);
INSERT INTO `sys_oper_log` VALUES (209, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:45:41', 47, 1);
INSERT INTO `sys_oper_log` VALUES (210, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', NULL, 1, 'nested exception is org.apache.ibatis.exceptions.PersistenceException: \r\n### Error updating database.  Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')\r\n### The error may exist in file [A:\\desktopA\\CRM\\RuoYi-Vue\\ruoyi-system\\target\\classes\\mapper\\system\\SysDeptMapper.xml]\r\n### The error may involve com.ruoyi.system.mapper.SysDeptMapper.insertDept\r\n### The error occurred while executing an update\r\n### Cause: java.lang.ClassCastException: class net.sf.jsqlparser.statement.select.SetOperationList cannot be cast to class net.sf.jsqlparser.statement.select.PlainSelect (net.sf.jsqlparser.statement.select.SetOperationList and net.sf.jsqlparser.statement.select.PlainSelect are in unnamed module of loader \'app\')', '2025-12-11 14:46:54', 30, 1);
INSERT INTO `sys_oper_log` VALUES (211, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, 'admin', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部11\",\"email\":\"ry@qq.com\",\"leader\":\"若依\",\"orderNum\":6,\"parentId\":101,\"phone\":\"15666666666\",\"status\":\"0\",\"userId\":2}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:50:28', 103, 1);
INSERT INTO `sys_oper_log` VALUES (212, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,1000,1001,1002,1003,1004,1005,1006,1007,1008,1009,1010,1011,1016,1017,1018,1019,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:52:46', 116, 1);
INSERT INTO `sys_oper_log` VALUES (213, '用户管理', 2, 'com.ruoyi.web.controller.system.SysUserController.edit()', 'PUT', 1, 'admin', NULL, '/system/user', '127.0.0.1', '内网IP', '{\"admin\":false,\"avatar\":\"\",\"createBy\":\"\",\"createTime\":\"2025-11-28 17:51:05\",\"delFlag\":\"0\",\"dept\":{\"children\":[],\"deptId\":110,\"params\":{}},\"deptId\":110,\"email\":\"1987379318@qq.com\",\"loginDate\":\"2025-12-11 14:52:56\",\"loginIp\":\"127.0.0.1\",\"nickName\":\"11\",\"params\":{},\"phonenumber\":\"\",\"postIds\":[],\"pwdUpdateDate\":\"2025-11-28 17:51:05\",\"roleIds\":[2],\"roles\":[{\"admin\":false,\"dataScope\":\"2\",\"deptCheckStrictly\":false,\"flag\":false,\"menuCheckStrictly\":false,\"params\":{},\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":2,\"status\":\"0\"}],\"sex\":\"0\",\"status\":\"0\",\"tenantId\":110,\"updateBy\":\"admin\",\"userId\":1006,\"userName\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:53:26', 28, 1);
INSERT INTO `sys_oper_log` VALUES (214, '角色管理', 2, 'com.ruoyi.web.controller.system.SysRoleController.edit()', 'PUT', 1, 'admin', NULL, '/system/role', '127.0.0.1', '内网IP', '{\"admin\":false,\"createTime\":\"2025-11-06 13:59:56\",\"dataScope\":\"2\",\"delFlag\":\"0\",\"deptCheckStrictly\":true,\"flag\":false,\"menuCheckStrictly\":false,\"menuIds\":[1,100,1000,1001,1002,1003,1004,1005,1006,101,1007,1008,1009,1010,1011,103,1016,1017,1018,1019,2000,2001,2002,2003],\"params\":{},\"remark\":\"普通角色\",\"roleId\":2,\"roleKey\":\"common\",\"roleName\":\"公司管理员\",\"roleSort\":2,\"status\":\"0\",\"updateBy\":\"admin\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 14:53:45', 19, 1);
INSERT INTO `sys_oper_log` VALUES (215, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE `n_company`  (\\n  `id` bigint NOT NULL AUTO_INCREMENT COMMENT \'企业编号\',\\n  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业名称\',\\n  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业地址\',\\n  `cplicense` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'营业执照\',\\n  `lename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人姓名\',\\n  `leage` int NULL DEFAULT NULL COMMENT \'法人年龄\',\\n  `leemail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人邮箱\',\\n  `lephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人电话\',\\n  `lecard` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人身份证号\',\\n  `state` int NULL DEFAULT 1 COMMENT \'企业状态：1-待审核 2-已通过 3-已拒绝 4-停用\',\\n  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业审批备注\',\\n  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'创建人\',\\n  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT \'创建时间\',\\n  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'更新人\',\\n  `update_time` datetime NULL DEFAULT NULL COMMENT \'更新时间\',\\n  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT \'删除标记：0-正常 1-删除\',\\n  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT \'租户ID\',\\n  PRIMARY KEY (`id`) USING BTREE,\\n  INDEX `idx_name`(`name` ASC) USING BTREE,\\n  INDEX `idx_cplicense`(`cplicense` ASC) USING BTREE,\\n  INDEX `idx_state`(`state` ASC) USING BTREE,\\n  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,\\n  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,\\n  INDEX `idx_lename`(`lename` ASC) USING BTREE,\\n  INDEX `idx_lephone`(`lephone` ASC) USING BTREE\\n) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER ', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-12-11 14:57:33', 52, 1);
INSERT INTO `sys_oper_log` VALUES (216, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE `n_company`  (\\n  `id` bigint NOT NULL AUTO_INCREMENT COMMENT \'企业编号\',\\n  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业名称\',\\n  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业地址\',\\n  `cplicense` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'营业执照\',\\n  `lename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人姓名\',\\n  `leage` int NULL DEFAULT NULL COMMENT \'法人年龄\',\\n  `leemail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人邮箱\',\\n  `lephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人电话\',\\n  `lecard` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人身份证号\',\\n  `state` int NULL DEFAULT 1 COMMENT \'企业状态：1-待审核 2-已通过 3-已拒绝 4-停用\',\\n  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业审批备注\',\\n  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'创建人\',\\n  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT \'创建时间\',\\n  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'更新人\',\\n  `update_time` datetime NULL DEFAULT NULL COMMENT \'更新时间\',\\n  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT \'删除标记：0-正常 1-删除\',\\n  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT \'租户ID\',\\n  PRIMARY KEY (`id`) USING BTREE,\\n  INDEX `idx_name`(`name` ASC) USING BTREE,\\n  INDEX `idx_cplicense`(`cplicense` ASC) USING BTREE,\\n  INDEX `idx_state`(`state` ASC) USING BTREE,\\n  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,\\n  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,\\n  INDEX `idx_lename`(`lename` ASC) USING BTREE,\\n  INDEX `idx_lephone`(`lephone` ASC) USING BTREE\\n) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER ', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-12-11 14:57:38', 8, 1);
INSERT INTO `sys_oper_log` VALUES (217, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE `n_company`  (\\n  `id` bigint NOT NULL AUTO_INCREMENT COMMENT \'企业编号\',\\n  `name` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业名称\',\\n  `address` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业地址\',\\n  `cplicense` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'营业执照\',\\n  `lename` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人姓名\',\\n  `leage` int NULL DEFAULT NULL COMMENT \'法人年龄\',\\n  `leemail` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人邮箱\',\\n  `lephone` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人电话\',\\n  `lecard` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'法人身份证号\',\\n  `state` int NULL DEFAULT 1 COMMENT \'企业状态：1-待审核 2-已通过 3-已拒绝 4-停用\',\\n  `remark` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'企业审批备注\',\\n  `create_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'创建人\',\\n  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT \'创建时间\',\\n  `update_by` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT \'更新人\',\\n  `update_time` datetime NULL DEFAULT NULL COMMENT \'更新时间\',\\n  `is_deleted` tinyint(1) NULL DEFAULT 0 COMMENT \'删除标记：0-正常 1-删除\',\\n  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT \'租户ID\',\\n  PRIMARY KEY (`id`) USING BTREE,\\n  INDEX `idx_name`(`name` ASC) USING BTREE,\\n  INDEX `idx_cplicense`(`cplicense` ASC) USING BTREE,\\n  INDEX `idx_state`(`state` ASC) USING BTREE,\\n  INDEX `idx_create_time`(`create_time` ASC) USING BTREE,\\n  INDEX `idx_is_deleted`(`is_deleted` ASC) USING BTREE,\\n  INDEX `idx_lename`(`lename` ASC) USING BTREE,\\n  INDEX `idx_lephone`(`lephone` ASC) USING BTREE\\n)\\n\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-12-11 14:57:42', 10, 1);
INSERT INTO `sys_oper_log` VALUES (218, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE `n_company` (\\n  `id` bigint NOT NULL AUTO_INCREMENT COMMENT \'企业编号\',\\n  `name` varchar(255) NOT NULL COMMENT \'企业名称\',\\n  `address` varchar(500) DEFAULT NULL COMMENT \'企业地址\',\\n  `cplicense` varchar(100) DEFAULT NULL COMMENT \'营业执照\',\\n  `lename` varchar(100) DEFAULT NULL COMMENT \'法人姓名\',\\n  `leage` int DEFAULT NULL COMMENT \'法人年龄\',\\n  `leemail` varchar(100) DEFAULT NULL COMMENT \'法人邮箱\',\\n  `lephone` varchar(30) DEFAULT NULL COMMENT \'法人电话\',\\n  `lecard` varchar(30) DEFAULT NULL COMMENT \'法人身份证号\',\\n  `state` int NOT NULL DEFAULT \'1\' COMMENT \'企业状态：1-待审核 2-已通过 3-已拒绝 4-停用\',\\n  `remark` varchar(255) DEFAULT NULL COMMENT \'企业审批备注\',\\n  `create_by` varchar(50) DEFAULT NULL COMMENT \'创建人\',\\n  `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT \'创建时间\',\\n  `update_by` varchar(50) DEFAULT NULL COMMENT \'更新人\',\\n  `update_time` datetime DEFAULT NULL COMMENT \'更新时间\',\\n  `is_deleted` tinyint(1) NOT NULL DEFAULT \'0\' COMMENT \'删除标记：0-正常 1-删除\',\\n  `tenant_id` bigint NOT NULL DEFAULT \'1\' COMMENT \'租户ID\',\\n  PRIMARY KEY (`id`) USING BTREE,\\n  KEY `idx_name` (`name`),\\n  KEY `idx_cplicense` (`cplicense`),\\n  KEY `idx_state` (`state`),\\n  KEY `idx_create_time` (`create_time`),\\n  KEY `idx_is_deleted` (`is_deleted`),\\n  KEY `idx_lename` (`lename`),\\n  KEY `idx_lephone` (`lephone`),\\n  KEY `idx_tenant_id` (`tenant_id`)  -- 添加租户ID索引，这对多租户很重要！\\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=\'企业信息表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-12-11 14:58:22', 15, 1);
INSERT INTO `sys_oper_log` VALUES (219, '创建表', 0, 'com.ruoyi.generator.controller.GenController.createTableSave()', 'POST', 1, 'admin', NULL, '/tool/gen/createTable', '127.0.0.1', '内网IP', '{\"sql\":\"CREATE TABLE `n_company` (\\n    `id` bigint NOT NULL AUTO_INCREMENT COMMENT \'企业编号\',\\n    `name` varchar(255) NOT NULL COMMENT \'企业名称\',\\n    `address` varchar(500) DEFAULT NULL COMMENT \'企业地址\',\\n    `cplicense` varchar(100) DEFAULT NULL COMMENT \'营业执照\',\\n    `lename` varchar(100) DEFAULT NULL COMMENT \'法人姓名\',\\n    `leage` int DEFAULT NULL COMMENT \'法人年龄\',\\n    `leemail` varchar(100) DEFAULT NULL COMMENT \'法人邮箱\',\\n    `lephone` varchar(30) DEFAULT NULL COMMENT \'法人电话\',\\n    `lecard` varchar(30) DEFAULT NULL COMMENT \'法人身份证号\',\\n    `state` int NOT NULL DEFAULT \'1\' COMMENT \'企业状态：1-待审核 2-已通过 3-已拒绝 4-停用\',\\n    `remark` varchar(255) DEFAULT NULL COMMENT \'企业审批备注\',\\n    `create_by` varchar(50) DEFAULT NULL COMMENT \'创建人\',\\n    `create_time` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP COMMENT \'创建时间\',\\n    `update_by` varchar(50) DEFAULT NULL COMMENT \'更新人\',\\n    `update_time` datetime DEFAULT NULL COMMENT \'更新时间\',\\n    `is_deleted` tinyint(1) NOT NULL DEFAULT \'0\' COMMENT \'删除标记：0-正常 1-删除\',\\n    `tenant_id` bigint NOT NULL DEFAULT \'1\' COMMENT \'租户ID\',\\n    PRIMARY KEY (`id`),\\n    KEY `idx_name` (`name`),\\n    KEY `idx_cplicense` (`cplicense`),\\n    KEY `idx_state` (`state`),\\n    KEY `idx_create_time` (`create_time`),\\n    KEY `idx_is_deleted` (`is_deleted`),\\n    KEY `idx_lename` (`lename`),\\n    KEY `idx_lephone` (`lephone`),\\n    KEY `idx_tenant_id` (`tenant_id`)\\n) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci COMMENT=\'企业信息表\';\"}', '{\"msg\":\"创建表结构异常\",\"code\":500}', 0, NULL, '2025-12-11 14:59:48', 18, 1);
INSERT INTO `sys_oper_log` VALUES (220, '菜单管理', 1, 'com.ruoyi.web.controller.system.SysMenuController.add()', 'POST', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createBy\":\"admin\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuName\":\"公司视图\",\"menuType\":\"M\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"/\",\"status\":\"0\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 16:20:15', 17, 1);
INSERT INTO `sys_oper_log` VALUES (221, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-11 16:20:15\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"公司视图\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"company/manage\",\"perms\":\"\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 16:21:47', 18, 1);
INSERT INTO `sys_oper_log` VALUES (222, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-11 16:20:15\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"公司视图\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"company/manage\",\"perms\":\"company:manange\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 16:21:58', 17, 1);
INSERT INTO `sys_oper_log` VALUES (223, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"createTime\":\"2025-12-11 16:20:15\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"公司视图\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"manage\",\"perms\":\"company:manange\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 16:22:17', 14, 1);
INSERT INTO `sys_oper_log` VALUES (224, '菜单管理', 2, 'com.ruoyi.web.controller.system.SysMenuController.edit()', 'PUT', 1, 'admin', NULL, '/system/menu', '127.0.0.1', '内网IP', '{\"children\":[],\"component\":\"company/manage/index\",\"createTime\":\"2025-12-11 16:20:15\",\"icon\":\"list\",\"isCache\":\"0\",\"isFrame\":\"1\",\"menuId\":2004,\"menuName\":\"公司视图\",\"menuType\":\"C\",\"orderNum\":6,\"params\":{},\"parentId\":0,\"path\":\"manage\",\"perms\":\"company:manange\",\"routeName\":\"\",\"status\":\"0\",\"updateBy\":\"admin\",\"visible\":\"0\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-11 16:22:31', 16, 1);
INSERT INTO `sys_oper_log` VALUES (225, '用户管理', 2, 'com.ruoyi.CRM.controller.UserController.edit()', 'PUT', 1, '11', NULL, '/company/staff/update', '127.0.0.1', '内网IP', '{\"age\":18,\"deptId\":110,\"email\":\"tbfv9r89@sina.com\",\"nickName\":\"赛雅鑫11\",\"phone\":\"17858704458\",\"remark\":\"consectetur veniam do irure deserunt\",\"roleId\":2,\"userId\":1013,\"userName\":\"aa23\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 16:09:29', 130, 1);
INSERT INTO `sys_oper_log` VALUES (226, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, '11', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":110,\"deptName\":\"杭州电气\",\"email\":\"ry@qq.com\",\"leader\":\"电气\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 16:44:00', 38, 1);
INSERT INTO `sys_oper_log` VALUES (227, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, '11', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":110,\"deptName\":\"杭州电气\",\"email\":\"ry@qq.com\",\"leader\":\"电气+1\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 16:44:08', 21, 1);
INSERT INTO `sys_oper_log` VALUES (228, '部门管理', 2, 'com.ruoyi.web.controller.system.SysDeptController.edit()', 'PUT', 1, '11', NULL, '/system/dept', '127.0.0.1', '内网IP', '{\"ancestors\":\"0\",\"children\":[],\"deptId\":110,\"deptName\":\"杭州电气\",\"email\":\"ry@qq.com\",\"leader\":\"电气\",\"orderNum\":0,\"params\":{},\"parentId\":0,\"phone\":\"15888888888\",\"status\":\"0\",\"updateBy\":\"11\"}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 16:44:12', 18, 1);
INSERT INTO `sys_oper_log` VALUES (229, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发部\",\"email\":\"zhangsan@example.com\",\"leader\":\"张三\",\"orderNum\":1,\"parentId\":100,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":2001}', NULL, 1, 'Cannot invoke \"com.ruoyi.common.core.domain.entity.SysDept.getDeptName()\" because \"info\" is null', '2025-12-13 16:55:39', 20, 1);
INSERT INTO `sys_oper_log` VALUES (230, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"张三\",\"orderNum\":2,\"parentId\":100,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":2001}', NULL, 1, 'Cannot invoke \"com.ruoyi.common.core.domain.entity.SysDept.getDeptName()\" because \"info\" is null', '2025-12-13 16:56:20', 7, 1);
INSERT INTO `sys_oper_log` VALUES (231, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,100,101\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"张三\",\"orderNum\":2,\"parentId\":100,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":2001}', NULL, 1, 'Cannot invoke \"com.ruoyi.common.core.domain.entity.SysDept.getDeptName()\" because \"info\" is null', '2025-12-13 17:01:28', 31, 1);
INSERT INTO `sys_oper_log` VALUES (232, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":2,\"parentId\":110,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:04:43', 28, 1);
INSERT INTO `sys_oper_log` VALUES (233, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":2,\"parentId\":110,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:06:27', 100, 1);
INSERT INTO `sys_oper_log` VALUES (234, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":2,\"parentId\":110,\"phone\":\"13800138000\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:07:54', 126, 1);
INSERT INTO `sys_oper_log` VALUES (235, '部门管理', 1, 'com.ruoyi.CRM.controller.TeamController.add()', 'POST', 1, '11', NULL, '/company/teams/add', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"deptName\":\"研发一部\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":2,\"parentId\":110,\"phone\":\"13800138000\",\"remark\":\"112\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:10:02', 105, 1);
INSERT INTO `sys_oper_log` VALUES (236, '部门管理', 2, 'com.ruoyi.CRM.controller.TeamController.edit()', 'PUT', 1, '11', NULL, '/company/teams/update', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110\",\"deptId\":207,\"deptName\":\"研发一部11\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":2,\"parentId\":110,\"phone\":\"13800138000\",\"remark\":\"112\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:19:23', 54, 1);
INSERT INTO `sys_oper_log` VALUES (237, '部门管理', 2, 'com.ruoyi.CRM.controller.TeamController.edit()', 'PUT', 1, '11', NULL, '/company/teams/update', '127.0.0.1', '内网IP', '{\"ancestors\":\"0,110,200\",\"deptId\":207,\"deptName\":\"研发一部112\",\"email\":\"zhangsan@example.com\",\"leader\":\"11\",\"orderNum\":1,\"parentId\":200,\"phone\":\"13800138000\",\"remark\":\"112\",\"status\":\"0\",\"userId\":1006}', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:20:36', 37, 1);
INSERT INTO `sys_oper_log` VALUES (238, '部门管理', 3, 'com.ruoyi.web.controller.system.SysDeptController.remove()', 'DELETE', 1, '11', NULL, '/system/dept/207', '127.0.0.1', '内网IP', '207', '{\"msg\":\"操作成功\",\"code\":200}', 0, NULL, '2025-12-13 17:21:33', 20, 1);

-- ----------------------------
-- Table structure for sys_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_post`;
CREATE TABLE `sys_post`  (
  `post_id` bigint NOT NULL AUTO_INCREMENT COMMENT '岗位ID',
  `post_code` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位编码',
  `post_name` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '岗位名称',
  `post_sort` int NOT NULL COMMENT '显示顺序',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`post_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 5 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '岗位信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_post
-- ----------------------------
INSERT INTO `sys_post` VALUES (1, 'ceo', '董事长', 1, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_post` VALUES (2, 'se', '项目经理', 2, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_post` VALUES (3, 'hr', '人力资源', 3, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);
INSERT INTO `sys_post` VALUES (4, 'user', '普通员工', 4, '0', 'admin', '2025-11-06 13:59:56', '', NULL, '', 1);

-- ----------------------------
-- Table structure for sys_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_role`;
CREATE TABLE `sys_role`  (
  `role_id` bigint NOT NULL AUTO_INCREMENT COMMENT '角色ID',
  `role_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色名称',
  `role_key` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色权限字符串',
  `role_sort` int NOT NULL COMMENT '显示顺序',
  `data_scope` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '1' COMMENT '数据范围（1：全部数据权限 2：自定数据权限 3：本部门数据权限 4：本部门及以下数据权限）',
  `menu_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '菜单树选择项是否关联显示',
  `dept_check_strictly` tinyint(1) NULL DEFAULT 1 COMMENT '部门树选择项是否关联显示',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '角色状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`role_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 104 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role
-- ----------------------------
INSERT INTO `sys_role` VALUES (1, '超级管理员', 'admin', 1, '1', 1, 1, '0', '0', 'admin', '2025-11-06 13:59:56', '', NULL, '超级管理员', 1);
INSERT INTO `sys_role` VALUES (2, '公司管理员', 'common', 2, '2', 0, 1, '0', '0', 'admin', '2025-11-06 13:59:56', 'admin', '2025-12-11 14:53:45', '普通角色', 1);
INSERT INTO `sys_role` VALUES (100, '杭电科技', 'hangke', 3, '2', 1, 1, '0', '0', 'admin', '2025-11-11 16:14:03', 'admin', '2025-11-24 17:55:03', NULL, 1);
INSERT INTO `sys_role` VALUES (101, '杭电电气', 'hangqi', 4, '2', 1, 1, '0', '0', 'admin', '2025-11-11 16:15:01', 'admin', '2025-11-11 16:17:57', NULL, 1);
INSERT INTO `sys_role` VALUES (102, '多租户', 'duozuhu', 5, '1', 1, 1, '0', '0', 'admin', '2025-11-26 18:28:39', 'admin', '2025-11-26 18:28:52', '11', 110);
INSERT INTO `sys_role` VALUES (103, '公司普通员工', 'staff', 3, '1', 1, 1, '0', '0', 'admin', '2025-12-09 16:34:11', '', NULL, NULL, 1);

-- ----------------------------
-- Table structure for sys_role_dept
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_dept`;
CREATE TABLE `sys_role_dept`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `dept_id` bigint NOT NULL COMMENT '部门ID',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`role_id`, `dept_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和部门关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_dept
-- ----------------------------
INSERT INTO `sys_role_dept` VALUES (2, 100, 0);
INSERT INTO `sys_role_dept` VALUES (2, 101, 0);
INSERT INTO `sys_role_dept` VALUES (2, 102, 0);
INSERT INTO `sys_role_dept` VALUES (2, 103, 0);
INSERT INTO `sys_role_dept` VALUES (2, 104, 0);
INSERT INTO `sys_role_dept` VALUES (2, 105, 0);
INSERT INTO `sys_role_dept` VALUES (2, 106, 0);
INSERT INTO `sys_role_dept` VALUES (2, 107, 0);
INSERT INTO `sys_role_dept` VALUES (2, 108, 0);
INSERT INTO `sys_role_dept` VALUES (2, 109, 0);
INSERT INTO `sys_role_dept` VALUES (2, 110, 0);
INSERT INTO `sys_role_dept` VALUES (2, 202, 0);
INSERT INTO `sys_role_dept` VALUES (100, 111, 0);
INSERT INTO `sys_role_dept` VALUES (101, 110, 0);
INSERT INTO `sys_role_dept` VALUES (102, 110, 0);

-- ----------------------------
-- Table structure for sys_role_menu
-- ----------------------------
DROP TABLE IF EXISTS `sys_role_menu`;
CREATE TABLE `sys_role_menu`  (
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `menu_id` bigint NOT NULL COMMENT '菜单ID',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`role_id`, `menu_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '角色和菜单关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_role_menu
-- ----------------------------
INSERT INTO `sys_role_menu` VALUES (2, 1, 0);
INSERT INTO `sys_role_menu` VALUES (2, 100, 0);
INSERT INTO `sys_role_menu` VALUES (2, 101, 0);
INSERT INTO `sys_role_menu` VALUES (2, 103, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1000, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1001, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1002, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1003, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1004, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1005, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1006, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1007, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1008, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1009, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1010, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1011, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1016, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1017, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1018, 0);
INSERT INTO `sys_role_menu` VALUES (2, 1019, 0);
INSERT INTO `sys_role_menu` VALUES (2, 2000, 0);
INSERT INTO `sys_role_menu` VALUES (2, 2001, 0);
INSERT INTO `sys_role_menu` VALUES (2, 2002, 0);
INSERT INTO `sys_role_menu` VALUES (2, 2003, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1, 0);
INSERT INTO `sys_role_menu` VALUES (100, 2, 0);
INSERT INTO `sys_role_menu` VALUES (100, 100, 0);
INSERT INTO `sys_role_menu` VALUES (100, 103, 0);
INSERT INTO `sys_role_menu` VALUES (100, 104, 0);
INSERT INTO `sys_role_menu` VALUES (100, 107, 0);
INSERT INTO `sys_role_menu` VALUES (100, 108, 0);
INSERT INTO `sys_role_menu` VALUES (100, 109, 0);
INSERT INTO `sys_role_menu` VALUES (100, 110, 0);
INSERT INTO `sys_role_menu` VALUES (100, 111, 0);
INSERT INTO `sys_role_menu` VALUES (100, 112, 0);
INSERT INTO `sys_role_menu` VALUES (100, 113, 0);
INSERT INTO `sys_role_menu` VALUES (100, 114, 0);
INSERT INTO `sys_role_menu` VALUES (100, 500, 0);
INSERT INTO `sys_role_menu` VALUES (100, 501, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1000, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1016, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1017, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1019, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1020, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1021, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1022, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1023, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1024, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1035, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1036, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1037, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1038, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1039, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1040, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1041, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1042, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1043, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1044, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1045, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1046, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1047, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1048, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1049, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1050, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1051, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1052, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1053, 0);
INSERT INTO `sys_role_menu` VALUES (100, 1054, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1, 0);
INSERT INTO `sys_role_menu` VALUES (101, 2, 0);
INSERT INTO `sys_role_menu` VALUES (101, 100, 0);
INSERT INTO `sys_role_menu` VALUES (101, 103, 0);
INSERT INTO `sys_role_menu` VALUES (101, 104, 0);
INSERT INTO `sys_role_menu` VALUES (101, 107, 0);
INSERT INTO `sys_role_menu` VALUES (101, 108, 0);
INSERT INTO `sys_role_menu` VALUES (101, 109, 0);
INSERT INTO `sys_role_menu` VALUES (101, 110, 0);
INSERT INTO `sys_role_menu` VALUES (101, 111, 0);
INSERT INTO `sys_role_menu` VALUES (101, 112, 0);
INSERT INTO `sys_role_menu` VALUES (101, 113, 0);
INSERT INTO `sys_role_menu` VALUES (101, 114, 0);
INSERT INTO `sys_role_menu` VALUES (101, 500, 0);
INSERT INTO `sys_role_menu` VALUES (101, 501, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1000, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1001, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1002, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1003, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1004, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1005, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1006, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1016, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1017, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1018, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1019, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1020, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1021, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1022, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1023, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1024, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1035, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1036, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1037, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1038, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1039, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1040, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1041, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1042, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1043, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1044, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1045, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1046, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1047, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1048, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1049, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1050, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1051, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1052, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1053, 0);
INSERT INTO `sys_role_menu` VALUES (101, 1054, 0);
INSERT INTO `sys_role_menu` VALUES (101, 2000, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1, 0);
INSERT INTO `sys_role_menu` VALUES (102, 2, 0);
INSERT INTO `sys_role_menu` VALUES (102, 3, 0);
INSERT INTO `sys_role_menu` VALUES (102, 100, 0);
INSERT INTO `sys_role_menu` VALUES (102, 101, 0);
INSERT INTO `sys_role_menu` VALUES (102, 102, 0);
INSERT INTO `sys_role_menu` VALUES (102, 103, 0);
INSERT INTO `sys_role_menu` VALUES (102, 104, 0);
INSERT INTO `sys_role_menu` VALUES (102, 105, 0);
INSERT INTO `sys_role_menu` VALUES (102, 106, 0);
INSERT INTO `sys_role_menu` VALUES (102, 107, 0);
INSERT INTO `sys_role_menu` VALUES (102, 108, 0);
INSERT INTO `sys_role_menu` VALUES (102, 109, 0);
INSERT INTO `sys_role_menu` VALUES (102, 110, 0);
INSERT INTO `sys_role_menu` VALUES (102, 111, 0);
INSERT INTO `sys_role_menu` VALUES (102, 112, 0);
INSERT INTO `sys_role_menu` VALUES (102, 113, 0);
INSERT INTO `sys_role_menu` VALUES (102, 114, 0);
INSERT INTO `sys_role_menu` VALUES (102, 115, 0);
INSERT INTO `sys_role_menu` VALUES (102, 116, 0);
INSERT INTO `sys_role_menu` VALUES (102, 117, 0);
INSERT INTO `sys_role_menu` VALUES (102, 500, 0);
INSERT INTO `sys_role_menu` VALUES (102, 501, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1000, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1001, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1002, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1003, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1004, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1005, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1006, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1007, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1008, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1009, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1010, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1011, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1012, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1013, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1014, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1015, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1016, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1017, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1018, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1019, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1020, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1021, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1022, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1023, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1024, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1025, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1026, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1027, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1028, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1029, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1030, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1031, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1032, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1033, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1034, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1035, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1036, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1037, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1038, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1039, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1040, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1041, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1042, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1043, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1044, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1045, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1046, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1047, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1048, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1049, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1050, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1051, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1052, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1053, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1054, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1055, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1056, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1057, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1058, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1059, 0);
INSERT INTO `sys_role_menu` VALUES (102, 1060, 0);
INSERT INTO `sys_role_menu` VALUES (102, 2000, 0);
INSERT INTO `sys_role_menu` VALUES (102, 2001, 0);
INSERT INTO `sys_role_menu` VALUES (102, 2002, 0);
INSERT INTO `sys_role_menu` VALUES (102, 2003, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1, 0);
INSERT INTO `sys_role_menu` VALUES (103, 100, 0);
INSERT INTO `sys_role_menu` VALUES (103, 101, 0);
INSERT INTO `sys_role_menu` VALUES (103, 103, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1000, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1001, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1002, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1003, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1004, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1005, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1006, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1007, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1008, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1009, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1010, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1011, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1016, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1017, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1018, 0);
INSERT INTO `sys_role_menu` VALUES (103, 1019, 0);
INSERT INTO `sys_role_menu` VALUES (103, 2000, 0);
INSERT INTO `sys_role_menu` VALUES (103, 2001, 0);
INSERT INTO `sys_role_menu` VALUES (103, 2002, 0);
INSERT INTO `sys_role_menu` VALUES (103, 2003, 0);

-- ----------------------------
-- Table structure for sys_tenant
-- ----------------------------
DROP TABLE IF EXISTS `sys_tenant`;
CREATE TABLE `sys_tenant`  (
  `tenant_id` bigint NOT NULL AUTO_INCREMENT COMMENT '租户ID',
  `tenant_name` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户名称',
  `tenant_code` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '租户编码',
  `contact_person` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系人',
  `contact_phone` varchar(20) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '联系电话',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '状态（0正常 1停用）',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT CURRENT_TIMESTAMP COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  PRIMARY KEY (`tenant_id`) USING BTREE,
  UNIQUE INDEX `tenant_code`(`tenant_code` ASC) USING BTREE,
  UNIQUE INDEX `idx_tenant_code`(`tenant_code` ASC) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1003 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '租户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_tenant
-- ----------------------------
INSERT INTO `sys_tenant` VALUES (0, '默认租户', 'default', '系统管理员', NULL, '0', '', '2025-11-26 17:19:13', '', '2025-11-26 23:47:31', '系统默认租户', '0');
INSERT INTO `sys_tenant` VALUES (1001, '测试租户A', 'test_tenant_a', '联系人A', NULL, '0', '', '2025-11-26 17:37:53', '', NULL, '测试租户A', '0');
INSERT INTO `sys_tenant` VALUES (1002, '测试租户B', 'test_tenant_b', '联系人B', NULL, '0', '', '2025-11-26 17:37:53', '', NULL, '测试租户B', '0');

-- ----------------------------
-- Table structure for sys_user
-- ----------------------------
DROP TABLE IF EXISTS `sys_user`;
CREATE TABLE `sys_user`  (
  `user_id` bigint NOT NULL AUTO_INCREMENT COMMENT '用户ID',
  `dept_id` bigint NULL DEFAULT NULL COMMENT '团队ID',
  `user_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户账号',
  `nick_name` varchar(30) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL COMMENT '用户昵称',
  `user_type` varchar(2) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '00' COMMENT '用户类型（00系统用户）',
  `email` varchar(50) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '用户邮箱',
  `phonenumber` varchar(11) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '手机号码',
  `sex` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '用户性别（0男 1女 2未知）',
  `avatar` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '头像地址',
  `password` varchar(100) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '密码',
  `status` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '账号状态（0正常 1停用）',
  `del_flag` char(1) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '0' COMMENT '删除标志（0代表存在 2代表删除）',
  `login_ip` varchar(128) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '最后登录IP',
  `login_date` datetime NULL DEFAULT NULL COMMENT '最后登录时间',
  `pwd_update_date` datetime NULL DEFAULT NULL COMMENT '密码最后更新时间',
  `create_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '创建者',
  `create_time` datetime NULL DEFAULT NULL COMMENT '创建时间',
  `update_by` varchar(64) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT '' COMMENT '更新者',
  `update_time` datetime NULL DEFAULT NULL COMMENT '更新时间',
  `remark` varchar(500) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NULL DEFAULT NULL COMMENT '备注',
  `tenant_id` bigint NOT NULL DEFAULT 1 COMMENT '租户ID',
  PRIMARY KEY (`user_id`) USING BTREE
) ENGINE = InnoDB AUTO_INCREMENT = 1022 CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户信息表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user
-- ----------------------------
INSERT INTO `sys_user` VALUES (1, 103, 'admin', '若依', '00', 'ry@163.com', '15888888888', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-12-13 16:05:30', '2025-11-06 13:59:56', 'admin', '2025-11-06 13:59:56', '', NULL, '管理员', 1);
INSERT INTO `sys_user` VALUES (2, 105, 'ry', '若依', '00', 'ry@qq.com', '15666666666', '1', '', '$2a$10$7JB720yubVSZvUI0rEqK/.VqGOZTH.ulu33dHOiBE8ByOhJIrdAu2', '0', '0', '127.0.0.1', '2025-11-29 19:14:41', '2025-11-06 13:59:56', 'admin', '2025-11-06 13:59:56', '11', '2025-11-28 17:54:14', '测试员', 1);
INSERT INTO `sys_user` VALUES (100, 200, '111', '123', '00', '123@qq.com', '13333333333', '0', '', '$2a$10$DLRFVL/ppE8CgcBEDXkIH.TNCjFQMfwR68BUgEJiArTefA0m1SIpK', '0', '0', '127.0.0.1', '2025-12-08 15:27:34', NULL, 'admin', '2025-11-11 16:20:56', '', NULL, '123', 1);
INSERT INTO `sys_user` VALUES (101, 201, '222', '1234', '00', '1234@qq.com', '13333333334', '0', '', '$2a$10$pl0nO.asXKgFt/x5eUm6Detmo6gCGHAgFc8LmLEDGTWFxRHmLJLuO', '0', '0', '127.0.0.1', '2025-11-24 17:55:37', NULL, 'admin', '2025-11-11 16:21:56', 'admin', '2025-11-11 16:23:08', '1234', 1001);
INSERT INTO `sys_user` VALUES (1005, NULL, '123', '123', '00', '', '', '0', '', '$2a$10$0xQJEhgqctDjjqHUYgrLj.0.EEdLTTcE6cEjNwBuyq6t44o8EjrFK', '0', '0', '127.0.0.1', '2025-11-26 19:01:22', '2025-11-26 18:46:40', '', '2025-11-26 18:46:40', 'admin', '2025-11-26 18:47:57', NULL, 111);
INSERT INTO `sys_user` VALUES (1006, 110, '11', '11', '00', '1987379318@qq.com', '', '0', '', '$2a$10$6iBPQP79YHApDosqB9IzS.CQHHdSZnseNZnsb0ya1v9d6xQsZmHS6', '0', '0', '127.0.0.1', '2025-12-13 16:43:32', '2025-11-28 17:51:05', '', '2025-11-28 17:51:05', 'admin', '2025-12-11 14:53:26', NULL, 110);
INSERT INTO `sys_user` VALUES (1013, 110, '22', '赛雅鑫11', '00', 'tbfv9r89@sina.com', '', '0', '', '$2a$10$ZdTgXw.c9f4/vVPSOOxs8O5mTtD.iriVs.QEFCdwEcAdPH/YXwXj2', '0', '0', '127.0.0.1', '2025-12-09 14:46:58', NULL, '11', '2025-12-09 14:45:52', '11', '2025-12-13 16:09:29', 'consectetur veniam do irure deserunt', 110);
INSERT INTO `sys_user` VALUES (1019, 110, 'aaa2', 'aaa2', '00', '', '', '0', '', '$2a$10$iRHnNTD0pC8WNYaXle1LF.EOsJx5fdjGLf0B1M6g5jsxIG1A3TyOC', '0', '0', '', NULL, '2025-12-09 16:27:16', '', '2025-12-09 16:27:15', '', NULL, NULL, 110);
INSERT INTO `sys_user` VALUES (1020, 110, 'aaa3', 'aaa3', '00', '', '', '0', '', '$2a$10$WfrXvg4M.C2ompeqg9gS2.g.U3hR9rDRrOaDDzAizy7gj6iKebt96', '0', '0', '', NULL, '2025-12-09 16:40:00', '', '2025-12-09 16:40:00', '', NULL, NULL, 110);
INSERT INTO `sys_user` VALUES (1021, 110, 'aaa4', 'aaa4', '00', '', '', '0', '', '$2a$10$IXwfPqYNyUavbhrdhRJbOOp/bZJt/28YLrCH.NbQFUNG1rzcusHCy', '0', '0', '', NULL, '2025-12-09 16:43:38', '', '2025-12-09 16:43:38', '', NULL, NULL, 110);

-- ----------------------------
-- Table structure for sys_user_post
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_post`;
CREATE TABLE `sys_user_post`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `post_id` bigint NOT NULL COMMENT '岗位ID',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`user_id`, `post_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户与岗位关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_post
-- ----------------------------
INSERT INTO `sys_user_post` VALUES (1, 1, 1);
INSERT INTO `sys_user_post` VALUES (2, 2, 1);
INSERT INTO `sys_user_post` VALUES (100, 4, 1);
INSERT INTO `sys_user_post` VALUES (101, 4, 1);

-- ----------------------------
-- Table structure for sys_user_role
-- ----------------------------
DROP TABLE IF EXISTS `sys_user_role`;
CREATE TABLE `sys_user_role`  (
  `user_id` bigint NOT NULL COMMENT '用户ID',
  `role_id` bigint NOT NULL COMMENT '角色ID',
  `tenant_id` bigint NOT NULL DEFAULT 0 COMMENT '租户ID',
  PRIMARY KEY (`user_id`, `role_id`) USING BTREE
) ENGINE = InnoDB CHARACTER SET = utf8mb4 COLLATE = utf8mb4_0900_ai_ci COMMENT = '用户和角色关联表' ROW_FORMAT = DYNAMIC;

-- ----------------------------
-- Records of sys_user_role
-- ----------------------------
INSERT INTO `sys_user_role` VALUES (1, 1, 1);
INSERT INTO `sys_user_role` VALUES (1, 103, 0);
INSERT INTO `sys_user_role` VALUES (2, 2, 1);
INSERT INTO `sys_user_role` VALUES (100, 101, 1);
INSERT INTO `sys_user_role` VALUES (101, 100, 1);
INSERT INTO `sys_user_role` VALUES (1005, 102, 1);
INSERT INTO `sys_user_role` VALUES (1006, 2, 0);
INSERT INTO `sys_user_role` VALUES (1021, 103, 0);

SET FOREIGN_KEY_CHECKS = 1;
