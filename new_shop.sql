/*
SQLyog Ultimate v11.13 (64 bit)
MySQL - 5.7.17-log : Database - new_shop
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`new_shop` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `new_shop`;

/*Table structure for table `alembic_version` */

DROP TABLE IF EXISTS `alembic_version`;

CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `alembic_version` */

insert  into `alembic_version`(`version_num`) values ('89367bd96c7f');

/*Table structure for table `category` */

DROP TABLE IF EXISTS `category`;

CREATE TABLE `category` (
  `id` varchar(50) NOT NULL,
  `cname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `category` */

insert  into `category`(`id`,`cname`) values ('1','女装男装'),('2','鞋靴箱包'),('3','运动户外'),('4','珠宝配饰'),('5','手机数码'),('6','生活用品'),('7','护肤彩妆');

/*Table structure for table `category_second` */

DROP TABLE IF EXISTS `category_second`;

CREATE TABLE `category_second` (
  `id` varchar(50) NOT NULL,
  `csname` varchar(255) NOT NULL,
  `cid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `category_second_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `category_second` */

insert  into `category_second`(`id`,`csname`,`cid`) values ('1','潮流女装','1'),('10','短靴','2'),('11','男鞋','2'),('12','女包','2'),('13','男包','2'),('14','服饰配件','2'),('16','运动服','3'),('17','户外运动','3'),('18','健身装备','3'),('19','骑行装备','3'),('2','初冬羽绒','1'),('20','珠宝首饰','4'),('21','时尚饰品','4'),('22','品质手表','4'),('23','眼镜配饰','4'),('24','手机','5'),('25','平板','5'),('26','电脑','5'),('27','相机','5'),('28','大家电','6'),('29','厨房电器','6'),('3','毛呢大衣','1'),('30','生活电器','6'),('31','个户电器','6'),('32','办公耗材','6'),('33','美容护肤','7'),('34','强效保养','7'),('35','超值彩妆','7'),('4','温暖毛衣','1'),('5','精选男装','1'),('6','冬季外套','1'),('7','羽绒服','1'),('9','女鞋','2');

/*Table structure for table `comment` */

DROP TABLE IF EXISTS `comment`;

CREATE TABLE `comment` (
  `id` varchar(50) NOT NULL,
  `content` text NOT NULL,
  `is_read` int(11) DEFAULT NULL,
  `cdate` datetime DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `comment_id` varchar(50) DEFAULT NULL,
  `pid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `comment_id` (`comment_id`),
  KEY `pid` (`pid`),
  CONSTRAINT `comment_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `comment_ibfk_2` FOREIGN KEY (`comment_id`) REFERENCES `comment` (`id`),
  CONSTRAINT `comment_ibfk_3` FOREIGN KEY (`pid`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `comment` */

insert  into `comment`(`id`,`content`,`is_read`,`cdate`,`uid`,`comment_id`,`pid`) values ('df62ef76d2af11e88719b808cfd4f089','么么哒',0,'2018-10-18 16:29:04','191806a4d29811e89e82b808cfd4f089',NULL,NULL);

/*Table structure for table `order` */

DROP TABLE IF EXISTS `order`;

CREATE TABLE `order` (
  `id` varchar(50) NOT NULL,
  `total_money` float DEFAULT NULL,
  `ordertime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL,
  `name` varchar(50) NOT NULL,
  `phone` varchar(50) NOT NULL,
  `addr` varchar(255) NOT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `order_last_time` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  CONSTRAINT `order_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order` */

/*Table structure for table `order_item` */

DROP TABLE IF EXISTS `order_item`;

CREATE TABLE `order_item` (
  `id` varchar(50) NOT NULL,
  `count` int(11) NOT NULL,
  `sub_total` float NOT NULL,
  `pid` varchar(50) DEFAULT NULL,
  `oid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`pid`),
  KEY `oid` (`oid`),
  CONSTRAINT `order_item_ibfk_1` FOREIGN KEY (`pid`) REFERENCES `product` (`id`) ON DELETE CASCADE,
  CONSTRAINT `order_item_ibfk_2` FOREIGN KEY (`oid`) REFERENCES `order` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `order_item` */

/*Table structure for table `product` */

DROP TABLE IF EXISTS `product`;

CREATE TABLE `product` (
  `id` varchar(50) NOT NULL,
  `pname` varchar(255) NOT NULL,
  `old_price` float NOT NULL,
  `new_price` float NOT NULL,
  `images` text,
  `is_hot` int(11) DEFAULT NULL,
  `is_sell` int(11) DEFAULT NULL,
  `pdate` datetime DEFAULT NULL,
  `click_count` int(11) DEFAULT NULL,
  `counts` int(11) NOT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `pDesc` text,
  `love_user` text,
  `is_pass` int(11) DEFAULT NULL,
  `head_img` varchar(255) DEFAULT NULL,
  `csid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `csid` (`csid`),
  CONSTRAINT `product_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `product_ibfk_2` FOREIGN KEY (`csid`) REFERENCES `category_second` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `product` */

insert  into `product`(`id`,`pname`,`old_price`,`new_price`,`images`,`is_hot`,`is_sell`,`pdate`,`click_count`,`counts`,`uid`,`pDesc`,`love_user`,`is_pass`,`head_img`,`csid`) values ('00337a10d29b11e8802cb808cfd4f089','Apple iPhone XS Max (A2103) 64GB 金色 全网通（移动4G优先版） 双卡双待',7999,7299,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexsmax1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexsmax2.jpg',1,1,'2018-10-21 07:23:17',1,1,'191806a4d29811e89e82b808cfd4f089','品牌： Apple\r\n商品名称：AppleiPhone Xs Max\r\n商品编号：100001860773\r\n商品毛重：495.00g\r\n商品产地：中国\r\n系统：ios系统\r\n',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexsmax2.jpg','24'),('0989b8f6d2a111e8a452b808cfd4f089','Apple AirPods 蓝牙无线耳机 适用于iPhone7/8/X手机耳机',1299,1000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94airpods1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94airpods2.jpg',2,1,'2018-10-21 12:05:59',123,1,'191806a4d29811e89e82b808cfd4f089','超24小时续航，Apple品牌配件，智慧生活，妙不可言！',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94airpods2.jpg','24'),('34d0b7e8d2a111e8ac05b808cfd4f089','Apple iPhone 8 Plus (A1864) 64GB 深空灰色 移动联通电信4G手机',6688,5555,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphone8plus1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphone8plus2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphone8plus3.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphone8plus4.jpg',2,1,'2018-10-21 12:41:53',78,1,'191806a4d29811e89e82b808cfd4f089','品牌： Apple\n商品名称：AppleiPhone 8 Plus商品编号：5089275商品毛重：480.00g商品产地：中国大陆多卡支持：单卡单待网络制式：4G LTE全网通机身内存：64GB4G LTE网络特性：移动4G+',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphone8plus1.jpg','24'),('38037514d2a011e89676b808cfd4f089','小牛（XIAONIU） 小牛电动 N 系列车塑料模型1:12DIY组装玩具拼装版 ',8000,7000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu3.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu4.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu5.jpg',1,1,'2018-10-19 16:29:42',9,1,'191806a4d29811e89e82b808cfd4f089','品牌： 小牛（XIAONIU）\n商品名称：小牛（XIAONIU） 小牛电动 N 系列车塑料模型1:12DIY组装玩具拼装版 预上色 白色商品编号：30724955293店铺： 小牛旗舰店商品毛重：200.00g商品产地：中国大陆货号：50130004尺码：均码',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94xiaoniu1.jpg','24'),('64dad6d2d4d111e8866fb808cfd4f089',' 李宁双肩背包女运动生活系列电脑书包ABSJ392 迷彩深色 尺寸',169,119,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lining1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lining2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lining3.jpg',0,1,'2018-10-21 11:10:04',5,1,'191806a4d29811e89e82b808cfd4f089','商品名称：李宁双肩背包男女通用运动生活系列电脑书包ABSJ392 迷彩深色 尺寸300*190*480MM商品编号：11300415412店铺： 李宁飞酷专卖店商品毛重：0.6kg货号：ABSJ392分类：双肩包适用人群：中性适用场景：运动',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lining1.jpg','12'),('6fc83e6ed2a111e88cf7b808cfd4f089','Apple 苹果 iPhone X 全面屏手机 银色 全网通 64GB',7299,5000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iPhonex1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iPhonex2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iPhonex3.jpg',2,1,'2018-10-21 12:57:44',129,1,'191806a4d29811e89e82b808cfd4f089','商品名称：AppleiPhone X商品编号：16580907535店铺： 佳沪手机旗舰店商品毛重：0.6kg多卡支持：单卡单待机身厚度：薄（7mm-8.5mm）拍照特点：光学变焦，后置双摄像头网络制式：4G LTE全网通4G LTE网络特性：其他热点：无线充电，人脸识别前置摄像头像素：800万-1599万屏幕配置：OLED屏，符合全面屏比例电池容量：2000mAh-2999mAh',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iPhonex1.jpg','24'),('8b52ceeed2a011e89d91b808cfd4f089','ARMANI阿玛尼女士口红唇釉唇膏 400#复古大红 臻致丝绒哑光红管唇釉6.5ml',199,100,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94amani1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94amani2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94amani3.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94amani4.jpg',1,1,'2018-10-19 15:14:23',3,1,'191806a4d29811e89e82b808cfd4f089','商品名称：【国内专柜 京东配达】ARMANI阿玛尼女士口红唇釉唇膏 400#复古大红 臻致丝绒哑光红管唇釉6.5ml商品编号：11016273021店铺： 瑞博纳化妆品专营店商品毛重：70.00g国产/进口：进口妆效：其它色系：其它',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94amani1.jpg','24'),('adf6ec2ed29f11e88a64b808cfd4f089','联想（Lenovo） Ideapad330C 15.6英寸8代i5/i7双硬盘轻薄商务笔记本电脑 ',12999,9999,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94%E8%81%94%E6%83%B3%E7%94%B5%E8%84%912.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94%E8%81%94%E6%83%B3%E7%94%B5%E8%84%912.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94%E8%81%94%E6%83%B3%E7%94%B5%E8%84%913.jpg',1,1,'2018-10-19 15:13:50',1,1,'191806a4d29811e89e82b808cfd4f089','商品名称：联想（Lenovo） Ideapad330C 15.6英寸8代i5/i7双硬盘轻薄商务笔记本电脑 定制i5-8250U【8G/1T+128G固态】 2G独显 正版Office2016送小米鼠标商品编号：26006166289店铺： 联想京湘通授权专卖店商品毛重：2.0kg系统：Windows 10厚度：20.0mm以上硬盘容量：128G+1T色系：黑色系待机时长：小于5小时系列：联想 - IdeaPad裸机重量：2-2.5kg显卡类别：高性能游戏独立显卡屏幕尺寸：15.6英寸显卡型号：其他特性：窄边框，其他内存容量：8G分辨率：全高清屏（1920×1080）显存容量：2G分类：游戏本，轻薄本，常规笔记本，其它　处理器：Intel i5低功耗版游戏性能：入门级，发烧级\n',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94%E8%81%94%E6%83%B3%E7%94%B5%E8%84%911.jpg','24'),('b6136dc6d2a111e8b281b808cfd4f089','三星 Galaxy Note9（SM-N9600 6GB+128G）丹青黑移动联通电信4G手机 双卡',6999,5000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing3.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing4.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing5.jpg',1,1,'2018-10-21 10:55:33',51,1,'191806a4d29811e89e82b808cfd4f089','商品名称：三星Galaxy Note9商品编号：8636676商品毛重：0.57kg商品产地：中国大陆系统：安卓（Android）机身厚度：普通（8.5mm以上）拍照特点：光学变焦，智能拍照，后置双摄像头屏幕配置：OLED屏，曲面屏，防蓝光，3D屏，符合全面屏比例后置摄像头像素：1200万-1999万电池容量：4000mAh-5999mAh多卡支持：双卡双待单4G4G LTE网络特性：VOLTE 4G通话热点：人工智能，人脸识别，无线充电，液冷散热运行内存：6GB前置摄像头像素：800万-1599万网络制式：4G LTE全网通机身颜色：黑色系游戏配置：游戏模式，游戏音效增强，游戏显示增强，游戏深度适配/调优机身内存：512GB',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94sanxing1.jpg','24'),('ca7f2450d2a011e8add8b808cfd4f089','魅族 16 X 全面屏手机 6GB+64GB 砚墨黑 全网通移动联通电信4G手机 双卡双待',1699,1509,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94meizu1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94meizu2.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94meizu3.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94meizu4.jpg',1,1,'2018-10-20 17:31:23',24,1,'191806a4d29811e89e82b808cfd4f089','品牌： 魅族（MEIZU）\n商品名称：魅族 16 X商品编号：100000400130商品毛重：447.00g商品产地：中国大陆系统：安卓（Android）机身厚度：薄（7mm-8.5mm）拍照特点：后置双摄像头4G LTE网络特性：其他运行内存：6GB游戏配置：游戏模式屏幕配置：符合全面屏比例电池容量：3000mAh-3999mAh机身颜色：黑色系热点：屏下指纹前置摄像头像素：2000万及以上老人机配置：远程协助网络制式：4G LTE全网通后置摄像头像素：2000万及以上机身内存：64GB多卡支持：双卡双待单4G',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94meizu1.jpg','24'),('fa659a2cd29d11e890a5b808cfd4f089','Z-RC 德国 成人儿童智能平衡车两轮双轮 体感车代步车电动迷你思维自平衡车儿童扭扭车漂移车平衡车 新款迷紫手提自平衡带蓝牙跑马灯送护具35KM',2800,2000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lingao1.png@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lingao2.png@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lingao3.png@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lingao4.png',1,1,'2018-10-20 22:52:11',4,1,'191806a4d29811e89e82b808cfd4f089','商品名称：领奥 Mini智能电动儿童平衡车两轮成人越野双轮思维代步扭扭车体感车带扶手 APP遥控 白色36V音乐款【10吋炫光轮+腿控手控+APP】商品编号：13518611392店铺： 领奥旗舰店商品毛重：20.0kg货号：领奥迷你重量：10-20kg理论时速：10-20km/h能否折叠：不可折叠额定功率：501W-1000W电池能否拆卸：可拆卸电池类别：锂电池控制方式：遥控，腿杆控，手杆控理论续航：10-20km电池电压：36V适用人群：成人变速档位：单速标准认证：CE认证分类：两轮体感车款式：两轮轮圈尺寸：10英寸',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94lingao1.png','24'),('fbe6d908d29e11e88b6fb808cfd4f089',' Apple iPhone XS Max (A2104) 256GB 金色 移动联通电信4G手机 双',12999,10000,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexr1.jpg@http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexr2.jpg',1,1,'2018-10-21 11:08:49',40,1,'191806a4d29811e89e82b808cfd4f089','品牌： Apple\n商品名称：AppleiPhone XS Max商品编号：100000287117商品毛重：480.00g商品产地：中国系统：ios系统',NULL,2,'http://qiniuyun.lmxljc.xyz/%E6%AF%95%E4%B8%9A%E2%80%94iphonexr2.jpg','24');

/*Table structure for table `shop_cart` */

DROP TABLE IF EXISTS `shop_cart`;

CREATE TABLE `shop_cart` (
  `id` varchar(50) NOT NULL,
  `sdate` datetime DEFAULT NULL,
  `count` int(11) DEFAULT NULL,
  `uid` varchar(50) DEFAULT NULL,
  `pid` varchar(50) DEFAULT NULL,
  `subTotal` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `uid` (`uid`),
  KEY `pid` (`pid`),
  CONSTRAINT `shop_cart_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `user` (`id`) ON DELETE CASCADE,
  CONSTRAINT `shop_cart_ibfk_2` FOREIGN KEY (`pid`) REFERENCES `product` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `shop_cart` */

/*Table structure for table `user` */

DROP TABLE IF EXISTS `user`;

CREATE TABLE `user` (
  `id` varchar(50) NOT NULL,
  `username` varchar(50) NOT NULL,
  `password` varchar(255) NOT NULL,
  `name` varchar(50) DEFAULT NULL,
  `email` varchar(100) NOT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `addr` varchar(255) DEFAULT NULL,
  `is_ok` int(11) DEFAULT NULL,
  `img_url` text,
  `create_time` datetime DEFAULT NULL,
  `identity` int(11) DEFAULT NULL,
  `scores` int(11) DEFAULT NULL,
  `shop_time` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

/*Data for the table `user` */

insert  into `user`(`id`,`username`,`password`,`name`,`email`,`phone`,`addr`,`is_ok`,`img_url`,`create_time`,`identity`,`scores`,`shop_time`) values ('191806a4d29811e89e82b808cfd4f089','李沫熙','pbkdf2:sha256:50000$zQZqUfVa$099deb314db9018fb79e7b67ee7b188333297fe6e2de3f99728862a6b9667581','李沫熙','1247721306@qq.com','13193801071','南阳理工汇森5楼',1,'http://pgfgqbd3k.bkt.clouddn.com/657d88f6d46911e893f3b808cfd4f089.jpg','2018-10-18 13:38:53',0,0,NULL),('85d8a4f6d4dd11e8a23ab808cfd4f089','李先生','pbkdf2:sha256:50000$PE2XpR69$abf7798119bcc9bb9210ffe896efd60871168ebe0113510f5b2c3d339ba92733','李先生','3531039691@qq.com','13193801071','南阳理工汇森5楼',1,'http://pgfgqbd3k.bkt.clouddn.com/bef0eedad4dd11e8a427b808cfd4f089.jpg','2018-10-21 11:00:53',0,0,NULL);

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
