CREATE DATABASE  IF NOT EXISTS `library` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `library`;
-- MySQL dump 10.13  Distrib 8.0.34, for macos13 (x86_64)
--
-- Host: localhost    Database: library
-- ------------------------------------------------------
-- Server version	8.0.34

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
-- Table structure for table `author`
--

DROP TABLE IF EXISTS `author`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author` (
  `author_id` int NOT NULL AUTO_INCREMENT,
  `author_name` varchar(64) NOT NULL,
  `date_of_birth` date NOT NULL,
  PRIMARY KEY (`author_id`),
  UNIQUE KEY `author_name` (`author_name`,`date_of_birth`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author`
--

LOCK TABLES `author` WRITE;
/*!40000 ALTER TABLE `author` DISABLE KEYS */;
INSERT INTO `author` VALUES (3,'David Foster Wallace','1962-02-21'),(1,'George R.R. Martin','1948-09-20'),(4,'Gillian Flynn','1971-02-24'),(6,'Sally Rooney','1991-02-20'),(5,'Stephen King','1947-09-21'),(2,'Toni Morrison','1931-02-18');
/*!40000 ALTER TABLE `author` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `author_writes_book`
--

DROP TABLE IF EXISTS `author_writes_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `author_writes_book` (
  `author_id` int NOT NULL,
  `isbn` bigint NOT NULL,
  PRIMARY KEY (`author_id`,`isbn`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `author_writes_book_ibfk_1` FOREIGN KEY (`author_id`) REFERENCES `author` (`author_id`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `author_writes_book_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `author_writes_book`
--

LOCK TABLES `author_writes_book` WRITE;
/*!40000 ALTER TABLE `author_writes_book` DISABLE KEYS */;
INSERT INTO `author_writes_book` VALUES (1,553103547),(4,9780307588371),(3,9780316920049),(5,9780788751554),(2,9781400033416),(6,9783442771509);
/*!40000 ALTER TABLE `author_writes_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `isbn` bigint NOT NULL,
  `title` varchar(64) NOT NULL,
  `original_publication_date` date NOT NULL,
  `book_language` varchar(64) NOT NULL,
  `book_format` enum('Paperback','Hardcover','Audiobook') NOT NULL,
  PRIMARY KEY (`isbn`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book`
--

LOCK TABLES `book` WRITE;
/*!40000 ALTER TABLE `book` DISABLE KEYS */;
INSERT INTO `book` VALUES (553103547,'A Game of Thrones','1996-08-01','English','Hardcover'),(9780307588371,'Gone Girl','2012-05-24','English','Paperback'),(9780316920049,'Infinite Jest','1996-02-01','English','Hardcover'),(9780788751554,'On Writing','2000-10-03','English','Audiobook'),(9781400033416,'Beloved','1987-09-16','English','Paperback'),(9783442771509,'Normal People','2018-08-30','English','Paperback');
/*!40000 ALTER TABLE `book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `book_copy`
--

DROP TABLE IF EXISTS `book_copy`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_copy` (
  `copy_number` int NOT NULL,
  `book_condition` enum('Poor','Fair','Good','Excellent','N/A') NOT NULL,
  `date_of_acquisition` date NOT NULL,
  `due_date` date DEFAULT NULL,
  `isbn` bigint NOT NULL,
  `branch_id` int NOT NULL,
  `member_id` int DEFAULT NULL,
  PRIMARY KEY (`isbn`,`copy_number`),
  KEY `branch_id` (`branch_id`),
  KEY `member_id` (`member_id`),
  CONSTRAINT `book_copy_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `book_copy_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `book_copy_ibfk_3` FOREIGN KEY (`member_id`) REFERENCES `branch_member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_copy`
--

LOCK TABLES `book_copy` WRITE;
/*!40000 ALTER TABLE `book_copy` DISABLE KEYS */;
INSERT INTO `book_copy` VALUES (1,'Good','2020-05-01',NULL,553103547,2,NULL),(2,'Poor','2020-05-01',NULL,553103547,1,NULL),(1,'Excellent','2020-01-01',NULL,9780307588371,1,NULL),(1,'Good','2020-03-01',NULL,9780316920049,2,NULL),(1,'N/A','2020-01-01',NULL,9780788751554,3,NULL),(2,'N/A','2023-08-28',NULL,9780788751554,1,NULL);
/*!40000 ALTER TABLE `book_copy` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_due_date` BEFORE UPDATE ON `book_copy` FOR EACH ROW BEGIN
    IF NEW.member_id IS NOT NULL AND OLD.member_id IS NULL THEN
        -- Update due_date to 30 days after the update
        SET NEW.due_date = DATE_ADD(NOW(), INTERVAL 30 DAY);

        -- Create a tuple in member_returns_at_branch
        INSERT INTO member_returns_at_branch (member_id, branch_id)
        VALUES (NEW.member_id, NEW.branch_id);

        -- Enable the event scheduler if it's not already enabled
        SET GLOBAL event_scheduler = 1;

        -- Set the member_id to update in the event
        SET @memberToUpdate = NEW.member_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book_has_genre`
--

DROP TABLE IF EXISTS `book_has_genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_has_genre` (
  `isbn` bigint NOT NULL,
  `genre_id` int NOT NULL,
  PRIMARY KEY (`isbn`,`genre_id`),
  KEY `genre_id` (`genre_id`),
  CONSTRAINT `book_has_genre_ibfk_1` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE RESTRICT ON UPDATE RESTRICT,
  CONSTRAINT `book_has_genre_ibfk_2` FOREIGN KEY (`genre_id`) REFERENCES `genre` (`genre_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `book_has_genre`
--

LOCK TABLES `book_has_genre` WRITE;
/*!40000 ALTER TABLE `book_has_genre` DISABLE KEYS */;
INSERT INTO `book_has_genre` VALUES (553103547,1),(9780316920049,2),(553103547,3),(9780307588371,4),(9780307588371,6),(9781400033416,7),(9783442771509,8),(553103547,9),(9781400033416,10),(9780316920049,12),(9780316920049,15),(9780788751554,16),(9780788751554,18);
/*!40000 ALTER TABLE `book_has_genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch`
--

DROP TABLE IF EXISTS `branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch` (
  `branch_id` int NOT NULL AUTO_INCREMENT,
  `street_number` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip_code` varchar(5) NOT NULL,
  `phone_number` varchar(64) NOT NULL,
  PRIMARY KEY (`branch_id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch`
--

LOCK TABLES `branch` WRITE;
/*!40000 ALTER TABLE `branch` DISABLE KEYS */;
INSERT INTO `branch` VALUES (1,123,'Main St','Boston','MA','02120','555-234-4536'),(2,22,'Broad St','Boston','MA','02120','555-234-4435'),(3,33,'State St','Boston','MA','02120','555-234-4657');
/*!40000 ALTER TABLE `branch` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `branch_member`
--

DROP TABLE IF EXISTS `branch_member`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `branch_member` (
  `member_id` int NOT NULL AUTO_INCREMENT,
  `member_name` varchar(64) NOT NULL,
  `street_number` int NOT NULL,
  `street_name` varchar(64) NOT NULL,
  `city` varchar(64) NOT NULL,
  `state` varchar(2) NOT NULL,
  `zip_code` varchar(5) NOT NULL,
  `date_joined` date NOT NULL,
  `fee_balance` decimal(10,2) DEFAULT '0.00',
  `account_state` enum('Valid','Invalid') NOT NULL,
  `username` varchar(64) NOT NULL,
  `passwords` varchar(64) NOT NULL,
  PRIMARY KEY (`member_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `branch_member`
--

LOCK TABLES `branch_member` WRITE;
/*!40000 ALTER TABLE `branch_member` DISABLE KEYS */;
INSERT INTO `branch_member` VALUES (1,'Steve Chao',2,'Belfast Av','Boston','MA','02120','2023-10-20',0.00,'Valid','steevy','cool_beans'),(2,'Mary Smith',234,'Huntington St','Boston','MA','02120','2023-09-01',1.50,'Valid','muury','password1'),(3,'Jordan Green',123,'360 Huntington Ave','Boston','MA','02115','2023-07-07',11.00,'Invalid','j_green','green_beans'),(4,'Jenny Branch',3,'Worthington St','Boston','MA','02120','2023-11-30',0.00,'Valid','jenny_bee','thatgirl');
/*!40000 ALTER TABLE `branch_member` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `before_update_account_state` BEFORE UPDATE ON `branch_member` FOR EACH ROW BEGIN
    DECLARE new_balance DECIMAL(10, 2);
    
    -- Retrieve the new fee balance for the specified member
    SELECT NEW.fee_balance INTO new_balance;
    
    -- Check if the new fee balance is over 10.00
    IF new_balance > 10.00 THEN
        -- Update the new account_state to "Invalid"
        SET NEW.account_state = 'Invalid';
    ELSE
        -- Update the new account_state to "Valid"
        SET NEW.account_state = 'Valid';
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `employee`
--

DROP TABLE IF EXISTS `employee`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `employee` (
  `staff_id` int NOT NULL AUTO_INCREMENT,
  `staff_name` varchar(64) NOT NULL,
  `hiring_date` date NOT NULL,
  `branch_id` int NOT NULL,
  `username` varchar(64) NOT NULL,
  `passwords` varchar(64) NOT NULL,
  PRIMARY KEY (`staff_id`),
  UNIQUE KEY `username` (`username`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `employee`
--

LOCK TABLES `employee` WRITE;
/*!40000 ALTER TABLE `employee` DISABLE KEYS */;
INSERT INTO `employee` VALUES (1,'Mo Barre','2023-11-01',1,'mbarre','pw1'),(2,'Sabiha Sarao','2023-11-02',1,'ssarao','pw2'),(3,'Hibah Khan','2023-11-03',1,'hkan','pw3');
/*!40000 ALTER TABLE `employee` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `genre`
--

DROP TABLE IF EXISTS `genre`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `genre` (
  `genre_id` int NOT NULL AUTO_INCREMENT,
  `genre_type` varchar(64) NOT NULL,
  PRIMARY KEY (`genre_id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `genre`
--

LOCK TABLES `genre` WRITE;
/*!40000 ALTER TABLE `genre` DISABLE KEYS */;
INSERT INTO `genre` VALUES (1,'Fantasy'),(2,'Science Fiction'),(3,'Action & Adventure'),(4,'Mystery'),(5,'Horror'),(6,'Thriller & Suspense'),(7,'Historical Fiction'),(8,'Romance'),(9,'Tragedy'),(10,'Magical Realism'),(11,'Graphic Novel'),(12,'Satire'),(13,'Young Adult'),(14,'Children\'s'),(15,'Literary Fiction'),(16,'Autobiography'),(17,'Biography'),(18,'Art'),(19,'Self-help'),(20,'History'),(21,'Humanities'),(22,'Family Drama');
/*!40000 ALTER TABLE `genre` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `member_returns_at_branch`
--

DROP TABLE IF EXISTS `member_returns_at_branch`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `member_returns_at_branch` (
  `member_id` int NOT NULL,
  `branch_id` int NOT NULL,
  `return_date` date DEFAULT NULL,
  `late_fee` decimal(10,2) DEFAULT NULL,
  PRIMARY KEY (`member_id`,`branch_id`),
  KEY `branch_id` (`branch_id`),
  CONSTRAINT `member_returns_at_branch_ibfk_1` FOREIGN KEY (`branch_id`) REFERENCES `branch_member` (`member_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `member_returns_at_branch_ibfk_2` FOREIGN KEY (`branch_id`) REFERENCES `branch` (`branch_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `member_returns_at_branch`
--

LOCK TABLES `member_returns_at_branch` WRITE;
/*!40000 ALTER TABLE `member_returns_at_branch` DISABLE KEYS */;
/*!40000 ALTER TABLE `member_returns_at_branch` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `check_book_return` AFTER UPDATE ON `member_returns_at_branch` FOR EACH ROW BEGIN
    IF NEW.return_date IS NOT NULL THEN
        -- Update book_copy to set member_id back to NULL when book is returned
        UPDATE book_copy
        SET member_id = NULL
        WHERE member_id = NEW.member_id
          AND branch_id = NEW.branch_id;

        -- Disable the event scheduler
        SET GLOBAL event_scheduler = 0;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `update_due_date_on_return` AFTER UPDATE ON `member_returns_at_branch` FOR EACH ROW BEGIN
    -- Check if the return_date is set to a not null value
    IF NEW.return_date IS NOT NULL THEN
        -- Update book_copy to set due_date to NULL when book is returned
        UPDATE book_copy
        SET due_date = NULL
        WHERE member_id = NEW.member_id
          AND branch_id = NEW.branch_id;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `publisher`
--

DROP TABLE IF EXISTS `publisher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher` (
  `publisher_id` int NOT NULL AUTO_INCREMENT,
  `publisher_name` varchar(64) NOT NULL,
  PRIMARY KEY (`publisher_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher`
--

LOCK TABLES `publisher` WRITE;
/*!40000 ALTER TABLE `publisher` DISABLE KEYS */;
INSERT INTO `publisher` VALUES (1,'Bantam Spectra'),(2,'Vintage'),(3,'Little, Brown and Company'),(4,'Random House Publishing Group'),(5,'Recorded Books LLC'),(6,'Faber and Faber');
/*!40000 ALTER TABLE `publisher` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `publisher_publishes_book`
--

DROP TABLE IF EXISTS `publisher_publishes_book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `publisher_publishes_book` (
  `publisher_id` int NOT NULL,
  `isbn` bigint NOT NULL,
  PRIMARY KEY (`publisher_id`,`isbn`),
  KEY `isbn` (`isbn`),
  CONSTRAINT `publisher_publishes_book_ibfk_1` FOREIGN KEY (`publisher_id`) REFERENCES `publisher` (`publisher_id`) ON DELETE RESTRICT ON UPDATE CASCADE,
  CONSTRAINT `publisher_publishes_book_ibfk_2` FOREIGN KEY (`isbn`) REFERENCES `book` (`isbn`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `publisher_publishes_book`
--

LOCK TABLES `publisher_publishes_book` WRITE;
/*!40000 ALTER TABLE `publisher_publishes_book` DISABLE KEYS */;
INSERT INTO `publisher_publishes_book` VALUES (1,553103547),(4,9780307588371),(3,9780316920049),(5,9780788751554),(2,9781400033416),(6,9783442771509);
/*!40000 ALTER TABLE `publisher_publishes_book` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'library'
--

--
-- Dumping routines for database 'library'
--
/*!50003 DROP FUNCTION IF EXISTS `get_available_book_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_available_book_copies`(
    p_isbn INT
) RETURNS int
    DETERMINISTIC
BEGIN
    DECLARE available_copies INT;

    SELECT COUNT(*) INTO available_copies
    FROM book_copy
    WHERE isbn = p_isbn AND member_id IS NULL;

    RETURN available_copies;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `get_fee_balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` FUNCTION `get_fee_balance`(p_member_id INT) RETURNS decimal(10,2)
    DETERMINISTIC
BEGIN
    DECLARE balance DECIMAL(10, 2);

    -- Retrieve the fee balance for the specified member
    SELECT fee_balance INTO balance
    FROM branch_member
    WHERE member_id = p_member_id;

    -- Return the fee balance
    RETURN balance;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_book` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_book`(
    add_isbn BIGINT,
    add_title VARCHAR(64),
    add_author_name VARCHAR(64),
    add_author_date_of_birth DATE,
    add_publisher_name VARCHAR(64),
    add_genre_type VARCHAR(64),
    add_original_publication_date DATE,
    add_book_language VARCHAR(64),
    add_book_format VARCHAR(64)
)
BEGIN
    -- Declare variables for author, publisher, and genre IDs
    DECLARE aid INT;
    DECLARE pid INT;
    
    -- Check if the author exists, create if not
    SELECT author_id INTO aid
    FROM author
    WHERE author_name = add_author_name;

    IF aid IS NULL THEN
        -- Author doesn't exist, create a new author
        INSERT INTO author (author_name, date_of_birth)
        VALUES (add_author_name, add_author_date_of_birth);

        -- Get the newly created author_id
        SET aid = LAST_INSERT_ID();
    END IF;

    -- Check if the publisher exists, create if not
    SELECT publisher_id INTO pid
    FROM publisher
    WHERE publisher_name = add_publisher_name;

    IF pid IS NULL THEN
        -- Publisher doesn't exist, create a new publisher
        INSERT INTO publisher (publisher_name)
        VALUES (add_publisher_name);

        -- Get the newly created publisher_id
        SET pid = LAST_INSERT_ID();
    END IF;

    -- Insert into the book table
    INSERT INTO book (isbn, title, original_publication_date, book_language, book_format)
    VALUES (add_isbn, add_title, add_original_publication_date, add_book_language, add_book_format);
	
    -- Call the new procedure to add genres
    CALL add_genre(add_isbn, add_genre_type);
	
    -- Insert into the author_writes_book table
    INSERT INTO author_writes_book (author_id, isbn)
    VALUES (aid, add_isbn);

    -- Insert into the publisher_publishes_book table
    INSERT INTO publisher_publishes_book (publisher_id, isbn)
    VALUES (pid, add_isbn);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_book_copy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_book_copy`(
    add_isbn BIGINT,
    add_book_condition VARCHAR(64),
    add_date_of_acquisition DATE,
    add_branch_id INT
)
BEGIN
    DECLARE check_bid INT;
    DECLARE check_isbn BIGINT;
    DECLARE next_copy_number INT;
    DECLARE check_book_format ENUM('Paperback', 'Hardcover', 'Audiobook');

    -- Check if isbn exists in the database and get the book format
    SELECT isbn, book_format INTO check_isbn, check_book_format
    FROM book
    WHERE isbn = add_isbn;
    IF check_isbn IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: isbn does not exist in the database';
    END IF;

    -- Check if the branch_id exists in the database
    SELECT branch_id INTO check_bid
    FROM branch
    WHERE branch_id = add_branch_id;
    IF check_bid IS NULL THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: branch_id does not exist in the database';
    END IF;

    -- If the book is an audiobook, set book_condition to 'N/A'
    IF check_book_format = 'Audiobook' THEN
        SET add_book_condition = 'N/A';
    ELSE
        -- If it's not an audiobook, ensure a valid book_condition is provided
        IF NOT add_book_condition IN ('Poor', 'Fair', 'Good', 'Excellent') THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Invalid book_condition for non-audiobook';
        END IF;
    END IF;

    -- Calculate the next copy_number for the given isbn
    SELECT IFNULL(MAX(copy_number), 0) + 1 INTO next_copy_number
    FROM book_copy
    WHERE isbn = add_isbn;

    -- Insert into the book_copy table
    INSERT INTO book_copy (copy_number, book_condition, date_of_acquisition, isbn, branch_id)
    VALUES (next_copy_number, add_book_condition, add_date_of_acquisition, add_isbn, add_branch_id);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `add_genre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `add_genre`(
    add_isbn BIGINT,
    add_genre_type VARCHAR(255)
)
BEGIN
    -- Declare variables
    DECLARE genre_value VARCHAR(64);
    DECLARE genre_start INT DEFAULT 1;
    DECLARE genre_end INT;
    DECLARE gid INT;

    -- Loop to process each genre
    WHILE genre_start <= LENGTH(add_genre_type) DO
        -- Find the position of the next comma or the end of the string
        SET genre_end = IFNULL(NULLIF(LOCATE(',', add_genre_type, genre_start), 0), LENGTH(add_genre_type) + 1);

        -- Extract the genre substring
        SET genre_value = TRIM(SUBSTRING(add_genre_type, genre_start, genre_end - genre_start));

        -- Check if the genre exists, create if not
        SELECT genre_id INTO gid FROM genre WHERE genre_type = genre_value;
		-- last attempt: INSERT IGNORE INTO genre (genre_id, genre_type) VALUES (gid, genre_value);
		IF gid IS NULL THEN
			INSERT INTO genre (genre_type) VALUES (genre_value);
			SET gid = LAST_INSERT_ID();
		END IF;
        
		-- Insert into the book_has_genre table
		INSERT INTO book_has_genre (isbn, genre_id)
		SELECT add_isbn, genre_id FROM genre WHERE genre_type = genre_value;

        -- Move to the next genre
        SET genre_start = genre_end + 1;
    END WHILE;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkout_book_copy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `checkout_book_copy`(
    IN p_isbn BIGINT,
    IN p_copy_number INT,
    IN p_member_id INT
)
BEGIN
    -- Update the member_id field in book_copy
    UPDATE book_copy
    SET member_id = p_member_id
    WHERE isbn = p_isbn AND copy_number = p_copy_number;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `create_member_account` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `create_member_account`(
    IN add_member_name VARCHAR(64),
    IN add_member_age INT,
    IN add_street_number INT,
    IN add_street_name VARCHAR(64),
    IN add_city VARCHAR(64),
    IN add_state VARCHAR(2),
    IN add_zip_code VARCHAR(5),
    IN add_username VARCHAR(64),
    IN add_password VARCHAR(64)
)
BEGIN
    DECLARE mid INT;
    -- Checking to see if the username already exists
    SELECT member_id INTO mid
    FROM branch_member
    WHERE username = add_username;
 
    IF mid IS NOT NULL THEN
        -- Username already exists, error
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Username already exists, choose another one';
    ELSE
INSERT INTO branch_member (
            member_name,
            member_age,
            street_number,
            street_name,
            city,
            state,
            zip_code,
            date_joined,
            username,
            passwords
		)
        VALUES (
            add_member_name,
            add_member_age,
            add_street_number,
            add_street_name,
            add_city,
            add_state,
            add_zip_code,
            CURRENT_DATE(),
            add_username,
            add_password
        );
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_book_copy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_book_copy`(
    IN p_copy_number INT,
    IN p_isbn BIGINT
)
BEGIN
    DECLARE is_checked_out BOOLEAN;

    SELECT IFNULL(due_date IS NOT NULL, FALSE) INTO is_checked_out
    FROM book_copy
    WHERE copy_number = p_copy_number AND isbn = p_isbn;

    IF EXISTS (SELECT 1 FROM book_copy WHERE copy_number = p_copy_number AND isbn = p_isbn) THEN
        IF is_checked_out THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Cannot delete checked-out book copy.';
        ELSE
            DELETE FROM book_copy WHERE copy_number = p_copy_number AND isbn = p_isbn;
        END IF;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Book copy not found.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `delete_member` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `delete_member`(IN p_member_id INT)
BEGIN
    -- Check if the member has a book checked out
    IF EXISTS (SELECT 1 FROM book_copy WHERE member_id = p_member_id) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Cannot delete member with checked-out books';
    END IF;

    -- Check if the member has a non-zero fee balance
    IF EXISTS (SELECT 1 FROM branch_member WHERE member_id = p_member_id AND fee_balance <> 0.00) THEN
        SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Error: Cannot delete member with a non-zero fee balance';
    END IF;

    -- Delete records related to the member
    DELETE FROM member_returns_at_branch WHERE member_id = p_member_id;
    DELETE FROM branch_member WHERE member_id = p_member_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_available_book_copies` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_book_copies`(
    IN p_title VARCHAR(64)
)
BEGIN
    SELECT
        bc.copy_number,
        bc.book_condition,
        b.title,
        a.author_name,
        b.isbn,
        b.book_language,
        b.book_format
    FROM
        book_copy AS bc
    JOIN
        book AS b ON bc.isbn = b.isbn
    JOIN
        author_writes_book AS awb ON b.isbn = awb.isbn
    JOIN
        author AS a ON awb.author_id = a.author_id
    WHERE
        LOWER(b.title) = LOWER(p_title) AND
        bc.member_id IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_available_book_copies_with_author` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_available_book_copies_with_author`(
    IN p_title VARCHAR(64)
)
BEGIN
    SELECT
        bc.copy_number,
        bc.book_condition,
        b.title,
        a.author_name,
        b.original_publication_date,
        b.book_language,
        b.book_format
    FROM
        book_copy AS bc
    JOIN
        book AS b ON bc.isbn = b.isbn
    JOIN
        author_writes_book AS awb ON b.isbn = awb.isbn
    JOIN
        author AS a ON awb.author_id = a.author_id
    WHERE
        b.title = p_title AND
        bc.member_id IS NULL;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_book_copy_condition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_book_copy_condition`(
    update_isbn BIGINT,
    update_copy_number INT,
    new_condition VARCHAR(64)
)
BEGIN
    DECLARE check_book_type ENUM('Paperback', 'Hardcover', 'Audiobook');
    DECLARE current_condition VARCHAR(64);
    DECLARE current_condition_value INT;
    DECLARE new_condition_value INT;

    -- Check if the book exists and get its type
    SELECT book_format INTO check_book_type
    FROM book
    WHERE isbn = update_isbn;

    -- Check if the book is an audiobook, and if it is, throw an error
    IF check_book_type = 'Audiobook' THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Cannot update the condition of an audiobook.';
    END IF;

    -- Get the current condition and its numeric value
    SELECT book_condition, CASE
        WHEN book_condition = 'Poor' THEN 1
        WHEN book_condition = 'Fair' THEN 2
        WHEN book_condition = 'Good' THEN 3
        WHEN book_condition = 'Excellent' THEN 4
        ELSE 0 END INTO current_condition, current_condition_value
    FROM book_copy
    WHERE isbn = update_isbn AND copy_number = update_copy_number;

    -- Get the numeric value of the new condition
    SET new_condition_value = CASE
        WHEN new_condition = 'Poor' THEN 1
        WHEN new_condition = 'Fair' THEN 2
        WHEN new_condition = 'Good' THEN 3
        WHEN new_condition = 'Excellent' THEN 4
        ELSE 0 END;

    -- Check if the new condition is a valid downgrade
    IF new_condition_value < current_condition_value THEN
        -- Valid downgrade
        UPDATE book_copy
        SET book_condition = new_condition
        WHERE isbn = update_isbn AND copy_number = update_copy_number;
    ELSE
        -- Invalid downgrade or upgrade attempt
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Invalid condition update.';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_fee_balance` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_fee_balance`(
    IN p_member_id INT,
    IN p_amount DECIMAL(10, 2)
)
BEGIN
    DECLARE current_balance DECIMAL(10, 2);

	-- get current fee
     SELECT get_fee_balance(p_member_id) INTO current_balance;

	-- check if entered amount is not more than fee
    IF p_amount <= current_balance THEN
        UPDATE branch_member
        SET fee_balance = current_balance - p_amount
        WHERE member_id = p_member_id;
    ELSE
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Amount exceeds fee balance';
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `update_member_address` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `update_member_address`(
    IN p_member_id INT,
    IN p_street_number INT,
    IN p_street_name VARCHAR(64),
    IN p_city VARCHAR(64),
    IN p_state VARCHAR(64),
    IN p_zip_code VARCHAR(5)
)
BEGIN
    UPDATE branch_member
    SET
        street_number = p_street_number,
        street_name = p_street_name,
        city = p_city,
        state = p_state,
        zip_code = p_zip_code
    WHERE
        member_id = p_member_id;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-12-06 16:30:26
