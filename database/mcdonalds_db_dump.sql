/* McDonald's Database Dump */
SET FOREIGN_KEY_CHECKS=0;

DROP TABLE IF EXISTS `all_combinations`;
CREATE TABLE `all_combinations` (
  `combination_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `combination_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`combination_id`),
  KEY `fk_combination_option` (`option_id`),
  CONSTRAINT `fk_combination_option` FOREIGN KEY (`option_id`) REFERENCES `menu_options` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `all_combinations` */
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001001', '熱紅茶 x1', 'O001', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001002', '熱奶茶 x1', 'O001', 50);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001003', '冰奶茶 x1', 'O001', 50);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001004', '台灣鮮榨柳丁汁 x1', 'O001', 68);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001005', '鮮乳 x1', 'O001', 33);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001006', '可口可樂（小） x1', 'O001', 33);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001007', '可口可樂（中） x1', 'O001', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001008', '零卡可樂（小） x1', 'O001', 33);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001009', '零卡可樂（中） x1', 'O001', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001010', '雪碧（小） x1', 'O001', 33);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001011', '雪碧（中） x1', 'O001', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001012', '冰檸檬風味紅茶（小） x1', 'O001', 33);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001013', '冰檸檬風味紅茶（中） x1', 'O001', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001014', '冰無糖紅茶（小） x1', 'O001', 35);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001015', '冰無糖紅茶（中） x1', 'O001', 43);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001016', '冰無糖綠茶（小） x1', 'O001', 35);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001017', '冰無糖綠茶（中） x1', 'O001', 43);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001018', '麥克雙牛堡 x1', 'O001', 60);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001019', '漢堡 x1', 'O001', 36);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001020', '吉事漢堡 x1', 'O001', 48);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001021', '薯條（小） x1', 'O001', 40);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001022', '薯條（中） x1', 'O001', 50);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001023', '薯條（大） x1', 'O001', 66);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001024', '麥脆鷄腿（1塊） x1', 'O001', 68);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001025', '麥脆鷄腿（2塊） x1', 'O001', 126);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001026', '勁辣香鷄翅（2塊） x1', 'O001', 49);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001027', '勁辣香雞翅（6塊） x1', 'O001', 130);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001028', '蘋果派 x1', 'O001', 40);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001029', '四季沙拉 x1', 'O001', 55);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001030', '水果袋 x1', 'O001', 42);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001031', '玉米湯（小） x1', 'O001', 45);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001032', '玉米湯（大） x1', 'O001', 55);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001033', '蛋捲冰淇淋 x1', 'O001', 18);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001034', '大蛋捲冰淇淋 x1', 'O001', 32);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001035', 'OREO冰炫風 x1', 'O001', 59);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001036', 'OREO冰炫風2入組 x1', 'O001', 120);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001037', '雙倍OREO冰炫風 x1', 'O001', 65);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001038', '麥克鷄塊（4塊） x1', 'O001', 48);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001039', '麥克鷄塊（6塊） x1', 'O001', 68);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001040', '麥克鷄塊（10塊） x1', 'O001', 109);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001041', '大麥克 x1', 'O001', 78);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001042', '雙層牛肉吉事堡 x1', 'O001', 72);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001043', '四盎司牛肉堡 x1', 'O001', 92);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001044', '雙層四盎司牛肉堡 x1', 'O001', 132);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001045', '麥香鷄 x1', 'O001', 48);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001046', '雙層麥香鷄 x1', 'O001', 78);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001047', '嫩煎鷄腿堡 x1', 'O001', 83);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001048', '勁辣鷄腿堡 x1', 'O001', 78);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001049', '麥香魚 x1', 'O001', 52);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001053', 'BLT安格斯牛肉堡 x1', 'O001', 122);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001054', '蕈菇安格斯牛肉堡 x1', 'O001', 132);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001055', '帕瑪森安格斯牛肉堡 x1', 'O001', 127);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001056', '帕瑪森主廚雞腿堡 x1', 'O001', 127);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001057', '蕈菇主廚雞腿堡 x1', 'O001', 132);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C001058', 'BLT嫩煎雞腿堡 x1', 'O001', 122);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C002001', '1+1星級點紅區(50元) x1 + 1+1星級點白區 x1', 'O002', 50);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C003001', '1+1星級點紅區(69元) x1 + 1+1星級點白區 x1', 'O003', 69);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004001', '麥脆鷄腿（2塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 191);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004002', '麥克鷄塊（6塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 133);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004003', '麥克鷄塊（10塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 174);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004004', '大麥克 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 143);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004005', '雙層牛肉吉事堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 137);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004006', '四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 157);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004007', '雙層四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 197);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004008', '麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 113);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004009', '雙層麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 143);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004010', '嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 148);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004011', '勁辣鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 143);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004012', '麥香魚 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1', 'O004', 117);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004016', '超值全餐(A)中薯 x1 + 38元飲品 x1 + BLT安格斯牛肉堡 x1', 'O004', 192);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004017', '超值全餐(A)中薯 x1 + 38元飲品 x1 + 蕈菇安格斯牛肉堡 x1', 'O004', 202);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004018', '超值全餐(A)中薯 x1 + 38元飲品 x1 + 帕瑪森安格斯牛肉堡 x1', 'O004', 197);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004019', '超值全餐(A)中薯 x1 + 38元飲品 x1 + 帕瑪森主廚雞腿堡 x1', 'O004', 197);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004020', '超值全餐(A)中薯 x1 + 38元飲品 x1 + 蕈菇主廚雞腿堡 x1', 'O004', 202);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C004021', '超值全餐(A)中薯 x1 + 38元飲品 x1 + BLT嫩煎雞腿堡 x1', 'O004', 192);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005001', '麥脆鷄腿（2塊） x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 196);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005002', '大麥克 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 148);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005003', '雙層牛肉吉事堡 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 142);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005004', '四盎司牛肉堡 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 162);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005005', '雙層四盎司牛肉堡 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 202);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005006', '麥香鷄 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 118);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005007', '雙層麥香鷄 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 148);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005008', '嫩煎鷄腿堡 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 153);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005009', '勁辣鷄腿堡 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 148);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005010', '麥香魚 x1 + 四季沙拉 x1 + 38元飲品 x1', 'O005', 122);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005011', '四季沙拉 x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O005', 138);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C005012', '四季沙拉 x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1', 'O005', 179);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006001', '大麥克 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 162);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006002', '雙層牛肉吉事堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 156);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006003', '四盎司牛肉堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 176);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006004', '雙層四盎司牛肉堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 216);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006005', '麥香鷄 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 132);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006006', '雙層麥香鷄 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 162);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006007', '嫩煎鷄腿堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 167);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006008', '勁辣鷄腿堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 162);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006009', '麥香魚 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1', 'O006', 136);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006010', '麥脆鷄腿（1塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O006', 152);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006011', '麥脆鷄腿（1塊） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1', 'O006', 193);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C006012', '麥脆鷄腿（1塊） x1 + 麥脆鷄腿（2塊） x1 + 38元飲品 x1', 'O006', 210);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007001', '大麥克 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007002', '雙層牛肉吉事堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 171);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007003', '四盎司牛肉堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 191);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007004', '雙層四盎司牛肉堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 231);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007005', '麥香鷄 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 147);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007006', '雙層麥香鷄 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007007', '嫩煎鷄腿堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 182);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007008', '勁辣鷄腿堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007009', '麥香魚 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 151);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007010', '薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 167);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007011', '薯條（小） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 208);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C007012', '薯條（小） x1 + 麥脆鷄腿（2塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1', 'O007', 225);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008001', '大麥克 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008002', '雙層牛肉吉事堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 171);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008003', '四盎司牛肉堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 191);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008004', '雙層四盎司牛肉堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 231);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008005', '麥香鷄 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 147);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008006', '雙層麥香鷄 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008007', '嫩煎鷄腿堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 182);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008008', '勁辣鷄腿堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 177);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008009', '麥香魚 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 151);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008010', '薯條（小） x1 + 麥克鷄塊（6塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 167);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008011', '薯條（小） x1 + 麥克鷄塊（6塊） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1', 'O008', 208);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C008012', '薯條（小） x1 + 麥脆鷄腿（2塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1', 'O008', 225);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C009001', '甜心卡A區 x1 + 甜心卡B區 x1', 'O009', 38);
INSERT INTO `all_combinations` (`combination_id`, `combination_name`, `option_id`, `price`) VALUES ('C009002', '甜心卡A區 x1 + 甜心卡B區 x1', 'O009', 38);

