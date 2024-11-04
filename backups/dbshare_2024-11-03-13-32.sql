-- MySQL dump 10.19  Distrib 10.3.39-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: dbshare
-- ------------------------------------------------------
-- Server version	10.3.39-MariaDB-0+deb10u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `categorie`
--

DROP TABLE IF EXISTS `categorie`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `categorie` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `libelle` varchar(100) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categorie`
--

LOCK TABLES `categorie` WRITE;
/*!40000 ALTER TABLE `categorie` DISABLE KEYS */;
INSERT INTO `categorie` VALUES (1,'exemple 2  AAaa'),(4,'bgfdbgfdbgfd'),(5,'je ne suis pas');
/*!40000 ALTER TABLE `categorie` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `contact`
--

DROP TABLE IF EXISTS `contact`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nom` varchar(30) NOT NULL,
  `sujet` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `message` longtext NOT NULL,
  `date_envoi` datetime NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `contact`
--

LOCK TABLES `contact` WRITE;
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` VALUES (3,'k','k','kkkkk@gmail.com','Ceci est un test pour le flash','0000-00-00 00:00:00'),(4,'Date','Temps','date@gmail.com','essay de temps','2024-09-27 08:55:29'),(5,'2ème','sujet','2eme@gmail.com','Ceci est le 2ème','2024-09-27 09:02:03');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctrine_migration_versions` (
  `version` varchar(191) NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int(11) DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctrine_migration_versions`
--

LOCK TABLES `doctrine_migration_versions` WRITE;
/*!40000 ALTER TABLE `doctrine_migration_versions` DISABLE KEYS */;
INSERT INTO `doctrine_migration_versions` VALUES ('DoctrineMigrations\\Version20240924094856','2024-09-24 09:51:44',651),('DoctrineMigrations\\Version20240924200719','2024-09-24 20:07:37',255),('DoctrineMigrations\\Version20240927085159','2024-09-27 08:52:16',569),('DoctrineMigrations\\Version20241001072737','2024-10-01 07:27:50',1984),('DoctrineMigrations\\Version20241004093748','2024-10-04 09:37:59',91),('DoctrineMigrations\\Version20241004094129','2024-10-04 09:41:33',1825),('DoctrineMigrations\\Version20241004094329','2024-10-04 09:43:34',245),('DoctrineMigrations\\Version20241031005922','2024-10-31 00:59:40',87);
/*!40000 ALTER TABLE `doctrine_migration_versions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `email` varchar(180) NOT NULL,
  `roles` longtext NOT NULL COMMENT '(DC2Type:json)',
  `password` varchar(255) NOT NULL,
  `date_inscription` datetime NOT NULL,
  `nom` varchar(50) NOT NULL,
  `prenom` varchar(50) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--

LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES (1,'blabla.ok@gmail.com','[]','$2y$13$BbtTHIhhSUcuNpb2ML7dMusv5qRNOCKxMr5DChZ.dd25InXRwEdau','2024-10-01 11:47:34','bla','blabla'),(2,'kuth@gmail.com','[]','$2y$13$NAdDlCLkGCPBziilGP4eX.7/qOjWzDfw1pg.yx4A10dK2osKHDbQ2','2024-10-01 11:47:44','ku','kuth'),(3,'htyg@gmail.com','[]','$2y$13$yos/0mIoysYhy0Yjo2PZheA1fJuq76zlEWV./Uv4YJLKetQ/AhklW','2024-10-01 11:47:49','ht','htyg'),(4,'hyt.lop@gmail.com','[]','$2y$13$0SfQNRhm.nRb.k14IjbZS.FChgcEuriXuPao56i8Z6L7X.qgF1Vk6','2024-10-01 11:47:53','hyt','hyt.log'),(5,'azerty@gmail.com','[]','$2y$13$bygKlHTbJyZNYRzwusZPFObfq6ApcVMSsB9fQ3PR/yIKIyP5s6nJy','2024-10-01 11:47:56','aze','azerty'),(6,'qwerty@gmail.com','[\"ROLE_MOD\"]','$2y$13$cMKzNJr1BU1sqln06mt6Jev7fMnREpCzuezFU.xWg6bvRg9KhXMm.','2024-10-01 11:48:00','qwe','qwerty'),(7,'qsdfgh@gmail.com','[\"ROLE_ADMIN\"]','$2y$13$iDQp3IYntsvbQr3Kn2SPL.ckCAd20mhJi26AKFhjPeBfXnHge7W4q','2024-10-01 11:48:03','qsd','qsdfgh'),(8,'ccrevrgf@gmail.com','[]','$2y$13$FacjVxqPhDzep4Gm17cGh.gVsLD9oufaVUStiLVmULU9jFIT/JMBG','2024-10-04 09:47:33','ccre','ccrevrgf'),(9,'essaie@gmail.com','[]','$2y$13$uBzvwxs19U07DVa9RqYnCO4AnjMggDpD9Ehof15qgGSYYARZqycNq','2024-10-31 15:55:16','essaie','essaieahahaha');
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

-- Dump completed on 2024-11-03 13:32:00
