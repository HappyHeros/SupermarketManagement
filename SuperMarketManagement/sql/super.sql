/*
Navicat MySQL Data Transfer

Source Server         : localhost_3306
Source Server Version : 50728
Source Host           : localhost:3306
Source Database       : super

Target Server Type    : MYSQL
Target Server Version : 50728
File Encoding         : 65001

Date: 2019-11-26 21:05:50
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for tb_goods
-- ----------------------------
DROP TABLE IF EXISTS `tb_goods`;
CREATE TABLE `tb_goods` (
  `goodsID` varchar(11) NOT NULL COMMENT '商品编号',
  `goodsName` varchar(4000) DEFAULT NULL COMMENT '商品名称',
  `goodsPrice` double DEFAULT NULL COMMENT '商品价格',
  `suplierID` varchar(11) DEFAULT NULL COMMENT '供应商编号 供应商编号',
  `promotionalPrice` float DEFAULT NULL COMMENT '促销价格',
  `proCreateTime` datetime DEFAULT NULL COMMENT '促销始日期',
  `proEndTime` datetime DEFAULT NULL COMMENT '促销止日期',
  `isDiscount` int(11) DEFAULT NULL COMMENT '是否允许打折 0:允许，1:不允许',
  `stockAlarm` int(11) DEFAULT NULL COMMENT '库存报警数量',
  `quantityIn` int(11) DEFAULT NULL COMMENT '计划进货数',
  `barCode` varchar(4000) DEFAULT NULL COMMENT '条形码',
  `remark` varchar(4000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`goodsID`),
  KEY `supplied` (`suplierID`),
  CONSTRAINT `supplied` FOREIGN KEY (`suplierID`) REFERENCES `tb_supplier` (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='商品信息表';

-- ----------------------------
-- Records of tb_goods
-- ----------------------------
INSERT INTO `tb_goods` VALUES ('201900001', '奶糖', '2.5', '00001', '2.5', '2019-11-18 20:46:14', '2019-11-26 20:46:23', '1', '1', '1', null, '');
INSERT INTO `tb_goods` VALUES ('201900002', '口香糖', '1.5', '00001', '1.5', '2019-11-25 20:47:06', '2019-11-26 20:47:14', '1', '0', '0', null, null);
INSERT INTO `tb_goods` VALUES ('201900003', '果汁', '4.5', '00003', '4', '2019-11-25 20:48:01', '2019-11-26 20:48:06', '1', '1', '1', null, null);
INSERT INTO `tb_goods` VALUES ('201900004', '冷冻牛肉', '18', '00002', '17.5', '2019-11-26 20:48:44', '2019-11-29 20:48:49', '1', '0', '0', null, null);

-- ----------------------------
-- Table structure for tb_member
-- ----------------------------
DROP TABLE IF EXISTS `tb_member`;
CREATE TABLE `tb_member` (
  `memberID` varchar(255) NOT NULL COMMENT '会员编号',
  `memberCode` varchar(255) DEFAULT NULL COMMENT '会员卡号',
  `monetary` float DEFAULT NULL COMMENT '累积消费金额',
  `createTime` datetime DEFAULT NULL COMMENT '注册日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`memberID`),
  CONSTRAINT `member` FOREIGN KEY (`memberID`) REFERENCES `tb_user` (`userID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='会员表';

-- ----------------------------
-- Records of tb_member
-- ----------------------------
INSERT INTO `tb_member` VALUES ('000001', '12345678', '1000', '2019-11-26 20:56:23', '此用户为我们超级用户');

-- ----------------------------
-- Table structure for tb_sales
-- ----------------------------
DROP TABLE IF EXISTS `tb_sales`;
CREATE TABLE `tb_sales` (
  `salesID` varchar(255) NOT NULL COMMENT '销售编号',
  `goodsID` varchar(255) DEFAULT NULL COMMENT '商品编号',
  `salesNum` varchar(255) DEFAULT NULL COMMENT '销售数量',
  `salesPrice` float DEFAULT NULL COMMENT '销售金额',
  `salesTime` datetime DEFAULT NULL COMMENT '销售日期',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`salesID`),
  KEY `sale` (`goodsID`),
  CONSTRAINT `sale` FOREIGN KEY (`goodsID`) REFERENCES `tb_goods` (`goodsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='销售表';

-- ----------------------------
-- Records of tb_sales
-- ----------------------------
INSERT INTO `tb_sales` VALUES ('000001', '201900001', '10', '1', '2019-11-26 20:54:24', null);
INSERT INTO `tb_sales` VALUES ('000002', '201900002', '12', '1', '2019-11-26 20:54:54', null);
INSERT INTO `tb_sales` VALUES ('000003', '201900003', '13', '1', '2019-11-26 20:55:10', null);

-- ----------------------------
-- Table structure for tb_stock
-- ----------------------------
DROP TABLE IF EXISTS `tb_stock`;
CREATE TABLE `tb_stock` (
  `stockID` varchar(11) NOT NULL COMMENT '入库编号',
  `stockGoodsID` varchar(11) DEFAULT NULL COMMENT '入库商品编号',
  `stockNum` int(11) DEFAULT NULL COMMENT '入库数量',
  `singleAmount` float DEFAULT NULL COMMENT '单额',
  `totalSum` float DEFAULT NULL COMMENT '总额',
  `createTime` datetime NOT NULL COMMENT '入库日期',
  `planTime` datetime DEFAULT NULL COMMENT '计划进货日期',
  `stockStatus` int(11) NOT NULL COMMENT '入库状态',
  `remark` varchar(4000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`stockID`),
  KEY `stock` (`stockGoodsID`),
  CONSTRAINT `stock` FOREIGN KEY (`stockGoodsID`) REFERENCES `tb_goods` (`goodsID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='进货表';

-- ----------------------------
-- Records of tb_stock
-- ----------------------------
INSERT INTO `tb_stock` VALUES ('1', '201900001', '10000', '1', '10000', '2019-11-26 20:57:33', '2019-11-26 20:57:37', '1', null);
INSERT INTO `tb_stock` VALUES ('2', '201900002', '500', '1', '500', '2019-11-26 20:59:04', '2019-11-27 20:59:08', '0', null);
INSERT INTO `tb_stock` VALUES ('3', '201900003', '1000', '1', '6000', '2019-11-25 20:59:45', '2019-11-27 20:59:49', '1', null);
INSERT INTO `tb_stock` VALUES ('4', '201900004', '2321', '1', '2321', '2019-11-26 21:00:24', '2019-11-26 21:00:27', '0', null);

-- ----------------------------
-- Table structure for tb_supplier
-- ----------------------------
DROP TABLE IF EXISTS `tb_supplier`;
CREATE TABLE `tb_supplier` (
  `supplierID` varchar(11) NOT NULL COMMENT '供货商编号',
  `supplierName` varchar(255) DEFAULT NULL COMMENT '供货商名称',
  `supplierAddress` varchar(255) DEFAULT NULL COMMENT '供货商地址',
  `supplierPhone` varchar(11) DEFAULT NULL COMMENT '供货商电话',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`supplierID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='供应商表';

-- ----------------------------
-- Records of tb_supplier
-- ----------------------------
INSERT INTO `tb_supplier` VALUES ('00001', '糖果供应商', '广州市番禺区大学城西一419', '110', null);
INSERT INTO `tb_supplier` VALUES ('00002', '冷冻食品供应商', '广州市番禺区大学城西一419供肉馆', '120', null);
INSERT INTO `tb_supplier` VALUES ('00003', '饮料食品供应商', '西一419饮料供应点', '119', null);

-- ----------------------------
-- Table structure for tb_trade
-- ----------------------------
DROP TABLE IF EXISTS `tb_trade`;
CREATE TABLE `tb_trade` (
  `tradeID` varchar(255) CHARACTER SET utf32 NOT NULL COMMENT '交易编号',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `tradePrice` float DEFAULT NULL COMMENT '交易金额',
  `memberCode` varchar(255) DEFAULT NULL COMMENT '会员卡号',
  `tradeTime` datetime DEFAULT NULL COMMENT '销售日期',
  `remark` varchar(4000) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`tradeID`),
  KEY `trade` (`username`),
  CONSTRAINT `trade` FOREIGN KEY (`username`) REFERENCES `tb_user` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='交易表';

-- ----------------------------
-- Records of tb_trade
-- ----------------------------
INSERT INTO `tb_trade` VALUES ('00001', '赵四', '1000', '12345687', '2019-11-26 21:05:16', '');

-- ----------------------------
-- Table structure for tb_user
-- ----------------------------
DROP TABLE IF EXISTS `tb_user`;
CREATE TABLE `tb_user` (
  `userID` varchar(255) NOT NULL COMMENT '用户编号',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名称',
  `password` varchar(255) DEFAULT NULL COMMENT '用户密码',
  `userType` int(11) DEFAULT NULL COMMENT '用户类型',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`userID`),
  KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COMMENT='用户表';

-- ----------------------------
-- Records of tb_user
-- ----------------------------
INSERT INTO `tb_user` VALUES ('000001', '张三', '123456', '1', null);
INSERT INTO `tb_user` VALUES ('000002', '李四', '123456', '2', null);
INSERT INTO `tb_user` VALUES ('000003', '王五', '123456', '1', null);
INSERT INTO `tb_user` VALUES ('000004', '赵四', '1234568', '3', null);
INSERT INTO `tb_user` VALUES ('000005', '普通客户', '000000', '4', null);