DROP TABLE IF EXISTS `combinations_detail`;
CREATE TABLE `combinations_detail` (
  `detail_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `combination_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `quantity` int NOT NULL DEFAULT '1',
  PRIMARY KEY (`detail_id`),
  KEY `fk_detail_combination` (`combination_id`),
  KEY `fk_detail_item` (`item_id`),
  CONSTRAINT `fk_detail_combination` FOREIGN KEY (`combination_id`) REFERENCES `all_combinations` (`combination_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_detail_item` FOREIGN KEY (`item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `combinations_detail` */
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00001', 'C001001', 'B00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00002', 'C001002', 'B00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00003', 'C001003', 'B00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00004', 'C001004', 'B00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00005', 'C001005', 'B00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00006', 'C001006', 'B00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00007', 'C001008', 'B00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00008', 'C001010', 'B00010', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00009', 'C001012', 'B00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00010', 'C001007', 'B00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00011', 'C001009', 'B00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00012', 'C001011', 'B00011', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00013', 'C001013', 'B00013', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00014', 'C001014', 'B00014', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00015', 'C001016', 'B00016', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00016', 'C001015', 'B00015', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00017', 'C001017', 'B00017', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00018', 'C001018', 'D00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00019', 'C001019', 'D00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00020', 'C001020', 'D00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00021', 'C001021', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00022', 'C001022', 'D00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00023', 'C001023', 'D00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00024', 'C001024', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00026', 'C001026', 'D00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00027', 'C001027', 'D00010', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00028', 'C001025', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00029', 'C001028', 'D00011', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00030', 'C001029', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00031', 'C001030', 'D00013', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00032', 'C001031', 'D00014', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00033', 'C001032', 'D00015', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00034', 'C001033', 'D00016', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00035', 'C001034', 'D00017', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00036', 'C001035', 'D00018', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00037', 'C001036', 'D00019', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00038', 'C001037', 'D00020', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00039', 'C001038', 'D00021', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00040', 'C001039', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00041', 'C001040', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00042', 'C001041', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00043', 'C001042', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00044', 'C001043', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00045', 'C001044', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00046', 'C001045', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00047', 'C001046', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00048', 'C001047', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00049', 'C001049', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00050', 'C001048', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00051', 'C002001', 'G00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00052', 'C002001', 'G00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00053', 'C003001', 'G00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00054', 'C003001', 'G00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00055', 'C004004', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00056', 'C004004', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00057', 'C004004', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00058', 'C004005', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00059', 'C004005', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00060', 'C004005', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00061', 'C004006', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00062', 'C004006', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00063', 'C004006', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00064', 'C004007', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00065', 'C004007', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00066', 'C004007', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00067', 'C004008', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00068', 'C004008', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00069', 'C004008', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00070', 'C004009', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00071', 'C004009', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00072', 'C004009', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00073', 'C004010', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00074', 'C004010', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00075', 'C004010', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00076', 'C004011', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00077', 'C004011', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00078', 'C004011', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00079', 'C004012', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00080', 'C004012', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00081', 'C004012', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00082', 'C004002', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00083', 'C004002', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00084', 'C004002', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00085', 'C004003', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00086', 'C004003', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00087', 'C004003', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00088', 'C005002', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00089', 'C005002', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00090', 'C005002', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00091', 'C005003', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00092', 'C005003', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00093', 'C005003', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00094', 'C005004', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00095', 'C005004', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00096', 'C005004', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00097', 'C005005', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00098', 'C005005', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00099', 'C005005', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00100', 'C005006', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00101', 'C005006', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00102', 'C005006', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00103', 'C005007', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00104', 'C005007', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00105', 'C005007', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00106', 'C005008', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00107', 'C005008', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00108', 'C005008', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00109', 'C005009', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00110', 'C005009', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00111', 'C005009', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00112', 'C005010', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00113', 'C005010', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00114', 'C005010', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00115', 'C005011', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00116', 'C005011', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00117', 'C005011', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00118', 'C005012', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00119', 'C005012', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00120', 'C005012', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00121', 'C006001', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00122', 'C006001', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00123', 'C006001', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00124', 'C006002', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00125', 'C006002', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00126', 'C006002', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00127', 'C006003', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00128', 'C006003', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00129', 'C006003', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00130', 'C006004', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00131', 'C006004', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00132', 'C006004', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00133', 'C006005', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00134', 'C006005', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00135', 'C006005', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00136', 'C006006', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00137', 'C006006', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00138', 'C006006', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00139', 'C006007', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00140', 'C006007', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00141', 'C006007', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00142', 'C006008', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00143', 'C006008', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00144', 'C006008', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00145', 'C006009', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00146', 'C006009', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00147', 'C006009', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00148', 'C006010', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00149', 'C006010', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00150', 'C006010', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00151', 'C006011', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00152', 'C006011', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00153', 'C006011', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00154', 'C006012', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00155', 'C006012', 'D00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00156', 'C006012', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00157', 'C005001', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00158', 'C005001', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00159', 'C005001', 'D00012', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00229', 'C004001', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00230', 'C004001', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00231', 'C004001', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00232', 'C008001', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00233', 'C008001', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00234', 'C008001', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00235', 'C008001', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00236', 'C008002', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00237', 'C008002', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00238', 'C008002', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00239', 'C008002', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00240', 'C008003', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00241', 'C008003', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00242', 'C008003', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00243', 'C008003', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00244', 'C008004', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00245', 'C008004', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00246', 'C008004', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00247', 'C008004', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00248', 'C008005', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00249', 'C008005', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00250', 'C008005', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00251', 'C008005', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00252', 'C008006', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00253', 'C008006', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00254', 'C008006', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00255', 'C008006', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00256', 'C008007', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00257', 'C008007', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00258', 'C008007', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00259', 'C008007', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00260', 'C008008', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00261', 'C008008', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00262', 'C008008', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00263', 'C008008', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00264', 'C008009', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00265', 'C008009', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00266', 'C008009', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00267', 'C008009', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00268', 'C008010', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00269', 'C008010', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00270', 'C008010', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00271', 'C008010', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00272', 'C008011', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00273', 'C008011', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00274', 'C008011', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00275', 'C008011', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00276', 'C007001', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00277', 'C007001', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00278', 'C007001', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00279', 'C007001', 'F00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00280', 'C007002', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00281', 'C007002', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00282', 'C007002', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00283', 'C007002', 'F00002', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00284', 'C007003', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00285', 'C007003', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00286', 'C007003', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00287', 'C007003', 'F00003', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00288', 'C007004', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00289', 'C007004', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00290', 'C007004', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00291', 'C007004', 'F00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00292', 'C007005', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00293', 'C007005', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00294', 'C007005', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00295', 'C007005', 'F00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00296', 'C007006', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00297', 'C007006', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00298', 'C007006', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00299', 'C007006', 'F00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00300', 'C007007', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00301', 'C007007', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00302', 'C007007', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00303', 'C007007', 'F00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00304', 'C007008', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00305', 'C007008', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00306', 'C007008', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00307', 'C007008', 'F00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00308', 'C007009', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00309', 'C007009', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00310', 'C007009', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00311', 'C007009', 'F00009', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00312', 'C007010', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00313', 'C007010', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00314', 'C007010', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00315', 'C007010', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00316', 'C007011', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00317', 'C007011', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00318', 'C007011', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00319', 'C007011', 'D00023', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00320', 'C007012', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00321', 'C007012', 'G00006', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00322', 'C007012', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00323', 'C007012', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00324', 'C008012', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00325', 'C008012', 'D00004', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00326', 'C008012', 'D00022', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00327', 'C008012', 'D00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00328', 'C009001', 'G00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00329', 'C009001', 'G00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00330', 'C009002', 'G00007', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00331', 'C009002', 'G00008', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00341', 'C004016', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00342', 'C004016', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00343', 'C004016', 'F00013', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00344', 'C004017', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00345', 'C004017', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00346', 'C004017', 'F00014', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00347', 'C004018', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00348', 'C004018', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00349', 'C004018', 'F00015', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00350', 'C004019', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00351', 'C004019', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00352', 'C004019', 'F00016', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00353', 'C004020', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00354', 'C004020', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00355', 'C004020', 'F00017', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00356', 'C004021', 'G00005', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00357', 'C004021', 'G00001', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00358', 'C004021', 'F00018', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00368', 'C001053', 'F00013', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00369', 'C001054', 'F00014', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00370', 'C001055', 'F00015', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00371', 'C001056', 'F00016', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00372', 'C001057', 'F00017', 1);
INSERT INTO `combinations_detail` (`detail_id`, `combination_id`, `item_id`, `quantity`) VALUES ('DT00373', 'C001058', 'F00018', 1);

DROP TABLE IF EXISTS `edit_logs`;
CREATE TABLE `edit_logs` (
  `log_id` int NOT NULL AUTO_INCREMENT,
  `table_name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `record_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `action_type` enum('INSERT','UPDATE','DELETE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `old_data` json DEFAULT NULL,
  `new_data` json DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `user_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT 'system',
  `batch_id` varchar(50) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`log_id`)
) ENGINE=InnoDB AUTO_INCREMENT=289 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `edit_logs` is skipped */

DROP TABLE IF EXISTS `favorites`;
CREATE TABLE `favorites` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plan_data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `fk_favorites_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `favorites` */
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (1, 1, '{"title": "升級推薦", "total": 337, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡"], "price": 92, "combo_name": "四盎司牛肉堡 x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "可口可樂（中）"], "price": 157, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+可口可樂（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["可口可樂（中）", "薯條（小）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (可口可樂（中）+薯條（小）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 63, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 400}', '2026-05-26 22:36:00');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (3, 1, '{"title": "升級推薦", "total": 371, "combos": [{"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["嫩煎鷄腿堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 148, "combo_name": "嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "冰無糖紅茶（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 89, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 460}', '2026-05-28 11:18:19');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (4, 2, '{"title": "升級推薦", "total": 371, "combos": [{"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["嫩煎鷄腿堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 148, "combo_name": "嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "冰無糖紅茶（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 89, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 460}', '2026-05-28 11:22:15');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (5, 2, '{"title": "升級推薦", "total": 371, "combos": [{"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["嫩煎鷄腿堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 148, "combo_name": "嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "冰無糖紅茶（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 89, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 460}', '2026-05-28 11:24:50');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (6, 1, '{"title": "最佳推薦", "total": 92, "combos": [{"qty": 1, "items": ["四盎司牛肉堡"], "price": 92, "combo_name": "四盎司牛肉堡 x1", "option_name": "單點"}], "isSweet": false, "savings": 0, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 92}', '2026-05-31 01:27:05');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (7, 1, '{"title": "升級推薦", "total": 290, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "薯條（小）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+薯條（小）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 68, "replaced": [], "extra_items": [{"qty": 1, "name": "冰檸檬風味紅茶（中）"}], "single_items": [], "originalTotal": 358}', '2026-05-31 01:45:27');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (8, 1, '{"title": "升級推薦", "total": 270, "combos": [{"qty": 1, "items": ["BLT嫩煎鷄腿堡", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 222, "combo_name": "超值全餐(A)中薯 x1 + 38元飲品 x1 + BLT嫩煎雞腿堡 x1 (薯條（中）+台灣鮮榨柳丁汁)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["麥克鷄塊（4塊）", "薯條（小）"], "price": 48, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (麥克鷄塊（4塊）+薯條（小）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 58, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 328}', '2026-06-18 01:27:59');
INSERT INTO `favorites` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (9, 1, '{"title": "升級推薦", "total": 343, "combos": [{"qty": 1, "items": ["麥克鷄塊（4塊）"], "price": 48, "combo_name": "麥克鷄塊（4塊） x1", "option_name": "單點"}, {"qty": 1, "items": ["BLT嫩煎鷄腿堡"], "price": 122, "combo_name": "BLT嫩煎雞腿堡 x1", "option_name": "單點"}, {"qty": 1, "items": ["雙層麥香鷄", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 173, "combo_name": "雙層麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+台灣鮮榨柳丁汁)", "option_name": "A經典配餐"}], "isSweet": false, "savings": 23, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 366}', '2026-06-18 01:29:16');

DROP TABLE IF EXISTS `item_group_links`;
CREATE TABLE `item_group_links` (
  `parent_item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `child_item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_cost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`parent_item_id`,`child_item_id`),
  KEY `fk_link_child` (`child_item_id`),
  CONSTRAINT `fk_link_child` FOREIGN KEY (`child_item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_link_parent` FOREIGN KEY (`parent_item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `item_group_links` */
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00001', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00002', 12);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00003', 12);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00004', 30);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00005', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00006', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00007', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00008', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00009', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00010', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00011', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00012', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00013', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00014', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00015', 5);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00016', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'B00017', 5);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'D00014', 7);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00001', 'D00015', 17);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00003', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00004', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00009', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00011', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00017', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'D00021', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00002', 'F00005', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00003', 'D00001', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00003', 'D00018', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00003', 'D00022', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00003', 'F00009', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00001', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00006', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00008', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00010', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00012', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00014', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00004', 'B00016', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00005', 'D00005', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00005', 'D00006', 16);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00006', 'D00018', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00006', 'D00020', 6);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00003', 12);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00007', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00009', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00011', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00013', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00015', 5);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'B00017', 5);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00006', 28);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00015', 17);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00018', 21);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00020', 27);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00021', 10);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00022', 30);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00007', 'D00023', 71);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00001', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00002', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00007', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00009', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00011', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00013', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00015', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'B00017', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'D00004', 0);
INSERT INTO `item_group_links` (`parent_item_id`, `child_item_id`, `extra_cost`) VALUES ('G00008', 'D00016', 0);

