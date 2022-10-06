
-- ----------------------------
-- Table structure for acc_invoice_type
-- ----------------------------
ALTER TABLE acc_invoice_type ADD COLUMN product_code varchar(100) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL COMMENT '服务/产品编号' AFTER invoice_id;
