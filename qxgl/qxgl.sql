-- MySQL dump 10.13  Distrib 8.0.18, for Win64 (x86_64)
--
-- Host: localhost    Database: qxgl
-- ------------------------------------------------------
-- Server version	8.0.18

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `t_menu`
--

DROP TABLE IF EXISTS `t_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_menu` (
  `mno` int(11) NOT NULL AUTO_INCREMENT,
  `mname` varchar(32) DEFAULT NULL,
  `mhref` varchar(32) DEFAULT NULL,
  `mtarget` varchar(32) DEFAULT NULL,
  `pno` int(11) DEFAULT NULL,
  `yl1` varchar(32) DEFAULT NULL,
  `yl2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`mno`)
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_menu`
--

LOCK TABLES `t_menu` WRITE;
/*!40000 ALTER TABLE `t_menu` DISABLE KEYS */;
INSERT INTO `t_menu` VALUES (1,'权限管理',NULL,NULL,-1,NULL,NULL),(2,'用户管理','userList.do','right',1,NULL,NULL),(3,'角色管理','roleList.do','right',1,NULL,NULL),(4,'菜单管理','menuList.jsp','right',1,NULL,NULL),(9,'系统管理',NULL,NULL,-1,NULL,NULL),(12,'学生管理',NULL,NULL,-1,NULL,NULL),(14,'教师管理',NULL,NULL,-1,NULL,NULL),(22,'基本信息管理',NULL,NULL,-1,NULL,NULL),(23,'商品管理',NULL,NULL,22,NULL,NULL),(24,'库房管理',NULL,NULL,22,NULL,NULL),(25,'供应商管理',NULL,NULL,22,NULL,NULL),(26,'修改密码',NULL,NULL,9,NULL,NULL),(27,'普通用户',NULL,NULL,2,NULL,NULL),(28,'vip用户',NULL,NULL,2,NULL,NULL);
/*!40000 ALTER TABLE `t_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role`
--

DROP TABLE IF EXISTS `t_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_role` (
  `rno` int(11) NOT NULL AUTO_INCREMENT,
  `rname` varchar(32) DEFAULT NULL,
  `description` varchar(32) DEFAULT NULL,
  `yl1` varchar(32) DEFAULT NULL,
  `yl2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`rno`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role`
--

LOCK TABLES `t_role` WRITE;
/*!40000 ALTER TABLE `t_role` DISABLE KEYS */;
INSERT INTO `t_role` VALUES (1,'系统管理员','非常牛',NULL,NULL),(2,'管理员','很牛',NULL,NULL),(3,'库管员','一般',NULL,NULL),(4,'销售员','一般',NULL,NULL),(5,'采购员','一般',NULL,NULL),(6,'财务员','一般',NULL,NULL),(7,'部门经理','牛',NULL,NULL);
/*!40000 ALTER TABLE `t_role` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_role_menu`
--

DROP TABLE IF EXISTS `t_role_menu`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_role_menu` (
  `rno` int(11) NOT NULL,
  `mno` int(11) NOT NULL,
  PRIMARY KEY (`rno`,`mno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_role_menu`
--

LOCK TABLES `t_role_menu` WRITE;
/*!40000 ALTER TABLE `t_role_menu` DISABLE KEYS */;
INSERT INTO `t_role_menu` VALUES (1,1),(1,2),(1,3),(1,4),(1,9),(1,12),(1,14),(1,22),(1,23),(1,24),(1,25),(1,26),(1,27),(1,28),(2,1),(2,2),(2,3),(2,4),(2,27),(2,28),(7,1),(7,2),(7,27),(7,28);
/*!40000 ALTER TABLE `t_role_menu` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user`
--

DROP TABLE IF EXISTS `t_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user` (
  `uno` int(11) NOT NULL AUTO_INCREMENT,
  `uname` varchar(16) DEFAULT NULL,
  `upass` varchar(16) DEFAULT NULL,
  `truename` varchar(8) DEFAULT NULL,
  `age` int(11) DEFAULT NULL,
  `sex` char(2) DEFAULT NULL,
  `phone` varchar(16) DEFAULT NULL,
  `yl1` varchar(32) DEFAULT NULL,
  `yl2` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`uno`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user`
--

LOCK TABLES `t_user` WRITE;
/*!40000 ALTER TABLE `t_user` DISABLE KEYS */;
INSERT INTO `t_user` VALUES (1,'zs','123','张三',20,'女','1234567',NULL,NULL),(2,'zs2','123','张三2',19,'女','1234568',NULL,NULL),(3,'zs3','123','张三3',20,'女','1234568',NULL,NULL),(5,'zs5','123','张三5',22,'男','1234570',NULL,NULL),(13,'lisi1','123','李四1',18,'男','123456',NULL,NULL),(14,'lisi2','123','李四2',19,'女','123456',NULL,NULL),(15,'lisi3','123','李四3',20,'男','123456',NULL,NULL),(16,'lisi4','123','李四4',21,'女','123456',NULL,NULL),(17,'lisi5','123','李四5',22,'男','123456',NULL,NULL),(18,'lisi6','123','李四6',23,'女','123456',NULL,NULL),(19,'lisi7','123','李四7',24,'男','123456',NULL,NULL),(20,'lisi8','123','李四8',25,'女','123456',NULL,NULL),(21,'lisi9','123','李四9',26,'男','123456',NULL,NULL),(22,'lisi10','123','李四10',27,'女','123456',NULL,NULL),(23,'lisi11','123','李四11',28,'男','123456',NULL,NULL),(24,'lisi12','123','李四12',29,'女','123456',NULL,NULL),(25,'lisi13','123','李四13',30,'男','123456',NULL,NULL),(26,'lisi14','123','李四14',31,'女','123456',NULL,NULL),(27,'lisi15','123','李四15',32,'男','123456',NULL,NULL),(28,'lisi16','123','李四16',33,'女','123456',NULL,NULL),(29,'lisi17','123','李四17',34,'男','123456',NULL,NULL),(30,'lisi18','123','李四18',35,'女','123456',NULL,NULL),(31,'lisi19','123','李四19',36,'男','123456',NULL,NULL),(32,'lisi20','123','李四20',37,'女','123456',NULL,NULL),(33,'lisi21','123','李四21',38,'男','123456',NULL,NULL),(34,'lisi22','123','李四22',39,'女','123456',NULL,NULL),(35,'lisi23','123','李四23',40,'男','123456',NULL,NULL),(36,'lisi24','123','李四24',41,'女','123456',NULL,NULL),(37,'lisi25','123','李四25',42,'男','123456',NULL,NULL),(38,'lisi26','123','李四26',43,'女','123456',NULL,NULL),(39,'lisi27','123','李四27',44,'男','123456',NULL,NULL),(40,'lisi28','123','李四28',45,'女','123456',NULL,NULL),(41,'lisi29','123','李四29',46,'男','123456',NULL,NULL),(42,'lisi30','123','李四30',47,'女','123456',NULL,NULL),(43,'lisi31','123','李四31',48,'男','123456',NULL,NULL),(44,'lisi32','123','李四32',49,'女','123456',NULL,NULL),(45,'lisi33','123','李四33',50,'男','123456',NULL,NULL),(46,'lisi34','123','李四34',51,'女','123456',NULL,NULL),(47,'lisi35','123','李四35',52,'男','123456',NULL,NULL),(48,'lisi36','123','李四36',53,'女','123456',NULL,NULL),(49,'lisi37','123','李四37',54,'男','123456',NULL,NULL),(50,'lisi38','123','李四38',55,'女','123456',NULL,NULL),(51,'lisi39','123','李四39',56,'男','123456',NULL,NULL),(52,'lisi40','123','李四40',57,'女','123456',NULL,NULL),(53,'lisi41','123','李四41',58,'男','123456',NULL,NULL),(54,'lisi42','123','李四42',59,'女','123456',NULL,NULL),(55,'lisi43','123','李四43',60,'男','123456',NULL,NULL),(56,'lisi44','123','李四44',61,'女','123456',NULL,NULL),(57,'lisi45','123','李四45',62,'男','123456',NULL,NULL),(58,'lisi46','123','李四46',63,'女','123456',NULL,NULL),(59,'lisi47','123','李四47',64,'男','123456',NULL,NULL),(60,'lisi48','123','李四48',65,'女','123456',NULL,NULL);
/*!40000 ALTER TABLE `t_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `t_user_role`
--

DROP TABLE IF EXISTS `t_user_role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `t_user_role` (
  `uno` int(11) NOT NULL,
  `rno` int(11) NOT NULL,
  PRIMARY KEY (`uno`,`rno`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `t_user_role`
--

LOCK TABLES `t_user_role` WRITE;
/*!40000 ALTER TABLE `t_user_role` DISABLE KEYS */;
INSERT INTO `t_user_role` VALUES (1,1),(2,2),(13,7);
/*!40000 ALTER TABLE `t_user_role` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-12 22:02:44
