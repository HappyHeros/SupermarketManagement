-- tb_goods
create table  `tb_goods`
(
       `goodsID`         INT not null comment '商品编号',
       `goodsName`       VARCHAR(4000) comment '商品名称',
       `goodsPrice`      DOUBLE comment '商品价格',
       `suplierID`       INT comment '供应商编号 供应商编号',
       `promotionalPrice` DOUBLE comment '促销价格',
       `proCreateTime`   DATETIME comment '促销始日期',
       `proEndTime`      DATETIME comment '促销止日期',
       `isDiscount`      INT comment '是否允许打折 0:允许，1:不允许',
       `stockAlarm`      INT comment '库存报警数量',
       `quantityIn`      INT comment '计划进货数',
       `barCode`         VARCHAR(4000) comment '条形码',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_goods`
       add constraint `PK_tb_goods_goodsID` primary key (`goodsID`);
alter table `tb_goods` comment= '商品信息表';

-- tb_user
/*
警告: 字段名可能非法 - password
*/
create table  `tb_user`
(
       `userID`          INT not null comment '用户编号',
       `username`        VARCHAR(4000) comment '用户名称',
       `password`        INT comment '用户密码',
       `userType`        INT comment '用户类型',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_user`
       add constraint `PK_tb_user_userID` primary key (`userID`);
alter table `tb_user` comment= '用户表';

-- tb_member
create table  `tb_member`
(
       `memberID`        INT not null comment '会员编号',
       `memberCode`      INT comment '会员卡号',
       `monetary`        DOUBLE comment '累积消费金额',
       `createTime`      DATETIME comment '注册日期',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_member`
       add constraint `PK_tb_member_memberID` primary key (`memberID`);
alter table `tb_member` comment= '会员表';

-- tb_sales
create table  `tb_sales`
(
       `salesID`         INT not null comment '销售编号',
       `goodsID`         INT comment '商品编号',
       `salesNum`        VARCHAR(4000) comment '销售数量',
       `salesPrice`      DOUBLE comment '销售金额',
       `salesTime`       DATETIME comment '销售日期',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_sales`
       add constraint `PK_tb_sales_salesID` primary key (`salesID`);
alter table `tb_sales` comment= '销售表';

-- tb_trade
create table  `tb_trade`
(
       `tradeID`         INT not null comment '交易编号',
       `username`        INT comment '用户名称',
       `tradePrice`      DOUBLE comment '交易金额',
       `memberCode`      INT comment '会员卡号',
       `tradeTime`       DATETIME comment '销售日期',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_trade`
       add constraint `PK_tb_trade_tradeID` primary key (`tradeID`);
alter table `tb_trade` comment= '交易表';

-- tb_stock
create table  `tb_stock`
(
       `stockID`         INT not null comment '入库编号',
       `stockGoodsID`    INT comment '入库商品编号',
       `stockNum`        INT comment '入库数量',
       `singleAmount`    DOUBLE comment '单额',
       `totalSum`        DOUBLE comment '总额',
       `createTime`      DATETIME not null comment '入库日期',
       `planTime`        DATETIME comment '计划进货日期',
       `stockStatus`     INT not null comment '入库状态',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_stock`
       add constraint `PK_tb_stock_stockID` primary key (`stockID`);
alter table `tb_stock` comment= '进货表';

-- tb_supplier
create table  `tb_supplier`
(
       `supplierID`      INT not null comment '供货商编号',
       `supplierName`    VARCHAR(4000) comment '供货商名称',
       `supplierAddress` VARCHAR(4000) comment '供货商地址',
       `supplierPhone`   INT comment '供货商电话',
       `remark`          VARCHAR(4000) comment '备注'
);
alter  table `tb_supplier`
       add constraint `PK_tb_supplier_supplierID` primary key (`supplierID`);
alter table `tb_supplier` comment= '供应商表';

-- tb_employees
/*
警告: 字段名可能非法 - employeeAttendance 
*/
create table  `tb_employees`
(
       `employeeID`      INT not null comment '员工编号',
       `employeeName`    VARCHAR(4000) comment '员工姓名',
       `employeePost`    VARCHAR(4000) comment '员工职位',
       `employeeAttendance ` DOUBLE comment '员工出勤率',
       `createTime`      DATETIME comment '员工入职时间',
       `achievement`     DOUBLE comment '员工业绩'
);
alter  table `tb_employees`
       add constraint `PK_tb_employees_employeeID` primary key (`employeeID`);
alter table `tb_employees` comment= '员工表';

alter  table `tb_goods`
       add constraint `FK_tb_goods_suplierID` foreign key (`suplierID`)
       references `tb_supplier`(`supplierID`);

alter  table `tb_member`
       add constraint `FK_tb_member_memberCode` foreign key (`memberCode`)
       references `tb_user`(`userID`);

alter  table `tb_sales`
       add constraint `FK_tb_sales_goodsID` foreign key (`goodsID`)
       references `tb_goods`(`goodsID`);

alter  table `tb_stock`
       add constraint `FK_tb_stock_stockGoodsID` foreign key (`stockGoodsID`)
       references `tb_goods`(`goodsID`);

