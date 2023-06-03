-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: libq
-- ------------------------------------------------------
-- Server version	5.5.5-10.4.27-MariaDB

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
-- Table structure for table `availability`
--

DROP TABLE IF EXISTS `availability`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `availability` (
  `Copies` int(11) NOT NULL,
  `AvailableCopies` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  PRIMARY KEY (`IdSchool`,`ISBN`),
  UNIQUE KEY `availability_index` (`ISBN`,`IdSchool`),
  KEY `IdSchool` (`IdSchool`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `FK_availability_book` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_availability_schoolunit` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER increase_available_copies
BEFORE UPDATE ON availability
FOR EACH ROW
BEGIN
    IF NEW.Copies > OLD.Copies THEN
        UPDATE availability
        SET AvailableCopies = AvailableCopies + (NEW.Copies - OLD.Copies)
        WHERE ISBN = NEW.ISBN;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER activate_reservations
AFTER UPDATE ON availability
FOR EACH ROW
BEGIN
    IF NEW.AvailableCopies > OLD.AvailableCopies THEN
        UPDATE reservation AS r
        SET r.Active = 1, NEW.AvailableCopies = OLD.AvailableCopies
        WHERE r.ISBN = NEW.ISBN
          AND r.Active = 0
          AND r.ReservationDate = (
              SELECT MIN(ReservationDate)
              FROM reservation
              WHERE ISBN = NEW.ISBN AND Active = 0
          );
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `book`
--

DROP TABLE IF EXISTS `book`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book` (
  `ISBN` varchar(17) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Publisher` varchar(50) NOT NULL,
  `PageNumber` int(10) unsigned NOT NULL,
  `Summary` text NOT NULL,
  `Picture` varchar(255) DEFAULT NULL,
  `Language` varchar(3) NOT NULL,
  `Rating` decimal(3,2) NOT NULL,
  PRIMARY KEY (`ISBN`),
  CONSTRAINT `CK_ISBN` CHECK ((`ISBN` like '978%' or `ISBN` like '979%') and `ISBN` regexp '^[0-9X]+$' and octet_length(`ISBN`) = 13),
  CONSTRAINT `CK_PAGENUMBER` CHECK (`PageNumber` >= 0 and `PageNumber` <= 2500),
  CONSTRAINT `CK_LANGUAGE` CHECK (`Language` in ('AFR','AMH','ARA','ASM','AYM','AZE','BEN','BIS','BHO','BUL','BUR','CAT','CEB','CES','CHI','CMN','CRO','CZE','DAN','DEU','DUT','ENG','EST','EWE','FIN','FRA','FUL','GLG','GLE','GRE','GUI','GUJ','HAT','HAU','HEB','HIN','HMO','HRV','HUN','IBO','ILO','ITA','JAV','KAL','KAN','KAZ','KHM','KIK','KIN','KIR','KOR','KUR','LAT','LAV','LIT','LOZ','LUG','MAI','MAL','MAO','MAR','MAY','MSA','MON','NEP','NOB','NYA','ORI','PAN','POL','PUS','QUE','RAR','RON','RUN','RUS','SLK','SLV','SOM','SOT','SPA','SRP','SWE','SWA','TAI','TAM','TGL','TIR','TON','TUM','TUR','UZB','VIE','WOL','YOR','YUE','ZUL'))
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_categories`
--

DROP TABLE IF EXISTS `book_categories`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_categories` (
  `Category` varchar(100) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  PRIMARY KEY (`Category`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `FK_book_categories_book` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_keywords`
--

DROP TABLE IF EXISTS `book_keywords`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_keywords` (
  `Keyword` varchar(45) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  PRIMARY KEY (`Keyword`,`ISBN`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `FK_book_keywords_book` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `book_writers`
--

DROP TABLE IF EXISTS `book_writers`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `book_writers` (
  `WriterID` int(11) NOT NULL AUTO_INCREMENT,
  `WriterName` varchar(100) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  PRIMARY KEY (`WriterID`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `FK_book_writers_book` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=339 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `borrowing`
--

DROP TABLE IF EXISTS `borrowing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `borrowing` (
  `BorrowingId` int(11) NOT NULL AUTO_INCREMENT,
  `BorrowDate` date NOT NULL,
  `Returned` varchar(10) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  PRIMARY KEY (`BorrowingId`),
  UNIQUE KEY `borrowing_index` (`IdUsers`,`ISBN`),
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `borrowing_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=3777 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_borrowing_insert
BEFORE INSERT ON borrowing
FOR EACH ROW
BEGIN
    DECLARE userType VARCHAR(10);

    -- Determine the user type (Student or Teacher)
    SELECT CASE
        WHEN EXISTS(SELECT * FROM student WHERE IdUsers = NEW.IdUsers) THEN 'student'
        WHEN EXISTS(SELECT * FROM teacher WHERE IdUsers = NEW.IdUsers) THEN 'teacher'
        ELSE NULL
    END INTO userType;

    IF userType IS NOT NULL AND NEW.Returned = False THEN
        IF userType = 'student' THEN
            UPDATE student
            SET BooksToBorrow = BooksToBorrow - 1
            WHERE IdUsers = NEW.IdUsers AND BooksToBorrow > 0;
            
            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot borrow more books. Please return one of your active rentals first.';
            END IF;
        ELSEIF userType = 'teacher' THEN
            UPDATE teacher
            SET BooksToBorrow = BooksToBorrow - 1
            WHERE IdUsers = NEW.IdUsers AND BooksToBorrow > 0;
            
            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot borrow more books. Please return one of your active rentals first.';
            END IF;
        END IF;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_borrowing_update
AFTER UPDATE ON borrowing
FOR EACH ROW
BEGIN
    DECLARE userType VARCHAR(10);
    DECLARE booksToReserve INT;

    IF OLD.Returned = 'False' AND NEW.Returned = 'True' THEN
        SELECT CASE
            WHEN EXISTS(SELECT * FROM student WHERE IdUsers = NEW.IdUsers) THEN 'student'
            WHEN EXISTS(SELECT * FROM teacher WHERE IdUsers = NEW.IdUsers) THEN 'teacher'
            ELSE NULL
        END INTO userType;

        IF userType IS NOT NULL THEN
            IF userType = 'student' THEN
                UPDATE student SET BooksToBorrow = BooksToBorrow + 1 WHERE IdUsers = NEW.IdUsers;
            ELSEIF userType = 'teacher' THEN
                UPDATE teacher SET BooksToBorrow = BooksToBorrow + 1 WHERE IdUsers = NEW.IdUsers;
            END IF;
        END IF;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `generaladmin`
--

DROP TABLE IF EXISTS `generaladmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `generaladmin` (
  `IdGeneralAdmin` int(11) NOT NULL AUTO_INCREMENT,
  `IdUsers` int(11) NOT NULL,
  PRIMARY KEY (`IdGeneralAdmin`),
  UNIQUE KEY `IdGeneralAdmin_UNIQUE` (`IdGeneralAdmin`),
  KEY `FK_generaladmin_users` (`IdUsers`),
  CONSTRAINT `FK_generaladmin_users` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loggeduser`
--

DROP TABLE IF EXISTS `loggeduser`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `loggeduser` (
  `IdLogged` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IdLogged`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `reservation`
--

DROP TABLE IF EXISTS `reservation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservation` (
  `ReservationId` int(11) NOT NULL AUTO_INCREMENT,
  `ReservationDate` date NOT NULL,
  `Active` tinyint(1) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  PRIMARY KEY (`ReservationId`),
  UNIQUE KEY `reservation_index` (`IdUsers`,`ISBN`),
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=354 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_reservation_insert
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE userType VARCHAR(10);

    -- Determine the user type (Student or Teacher)
    SELECT CASE
        WHEN EXISTS(SELECT * FROM student WHERE IdUsers = NEW.IdUsers) THEN 'student'
        WHEN EXISTS(SELECT * FROM teacher WHERE IdUsers = NEW.IdUsers) THEN 'teacher'
        ELSE NULL
    END INTO userType;

    IF userType IS NOT NULL THEN
        IF userType = 'student' THEN
            UPDATE student
            SET BooksToReserve = BooksToReserve - 1
            WHERE IdUsers = NEW.IdUsers AND BooksToReserve > 0;
            
            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot reserve more books. Please return one of your active rentals first.';
            END IF;
        ELSEIF userType = 'teacher' THEN
            UPDATE teacher
            SET BooksToReserve = BooksToReserve - 1
            WHERE IdUsers = NEW.IdUsers AND BooksToReserve > 0;
            
            IF ROW_COUNT() = 0 THEN
                SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Cannot reserve more books. Please return one of your active rentals first.';
            END IF;
        END IF;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER after_reservation_delete
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE userType VARCHAR(10);

    -- Determine the user type (Student or Teacher)
    SELECT CASE
        WHEN EXISTS(SELECT * FROM student WHERE IdUsers = NEW.IdUsers) THEN 'student'
        WHEN EXISTS(SELECT * FROM teacher WHERE IdUsers = NEW.IdUsers) THEN 'teacher'
        ELSE NULL
    END INTO userType;

    IF userType IS NOT NULL THEN
        IF userType = 'student' THEN
            UPDATE student
            SET BooksToReserve = BooksToReserve + 1
            WHERE IdUsers = NEW.IdUsers;
        ELSEIF userType = 'teacher' THEN
            UPDATE teacher
            SET BooksToReserve = BooksToReserve + 1
            WHERE IdUsers = NEW.IdUsers;
        END IF;
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER reservation_delayed_return
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM borrowing
        WHERE IdUsers = NEW.IdUsers
            AND Returned = 'False'
            AND DATEDIFF(NEW.ReservationDate, BorrowDate) > 14
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot make a reservation. You have a delayed borrowing.';
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER reservation_active_borrowing
BEFORE INSERT ON reservation
FOR EACH ROW
BEGIN
    DECLARE active_borrowing INT;

    SELECT COUNT(*) INTO active_borrowing
    FROM borrowing
    WHERE IdUsers = NEW.IdUsers AND ISBN = NEW.ISBN AND Returned = 'false';

    IF active_borrowing > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Cannot make a reservation. You already have an active borrowing of the same book.';
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
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_VALUE_ON_ZERO' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER reservation_added_active_trigger
BEFORE INSERT ON `reservation`
FOR EACH ROW
BEGIN
  IF NEW.Active = 1 THEN
    UPDATE `availability`
    SET AvailableCopies = CASE
      WHEN AvailableCopies > 0 THEN AvailableCopies - 1
      ELSE 0
    END
    WHERE `availability`.`ISBN` = NEW.ISBN
      AND `availability`.`IdSchool` IN (
        SELECT IdSchool FROM `student` WHERE IdUsers = NEW.IdUsers
        UNION
        SELECT IdSchool FROM `teacher` WHERE IdUsers = NEW.IdUsers
      );
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `review`
--

DROP TABLE IF EXISTS `review`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `review` (
  `ReviewText` text NOT NULL,
  `RatingLikert` int(11) NOT NULL,
  `Approval` binary(1) DEFAULT NULL,
  `IdUsers` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_RATING` CHECK (`RatingLikert` >= 1 and `RatingLikert` <= 5)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schooladmin`
--

DROP TABLE IF EXISTS `schooladmin`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schooladmin` (
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  KEY `FK_schooladmin_schoolunit` (`IdSchool`),
  CONSTRAINT `FK_schooladmin_schoolunit` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  CONSTRAINT `FK_schooladmin_users` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `schoolunit`
--

DROP TABLE IF EXISTS `schoolunit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `schoolunit` (
  `IdSchool` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(45) NOT NULL,
  `Adress_street` varchar(45) NOT NULL,
  `Adress_number` int(11) NOT NULL,
  `Adress_city` varchar(45) NOT NULL,
  `Email` varchar(45) NOT NULL,
  `SchoolPrinciple` varchar(45) NOT NULL,
  `SchoolAdmin` varchar(45) NOT NULL,
  PRIMARY KEY (`IdSchool`),
  UNIQUE KEY `ID_UNIQUE` (`IdSchool`),
  CONSTRAINT `CK_Email_Format` CHECK (`Email` like '%_@%._%')
) ENGINE=InnoDB AUTO_INCREMENT=22 DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `student`
--

DROP TABLE IF EXISTS `student`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `student` (
  `StudentName` varchar(45) NOT NULL,
  `Adress_street` varchar(45) NOT NULL,
  `Adress_number` int(11) NOT NULL,
  `Adress_city` varchar(45) NOT NULL,
  `StudentEmail` varchar(100) NOT NULL,
  `BirthDate` date NOT NULL,
  `BooksToReserve` int(11) NOT NULL,
  `BooksToBorrow` int(11) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  UNIQUE KEY `StudentEmail` (`StudentEmail`),
  KEY `FK_student_users` (`IdUsers`),
  KEY `FK_student_schoolunit` (`IdSchool`),
  KEY `student_userid_index` (`IdUsers`),
  CONSTRAINT `FK_student_schoolunit` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_student_users` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_StudentEmail_Format` CHECK (`StudentEmail` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'),
  CONSTRAINT `CK_BooksToReserve` CHECK (`BooksToReserve` >= 0 and `BooksToReserve` <= 2),
  CONSTRAINT `CK_BooksToBorrow` CHECK (`BooksToBorrow` >= 0 and `BooksToBorrow` <= 2)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `teacher`
--

DROP TABLE IF EXISTS `teacher`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `teacher` (
  `TeacherName` varchar(45) NOT NULL,
  `Adress_street` varchar(45) NOT NULL,
  `Adress_number` int(11) NOT NULL,
  `Adress_city` varchar(45) NOT NULL,
  `TeacherEmail` varchar(100) NOT NULL,
  `BirthDate` date NOT NULL,
  `BooksToReserve` int(11) NOT NULL,
  `BooksToBorrow` int(11) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  UNIQUE KEY `TeacherEmail` (`TeacherEmail`),
  KEY `FK_teacher_users` (`IdUsers`),
  KEY `FK_teacher_schoolunit` (`IdSchool`),
  KEY `teacher_userid_index` (`IdUsers`),
  CONSTRAINT `FK_teacher_schoolunit` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_teacher_users` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_TeacherEmail_Format` CHECK (`TeacherEmail` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'),
  CONSTRAINT `CK_BooksToReserve` CHECK (`BooksToReserve` >= 0 and `BooksToReserve` <= 1),
  CONSTRAINT `CK_BooksToBorrow` CHECK (`BooksToBorrow` >= 0 and `BooksToBorrow` <= 1)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `telephone`
--

DROP TABLE IF EXISTS `telephone`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `telephone` (
  `IdSchool` int(11) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  PRIMARY KEY (`IdSchool`,`PhoneNumber`),
  CONSTRAINT `fk_telephoneuser_users` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_PhoneNumber` CHECK (octet_length(`PhoneNumber`) >= 8)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `IdUsers` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Approved` tinyint(1) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  KEY `idx_Username` (`IdUsers`),
  CONSTRAINT `chk_Username` CHECK (octet_length(`Username`) >= 7 and octet_length(`Username`) <= 50),
  CONSTRAINT `chk_Password` CHECK (octet_length(`Password`) >= 6 and octet_length(`Password`) <= 16)
) ENGINE=InnoDB AUTO_INCREMENT=1461 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-06-03 23:38:39
