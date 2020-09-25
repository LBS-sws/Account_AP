/*
Navicat MySQL Data Transfer

Source Server         : ldb
Source Server Version : 50505
Source Host           : localhost:3306
Source Database       : account

Target Server Type    : MYSQL
Target Server Version : 50505
File Encoding         : 65001

Date: 2020-09-25 15:34:49
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for `acc_invoice_type`
-- ----------------------------
DROP TABLE IF EXISTS `acc_invoice_type`;
CREATE TABLE `acc_invoice_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `invoice_id` int(11) NOT NULL,
  `description` varchar(255) DEFAULT NULL COMMENT '服务、产品内容',
  `quantity` varchar(255) DEFAULT NULL COMMENT '数量',
  `unit_price` varchar(255) DEFAULT NULL COMMENT '单价',
  `amount` varchar(255) DEFAULT NULL COMMENT '总价',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=313 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of acc_invoice_type
-- ----------------------------
INSERT INTO `acc_invoice_type` VALUES ('1', '1', 'Restroom Hygiene', '3', '160.00', '481.00');
INSERT INTO `acc_invoice_type` VALUES ('2', '2', 'Restroom Hygiene', '1', '181.90', '181.90');
INSERT INTO `acc_invoice_type` VALUES ('3', '3', 'CPT PAPER (6R/CTN)', '3', '67.09', '201.27');
INSERT INTO `acc_invoice_type` VALUES ('4', '4', 'Pest Control', '3', '385.20', '1155.60');
INSERT INTO `acc_invoice_type` VALUES ('5', '5', 'Pest Control', '6', '149.80', '749.00');
INSERT INTO `acc_invoice_type` VALUES ('6', '6', 'BELUX-JRT GRADE AA (12R/CTN）', '2', '2', '4');
INSERT INTO `acc_invoice_type` VALUES ('7', '6', 'CPT PAPER (6R/CTN)', '6', '63.56', '381.35');
INSERT INTO `acc_invoice_type` VALUES ('8', '6', 'BELUX-JRT GRADE AA (12R/CTN）', '2', '25.47', '50.93');
INSERT INTO `acc_invoice_type` VALUES ('9', '6', 'BELUX-JRT GRADE AA (12R/CTN）', '2', '25.47', '432.28');
INSERT INTO `acc_invoice_type` VALUES ('10', '7', 'Pest Control', '3', '128.40', '385.20');
INSERT INTO `acc_invoice_type` VALUES ('11', '7', 'Insect light trap Service', '3', '42.80', '128.40');
INSERT INTO `acc_invoice_type` VALUES ('12', '8', 'Pest Control', '3', '128.40', '385.20');
INSERT INTO `acc_invoice_type` VALUES ('13', '9', 'Space disinfection', '1', '428.00', '428.00');
INSERT INTO `acc_invoice_type` VALUES ('14', '10', 'Pest Control', '6', '117.70', '706.20');
INSERT INTO `acc_invoice_type` VALUES ('15', '11', 'Pest Control', '1', '171.20', '171.20');
INSERT INTO `acc_invoice_type` VALUES ('16', '12', 'Pest Control', '1', '310.30', '310.30');
INSERT INTO `acc_invoice_type` VALUES ('17', '13', 'Pest Control', '6', '149.80', '898.80');
INSERT INTO `acc_invoice_type` VALUES ('18', '14', 'Rent machine service', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('19', '15', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('20', '16', 'Restroom Hygiene', '1', '0.00', '0.00');
INSERT INTO `acc_invoice_type` VALUES ('21', '17', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('22', '18', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('23', '19', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('24', '20', 'Restroom Hygiene', '1', '96.00', '96.00');
INSERT INTO `acc_invoice_type` VALUES ('25', '20', 'Space disinfection', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('26', '20', 'Rent machine service', '1', '64.00', '64.00');
INSERT INTO `acc_invoice_type` VALUES ('27', '21', 'Pest Control', '1', '364.00', '364.00');
INSERT INTO `acc_invoice_type` VALUES ('28', '21', 'Rent machine service', '1', '11.00', '11.00');
INSERT INTO `acc_invoice_type` VALUES ('29', '21', 'Insect light trap Service', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('30', '22', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('31', '22', 'Insect light trap Service', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('32', '23', 'Pest Control', '1', '198.00', '198.00');
INSERT INTO `acc_invoice_type` VALUES ('33', '24', 'Space disinfection', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('34', '25', 'Space disinfection', '1', '201.00', '201.00');
INSERT INTO `acc_invoice_type` VALUES ('35', '26', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('36', '27', 'Space disinfection', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('37', '28', 'Space disinfection', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('38', '29', 'Pest Control', '1', '375.00', '375.00');
INSERT INTO `acc_invoice_type` VALUES ('39', '29', 'Rent machine service', '1', '32.00', '32.00');
INSERT INTO `acc_invoice_type` VALUES ('40', '30', 'Restroom Hygiene', '1', '251.00', '251.00');
INSERT INTO `acc_invoice_type` VALUES ('41', '31', 'Rent machine service', '1', '152.00', '152.00');
INSERT INTO `acc_invoice_type` VALUES ('42', '31', 'Rent machine service', '1', '54.00', '54.00');
INSERT INTO `acc_invoice_type` VALUES ('43', '32', 'Space disinfection', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('44', '33', 'Restroom Hygiene', '1', '193.00', '193.00');
INSERT INTO `acc_invoice_type` VALUES ('45', '34', 'Insect light trap Service', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('46', '35', 'Restroom Hygiene', '1', '32.00', '32.00');
INSERT INTO `acc_invoice_type` VALUES ('47', '35', 'Pest Control', '1', '449.00', '449.00');
INSERT INTO `acc_invoice_type` VALUES ('48', '36', 'Pest Control', '1', '910.00', '910.00');
INSERT INTO `acc_invoice_type` VALUES ('49', '36', 'Insect light trap Service', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('50', '36', 'Rent machine service', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('51', '37', 'Space disinfection', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('52', '38', 'Space disinfection', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('53', '39', 'Restroom Hygiene', '1', '942.00', '942.00');
INSERT INTO `acc_invoice_type` VALUES ('54', '39', 'Space disinfection', '1', '1156.00', '1156.00');
INSERT INTO `acc_invoice_type` VALUES ('55', '39', 'Fogger Service', '1', '321.00', '321.00');
INSERT INTO `acc_invoice_type` VALUES ('56', '39', 'Pest Control', '1', '268.00', '268.00');
INSERT INTO `acc_invoice_type` VALUES ('57', '40', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('58', '41', 'Restroom Hygiene', '1', '1311.00', '1311.00');
INSERT INTO `acc_invoice_type` VALUES ('59', '41', 'Rent machine service', '1', '180.00', '180.00');
INSERT INTO `acc_invoice_type` VALUES ('60', '41', 'Rent machine service', '1', '148.00', '148.00');
INSERT INTO `acc_invoice_type` VALUES ('61', '41', 'Rent machine service', '1', '0.00', '0.00');
INSERT INTO `acc_invoice_type` VALUES ('62', '42', 'Restroom Hygiene', '1', '102.00', '102.00');
INSERT INTO `acc_invoice_type` VALUES ('63', '42', 'Space disinfection', '1', '0.00', '0.00');
INSERT INTO `acc_invoice_type` VALUES ('64', '43', 'Restroom Hygiene', '1', '259.00', '259.00');
INSERT INTO `acc_invoice_type` VALUES ('65', '44', 'Restroom Hygiene', '1', '251.00', '251.00');
INSERT INTO `acc_invoice_type` VALUES ('66', '45', 'Restroom Hygiene', '1', '321.00', '321.00');
INSERT INTO `acc_invoice_type` VALUES ('67', '46', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('68', '47', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('69', '47', 'Insect light trap Service', '1', '43.00', '43.00');
INSERT INTO `acc_invoice_type` VALUES ('70', '48', 'Pest Control', '1', '270.00', '270.00');
INSERT INTO `acc_invoice_type` VALUES ('71', '49', 'Pest Control', '1', '144.00', '144.00');
INSERT INTO `acc_invoice_type` VALUES ('72', '50', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('73', '51', 'Space disinfection', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('74', '52', 'Space disinfection', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('75', '53', 'Space disinfection', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('76', '54', 'Pest Control', '1', '144.00', '144.00');
INSERT INTO `acc_invoice_type` VALUES ('77', '55', 'Space disinfection', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('78', '56', 'Pest Control', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('79', '57', 'Pest Control', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('80', '58', 'Restroom Hygiene', '1', '17.00', '17.00');
INSERT INTO `acc_invoice_type` VALUES ('81', '58', 'Pest Control', '1', '428.00', '428.00');
INSERT INTO `acc_invoice_type` VALUES ('82', '59', 'Pest Control', '1', '385.00', '385.00');
INSERT INTO `acc_invoice_type` VALUES ('83', '60', 'Pest Control', '1', '417.00', '417.00');
INSERT INTO `acc_invoice_type` VALUES ('84', '61', 'Restroom Hygiene', '1', '481.00', '481.00');
INSERT INTO `acc_invoice_type` VALUES ('85', '61', 'Pest Control', '1', '481.00', '481.00');
INSERT INTO `acc_invoice_type` VALUES ('86', '62', 'Pest Control', '1', '385.00', '385.00');
INSERT INTO `acc_invoice_type` VALUES ('87', '63', 'Pest Control', '1', '492.00', '492.00');
INSERT INTO `acc_invoice_type` VALUES ('88', '63', 'Rent machine service', '1', '21.00', '21.00');
INSERT INTO `acc_invoice_type` VALUES ('89', '64', 'Pest Control', '1', '375.00', '375.00');
INSERT INTO `acc_invoice_type` VALUES ('90', '64', 'Rent machine service', '1', '32.00', '32.00');
INSERT INTO `acc_invoice_type` VALUES ('91', '65', 'Restroom Hygiene', '1', '589.00', '589.00');
INSERT INTO `acc_invoice_type` VALUES ('92', '66', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('93', '66', 'Pest Control', '1', '193.00', '193.00');
INSERT INTO `acc_invoice_type` VALUES ('94', '66', 'Insect light trap Service', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('95', '67', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('96', '68', 'Pest Control', '1', '289.00', '289.00');
INSERT INTO `acc_invoice_type` VALUES ('97', '69', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('98', '70', 'Space disinfection', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('99', '71', 'Restroom Hygiene', '1', '77.00', '77.00');
INSERT INTO `acc_invoice_type` VALUES ('100', '71', 'Rent machine service', '1', '22.00', '22.00');
INSERT INTO `acc_invoice_type` VALUES ('101', '72', 'Pest Control', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('102', '73', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('103', '73', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('104', '74', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('105', '75', 'Space disinfection', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('106', '76', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('107', '77', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('108', '78', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('109', '79', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('110', '80', 'Space disinfection', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('111', '81', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('112', '82', 'Space disinfection', '1', '273.00', '273.00');
INSERT INTO `acc_invoice_type` VALUES ('113', '83', 'Restroom Hygiene', '1', '300.00', '300.00');
INSERT INTO `acc_invoice_type` VALUES ('114', '84', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('115', '85', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('116', '85', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('117', '86', 'Pest Control', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('118', '87', 'Space disinfection', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('119', '88', 'Pest Control', '1', '144.00', '144.00');
INSERT INTO `acc_invoice_type` VALUES ('120', '89', 'Restroom Hygiene', '1', '498.00', '498.00');
INSERT INTO `acc_invoice_type` VALUES ('121', '90', 'Pest Control', '1', '428.00', '428.00');
INSERT INTO `acc_invoice_type` VALUES ('122', '91', 'Space disinfection', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('123', '92', 'Pest Control', '1', '257.00', '257.00');
INSERT INTO `acc_invoice_type` VALUES ('124', '93', 'Restroom Hygiene', '1', '129.00', '129.00');
INSERT INTO `acc_invoice_type` VALUES ('125', '94', 'Restroom Hygiene', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('126', '94', 'Space disinfection', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('127', '95', 'Space disinfection', '1', '492.00', '492.00');
INSERT INTO `acc_invoice_type` VALUES ('128', '95', 'Restroom Hygiene', '1', '362.00', '362.00');
INSERT INTO `acc_invoice_type` VALUES ('129', '96', 'Pest Control', '1', '428.00', '428.00');
INSERT INTO `acc_invoice_type` VALUES ('130', '97', 'Restroom Hygiene', '1', '361.00', '361.00');
INSERT INTO `acc_invoice_type` VALUES ('131', '97', 'Pest Control', '1', '963.00', '963.00');
INSERT INTO `acc_invoice_type` VALUES ('132', '98', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('133', '99', 'Pest Control', '1', '203.00', '203.00');
INSERT INTO `acc_invoice_type` VALUES ('134', '100', 'Pest Control', '1', '589.00', '589.00');
INSERT INTO `acc_invoice_type` VALUES ('135', '101', 'Space disinfection', '1', '203.00', '203.00');
INSERT INTO `acc_invoice_type` VALUES ('136', '101', 'Pest Control', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('137', '102', 'Space disinfection', '1', '257.00', '257.00');
INSERT INTO `acc_invoice_type` VALUES ('138', '103', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('139', '104', 'Pest Control', '1', '321.00', '321.00');
INSERT INTO `acc_invoice_type` VALUES ('140', '105', 'Restroom Hygiene', '1', '230.00', '230.00');
INSERT INTO `acc_invoice_type` VALUES ('141', '106', 'Restroom Hygiene', '1', '310.00', '310.00');
INSERT INTO `acc_invoice_type` VALUES ('142', '107', 'Restroom Hygiene', '1', '289.00', '289.00');
INSERT INTO `acc_invoice_type` VALUES ('143', '107', 'Space disinfection', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('144', '107', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('145', '108', 'Restroom Hygiene', '1', '244.00', '244.00');
INSERT INTO `acc_invoice_type` VALUES ('146', '109', 'Restroom Hygiene', '1', '300.00', '300.00');
INSERT INTO `acc_invoice_type` VALUES ('147', '109', 'Pest Control', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('148', '110', 'Restroom Hygiene', '1', '257.00', '257.00');
INSERT INTO `acc_invoice_type` VALUES ('149', '111', 'Restroom Hygiene', '1', '306.00', '306.00');
INSERT INTO `acc_invoice_type` VALUES ('150', '112', 'Restroom Hygiene', '1', '244.00', '244.00');
INSERT INTO `acc_invoice_type` VALUES ('151', '113', 'Restroom Hygiene', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('152', '113', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('153', '114', 'Restroom Hygiene', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('154', '115', 'Restroom Hygiene', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('155', '116', 'Fogger Service', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('156', '116', 'Fogger Service', '1', '187.00', '187.00');
INSERT INTO `acc_invoice_type` VALUES ('157', '117', 'Restroom Hygiene', '1', '47.00', '47.00');
INSERT INTO `acc_invoice_type` VALUES ('158', '117', 'Pest Control', '1', '47.00', '47.00');
INSERT INTO `acc_invoice_type` VALUES ('159', '118', 'Restroom Hygiene', '1', '177.00', '177.00');
INSERT INTO `acc_invoice_type` VALUES ('160', '119', 'Pest Control', '1', '67.00', '67.00');
INSERT INTO `acc_invoice_type` VALUES ('161', '120', 'Pest Control', '1', '449.00', '449.00');
INSERT INTO `acc_invoice_type` VALUES ('162', '121', 'Pest Control', '1', '0.00', '0.00');
INSERT INTO `acc_invoice_type` VALUES ('163', '122', 'Pest Control', '1', '482.00', '482.00');
INSERT INTO `acc_invoice_type` VALUES ('164', '123', 'Pest Control', '1', '963.00', '963.00');
INSERT INTO `acc_invoice_type` VALUES ('165', '124', 'Insect light trap Service', '1', '37.00', '37.00');
INSERT INTO `acc_invoice_type` VALUES ('166', '125', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('167', '125', 'Pest Control', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('168', '125', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('169', '125', 'Insect light trap Service', '1', '112.00', '112.00');
INSERT INTO `acc_invoice_type` VALUES ('170', '126', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('171', '127', 'Restroom Hygiene', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('172', '128', 'Space disinfection', '1', '1070.00', '1070.00');
INSERT INTO `acc_invoice_type` VALUES ('173', '129', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('174', '129', 'Pest Control', '1', '193.00', '193.00');
INSERT INTO `acc_invoice_type` VALUES ('175', '130', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('176', '130', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('177', '131', 'Restroom Hygiene', '1', '406.00', '406.00');
INSERT INTO `acc_invoice_type` VALUES ('178', '132', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('179', '133', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('180', '134', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('181', '135', 'Pest Control', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('182', '136', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('183', '137', 'Pest Control', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('184', '138', 'Pest Control', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('185', '139', 'Restroom Hygiene', '1', '54.00', '54.00');
INSERT INTO `acc_invoice_type` VALUES ('186', '139', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('187', '140', 'Restroom Hygiene', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('188', '140', 'Space disinfection', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('189', '141', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('190', '142', 'Pest Control', '1', '145.00', '145.00');
INSERT INTO `acc_invoice_type` VALUES ('191', '143', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('192', '144', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('193', '145', 'Pest Control', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('194', '146', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('195', '147', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('196', '148', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('197', '149', 'Restroom Hygiene', '1', '122.00', '122.00');
INSERT INTO `acc_invoice_type` VALUES ('198', '150', 'Restroom Hygiene', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('199', '150', 'Pest Control', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('200', '151', 'Pest Control', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('201', '152', 'Restroom Hygiene', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('202', '152', 'Pest Control', '1', '96.00', '96.00');
INSERT INTO `acc_invoice_type` VALUES ('203', '153', 'Pest Control', '1', '96.00', '96.00');
INSERT INTO `acc_invoice_type` VALUES ('204', '154', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('205', '154', 'Pest Control', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('206', '155', 'Fogger Service', '1', '268.00', '268.00');
INSERT INTO `acc_invoice_type` VALUES ('207', '155', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('208', '156', 'Pest Control', '1', '268.00', '268.00');
INSERT INTO `acc_invoice_type` VALUES ('209', '157', 'Pest Control', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('210', '158', 'Restroom Hygiene', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('211', '158', 'Pest Control', '1', '375.00', '375.00');
INSERT INTO `acc_invoice_type` VALUES ('212', '159', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('213', '160', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('214', '161', 'Pest Control', '1', '482.00', '482.00');
INSERT INTO `acc_invoice_type` VALUES ('215', '162', 'Restroom Hygiene', '1', '321.00', '321.00');
INSERT INTO `acc_invoice_type` VALUES ('216', '163', 'Pest Control', '1', '1231.00', '1231.00');
INSERT INTO `acc_invoice_type` VALUES ('217', '164', 'Space disinfection', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('218', '164', 'Fogger Service', '1', '305.00', '305.00');
INSERT INTO `acc_invoice_type` VALUES ('219', '164', 'Pest Control', '1', '305.00', '305.00');
INSERT INTO `acc_invoice_type` VALUES ('220', '165', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('221', '166', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('222', '166', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('223', '167', 'Restroom Hygiene', '1', '99.00', '99.00');
INSERT INTO `acc_invoice_type` VALUES ('224', '167', 'Pest Control', '1', '99.00', '99.00');
INSERT INTO `acc_invoice_type` VALUES ('225', '168', 'Restroom Hygiene', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('226', '169', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('227', '170', 'Restroom Hygiene', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('228', '170', 'Pest Control', '1', '385.00', '385.00');
INSERT INTO `acc_invoice_type` VALUES ('229', '171', 'Restroom Hygiene', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('230', '172', 'Restroom Hygiene', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('231', '173', 'Restroom Hygiene', '1', '300.00', '300.00');
INSERT INTO `acc_invoice_type` VALUES ('232', '173', 'Pest Control', '1', '375.00', '375.00');
INSERT INTO `acc_invoice_type` VALUES ('233', '174', 'Restroom Hygiene', '1', '198.00', '198.00');
INSERT INTO `acc_invoice_type` VALUES ('234', '174', 'Pest Control', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('235', '175', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('236', '175', 'Pest Control', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('237', '176', 'Pest Control', '1', '300.00', '300.00');
INSERT INTO `acc_invoice_type` VALUES ('238', '177', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('239', '178', 'Pest Control', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('240', '179', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('241', '179', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('242', '179', 'Insect light trap Service', '1', '43.00', '43.00');
INSERT INTO `acc_invoice_type` VALUES ('243', '180', 'Restroom Hygiene', '1', '209.00', '209.00');
INSERT INTO `acc_invoice_type` VALUES ('244', '180', 'Rent machine service', '1', '16.00', '16.00');
INSERT INTO `acc_invoice_type` VALUES ('245', '181', 'Restroom Hygiene', '1', '197.00', '197.00');
INSERT INTO `acc_invoice_type` VALUES ('246', '182', 'Space disinfection', '1', '278.00', '278.00');
INSERT INTO `acc_invoice_type` VALUES ('247', '183', 'Restroom Hygiene', '1', '213.00', '213.00');
INSERT INTO `acc_invoice_type` VALUES ('248', '184', 'Pest Control', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('249', '185', 'Restroom Hygiene', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('250', '185', 'Space disinfection', '1', '246.00', '246.00');
INSERT INTO `acc_invoice_type` VALUES ('251', '186', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('252', '186', 'Insect light trap Service', '1', '43.00', '43.00');
INSERT INTO `acc_invoice_type` VALUES ('253', '187', 'Restroom Hygiene', '1', '556.00', '556.00');
INSERT INTO `acc_invoice_type` VALUES ('254', '188', 'Pest Control', '1', '631.00', '631.00');
INSERT INTO `acc_invoice_type` VALUES ('255', '189', 'Restroom Hygiene', '1', '214.00', '214.00');
INSERT INTO `acc_invoice_type` VALUES ('256', '190', 'Restroom Hygiene', '1', '1025.00', '1025.00');
INSERT INTO `acc_invoice_type` VALUES ('257', '191', 'Restroom Hygiene', '1', '1319.00', '1319.00');
INSERT INTO `acc_invoice_type` VALUES ('258', '192', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('259', '192', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('260', '193', 'Pest Control', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('261', '194', 'Pest Control', '1', '332.00', '332.00');
INSERT INTO `acc_invoice_type` VALUES ('262', '195', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('263', '196', 'Pest Control', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('264', '197', 'Pest Control', '1', '1070.00', '1070.00');
INSERT INTO `acc_invoice_type` VALUES ('265', '198', 'Restroom Hygiene', '1', '1070.00', '1070.00');
INSERT INTO `acc_invoice_type` VALUES ('266', '199', 'Restroom Hygiene', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('267', '199', 'Pest Control', '1', '182.00', '182.00');
INSERT INTO `acc_invoice_type` VALUES ('268', '200', 'Restroom Hygiene', '1', '64.00', '64.00');
INSERT INTO `acc_invoice_type` VALUES ('269', '201', 'Restroom Hygiene', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('270', '202', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('271', '203', 'Restroom Hygiene', '1', '319.00', '319.00');
INSERT INTO `acc_invoice_type` VALUES ('272', '204', 'Restroom Hygiene', '1', '1000.00', '1000.00');
INSERT INTO `acc_invoice_type` VALUES ('273', '205', 'Restroom Hygiene', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('274', '205', 'Pest Control', '1', '203.00', '203.00');
INSERT INTO `acc_invoice_type` VALUES ('275', '206', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('276', '207', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('277', '208', 'Pest Control', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('278', '209', 'Restroom Hygiene', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('279', '209', 'Pest Control', '1', '193.00', '193.00');
INSERT INTO `acc_invoice_type` VALUES ('280', '210', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('281', '210', 'Pest Control', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('282', '211', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('283', '212', 'Restroom Hygiene', '1', '161.00', '161.00');
INSERT INTO `acc_invoice_type` VALUES ('284', '213', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('285', '214', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('286', '215', 'Restroom Hygiene', '1', '193.00', '193.00');
INSERT INTO `acc_invoice_type` VALUES ('287', '215', 'Space disinfection', '1', '514.00', '514.00');
INSERT INTO `acc_invoice_type` VALUES ('288', '215', 'Pest Control', '1', '353.00', '353.00');
INSERT INTO `acc_invoice_type` VALUES ('289', '216', 'Restroom Hygiene', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('290', '216', 'Pest Control', '1', '171.00', '171.00');
INSERT INTO `acc_invoice_type` VALUES ('291', '217', 'Pest Control', '1', '118.00', '118.00');
INSERT INTO `acc_invoice_type` VALUES ('292', '218', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('293', '218', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('294', '219', 'Pest Control', '1', '482.00', '482.00');
INSERT INTO `acc_invoice_type` VALUES ('295', '219', 'Rent machine service', '1', '180.00', '180.00');
INSERT INTO `acc_invoice_type` VALUES ('296', '219', 'Insect light trap Service', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('297', '220', 'Restroom Hygiene', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('298', '221', 'Restroom Hygiene', '1', '107.00', '107.00');
INSERT INTO `acc_invoice_type` VALUES ('299', '221', 'Pest Control', '1', '268.00', '268.00');
INSERT INTO `acc_invoice_type` VALUES ('300', '222', 'Restroom Hygiene', '1', '209.00', '209.00');
INSERT INTO `acc_invoice_type` VALUES ('301', '223', 'Pest Control', '1', '150.00', '150.00');
INSERT INTO `acc_invoice_type` VALUES ('302', '224', 'Restroom Hygiene', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('303', '224', 'Pest Control', '1', '278.00', '278.00');
INSERT INTO `acc_invoice_type` VALUES ('304', '224', 'Insect light trap Service', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('305', '225', 'Restroom Hygiene', '1', '86.00', '86.00');
INSERT INTO `acc_invoice_type` VALUES ('306', '225', 'Pest Control', '1', '128.00', '128.00');
INSERT INTO `acc_invoice_type` VALUES ('307', '226', 'Pest Control', '1', '235.00', '235.00');
INSERT INTO `acc_invoice_type` VALUES ('308', '227', 'Restroom Hygiene', '1', '139.00', '139.00');
INSERT INTO `acc_invoice_type` VALUES ('309', '228', 'Restroom Hygiene', '1', '188.00', '188.00');
INSERT INTO `acc_invoice_type` VALUES ('310', '228', 'Pest Control', '1', '71.00', '71.00');
INSERT INTO `acc_invoice_type` VALUES ('311', '229', 'Restroom Hygiene', '1', '75.00', '75.00');
INSERT INTO `acc_invoice_type` VALUES ('312', '229', 'Pest Control', '1', '80.00', '80.00');
