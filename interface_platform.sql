-- MySQL dump 10.13  Distrib 8.0.25, for Win64 (x86_64)
--
-- Host: localhost    Database: interface_platform
-- ------------------------------------------------------
-- Server version	8.0.25

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
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=61 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add user',4,'add_user'),(14,'Can change user',4,'change_user'),(15,'Can delete user',4,'delete_user'),(16,'Can view user',4,'view_user'),(17,'Can add content type',5,'add_contenttype'),(18,'Can change content type',5,'change_contenttype'),(19,'Can delete content type',5,'delete_contenttype'),(20,'Can view content type',5,'view_contenttype'),(21,'Can add session',6,'add_session'),(22,'Can change session',6,'change_session'),(23,'Can delete session',6,'delete_session'),(24,'Can view session',6,'view_session'),(25,'Can add 项目信息表',7,'add_project'),(26,'Can change 项目信息表',7,'change_project'),(27,'Can delete 项目信息表',7,'delete_project'),(28,'Can view 项目信息表',7,'view_project'),(29,'Can add 模块信息表',8,'add_module'),(30,'Can change 模块信息表',8,'change_module'),(31,'Can delete 模块信息表',8,'delete_module'),(32,'Can view 模块信息表',8,'view_module'),(33,'Can add 测试用例表',9,'add_testcase'),(34,'Can change 测试用例表',9,'change_testcase'),(35,'Can delete 测试用例表',9,'delete_testcase'),(36,'Can view 测试用例表',9,'view_testcase'),(37,'Can add 用例集合表',10,'add_casesuite'),(38,'Can change 用例集合表',10,'change_casesuite'),(39,'Can delete 用例集合表',10,'delete_casesuite'),(40,'Can view 用例集合表',10,'view_casesuite'),(41,'Can add suite case',11,'add_suitecase'),(42,'Can change suite case',11,'change_suitecase'),(43,'Can delete suite case',11,'delete_suitecase'),(44,'Can view suite case',11,'view_suitecase'),(45,'Can add 接口地址配置表',12,'add_interfaceserver'),(46,'Can change 接口地址配置表',12,'change_interfaceserver'),(47,'Can delete 接口地址配置表',12,'delete_interfaceserver'),(48,'Can view 接口地址配置表',12,'view_interfaceserver'),(49,'Can add 用例执行结果记录表',13,'add_testcaseexecuteresult'),(50,'Can change 用例执行结果记录表',13,'change_testcaseexecuteresult'),(51,'Can delete 用例执行结果记录表',13,'delete_testcaseexecuteresult'),(52,'Can view 用例执行结果记录表',13,'view_testcaseexecuteresult'),(53,'Can add case suite execute record',14,'add_casesuiteexecuterecord'),(54,'Can change case suite execute record',14,'change_casesuiteexecuterecord'),(55,'Can delete case suite execute record',14,'delete_casesuiteexecuterecord'),(56,'Can view case suite execute record',14,'view_casesuiteexecuterecord'),(57,'Can add case suite test case execute record',15,'add_casesuitetestcaseexecuterecord'),(58,'Can change case suite test case execute record',15,'change_casesuitetestcaseexecuterecord'),(59,'Can delete case suite test case execute record',15,'delete_casesuitetestcaseexecuterecord'),(60,'Can view case suite test case execute record',15,'view_casesuitetestcaseexecuterecord');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user`
--

DROP TABLE IF EXISTS `auth_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user`
--