DROP TABLE IF EXISTS `items`;
CREATE TABLE `items` (
  `item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_type` enum('FOOD','BEVERAGE','DESSERT','GROUP') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `items` */
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00001', '熱紅茶', 'BEVERAGE', 38);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00002', '熱奶茶', 'BEVERAGE', 50);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00003', '冰奶茶', 'BEVERAGE', 50);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00004', '台灣鮮榨柳丁汁', 'BEVERAGE', 68);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00005', '鮮乳', 'BEVERAGE', 33);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00006', '可口可樂（小）', 'BEVERAGE', 33);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00007', '可口可樂（中）', 'BEVERAGE', 38);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00008', '零卡可樂（小）', 'BEVERAGE', 33);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00009', '零卡可樂（中）', 'BEVERAGE', 38);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00010', '雪碧（小）', 'BEVERAGE', 33);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00011', '雪碧（中）', 'BEVERAGE', 38);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00012', '冰檸檬風味紅茶（小）', 'BEVERAGE', 33);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00013', '冰檸檬風味紅茶（中）', 'BEVERAGE', 38);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00014', '冰無糖紅茶（小）', 'BEVERAGE', 35);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00015', '冰無糖紅茶（中）', 'BEVERAGE', 43);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00016', '冰無糖綠茶（小）', 'BEVERAGE', 35);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('B00017', '冰無糖綠茶（中）', 'BEVERAGE', 43);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00001', '麥克雙牛堡', 'DESSERT', 60);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00002', '漢堡', 'DESSERT', 36);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00003', '吉事漢堡', 'DESSERT', 48);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00004', '薯條（小）', 'DESSERT', 40);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00005', '薯條（中）', 'DESSERT', 50);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00006', '薯條（大）', 'DESSERT', 66);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00007', '麥脆鷄腿（1塊）', 'DESSERT', 68);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00008', '麥脆鷄腿（2塊）', 'DESSERT', 126);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00009', '勁辣香鷄翅（2塊）', 'DESSERT', 49);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00010', '勁辣香雞翅（6塊）', 'DESSERT', 130);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00011', '蘋果派', 'DESSERT', 40);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00012', '四季沙拉', 'DESSERT', 55);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00013', '水果袋', 'DESSERT', 42);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00014', '玉米湯（小）', 'DESSERT', 45);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00015', '玉米湯（大）', 'DESSERT', 55);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00016', '蛋捲冰淇淋', 'DESSERT', 18);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00017', '大蛋捲冰淇淋', 'DESSERT', 32);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00018', 'OREO冰炫風', 'DESSERT', 59);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00019', 'OREO冰炫風2入組', 'DESSERT', 120);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00020', '雙倍OREO冰炫風', 'DESSERT', 65);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00021', '麥克鷄塊（4塊）', 'DESSERT', 48);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00022', '麥克鷄塊（6塊）', 'DESSERT', 68);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('D00023', '麥克鷄塊（10塊）', 'DESSERT', 109);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00001', '大麥克', 'FOOD', 78);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00002', '雙層牛肉吉事堡', 'FOOD', 72);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00003', '四盎司牛肉堡', 'FOOD', 92);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00004', '雙層四盎司牛肉堡', 'FOOD', 132);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00005', '麥香鷄', 'FOOD', 48);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00006', '雙層麥香鷄', 'FOOD', 78);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00007', '嫩煎鷄腿堡', 'FOOD', 83);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00008', '勁辣鷄腿堡', 'FOOD', 78);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00009', '麥香魚', 'FOOD', 52);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00013', 'BLT安格斯牛肉堡', 'FOOD', 122);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00014', '蕈菇安格斯牛肉堡', 'FOOD', 132);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00015', '帕瑪森安格斯牛肉堡', 'FOOD', 127);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00016', '帕瑪森主廚鷄腿堡', 'FOOD', 127);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00017', '蕈菇主廚鷄腿堡', 'FOOD', 132);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('F00018', 'BLT嫩煎鷄腿堡', 'FOOD', 122);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00001', '38元飲品', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00002', '1+1星級點紅區(50元)', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00003', '1+1星級點紅區(69元)', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00004', '1+1星級點白區', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00005', '超值全餐(A)中薯', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00006', '超值全餐(D)冰炫風', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00007', '甜心卡A區', 'GROUP', 0);
INSERT INTO `items` (`item_id`, `item_name`, `item_type`, `price`) VALUES ('G00008', '甜心卡B區', 'GROUP', 0);

