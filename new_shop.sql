/*
 Navicat Premium Data Transfer

 Source Server         : 本地
 Source Server Type    : MySQL
 Source Server Version : 50728
 Source Host           : localhost:3306
 Source Schema         : new_shop

 Target Server Type    : MySQL
 Target Server Version : 50728
 File Encoding         : 65001

 Date: 08/05/2020 23:57:44
*/

SET NAMES utf8mb4;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
-- Table structure for alembic_version
-- ----------------------------
DROP TABLE IF EXISTS `alembic_version`;
CREATE TABLE `alembic_version` (
  `version_num` varchar(32) NOT NULL,
  PRIMARY KEY (`version_num`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of alembic_version
-- ----------------------------
BEGIN;
INSERT INTO `alembic_version` VALUES ('89367bd96c7f');
COMMIT;

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` varchar(50) NOT NULL,
  `cname` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
BEGIN;
INSERT INTO `category` VALUES ('1', '女装男装');
INSERT INTO `category` VALUES ('2', '鞋靴箱包');
INSERT INTO `category` VALUES ('3', '运动户外');
INSERT INTO `category` VALUES ('4', '珠宝配饰');
INSERT INTO `category` VALUES ('5', '手机数码');
INSERT INTO `category` VALUES ('6', '生活用品');
INSERT INTO `category` VALUES ('7', '护肤彩妆');
COMMIT;

-- ----------------------------
-- Table structure for category_second
-- ----------------------------
DROP TABLE IF EXISTS `category_second`;
CREATE TABLE `category_second` (
  `id` varchar(50) NOT NULL,
  `csname` varchar(255) NOT NULL,
  `cid` varchar(50) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`),
  CONSTRAINT `category_second_ibfk_1` FOREIGN KEY (`cid`) REFERENCES `category` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category_second
-- ----------------------------
BEGIN;
INSERT INTO `category_second` VALUES ('1', '潮流女装', '1');
INSERT INTO `category_second` VALUES ('10', '短靴', '2');
INSERT INTO `category_second` VALUES ('11', '男鞋', '2');
INSERT INTO `category_second` VALUES ('12', '女包', '2');
INSERT INTO `category_second` VALUES ('13', '男包', '2');
INSERT INTO `category_second` VALUES ('14', '服饰配件', '2');
INSERT INTO `category_second` VALUES ('16', '运动服', '3');
INSERT INTO `category_second` VALUES ('17', '户外运动', '3');
INSERT INTO `category_second` VALUES ('18', '健身装备', '3');
INSERT INTO `category_second` VALUES ('19', '骑行装备', '3');
INSERT INTO `category_second` VALUES ('2', '初冬羽绒', '1');
INSERT INTO `category_second` VALUES ('20', '珠宝首饰', '4');
INSERT INTO `category_second` VALUES ('21', '时尚饰品', '4');
INSERT INTO `category_second` VALUES ('22', '品质手表', '4');
INSERT INTO `category_second` VALUES ('23', '眼镜配饰', '4');
INSERT INTO `category_second` VALUES ('24', '手机', '5');
INSERT INTO `category_second` VALUES ('25', '平板', '5');
INSERT INTO `category_second` VALUES ('26', '电脑', '5');
INSERT INTO `category_second` VALUES ('27', '相机', '5');
INSERT INTO `category_second` VALUES ('28', '大家电', '6');
INSERT INTO `category_second` VALUES ('29', '厨房电器', '6');
INSERT INTO `category_second` VALUES ('3', '毛呢大衣', '1');
INSERT INTO `category_second` VALUES ('30', '生活电器', '6');
INSERT INTO `category_second` VALUES ('31', '个户电器', '6');
INSERT INTO `category_second` VALUES ('32', '办公耗材', '6');
INSERT INTO `category_second` VALUES ('33', '美容护肤', '7');
INSERT INTO `category_second` VALUES ('34', '强效保养', '7');
INSERT INTO `category_second` VALUES ('35', '超值彩妆', '7');
INSERT INTO `category_second` VALUES ('4', '温暖毛衣', '1');
INSERT INTO `category_second` VALUES ('5', '精选男装', '1');
INSERT INTO `category_second` VALUES ('6', '冬季外套', '1');
INSERT INTO `category_second` VALUES ('7', '羽绒服', '1');
INSERT INTO `category_second` VALUES ('9', '女鞋', '2');
COMMIT;

-- ----------------------------
-- Table structure for comment
-- ----------------------------
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

-- ----------------------------
-- Records of comment
-- ----------------------------
BEGIN;
INSERT INTO `comment` VALUES ('0170b81a81df11ea9c4dacde48001122', '哈哈哈哈哈 确实不错', 0, '2020-04-19 09:42:19', '191806a4d29811e89e82b808cfd4f089', NULL, NULL);
INSERT INTO `comment` VALUES ('251944788f9311ea8675acde48001122', '这个车子真的很便宜 欢迎大家来买', 0, '2020-05-06 20:14:33', '4ebfe6b8554311ea8306acde48001122', NULL, 'b0fe4e328ea011ea9d5eacde48001122');
INSERT INTO `comment` VALUES ('2ed39da490fd11eaadc8acde48001122', '我的和这个一样 买的时候真的很不错', 0, '2020-05-08 15:26:07', '191806a4d29811e89e82b808cfd4f089', NULL, '9ccbc7628ea211eaaed5acde48001122');
INSERT INTO `comment` VALUES ('372a8e6a8f9311ea8675acde48001122', '是的呢 这', 0, '2020-05-06 20:15:04', '4ebfe6b8554311ea8306acde48001122', '251944788f9311ea8675acde48001122', NULL);
INSERT INTO `comment` VALUES ('39f44f7690fd11eaadc8acde48001122', '嗯嗯 这个价钱很低', 0, '2020-05-08 15:26:26', '191806a4d29811e89e82b808cfd4f089', '2ed39da490fd11eaadc8acde48001122', NULL);
INSERT INTO `comment` VALUES ('42a5b8da555211eabba8acde48001122', '你好', 0, '2020-02-22 17:03:58', '4ebfe6b8554311ea8306acde48001122', NULL, 'b6136dc6d2a111e8b281b808cfd4f089');
INSERT INTO `comment` VALUES ('699541fe904911eab57aacde48001122', '真不错，好喜欢', 0, '2020-05-07 17:59:17', '191806a4d29811e89e82b808cfd4f089', NULL, '73336ac8555d11ea8a88acde48001122');
INSERT INTO `comment` VALUES ('8fd12452592e11eab856acde48001122', '这小米手机是正品吗 可以便宜点吗', 0, '2020-02-27 14:58:30', '191806a4d29811e89e82b808cfd4f089', NULL, '3284b00c592e11eab856acde48001122');
INSERT INTO `comment` VALUES ('d3a4964e556611eaaa43acde48001122', '你好价格可以便宜一点吗', 0, '2020-02-22 19:31:11', '191806a4d29811e89e82b808cfd4f089', NULL, '34d0b7e8d2a111e8ac05b808cfd4f089');
INSERT INTO `comment` VALUES ('df62ef76d2af11e88719b808cfd4f089', '么么哒', 0, '2018-10-18 16:29:04', '191806a4d29811e89e82b808cfd4f089', NULL, NULL);
INSERT INTO `comment` VALUES ('e8700022556611eaaa43acde48001122', '不好意思 已经是最低价钱啦', 0, '2020-02-22 19:31:46', '4ebfe6b8554311ea8306acde48001122', 'd3a4964e556611eaaa43acde48001122', NULL);
INSERT INTO `comment` VALUES ('fd446076591a11eab856acde48001122', '咋样', 0, '2020-02-27 12:38:24', '191806a4d29811e89e82b808cfd4f089', NULL, 'fa659a2cd29d11e890a5b808cfd4f089');
INSERT INTO `comment` VALUES ('fefd8e40847d11eab2cfacde48001122', '嗯嗯呢能', 0, '2020-04-22 17:45:27', '191806a4d29811e89e82b808cfd4f089', 'fd446076591a11eab856acde48001122', NULL);
COMMIT;

-- ----------------------------
-- Table structure for order
-- ----------------------------
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

-- ----------------------------
-- Records of order
-- ----------------------------
BEGIN;
INSERT INTO `order` VALUES ('59ded3f2914211eab7d4acde48001122', 7299, '2020-05-08 23:41:15', 0, '', '', '', '191806a4d29811e89e82b808cfd4f089', '17:26');
COMMIT;

-- ----------------------------
-- Table structure for order_item
-- ----------------------------
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

-- ----------------------------
-- Records of order_item
-- ----------------------------
BEGIN;
INSERT INTO `order_item` VALUES ('4e97cbb8914011eab7d4acde48001122', 1, 7299, '00337a10d29b11e8802cb808cfd4f089', '59ded3f2914211eab7d4acde48001122');
COMMIT;

-- ----------------------------
-- Table structure for product
-- ----------------------------
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

-- ----------------------------
-- Records of product
-- ----------------------------
BEGIN;
INSERT INTO `product` VALUES ('00337a10d29b11e8802cb808cfd4f089', 'Apple iPhone XS Max (A2103) 64GB 金色 全网通（移动4G优先版） 双卡双待', 7999, 7299, 'http://qiniuyun.donghao.club/45ab3dd6c35d981b.jpg@http://qiniuyun.donghao.club/3f3e4aa3c7515658.jpg', 0, 1, '2020-05-08 23:28:48', 14, 0, '191806a4d29811e89e82b808cfd4f089', '品牌： Apple\r\n商品名称：AppleiPhone Xs Max\r\n商品编号：100001860773\r\n商品毛重：495.00g\r\n商品产地：中国\r\n系统：ios系统\r\n', '', 2, 'http://qiniuyun.donghao.club/45ab3dd6c35d981b.jpg', '24');
INSERT INTO `product` VALUES ('0631afe0914211eab7d4acde48001122', 'Apple 2019 MacBook Pro 16【带触控栏】九代六核i7 16G 512G深空灰 ', 18799, 17333, 'http://qiniuyun.donghao.club/0282cae6914211eab7d4acde48001122.jpg@http://qiniuyun.donghao.club/03ae4cd8914211eab7d4acde48001122.jpg@', 0, 1, '2020-05-08 23:55:52', 3, 1, '4ebfe6b8554311ea8306acde48001122', '运行速度：非常好，挺快的！2.4G要好\n屏幕效果：分辨率非常高，色彩柔和，舒服\n散热性能：办公用散热不错\n外形外观：深灰色内涵大气，上档次，特别漂亮\n轻薄程度：挺薄！非常适中，特别喜欢！\n其他特色：13.3大小合适，重量可以，没有鼠标，需要自配！', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/0282cae6914211eab7d4acde48001122.jpg', '26');
INSERT INTO `product` VALUES ('0989b8f6d2a111e8a452b808cfd4f089', 'Apple AirPods 蓝牙无线耳机 适用于iPhone7/8/X手机耳机', 1299, 1000, 'http://qiniuyun.donghao.club/dd359563dc751ca5%20%281%29.jpg@http://qiniuyun.donghao.club/70e84d1d269937ed.jpg', 0, 1, '2020-05-08 22:59:32', 163, 1, '191806a4d29811e89e82b808cfd4f089', '超24小时续航，Apple品牌配件，智慧生活，妙不可言！', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/70e84d1d269937ed.jpg', '24');
INSERT INTO `product` VALUES ('3284b00c592e11eab856acde48001122', '小米10 双模5G 骁龙865 1亿像素8K相机 对称式立体声 8GB+256GB 钛银黑', 4299, 3999, 'http://qiniuyun.donghao.club/31e90846592e11eab856acde48001122.jpg@http://qiniuyun.donghao.club/32602b9c592e11eab856acde48001122.jpg@http://qiniuyun.donghao.club/326fafe0592e11eab856acde48001122.jpg@http://qiniuyun.donghao.club/3278f686592e11eab856acde48001122.jpg@', 0, 1, '2020-05-08 23:14:03', 11, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：小米10商品编号：100011199522商品毛重：0.6kg商品产地：中国大陆游戏性能：发烧级操作系统：Android(安卓)\n上面是配置 我才买的没多久 不喜欢这个颜色 所以出售出', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/3278f686592e11eab856acde48001122.jpg', '24');
INSERT INTO `product` VALUES ('34d0b7e8d2a111e8ac05b808cfd4f089', 'Apple iPhone 11 Pro (A2217) 256GB 银色 移动联通电信4G手机 双卡双待', 9999, 5555, 'http://qiniuyun.donghao.club/2461a6a0c4d4b3db.jpg@http://qiniuyun.donghao.club/343e35fc42a307fd.jpg@http://qiniuyun.donghao.club/15d9c43f11b0ab52.jpg@http://qiniuyun.donghao.club/37080986778851b4.jpg', 0, 1, '2020-05-08 23:14:51', 144, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：AppleiPhone 11 Pro商品编号：100008348510商品毛重：500.00g商品产地：中国大陆CPU型号：其他运行内存：其它内存机身存储：256GB存储卡：不支持存储卡摄像头数量：后置三摄后摄主摄像素：1200万像素前摄主摄像素：1200万像素主屏幕尺寸（英寸）：5.8英寸分辨率：其它分辨率屏幕比例：其它屏幕比例屏幕前摄组合：其他电池容量（mAh）：以官网信息为准充电器：其他机身颜色：银色操作系统：iOS(Apple)', '4ebfe6b8554311ea8306acde48001122_191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/2461a6a0c4d4b3db.jpg', '24');
INSERT INTO `product` VALUES ('38037514d2a011e89676b808cfd4f089', '耐克NIKE 男子 透气 缓震 跑步鞋  运动鞋 CI3787-008黑色40码', 519, 442, 'http://qiniuyun.donghao.club/1e1ba7f4f9b6beaf.jpg@http://qiniuyun.donghao.club/0baccec45c425e4c.jpg@http://qiniuyun.donghao.club/993a7456c638b93b.jpg', 0, 1, '2020-05-08 19:46:09', 19, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：耐克AA7403商品编号：100005923001商品毛重：0.7kg商品产地：以实物为准货号：CI3787-008适合路面：跑道，公路，小道鞋面材质：织物上市时间：2019年秋季选购热点：经典款功能：透气适用人群：男士闭合方式：系带', NULL, 2, 'http://qiniuyun.donghao.club/1e1ba7f4f9b6beaf.jpg', '11');
INSERT INTO `product` VALUES ('484152348e0211eaa870acde48001122', 'Apple iPhone SE (A2298) 64GB 红色 移动联通电信4G手机', 3999, 2999, 'http://qiniuyun.donghao.club/41b8ec388e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/42abf7488e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/43532bbc8e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/4539a4428e0211eaa870acde48001122.jpg@', 0, 1, '2020-05-08 14:33:19', 12, 1, '191806a4d29811e89e82b808cfd4f089', '品牌： Apple\n商品名称：AppleiPhone SE (第二代)商品编号：100012686112商品毛重：400.00g商品产地：中国大陆CPU型号：其他运行内存：其它内存机身存储：64GB存储卡：不支持存储卡摄像头数量：后置单摄后摄主摄像素：1200万像素前摄主摄像素：700万像素主屏幕尺寸（英寸）：4.7英寸分辨率：其它分辨率屏幕比例：其它屏幕比例屏幕前摄组合：其他充电器：其他', NULL, 2, 'http://qiniuyun.donghao.club/41b8ec388e0211eaa870acde48001122.jpg', '24');
INSERT INTO `product` VALUES ('4bd0b7508e0211eaa870acde48001122', 'Apple iPhone SE (A2298) 64GB 红色 移动联通电信4G手机', 3999, 2999, 'http://qiniuyun.donghao.club/45ae84068e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/46e60e848e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/479cc9f88e0211eaa870acde48001122.jpg@http://qiniuyun.donghao.club/49b544d68e0211eaa870acde48001122.jpg@', 0, 1, '2020-05-06 21:18:57', 0, 1, '191806a4d29811e89e82b808cfd4f089', '品牌： Apple\n商品名称：AppleiPhone SE (第二代)商品编号：100012686112商品毛重：400.00g商品产地：中国大陆CPU型号：其他运行内存：其它内存机身存储：64GB存储卡：不支持存储卡摄像头数量：后置单摄后摄主摄像素：1200万像素前摄主摄像素：700万像素主屏幕尺寸（英寸）：4.7英寸分辨率：其它分辨率屏幕比例：其它屏幕比例屏幕前摄组合：其他充电器：其他', NULL, 0, 'http://qiniuyun.donghao.club/49b544d68e0211eaa870acde48001122.jpg', '24');
INSERT INTO `product` VALUES ('64dad6d2d4d111e8866fb808cfd4f089', 'Apple iPad Pro 11英寸平板电脑2018年新款（256G WLAN+Cellular/全面屏/A12X芯片/Face ID MU1C2CH/A）银色', 8299, 5200, 'http://qiniuyun.donghao.club/26ce5396338b6519.jpg@http://qiniuyun.donghao.club/f4c8eb97699aa637.jpg', 0, 1, '2020-05-07 22:13:20', 44, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：AppleiPad商品编号：100000305421商品毛重：0.86kg商品产地：中国大陆系统：ios系统存储容量：256GB厚度：7.0mm以下屏幕尺寸：其他分类：娱乐平板颜色：银色', '4ebfe6b8554311ea8306acde48001122_191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/f4c8eb97699aa637.jpg', '25');
INSERT INTO `product` VALUES ('73336ac8555d11ea8a88acde48001122', '稻草人（MEXICAN）双肩包女时尚休闲背包学院帆布书包 红色', 169, 99, 'http://qiniuyun.donghao.club/72d6540a555d11ea8a88acde48001122.jpg@http://qiniuyun.donghao.club/730ca5aa555d11ea8a88acde48001122.jpg@http://qiniuyun.donghao.club/731e215e555d11ea8a88acde48001122.jpg@http://qiniuyun.donghao.club/7328a160555d11ea8a88acde48001122.jpg@', 0, 1, '2020-05-07 17:59:04', 34, 1, '4ebfe6b8554311ea8306acde48001122', '商品名称：稻草人双肩包商品编号：6547438商品毛重：0.63kg商品产地：中国大陆货号：MLJB01170973RD01A风格：日韩风容纳电脑尺寸：13.1-14英寸软硬度：软内部结构：手机袋，拉链暗袋有无夹层：无夹层里料材质：涤纶是否可折叠：可折叠适用场景：休闲图案：纯色附属肩带：双根大小：中包闭合方式：拉链材质：帆布箱包外袋种类：立体袋颜色：红色是否防水：防泼水提拎部件类型：软把适用人群：青年上市时间：2019夏季', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/7328a160555d11ea8a88acde48001122.jpg', '12');
INSERT INTO `product` VALUES ('9ccbc7628ea211eaaed5acde48001122', '戴森(Dyson) 新一代吹风机 Dyson Supersonic 电吹风 进口家用 礼物推荐 HD', 2999, 1999, 'http://qiniuyun.donghao.club/98c7b7ac8ea211eaaed5acde48001122.jpg@http://qiniuyun.donghao.club/9957344a8ea211eaaed5acde48001122.jpg@http://qiniuyun.donghao.club/99f0bc8c8ea211eaaed5acde48001122.jpg@http://qiniuyun.donghao.club/9ba3e81a8ea211eaaed5acde48001122.jpg@', 2, 1, '2020-05-08 23:14:33', 62, 1, '191806a4d29811e89e82b808cfd4f089', '戴森戴森，这个品牌很喜欢，一直从国外用到国内，吹风机是双十一活动抢到的，无敌了，我是京东十几年的忠实粉丝了，一直对京东送货十分认可，送货速度最快，没有之一，而且是送货上门，这在目前快递里面是很难得的了，包装也很精致，堪称完美，打开包装，看到我喜欢的紫色，很开心，吹风机小巧精致，配置的多头很棒滴，电源线很长很软，手感好，便于收纳，说说效果吧，风力够大，可以调节，音量也可以接受，首发吹干速度很快哟，建议头发长和多的女生试试吧，真的是不错的选择，赞赞', '191806a4d29811e89e82b808cfd4f089_9c96169c8ee511ea8e36acde48001122_4ebfe6b8554311ea8306acde48001122_', 2, 'http://qiniuyun.donghao.club/98c7b7ac8ea211eaaed5acde48001122.jpg', '30');
INSERT INTO `product` VALUES ('adf6ec2ed29f11e88a64b808cfd4f089', '尼康（Nikon）D7500 单反相机 数码相机 （AF-S DX 尼克尔 18-140mm f/3.5-5.6G ED VR 单反镜头)', 7999, 5999, 'http://qiniuyun.donghao.club/5926960cN00904afa.jpg@http://qiniuyun.donghao.club/5b7fca77N581900f7.jpg@http://qiniuyun.donghao.club/5926966fN818bfbc5.jpg@http://qiniuyun.donghao.club/59269641N3c72e367.jpg', 2, 1, '2020-05-08 23:29:47', 26, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：尼康D7500商品编号：4247631商品毛重：2.16kg商品产地：泰国（批次不同，产地不同）滤镜直径：67mm用途：人物摄影，风光摄影，运动摄影，静物摄影画幅：APS-C画幅分类：中端套头：单镜头套机像素：2000-2999万', '53d6fd8c81e211ea844facde48001122_191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/5b7fca77N581900f7.jpg', '27');
INSERT INTO `product` VALUES ('b0fe4e328ea011ea9d5eacde48001122', '小米（MI） 滑板车成人米家电动滑板自行车可折叠', 1999, 999, 'http://qiniuyun.donghao.club/ac6c05d08ea011ea9d5eacde48001122.jpg@http://qiniuyun.donghao.club/ad0cabe88ea011ea9d5eacde48001122.jpg@http://qiniuyun.donghao.club/add7b9008ea011ea9d5eacde48001122.jpg@http://qiniuyun.donghao.club/aed6328c8ea011ea9d5eacde48001122.jpg@http://qiniuyun.donghao.club/afbb05068ea011ea9d5eacde48001122.jpg@', 2, 1, '2020-05-08 22:55:34', 49, 2, '191806a4d29811e89e82b808cfd4f089', '主体\n品牌\n小米\n主要材质\n以实物为准\n型号\n电动滑板车\n轮胎尺寸\n前轮尺寸\n8.5英寸\n后轮尺寸\n8.5英寸\n独轮/双轮尺寸\n8.5英寸', '191806a4d29811e89e82b808cfd4f089_4ebfe6b8554311ea8306acde48001122_', 2, 'http://qiniuyun.donghao.club/ac6c05d08ea011ea9d5eacde48001122.jpg', '19');
INSERT INTO `product` VALUES ('b6136dc6d2a111e8b281b808cfd4f089', 'Skechers斯凯奇女鞋熊猫鞋 D\'lites时尚蝴蝶结丝绸小白鞋老爹鞋 11976 浅粉色/LTPK 36', 700, 300, 'http://qiniuyun.donghao.club/ca98bce6fd0fd462.jpg@http://qiniuyun.donghao.club/a567394d86f451ea.jpg@http://qiniuyun.donghao.club/5b154a06d5c89bff.jpg', 0, 1, '2020-05-08 19:44:46', 70, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：Skechers斯凯奇女鞋熊猫鞋 D\'lites时尚蝴蝶结丝绸小白鞋老爹鞋 11976 浅粉色/LTPK 36商品编号：52841063722店铺： skechers斯凯奇旗舰店商品毛重：500.00g货号：11976风格：韩版鞋品名称：低帮鞋鞋跟高度：中跟(3-5cm)闭合方式：系带制鞋工艺：胶粘鞋鞋底材质：复合底适用季节：春秋适用场景：日常尺码：35.5，35，36.5，36，37，37.5，38，38.5，39.5，39，40鞋面材质：混合材质流行元素：细带组合内里材质：布开口深度：深口鞋跟形状：平底鞋帮高度：低帮颜色：粉色图案：纯色鞋头款式：圆头适用人群：青年上市时间：2019年春季', '4ebfe6b8554311ea8306acde48001122_', 2, 'http://qiniuyun.donghao.club/ca98bce6fd0fd462.jpg', '9');
INSERT INTO `product` VALUES ('ca7f2450d2a011e8add8b808cfd4f089', 'PUMA彪马女装2019新款保暖长款运动服休闲羽绒服 粉 L', 999, 499, 'http://qiniuyun.donghao.club/f9b44c03842157b2.jpg@http://qiniuyun.donghao.club/abf6aed0e0a92d4e.jpg', 0, 1, '2020-05-08 22:50:21', 34, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：PUMA彪马女装2019新款保暖长款运动服休闲羽绒服581615 58161514新婚粉 L商品编号：58845917170店铺： 名鞋库运动旗舰店商品毛重：500.00g商品产地：中国大陆货号：58161514材质：锦纶适用人群：女士类型：翻领适用季节：春秋填充物：白鸭绒款式：中长款上市时间：2019年冬季', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/f9b44c03842157b2.jpg', '7');
INSERT INTO `product` VALUES ('d130f60a914311eab7d4acde48001122', 'Dickies邮差包男女休闲斜挎包运动单肩包173U90LBB16BK02/黑色', 189, 119, 'http://qiniuyun.donghao.club/c9172264914311eab7d4acde48001122.jpg@http://qiniuyun.donghao.club/c98d16e0914311eab7d4acde48001122.jpg@', 0, 1, '2020-05-08 23:57:27', 3, 3, '4ebfe6b8554311ea8306acde48001122', '外观颜值：非常可以非常A，风格不会太过分夸张。\n材质手感：牛仔布非常手软非常舒服。\n容量空间：可以装\'\'a4纸大小，13寸电脑装不进去，打开翻折部分非常能装。\n做工细节：走线完全OK做工整体比较精致经得起考验。\n适用场合：日常简便通勤，装点书装点小东西完全能够应付。', '191806a4d29811e89e82b808cfd4f089_4ebfe6b8554311ea8306acde48001122_', 2, 'http://qiniuyun.donghao.club/c9172264914311eab7d4acde48001122.jpg', '13');
INSERT INTO `product` VALUES ('f08252166c4411ea9a1cacde48001122', 'Apple iPad Pro 11英寸平板电脑 2020', 7299, 7099, 'http://qiniuyun.donghao.club/efcc24646c4411ea9a1cacde48001122.jpg@http://qiniuyun.donghao.club/f05b745c6c4411ea9a1cacde48001122.jpg@http://qiniuyun.donghao.club/f065c5926c4411ea9a1cacde48001122.jpg@http://qiniuyun.donghao.club/f07000c06c4411ea9a1cacde48001122.jpg@', 0, 1, '2020-05-08 23:13:20', 43, 1, '191806a4d29811e89e82b808cfd4f089', 'Apple iPad Pro 11英寸平板电脑 2020年新款(256G WLAN版/全面屏/A12Z/Face ID/MXDC2CH/A) 深空灰色', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/efcc24646c4411ea9a1cacde48001122.jpg', '25');
INSERT INTO `product` VALUES ('fa659a2cd29d11e890a5b808cfd4f089', 'AJ AIR JORDAN MARS 270 男子运动鞋 CD7070 CD7070-135 43', 2800, 2000, 'http://qiniuyun.donghao.club/b139e4c53a97441d.png@http://qiniuyun.donghao.club/8bf1ca80689d819f.jpg@http://qiniuyun.donghao.club/b02321b5cc7beb47.jpg@http://qiniuyun.donghao.club/d76c243ab5dbc2a4.jpg@http://qiniuyun.donghao.club/94bc38968607806c.jpg', 0, 1, '2020-05-05 15:07:31', 40, 0, '191806a4d29811e89e82b808cfd4f089', '商品名称：AJ AIR JORDAN MARS 270 男子运动鞋 CD7070 CD7070-135 43商品编号：61407045252店铺： TOPSPORTS官方旗舰店商品毛重：1.0kg货号：CD7070功能科技：其它款式：高帮适用场地：通用功能：减震适用人群：男士上市时间：2019年秋季', '191806a4d29811e89e82b808cfd4f089_', 2, 'http://qiniuyun.donghao.club/b139e4c53a97441d.png', '11');
INSERT INTO `product` VALUES ('fbe6d908d29e11e88b6fb808cfd4f089', 'Apple Watch Series 5 GPS款 44毫米金色铝金属表壳 粉砂色运动型表带）', 3499, 2899, 'http://qiniuyun.donghao.club/7f84707ddd77d6ce.jpg@http://qiniuyun.donghao.club/b07322b0daeb0348.jpg@http://qiniuyun.donghao.club/ea3fe55c794cebb7.jpg@http://qiniuyun.donghao.club/2a42a7dd7c432a4a.jpg', 0, 1, '2020-05-08 19:44:54', 70, 1, '191806a4d29811e89e82b808cfd4f089', '商品名称：AppleApple Watch商品编号：100008348590商品毛重：0.52kg商品产地：中国大陆机身厚度：10-12mm屏幕大小：40mm以上运动模式识别：10-15种屏幕显示：彩色触屏防水等级：50米防水续航时间：3天以下通话功能：蓝牙通话优选服务：一年质保功能：GPS定位，NFC支付，久坐提醒，气压高度测量，消息提醒，心率监测，自定义表盘，3G通话/4G通话，短信收发，来电提醒，邮件提示，音乐播放适用人群：男士，女士，老人，儿童，通用腕带材质：硅胶', '4ebfe6b8554311ea8306acde48001122_53d6fd8c81e211ea844facde48001122_', 2, 'http://qiniuyun.donghao.club/b07322b0daeb0348.jpg', '22');
COMMIT;

-- ----------------------------
-- Table structure for shop_cart
-- ----------------------------
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

-- ----------------------------
-- Table structure for user
-- ----------------------------
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

-- ----------------------------
-- Records of user
-- ----------------------------
BEGIN;
INSERT INTO `user` VALUES ('191806a4d29811e89e82b808cfd4f089', '超级管理员', 'pbkdf2:sha256:50000$GWCU17XC$b4d726ed90e4b787040610cafdb893e6fc0ceb7766f941364e51d007eba9331d', '李先生', '1247721306@qq.com', '13193801071', '南工16号宿舍楼', 1, 'http://qiniuyun.donghao.club/0c945380556311ea8addacde48001122.jpg', '2018-10-18 13:38:53', 1, 0, NULL);
INSERT INTO `user` VALUES ('4ebfe6b8554311ea8306acde48001122', 'lmx', 'pbkdf2:sha256:50000$OCzaOj8L$22174e8cac8a2f4ad265f9cbb6c4f2aa7ae15165c5a8d3fc8cf1a3c7bee041b1', 'lmx', '1569660468@qq.com', '13193801071', '南工16号宿舍楼', 1, 'http://qiniuyun.donghao.club/ada7ec2e900e11eaba30acde48001122.jpg', '2020-02-22 15:16:56', 0, 0, NULL);
INSERT INTO `user` VALUES ('53d6fd8c81e211ea844facde48001122', '小可爱', 'pbkdf2:sha256:50000$aXwG8d7t$fdf2a21c27747553ccb5d538e043b27c540b1b8dcda62c6ac02b31b5bfc25a2a', '小可爱', '2020897405@qq.com', '13193801071', '南阳', 1, 'http://qiniuyun.donghao.club/89e77c6281e211ea844facde48001122.jpg', '2020-04-19 10:06:06', 0, 0, NULL);
INSERT INTO `user` VALUES ('85d8a4f6d4dd11e8a23ab808cfd4f089', '李先生', 'pbkdf2:sha256:50000$PE2XpR69$abf7798119bcc9bb9210ffe896efd60871168ebe0113510f5b2c3d339ba92733', '李先生', '3531039691@qq.com', '13193801071', '南阳理工汇森5楼', 1, 'http://qiniuyun.donghao.club/b391927c555611ea86a8acde48001122.jpg', '2018-10-21 11:00:53', 0, 0, NULL);
INSERT INTO `user` VALUES ('9c96169c8ee511ea8e36acde48001122', 'qinYuGang', 'pbkdf2:sha256:50000$Gm8wwrVn$a202f5c0404b19c87bc8b6a728e2d465f2537ed7c9a21bfe52bb5b066197841f', '秦宇罡', '3227648426@qq.com', '13193801071', '南工16号宿舍楼', 1, 'http://qiniuyun.donghao.club/ea1056628ee511ea8e36acde48001122.jpg', '2020-05-05 23:32:21', 0, 0, NULL);
COMMIT;

SET FOREIGN_KEY_CHECKS = 1;