LOCK TABLES `auth_user` WRITE;
/*!40000 ALTER TABLE `auth_user` DISABLE KEYS */;
INSERT INTO `auth_user` VALUES (1,'pbkdf2_sha256$150000$vFPlGe1yVgD6$mcRXn0qQUFNrAz0GTI2wVnTEDSDZ0lA2X6PQ1FU/LDs=','2021-07-19 21:24:11.676570',1,'admin','','','admin@123.com',1,1,'2021-07-13 07:26:43.652071');
/*!40000 ALTER TABLE `auth_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_groups`
--

DROP TABLE IF EXISTS `auth_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_groups_user_id_group_id_94350c0c_uniq` (`user_id`,`group_id`),
  KEY `auth_user_groups_group_id_97559544_fk_auth_group_id` (`group_id`),
  CONSTRAINT `auth_user_groups_group_id_97559544_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `auth_user_groups_user_id_6a12ed8b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_groups`
--

LOCK TABLES `auth_user_groups` WRITE;
/*!40000 ALTER TABLE `auth_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_user_user_permissions`
--

DROP TABLE IF EXISTS `auth_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_user_user_permissions_user_id_permission_id_14a6b632_uniq` (`user_id`,`permission_id`),
  KEY `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_user_user_permi_permission_id_1fbb5f2c_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_user_user_permissions_user_id_a95ead1b_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_user_user_permissions`
--

LOCK TABLES `auth_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `auth_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_auth_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
INSERT INTO `django_admin_log` VALUES (1,'2021-07-13 08:52:27.977309','1','项目一',1,'[{\"added\": {}}]',7,1),(2,'2021-07-13 08:52:42.372132','2','项目二',1,'[{\"added\": {}}]',7,1),(3,'2021-07-14 10:18:24.624514','1','模块一',1,'[{\"added\": {}}]',8,1),(4,'2021-07-14 10:18:38.085284','2','模块二',1,'[{\"added\": {}}]',8,1),(5,'2021-07-14 10:18:53.583170','3','模块三',1,'[{\"added\": {}}]',8,1),(6,'2021-07-14 10:19:17.061513','4','模块四',1,'[{\"added\": {}}]',8,1),(7,'2021-07-14 11:40:24.553918','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u63a5\\u53e3\\u5730\\u5740\"]}}]',9,1),(8,'2021-07-14 11:40:34.215470','2','登录',2,'[{\"changed\": {\"fields\": [\"\\u63a5\\u53e3\\u5730\\u5740\"]}}]',9,1),(9,'2021-07-14 16:33:03.912256','1','CaseSuite object (1)',1,'[{\"added\": {}}]',10,1),(10,'2021-07-14 16:33:14.585866','2','CaseSuite object (2)',1,'[{\"added\": {}}]',10,1),(11,'2021-07-15 16:24:00.248779','1','dev',1,'[{\"added\": {}}]',12,1),(12,'2021-07-15 16:24:14.187577','2','prod',1,'[{\"added\": {}}]',12,1),(13,'2021-07-17 16:18:34.608759','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(14,'2021-07-17 16:19:04.757903','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(15,'2021-07-17 16:19:18.403982','2','登录',2,'[{\"changed\": {\"fields\": [\"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(16,'2021-07-17 16:21:17.771763','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(17,'2021-07-17 21:59:37.053955','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(18,'2021-07-17 22:02:10.724190','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u8bf7\\u6c42\\u6570\\u636e\", \"\\u65ad\\u8a00\\u5185\\u5bb9\"]}}]',9,1),(19,'2021-07-17 22:16:23.736824','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u8bf7\\u6c42\\u6570\\u636e\"]}}]',9,1),(20,'2021-07-18 21:15:43.433082','1','注册',2,'[{\"changed\": {\"fields\": [\"\\u8bf7\\u6c42\\u6570\\u636e\"]}}]',9,1),(21,'2021-07-19 21:39:22.086904','1','注册',2,'[{\"changed\": {\"fields\": [\"request_data\"]}}]',9,1);
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'auth','user'),(5,'contenttypes','contenttype'),(10,'interfacetestplatform','casesuite'),(14,'interfacetestplatform','casesuiteexecuterecord'),(15,'interfacetestplatform','casesuitetestcaseexecuterecord'),(12,'interfacetestplatform','interfaceserver'),(8,'interfacetestplatform','module'),(7,'interfacetestplatform','project'),(11,'interfacetestplatform','suitecase'),(9,'interfacetestplatform','testcase'),(13,'interfacetestplatform','testcaseexecuteresult'),(6,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-07-17 15:57:22.277612'),(2,'auth','0001_initial','2021-07-17 15:57:25.496137'),(3,'admin','0001_initial','2021-07-17 15:57:26.949129'),(4,'admin','0002_logentry_remove_auto_add','2021-07-17 15:57:26.995967'),(5,'admin','0003_logentry_add_action_flag_choices','2021-07-17 15:57:27.027251'),(6,'contenttypes','0002_remove_content_type_name','2021-07-17 15:57:27.542804'),(7,'auth','0002_alter_permission_name_max_length','2021-07-17 15:57:27.792821'),(8,'auth','0003_alter_user_email_max_length','2021-07-17 15:57:27.902156'),(9,'auth','0004_alter_user_username_opts','2021-07-17 15:57:27.949059'),(10,'auth','0005_alter_user_last_login_null','2021-07-17 15:57:28.183392'),(11,'auth','0006_require_contenttypes_0002','2021-07-17 15:57:28.214668'),(12,'auth','0007_alter_validators_add_error_messages','2021-07-17 15:57:28.245915'),(13,'auth','0008_alter_user_username_max_length','2021-07-17 15:57:28.683395'),(14,'auth','0009_alter_user_last_name_max_length','2021-07-17 15:57:28.933334'),(15,'auth','0010_alter_group_name_max_length','2021-07-17 15:57:29.027142'),(16,'auth','0011_update_proxy_permissions','2021-07-17 15:57:29.073982'),(17,'auth','0012_alter_user_first_name_max_length','2021-07-17 15:57:29.323931'),(18,'interfacetestplatform','0001_initial','2021-07-17 15:57:29.589569'),(19,'interfacetestplatform','0002_module','2021-07-17 15:57:29.995791'),(20,'interfacetestplatform','0003_testcase','2021-07-17 15:57:32.144133'),(21,'interfacetestplatform','0004_casesuite','2021-07-17 15:57:32.253502'),(22,'interfacetestplatform','0005_auto_20210714_1659','2021-07-17 15:57:32.847176'),(23,'interfacetestplatform','0006_interfaceserver','2021-07-17 15:57:32.956579'),(24,'sessions','0001_initial','2021-07-17 15:57:33.097159'),(25,'interfacetestplatform','0007_testcaseexecuteresult','2021-07-17 16:52:30.257045'),(26,'interfacetestplatform','0008_testcaseexecuteresult_execute_var','2021-07-17 17:48:52.422039'),(27,'interfacetestplatform','0009_rename_execute_var_testcaseexecuteresult_extract_var','2021-07-17 17:56:41.773575'),(28,'interfacetestplatform','0010_alter_testcaseexecuteresult_exception_info','2021-07-17 22:03:22.689253'),(29,'interfacetestplatform','0011_casesuiteexecuterecord_casesuitetestcaseexecuterecord','2021-07-17 22:37:55.126474');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
INSERT INTO `django_session` VALUES ('2a9opqa8811q4fvmqw5qq5d1ekb760d6','NWVhYmQ4YmY5YWQ5ZWQxMWNmMGViZGEyNjc3ODk1NmE3OWIzMGI3Mzp7Il9hdXRoX3VzZXJfaWQiOiIxIiwiX2F1dGhfdXNlcl9iYWNrZW5kIjoiZGphbmdvLmNvbnRyaWIuYXV0aC5iYWNrZW5kcy5Nb2RlbEJhY2tlbmQiLCJfYXV0aF91c2VyX2hhc2giOiJlMTg5YjM0ZTAwNTc1YzIxNTVhZDRhOGE4MDM0MjU2MTE2ODlmMWM0IiwiaXNfbG9naW4iOnRydWV9','2021-08-02 21:24:11.723534'),('nshng03ha0xjdu4bl8d47g38gik13yqd','.eJxVjEEOwiAQRe_C2pBSigxduvcMZAaGFjWQlHZlvLtt0oVu_3v_vYXHbZ391njxOYpRKHH53QjDk8sB4gPLVGWoZV0yyUORJ23yXiO_bqf7F5ixzfsbHDrXWXaQyJLqYKCODDJdEax2SQfWbFwMjNxbBcTAykA_pGS0Uv0ezc2_6pSLGNdl488XnNw92A:1m3YoJ:Kvr_vs7YyswsQAUOU0PUOlzPtSAX7TZ65B6fI2b6llE','2021-07-28 14:55:59.177100'),('sezcei0ivyjhadzwmmel8rclntjshjov','.eJxVjEEOwiAQRe_C2pBSigxduvcMZAaGFjWQlHZlvLtt0oVu_3v_vYXHbZ391njxOYpRKHH53QjDk8sB4gPLVGWoZV0yyUORJ23yXiO_bqf7F5ixzfsbHDrXWXaQyJLqYKCODDJdEax2SQfWbFwMjNxbBcTAykA_pGS0Uv0ezc2_6pSLGNdl488XnNw92A:1m4fLK:CRtQqP2vdhYgsMHUd-v5VQ-OGT7rliopvUQdk04K464','2021-07-31 16:06:38.183985');
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_casesuite`
--

DROP TABLE IF EXISTS `interfacetestplatform_casesuite`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_casesuite` (
  `id` int NOT NULL AUTO_INCREMENT,
  `suite_desc` varchar(100) DEFAULT NULL,
  `if_execute` int NOT NULL,
  `test_case_model` varchar(100) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_casesuite`
--

LOCK TABLES `interfacetestplatform_casesuite` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_casesuite` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_casesuite` VALUES (1,'测试集合一',0,'data','Juno','2021-07-14 16:33:03.888254'),(2,'测试集合二',0,'data','Juno','2021-07-14 16:33:14.562865');
/*!40000 ALTER TABLE `interfacetestplatform_casesuite` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_casesuiteexecuterecord`
--

DROP TABLE IF EXISTS `interfacetestplatform_casesuiteexecuterecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_casesuiteexecuterecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `run_time_interval` int DEFAULT NULL,
  `status` int DEFAULT NULL,
  `test_result` varchar(50) DEFAULT NULL,
  `creator` varchar(50) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `execute_start_time` varchar(300) DEFAULT NULL,
  `case_suite_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatfor_case_suite_id_74271f02_fk_interface` (`case_suite_id`),
  CONSTRAINT `interfacetestplatfor_case_suite_id_74271f02_fk_interface` FOREIGN KEY (`case_suite_id`) REFERENCES `interfacetestplatform_casesuite` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_casesuiteexecuterecord`
--

LOCK TABLES `interfacetestplatform_casesuiteexecuterecord` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_casesuiteexecuterecord` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_casesuiteexecuterecord` VALUES (1,0,0,NULL,'admin','2021-07-18 12:39:58.051580',NULL,1),(2,0,0,NULL,'admin','2021-07-18 12:44:30.864379',NULL,1),(3,0,1,'成功','admin','2021-07-18 12:46:41.076830','2021-07-18 12:46:41',1),(4,0,1,'成功','admin','2021-07-18 12:47:54.291233','2021-07-18 12:47:54',1),(5,0,1,'成功','admin','2021-07-18 12:47:54.332201','2021-07-18 12:47:54',2),(6,0,1,'成功','admin','2021-07-18 12:49:13.417702','2021-07-18 12:49:13',1),(7,0,1,'成功','admin','2021-07-18 12:53:34.620441','2021-07-18 12:53:34',1),(8,0,1,'成功','admin','2021-07-18 12:53:35.298046','2021-07-18 12:53:34',2),(9,0,1,'失败','admin','2021-07-18 21:15:50.083933','2021-07-18 21:15:49',1),(10,0,1,'成功','admin','2021-07-19 21:58:42.931139','2021-07-19 21:58:42',1);
/*!40000 ALTER TABLE `interfacetestplatform_casesuiteexecuterecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_casesuitetestcaseexecuterecord`
--

DROP TABLE IF EXISTS `interfacetestplatform_casesuitetestcaseexecuterecord`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_casesuitetestcaseexecuterecord` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT NULL,
  `exception_info` varchar(2048) DEFAULT NULL,
  `request_data` varchar(1024) DEFAULT NULL,
  `response_data` varchar(1024) DEFAULT NULL,
  `execute_result` varchar(1024) DEFAULT NULL,
  `extract_var` varchar(1024) DEFAULT NULL,
  `last_time_response_data` varchar(1024) DEFAULT NULL,
  `execute_total_time` varchar(1024) DEFAULT NULL,
  `execute_start_time` varchar(300) DEFAULT NULL,
  `execute_end_time` varchar(300) DEFAULT NULL,
  `case_suite_record_id` int NOT NULL,
  `test_case_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatfor_case_suite_record_id_94a0ef97_fk_interface` (`case_suite_record_id`),
  KEY `interfacetestplatfor_test_case_id_00258ba4_fk_interface` (`test_case_id`),
  CONSTRAINT `interfacetestplatfor_case_suite_record_id_94a0ef97_fk_interface` FOREIGN KEY (`case_suite_record_id`) REFERENCES `interfacetestplatform_casesuiteexecuterecord` (`id`),
  CONSTRAINT `interfacetestplatfor_test_case_id_00258ba4_fk_interface` FOREIGN KEY (`test_case_id`) REFERENCES `interfacetestplatform_testcase` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_casesuitetestcaseexecuterecord`
--

LOCK TABLES `interfacetestplatform_casesuitetestcaseexecuterecord` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_casesuitetestcaseexecuterecord` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_casesuitetestcaseexecuterecord` VALUES (1,1,NULL,'{\"username\":\"testman20209\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2749}','成功','userid: 2749','','261','2021-07-18 12:53:34','2021-07-18 12:53:34',7,1),(2,1,NULL,'{\"username\": \"testman20209\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"3d1f9000cd7bf7a7a3a1c32cdaf1e08a\", \"code\": \"00\", \"userid\": 2749, \"login_time\": \"2021-07-18 12:53:34\"}','成功','token: 3d1f9000cd7bf7a7a3a1c32cdaf1e08a','','217','2021-07-18 12:53:34','2021-07-18 12:53:34',7,2),(3,1,NULL,'{\"username\":\"testman20210\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2750}','成功','userid: 2750','{\"code\": \"00\", \"userid\": 2749}','288','2021-07-18 12:53:34','2021-07-18 12:53:34',8,1),(4,1,NULL,'{\"username\": \"testman20210\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"3e611ae6a5b433a07358ad1b1094eda1\", \"code\": \"00\", \"userid\": 2750, \"login_time\": \"2021-07-18 12:53:35\"}','成功','token: 3e611ae6a5b433a07358ad1b1094eda1','{\"token\": \"3d1f9000cd7bf7a7a3a1c32cdaf1e08a\", \"code\": \"00\", \"userid\": 2749, \"login_time\": \"2021-07-18 12:53:34\"}','261','2021-07-18 12:53:35','2021-07-18 12:53:35',8,2),(5,1,'Traceback (most recent call last):\n  File \"E:\\InterfaceAutoTest\\interfacetestplatform\\task.py\", line 175, in suite_task\n    res_data = request_process(url, request_method, json.loads(request_data))\n  File \"C:\\Python36\\lib\\json\\__init__.py\", line 354, in loads\n    return _default_decoder.decode(s)\n  File \"C:\\Python36\\lib\\json\\decoder.py\", line 339, in decode\n    obj, end = self.raw_decode(s, idx=_w(s, 0).end())\n  File \"C:\\Python36\\lib\\json\\decoder.py\", line 355, in raw_decode\n    obj, end = self.scan_once(s, idx)\njson.decoder.JSONDecodeError: Expecting property name enclosed in double quotes: line 1 column 76 (char 75)\n','{\"username\":\"testman20211\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\",,,}',NULL,'失败',NULL,'{\"code\": \"00\", \"userid\": 2750}','0','2021-07-18 21:15:49','2021-07-18 21:15:49',9,1),(6,1,'keyword: userid not matched from response, assert failed','{\"username\": \"testman20211\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"code\": \"03\", \"params\": {\"username\": \"testman20211\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','失败',NULL,'{\"token\": \"3e611ae6a5b433a07358ad1b1094eda1\", \"code\": \"00\", \"userid\": 2750, \"login_time\": \"2021-07-18 12:53:35\"}','211','2021-07-18 21:15:49','2021-07-18 21:15:50',9,2),(7,1,NULL,'{\"username\":\"testman20215\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 6}','成功','userid：6',NULL,'200','2021-07-19 21:58:42','2021-07-19 21:58:42',10,1),(8,1,NULL,'{\"username\": \"testman20215\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"513fe7dea2738132223f12d3031e06a2\", \"code\": \"00\", \"userid\": 6, \"login_time\": \"2021-07-19 21:58:42\"}','成功','token：513fe7dea2738132223f12d3031e06a2','{\"code\": \"03\", \"params\": {\"username\": \"testman20211\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','211','2021-07-19 21:58:42','2021-07-19 21:58:42',10,2);
/*!40000 ALTER TABLE `interfacetestplatform_casesuitetestcaseexecuterecord` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_interfaceserver`
--

DROP TABLE IF EXISTS `interfacetestplatform_interfaceserver`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_interfaceserver` (
  `id` int NOT NULL AUTO_INCREMENT,
  `env` varchar(50) NOT NULL,
  `ip` varchar(50) NOT NULL,
  `port` varchar(100) NOT NULL,
  `remark` varchar(100) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_interfaceserver`
--

LOCK TABLES `interfacetestplatform_interfaceserver` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_interfaceserver` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_interfaceserver` VALUES (1,'dev','39.100.104.214','8080','开发环境','2021-07-15 16:24:00.204777','2021-07-15 16:24:00.204777'),(2,'prod','39.100.104.214','8080','生产环境','2021-07-15 16:24:14.143574','2021-07-15 16:24:14.143574');
/*!40000 ALTER TABLE `interfacetestplatform_interfaceserver` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_module`
--

DROP TABLE IF EXISTS `interfacetestplatform_module`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_module` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `test_owner` varchar(50) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  `belong_project_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatfor_belong_project_id_416881f0_fk_interface` (`belong_project_id`),
  CONSTRAINT `interfacetestplatfor_belong_project_id_416881f0_fk_interface` FOREIGN KEY (`belong_project_id`) REFERENCES `interfacetestplatform_project` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_module`
--

LOCK TABLES `interfacetestplatform_module` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_module` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_module` VALUES (1,'模块一','Juno','测试模块一','2021-07-14 10:18:24.597512','2021-07-14 10:18:24.597512',1),(2,'模块二','Juno','测试模块二','2021-07-14 10:18:38.054282','2021-07-14 10:18:38.055282',1),(3,'模块三','Juno','测试模块三','2021-07-14 10:18:53.553169','2021-07-14 10:18:53.553169',1),(4,'模块四','Juno','测试模块四','2021-07-14 10:19:17.048512','2021-07-14 10:19:17.048512',2);
/*!40000 ALTER TABLE `interfacetestplatform_module` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_project`
--

DROP TABLE IF EXISTS `interfacetestplatform_project`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_project` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `proj_owner` varchar(20) NOT NULL,
  `test_owner` varchar(20) NOT NULL,
  `dev_owner` varchar(20) NOT NULL,
  `desc` varchar(100) DEFAULT NULL,
  `create_time` datetime(6) NOT NULL,
  `update_time` datetime(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_project`
--

LOCK TABLES `interfacetestplatform_project` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_project` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_project` VALUES (1,'项目一','zhangsan','Juno','lisi','测试项目一','2021-07-13 08:52:27.871303','2021-07-13 08:52:27.872303'),(2,'项目二','zhangsan','Juno','lisi','测试项目二','2021-07-13 08:52:42.352131','2021-07-13 08:52:42.352131');
/*!40000 ALTER TABLE `interfacetestplatform_project` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_suitecase`
--

DROP TABLE IF EXISTS `interfacetestplatform_suitecase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_suitecase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` int NOT NULL,
  `create_time` datetime(6) NOT NULL,
  `case_suite_id` int NOT NULL,
  `test_case_id` int NOT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatfor_case_suite_id_9ca7eb43_fk_interface` (`case_suite_id`),
  KEY `interfacetestplatfor_test_case_id_943732e8_fk_interface` (`test_case_id`),
  CONSTRAINT `interfacetestplatfor_case_suite_id_9ca7eb43_fk_interface` FOREIGN KEY (`case_suite_id`) REFERENCES `interfacetestplatform_casesuite` (`id`),
  CONSTRAINT `interfacetestplatfor_test_case_id_943732e8_fk_interface` FOREIGN KEY (`test_case_id`) REFERENCES `interfacetestplatform_testcase` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_suitecase`
--

LOCK TABLES `interfacetestplatform_suitecase` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_suitecase` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_suitecase` VALUES (2,1,'2021-07-18 12:47:35.794603',1,1),(3,1,'2021-07-18 12:47:35.811660',1,2),(4,1,'2021-07-18 12:47:44.044197',2,1),(5,1,'2021-07-18 12:47:44.059186',2,2);
/*!40000 ALTER TABLE `interfacetestplatform_suitecase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_testcase`
--

DROP TABLE IF EXISTS `interfacetestplatform_testcase`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_testcase` (
  `id` int NOT NULL AUTO_INCREMENT,
  `case_name` varchar(50) NOT NULL,
  `request_data` varchar(1024) NOT NULL,
  `uri` varchar(1024) NOT NULL,
  `assert_key` varchar(1024) DEFAULT NULL,
  `maintainer` varchar(1024) NOT NULL,
  `extract_var` varchar(1024) DEFAULT NULL,
  `request_method` varchar(1024) DEFAULT NULL,
  `status` int DEFAULT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) DEFAULT NULL,
  `belong_module_id` int NOT NULL,
  `belong_project_id` int NOT NULL,
  `user_id` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatfor_belong_project_id_210fc6df_fk_interface` (`belong_project_id`),
  KEY `interfacetestplatform_testcase_user_id_cf6cb43d_fk_auth_user_id` (`user_id`),
  KEY `interfacetestplatform_testcase_belong_module_id_1caf7e3c` (`belong_module_id`),
  CONSTRAINT `interfacetestplatfor_belong_module_id_1caf7e3c_fk_interface` FOREIGN KEY (`belong_module_id`) REFERENCES `interfacetestplatform_module` (`id`),
  CONSTRAINT `interfacetestplatfor_belong_project_id_210fc6df_fk_interface` FOREIGN KEY (`belong_project_id`) REFERENCES `interfacetestplatform_project` (`id`),
  CONSTRAINT `interfacetestplatform_testcase_user_id_cf6cb43d_fk_auth_user_id` FOREIGN KEY (`user_id`) REFERENCES `auth_user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_testcase`
--

LOCK TABLES `interfacetestplatform_testcase` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_testcase` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_testcase` VALUES (1,'注册','{\"username\":\"testman${unique_num1}\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','/register/','userid','Juno','userid||userid\": (\\d+)','post',0,'2021-06-14 18:39:02.730634','2021-07-19 21:39:22.066223',1,1,1),(2,'登录','{\"username\": \"testman${num1}\", \"password\": \"${md5(\'123456789abc\')}\"}','/login/','token&&userid','Juno','token||token\": \"(\\w+)','post',0,'2021-06-14 18:41:22.508075','2021-07-17 16:19:18.396991',1,1,1),(3,'创建博客','{\"userid\":${userid}, \"token\": \"${token}\", \"title\":\"python\", \"content\":\"python port test\"}','/create/','\"code\": \"00\"','张三','None','post',0,'2021-07-03 16:21:05.547356','2021-07-03 18:47:54.407413',1,1,1),(4,'查询用户博文','{\"userid\":${userid}, \"token\": \"${token}\" }','/getBlogsOfUser/','\"title\": \"','张三','articleId||\"articleId\": (\\d+)','post',0,'2021-07-03 16:22:05.848088','2021-07-03 22:00:42.823255',1,1,1),(5,'查询博文内容','${articleId}','/getBlogContent/','\"content\": \"python port test\"','张三','None','get',0,'2021-07-03 16:22:57.026532','2021-07-03 22:02:49.240907',1,1,1),(6,'更新博文内容','{\"userid\":${userid}, \"token\": \"${token}\", \"articleId\":${articleId}, \"title\":\"python\", \"content\":\"test test\"}','/update/','\"update_time\": \"2021','张三','None','put',0,'2021-07-03 16:23:46.480833','2021-07-03 22:03:57.762001',1,1,1),(7,'批量查询博文','${articleId}','/getBlogsContent/articleIds=','\"code\": \"00\"','张三','None','get',0,'2021-07-03 22:11:39.000000','2021-07-03 22:11:45.000000',1,1,1),(8,'删除博文','{\"userid\":${userid}, \"token\": \"${token}\", \"articleId\":[${articleId}]}','/delete/','\"code\": \"00\"','张三','None','post',0,'2021-07-03 16:25:00.818050','2021-07-03 16:25:00.818050',1,1,1);
/*!40000 ALTER TABLE `interfacetestplatform_testcase` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `interfacetestplatform_testcaseexecuteresult`
--

DROP TABLE IF EXISTS `interfacetestplatform_testcaseexecuteresult`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `interfacetestplatform_testcaseexecuteresult` (
  `id` int NOT NULL AUTO_INCREMENT,
  `status` int DEFAULT NULL,
  `exception_info` varchar(2048) DEFAULT NULL,
  `request_data` varchar(1024) DEFAULT NULL,
  `response_data` varchar(1024) DEFAULT NULL,
  `execute_result` varchar(1024) DEFAULT NULL,
  `last_time_response_data` varchar(1024) DEFAULT NULL,
  `execute_total_time` varchar(1024) DEFAULT NULL,
  `execute_start_time` varchar(300) DEFAULT NULL,
  `execute_end_time` varchar(300) DEFAULT NULL,
  `created_time` datetime(6) NOT NULL,
  `updated_time` datetime(6) DEFAULT NULL,
  `belong_test_case_id` int NOT NULL,
  `extract_var` varchar(1024) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `interfacetestplatform_testc_belong_test_case_id_07b5240c` (`belong_test_case_id`),
  CONSTRAINT `interfacetestplatfor_belong_test_case_id_07b5240c_fk_interface` FOREIGN KEY (`belong_test_case_id`) REFERENCES `interfacetestplatform_testcase` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=24 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `interfacetestplatform_testcaseexecuteresult`
--

LOCK TABLES `interfacetestplatform_testcaseexecuteresult` WRITE;
/*!40000 ALTER TABLE `interfacetestplatform_testcaseexecuteresult` DISABLE KEYS */;
INSERT INTO `interfacetestplatform_testcaseexecuteresult` VALUES (1,1,NULL,'{\"username\":\"testman20204\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2746}','成功','','226','2021-07-17 17:56:59','2021-07-17 17:57:00','2021-07-17 17:56:59.847973','2021-07-17 17:57:00.119061',1,'userid: 2746'),(2,1,NULL,'{\"username\": \"testman20204\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"e3e8926321240ff33828980a0d3c2782\", \"code\": \"00\", \"userid\": 2746, \"login_time\": \"2021-07-17 17:57:00\"}','成功','','219','2021-07-17 17:57:00','2021-07-17 17:57:00','2021-07-17 17:57:00.145622','2021-07-17 17:57:00.404052',2,'token: e3e8926321240ff33828980a0d3c2782'),(3,1,NULL,'{\"username\":\"testman20205\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2747}','成功','{\"code\": \"00\", \"userid\": 2746}','252','2021-07-17 21:12:35','2021-07-17 21:12:35','2021-07-17 21:12:35.029967','2021-07-17 21:12:35.315207',1,'userid: 2747'),(4,1,NULL,'{\"username\": \"testman20205\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"e97ad085136262c9604d369e9082d5b8\", \"code\": \"00\", \"userid\": 2747, \"login_time\": \"2021-07-17 21:12:36\"}','成功','{\"token\": \"e3e8926321240ff33828980a0d3c2782\", \"code\": \"00\", \"userid\": 2746, \"login_time\": \"2021-07-17 17:57:00\"}','553','2021-07-17 21:12:35','2021-07-17 21:12:35','2021-07-17 21:12:35.341195','2021-07-17 21:12:35.932010',2,'token: e97ad085136262c9604d369e9082d5b8'),(5,1,'','{\"username\":\"testman20206\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2748}','失败','{\"code\": \"00\", \"userid\": 2747}','256','2021-07-17 21:59:46','2021-07-17 21:59:46','2021-07-17 21:59:46.320861','2021-07-17 21:59:46.603482',1,NULL),(6,1,NULL,'{\"username\": \"testman20206\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"4053d051541baac166ad58cb20be38a4\", \"code\": \"00\", \"userid\": 2748, \"login_time\": \"2021-07-17 21:59:47\"}','成功','{\"token\": \"e97ad085136262c9604d369e9082d5b8\", \"code\": \"00\", \"userid\": 2747, \"login_time\": \"2021-07-17 21:12:36\"}','206','2021-07-17 21:59:46','2021-07-17 21:59:46','2021-07-17 21:59:46.633257','2021-07-17 21:59:46.873594',2,'token: 4053d051541baac166ad58cb20be38a4'),(7,NULL,NULL,NULL,NULL,NULL,'{\"code\": \"00\", \"userid\": 2748}',NULL,NULL,NULL,'2021-07-17 22:02:16.381482','2021-07-17 22:02:16.392240',1,NULL),(8,1,'Traceback (most recent call last):\n  File \"E:\\InterfaceAutoTest\\interfacetestplatform\\task.py\", line 72, in case_task\n    res_data = request_process(url, request_method, json.loads(request_data))\n  File \"C:\\Python36\\lib\\json\\__init__.py\", line 354, in loads\n    return _default_decoder.decode(s)\n  File \"C:\\Python36\\lib\\json\\decoder.py\", line 339, in decode\n    obj, end = self.raw_decode(s, idx=_w(s, 0).end())\n  File \"C:\\Python36\\lib\\json\\decoder.py\", line 355, in raw_decode\n    obj, end = self.scan_once(s, idx)\njson.decoder.JSONDecodeError: Expecting property name enclosed in double quotes: line 1 column 76 (char 75)\n','{\"username\":\"testman20208\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\",,,,}',NULL,'失败',NULL,'0','2021-07-17 22:03:32','2021-07-17 22:03:32','2021-07-17 22:03:32.429283','2021-07-17 22:03:32.535222',1,NULL),(9,1,'keyword: userid not matched from response, assert failed','{\"username\": \"testman20208\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"code\": \"03\", \"params\": {\"username\": \"testman20208\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','失败','{\"token\": \"4053d051541baac166ad58cb20be38a4\", \"code\": \"00\", \"userid\": 2748, \"login_time\": \"2021-07-17 21:59:47\"}','225','2021-07-17 22:03:32','2021-07-17 22:03:32','2021-07-17 22:03:32.564207','2021-07-17 22:03:32.820061',2,NULL),(10,1,'Traceback (most recent call last):\n  File \"F:\\InterfaceAutoTest\\interfacetestplatform\\task.py\", line 76, in case_task\n    res_data = request_process(url, request_method, json.loads(request_data))\n  File \"c:\\python36\\lib\\json\\__init__.py\", line 354, in loads\n    return _default_decoder.decode(s)\n  File \"c:\\python36\\lib\\json\\decoder.py\", line 339, in decode\n    obj, end = self.raw_decode(s, idx=_w(s, 0).end())\n  File \"c:\\python36\\lib\\json\\decoder.py\", line 355, in raw_decode\n    obj, end = self.scan_once(s, idx)\njson.decoder.JSONDecodeError: Expecting property name enclosed in double quotes: line 1 column 75 (char 74)\n','{\"username\":\"testmanNone\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\",,,}',NULL,'失败',NULL,'41000','2021-07-19 21:24:24','2021-07-19 21:25:06','2021-07-19 21:24:24.223956','2021-07-19 21:25:06.084598',1,NULL),(11,1,'keyword：userid not matched from response, assert failed','{\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"code\": \"03\", \"params\": {\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','失败','{\"code\": \"03\", \"params\": {\"username\": \"testman20208\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','447','2021-07-19 21:25:06','2021-07-19 21:25:06','2021-07-19 21:25:06.103615','2021-07-19 21:25:06.574678',2,NULL),(12,1,NULL,'{\"username\":\"testmanNone\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 2}','成功',NULL,'41380','2021-07-19 21:39:30','2021-07-19 21:40:11','2021-07-19 21:39:30.283378','2021-07-19 21:40:11.704337',1,'userid：2'),(13,1,NULL,'{\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:40:11\"}','成功','{\"code\": \"03\", \"params\": {\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}}','165','2021-07-19 21:40:11','2021-07-19 21:40:11','2021-07-19 21:40:11.743317','2021-07-19 21:40:11.943206',2,'token：f734f8cdd52bbd4435f33ec5d8eb4a6b'),(14,1,'','{\"username\":\"testmanNone\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"username\": \"testmanNone\", \"code\": \"01\"}','失败','{\"code\": \"00\", \"userid\": 2}','41734','2021-07-19 21:41:19','2021-07-19 21:42:01','2021-07-19 21:41:19.398382','2021-07-19 21:42:01.159620',1,NULL),(15,1,NULL,'{\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:42:01\"}','成功','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:40:11\"}','237','2021-07-19 21:42:01','2021-07-19 21:42:01','2021-07-19 21:42:01.190609','2021-07-19 21:42:01.460899',2,'token：f734f8cdd52bbd4435f33ec5d8eb4a6b'),(16,1,'','{\"username\":\"testmanNone\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"username\": \"testmanNone\", \"code\": \"01\"}','失败','{\"username\": \"testmanNone\", \"code\": \"01\"}','41452','2021-07-19 21:46:17','2021-07-19 21:46:58','2021-07-19 21:46:17.519161','2021-07-19 21:46:59.000853',1,NULL),(17,1,NULL,'{\"username\": \"testmanNone\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:46:59\"}','成功','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:42:01\"}','479','2021-07-19 21:46:59','2021-07-19 21:46:59','2021-07-19 21:46:59.040824','2021-07-19 21:46:59.548527',2,'token：f734f8cdd52bbd4435f33ec5d8eb4a6b'),(18,1,NULL,'{\"username\":\"testman7722\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 3}','成功','{\"username\": \"testmanNone\", \"code\": \"01\"}','227','2021-07-19 21:48:54','2021-07-19 21:48:54','2021-07-19 21:48:54.231243','2021-07-19 21:48:54.495100',1,'userid：3'),(19,1,NULL,'{\"username\":\"testman7723\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 4}','成功','{\"username\": \"testmanNone\", \"code\": \"01\"}','243','2021-07-19 21:48:54','2021-07-19 21:48:54','2021-07-19 21:48:54.240238','2021-07-19 21:48:54.528085',1,'userid：4'),(20,1,NULL,'{\"username\": \"testman7722\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"9f3581220a6afcfb86edc4a1e6483448\", \"code\": \"00\", \"userid\": 3, \"login_time\": \"2021-07-19 21:48:54\"}','成功','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:46:59\"}','167','2021-07-19 21:48:54','2021-07-19 21:48:54','2021-07-19 21:48:54.548069','2021-07-19 21:48:54.753197',2,'token：9f3581220a6afcfb86edc4a1e6483448'),(21,1,NULL,'{\"username\": \"testman7723\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"265c6ccc228acd57e0dd2f2ad5c0c4c8\", \"code\": \"00\", \"userid\": 4, \"login_time\": \"2021-07-19 21:48:54\"}','成功','{\"token\": \"f734f8cdd52bbd4435f33ec5d8eb4a6b\", \"code\": \"00\", \"userid\": 2, \"login_time\": \"2021-07-19 21:46:59\"}','187','2021-07-19 21:48:54','2021-07-19 21:48:54','2021-07-19 21:48:54.562089','2021-07-19 21:48:54.786345',2,'token：265c6ccc228acd57e0dd2f2ad5c0c4c8'),(22,1,NULL,'{\"username\":\"testman20214\", \"password\":\"123456789abc\",\"email\":\"sed@qq.com\"}','{\"code\": \"00\", \"userid\": 5}','成功','{\"code\": \"00\", \"userid\": 4}','188','2021-07-19 21:50:26','2021-07-19 21:50:26','2021-07-19 21:50:26.404170','2021-07-19 21:50:26.630044',1,'userid：5'),(23,1,NULL,'{\"username\": \"testman20214\", \"password\": \"d266f2f31cf903c870027659030e967e\"}','{\"token\": \"b319881b0c246d3dd1034ee9d968726f\", \"code\": \"00\", \"userid\": 5, \"login_time\": \"2021-07-19 21:50:26\"}','成功','{\"token\": \"265c6ccc228acd57e0dd2f2ad5c0c4c8\", \"code\": \"00\", \"userid\": 4, \"login_time\": \"2021-07-19 21:48:54\"}','173','2021-07-19 21:50:26','2021-07-19 21:50:26','2021-07-19 21:50:26.657026','2021-07-19 21:50:26.915545',2,'token：b319881b0c246d3dd1034ee9d968726f');
/*!40000 ALTER TABLE `interfacetestplatform_testcaseexecuteresult` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-07-19 23:18:27
