-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: mcdonalds_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `all_combinations`
--

DROP TABLE IF EXISTS `all_combinations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `all_combinations` (
  `combination_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `combination_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`combination_id`),
  KEY `fk_combination_option` (`option_id`),
  CONSTRAINT `fk_combination_option` FOREIGN KEY (`option_id`) REFERENCES `menu_options` (`option_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `all_combinations`
--

LOCK TABLES `all_combinations` WRITE;
/*!40000 ALTER TABLE `all_combinations` DISABLE KEYS */;
INSERT INTO `all_combinations` VALUES ('C001001','熱紅茶 x1','O001',38),('C001002','熱奶茶 x1','O001',50),('C001003','冰奶茶 x1','O001',50),('C001004','台灣鮮榨柳丁汁 x1','O001',68),('C001005','鮮乳 x1','O001',33),('C001006','可口可樂（小） x1','O001',33),('C001007','可口可樂（中） x1','O001',38),('C001008','零卡可樂（小） x1','O001',33),('C001009','零卡可樂（中） x1','O001',38),('C001010','雪碧（小） x1','O001',33),('C001011','雪碧（中） x1','O001',38),('C001012','冰檸檬風味紅茶（小） x1','O001',33),('C001013','冰檸檬風味紅茶（中） x1','O001',38),('C001014','冰無糖紅茶（小） x1','O001',35),('C001015','冰無糖紅茶（中） x1','O001',43),('C001016','冰無糖綠茶（小） x1','O001',35),('C001017','冰無糖綠茶（中） x1','O001',43),('C001018','麥克雙牛堡 x1','O001',60),('C001019','漢堡 x1','O001',36),('C001020','吉事漢堡 x1','O001',48),('C001021','薯條（小） x1','O001',40),('C001022','薯條（中） x1','O001',50),('C001023','薯條（大） x1','O001',66),('C001024','麥脆鷄腿（1塊） x1','O001',68),('C001025','麥脆鷄腿（2塊） x1','O001',126),('C001026','勁辣香鷄翅（2塊） x1','O001',49),('C001027','勁辣香雞翅（6塊） x1','O001',130),('C001028','蘋果派 x1','O001',40),('C001029','四季沙拉 x1','O001',55),('C001030','水果袋 x1','O001',42),('C001031','玉米湯（小） x1','O001',45),('C001032','玉米湯（大） x1','O001',55),('C001033','蛋捲冰淇淋 x1','O001',18),('C001034','大蛋捲冰淇淋 x1','O001',32),('C001035','OREO冰炫風 x1','O001',59),('C001036','OREO冰炫風2入組 x1','O001',120),('C001037','雙倍OREO冰炫風 x1','O001',65),('C001038','麥克鷄塊（4塊） x1','O001',48),('C001039','麥克鷄塊（6塊） x1','O001',68),('C001040','麥克鷄塊（10塊） x1','O001',109),('C001041','大麥克 x1','O001',78),('C001042','雙層牛肉吉事堡 x1','O001',72),('C001043','四盎司牛肉堡 x1','O001',92),('C001044','雙層四盎司牛肉堡 x1','O001',132),('C001045','麥香鷄 x1','O001',48),('C001046','雙層麥香鷄 x1','O001',78),('C001047','嫩煎鷄腿堡 x1','O001',83),('C001048','勁辣鷄腿堡 x1','O001',78),('C001049','麥香魚 x1','O001',52),('C002001','1+1星級點紅區(50元) x1 + 1+1星級點白區 x1','O002',50),('C003001','1+1星級點紅區(69元) x1 + 1+1星級點白區 x1','O003',69),('C004001','麥脆鷄腿（2塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',191),('C004002','麥克鷄塊（6塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',133),('C004003','麥克鷄塊（10塊） x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',174),('C004004','大麥克 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',143),('C004005','雙層牛肉吉事堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',137),('C004006','四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',157),('C004007','雙層四盎司牛肉堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',197),('C004008','麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',113),('C004009','雙層麥香鷄 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',143),('C004010','嫩煎鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',148),('C004011','勁辣鷄腿堡 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',143),('C004012','麥香魚 x1 + 38元飲品 x1 + 超值全餐(A)中薯 x1','O004',117),('C005001','麥脆鷄腿（2塊） x1 + 四季沙拉 x1 + 38元飲品 x1','O005',196),('C005002','大麥克 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',148),('C005003','雙層牛肉吉事堡 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',142),('C005004','四盎司牛肉堡 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',162),('C005005','雙層四盎司牛肉堡 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',202),('C005006','麥香鷄 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',118),('C005007','雙層麥香鷄 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',148),('C005008','嫩煎鷄腿堡 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',153),('C005009','勁辣鷄腿堡 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',148),('C005010','麥香魚 x1 + 四季沙拉 x1 + 38元飲品 x1','O005',122),('C005011','四季沙拉 x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O005',138),('C005012','四季沙拉 x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1','O005',179),('C006001','大麥克 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',162),('C006002','雙層牛肉吉事堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',156),('C006003','四盎司牛肉堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',176),('C006004','雙層四盎司牛肉堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',216),('C006005','麥香鷄 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',132),('C006006','雙層麥香鷄 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',162),('C006007','嫩煎鷄腿堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',167),('C006008','勁辣鷄腿堡 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',162),('C006009','麥香魚 x1 + 麥脆鷄腿（1塊） x1 + 38元飲品 x1','O006',136),('C006010','麥脆鷄腿（1塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O006',152),('C006011','麥脆鷄腿（1塊） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1','O006',193),('C006012','麥脆鷄腿（1塊） x1 + 麥脆鷄腿（2塊） x1 + 38元飲品 x1','O006',210),('C007001','大麥克 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',177),('C007002','雙層牛肉吉事堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',171),('C007003','四盎司牛肉堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',191),('C007004','雙層四盎司牛肉堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',231),('C007005','麥香鷄 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',147),('C007006','雙層麥香鷄 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',177),('C007007','嫩煎鷄腿堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',182),('C007008','勁辣鷄腿堡 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',177),('C007009','麥香魚 x1 + 薯條（小） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',151),('C007010','薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',167),('C007011','薯條（小） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',208),('C007012','薯條（小） x1 + 麥脆鷄腿（2塊） x1 + 38元飲品 x1 + 超值全餐(D)冰炫風 x1','O007',225),('C008001','大麥克 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',177),('C008002','雙層牛肉吉事堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',171),('C008003','四盎司牛肉堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',191),('C008004','雙層四盎司牛肉堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',231),('C008005','麥香鷄 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',147),('C008006','雙層麥香鷄 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',177),('C008007','嫩煎鷄腿堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',182),('C008008','勁辣鷄腿堡 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',177),('C008009','麥香魚 x1 + 薯條（小） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',151),('C008010','薯條（小） x1 + 麥克鷄塊（6塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',167),('C008011','薯條（小） x1 + 麥克鷄塊（6塊） x1 + 麥克鷄塊（10塊） x1 + 38元飲品 x1','O008',208),('C008012','薯條（小） x1 + 麥脆鷄腿（2塊） x1 + 麥克鷄塊（6塊） x1 + 38元飲品 x1','O008',225),('C009001','甜心卡A區 x1 + 甜心卡B區 x1','O009',38),('C009002','甜心卡A區 x1 + 甜心卡B區 x1','O009',38);
/*!40000 ALTER TABLE `all_combinations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `combinations_detail`
--

DROP TABLE IF EXISTS `combinations_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `combinations_detail`
--

LOCK TABLES `combinations_detail` WRITE;
/*!40000 ALTER TABLE `combinations_detail` DISABLE KEYS */;
INSERT INTO `combinations_detail` VALUES ('DT00001','C001001','B00001',1),('DT00002','C001002','B00002',1),('DT00003','C001003','B00003',1),('DT00004','C001004','B00004',1),('DT00005','C001005','B00005',1),('DT00006','C001006','B00006',1),('DT00007','C001008','B00008',1),('DT00008','C001010','B00010',1),('DT00009','C001012','B00012',1),('DT00010','C001007','B00007',1),('DT00011','C001009','B00009',1),('DT00012','C001011','B00011',1),('DT00013','C001013','B00013',1),('DT00014','C001014','B00014',1),('DT00015','C001016','B00016',1),('DT00016','C001015','B00015',1),('DT00017','C001017','B00017',1),('DT00018','C001018','D00001',1),('DT00019','C001019','D00002',1),('DT00020','C001020','D00003',1),('DT00021','C001021','D00004',1),('DT00022','C001022','D00005',1),('DT00023','C001023','D00006',1),('DT00024','C001024','D00007',1),('DT00026','C001026','D00009',1),('DT00027','C001027','D00010',1),('DT00028','C001025','D00008',1),('DT00029','C001028','D00011',1),('DT00030','C001029','D00012',1),('DT00031','C001030','D00013',1),('DT00032','C001031','D00014',1),('DT00033','C001032','D00015',1),('DT00034','C001033','D00016',1),('DT00035','C001034','D00017',1),('DT00036','C001035','D00018',1),('DT00037','C001036','D00019',1),('DT00038','C001037','D00020',1),('DT00039','C001038','D00021',1),('DT00040','C001039','D00022',1),('DT00041','C001040','D00023',1),('DT00042','C001041','F00001',1),('DT00043','C001042','F00002',1),('DT00044','C001043','F00003',1),('DT00045','C001044','F00004',1),('DT00046','C001045','F00005',1),('DT00047','C001046','F00006',1),('DT00048','C001047','F00007',1),('DT00049','C001049','F00009',1),('DT00050','C001048','F00008',1),('DT00051','C002001','G00002',1),('DT00052','C002001','G00004',1),('DT00053','C003001','G00003',1),('DT00054','C003001','G00004',1),('DT00055','C004004','F00001',1),('DT00056','C004004','G00005',1),('DT00057','C004004','G00001',1),('DT00058','C004005','G00005',1),('DT00059','C004005','G00001',1),('DT00060','C004005','F00002',1),('DT00061','C004006','G00005',1),('DT00062','C004006','G00001',1),('DT00063','C004006','F00003',1),('DT00064','C004007','G00005',1),('DT00065','C004007','G00001',1),('DT00066','C004007','F00004',1),('DT00067','C004008','G00005',1),('DT00068','C004008','G00001',1),('DT00069','C004008','F00005',1),('DT00070','C004009','G00005',1),('DT00071','C004009','G00001',1),('DT00072','C004009','F00006',1),('DT00073','C004010','G00005',1),('DT00074','C004010','G00001',1),('DT00075','C004010','F00007',1),('DT00076','C004011','G00005',1),('DT00077','C004011','G00001',1),('DT00078','C004011','F00008',1),('DT00079','C004012','G00005',1),('DT00080','C004012','G00001',1),('DT00081','C004012','F00009',1),('DT00082','C004002','G00005',1),('DT00083','C004002','G00001',1),('DT00084','C004002','D00022',1),('DT00085','C004003','G00005',1),('DT00086','C004003','G00001',1),('DT00087','C004003','D00023',1),('DT00088','C005002','G00001',1),('DT00089','C005002','D00012',1),('DT00090','C005002','F00001',1),('DT00091','C005003','G00001',1),('DT00092','C005003','D00012',1),('DT00093','C005003','F00002',1),('DT00094','C005004','G00001',1),('DT00095','C005004','D00012',1),('DT00096','C005004','F00003',1),('DT00097','C005005','G00001',1),('DT00098','C005005','D00012',1),('DT00099','C005005','F00004',1),('DT00100','C005006','G00001',1),('DT00101','C005006','D00012',1),('DT00102','C005006','F00005',1),('DT00103','C005007','G00001',1),('DT00104','C005007','D00012',1),('DT00105','C005007','F00006',1),('DT00106','C005008','G00001',1),('DT00107','C005008','D00012',1),('DT00108','C005008','F00007',1),('DT00109','C005009','G00001',1),('DT00110','C005009','D00012',1),('DT00111','C005009','F00008',1),('DT00112','C005010','G00001',1),('DT00113','C005010','D00012',1),('DT00114','C005010','F00009',1),('DT00115','C005011','G00001',1),('DT00116','C005011','D00012',1),('DT00117','C005011','D00022',1),('DT00118','C005012','G00001',1),('DT00119','C005012','D00012',1),('DT00120','C005012','D00023',1),('DT00121','C006001','G00001',1),('DT00122','C006001','D00007',1),('DT00123','C006001','F00001',1),('DT00124','C006002','G00001',1),('DT00125','C006002','D00007',1),('DT00126','C006002','F00002',1),('DT00127','C006003','G00001',1),('DT00128','C006003','D00007',1),('DT00129','C006003','F00003',1),('DT00130','C006004','G00001',1),('DT00131','C006004','D00007',1),('DT00132','C006004','F00004',1),('DT00133','C006005','G00001',1),('DT00134','C006005','D00007',1),('DT00135','C006005','F00005',1),('DT00136','C006006','G00001',1),('DT00137','C006006','D00007',1),('DT00138','C006006','F00006',1),('DT00139','C006007','G00001',1),('DT00140','C006007','D00007',1),('DT00141','C006007','F00007',1),('DT00142','C006008','G00001',1),('DT00143','C006008','D00007',1),('DT00144','C006008','F00008',1),('DT00145','C006009','G00001',1),('DT00146','C006009','D00007',1),('DT00147','C006009','F00009',1),('DT00148','C006010','G00001',1),('DT00149','C006010','D00007',1),('DT00150','C006010','D00022',1),('DT00151','C006011','G00001',1),('DT00152','C006011','D00007',1),('DT00153','C006011','D00023',1),('DT00154','C006012','G00001',1),('DT00155','C006012','D00007',1),('DT00156','C006012','D00008',1),('DT00157','C005001','D00008',1),('DT00158','C005001','G00001',1),('DT00159','C005001','D00012',1),('DT00229','C004001','G00001',1),('DT00230','C004001','G00005',1),('DT00231','C004001','D00008',1),('DT00232','C008001','G00001',1),('DT00233','C008001','D00022',1),('DT00234','C008001','D00004',1),('DT00235','C008001','F00001',1),('DT00236','C008002','G00001',1),('DT00237','C008002','D00022',1),('DT00238','C008002','D00004',1),('DT00239','C008002','F00002',1),('DT00240','C008003','G00001',1),('DT00241','C008003','D00022',1),('DT00242','C008003','D00004',1),('DT00243','C008003','F00003',1),('DT00244','C008004','G00001',1),('DT00245','C008004','D00022',1),('DT00246','C008004','D00004',1),('DT00247','C008004','F00004',1),('DT00248','C008005','G00001',1),('DT00249','C008005','D00022',1),('DT00250','C008005','D00004',1),('DT00251','C008005','F00005',1),('DT00252','C008006','G00001',1),('DT00253','C008006','D00022',1),('DT00254','C008006','D00004',1),('DT00255','C008006','F00006',1),('DT00256','C008007','G00001',1),('DT00257','C008007','D00022',1),('DT00258','C008007','D00004',1),('DT00259','C008007','F00007',1),('DT00260','C008008','G00001',1),('DT00261','C008008','D00022',1),('DT00262','C008008','D00004',1),('DT00263','C008008','F00008',1),('DT00264','C008009','G00001',1),('DT00265','C008009','D00022',1),('DT00266','C008009','D00004',1),('DT00267','C008009','F00009',1),('DT00268','C008010','G00001',1),('DT00269','C008010','D00022',1),('DT00270','C008010','D00022',1),('DT00271','C008010','D00004',1),('DT00272','C008011','G00001',1),('DT00273','C008011','D00022',1),('DT00274','C008011','D00004',1),('DT00275','C008011','D00023',1),('DT00276','C007001','G00001',1),('DT00277','C007001','G00006',1),('DT00278','C007001','D00004',1),('DT00279','C007001','F00001',1),('DT00280','C007002','G00001',1),('DT00281','C007002','G00006',1),('DT00282','C007002','D00004',1),('DT00283','C007002','F00002',1),('DT00284','C007003','G00001',1),('DT00285','C007003','G00006',1),('DT00286','C007003','D00004',1),('DT00287','C007003','F00003',1),('DT00288','C007004','G00001',1),('DT00289','C007004','G00006',1),('DT00290','C007004','D00004',1),('DT00291','C007004','F00004',1),('DT00292','C007005','G00001',1),('DT00293','C007005','G00006',1),('DT00294','C007005','D00004',1),('DT00295','C007005','F00005',1),('DT00296','C007006','G00001',1),('DT00297','C007006','G00006',1),('DT00298','C007006','D00004',1),('DT00299','C007006','F00006',1),('DT00300','C007007','G00001',1),('DT00301','C007007','G00006',1),('DT00302','C007007','D00004',1),('DT00303','C007007','F00007',1),('DT00304','C007008','G00001',1),('DT00305','C007008','G00006',1),('DT00306','C007008','D00004',1),('DT00307','C007008','F00008',1),('DT00308','C007009','G00001',1),('DT00309','C007009','G00006',1),('DT00310','C007009','D00004',1),('DT00311','C007009','F00009',1),('DT00312','C007010','G00001',1),('DT00313','C007010','G00006',1),('DT00314','C007010','D00004',1),('DT00315','C007010','D00022',1),('DT00316','C007011','G00001',1),('DT00317','C007011','G00006',1),('DT00318','C007011','D00004',1),('DT00319','C007011','D00023',1),('DT00320','C007012','G00001',1),('DT00321','C007012','G00006',1),('DT00322','C007012','D00004',1),('DT00323','C007012','D00008',1),('DT00324','C008012','G00001',1),('DT00325','C008012','D00004',1),('DT00326','C008012','D00022',1),('DT00327','C008012','D00008',1),('DT00328','C009001','G00007',1),('DT00329','C009001','G00008',1),('DT00330','C009002','G00007',1),('DT00331','C009002','G00008',1);
/*!40000 ALTER TABLE `combinations_detail` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `item_group_links`
--

DROP TABLE IF EXISTS `item_group_links`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `item_group_links` (
  `parent_item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `child_item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `extra_cost` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`parent_item_id`,`child_item_id`),
  KEY `fk_link_child` (`child_item_id`),
  CONSTRAINT `fk_link_child` FOREIGN KEY (`child_item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE,
  CONSTRAINT `fk_link_parent` FOREIGN KEY (`parent_item_id`) REFERENCES `items` (`item_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `item_group_links`
--

LOCK TABLES `item_group_links` WRITE;
/*!40000 ALTER TABLE `item_group_links` DISABLE KEYS */;
INSERT INTO `item_group_links` VALUES ('G00001','B00001',0),('G00001','B00002',12),('G00001','B00003',12),('G00001','B00004',30),('G00001','B00005',0),('G00001','B00006',0),('G00001','B00007',0),('G00001','B00008',0),('G00001','B00009',0),('G00001','B00010',0),('G00001','B00011',0),('G00001','B00012',0),('G00001','B00013',0),('G00001','B00014',0),('G00001','B00015',5),('G00001','B00016',0),('G00001','B00017',5),('G00001','D00014',7),('G00001','D00015',17),('G00002','D00003',0),('G00002','D00004',0),('G00002','D00009',0),('G00002','D00011',0),('G00002','D00017',0),('G00002','D00021',0),('G00002','F00005',0),('G00003','D00001',0),('G00003','D00018',0),('G00003','D00022',0),('G00003','F00009',0),('G00004','B00001',0),('G00004','B00006',0),('G00004','B00008',0),('G00004','B00010',0),('G00004','B00012',0),('G00004','B00014',0),('G00004','B00016',0),('G00005','D00005',0),('G00005','D00006',16),('G00006','D00018',0),('G00006','D00020',6),('G00007','B00003',12),('G00007','B00007',0),('G00007','B00009',0),('G00007','B00011',0),('G00007','B00013',0),('G00007','B00015',5),('G00007','B00017',5),('G00007','D00006',28),('G00007','D00015',17),('G00007','D00018',21),('G00007','D00020',27),('G00007','D00021',10),('G00007','D00022',30),('G00007','D00023',71),('G00008','B00001',0),('G00008','B00002',0),('G00008','B00007',0),('G00008','B00009',0),('G00008','B00011',0),('G00008','B00013',0),('G00008','B00015',0),('G00008','B00017',0),('G00008','D00004',0),('G00008','D00016',0);
/*!40000 ALTER TABLE `item_group_links` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `items`
--

DROP TABLE IF EXISTS `items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `items` (
  `item_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `item_type` enum('FOOD','BEVERAGE','DESSERT','GROUP') COLLATE utf8mb4_unicode_ci NOT NULL,
  `price` int NOT NULL DEFAULT '0',
  PRIMARY KEY (`item_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `items`
--

LOCK TABLES `items` WRITE;
/*!40000 ALTER TABLE `items` DISABLE KEYS */;
INSERT INTO `items` VALUES ('B00001','熱紅茶','BEVERAGE',38),('B00002','熱奶茶','BEVERAGE',50),('B00003','冰奶茶','BEVERAGE',50),('B00004','台灣鮮榨柳丁汁','BEVERAGE',68),('B00005','鮮乳','BEVERAGE',33),('B00006','可口可樂（小）','BEVERAGE',33),('B00007','可口可樂（中）','BEVERAGE',38),('B00008','零卡可樂（小）','BEVERAGE',33),('B00009','零卡可樂（中）','BEVERAGE',38),('B00010','雪碧（小）','BEVERAGE',33),('B00011','雪碧（中）','BEVERAGE',38),('B00012','冰檸檬風味紅茶（小）','BEVERAGE',33),('B00013','冰檸檬風味紅茶（中）','BEVERAGE',38),('B00014','冰無糖紅茶（小）','BEVERAGE',35),('B00015','冰無糖紅茶（中）','BEVERAGE',43),('B00016','冰無糖綠茶（小）','BEVERAGE',35),('B00017','冰無糖綠茶（中）','BEVERAGE',43),('D00001','麥克雙牛堡','DESSERT',60),('D00002','漢堡','DESSERT',36),('D00003','吉事漢堡','DESSERT',48),('D00004','薯條（小）','DESSERT',40),('D00005','薯條（中）','DESSERT',50),('D00006','薯條（大）','DESSERT',66),('D00007','麥脆鷄腿（1塊）','DESSERT',68),('D00008','麥脆鷄腿（2塊）','DESSERT',126),('D00009','勁辣香鷄翅（2塊）','DESSERT',49),('D00010','勁辣香雞翅（6塊）','DESSERT',130),('D00011','蘋果派','DESSERT',40),('D00012','四季沙拉','DESSERT',55),('D00013','水果袋','DESSERT',42),('D00014','玉米湯（小）','DESSERT',45),('D00015','玉米湯（大）','DESSERT',55),('D00016','蛋捲冰淇淋','DESSERT',18),('D00017','大蛋捲冰淇淋','DESSERT',32),('D00018','OREO冰炫風','DESSERT',59),('D00019','OREO冰炫風2入組','DESSERT',120),('D00020','雙倍OREO冰炫風','DESSERT',65),('D00021','麥克鷄塊（4塊）','DESSERT',48),('D00022','麥克鷄塊（6塊）','DESSERT',68),('D00023','麥克鷄塊（10塊）','DESSERT',109),('F00001','大麥克','FOOD',78),('F00002','雙層牛肉吉事堡','FOOD',72),('F00003','四盎司牛肉堡','FOOD',92),('F00004','雙層四盎司牛肉堡','FOOD',132),('F00005','麥香鷄','FOOD',48),('F00006','雙層麥香鷄','FOOD',78),('F00007','嫩煎鷄腿堡','FOOD',83),('F00008','勁辣鷄腿堡','FOOD',78),('F00009','麥香魚','FOOD',52),('F00010','測試','FOOD',10),('G00001','38元飲品','GROUP',0),('G00002','1+1星級點紅區(50元)','GROUP',0),('G00003','1+1星級點紅區(69元)','GROUP',0),('G00004','1+1星級點白區','GROUP',0),('G00005','超值全餐(A)中薯','GROUP',0),('G00006','超值全餐(D)冰炫風','GROUP',0),('G00007','甜心卡A區','GROUP',0),('G00008','甜心卡B區','GROUP',0);
/*!40000 ALTER TABLE `items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `menu_options`
--

DROP TABLE IF EXISTS `menu_options`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `menu_options` (
  `option_id` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `option_name` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`option_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `menu_options`
--

LOCK TABLES `menu_options` WRITE;
/*!40000 ALTER TABLE `menu_options` DISABLE KEYS */;
INSERT INTO `menu_options` VALUES ('O001','單點'),('O002','1+1星級點（50元）'),('O003','1+1星級點（69元）'),('O004','A經典配餐'),('O005','B清爽配餐'),('O006','C勁脆配餐'),('O007','D炫冰配餐'),('O008','E豪吃配餐'),('O009','甜心卡');
/*!40000 ALTER TABLE `menu_options` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-16  1:43:11

-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: mcdonalds_db
-- ------------------------------------------------------
-- Server version	8.0.43

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `edit_logs`
--

DROP TABLE IF EXISTS `edit_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=253 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2026-05-16  1:43:13