DROP TABLE IF EXISTS `menu_options`;
CREATE TABLE `menu_options` (
  `option_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `menu_options` */
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O001', '單點');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O002', '1+1星級點（50元）');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O003', '1+1星級點（69元）');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O004', 'A經典配餐');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O005', 'B清爽配餐');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O006', 'C勁脆配餐');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O007', 'D炫冰配餐');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O008', 'E豪吃配餐');
INSERT INTO `menu_options` (`option_id`, `option_name`) VALUES ('O009', '甜心卡');

DROP TABLE IF EXISTS `order_history`;
CREATE TABLE `order_history` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `plan_data` json NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  KEY `user_id_idx` (`user_id`),
  CONSTRAINT `fk_history_user` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `order_history` */
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (1, 1, '{"title": "升級推薦", "total": 337, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡"], "price": 92, "combo_name": "四盎司牛肉堡 x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "可口可樂（中）"], "price": 157, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+可口可樂（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["可口可樂（中）", "薯條（小）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (可口可樂（中）+薯條（小）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 63, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 400}', '2026-05-27 17:57:50');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (2, 1, '{"title": "升級推薦", "total": 358, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡"], "price": 92, "combo_name": "四盎司牛肉堡 x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "可口可樂（中）"], "price": 157, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+可口可樂（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "可口可樂（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+可口可樂（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 61, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 419}', '2026-05-27 17:57:54');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (3, 2, '{"title": "最佳推薦", "total": 92, "combos": [{"qty": 1, "items": ["四盎司牛肉堡"], "price": 92, "combo_name": "四盎司牛肉堡 x1", "option_name": "單點"}], "isSweet": false, "savings": 0, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 92}', '2026-05-27 23:18:39');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (5, 1, '{"title": "升級推薦", "total": 371, "combos": [{"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["嫩煎鷄腿堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 148, "combo_name": "嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "冰無糖紅茶（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 89, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 460}', '2026-05-28 11:18:46');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (6, 2, '{"title": "升級推薦", "total": 371, "combos": [{"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["嫩煎鷄腿堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 148, "combo_name": "嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["OREO冰炫風", "冰無糖紅茶（中）"], "price": 59, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (OREO冰炫風+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 89, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 460}', '2026-05-28 11:22:59');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (7, 1, '{"title": "升級推薦", "total": 350, "combos": [{"qty": 1, "items": ["冰檸檬風味紅茶（中）"], "price": 38, "combo_name": "冰檸檬風味紅茶（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["雙層麥香鷄", "薯條（中）", "冰無糖紅茶（中）"], "price": 148, "combo_name": "雙層麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰無糖紅茶（中）)", "option_name": "A經典配餐"}], "isSweet": false, "savings": 46, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 396}', '2026-05-31 01:41:39');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (8, 1, '{"title": "最佳推薦", "total": 252, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 66, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 318}', '2026-05-31 01:54:49');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (9, 1, '{"title": "最佳推薦", "total": 252, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 66, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 318}', '2026-05-31 01:55:43');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (10, 1, '{"title": "最佳推薦", "total": 252, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 66, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 318}', '2026-05-31 01:56:37');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (11, 1, '{"title": "最佳推薦", "total": 252, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 66, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 318}', '2026-05-31 01:57:36');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (12, 1, '{"title": "最佳推薦", "total": 252, "combos": [{"qty": 1, "items": ["薯條（中）"], "price": 50, "combo_name": "薯條（中） x1", "option_name": "單點"}, {"qty": 1, "items": ["四盎司牛肉堡", "薯條（中）", "玉米湯（小）"], "price": 164, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+玉米湯（小）)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["冰檸檬風味紅茶（中）", "冰無糖紅茶（中）"], "price": 38, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (冰檸檬風味紅茶（中）+冰無糖紅茶（中）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 66, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 318}', '2026-05-31 01:58:16');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (13, 1, '{"title": "精簡方案", "total": 392, "combos": [{"qty": 1, "items": ["大麥克"], "price": 78, "is_promo": false, "combo_name": "大麥克 x1", "extra_cost": 0, "promo_name": "", "reward_qty": 0, "option_name": "單點", "base_combo_price": 78, "reward_item_name": ""}, {"qty": 2, "items": ["四盎司牛肉堡", "薯條（中）", "冰檸檬風味紅茶（中）"], "price": 157, "is_promo": false, "combo_name": "四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+冰檸檬風味紅茶（中）)", "extra_cost": 0, "promo_name": "", "reward_qty": 0, "option_name": "A經典配餐", "base_combo_price": 157, "reward_item_name": ""}], "isSweet": false, "savings": 46, "replaced": [], "extra_items": [{"qty": 1, "name": "【滿額贈】麥克鷄塊（4塊）"}], "single_items": [], "originalTotal": 438}', '2026-06-17 23:04:08');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (14, 1, '{"title": "精簡方案", "total": 227, "combos": [{"qty": 1, "items": ["雙層四盎司牛肉堡", "薯條（中）", "台灣鮮榨柳丁汁", "麥克鷄塊（4塊）"], "price": 227, "is_promo": true, "combo_name": "雙層四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+台灣鮮榨柳丁汁)", "extra_cost": 0, "promo_name": "買超值全餐送4塊鷄塊", "reward_qty": 1, "option_name": "A經典配餐", "base_combo_price": 227, "reward_item_name": "麥克鷄塊（4塊）"}], "isSweet": false, "savings": 71, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 298}', '2026-06-17 23:10:18');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (15, 1, '{"title": "精簡方案", "total": 275, "combos": [{"qty": 1, "items": ["麥克鷄塊（4塊）"], "price": 48, "is_promo": false, "combo_name": "麥克鷄塊（4塊） x1", "extra_cost": 0, "promo_name": "", "reward_qty": 0, "option_name": "單點", "base_combo_price": 48, "reward_item_name": ""}, {"qty": 1, "items": ["雙層四盎司牛肉堡", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 227, "is_promo": false, "combo_name": "雙層四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+台灣鮮榨柳丁汁)", "extra_cost": 0, "promo_name": "", "reward_qty": 0, "option_name": "A經典配餐", "base_combo_price": 227, "reward_item_name": ""}], "isSweet": false, "savings": 23, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 298}', '2026-06-17 23:10:25');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (16, 1, '{"title": "升級推薦", "total": 343, "combos": [{"qty": 1, "items": ["麥克鷄塊（4塊）"], "price": 48, "combo_name": "麥克鷄塊（4塊） x1", "option_name": "單點"}, {"qty": 1, "items": ["BLT嫩煎鷄腿堡"], "price": 122, "combo_name": "BLT嫩煎雞腿堡 x1", "option_name": "單點"}, {"qty": 1, "items": ["雙層麥香鷄", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 173, "combo_name": "雙層麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1 (薯條（中）+台灣鮮榨柳丁汁)", "option_name": "A經典配餐"}], "isSweet": false, "savings": 23, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 366}', '2026-06-18 01:28:31');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (17, 1, '{"title": "升級推薦", "total": 270, "combos": [{"qty": 1, "items": ["BLT嫩煎鷄腿堡", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 222, "combo_name": "超值全餐(A)中薯 x1 + 38元飲品 x1 + BLT嫩煎雞腿堡 x1 (薯條（中）+台灣鮮榨柳丁汁)", "option_name": "A經典配餐"}, {"qty": 1, "items": ["麥克鷄塊（4塊）", "薯條（小）"], "price": 48, "combo_name": "甜心卡A區 x1 + 甜心卡B區 x1 (麥克鷄塊（4塊）+薯條（小）)", "option_name": "甜心卡"}], "isSweet": true, "savings": 58, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 328}', '2026-06-18 01:30:06');
INSERT INTO `order_history` (`id`, `user_id`, `plan_data`, `created_at`) VALUES (18, 1, '{"title": "最佳推薦", "total": 270, "combos": [{"qty": 1, "items": ["麥克鷄塊（4塊）"], "price": 48, "combo_name": "麥克鷄塊（4塊） x1", "option_name": "單點"}, {"qty": 1, "items": ["BLT嫩煎鷄腿堡", "薯條（中）", "台灣鮮榨柳丁汁"], "price": 222, "combo_name": "超值全餐(A)中薯 x1 + 38元飲品 x1 + BLT嫩煎雞腿堡 x1 (薯條（中）+台灣鮮榨柳丁汁)", "option_name": "A經典配餐"}], "isSweet": false, "savings": 18, "replaced": [], "extra_items": [], "single_items": [], "originalTotal": 288}', '2026-06-18 10:48:36');

DROP TABLE IF EXISTS `promotions`;
CREATE TABLE `promotions` (
  `promo_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `promo_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition_type` enum('OPTION','COMBINATION','ITEM','MIN_PRICE') COLLATE utf8mb4_unicode_ci NOT NULL,
  `condition_value` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `reward_item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_cost` int NOT NULL DEFAULT '0',
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `start_time` datetime DEFAULT NULL,
  `end_time` datetime DEFAULT NULL,
  PRIMARY KEY (`promo_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `promotions` */
INSERT INTO `promotions` (`promo_id`, `promo_name`, `condition_type`, `condition_value`, `reward_item_id`, `extra_cost`, `is_active`, `start_time`, `end_time`) VALUES ('P002', '滿350送鷄塊', 'MIN_PRICE', '350', 'D00021', 0, 1, NULL, NULL);

DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `password_hash` varchar(255) CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

/* Data for table `users` */
INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `created_at`) VALUES (1, 'test', NULL, '$2b$10$tE3oQnQSuuF.VgRkcceDo.HuMyBxPjfgrAx1LfBMqUvmYthhXUJFG', '2026-05-26 22:26:39');
INSERT INTO `users` (`id`, `username`, `email`, `password_hash`, `created_at`) VALUES (2, 'test1', NULL, '$2b$10$QK5idogWvU2dZDJMyKuQcuAsw7K/3sQQtnIR1IbP6fGEg9NaEwAXK', '2026-05-27 22:49:50');

SET FOREIGN_KEY_CHECKS=1;
