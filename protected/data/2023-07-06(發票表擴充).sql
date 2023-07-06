
-- ----------------------------
-- Table structure for acc_invoice
-- ----------------------------
ALTER TABLE acc_invoice ADD COLUMN payment_method varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '付款週期' AFTER payment_term;
