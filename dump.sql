-- MySQL dump 10.13  Distrib 8.0.22, for Linux (x86_64)
--
-- Host: localhost    Database: blog
-- ------------------------------------------------------
-- Server version	8.0.22-0ubuntu0.20.04.3

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
-- Current Database: `blog`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `blog` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;

USE `blog`;

--
-- Table structure for table `article`
--

DROP TABLE IF EXISTS `article`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `article` (
  `id_article` int NOT NULL AUTO_INCREMENT,
  `user_id_id` int NOT NULL,
  `titre` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` mediumtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `alias` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_publication` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id_article`),
  KEY `IDX_23A0E669D86650F` (`user_id_id`),
  CONSTRAINT `FK_23A0E669D86650F` FOREIGN KEY (`user_id_id`) REFERENCES `user` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `article`
--

LOCK TABLES `article` WRITE;
/*!40000 ALTER TABLE `article` DISABLE KEYS */;
INSERT INTO `article` VALUES (1,1,'titre1','test','article','2021-01-04 13:32:50'),(2,1,'titre1','test','article2','2021-01-04 13:34:39'),(4,1,'fete de la biere annulée','cette année la fête de la biere est annulée pour cause de covid','article_2','2020-02-01 00:00:00'),(5,1,'fete de la saucisse annulée','cette année la fête de la saucisse est annulée pour cause de covid','article_3','2020-03-01 00:00:00'),(6,1,'fete de la spéléo annulée','cette année la fête de la spéléo est annulée pour cause de covid','article_4','2020-04-01 00:00:00'),(7,2,'fete de la musique annulée','cette année la fête de la musique est annulée pour cause de covid','article_5','2020-05-01 00:00:00'),(8,2,'fete de la randonnée annulée','cette année la fête de la randonnée est annulée pour cause de covid','article_6','2020-06-01 00:00:00'),(9,2,'fete de l escalade annulée','cette année la fête de l escalade est annulée pour cause de covid','article_7','2020-07-01 00:00:00'),(10,3,'fete du cinema annulée','cette année la fête du cinema est annulée pour cause de covid','article_8','2020-08-01 00:00:00'),(11,3,'fete chez Jojo annulée','cette année la fete chez Jojo est annulée pour cause de covid','article_9','2020-09-01 00:00:00'),(12,3,'fete de Noel annulée','cette année la fete de Noel est annulée pour cause de covid','article_10','2020-10-01 00:00:00'),(13,1,'fete de l\'ecole annulée','cette année la fete de l\'ecole est annulée pour cause de covid','article_11','2020-11-01 00:00:00');
/*!40000 ALTER TABLE `article` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20201226175148','2020-12-27 10:40:45',320),('DoctrineMigrations\\Version20201227102516','2020-12-27 10:40:46',160);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `user` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `first_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `last_name` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `date_publication` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `is_verified` tinyint(1) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_8D93D649E7927C74` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'lounis.lemaitre@hotmail.com','[]','$argon2id$v=19$m=65536,t=4,p=1$S083eWdydzlXMkJMMVo5Rw$cs3roCzizorsoVvb/7j/TCgB5KUG2kzN8W+Y+67O1w0','Lounis','Lemaitre','2020-12-27 10:41:22',1),(2,'lounis.lemaitre@gmail.com','[]','$argon2id$v=19$m=65536,t=4,p=1$ZXVMSHd5UmFQWXRvY29jbA$nh+cQNutBPh4u8pYUGZEtucM86fPK3VPm13TZJTpgPw','LaBaffe','Lemaitre','2020-12-27 10:46:43',1),(3,'pierre.lemaitre@gmail.com','[]','$argon2id$v=19$m=65536,t=4,p=1$Vnp6OWcwU2VEUGhGWE5tUA$dkATWOVNWbhU+q5L4ZBndl7SKla0FbzTb+AXAquZpBo','pierre','Lemaitre','2020-12-27 10:48:06',1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-01-04 15:11:54
