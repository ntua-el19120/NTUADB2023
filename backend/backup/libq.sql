/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: availability
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `availability` (
  `Copies` int(11) NOT NULL,
  `AvailableCopies` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `IdSchool` (`IdSchool`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `availability_ibfk_1` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `availability_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: book
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `book` (
  `ISBN` varchar(17) NOT NULL,
  `Title` varchar(100) NOT NULL,
  `Publisher` varchar(45) NOT NULL,
  `PageNumber` int(11) NOT NULL,
  `Summary` text NOT NULL,
  `Picture` varchar(255) DEFAULT NULL,
  `Language` varchar(45) NOT NULL,
  `Rating` decimal(3, 2) NOT NULL,
  PRIMARY KEY (`ISBN`),
  UNIQUE KEY `ID_UNIQUE` (`ISBN`),
  CONSTRAINT `CK_ISBN` CHECK (
  `ISBN` regexp '^(978|979)\\d{1,5}\\d{1,7}\\d{1,6}\\d|X$'
  or `ISBN` regexp '^(978|979) \\d{1,5} \\d{1,7} \\d{1,6} \\d|X$'
  ),
  CONSTRAINT `CK_PAGENUMBER` CHECK (
  `PageNumber` >= 0
  and `PageNumber` <= 4000
  ),
  CONSTRAINT `CK_LANGUAGE` CHECK (
  `Language` in (
    'AFR',
    'AMH',
    'ARA',
    'ASM',
    'AYM',
    'AZE',
    'BEN',
    'BIS',
    'BHO',
    'BUL',
    'BUR',
    'CAT',
    'CEB',
    'CES',
    'CHI',
    'CMN',
    'CRO',
    'CZE',
    'DAN',
    'DEU',
    'DUT',
    'ENG',
    'EST',
    'EWE',
    'FIN',
    'FRA',
    'FUL',
    'GLG',
    'GLE',
    'GRE',
    'GUI',
    'GUJ',
    'HAT',
    'HAU',
    'HEB',
    'HIN',
    'HMO',
    'HRV',
    'HUN',
    'IBO',
    'ILO',
    'ITA',
    'JAV',
    'KAL',
    'KAN',
    'KAZ',
    'KHM',
    'KIK',
    'KIN',
    'KIR',
    'KOR',
    'KUR',
    'LAT',
    'LAV',
    'LIT',
    'LOZ',
    'LUG',
    'MAI',
    'MAL',
    'MAO',
    'MAR',
    'MAY',
    'MSA',
    'MON',
    'NEP',
    'NOB',
    'NYA',
    'ORI',
    'PAN',
    'POL',
    'PUS',
    'QUE',
    'RAR',
    'RON',
    'RUN',
    'RUS',
    'SLK',
    'SLV',
    'SOM',
    'SOT',
    'SPA',
    'SRP',
    'SWE',
    'SWA',
    'TAI',
    'TAM',
    'TGL',
    'TIR',
    'TON',
    'TUM',
    'TUR',
    'UZB',
    'VIE',
    'WOL',
    'YOR',
    'YUE',
    'ZUL'
  )
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: book_categories
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `book_categories` (
  `Category` enum(
  'Ιστορία (History)',
  'Μυθιστόρημα (Novel)',
  'Φαντασία (Fantasy)',
  'Μυστήριο (Mystery)',
  'Θρίλερ (Thriller)',
  'Ρομαντικό (Romance)',
  'Ποίηση (Poetry)',
  'Διηγήματα (Short Stories)',
  'Αυτοβελτίωση (Self-Improvement)',
  'Θρησκεία (Religion)',
  'Φιλοσοφία (Philosophy)',
  'Ψυχολογία (Psychology)',
  'Παιδικά βιβλία (Childrens Books)',
  'Ταξίδια (Travel)',
  'Τέχνη (Art)',
  'Αρχιτεκτονική (Architecture)',
  'Μαγειρική (Cooking)',
  'Αθλητισμός (Sports)',
  'Επιστημονικά (Science)',
  'Οικονομία (Economics)',
  'Πολιτική (Politics)',
  'Βιογραφίες (Biographies)',
  'Μαθηματικά (Mathematics)',
  'Γλωσσολογία (Linguistics)',
  'Εκπαίδευση (Education)',
  'Περιβάλλον (Environment)',
  'Κοινωνιολογία (Sociology)',
  'Μουσική (Music)',
  'Δικαίωμα (Law)',
  'Επιστημονική Φαντασία (Science Fiction)',
  'Φανταστική Νεανική Λογοτεχνία (Young Adult Fantasy)',
  'Ιστορικό Μυθιστόρημα (Historical Novel)',
  'Πολεμική Λογοτεχνία (War Literature)',
  'Αστυνομική Λογοτεχνία (Crime Fiction)',
  'Επιστημονική Διαφήμιση (Science Non-Fiction)',
  'Αυτοβιογραφία (Autobiography)',
  'Μαγικό Ρεαλισμό (Magical Realism)',
  'Θρησκευτική Λογοτεχνία (Religious Literature)',
  'Κλασική Λογοτεχνία (Classic Literature)',
  'Περιπέτεια (Adventure)',
  'Παραμύθια (Fairy Tales)',
  'Μυθολογία (Mythology)',
  'Τραγωδία (Tragedy)',
  'Κωμωδία (Comedy)',
  'Θέατρο (Theater)',
  'Τεχνολογία (Technology)',
  'Επιστήμη της Υγείας (Health Science)',
  'Περιπλανήσεις (Journeys)',
  'Πολιτισμολογία (Cultural Studies)'
  ) DEFAULT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `book_categories_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: book_keywords
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `book_keywords` (
  `Keyword` varchar(45) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `book_keywords_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: book_writers
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `book_writers` (
  `WriterName` varchar(45) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `book_writers_ibfk_1` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: borrowing
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `borrowing` (
  `BorrowDate` date NOT NULL,
  `Returned` varchar(45) CHARACTER SET utf8 COLLATE utf8_bin NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `borrowing_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `borrowing_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: generaladmin
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `generaladmin` (
  `IdGeneralAdmin` int(11) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  PRIMARY KEY (`IdGeneralAdmin`),
  UNIQUE KEY `IdGeneralAdmin_UNIQUE` (`IdGeneralAdmin`),
  KEY `IdUsers` (`IdUsers`),
  CONSTRAINT `generaladmin_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: reservation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `reservation` (
  `ReservationDate` date NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `reservation_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `reservation_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: review
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `review` (
  `ReviewText` text NOT NULL,
  `RatingLikert` int(11) NOT NULL,
  `Approval` binary(1) DEFAULT NULL,
  `IdUsers` int(11) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `ISBN` (`ISBN`),
  CONSTRAINT `review_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `review_ibfk_2` FOREIGN KEY (`ISBN`) REFERENCES `book` (`ISBN`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_RATING` CHECK (
  `RatingLikert` >= 1
  and `RatingLikert` <= 5
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: schooladmin
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `schooladmin` (
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  `Name` varchar(45) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  KEY `IdSchool` (`IdSchool`),
  CONSTRAINT `schooladmin_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `schooladmin_ibfk_2` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: schoolunit
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `schoolunit` (
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
  CONSTRAINT `CK_Email_Format` CHECK (
  `Email` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  )
) ENGINE = InnoDB AUTO_INCREMENT = 12 DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: student
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `student` (
  `StudentName` varchar(45) NOT NULL,
  `Adress_street` varchar(45) NOT NULL,
  `Adress_number` int(11) NOT NULL,
  `Adress_city` varchar(45) NOT NULL,
  `StudentEmail` varchar(100) NOT NULL,
  `BirthDate` date NOT NULL,
  `BooksToBorrow` int(11) NOT NULL,
  `BooksToReserve` int(11) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `IdSchool` (`IdSchool`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_StudentEmail_Format` CHECK (
  `StudentEmail` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  ),
  CONSTRAINT `CK_BooksToBorrow` CHECK (
  `BooksToBorrow` >= 0
  and `BooksToBorrow` <= 2
  ),
  CONSTRAINT `CK_BooksToReserve` CHECK (
  `BooksToReserve` >= 0
  and `BooksToReserve` <= 2
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: teacher
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `teacher` (
  `TeacherName` varchar(45) NOT NULL,
  `Adress_street` varchar(45) NOT NULL,
  `Adress_number` int(11) NOT NULL,
  `Adress_city` varchar(45) NOT NULL,
  `TeacherEmail` varchar(100) NOT NULL,
  `BirthDate` date NOT NULL,
  `BooksToBorrow` int(11) NOT NULL,
  `BooksToReserve` int(11) NOT NULL,
  `IdUsers` int(11) NOT NULL,
  `IdSchool` int(11) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  KEY `IdSchool` (`IdSchool`),
  CONSTRAINT `teacher_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `teacher_ibfk_2` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `CK_TeacherEmail_Format` CHECK (
  `TeacherEmail` regexp '^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}$'
  ),
  CONSTRAINT `CK_BooksToBorrow` CHECK (
  `BooksToBorrow` >= 0
  and `BooksToBorrow` <= 1
  ),
  CONSTRAINT `CK_BooksToReserve` CHECK (
  `BooksToReserve` >= 0
  and `BooksToReserve` <= 1
  )
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: telephone
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `telephone` (
  `IdSchool` int(11) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  KEY `IdSchool` (`IdSchool`),
  CONSTRAINT `telephone_ibfk_1` FOREIGN KEY (`IdSchool`) REFERENCES `schoolunit` (`IdSchool`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_PhoneNumber` CHECK (octet_length(`PhoneNumber`) >= 8)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: telephoneuser
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `telephoneuser` (
  `IdUsers` int(11) NOT NULL,
  `PhoneNumber` varchar(20) NOT NULL,
  KEY `IdUsers` (`IdUsers`),
  CONSTRAINT `telephoneuser_ibfk_1` FOREIGN KEY (`IdUsers`) REFERENCES `users` (`IdUsers`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `chk_PhoneNumber` CHECK (octet_length(`PhoneNumber`) >= 8)
) ENGINE = InnoDB DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `users` (
  `IdUsers` int(11) NOT NULL AUTO_INCREMENT,
  `Username` varchar(50) NOT NULL,
  `Password` varchar(20) NOT NULL,
  `Approved` binary(1) NOT NULL,
  PRIMARY KEY (`IdUsers`),
  UNIQUE KEY `Username` (`Username`),
  UNIQUE KEY `Username_UNIQUE` (`Username`),
  CONSTRAINT `chk_Username` CHECK (
  octet_length(`Username`) >= 5
  and octet_length(`Username`) <= 50
  ),
  CONSTRAINT `chk_Password` CHECK (
  octet_length(`Password`) >= 8
  and octet_length(`Password`) <= 20
  )
) ENGINE = InnoDB AUTO_INCREMENT = 121 DEFAULT CHARSET = utf8 COLLATE = utf8_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: persons_per_school_view
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `persons_per_school_view` AS
select
  `sa`.`IdUsers` AS `IdSchoolAdmin`,
  `sa`.`Name` AS `SchoolAdminName`,
  `s`.`IdSchool` AS `IdSchool`,
  'Student' AS `PersonType`,
  `st`.`IdUsers` AS `PersonId`,
  `st`.`StudentName` AS `PersonName`,
  `st`.`StudentEmail` AS `PersonEmail`
from
  (
  (
    `student` `st`
    join `schooladmin` `sa` on(`st`.`IdSchool` = `sa`.`IdSchool`)
  )
  join `schoolunit` `s` on(`sa`.`IdSchool` = `s`.`IdSchool`)
  )
union all
select
  `sa`.`IdUsers` AS `IdSchoolAdmin`,
  `sa`.`Name` AS `SchoolAdminName`,
  `s`.`IdSchool` AS `IdSchool`,
  'Teacher' AS `PersonType`,
  `t`.`IdUsers` AS `PersonId`,
  `t`.`TeacherName` AS `PersonName`,
  `t`.`TeacherEmail` AS `PersonEmail`
from
  (
  (
    `teacher` `t`
    join `schooladmin` `sa` on(`t`.`IdSchool` = `sa`.`IdSchool`)
  )
  join `schoolunit` `s` on(`sa`.`IdSchool` = `s`.`IdSchool`)
  );

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: schooladminsapplications
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `schooladminsapplications` AS
select
  `sa`.`Name` AS `name`
from
  (
  `schooladmin` `sa`
  join `users` `u` on(`sa`.`IdUsers` = `u`.`IdUsers`)
  )
where
  `u`.`Approved` = 0;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: users_view
# ------------------------------------------------------------

CREATE OR REPLACE VIEW `users_view` AS
select
  `users`.`IdUsers` AS `IdUsers`,
  `users`.`Approved` AS `Approved`
from
  `users`;

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: availability
# ------------------------------------------------------------

INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9786180320107');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9781071510032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9786180320138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 1, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9781667432564');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9781329008045');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 1, '9789600363524');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9786180314694');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 1, '9786180313321');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 1, '9786180321005');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9788873047681');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9781071523902');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9786180322798');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789600367638');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789601699837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9781909550650');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9786180322330');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9786180322316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789601645858');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 1, '9789939004938');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 1, '9781909550513');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9781005226350');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 1, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 1, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9781911352709');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789605721213');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 1, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 1, '9786180328981');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789601655581');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9786180330793');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789605724139');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 1, '9786180322323');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9786180325560');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 1, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789600367690');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9789601657844');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 1, '9789601647838');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 1, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789605722241');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 1, '9781547535682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9781987904185');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9786180319750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9786180317640');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9786180327090');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 1, '9789601657660');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 1, '9789601647500');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9781667407227');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 1, '9781909550032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9781912322961');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 1, '9789600364187');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 1, '9786180314687');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9789605721794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9786180337389');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9789605721138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9781547523986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9786180321012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9789609527002');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 1, '9789600363661');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9786180322897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9789600358896');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 1, '9786180317695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9789601656052');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9789609527750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 1, '9789605724382');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 1, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9786180324129');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 1, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 1, '9789600359831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9786180317831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9789600358100');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 1, '9781071532997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9786180323887');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 1, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9786180400557');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 1, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 1, '9789605721466');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 1, '9789600360226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 1, '9786180319767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 1, '9789605722647');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 1, '9789601651750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 2, '9789605666477');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9789600368352');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9789600360455');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 2, '9781071599594');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9786180317831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9789601647371');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9789600358896');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9781547523986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9789601659541');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180317848');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9781987904185');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 2, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180322651');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9781387567997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789600353990');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 2, '9789600357288');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9786180337389');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789605724382');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789600358834');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9781005226350');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9781547524365');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 2, '9783966103473');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9781909550018');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9786180317589');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180320138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9789609527002');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789600360677');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9786180400557');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9789600354072');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9786180313321');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9781667432564');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9789600363661');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 2, '9789601648392');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180327090');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9788873047681');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9786180329087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 2, '9781465549976');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9786180314694');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9786180400373');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9786180329278');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9789605722470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 2, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180319750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9789600364187');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9789605721664');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9789605722647');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9789600360639');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9786180319767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 2, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 2, '9789600360226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9786180321012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180313925');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 2, '9786180324440');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9789605724139');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9786180329049');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9789605722579');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 2, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180322736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9781909550360');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 2, '9789600367638');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 2, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 2, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 2, '9786180320787');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9789601698359');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 2, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 2, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 2, '9786180320794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 2, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9786180313819');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9781667407227');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 2, '9786180328981');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 2, '9789600367690');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 2, '9781912322961');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 2, '9789601647623');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 2, '9786180326970');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 2, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 2, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 2, '9786180336108');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 3, '9789601645704');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 3, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9789605725556');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9788873047681');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9786180322897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9789605722241');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789605721695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9785041658434');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 3, '9789601647500');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 3, '9789600354713');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 3, '9789601657844');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 3, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 3, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9781667429625');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 3, '9786180322675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 3, '9789605720575');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 3, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789605721466');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180321005');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9786180327717');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9786180320121');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789605722579');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789605724139');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9786180328981');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789609412797');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 3, '9789600361223');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180329766');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 3, '9786180324440');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789600322439');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 3, '9789601648392');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 3, '9781071523902');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9781909550018');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180329094');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9786180320794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789600358834');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 3, '9786180327007');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 3, '9786180313321');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9781071526521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 3, '9786180330793');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789601647883');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9781547574667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9786180326376');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9781912322015');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9789601647838');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 3, '9781547532742');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9789601645322');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 3, '9789601655581');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9786180322330');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 3, '9789600368345');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9785043797230');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 3, '9786180317831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9786180329049');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180320091');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9781667411767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 3, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 3, '9786180329001');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9789601699837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9786180322668');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 3, '9789609527750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789601647371');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789604007837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9781387567997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9789464447675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9781909550513');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 3, '9786180319750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180317879');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 3, '9789605722470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 3, '9781071526767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 3, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 3, '9786180322798');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 3, '9789601647623');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 3, '9789608869530');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 3, '9786180315110');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 3, '9781987904185');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180320107');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9786180324853');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 3, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 3, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 3, '9786180317589');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 3, '9786180314687');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 3, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9789609527200');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 4, '9789464447675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9786180326970');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 4, '9789601645032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789601647623');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9786180322668');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9781071523902');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 4, '9789601681986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9781912322961');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9789601698359');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 4, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 4, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 4, '9789605724139');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9786180317848');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789608869530');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 4, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9786180317770');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 4, '9789605722647');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 4, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789600367867');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9786180329001');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180327090');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9789600360455');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9786180329278');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 4, '9781547524365');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 4, '9789609412797');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 4, '9786180322316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789600361087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180324143');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9789601647371');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9786180321012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789604007837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 4, '9786180328394');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9786180322897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 4, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9781071510032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 4, '9789600361223');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789600360677');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9781547574667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 4, '9789601699837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9789605720575');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 4, '9786180324075');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 4, '9786180329094');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 4, '9786180317695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 4, '9786180320107');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9785043797230');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9786180319767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 4, '9781667432564');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 4, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 4, '9786180322309');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789605722470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605722241');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 4, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9789605665951');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9789600368345');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 4, '9786180325560');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 4, '9789600363524');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605724382');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9789601655581');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180328981');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9786180328356');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 4, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789600354713');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9789605723316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 4, '9786180329292');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180329087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 4, '9786180325539');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 4, '9785041658434');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 4, '9789601639406');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 4, '9789600363661');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 4, '9789600358896');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 4, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 4, '9781909550650');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 4, '9789605721695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 4, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 4, '9781329008045');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 5, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9789608869530');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9789601645230');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9789605722470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9781071526767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9789601647838');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789605721466');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 5, '9789600367638');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 5, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 5, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 5, '9789601651736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 5, '9789601657660');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9781909550032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9789601651750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 5, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9789605722579');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9781667432564');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789600361407');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 5, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 5, '9789601639406');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 5, '9786180323887');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 5, '9789600357288');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 5, '9789605721695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9781667429625');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9781329008045');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 5, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9781547535682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180329049');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9789600359831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 5, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9786180322736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 5, '9781071599594');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 5, '9786180314694');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 5, '9781547523986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9781071510032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 5, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 5, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9789601656052');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 5, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180320121');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 5, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 5, '9786180320794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 5, '9786180327717');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9789609527200');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9789600367867');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9786180324075');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180317770');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 5, '9789601647883');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 5, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 5, '9789600361087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9789601645858');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 5, '9789600360639');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9783966103473');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9786180336108');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9786180324129');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9786180322323');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9789609527002');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 5, '9781547524365');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789605721138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9781667405148');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 5, '9786180313819');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9781547574667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 5, '9786180328394');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 5, '9786180337389');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9781667411767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9781911352709');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 5, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180329766');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 5, '9789601685427');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 5, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 5, '9789601659541');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9789600354713');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9786180330793');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9781071526521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 5, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9786180326956');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 5, '9786180324853');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9789601647623');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 5, '9789605723316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 5, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 5, '9789600368352');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 5, '9781465549976');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 5, '9789601645322');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 6, '9783966103473');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 6, '9781547524365');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9786180329094');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180333190');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 6, '9789609412797');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180324143');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180332438');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 6, '9789609527002');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789601657844');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9786180400557');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9786180317770');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789601647500');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9781547523986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9789608869530');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9786180322736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180319125');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 6, '9786180320787');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9786180327007');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180326970');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9789601655666');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789600359831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9781329008045');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9781465549976');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9786180324129');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9789609527200');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9786180313819');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9781909550513');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9789601647883');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9786180702408');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789600364187');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 6, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 6, '9781071532997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9786180320107');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9789600360226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789600361407');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180319767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 6, '9786180320121');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9786180322293');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9781909550360');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9789601645858');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9786180322316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180320114');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789605721466');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9788873042204');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789605721138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789600367638');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789604007837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180324440');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180328356');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 6, '9789601639406');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9781912322015');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9789601647838');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9785041658434');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9786180400373');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 6, '9789605722579');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180330793');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 6, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 6, '9789601668062');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 6, '9781667429625');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 6, '9781071599594');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9786180327090');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9789601651606');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9789600361087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 6, '9789601667751');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9786180322330');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 6, '9789600354072');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 6, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 6, '9789600367690');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 6, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 6, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 6, '9789600363661');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9789605723316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 7, '9786180321005');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789601655666');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9789601699837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 7, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 7, '9781909550018');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9786180324129');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9786180327007');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9786180322798');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 7, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 7, '9789605721466');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9789600364187');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789600359831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 7, '9786180324853');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9786180329094');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9781667411767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9786180328134');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9789600353990');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 7, '9788873047681');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180702408');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 7, '9786180322316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9781909550032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 7, '9789601645322');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 7, '9789601651750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180323887');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 7, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9786180329278');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9786180400373');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 7, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9786180329292');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 7, '9786180317831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180322323');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9789605723231');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9786180313925');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9786180324112');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9786180317640');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9781071532997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9789600367867');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9781547532742');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789601667751');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 7, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9786180320138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9789600354713');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789600360455');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180322330');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 7, '9786180332438');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 7, '9781071599594');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9789601647623');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789601647371');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 7, '9789939004938');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789600360639');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789600367638');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 7, '9789601660073');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789601651736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9786180324440');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9781547535682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9789600361223');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 7, '9789601698359');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789601685427');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9786180313819');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9786180321012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9781909550650');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 7, '9786180337389');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180324075');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9789600363524');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9786180317848');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 7, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9781909550513');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9781987904185');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9786180322651');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9789600368338');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 7, '9781071510032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 7, '9789601645032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9786180329001');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 7, '9789600361407');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 7, '9789601659541');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 7, '9786180326376');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 7, '9789601645858');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 7, '9789605665951');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 7, '9789601645209');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9783966103473');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789600367867');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9789605665951');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9786180326956');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789600363524');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9781909550032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 8, '9786180322316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9781667405148');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9786180329766');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9786180324112');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 8, '9786180321012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 8, '9789604007837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9781909550650');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 8, '9786180322668');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789601648392');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789601686370');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9786180317640');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9786180322682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9789601668062');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9786180322798');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9789464447675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180320107');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 8, '9781912322886');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789939004938');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9789600354072');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 8, '9789600357288');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9786180324853');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9789605723231');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9789605721695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9788873042204');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9786180313925');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9786180326970');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9785043340351');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 8, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9786180400373');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 8, '9788873047476');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9786180326376');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9789601645704');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789600358100');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9786180320800');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789605724382');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 8, '9789605725556');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9786180325539');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 8, '9786180328356');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 8, '9789600358896');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9786180315110');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 8, '9789600361087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 8, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9789601667751');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9781908362391');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9781547535682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9789609412797');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 8, '9789605724924');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9786180320138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9786180314694');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 8, '9789601657844');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9781912322015');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9789609527200');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 8, '9789605722647');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 8, '9781005226350');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 8, '9789601645209');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9789600368345');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 8, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180322897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9781911352709');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180317701');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 8, '9781909550544');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 8, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9786180322385');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 8, '9789609527750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9786180329049');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 8, '9789601685427');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 8, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9789601645230');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 8, '9786180322330');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 8, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 8, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 8, '9781071532997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 8, '9786180322293');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 8, '9786180320114');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 8, '9789601651736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 8, '9789601647500');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 9, '9781667407227');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9781310259654');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180322897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9789600353990');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9789600368338');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 9, '9789600357288');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180327717');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 9, '9789608869530');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 9, '9789600367867');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9786180328226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 9, '9789600368345');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180325560');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 9, '9786180326376');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789604007837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9781387567997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 9, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 9, '9789606796616');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 9, '9789605721336');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789601655666');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180400557');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9781005226350');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9789601651606');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 9, '9789600360639');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180320787');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 9, '9789605724948');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9786180325539');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789939004938');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 9, '9789601699837');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9786180320091');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 9, '9789601646572');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789464447675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180327007');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 9, '9789605723897');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9786180317589');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789601639406');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9789600367782');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9781908362391');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 9, '9786180322644');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 9, '9789600368352');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789600358896');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 9, '9781909550018');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 9, '9789601651736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789605665951');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 9, '9789600354072');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 9, '9789605722012');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9781667429625');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 9, '9781465549976');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9781071526767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 9, '9786180400373');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 9, '9786180317879');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789605722647');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789601647470');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 9, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 9, '9789600363661');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 9, '9789600360226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 9, '9789605722876');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 9, '9789600367690');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 9, '9788873047681');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 9, '9781547523986');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9781547535682');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 9, '9786180317770');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9789609527637');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 9, '9789605720575');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 9, '9786180336108');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9781667405148');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 9, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9789601647838');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9789605721213');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9781329008045');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 9, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180328134');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 9, '9786180328356');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180328394');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9786180313826');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 9, '9789601698359');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 9, '9786180317848');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 9, '9786180320138');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180327090');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 9, '9781911352709');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 9, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9781909550780');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9781910714324');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9781909550650');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 9, '9786180333190');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 9, '9789601673196');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 9, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 9, '9789609527200');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 9, '9786180322736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 9, '9781547524365');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 9, '9786180313819');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 9, '9789600360455');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180320329');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9786180319774');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 4, 10, '9786180320787');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9781667411767');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9789601645322');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9786180324112');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180322675');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9789600368352');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180313321');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9788873047476');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 10, '9781911352709');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9781908362391');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9786180324143');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789600360677');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789605723316');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9786180323887');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 10, '9789605723736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 10, '9786180319934');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9781507198025');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9786180329278');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9786180326376');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 10, '9786180324440');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9786180322736');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9786180317695');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180332421');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9781071526521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9781071532997');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 10, '9789601657660');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180702408');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9789601659541');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9781071599594');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9786180326550');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9789600353990');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9789601651750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180324129');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 10, '9781547510740');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9789605725556');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 10, '9789600368338');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 10, '9786180328134');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180317879');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 10, '9789601645032');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9789601655581');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789601666587');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9785043797230');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 2, 10, '9789605721664');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180319750');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 10, '9786180314694');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9781547574667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9789600359831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9789601698359');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180325539');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9781987904215');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9786180317589');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 10, '9785041512521');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 0, 10, '9789601667744');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9786180326970');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9786180329094');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9789609527101');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9786180321005');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9786180317794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789600367843');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 10, '9786180314687');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9789605723699');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9786180329087');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180317831');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9786180325560');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9789600367645');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9786180317602');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9786180322293');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9789601647500');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789605665951');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789601647883');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 2, 10, '9788873042204');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 3, 10, '9785041658434');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 10, '9781912322961');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9789609412797');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9786180329667');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180317770');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789600361223');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9789605720285');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 2, 10, '9789605721794');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 3, 10, '9789600354713');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (3, 1, 10, '9786180337389');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180322651');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9786180322668');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9786180324075');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9781632913234');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9786180336108');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9789601656052');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 1, 10, '9789605720575');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9789600368345');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9789600360226');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (5, 0, 10, '9781912322046');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 1, 10, '9786180328257');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 1, 10, '9786180320800');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (4, 0, 10, '9786180324082');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9789601657844');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9786180332438');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (1, 0, 10, '9789601685427');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 0, 10, '9781667432564');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book
# ------------------------------------------------------------

INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781005226350',
    'Ζάκ Σκατομάτης',
    'Christophe NOËL',
    18,
    'Μια όμορφη ιστορία αγάπης που τελειώνει άσχημα. Συναντιούνται, αγαπούν ο ένας τον άλλον, ζουν ευτυχισμένοι με τα 10 παιδιά τους. Και μετά μια μέρα ... ο ήρωας μας πέφτει από τον Χαρύβδη στη Σκύλλα. Γαλλικός Τίτλος : Jacques Merdeuil Μετάφραση : Χ. Βολιώτης',
    'http://books.google.com/books/content?id=oy8EEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DUT',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781071510032',
    'Κάπου στον κόσμο',
    'Babelcube Inc.',
    46,
    'Ο Φελίπε είναι ένα αγόρι από την Ισημερινή Γουινέα, ο οποίος είναι πεπεισμένος ότι κάπου στον κόσμο θα βρει την ευτυχία που θέλει, αντιμετωπίζοντας μόνος του και με δυσκολία ορισμένες προκλήσεις που θα προσπαθήσουν να παρεμποδίσουν την πρόοδό του.',
    'http://books.google.com/books/content?id=KhyyDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781071523902',
    'Στα σκοτεινά και βαθειά',
    'Babelcube Inc.',
    35,
    'Ήταν το πρώτο θαλασσινό ταξίδι του Μπίλυ Μάκ Τάβις. Είχε μπαρκάρει για να υπηρετήσει στην συνοδεία πλοίων της Θίστλ μιας Καναδικής Βασιλικής Ναυτικής κορβέττας. Μέσω μιας επίθεσης υποβρυχίου και βομβαρδισμού της Λουφτφάβε, Ο Μπίλυ νόμιζε ότι είχε δεί όλο τον τρόμο που έδεινε ο Ατλαντικός σε έναν νέο Καναδό ναύτη. Αλλά ο Μεγάλος Τζίμι Νόναν είχε άλλα σχέδια...',
    'http://books.google.com/books/content?id=2mHIDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781071526521',
    'Η Νεκρή Συγγραφέας',
    'Babelcube Inc.',
    104,
    'Η Άννα είναι μια συγγραφέας μέσης ηλικίας που μεγάλωσε την κόρη της μόνη της. Στο σήμερα, η Μπέρτα έχει μεγαλώσει και η επιθυμία που είχε να γνωρίσει τον πατέρα της, τον οποίο έχει δει μόνο σε φωτογραφία, φουντώνει όταν η σχέση με το αγόρι της περνάει κρίση. Ο Χανς δουλεύει σε ένα εργοστάσιο και έχει μια αδερφή, την Κλάρα, μια έφηβη την οποία δεν καταλαβαίνει κανείς και η οποία έχει εμμονή με έναν τύπο που οδηγεί μια κίτρινη μηχανή. Αλλά είναι, κυρίως, η ιστορία της Άννα Φλίντερ, που όταν επιλέγει να γράψει ένα βιβλίο με αυτοβιογραφικό χαρακτήρα, η έμπνευση την επισκέπτεται παίρνοντας τη μορφή του άντρα που πριν χρόνια εγκατέλειψε. «Στην ιστορία παρατηρείται η διαδικασία δημιουργίας της διανοούμενης. Είναι ένα έργο που απευθύνεται σε όσους αρέσει να διαβάζουν και αφήνονται να απορροφηθούν α&pi',
    'http://books.google.com/books/content?id=I_fPDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'AFR',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781071526767',
    'Γεννημένος για να επιβιώνει',
    'Babelcube Inc.',
    60,
    'Συνέβει μόλις χτές ή ίσως προχτές. Οι βόμβες είχαν πέσει. Κανείς δεν ήξερε το γιατί. Ίσως μια πολιτική μελέτη είχε ληφθεί σοβαρά υπόψιν. Ίσως είχε γίνει μια συμφωνία έρευνας. Ένα νέο σχέδιο να τονωθεί το χρηματιστήριο. Όποιος κι αν ήταν ο λόγος, είχε αναμφίβολα γίνει μια επισταμένη έρευνα και είχαν ληφθεί υπόψιν όλες οι απόψεις. Η πρόταση σίγουρα είχε περάσει απο το συμβούλιο μια η δυο φορές. Πάνω απ όλα έρχονταν εκλογές. Εκείνοι μπήκαν μπροστά και το έκαναν. Κάθε ίχνος πολιτισμού είχε χαθεί, είχαν σωθεί μόνο κάποια ίχνη οστράκων στα όρια της ύπαρξης. Μπορούμε να πούμε ότι επιβίωναν τα Θαλασσινά...',
    'http://books.google.com/books/content?id=U_fPDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781071532997',
    'ΜΟΝΗ με τον Κύριο Ντάρσι',
    'Babelcube Inc.',
    181,
    'Η Ελίζαμπεθ Μπέννετ δεν μπορεί να φανταστεί τίποτα χειρότερο από το να αποκλειστεί από μια χιονοθύελλα σε μια μικρή αγροικία με τον περήφανο και δυσάρεστο Κύριο Ντάρσι. Αλλά έχοντας παγιδευτεί εκεί για μέρες, με έναν τραυματισμένο Κύριο Ντάρσι, τουλάχιστον αυτός μπορέι να ανάβει φωτιά για να μην παγώσουν. Αλλά όταν βάζει τα χέρια του γύρω της, ανακαλύπτει ότι το τζάκι δεν είναι το μόνο μέρος που ξέρει πώς να ανάβει φωτιά. Δεν πιστεύει τις υποσχέσεις του ότι θα την παντρευτεί αν κάποιος ανακαλύψει ότι ήταν μαζί. Όταν οι φόβοι της επιβεβαιώθηκαν και η φήμη της καταρρακώθηκε, δεν εκπλήσσετε που ανακαλύπτει ότι ο Κύριος Ντάρσι εξαφανίστηκε, αφήνοντάς την χωρίς άλλη επιλογή από το να βρει ένα σύζυγο το συντομότερο πριν η οικογένειά της καταστραφεί. Ακόμα κι αν δεν μπορεί να σταματήσει να τον &',
    'http://books.google.com/books/content?id=Rp3YDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781387567997',
    'Acapulco',
    'Lulu.com',
    284,
    'Ο Άλκης είναι ένας ξεναγός που έχει μείνει άνεργος και αποφασίζει να βρει την τύχη του σε ένα απομακρυσμένο θέρετρο της Αγγλίας. Έχει αφήσει πίσω του δυο οικογένειες, μια στην Ελλάδα με δυο παιδιά κι άλλη μια στο Βέλγιο με ένα ακόμα. Η τυχοδιωκτική του φύση τον αποτρέπει από το να βρίσκεται εγκιβωτισμένος σε ένα γάμο αλλά του δημιουργεί παράλληλα ενοχές για τα παιδιά του.',
    'http://books.google.com/books/content?id=tm5LDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781632913234',
    'Μια Αναζήτηση για Ήρωες (Βιβλίο #1 από την σειρά Το Δακτυλίδι του Μάγου)',
    'Morgan Rice',
    300,
    'Το #1 Μπεστ Σέλερ! Από την Μόργκαν Ράις, την #1 συγγραφέα σε μπεστ σέλερ επιτυχίες έρχεται τώρα μια εκπληκτική σειρά φαντασίας. Το «ΜΙΑ ΑΝΑΖΗΤΗΣΗ ΓΙΑ ΗΡΩΕΣ» (ΒΙΒΛΙΟ #1 ΣΤΗΝ ΣΕΙΡΑ ΤΟ ΔΑΚΤΥΛΙΔΙ ΤΟΥ ΜΑΓΟΥ) περιστρέφεται γύρω από την επική ιστορία ενός ξεχωριστού 14χρονου αγοριού από ένα μικρό χωριό στα περίχωρα του Βασιλείου του Δακτυλιδιού. Ο Θόργκριν είναι ο πιο μικρός από τέσσερα αγόρια και ο λιγότερο αγαπητός του πατέρα του. Τα αδέλφια του τον μισούν, όμως ο Θοργκριν αισθάνεται ότι είναι διαφορετικός από τους άλλους. Ονειρεύεται να γίνει σπουδαίος πολεμιστής, να μπει στην ομάδα των αντρών του Βασιλιά και να προστατέψει το Δακτυλίδι από τις ορδές των πλασμάτων που βρίσκονται στην άλλη πλευρά του Φαραγγιού. Όταν φτάνει στην κατάλληλη ηλικία, ο πατέρας του δεν του επιτρέπει να προσπαθήσει να μπει στην Λεγεώνα του Βασιλιά, αλλά εκείνος αρνείται να υπακούσει στην απαγόρευσή του. Φεύγει μόνος του, αλλά αποφασισμένος να μπει απρόσκλητος στην Αυλή του Βασιλιά και να τους κάνει να τον πάρουν στα σοβαρά. Αλλά η Αυλή του Βασιλιά είναι γεμάτη με τα δικά της οικογενειακά δράματα, αγώνες για την εξουσία, φιλοδοξίες, ζήλια, βία και προδοσία. Ο Βασιλιάς ΜακΓκιλ πρέπει να επιλέξει τον διάδοχό του ανάμεσα στα παιδιά του, ενώ το αρχαίο Σπαθί της Δυναστείας, η πηγή όλης της δύναμης, παραμένει ανέγγιχτο περιμένοντας την άφιξη του Εκλεκτού. Ο Θόργκριν φτάνει απρόσκλητος και δίνει μάχη για να γίνει αποδεκτός και να μπει στην Λεγεώνα του Βασιλιά. Ο Θόργκριν σιγά σιγά μαθαίνει ότι έχει μυστηριώδες δυνάμεις που δεν μπορεί να καταλάβει, ενώ ταυτόχρονα βλέπει ότι έχει ένα ξεχωριστό χάρισμα και ένα ξεχωριστό πεπρωμένο. Ενάντια σε κάθε πιθανότητα, ερωτεύεται την κόρη του Βασιλιά, αλλά τη στιγμή που η σχέση τους αρχίζει να ανθίζει, ο Θορ ανακαλύπτει ότι έχει ισχυρούς αντίζηλους. Καθώς αγωνίζεται να καταλάβει τις δυνάμεις του, ο μάγος του βασιλιά τον παίρνει υπό την προστασία του και του λέει για την μητέρα του που δεν είχε γνωρίσει ποτέ. Του λέει ότι η μητέρα του ζει σε ένα τόπο πολύ μακριά, πέρα από το Φαράγγι, πιο πέρα ακόμα κι’ από την χώρα των Δράκων. Πριν ο Θόργκριν τολμήσει να κάνει το βήμα για να γίνει ο πολεμιστής που λαχταράει να γίνει, πρέπει να συμπληρώσει την εκπαίδευσή του. Όμως αυτή σταματάει απότομα αφού βρίσκεται μπλεγμένος σε βασιλικές συνωμοσίες και αντι-συνωμοσίες που απειλούν την αγάπη του και απειλούν να τον καταστρέψουν – καθώς και ολόκληρο το βασίλειο μαζί του. Με το εκλεπτυσμένο λεξιλόγιό της και τους ξεχωριστούς ήρωές της, η ιστορία “ΜΙΑ ΑΝΑΖΗΤΗΣΗ ΓΙΑ ΗΡΩΕΣ” είναι μια επική ιστορία με φίλους και εραστές, με αντιπάλους και μνηστήρες, με ιππότες και δράκους, με ίντριγκες και πολιτικές μηχανορραφίες, με ιστορίες ενηλικίωσης, ραγισμένες καρδιές, εξαπάτηση, φιλοδοξία και προδοσία. Είναι μια ιστορία τιμής και θάρρους, μοίρας και πεπρωμένου, αλλά και μαγείας. Είναι μια ιστορία φαντασίας που μας μεταφέρει σ’ ένα κόσμο που δεν πρόκειται να ξεχάσουμε ποτέ. Μια ιστορία που γοητεύει ανθρώπους όλων των φύλων και ηλικιών. Στην Ελληνική γλώσσα είναι περίπου 90.000 λέξεις. Τα βιβλία #3--#17 της σειράς είναι επίσης διαθέσιμα Books #3--#17 in the series are now also available! “Μια απολαυστική ιστορία επικής φαντασίας.” —Kirkus Reviews “Η αρχή για κάτι πολύ σημαντικό βρίσκεται εδώ.” --San Francisco Book Review “Γεμάτο Δράση …. Ο τρόπος που γράφει η Ράις είναι εμπεριστατωμένος και η βάση της ιστορίας εξαιρετικά ενδιαφέρουσα.” --Publishers Weekly “Μια συναρπαστική ιστορία φαντασίας …. Αυτή είναι μόνο η αρχή μιας πολλά υποσχόμενης επικής σειρά για νεαρούς ενήλικες.” --Midwest Book Review',
    'http://books.google.com/books/content?id=rsuqCQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781667405148',
    'Ο Βρόμικος Πρίγκηπας',
    'Babelcube Inc.',
    98,
    'Φιν Έπιασα μια γυναικεία σιλουέτα με την άκρη του ματιού μου όταν διεκπεραίωνα μια εκτέλεση. Θα μπορούσε να ήταν κατάσκοπος, οπότε δεν είχα άλλη επιλογή από το να την ακολουθήσω. Όταν τη στρίμωξα σ’ ένα εγκαταλειμμένο σπίτι, κατάλαβα ότι έπρεπε να την κάνω δικιά μου. Άνια Προσπαθώ απλά να επιβιώσω μέσα σ’ αυτόν τον καταραμένο πόλεμο. Όταν άκουσα αντρικές φωνές στην περιοχή δεν μπόρεσα να συγκρατήσω την περιέργειά μου. Ο ήχος των πυροβολισμών με ξαπόστειλε πίσω στο στρατόπεδό μου. Δεν περίμενα να με ακολουθήσουν. Και τώρα αυτός ο όμορφος ξένος απαιτεί να τον ακολουθήσω. Λέει ότι ο μόνος τρόπος να με σώσει είναι να φυτέψει ένα παιδί μέσα μου. Δεν έχω ξαναπάει με άντρα, μα όταν με καρφώνει με τα πεινασμένα μάτια του είναι δύσκολο να αρνηθώ. Και δε με χαλάει ότι είναι ένας όμορφος πρίγκηπας.',
    'http://books.google.com/books/content?id=24o9EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781667407227',
    'Χαμηλά σύννεφα',
    'Babelcube Inc.',
    337,
    'Η Γαβριέλα είναι μια ηθοποιός που, όταν η καριέρα της φτάνει στο τέλος της, πραγματοποιεί ένα ταξίδι στην πόλη όπου πέρασε την εφηβεία της. Η ξαφνική επίσκεψή της αιφνιδιάζει δυο από τις φίλες της, που βλέπουν σε εκείνη ένα είδος διαφυγής από πολλές γκρι και μονότονες ημέρες. Επίσης η ηθοποιός μπορεί να διαισθανθεί μέσω εκείνων τη ζωή που θα μπορούσε να είχε. Αντί αυτού, το βάρος της φήμης την καταδιώκει εδώ και σαράντα χρόνια και μόνο ένα πράγμα μοιάζει προφανές: αυτό το ταξίδι ξυπνάει παλιά πάθη και αναστατώνει τις ζωές όλων όσων επισκέπτεται. Η Νούρια Ανιό μας παρουσιάζει ένα κομμάτι πραγματικής ζωής, διαμελισμένο με το φίνο νυστέρι της γραφής της. Η νουβέλα είναι πολύ ενδιαφέρουσα και αποτελεί μια από τις μεγάλες υποσχέσεις της σύγχρονης καταλανικής αφήγησης.—LUll crític',
    'http://books.google.com/books/content?id=YoY9EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781667432564',
    'Πάγος και Φωτιά',
    'Babelcube Inc.',
    62,
    'Μια Ιστορία για Ρουμπίνια, Σκιές και Έρωτα Όταν οι μεταλλωρύχοι του Βασιλιά ανακαλύπτουν ένα περίεργο ρουμπίνι γεμάτο φωτιά, βαθιά κάτω από το βουνό, ο Βασιλιάς είναι κατενθουσιασμένος. Μόνο που υπάρχει ένα πρόβλημα. Το πετράδι ανήκει στις σκιές που ζουν στο ορυχείο. Ο Βασιλιάς, ωστόσο, θα κάνει τα πάντα για να πάρει στα άπληστα χέρια του το ρουμπίνι, ακόμη κι αν αυτό σημαίνει την καταστροφή του βασιλείου. Ο γιος του αρχιμεταλλωρύχου, ο Πίτερ Σνόου, αναγκάζεται να σώσει την κατάσταση. Το Πάγος και Φωτιά είναι ένα διήγημα περίπου 5.200 λέξεων, αποτελούμενο από μία ευέξαπτη πριγκίπισσα, μία υπερβολικά σοφή μαγείρισσα και κάμποσα βατράχια στην τάφρο.',
    'http://books.google.com/books/content?id=0D92EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781908362391',
    'Ο Χυμικός Γάμος του Christian Rosenkreutz',
    'AKAKIA Publications',
    181,
    'Το έργο Ο Χυμικός Γάμος του Christian Rosenkreutz (Κρίστιαν Ρόζενκροιτς / Χριστιανού Ροδόσταυρου) εκδόθηκε για πρώτη φορά στη Γερμανική γλώσσα στο Στρασβούργο το έτος 1616. Λέγεται όμως, ότι προϋπήρχε σαν χειρόγραφο από το 1459. Μεταφράστηκε για πρώτη φορά στα Αγγλικά το 1690 από τον Ε. Foxcroft. Η παρούσα Ελληνική έκδοση είναι μία δύσκολη πρωτοβουλία των Εκδόσεων AKAKIA και προκύπτει από την, κατά το δυνατόν ακριβέστερη, μετάφραση στα Ελληνικά ολόκληρου του κειμένου της πρωτότυπης έκδοσης του Foxcroft του 1690. Ο Χυμικός Γάμος του Christian Rosenkreutz, εκδόθηκε το 1616 στο Στρασβούργο και η ανώνυμη συγγραφή του, αποδίδεται στον Johannes Valentinus Andreae, τότε δεκαεφτάχρονο φοιτητή, μεγάλο μελετητή της Φιλοσοφίας και του Χριστιανισμού, και αργότερα Λουθηρανό Ιερέα. Πρόκεται για το τρίτο κατά σειρά των πρωτύπων έργων της μυστηριώδους «Αδελφότητος του Ρόδου και του Σταυρού», των λεγόμενων Ροδοσταύρων. Τα δύο πρώτα είχαν τη μορφή μανιφέστου, ενώ το παρόν πρόκειται για ένα αλληγορικό ρομάντζο που χωρίζεται σε Επτά Ημέρες, ή Επτά Ταξίδια, όπως η Γένεση, και μας αφηγείται τον τρόπο όπου ο Christian Rosenkreutz προσεκλήθη να επισκεφθεί ένα μυστήριο κάστρο γεμάτο θαύματα, με σκοπό να βοηθήσει στον Χυμικό Γάμο του Βασιλέως και της Βασιλίσσης, δηλαδή, του Γαμπρού και της Νύφης.',
    'http://books.google.com/books/content?id=7La0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550018',
    'Το Ξέσκοτο',
    'AKAKIA Publications',
    57,
    'Όταν ο κόσμος είναι παντού φωτεινός, λαμπρός, γεμάτος αγάπη και ευτυχία, παράδεισο και αλήθεια, κάποιοι διαλέγουν να κρυφτούν στο σκοτάδι, να κυλιστούν στο βούρκο, να γίνουν τέρατα που θα τρομάζουν το φως και θα καταβροχθίζουν αδύναμες συνειδήσεις. Κάποιοι επιλέγουν να βρουν το μόνο σκοτεινό μέρος της ψυχής τους και να κατοικήσουν εκεί για πάντα, μαζί με τη ματωμένη τους συγγνώμη, που ποτέ και σε κανέναν δε χάρισαν. Επιλέγουν το Ξέσκοτο. ΑΠΑΓΟΡΕΥΕΤΑΙ ΑΥΣΤΗΡΑ η ανάγνωση αυτού του βιβλίου από άτομα με καρδιαγγειακές ή ψυχιατρικές παθήσεις, άσθμα, έλκος ή εγκύους γυναίκες, και γενικά, από άτομα με ευαισθησία. Αν αισθανθείτε αδιαθεσία, τρέμουλο, ταχυκαρδία, πόνο στο στήθος, ναυτία, έντονο πόνο στο κεφάλι και στα μάτια, τάσεις προς λιποθυμία ή διαπιστώστε αιμορραγία, σημαίνει πως είστε σε καλό δρόμο!',
    'http://books.google.com/books/content?id=2vq0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550032',
    'Ο Χυμικός Γάμος του Christian Rosenkreutz',
    'AKAKIA Publications',
    105,
    'Το έργο Ο Χυμικός Γάμος του Christian Rosenkreutz (Κρίστιαν Ρόζενκροιτς / Χριστιανού Ροδόσταυρου) εκδόθηκε για πρώτη φορά στη Γερμανική γλώσσα στο Στρασβούργο το έτος 1616. Λέγεται όμως, ότι προϋπήρχε σαν χειρόγραφο από το 1459. Μεταφράστηκε για πρώτη φορά στα Αγγλικά το 1690 από τον Ε. Foxcroft. Η παρούσα Ελληνική έκδοση είναι μία δύσκολη πρωτοβουλία των Εκδόσεων AKAKIA και προκύπτει από την, κατά το δυνατόν ακριβέστερη, μετάφραση στα Ελληνικά ολόκληρου του κειμένου της πρωτότυπης έκδοσης του Foxcroft του 1690. Ο Χυμικός Γάμος του Christian Rosenkreutz, εκδόθηκε το 1616 στο Στρασβούργο και η ανώνυμη συγγραφή του, αποδίδεται στον Johannes Valentinus Andreae, τότε δεκαεφτάχρονο φοιτητή, μεγάλο μελετητή της Φιλοσοφίας και του Χριστιανισμού, και αργότερα Λουθηρανό Ιερέα. Πρόκεται για το τρίτο κατά σειρά των πρωτύπων έργων της μυστηριώδους «Αδελφότητος του Ρόδου και του Σταυρού», των λεγόμενων Ροδοσταύρων. Τα δύο πρώτα είχαν τη μορφή μανιφέστου, ενώ το παρόν πρόκειται για ένα αλληγορικό ρομάντζο που χωρίζεται σε Επτά Ημέρες, ή Επτά Ταξίδια, όπως η Γένεση, και μας αφηγείται τον τρόπο όπου ο Christian Rosenkreutz προσεκλήθη να επισκεφθεί ένα μυστήριο κάστρο γεμάτο θαύματα, με σκοπό να βοηθήσει στον Χυμικό Γάμο του Βασιλέως και της Βασιλίσσης, δηλαδή, του Γαμπρού και της Νύφης.',
    'http://books.google.com/books/content?id=qsW0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    1.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550360',
    'Αέρα Θέλει η Πουτανιά',
    'AKAKIA Publications',
    211,
    'Μέσα στον χώρο των πόλεων και του σύγχρονου πολιτισμού που δημιούργησε ο άνθρωπος, οργάνωσε και τις λειτουργικές εκφράσεις και συμπεριφορές του. Όχι μόνο στη συγκρότηση της οικογένειας, του κράτους και της θρησκευτικότητας αλλά και πέρα απο αυτά, στον χώρο της διασκέδασης και της ζωής στη νύχτα, έξω απο σωστό και νόμιμο, εκεί όπου επικρατεί ο νόμος των club και των σύγχρονων μέσων διασκέδασης. Εκεί όπου συναντώνται η πορνεία με την αλητεία, ο ξεπεσμός, η εμπορία σάρκας και συνειδήσεων, αλλά και η αξία των δήθεν ευϋπόληπτων προσώπων της κοινωνίας μας. Εκεί όπου οι διαφορές δεν λύνονται με υπογραφές, αλλά με την μαγκιά, την παληκαριά και την χειροδικία. Είναι η άλλη πλευρά της νομιμότητας, είναι οι νύχτες που ο ίδιος ο κόσμος μας δημιούργησε και βιώνει αγκαλιάζοντας τους ανθρώπους της, που αγωνίζονται για το μεροκάματο, και των άλλων, αυτών που για οποιονδήποτε λόγο ακολουθούν μια άλλη πλευρά της ζωής, κρυμμένη πίσω απο τις ψευδαισθήσεις τους. Μια βαθειά τομή στο χώρο της νύχτας, καθώς η έλλειψη ηθών και η κερδοσκοπία, πίσω από την παρανομία και την εκμετάλλευση της ανθρώπινης αξιοπρέπειας αποτελεί τον κανόνα. Στιγμές δυνατές, ρεαλιστικές, όμορφα δοσμένες για μια ανάγνωση που θα θυμάστε!',
    'http://books.google.com/books/content?id=ivi0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550513',
    'Λευκές Σελίδες για Άναρχα Όνειρα',
    'AKAKIA Publications',
    42,
    'Δύο ιστορίες ανθρώπων, εκτυλίσσονται σ’ ένα μικρό νησί των Κυκλάδων, και σαν δυο αληθινά παραμύθια, περιπλέκονται με την φαντασία την ίδια στιγμή που αγωνίζονται να ορθώσουν την ζοφερή τους πραγματικότητα, αφού την αποδεχτούν αρχικά, να παραμερίσουν φόβους και ενοχές και να αγωνιστούν με όλες τους τις δυνάμεις για να την αλλάξουν. Εκείνος αποτυχημένος επιχειρηματίας που μετακόμισε με την οικογένειά του στο νησί και κι εκείνη η δεύτερη Μαρίνα της ιστορίας, η Μαρίνα του νησιού, παλεύει να επιβιώσει και να μεγαλώσει τα παιδιά της στο δύσκολο περιβάλλον της ανέχειας με μόνα όπλα, τις ιδέες της και τη δημιουργική της φαντασία. Κι οι δυο βασανίζονται από αναπάντητα ερωτήματα όμως ψάχνουν για λύσεις, αναβιώνουν τις ελπίδες που έχουν χαθεί και χτίζουν δειλά-δειλά τα όνειρά τους, μέσα στο περιβάλλον της ύφεσης και της στέρησης, χωρίς ενδοιασμούς και με ανατρεπτικές ιδέες. Το τέλος του μυθιστορήματος θα το δώσει ο κάθε αναγνώστης!',
    'http://books.google.com/books/content?id=mL-0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550544',
    'Προπατορικό Αμάρτημα',
    'AKAKIA Publications',
    227,
    'Ο Μάχιμος είναι ένας φοιτητής σε μια πόλη χωρίς όνομα, σε κάποια ασήμαντη κουκίδα της γήινης σφαίρας, σε κάποια γωνιά του πλανήτη χωρίς ακριβείς γεωγραφικές συντεταγμένες. Πλημμυρισμένος από το νεανικό του σφρίγος, γεμάτος από ελπίδα και όραμα για έναν πιο δίκαιο κόσμο, μάχεται ακατάπαυστα εναντίον όλων, απέναντι σε κάθε εχθρό, αόρατο ή ορατό, κόντρα σε οποιονδήποτε στέκεται εμπόδιο στα ιδανικά του και απειλεί να σκοτώσει τα όνειρά του. Κάποια στιγμή όμως, συνειδητοποιεί ότι όλες αυτές οι μάχες δεν είναι παρά μια μάταια κι ανούσια αναζήτηση, μια ανώφελη και αδιέξοδη πορεία, μια τεράστια πλάνη. Συνειδητοποιεί ότι έχει κάνει το μοιραίο λάθος, ότι έχει μπερδέψει τον πραγματικό του εχθρό με κάποιον άλλον. Συνειδητοποιεί ότι κι ο ίδιος δεν είναι τίποτα άλλο παρά ένα γρανάζι του συστήματος που τόσο πολύ απεχθάνεται, τίποτα παραπάνω από ένα ακόμη ανήμπορο πιόνι στην σκακιέρα των ισχυρών. Την ίδια στιγμή, μέσα από την φλόγα του έρωτα και του πάθους, καθώς και μέσα από τις νέες ισορροπίες που φέρνει η αναπάντεχη ανατροπή του πολιτεύματος από τον στρατό, θα γεννηθεί μέσα του κάτι νέο, πρωτόγνωρο και συνταρακτικό. Θα γεννηθεί το Χρέος, αυτό το τρομερό τέρας που δεν χορταίνει ποτέ. Από εδώ και πέρα όλα είναι σαφή και ξεκάθαρα: Το Χρέος θα κατευθύνει πλέον τα βήματα του, σαν τον τυφλό που ο σκύλος καθοδηγεί στην απέναντι πλευρά του δρόμου. Από την άλλη, ένας μεσήλικας άντρας, καθοδηγείται κι αυτός από τον ίδιο σκύλο, ανήμπορος να αντισταθεί στις διαταγές αυτού του αόρατου φίλου ή εχθρού, ανήμπορος να καθορίσει ο ίδιος την μοίρα του. Το Χρέος δεν τον ρωτά, την στιγμή που τον προστάζει να αφαιρέσει την ζωή ενός φαινομενικά αθώου ανθρώπου... Ένας ισχυρός δεσμός τον κρατάει δεμένο με τον Μάχιμο. Οι μοίρες τους, άρρηκτα δεμένες μέχρι κάποια στιγμή, δεν θα ξανανταμώσουν ποτέ. Το Χρέος, θα είναι ο μοναδικός συνδετικός τους κρίκος.....',
    'http://books.google.com/books/content?id=JPu0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550650',
    'Μελιπεριπέτειες ενός Μελισσοκόμου',
    'AKAKIA Publications',
    63,
    'Η ενασχόλησή μου με τη μελισσοκομία είχε ως αποτέλεσμα να βιώσω διάφορες καταστάσεις. Ειδικά τα πρώτα χρόνια που ασχολήθηκα με αυτή ως νέος μελισσοκόμος έζησα διάφορα ευτράπελα αλλά και στιγμές που με συγκίνησαν και έμειναν χαραγμένες στη μνήμη μου. Αποφάσισα, λοιπόν, κάποιες από αυτές να τις μεταφέρω στους αναγνώστες. Επιπλέον, μέσα από αυτές τις αυτοτελείς ιστορίες που περιέχει το βιβλίο θα παρακολουθήσετε την κοπιαστική εργασία που πρέπει να καταβάλει ένας μελισσοκόμος, ώστε να έχει μια καλή παραγωγή μελιού μα και τα τυχόν ρίσκα που καλείται κατά καιρούς να πάρει. Τέλος, γίνεται μια προσπάθεια να παρουσιάσω τον όμορφο κόσμο της μέλισσας και πως μέσω αυτής έζησα μοναδικές στιγμές.',
    'http://books.google.com/books/content?id=rrq0BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'SWE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781909550780',
    'Το Κυνήγι της Ανατολής',
    'AKAKIA Publications',
    112,
    'Στα πανάκριβα σαλέ το Ελβετικών Άλπεων τα μυθικά πάρτυ των ολιγάριθμων μεγιστάνων του χώρου δεν είναι κάτι σπάνιο, όμως πάντα αποτελούν μια πρώτης τάξεως ευκαιρία για επίλυση διαφορών και υπογραφές νέων συμφωνιών. Ο Άσσος ήξερε οτι οι ημίγυμνες καλλονές που περιφέρονται στολισμένες με τα εκθαμβωτικά πετράδια και η σαμπάνια που ρέει ως το πρωί βοηθούν σημαντικά σε αυτό. Παρ ότι είχε αποσυρθεί απο καιρό, γνώριζε καλά την απαστράπτουσα βιτρίνα του σιναφιού, ακόμη καλύτερα όμως την αθέατη, σκοτεινή πλευρά της και σίγουρα δεν σκόπευε να επιστρέψει. Η αναπάντεχη δολοφονία του Ιταλού φίλου του και τα τρομοκρατημένα μάτια της ορφανής κόρης του, ανέτρεψαν όλα τα δεδομένα. Όταν στοχοποιήθηκε και ο ίδιος, το θέμα έγινε προσωπικό. Έπρεπε να βρει το δολοφόνο, αλλά πρώτα από όλα έπρεπε να ανακαλύψει τα ίχνη της χαμένης Ανατολής...',
    'http://books.google.com/books/content?id=t720BgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781910714324',
    'Κρύσταλλοι Ι',
    'AKAKIA Publications',
    394,
    'Οι σειρά «Κρύσταλλοι» θα συνίσταται από μια δεκαλογία η οποία θα ξεκινάει από την δημιουργία του σύμπαντος, θα διαπερνά ολόκληρο τον πανανθρώπινο πολιτισμό, θα φθάνει στο παρόν και θα συνεχίζει στο μέλλον, παρακολουθώντας περιληπτικά την εξέλιξη του ανθρώπινου πολιτισμού.Το πρώτο βιβλίο είναι η «1η Τιτανομαχία: Σύγκρουση Κενού-Υπερκόσμιου (Δημιουργία)» από το οποίο αρχίζει ένα ταξίδι. Ένα ταξίδι που ξεκινάει από την Μεγάλη Έκρηξη, την εξελικτική πορεία του σύμπαντος και φθάνει στη δημιουργία των πλανητικών συστημάτων.Το έργο στο πρώτο βιβλίο ξεκινάει από μια ελληνική επαρχιακή πόλη, όπου ένα ερωτευμένο ζευγάρι ανακαλύπτει ένα αντικείμενο με περίεργες ιδιότητες και ικανότητες. Μελετάτε από την τοπική επιστημονική κοινότητα, αναφέρονται παλιότεροι θρύλοι και παραδόσεις γύρω από αυτό, που μέχρι πρότινος θεωρούνταν μύθοι και παραμύθια.Το αντικείμενο μεταφέρεται στην Αθήνα και μελετάται από την ελληνική επιστημονική κοινότητα. Κατόπιν καλούνται τα ηχηρά ονόματα της διεθνούς επιστημονικής κοινότητας. Βάσει των ιδιοτήτων που έχουν αναδειχθεί, επιχειρείται ένα πείραμα στην Ακρόπολη, με θαυμαστά και μη αναμενόμενα αποτελέσματα. Από εκεί και πέρα αρχίζει μια υπέροχη διαδρομή σε μια σειρά 10 βιβλίων.Μέσα από μύθο, αλληγορίες αλλά και πραγματικές επιστημονικές γνώσεις, επιχειρείτε, πέραν της διασκέδασης, ο αναγνώστης να αποκομίσει και αληθινές γνώσεις. Έτσι, ο αναγνώστης μέσα από μυθιστορηματική αφήγηση μαθαίνει για την δημιουργία και για την εξέλιξη του σύμπαντος, για τους γαλαξίες, για τα ηλιακά συστήματα, για την γη, για τη ζωή πάνω στην γη, για την εξέλιξη του ανθρώπινου είδους, για την φιλοσοφία, για την επιστήμη, για τις θρησκείες και για τον εν γένει αγώνα της ενανθρώπισης του ανθρώπινου είδους, για να φθάσουμε στις σημερινές συγκρούσεις. Τηλεγραφικά τα 10 βιβλία που θα ακολουθήσουν με ενδεικτικές ονομασίες:1η Τιτανομαχία: Σύγκρουση Κενού-Υπερκόσμιου (Δημιουργία) 2η Τιτανομαχία: Σύγκρουση Υπερκόσμιου-Υπερφυσικού (Ουρανομαχία) 3η Τιτανομαχία: Σύγκρουση Φυσικού-Υπερφυσικού (Ζευς-Κρόνος) 4η Τιτανομαχία: Σύγκρουση Φυσικού-Παραφυσικού (Γιγαντομαχία) 5η Τιτανομαχία: Σύγκρουση Φυσικού-Μεταφυσικού (Προμηθειάς) 6η Τιτανομαχία: Σύγκρουση Καλού-Κακού (Λευκός-Μαύρος Κρύσταλλος) 7η Τιτανομαχία: Σύγκρουση Κοινωνικοπολιτικού-Αντικοινωνικοπολιτικού (Πρώτοι πολιτισμοί) 8η Τιτανομαχία: Σύγκρουση Ανθρωπισμού-Τεχνοκρατισμού (Νεότεροι χρόνοι) 9η Τιτανομαχία: Σύγκρουση Πολιτισμού-Βαρβαρότητας (Σήμερα) 10η Τιτανομαχία: Σύγκρουση Γήινων-Εξωγήινων (Διαγαλαξιακά ταξίδια)',
    'http://books.google.com/books/content?id=40wWCgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781911352709',
    'ΚΡΥΣΤΑΛΛΟΙ ΙΙΙ',
    'AKAKIA Publications',
    415,
    'Η σειρά «Κρύσταλλοι» ξεκινάει από τις απαρχές της δημιουργίας του σύμπαντος και διαπερνά ολόκληρο τον πανανθρώπινο πολιτισμό, φθάνει στο παρόν και θα συνεχίσει στο μέλλον, παρακολουθώντας περιληπτικά την εξέλιξη του ανθρώπινου πολιτισμού.Στο πρώτο βιβλίο «1η Τιτανομαχία: Σύγκρουση Κενού-Υπερκόσμιου» (13,85 με 5 δισεκατομμύρια χρόνια πριν) παρακολουθήσαμε την αρχή της μυθιστορηματικής σειράς «Κρύσταλλοι», η οποία ξεκίνησε από μια ελληνική επαρχιακή πόλη στην οποία ανακαλύφθηκε ένα αντικείμενο με υπερβατικές ικανότητες, η μελέτη του οποίου απέδειξε εκπληκτικά αποτελέσματα και με το οποίο ξεκίνησε ένα κοσμικό ταξίδι. Στο κοσμικό αυτό ταξίδι ταξιδέψαμε πίσω στο χρόνο και παρακολουθήσαμε τη δημιουργία του σύμπαντος.Στο δεύτερο βιβλίο «2η Τιτανομαχία: Σύγκρουση Υπερκόσμιου-Υπερφυσικού» (5 δισεκατομμύρια με 50 εκατομμύρια χρόνια πριν) παρακολουθήσαμε μέσα από το κοσμικό ταξίδι τις τιτάνιες δυνάμεις να συμβάλουν στη δημιουργία του γαλαξία μας, του ηλιακού μας συστήματος, στη δημιουργία και στην κατασκευαστική δομή της Γης, στην εμφάνιση της ζωής πάνω στη Γη και στην εξελικτική της πορεία, ενώ ταυτόχρονα παρακολουθούσαμε και τη σύγκρουση των τιτάνιων δυνάμεων με αρχηγό τον Κρόνο με τις υπερκόσμιες δυνάμεις με αρχηγό τον Ουρανό.Στο τρίτο και τέταρτο βιβλίο, «3η Τιτανομαχία: Σύγκρουση Υπερφυσικού-Φυσικού» (50 εκατομμύρια χρόνια με 100 χιλιάδες χρόνια πριν) κυριαρχούν οι Ολύμπιοι θεοί με αρχηγό το Δία. Υπό μορφή επικών μονομαχιών και αγώνων παρουσιάζεται η εξέλιξη της ζωής στον πλανήτη Γη, η κυριαρχία των θηλαστικών και ο φυλογενετικός κλάδος του ανθρώπου. Η εξελικτική πορεία του ανθρώπου φθάνει έως τον Homo sapiens. Ιδιαίτερη έμφαση δίδεται στον “άνθρωπο” και στα εξελικτικά στάδια εξανθρώπισής του, από τα πρωτεύοντα θηλαστικά στους ανθρωπίδες (Hominoidea), στη συνέχεια στους αυστραλοπίθηκους (Australopithecines) και από αυτούς στο γένος “Homo”.Συνεχίζοντας το μαγικό αυτό ταξίδι, μέσα από μύθο, αλληγορίες, αληθινά γεγονότα και πραγματικές επιστημονικές γνώσεις, στα επόμενα βιβλία ο αναγνώστης θα παρακολουθήσει όλον τον πανανθρώπινο πολιτισμό, από τη δημιουργία του σύμπαντος έως και σήμερα.',
    'http://books.google.com/books/content?id=2hNaDgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GUI',
    3.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781912322046',
    'Κρύσταλλοι IV',
    'AKAKIA Publications',
    428,
    'Η σειρά «Κρύσταλλοι» είναι μια μυθιστορηματική σειρά, η οποία ξεκινάει από τις απαρχές της δημιουργίας του σύμπαντος, διαπερνά ολόκληρο τον πανανθρώπινο πολιτισμό, φθάνει στο παρόν και θα συνεχίσει στο μέλλον, παρακολουθώντας περιληπτικά την εξελικτική πορεία του ανθρώπινου πολιτισμού. Στο πρώτο μέρος της Σύγκρουσης Υπερφυσικού – Φυσικού περιηγηθήκαμε την εξελικτική πορεία της ζωής από 50 εκατομμύρια χρόνια με 200 χιλιάδες χρόνια πριν, παρακολουθήσαμε τις πρώτες συγκρούσεις Υπερφυσικού-Φυσικού, την δημιουργία της βαλκανικής χερσονήσου, την κυριαρχία των θηλαστικών, αλλά ακολουθήσαμε το ξεχωριστό φυλογενετικό δέντρο του ανθρώπου. Έγινε μια ευσύνοπτη αναφορά στο μορφωτικό/εκπαιδευτικό σύστημα για την καλλιέργεια των νοημόνων έμβιων όντων στα τρία πνευματικά επίπεδα, στα δέκα «πρόσωπα», στις τρεις επιγνώσεις, στα τέσσερα μονοπάτια και στις πέντε πληγές, που επηρεάζουν άμεσα και έμμεσα τη ζωή τους. Στο δεύτερο μέρος της Σύγκρουσης Υπερφυσικού – Φυσικού, 200 με 100 χιλιάδες χρόνια πριν, παρακολουθούμε την αργόσυρτη μεταλλαγή του Homo sapiens-sapiens, κατά την οποία η ζωή αρ-χίζει να αποκτά πλήρη αυτογνωσία. Γίνεται η τελική δοκιμασία και η ορκωμοσία του Δία ως Πο-λεμιστή του Φωτός, η αναζήτησή του, η ανάληψη της ευθύνης του αγώνα της παλινόρθωσης των Φυσικών Δυνάμεων. Κυριαρχούν οι επικές συγκρούσεις, τιτανομαχίες και μονομαχίες μεταξύ των Τιτάνων και Ολύμπιων Θεών. Η 4η Τιτανομαχία παρακολουθούμε τη μεταστροφή της φύσης στο λογικό, την ενσάρκωση της φύσης με τη ζωή και την εκλογίκευσή της με τον Homo sapiens-sapiens. Είναι το νοήμον έμβιο ον με το οποίο προσπαθεί το σύμπαν να αποκτήσει αυτεπίγνωση και αυτοπραγμάτωση. Έτσι λοιπόν, από την μία παρακολουθούμε τις δυσθεώρητες και ανυπέρβλητες δυσκολίες με τις οποίες ο Λευκός Κρύσταλλος θα φθάσει τελικά στον Όλυμπο στα χέρια του Δία, ενώ από την άλλη την ευκολία με την οποία ο Μαύρος Κρύσταλλος θα φθάσει στην Όθρυ στα χέρια του Κρόνου. Παρακολουθούμε κατ’ ουσία τη διαμάχη του ορθολογικού με το ανορθόλογο και παράλογο και το πέρασμα του ανθρώπου στο λογικό. Πάλεψε ο άνθρωπος στην προσπάθεια της μετάβασης αυτής. Φωτιά πήρε το μυαλό του επί σειρά χιλιάδων ετών, προσπαθώντας να απαντήσει στα τόσο δύσκολα και αναπάντητα ερωτήματά του. Στο τέλος νίκησε, προχώρησε, μα ήταν μια πύρρειος νίκη, αφού διολίσθησε σε μεταφυσικές και υπερφυσικές διαφυγές. Έτσι, το μεταφυσικό και ανορθολογικό υποβόσκει στην καθημερινότητα σε κάθε σκέψη του, και αναδεικνύεται σε κάθε δυσκολία. Για τέτοιας μορφής τιτανομαχίες συνέβησαν μέσα στο ανθρώπινο μυαλό.',
    'http://books.google.com/books/content?id=SoifDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MAO',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781912322640',
    'Κόκκινη θάλασσα',
    'AKAKIA Publications',
    382,
    'Μια θάλασσα που ενώνει. Μια θάλασσα που χωρίζει. Ο πρώτος παγκόσμιος πόλεμος μαίνεται γύρω από την αιώνια θάλασσα. Μια συλλογική μοίρα μοιάζει να αποφάσισε για όλους. Μέσα στο μεγάλο κατρακύλισμα ο λοχαγός Μάριο Ρόσσι θα ακολουθήσει μια αντίστροφη πορεία, και θα συναντηθεί με την ανέγνωρη αλήθεια. Τόσο τη δική του όσο κι ενός κόσμου που αλλάζει γύρω του, κι ο πόλεμος φαντάζει ο μοχλός καταλύτης.',
    'http://books.google.com/books/content?id=aoifDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781912322961',
    'Η βροχή δε σταμάτησε ακόμα',
    'AKAKIA Publications',
    320,
    'Η ψυχική δύναμη, οι δύσκολες συνθήκες διαβίωσης, τα νιάτα και ο έρωτας αλλά και η επιμονή για μια αξιοπρεπή ζωή είναι τα κύρια στοιχεία που χαρακτηρίζουν αυτό το το μυθιστόρημα που περιστρέφεται γύρω από την προσπάθεια της Λώρας , μιας νεαρής φοιτήτριας χωρίς οικογενειακή και οικονομική στήριξη, να πραγματοποιήσει τα όνειρά της. Όταν ο έρωτας της κτυπά την πόρτα με τη μορφή του Φρανσουά, ενός πάμπλουτου Γάλλου φοιτητή, που μπορεί να της προσφέρει μια παραμυθένια ζωή, μια εσωτερική πάλη αρχίζει. Ανεξάρτητη και δυναμική, απορρίπτει κοινωνικά εμπόδια που βάζει η οικογένειά του και νιώθει την αγάπη που της προσφέρει σαν παγίδα που εκμηδενίζει την προσωπικότητά της. Μέσα από μια δεμένη πλοκή που διαδραματίζεται στην Αγγλία, στη Γαλλία, στην Ισπανία και στην Κύπρο και μέσα από εικόνες που ζωντανεύουν μπροστά στα μάτια του αναγνώστη, οι δύο κεντρικοί ήρωες καλούνται να πάρουν σημαντικές αποφάσεις ενώ η βροχή δε σταματά όπως και η ζωή. Η τεχνική του διπλού τέλους είναι πρωτοποριακή για την κυπριακή λογοτεχνία και δείχνει την ικανότητα της συγγραφέως να χειριστεί, να πλάσει την πλοκή και να την οδηγήσει σε εναλλακτικούς δρόμους, καθιστώντας το μυθιστόρημα ιδιαίτερα ενδιαφέρον.',
    'http://books.google.com/books/content?id=eoifDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781987904185',
    'ΣΕΜΙΡΑΜΙΣ',
    'AA Publishing',
    240,
    'ΣΕΜΙΡΑΜΙΣ Ένα περιπετειώδες αισθηματικό κοσμοπολίτικο μυθιστόρημα, που απ’ την πρώτη στιγμή συναρπάζει τον αναγνώστη, συμπαρασύροντάς τον σ’ έναν κόσμο λαβυρινθώδη, όπου η δύναμη και ο πλούτος αντιστρατεύονται τον αιώνιο πόθο για την αληθινή ευτυχία. ΑΠΟΣΠΑΣΜΑΤΑ ΤΟΥ ΒΙΒΛΙΟΥ «Γύρισα να του μιλήσω, η σκέψη μου όμως δεν εξωτερικεύτηκε γιατί τα πράσινα μάτια του μού έκαναν νόημα να κοιτάξω κάτω. Η θάλασσα είχε αλλού το χρώμα του σμαραγδιού, αλλού ήταν καταγάλανη, αλλού τουρκουάζ και αλλού γκρι-μπλε. Υπήρχαν λιλιπούτεια νησάκια με πυκνή βλάστηση, κολπίσκοι, όπου κάτασπρα κότερα ήταν αγκυροβολημένα εδώ κι εκεί, λοφίσκοι με πολλά δένδρα ανάμεσα από τα οποία ξεπρόβαλλαν οι κάτασπρες στέγες των σπιτιών, πισίνες και δαντελωτές παραλίες...» «Καθόμασταν σ’ ένα γωνιακό τραπέζι του ρεστοράν στο χείλος της παραλίας. Η θαλασσινή αύρα είχε επιδεινωθεί. Ο αέρας, ερχόμενος από τον Ειρηνικό ωκεανό, έσβηνε τη φλόγα που αν και προστατευμένη μέσα στο γυάλινο κηροπήγιο, υπέκυπτε συνεχώς στην παιχνιδιάρικη διάθεσή του. Η ζοφερή όμως νύχτα φωτιζόταν από ένα ολοστρόγγυλο φεγγάρι, που πρόβαλε πέρα μακριά από τις βόρειες ακτές της Αυστραλίας. Ένοιωθα μουδιασμένη από αληθινή ευτυχία. Ήταν μία φευγαλέα ευτυχία, που όταν η σελήνη θα ολοκλήρωνε την τροχιά της, θα με απαρνιόταν. Ο Ρούντολφ θα έφευγε μακριά, θα επέστρεφε στην Ευρώπη…» «Κατεβήκαμε τα μαρμάρινα σκαλοπάτια της βεράντας και καθίσαμε κοντά στο νερό. Ήταν το αγαπημένο μου μέρος. Οι απόκρημνες βουνοπλαγιές καθρεπτίζονταν στη γαληνεμένη λίμνη, που είχε αποκτήσει την απόχρωση του σμαραγδιού από την αρμονία των χρωμάτων της βαθυπράσινης φύσης και του γαλάζιου ουρανού. Ένα βαπορέτο με την αυστριακή σημαία ν’ ανεμίζει στην πρύμνη, έκανε το γύρο της λίμνης σταθμεύοντας σε κάθε χωριουδάκι…» «Τουλίπες, κρίνοι και ιβίσκοι ήταν φυτεμένοι και βαθιά μέσα από τα φυλλώματα μιας φουντωτής ελιάς, διέκρινα το λευκό πανί ενός ιστιοφόρου, που έμπαινε στον κολπίσκο του Πορτοφίνο. Δύο απόκρημνοι λόφοι τον προφύλαγαν, πνιγμένοι στα πεύκα και στα κυπαρίσσια, όπου τα κύματα έσκαγαν πάνω στα βράχια σχηματίζοντας μία άσπρη δαντελωτή γραμμή….»',
    'http://books.google.com/books/content?id=a9R0DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9781987904215',
    'ΡΩΜΗ',
    'AA Publishing',
    214,
    'ΡΩΜΗ, ΤΟ ΠΟΡΤΡΕΤΟ ΕΝΟΣ ΑΓΝΩΣΤΟΥ «Ένα μυθιστόρημα για όσους αγαπούν την Αιώνια Πόλη» Η Αμέλια, συγγραφέας ρομαντικών μυθιστορημάτων, βρίσκεται στη Ρώμη για να βρει υλικό για το νέο της βιβλίο, εμπνευσμένη από τη μακραίωνη ιστορία της πόλης. Τα σχέδια για το βιβλίο αλλάζουν, όταν μία Ρωμαία φίλη της, την ωθεί να γράψει την ιστορία του άνδρα της, Κλαύδιου. Εκείνη δέχεται, αλλά πολύ σύντομα συνειδητοποιεί ότι έχει εισέλθει σ’ ένα παιχνίδι που είναι ιδιαίτερα απρόβλεπτο. Γοητεύεται ολοένα και περισσότερο από την προσωπικότητα αυτού του αγνώστου άνδρα και αρχίζει σιγά-σιγά να αναμιγνύει την πραγματικότητα με την ψευδαίσθηση. Μοιραία, κάποια στιγμή συγγραφέας και ήρωας συναντιούνται… ΑΠΟΣΠΑΣΜΑΤΑ ΤΟΥ ΒΙΒΛΙΟΥ «Πήγε στο παράθυρο για να θαυμάσει το ηλιοβασίλεμα. Tο τοπίο μεταμορφωνόταν σιγά-σιγά, τα χρώματα γίνονταν βαθύτερα και η υγρασία άρχιζε να θολώνει την ατμόσφαιρα. Πέρα, στο βάθος του ορίζοντα, η Pώμη ετοιμαζόταν να υποδεχτεί τη νύχτα, φορτωμένη με τα βαριά μνημεία της, με τους ήχους, και με τα αυτοκίνητα που διέσχιζαν ακατάπαυστα τις γέφυρές της. Tριγύρω οι λόφοι, δεμένοι με τους μύθους από τα βάθη της ιστορίας της, συμπλήρωναν την ειδυλλιακή αυτή εικόνα…» «Tο ανεπαίσθητο κυμάτισμα των κορυφογραμμών οδήγησε το βλέμμα της στο βάθος του ορίζοντα, εκεί όπου το βαθύ πράσινο της γης ενωνόταν με το απέραντο γαλάζιο του ουρανού και ο τρούλος του Aγίου Πέτρου διακρινόταν αρκετά καθαρά. Για δες, είπε μέσα της χαρούμενα, είμαστε μόλις δύο βήματα από τη Pώμη και υπάρχουν πρόβατα τριγύρω...»',
    'http://books.google.com/books/content?id=VnWODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9783966103473',
    'Η Περιπέτεια Της Μικρής Νεραϊδας',
    'Bookamvilia',
    24,
    'Η Μαρία Βαρσάμη – Καρακίτσιου μένοντας πλέον κοντά στη φύση και αγαπώντας πάντα τα παραμύθια, ξεκίνησε να γράφει τις πρώτες ιστορίες για παιδιά εμπνευσμένες από τα ζωάκια της φύσης. Το παιδικό παραμύθι Η περιπέτεια της μικρής νεράϊδας είναι μια συγκινητική ιστορία με αίσιο τέλος που θα λατρέψουν μικροί και μεγάλοι.',
    'http://books.google.com/books/content?id=5im4DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9785041512521',
    'Κριτήριο Λάιμπνιτς',
    'Litres',
    1043,
    'Μια τυχαία επιστημονική ανακάλυψη είναι η αρχή μίας συγκλονιστικής περιπέτειας, που ξεκινά στα όρια της επιστήμης και απειλεί να τα ξεπεράσει. Οι πρωταγωνιστές βρίσκονται σε πρωτόγνωρες και απρόσμενες διαδρομές αντιμετωπίζοντας καταστάσεις πέραν των συνηθισμένων. Αυτή η περιπέτεια της επιστήμης και της τεχνολογίας γίνεται, επίσης, εσωτερική περιπέτεια για ορισμένους από αυτούς, οι οποίοι ανακαλύπτουν, άγνωστες ως τότε, πτυχές της ιδιωτικής τους ζωής και της σεξουαλικότητάς τους. Μέσα από μία αλληλουχία, πλούσια σε συναρπαστικά γεγονότα και ανατροπές, η ιστορία εμπλέκει τον αναγνώστη και τον κρατά σε αγωνία από την αρχή ως το τέλος.',
    'http://books.google.com/books/content?id=lzqEDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9785041658434',
    'Ο Χορός Του Φεγγαριού',
    'Litres',
    258,
    'Η Ζωή της Ένβι ήταν τέλεια. Είχε έναν υπέροχο αδερφό. έναν υπέροχο σύντροφο και την καλύτερη δουλειά που θα μπορούσε να ζητήσει μία κοπέλα...σύχναζε στα πιο πολυσύχναστα κλαμπς της πόλης. Όλα ήταν τέλεια, μέχρι τη στιγμή που της τηλεφώνησε ένας από τους καλύτερους της φίλους, για να της πει ότι το αγόρι της χόρευε κατακόρυφο λίμπο στην πίστα του Μούνντανς. Η απόφασή της να πάει να τον βρει πυροδοτεί μία σειρά από γεγονότα, που θα την αναγκάσουν να γνωρίσει έναν παράλληλο μεταφυσικό κόσμο, καλά κρυμμένο πίσω από την ανιαρή πραγματικότητα. Έναν κόσμο στον οποίον οι άνθρωποι μπορούν να μεταμορφωθούν σε ιαγουάρους, πραγματικά βαμπίρ που τριγυρνούν στους δρόμους και έκπτωτους αγγέλους που περπατούν ανάμεσά μας. Ο Ντέβον είναι ένας ανθρωπόμορφος ιαγουάρος, που ζει στα άκρα, και ένας από τους δύο ιδιοκτήτες του Μούνντανς. Η ζωή του κλονίζεται μία νύχτα, όταν στην πίστα του κλαμπ του παρατηρεί τον αισθησιακό χορό μίας φλογερής αλλά κυνικής κοκκινομάλλας.Η Ζωή της Ένβι ήταν τέλεια. Είχε έναν υπέροχο αδερφό. έναν υπέροχο σύντροφο και την καλύτερη δουλειά που θα μπορούσε να ζητήσει μία κοπέλα...σύχναζε στα πιο πολυσύχναστα κλαμπς της πόλης. Όλα ήταν τέλεια, μέχρι τη στιγμή που της τηλεφώνησε ένας από τους καλύτερους της φίλους, για να της πει ότι το αγόρι της χόρευε κατακόρυφο λίμπο στην πίστα του Μούνντανς. Η απόφασή της να πάει να τον βρει πυροδοτεί μία σειρά από γεγονότα, που θα την αναγκάσουν να γνωρίσει έναν παράλληλο μεταφυσικό κόσμο, καλά κρυμμένο πίσω από την ανιαρή πραγματικότητα. Έναν κόσμο στον οποίον οι άνθρωποι μπορούν να μεταμορφωθούν σε ιαγουάρους, πραγματικά βαμπίρ που τριγυρνούν στους δρόμους και έκπτωτους αγγέλους που περπατούν ανάμεσά μας. Ο Ντέβον είναι ένας ανθρωπόμορφος ιαγουάρος, που ζει στα άκρα, και ένας από τους δύο ιδιοκτήτες του Μούνντανς. Η ζωή του κλονίζεται μία νύχτα, όταν στην πίστα του κλαμπ του παρατηρεί τον αισθησιακό χορό μίας φλογερής αλλά κυνικής κοκκινομάλλας. Με τον πόλεμο των βαμπίρ να μαίνεται γύρω τους ο Ντέβον ορκίζεται ότι αυτήν τη γυναίκα θα... και πολεμά μέχρι θανάτου για να την αποκτήσει.',
    'http://books.google.com/books/content?id=xA2TDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9785043797230',
    'Η Τελευταία Θέση Στο Χίντενμπουργκ',
    'Litres',
    371,
    'Ένα λάθος τηλεφώνημα φέρνει τον Ντόνοβαν στην μπροστινή πόρτα της Σάντια. Εκείνος νόμιζε ότι θα δίδασκε Μπράιγ σε έναν τυφλό, ενώ εκείνη νόμιζε ότι ήταν δικηγόρος αναπηρικών υποθέσεων.Όταν μαθαίνει ο Ντόνοβαν για την άθλια κατάσταση στην οποία βρίσκονται η Σάντια και ο προ-πάππους της, ξεχνά το μάθημα Μπράιγ και άρχισε να ψάχνει τρόπους με τους οποίους θα τη βοηθούσε να ξεπεράσει τα διλήμματα που απειλούσαν να την συνθλίψουν.Translator: Evangelia',
    'http://books.google.com/books/content?id=uRJQEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MAY',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180313826',
    'Το βαμμένο πουλί',
    'Metaichmio Publications',
    328,
    'Μια συγκλονιστική αφήγηση με θέμα την οδύσσεια ενός εξάχρονου αγοριού στην Ανατολική Ευρώπη κατά τη διάρκεια του Β Παγκόσμιου πολέμου. Ένα κλασικό πλέον βιβλίο το οποίο όταν πρωτοεκδόθηκε, το 1965, δίχασε την κριτική, άλλοι το αποθέωσαν και άλλοι κατηγόρησαν το συγγραφέα του ότι περιγράφει υπερβολικά βίαιες σκηνές. Ο Κοζίνσκι υπέφερε για πολλά χρόνια λόγω αυτού του βιβλίου: η έκδοση απαγορεύτηκε στην Πολωνία, τη γενέτειρά του, και η οικογένειά του υπέστη προπηλακισμούς από Ανατολικοευρωπαίους οι οποίοι θεωρούσαν ότι το βιβλίο έθιγε τον πολιτισμό τους. Το έργο του όμως άντεξε στο χρόνο και σήμερα θεωρείται κλασικό, επειδή ακριβώς περιγράφει μοναδικά την ίδια τη φύση της βαναυσότητας αλλά και την πάλη για επιβίωση.',
    'http://books.google.com/books/content?id=Y_ZaDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180313925',
    'Το βιβλίο των ψευδαισθήσεων',
    'Metaichmio Publications',
    408,
    'Έξι μήνες μετά τον θάνατο της συζύγου και των δύο γιων του σε αεροπορικό δυστύχημα, ο καθηγητής Ντέιβιντ Τσίμερ ζει βυθισμένος στη θλίψη. Τότε, παρακολουθώντας τηλεόραση ένα βράδυ, το απόσπασμα μιας χαμένης ταινίας του Έκτορ Μαν, ενός κωμικού του βωβού κινηματογράφου, κεντρίζει το ενδιαφέρον του. Η ολοένα και μεγαλύτερη εμμονή του με το μυστήριο της αληθινής ιστορίας του Μαν θα οδηγήσει τον Τσίμερ σε ένα παράξενο και τρομακτικό ταξίδι στον γεμάτο σκιές κόσμο του ψέματος, των ψευδαισθήσεων και του απροσδόκητου έρωτα… Γραμμένο με καθηλωτική ένταση και ακρίβεια, το συγκλονιστικό αυτό μυθιστόρημα καταβυθίζει τον αναγνώστη σε ένα σύμπαν όπου το κωμικό και το τραγικό, η πραγματικότητα και η φαντασία, η βιαιότητα και η τρυφερότητα γίνονται ένα.',
    'http://books.google.com/books/content?id=lx1bDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180314687',
    'Στο τέλος νικάω εγώ',
    'Metaichmio Publications',
    304,
    'Ιστορία δεν είναι οι απόψεις των ιστορικών, είναι οι ζωές των ανθρώπων. Ένας ζαχαροπλάστης που φτιάχνει την καλύτερη κρέμα στην πόλη. Ένας Κρητικός χωροφύλακας που κάνει σαματά. Μία παρέα από φοιτητές και ο παλιός τους δάσκαλος. Ένα Γάλλος γιατρός που έζησε πολλά. Μία αρτίστα που κεντάει γιασεμιά στον ποδόγυρο. Ένας απότακτος Πελοποννήσιος με σχέδια κρυφά. Γονείς και παιδιά, φίλοι και συνεργάτες, αδέλφια, μοναχικοί λύκοι, ερωτευμένα ζευγάρια. Ένας φόνος, μία παρ’ ολίγον κατάχρηση και μερικά μυστικά. Από τη Θεσσαλονίκη του Μεγάλου Πολέμου ως τα capital control, οι ήρωές μας παίρνουν φόρα και προχωρούν μπροστά.',
    'http://books.google.com/books/content?id=2R1bDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'TUM',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180314694',
    'Το μοναστήρι της Πάρμας',
    'Metaichmio Publications',
    536,
    'Το Μοναστήρι της Πάρµας του Σταντάλ καθόρισε το ίδιο το µυθιστορηµατικό είδος και θεωρείται από πολλούς το σηµαντικότερο γαλλικό µυθιστόρηµα του 19ου αιώνα. Πρόκειται για ένα αφηγηµατικό παραλήρηµα νεανικής τόλµης και πάθους µε φόντο τα χρυσαφένια τοπία της Ιταλίας µέσα και έξω από τον ναπολεόντειο κόσµο. Ο έρωτας, οι συνωµοσίες, η τέχνη της µηχανορραφίας και η πολιτική µαζί µε όλα σχεδόν τα ανθρώπινα προτερήµατα και ελαττώµατα διεκδικούν το µερίδιό τους σε έναν καταιγισµό µικρών και µεγάλων επεισοδίων. Πρωταγωνιστεί ο ευειδής νεαρός αριστοκράτης Φαµπρίτσιο ντελ Ντόγκο, η αµίµητη θεία του κόµισσα Σανσεβερίνα, ο δισυπόστατος κόµης Μόσκα και η Κλέλια ντελ Κόντι, µια ιδεατή κορασίδα. Πάνω απ’ όλα όµως πρωταγωνιστεί η στιβαρή φιγούρα του Σταντάλ που κοιτάζει από ψηλά και ενορχηστρώνει µεγαλοφυώς το αριστούργηµά του. Μυθιστόρηµα αφιερωµένο στην αγέρωχη νιότη, στη δύναµη του έρωτα µα και στο τραγικό µεγαλείο του ανθρώπου όταν αυτός αναµετράται µε τον πόλεµο, τον θάνατο και τον θεό του. Για πολλούς το Μοναστήρι της Πάρµας δεν είναι µόνο το magnum opus του Σταντάλ, αλλά και το µείζον γαλλικό µυθιστόρηµα του 19ου αιώνα. Η σηµασία του για τον κόσµο της λογοτεχνίας είναι ακόµα µεγαλύτερη αν λάβουµε υπόψη τον επιδραστικό ρόλο του στο τολστοϊκό σύµπαν. […] Για τον τρόπο που υποδέχτηκε η κριτική τοΜοναστήρι της Πάρµας αρκεί το άρθρο του νεαρού τότε Μπαλζάκ, που αποτέλεσε έκτοτε επωδό της πρώτης έκδοσης. Μαζί µε την απάντηση του Σταντάλ αποτελούν αναπόσπαστο µέρος της στανταλικής ποιητικής. Όταν ο Μπαλζάκ οµολογεί πως διάβασε τρίτη φορά το µυθιστόρηµα, δεν ψεύδεται. Είναι τόσο ενδελεχής η κριτική µατιά του, ώστε δεν υπάρχει καµία αµφιβολία για αυτό. Άλλωστε συνάδει µε την παρότρυνση του βρετανού λόγιου Σίριλ Κόνολι, ο οποίος επιµένει ότι κάθε σπουδαίο λογοτεχνικό κείµενο γράφεται για να διαβαστεί τουλάχιστον δύο φορές. Από τον πρόλογο του Δηµήτρη Στεφανάκη «Φεύγει η ζωή, γι’ αυτό κι εσύ µην κάνεις τον δύσκολο στην ευτυχία που σου παρουσιάζεται, κοίτα να χαρείς».',
    'http://books.google.com/books/content?id=3R1bDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180315110',
    'Υπό το κράτος του τρόμου',
    'Metaichmio Publications',
    256,
    'Το παράξενο χόμπι ενός συνταξιούχου πρώην υπαλλήλου που κρύβει στην ψυχή του ένα φοβερό «μυστικό». Η απόδραση ενός οικογενειάρχη με προβλήματα από την κόλαση της μεγαλούπολης και την καταστροφική μανία των διαδηλωτών-κουκουλοφόρων. Ένας άντρας, που βιώνει το άγχος της απόλυτης μοναξιάς του στις γιορτές, γίνεται ο μοναδικός «άσος της νύχτας». Μια όμορφη οικιακή βοηθός από την ανατολική Ευρώπη, που θεωρεί ότι έχει ξεπέσει κοινωνικά στη χώρα που τώρα εργάζεται. Ένας πρόσφυγας, δυνάμει παλαιστής, χαραμίζεται σ’ ένα επάγγελμα που δεν του αξίζει. Η απελπισία ενός πατέρα που θέλει να γλιτώσει από την αρρώστια του, αλλά κι από τη θηλιά αγάπης των δικών του ανθρώπων. Το όνειρο μιας ολόκληρης ζωής ενός επιτυχημένου βιοτέχνη που σβήνει ξαφνικά και άδοξα. Ο διχασμός προσωπικότητας ενός νέου οικογενειάρχη που νιώθει ενοχές για τα δεινά που υποφέρουν οι συνάνθρωποί του. Η απεγνωσμένη έκκληση για βοήθεια ενός άντρα που απειλείται να πέσει θύμα εγκλήματος. Η δραματική απόπειρα ενός συγγραφέα, με αφορμή τον τρόμο της προσωπικής του ζωής, να συγγράψει ένα βιβλίο. Αυτές είναι μερικές από τις (23) ιστορίες καθημερινότητας του βιβλίου, των οποίων οι πρωταγωνιστές, παρόλο που βιώνουν συχνά οδυνηρές καταστάσεις από τις συγκυρίες μιας δύσκολης πραγματικότητας (ως παρεπόμενα της πολυδιάστατης και μακροχρόνιας κρίσης που μαστίζει όχι μόνο τον τόπο μας, αλλά και ολόκληρο τον κόσμο), προσπαθούν να διατηρήσουν εν ενεργεία μέσα τους έναν θερμό πυρήνα ονείρου, αντίστασης και καλοσύνης.',
    'http://books.google.com/books/content?id=pMtaDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317602',
    'Επτά μείον ένα',
    'Metaichmio Publications',
    480,
    'ΕΝΑ ΘΡΙΛΕΡ ΠΟΥ ΚΟΒΕΙ ΤΗΝ ΑΝΑΣΑΜΕ ΤΙΣ ΑΝΑΠΑΝΤΕΧΕΣ ΑΝΑΤΡΟΠΕΣ ΤΗΣ ΠΛΟΚΗΣ Η ΠΡΩΤΗ ΠΕΡΙΠΕΤΕΙΑ ΤΗΣ ΝΕΑΣ ΣΕΙΡΑΣΤΟΥ ARNE DAHL ΚΑΠΟΙΟΣ ΠΑΡΑΚΟΛΟΥΘΕI... Σε κάθε εγκαταλελειµµένη σκηνή εγκλήµατος υπάρχει ένα κρυµµένο στοιχείο: ένας µικρός οδοντωτός τροχός που σχεδόν δεν διακρίνεται µε γυµνό µάτι. Κάποιος στέλνει στον επιθεωρητή Σαµ Μπέργερ ένα µήνυµα, κάποιος που ξέρει ότι µόνο αυτός θα καταλάβει το κρυπτογραφηµένο χνάρι. ΚΑΠΟΙΟΣ ΞΕΡΕΙ... Όταν άλλη µια έφηβη εξαφανίζεται, ο Σαµ πρέπει να πείσει τους ανωτέρους του ότι έχουν να κάνουν µε έναν σίριαλ κίλερ. Καθώς η αστυνοµία συνεχίζει το κυνήγι για να εντοπίσει το τελευταίο θύµα, ο Σαµ είναι αναγκασµένος να φέρει στο φως βαθιά θαµµένους προσωπικούς δαίµονες. Δεν έχει άλλη επιλογή αν θέλει να καταλάβει το ζοφερό προσωπικό µήνυµα του δολοφόνου πριν εκπνεύσει ο χρόνος. ΚΑΠΟΙΟΣ ΣΚΟΤΩΝΕΙ ΜΟΝΟ ΓΙΑ ΧΑΡΗ ΤΟΥ... ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Ένας από τους πραγµατικά σπουδαίους συγγραφείς της σκανδιναβικής αστυνοµικής λογοτεχνίας. Mark Billingham, συγγραφέας Ο Arne Dahl έχει δηµιουργήσει τη δική του σχολή αστυνοµικής λογοτεχνίας, συνδυάζοντας αριστοτεχνικά διεθνείς δολοπλοκίες, κατασκοπεία, σασπένς και υψηλή λογοτεχνία. LarsKepler, συγγραφέας Ίσως ο πιο ταλαντούχος απ’ όλους τους σκανδιναβούς συγγραφείς. Πέτρος Μάρκαρης, Τα Νέα',
    'http://books.google.com/books/content?id=6qFyDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317640',
    'Δάσος σκοτεινό',
    'Metaichmio Publications',
    352,
    'Το νέο, πολυαναμενόμενο μυθιστόρημα της Νικόλ Κράους. Ο Τζουλς Έπσταϊν, ένας θαλερός ηλικιωμένος άντρας από τη Νέα Υόρκη, που έχει μάθει να υπερνικά τις δυσκολίες της ζωής με τη δύναμη της θέλησής του, αγνοείται επί μέρες στο Τελ Αβίβ, όπου διέμενε τους τελευταίους τρεις μήνες. Η Νικόλ, μια σαραντάχρονη συγγραφέας από το Μπρούκλιν, νιώθει μουδιασμένη από την υπαρξιακή μοναξιά της. Αδυνατεί να γράψει, δυσκολεύεται να κοιμηθεί, και η εικόνα του ξενοδοχείου στο Τελ Αβίβ όπου περνούσε τις παιδικές της διακοπές τη στοιχειώνει τόσο επίμονα ώστε αποφασίζει, μέσα σε μια νύχτα, να ξαναπάει εκεί για ένα διάστημα. Ένας μεγαλοδικηγόρος και μια μυθιστοριογράφος, δύο άνθρωποι που έχουν χάσει τον δρόμο τους στη ζωή και αναζητούν το ψυχικό και πνευματικό τους στίγμα.',
    'http://books.google.com/books/content?id=wB9zDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317695',
    'Το μήνυμα',
    'Metaichmio Publications',
    464,
    'Στο εσωτερικό μιας σχολικής χρονοκάψουλας, δέκα χρόνια αφότου σφραγίστηκε, ανακαλύπτεται ένα ανατριχιαστικό μήνυμα που προβλέπει τον θάνατο έξι ανθρώπων. Σίγουρα όμως, αν γράφτηκε από κάποιο δεκατριάχρονο, δεν μπορεί να είναι αληθινή απειλή… Ο ντετέκτιβ Χούλνταρ θεωρεί πως του ανέθεσαν την έρευνα απλώς και μόνο για να τον κρατήσουν μακριά από πραγματικές υποθέσεις και στρέφεται στην ψυχολόγο Φρέιγια για να τον βοηθήσει να καταλάβει τον έφηβο που το έγραψε. Μια σειρά μακάβριων γεγονότων ωστόσο, η ανακάλυψη κομμένων ανθρώπινων μελών σε έναν κήπο και ο φόνος του ιδιοκτήτη του σπιτιού με τα αρχικά ΜΠ. Τ., σηματοδοτούν άλλη μια σοκαριστική υπόθεση που πρέπει να εξιχνιάσουν.',
    'http://books.google.com/books/content?id=kot5DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317701',
    'Οι άνθρωποι στα δέντρα',
    'Metaichmio Publications',
    496,
    'Το 1950, ο Νόρτον Περίνα, ένας νεαρός γιατρός, συµφωνεί να συνοδεύσει τον ανθρωπολόγο Πολ Τάλεντ σε µια αποστολή στο αποµακρυσµένο νησί Ιβου’ίβου της Μικρονησίας, σε αναζήτηση µιας φηµολογούµενης χαµένης φυλής. Επιτυγχάνουν: Δεν βρίσκουν µονάχα τη φυλή αλλά και µια οµάδα δασόβιων που τους βαφτίζουν «ονειροβάτες» και οι οποίοι αποδεικνύεται πως είναι εξαιρετικά µακρόβιοι µα και ανοϊκοί. Ο Περίνα υποψιάζεται πως η πηγή της µακροζωίας τους είναι µια δυσεύρετη χελώνα• µην µπορώντας να αντισταθεί στην πιθανότητα της αιώνιας ζωής, σκοτώνει µια χελώνα και περνάει λαθραία το κρέας της στις ΗΠΑ. Αποδεικνύει την υπόθεσή του επιστηµονικά, κερδίζοντας παγκόσµια φήµη και το βραβείο Νόµπελ, σύντοµα όµως ανακαλύπτει ότι αυτή η θαυµατουργή ιδιότητα έχει ένα φρικτό τίµηµα...',
    'http://books.google.com/books/content?id=umd0DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'CEB',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317770',
    'Εφιάλτης στην Αριζόνα',
    'Metaichmio Publications',
    376,
    'Η Όντρα θέλει απλώς να φτάσει στην Καλιφόρνια. Επιτέλους, βρήκε το κουράγιο να εγκαταλείψει τον καταπιεστικό της σύζυγο για να κάνει μια καινούργια αρχή με τα δυο παιδιά της. Διέσχισε τη χώρα προσεκτικά, από παράδρομους, με τα δυο παιδιά στο πίσω κάθισμα· κι όταν ένας σερίφης την σταματά στη μέση της ερήμου της Αριζόνας, η Όντρα πασχίζει να κρύψει τη νευρικότητά της. Πρέπει να το κάνει. Έπειτα όμως ο σερίφης βγάζει από το πορτ μπαγκάζ της ένα σακουλάκι με ναρκωτικά που η Όντρα πρώτη φορά βλέπει, και η νευρικότητά της γίνεται πανικός. Νομίζει ότι συνέβη το χειρότερο. Αλλά δυστυχώς, κάνει λάθος. Το χειρότερο έρχεται.',
    'http://books.google.com/books/content?id=5ot5DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317794',
    'Μικρές φωτιές παντού',
    'Metaichmio Publications',
    496,
    'Στο Σέικερ Χάιτς, ένα ήρεμο, προοδευτικό προάστιο του Κλίβελαντ, όλα είναι σχεδιασμένα ως την τελευταία λεπτομέρεια – από τη χάραξη των στριφογυριστών δρόμων ως το χρώμα των σπιτιών, ως τις επιτυχημένες ζωές που πρόκειται να ζήσουν οι κάτοικοί του. Και κανείς δεν ενσαρκώνει αυτό το πνεύμα καλύτερα απ’ ότι η Έλενα Ρίτσαρντσον, της οποίας η βασική αρχή είναι να σέβεται πάντα τους κανόνες. Τότε, στην ειδυλλιακή φούσκα που συνιστά τη ζωή της οικογένειάς της, μπαίνει η Μία Γουόρεν, μια αινιγματική καλλιτέχνιδα που νοικιάζει μαζί με την έφηβη κόρη της, την Περλ, ένα σπίτι των Ρίτσαρντσον. Σύντομα η Μία και η Περλ αποκτούν πολύ σημαντικότερο ρόλο στη ζωή τους από αυτόν των απλών ενοικιαστριών – και τα τέσσερα παιδιά των Ρίτσαρντσον γοητεύονται από τη μητέρα και την κόρη. Η Μία όμως κουβαλά ένα μυστηριώδες παρελθόν και μια αψηφισιά για το κατεστημένο που απειλεί να ανατρέψει την τόσο τέλεια οργανωμένη κοινότητά τους.',
    'http://books.google.com/books/content?id=EtZ5DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MAO',
    3.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317831',
    'Οι γιοι του Όντιν',
    'Metaichmio Publications',
    560,
    'ΦΟΝΙΚΑ ΜΥΣΤΙΚΑ ΣΤΑ ΕΡΕΙΠΙΑ ΤΟΥ Γ΄ΡΑΪΧ Βερολίνο, Ιανουάριος 1945: Ενώ τα συµµαχικά στρατεύµατα προε-λαύνουν προς τη Γερµανία και στη χώρα επικρατούν σύγχυση και χάος, δολοφονείται βίαια ο λοχαγός των Ες Ες Έριχ Χάουζερ, ο σύζυγος της προστάτιδας του επιθεωρητή Οπενχάιµερ, της Χίλντε. Το ζευγάρι έχει χωρίσει εδώ και χρόνια, καθώς είναι εντελώς διαφορετική η τοποθέτησή τους απέναντι στο ναζιστικό καθεστώς. Ο αδίστακτος στρατιωτικός Χάουζερ διεξήγε πειράµατα σε ανθρώπους σε στρατόπεδο συγκέντρωσης στα ανατολικά, κάτι το οποίο είχε ανακαλύψει η Χίλντε και το οποίο ενδεχοµένως να ήταν το κίνητρό της για να τον δολοφονήσει. Όµως ο επιθεωρητής Οπενχάιµερ, προσπαθώντας να σώσει τη φίλη του από τα νύχια του ναζιστικού δικαστικού συστήµατος, θα βρει κοντά στο πτώµα µια καρφίτσα µε έναν ρούνο. Η καρφίτσα αυτή τον οδηγεί στα ίχνη µιας σέχτας που τα µέλη της θεωρούν ότι ανήκουν στην κυρίαρχη φυλή και κάνουν ήδη σχέδια για τη µετα-εθνικοσοσιαλιστική εποχή…',
    'http://books.google.com/books/content?id=xaN9DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180317879',
    'Η κυρία που λυπάται',
    'Metaichmio Publications',
    304,
    'Ο Ισίδωρος Ζουγανέλης, ένας σαραντάχρονος ψυχολόγος με τραυματικό παρελθόν, οικογενειακός σύμβουλος, συγγραφέας βιβλίων Αυτοβελτίωσης και τηλεοπτική περσόνα, χάνει το έδαφος κάτω από τα πόδια του όταν η σύμβασή του με το ιδιωτικό κανάλι Kronos δεν ανανεώνεται. Η δεύτερη ευκαιρία που θα του προσφέρει μια κυρία της υψηλής κοινωνίας, με πλούσιο φιλανθρωπικό έργο αλλά κι έντονα αμφιλεγόμενη προσωπικότητα, θα τον οδηγήσει στα παρασκήνια μιας σαγηνευτικής όσο κι επικίνδυνης υπόθεσης, σε απόσταση αναπνοής από το χείλος της αβύσσου. Μετά από απουσία χρόνων, ο Πέτρος Τατσόπουλος επιστρέφει στα γνώριμα εδάφη του μυθιστορήματος. Στην Κυρία που λυπάται συνδυάζει στοιχεία από το σύγχρονο ψυχολογικό θρίλερ και την αχαλίνωτη μαύρη κωμωδία με τον αισθησιασμό και το μυστήριο ενός παραδοσιακού pulp fiction. Κλείνει το μάτι στις θεωρίες συνωμοσίας και ρίχνει ένα διεισδυτικό όσο και συμπονετικό βλέμμα σ’ έναν κόσμο που αρνείται πεισματικά ν’ αναγνωρίσει το είδωλό του στον καθρέφτη. Από τη στιγμή που ο σοφέρ ειδοποίησε να μας ανοίξουν την κεντρική πύλη έως τη στιγμή που μου έδωσε το βρεγμένο χέρι της, οι πάντες κινήθηκαν με ακρίβεια χορευτών σε χορογραφία. Άνθρωποι που εμφανίζονταν από το πουθενά κι εξαφανίζονταν στο πουθενά, έπαιρναν το βαλιτσάκι μου από την κούρσα, με τράταραν γκουρμεδιές, μου έβαζαν στο χέρι το τζιν τόνικ που ζήτησα πριν καν προλάβω να το ζητήσω, με ξάπλωναν σε μια σεζλόνγκ δίπλα στην πισίνα, με θέα προς την οικοδέσποινα που κολυμπούσε κάτω από το νερό κι έβγαζε κάπου κάπου το κεφαλάκι της, όπως το προϊστορικό τέρας, η Νέσι, στη λίμνη του Λόχνες.',
    'http://books.google.com/books/content?id=c6N9DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180319125',
    'Η γυναίκα και το νευρόσπαστο',
    'Metaichmio Publications',
    175,
    'Κλασική ερωτική νουβέλα η οποία μεταφέρθηκε πολλές φορές στον κινηματογράφο με πρωταγωνίστριες μεταξύ άλλων τη Μαρλέν Ντίτριχ και την Μπριζίτ Μπαρντό.',
    'http://books.google.com/books/content?id=NxuFDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'AYM',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180319767',
    '1793: Τότε που βασίλευε η βία',
    'Metaichmio Publications',
    560,
    'Σουηδία, 1793. Έχει περάσει παραπάνω από ένας χρόνος από τον θάνατο του βασιλιά Γουσταύου Γ΄. Στον απόηχο του θανάτου του, με τους επιγόνους να αλληλοσπαράσσονται για τη διαδοχή, και έντονο τον φόβο πως η Γαλλική Επανάσταση θα εξαπλωθεί στη Σουηδία, η εμπιστοσύνη πλέον σπανίζει, ενώ η παράνοια και οι συνωμοσίες ευδοκιμούν σε κάθε σκοτεινή γωνιά. Ένα ακρωτηριασμένο πτώμα που ανακαλύπτεται στα βρομερά νερά μιας λίμνης στο νησί Σέντερμαλμ είναι τόσο φρικτά παραμορφωμένο που είναι αδύνατο να αναγνωριστεί. Τη ζοφερή αυτή υπόθεση αναλαμβάνει ο φθισικός αστυνόμος Σέσιλ Βίνγκε που δεν θα αργήσει να βυθιστεί σ’ έναν λαβύρινθο σκοτεινών μυστικών και ανείπωτου φόβου στον οποίο όσο προχωρά τόσο κυκλώνει την υψηλή κοινωνία της Στοκχόλμης. Ένα μοναδικό μυθιστόρημα που ανανεώνει την αστυνομική λογοτεχνία, συνδυάζοντας το θρίλερ με το ιστορικό μυθιστόρημα.',
    'http://books.google.com/books/content?id=gRWJDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180319774',
    'Graffiti palace',
    'Metaichmio Publications',
    544,
    'Ένα οδοιπορικό σε µια πόλη µεταµορφωµένη από την έκρηξη των κατοίκων της στις λαθραίες και αθέατες κοινότητες που αποτελούσαν τη ραχοκοκαλιά του Λος Άντζελες τη δεκαετία του 1960 Αύγουστος 1965. Το Λος Άντζελες βράζει. Ο Αµέρικο Μονκ, ένας ιδιότυπος καταγραφέας των γκράφιτι της πόλης, προσπαθεί εναγωνίως να επιστρέψει σπίτι, στην αυτοσχέδια κοινότητά του που ζει σ’ έναν λαβύρινθο από κοντέινερ στο λιµάνι, όπου τον περιµένει ως άλλη Πηνελόπη η έγκυος φιλενάδα του. Όµως αυτό συµβαίνει ακριβώς όταν ξεσπούν οι Ταραχές στο Γουότς, και παρότι η ιδιότητα του µελετητή των τοίχων τού επιτρέπει τη διέλευση από τις επικράτειες της εκάστοτε συµµορίας, ο δρόµος του προς το σπίτι δεν θα είναι εύκολος… Το βιβλίο του πρωτοεµφανιζόµενου στη λογοτεχνία A.G. Lombardo έχει τις ρίζες του στην οµηρική Οδύσσεια και τον Οδυσσέα του Τζόις, στα εµβληµατικά γκράφιτι και τις ταγκιές (υπογραφές των γκραφιτάδων) που δεσπόζουν στην πόλη του Λος Άντζελες και πρωτοεµφανίζονται στα τέλη του 19ου αιώνα –αποτελώντας διακριτή γλώσσα επικοινωνίας των συµµοριών, των αποσυνάγωγων και των πενήτων–, καθώς και στις φυλετικές κοινωνικές ταραχές που διήρκεσαν έξι ολόκληρα µερόνυχτα, συντάραξαν και αιµατοκύλισαν το υποβαθµισµένο Γουότς τη δεκαετία του ’60. Είναι ένα µυθιστόρηµα που εξελίσσεται µέσα σε µια διαρκή εναλλαγή φωτός και σκοταδιού, λευκού και µαύρου, οι φωτεινές επιγραφές, οι φάροι των περιπολικών, των ασθενοφόρων, των οχηµάτων της πυροσβεστικής αναβοσβήνουν, οι διάτρητοι από σφαίρες φανοστάτες άλλοτε λειτουργούν κι άλλοτε όχι, οι βόµβες µολότοφ εκρήγνυνται µε µια στιγµιαία λάµψη, το ηλιοβασίλεµα λαµπυρίζει αιµάτινο λίγο πριν χαθεί στον µακρινό ορίζοντα, ο καπνός καλύπτει το φως και το σκοτάδι, οι φλόγες µαίνονται, οι µαύροι ξεσηκώνονται ενάντια στους λευκούς και οι λευκοί βιαιοπραγούν κατά των µαύρων, οι τυφλοί βλέπουν και αυτοί που βλέπουν έχουν τυφλωθεί, όλοι και όλα εκπέµπουν ένα επιτακτικό σήµα κινδύνου, ακόµα και ο χρόνος στο γκέτο ισορροπεί σ’ ένα µεταίχµιο, τα δευτερόλεπτα, οι ώρες, οι εβδοµάδες, τα χρόνια συσσωρεύονται πριν να αναλωθούν σ’ ένα εκρηκτικό Τώρα. από το επίµετρο της µεταφράστριας',
    'http://books.google.com/books/content?id=iRWJDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180319934',
    'Η ξηρασία',
    'Metaichmio Publications',
    422,
    'Η Αυστραλία βιώνει τη χειρότερη ξηρασία εδώ κι έναν αιώνα, και στη μικρή πόλη της Κιβάρα έχει να βρέξει δύο ολόκληρα χρόνια. Οι εντάσεις που υποβόσκουν στην κοινότητα γίνονται αφόρητες όταν τρία μέλη της οικογένειας Χάντλερ βρίσκονται νεκρά. Όλοι θεωρούν ότι ο αρχηγός της οικογένειας Χάντλερ, ο Λιουκ, αυτοκτόνησε αφού σκότωσε τη σύζυγο και τον εξάχρονο γιο του. Ο αστυνομικός Άρον Φαλκ επιστρέφει στη γενέτειρά του για την κηδεία του καλύτερου φίλου των παιδικών του χρόνων και, παρά τη θέλησή του, αναγκάζεται να συμμετάσχει στην έρευνα. Καθώς τα ερωτήματα πολλαπλασιάζονται και η καχυποψία απλώνεται στην πόλη, ο Φαλκ υποχρεώνεται να έρθει αντιμέτωπος με μυστικά από το δικό του παρελθόν που αναδύονται στην επιφάνεια όταν αμφισβητεί την αλήθεια για το έγκλημα του φίλου του.',
    'http://books.google.com/books/content?id=xNuLDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320091',
    'Αναψηλάφηση',
    'Metaichmio Publications',
    424,
    'Ο ήρωας του βιβλίου –μέλος μιας αριστερής, αντιστασιακής οργάνωσης κατά τη δικτατορία η οποία εξαρθρώθηκε από τους χουντικούς– καταφεύγει στη Βαρκελώνη όπου διαπρέπει ως κλασικός φιλόλογος και ομηριστής. Με τις ψυχικές και σωματικές κακοποιήσεις που φέρει, δεν επιστρέφει στην Ελλάδα παρά πενήντα χρόνια αργότερα. Στην Ελλάδα του σήμερα. Βρίσκει μια χώρα σε πολιτική, οικονομική, ηθική, γλωσσική παρακμή, βουτηγμένη στον αμοραλισμό και στην αμάθεια. Δεν μπορεί να την αντέξει. Οι παλιοί σύντροφοι έχουν μεταλλαχτεί, ακολούθησαν δρόμους εντελώς αντίθετους από την αρχική ιδεολογία τους, άλλοι περιφέρονται κομματικά, άλλοι καταδικάστηκαν για διαφθορά και οι αξιοπρεπέστεροι έχουν εξαφανιστεί – μια εμπλοκή του βιολογικού καθαρισμού της κοινοβουλευτικής δημοκρατίας επιτρέπει πάντα στα πολιτικά περιττώματα να επιπλέουν. Ο Βασίλης Γκουρογιάννης μετά τα εμβληματικά και θαρραλέα έργα Διηγήσεις παραφυσικών φαινομένων 1990, Το ασημόχορτο ανθίζει 1992, Κόκκινο στην Πράσινη Γραμμή 2009, με το παρόν βιβλίο δίνει το συγκλονιστικότερο και αρτιότερο έργο του, μια αξονική τομογραφία των τελευταίων πενήντα ετών της χώρας που ασθενεί βαριά. Είναι περίεργο αλλά λέει τη λέξη πατρίδα όλο και συχνότερα, και τη λέει ακόμη με μητρική προφορά, η ισπανική γλώσσα δεν της έφαγε κανένα γράμμα. Ολόκληρη η λέξη απαρτίζεται ευτυχώς από γράμματα που δεν τα χωνεύει το στομάχι της ισπανικής. Ενώ όμως πρέπει να νιώθει περήφανος για τη χρήση αυτής της λέξης, εντούτοις αισθάνεται ένα είδος αηδίας όταν η λέξη βρίσκεται στο στόμα του, σαν να έχει αρπάξει μασημένη τσίχλα από το στόμα των υπερπατριωτών, των Χρυσαυγιτών, και συνεχίζει να τη μασάει αυτός! Έχει μνήμες. Τις έχει γευτεί αυτές τις ιδεολογικές τσίχλες: Πατρίς-Θρησκεία-Οικογένεια. Ελλάς-Ελλήνων-Χριστιανών. Πρέπει να δημιουργηθεί άλλη λέξη αγάπης για την πατρίδα, αυτή η όμορφη ομηρική λέξη πάτρης έχει καεί.',
    'http://books.google.com/books/content?id=8yiODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320114',
    'Η έρημος των Ταρτάρων',
    'Metaichmio Publications',
    296,
    'Το αριστούργηµα του Ντίνο Μπουτζάτι Η έρημος των Ταρτάρων αφηγείται την ιστορία του νεαρού υπολοχαγού Τζοβάνι Ντρόγκο, ο οποίος περνάει τη ζωή του στο Οχυρό Μπαστιάνι, όπου τοποθετείται στον πρώτο του διορισµό, περιµένοντας µάταια την εισβολή του θρυλικού εχθρού από τον βορρά. Με φόντο την απέραντη, οµοιόµορφη έρηµο, ο Μπουτζάτι αφηγείται την αναµονή της µεγάλης ευκαιρίας για τον αξιωµατικό, της ευκαιρίας που θα του αλλάξει τη ζωή χαρίζοντάς του την πολυπόθητη δόξα. Μόνο που η µεγάλη ευκαιρία τελικά δεν παρουσιάζεται ποτέ και ο αξιωµατικός, τριάντα ολόκληρα χρόνια µετά, έρχεται αντιµέτωπος µε το κορυφαίο γεγονός: τον θάνατο. Και τον αντιµετωπίζει µονάχος, χωρίς να περιµένει βοήθεια ή κατανόηση από κανέναν, σ’ ένα περιβάλλον παντελώς άγνωστο. Ένα μυθιστόρημα για τη μοναξιά, την υπαρξιακή αγωνία, την άνιση μάχη ενάντια στο πέρασμα του χρόνου, την ανθρώπινη αξιοπρέπεια, τον θάνατο. Το βιβλίο μεταφέρθηκε στον κινηματογράφο το 1976 από τον σκηνοθέτη Βαλέριο Τζουρλίνι.',
    'http://books.google.com/books/content?id=_yiODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320138',
    'Το χρυσό κλουβί',
    'Metaichmio Publications',
    432,
    'Η ΕΚΔΙΚΗΣΗ ΜΙΑΣ ΓΥΝΑΙΚΑΣ ΕΙΝΑΙ ΟΜΟΡΦΗ ΚΑΙ ΣΚΛΗΡΗ Η βασίλισσα των μπεστ σέλερ της Σουηδίας, η Camilla Lackberg επιστρέφει με μια καταπληκτική νέα διλογία, αφήνοντας για λίγο κατά μέρος τη σειρά της Φιελμπάκα και το πρωταγωνιστικό δίδυμο Πάτρικ και Ερίκα. Περισσότερα από 23 εκατομμύρια αντίτυπα σε όλο τον κόσμο. Η Φέι μοιάζει να τα έχει όλα: έναν τέλειο σύζυγο, μια πολυαγαπημένη κόρη και ένα πολυτελές διαμέρισμα στην καλύτερη περιοχή της Στοκχόλμης. Όμως σκοτεινές αναμνήσεις από την παιδική της ηλικία σ’ ένα γραφικό ψαροχώρι, τη Φιελμπάκα, τη στοιχειώνουν και νιώθει όλο και περισσότερο σαν φυλακισμένη σε χρυσό κλουβί. Κάποτε ήταν μια δυνατή και φιλόδοξη γυναίκα, πριν τα παρατήσει όλα για τον σύζυγό της τον Τζακ. Όταν διαπιστώνει πως εκείνος την απατά, ο κόσμος της Φέι γκρεμίζεται και μένει εντελώς ξεκρέμαστη. Είναι κυριολεκτικά καταρρακωμένη, ώσπου αποφασίζει να πληρώσει τον Τζακ με το ακριβές αντίτιμο της προδοσίας του, με τη δίκαιη εκδίκησή της. Το Χρυσό κλουβί είναι ένα γενναίο μυθιστόρημα με πρωταγωνίστρια μια γυναίκα που τη χρησιμοποίησαν, την πρόδωσαν ώσπου να πάρει τη μοίρα στα χέρια της. Μια δραματική ιστορία εξαπάτησης, λύτρωσης και εκδίκησης.',
    'http://books.google.com/books/content?id=6yiODwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320787',
    'Πέρα δώθε',
    'Metaichmio Publications',
    456,
    'Η οικογένεια Χωρέµη, ξεριζωµένη από τη γενέτειρά της τη Χίο, για να γλιτώσει από τη σφαγή του 1822, ξαναχτίζει µε επιµονή και πίστη στην πρόοδο τη ζωή της στη Σύρο, όπου στη διάρκεια των χρόνων συγκεντρώνονται πρόσφυγες και κατατρεγµένοι από διάφορες περιοχές της Μεσογείου. Οι οικονοµικές δραστηριότητες της οικογένειας συνδέονται µε τη ραγδαία ανάπτυξη της Ερµούπουλης και την ανάδειξή της σε εµπορικό και ακτοπλοϊκό κέντρο στα µέσα του 19ου αιώνα. Ο καιρός κυλά και τα µέλη της οικογένειας, ο Στέφανος και η Σµαράγδα, ο Άλκης και η Ελένη, ο Ζαννής και ο Αντώνης, ο Χαρίλαος και η Ρορώ ερωτεύονται, παντρεύονται, σπουδάζουν στο εξωτερικό, παραθερίζουν όλοι µαζί στο Πισκοπιό, εξελίσσονται παράλληλα µε τον τόπο. Μια τραγωδία ωστόσο που ρίχνει βαριά τη σκιά της στην οικογένεια Χωρέµη θα σταθεί η αφορµή για να αναδυθούν έριδες και ανταγωνισµοί ανοίγοντας έναν ακόµα κύκλο στο αδιάκοπο πέρα δώθε των µελών της. Μια πανοραµική αποτύπωση της ανόδου και της πτώσης µιας πόλης και ενός νησιού, που γίνεται χωνευτήρι διαφορετικών εθνοτικών οµάδων. Ένα συναρπαστικό µυθιστόρηµα για το πώς οι µυλόπετρες της ιστορίας διαµορφώνουν την πορεία µιας οικογένειας. Ξερότοπος ήταν το νησί, τέσσερις χιλιάδες αριθµούσε, όταν η Χίος πριν την καταστροφή της αριθµούσε πάνω από εκατόν είκοσι χιλιάδες. Κι αν οι Χιώτες ήρθαν το ’22, το ’24 ήρθαν οι Ψαριανοί. Γέµισε τότε η παραλία καλύβες, πάνω από χίλιες απλώθηκαν στην αιµασιά. Οι άνθρωποι που κατέφυγαν εκείνα τα χρόνια στη Σύρο ταλαιπωρηµένοι ήταν, φτωχοί και δυστυχισµένοι, ωστόσο ήταν έντιµοι βιοπαλαιστές και δηµιουργικοί. Χωρίς πολλά λόγια, πήραν τη ζωή τους στα χέρια τους. Πρώτα βάφτισαν τον τόπο όπου εγκαταστάθηκαν Ερµούπολη και µετά τον έφτιαξαν πόλη! Σε λιγότερο από δέκα χρόνια φτιάχτηκαν σπίτια, εκκλησίες, νοσοκοµείο, κτίσθηκε και λειτούργησε το Γυµνάσιο Ερµουπόλεως, ιδρύθηκε το πρώτο ταχυδροµικό γραφείο της χώρας, ενώ στα δεκαπέντε χρόνια συντάχθηκε το ρυµοτοµικό σχέδιο της πόλης, µε εκατόν είκοσι δρόµους και πολλές πλατείες! Γκρεµίστηκαν τότε όλες οι καλύβες της παραλίας κι η Ερµούπολη άρχισε να παίρνει τη µορφή µιας όµορφης πόλης, που απλωνόταν απ’ τη θάλασσα ως ψηλά στους δύο λόφους, την Άνω Σύρο και το ?ήλι.',
    'http://books.google.com/books/content?id=QcWWDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320794',
    'Germania',
    'Metaichmio Publications',
    560,
    'ΕΝΑΣ ΤΡΟΜΑΚΤΙΚΟΣ ΝΕΟΣ ΚΟΣΜΟΣ ΜΕΣ ΣΤΑ ΣΥΝΤΡΙΜΜΙΑ Βερολίνο, τέλος Απριλίου 1945: Τις τελευταίες ηµέρες της κατάρρευσης του Τρίτου Ράιχ ο επιθεωρητής Οπενχάιµερ και η σύζυγός του Λίζα τις περνούν σε ένα υπόγειο καταφύγιο. Ωστόσο, η Λίζα πέφτει θύµα βιασµού από έναν ρώσο στρατιώτη. Ο δράστης είναι ένας λιποτάκτης που ονοµάζεται Γκριγκόριεφ. Ο Οπενχάιµερ, όταν αρχίζει να αναζητεί τα ίχνη του, έρχεται αντιµέτωπος µ ένα πλέγµα ψευδών και εξαπάτησης, στο κέντρο του οποίου βρίσκεται µια βαλίτσα µε άκρως επικίνδυνο περιεχόµενο. Είναι σαφές ότι ο Γκριγκόριεφ προσπαθεί να διαπραγµατευτεί παράνοµα υλικό σχετικό µε τις έρευνες των ναζί στον τοµέα της ατοµικής ενέργειας. Και γι’ αυτό τον λόγο στο παιχνίδι έχουν µπει παραπάνω από µία µυστικές υπηρεσίες... Προσωπική εκδίκηση ή συλλογικό καλό: ο επιθεωρητής Οπενχάιµερ καλείται να διαλέξει ποιο µονοπάτι θα ακολουθήσει. ΤΟ ΤΡΙΤΟ ΜΕΡΟΣ ΤΗΣ ΤΡΙΛΟΓΙΑΣ GERMANIA ΜΕ ΠΡΩΤΑΓΩΝΙΣΤΗ ΤΟΝ ΕΠΙΘΕΩΡΗΤΗ ΟΠΕΝΧΑΪΜΕΡ',
    'http://books.google.com/books/content?id=R8WWDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180320800',
    'Το κόκκινο σήμα του θάρρους',
    'Metaichmio Publications',
    280,
    'Ένας άντρας κάπου κοντά του, που μέχρι εκείνη τη στιγμή έριχνε ασταμάτητα με το όπλο του, σταμάτησε ξαφνικά κι άρχισε να τρέχει ουρλιάζοντας. Ένα παλικάρι που στο πρόσωπό του ήταν αποτυπωμένη η έκφραση του ασίγαστου θάρρους, το μεγαλείο εκείνου που δεν διστάζει να δώσει και τη ζωή του, μέσα σε μια στιγμή είχε χτυπηθεί από την αθλιότητα. Χλώμιασε σαν κάποιον που, μέσα στη νύχτα, συνειδητοποιεί πως έχει φτάσει στο χείλος του γκρεμού. Ήταν αποκαλυπτικό. Πέταξε κι εκείνος το όπλο του και το ’βαλε στα πόδια. Καμιά ντροπή στο πρόσωπό του. Έτρεχε σαν τον λαγό. Το διασημότερο έργο του Στίβεν Κρέιν εκδόθηκε το 1895 και χάρισε στον νεαρό συγγραφέα του διεθνή φήμη. Εκτυλίσσεται στη διάρκεια του Αμερικανικού Εμφυλίου και αφηγείται τη βάναυση αφύπνιση ενός νεαρού στρατιώτη των Βορείων. Ο Χένρι Φλέμινγκ ονειρευόταν την έξαψη και τη δόξα του πολέμου, αλλά όταν βρέθηκε στο πεδίο μάχης έτρεξε για να γλιτώσει από τη φρίκη των συγκρούσεων. Ένας τυχαίος τραυματισμός θα τον εξιλεώσει για τη δειλία του στα μάτια των άλλων και θα τον οδηγήσει στο να αναμετρηθεί με τον φόβο του. Ένα έργο που υμνήθηκε για την ψυχολογική του διεισδυτικότητα και για τον πρωτοποριακό του ρεαλισμό στην αποτύπωση των συνθηκών μάχης, ένα αθάνατο αριστούργημα που εξακολουθεί έως σήμερα να συγκινεί. Ένα μυθιστόρημα για τον Αμερικανικό Εμφύλιο (1861-65), όπου για πρώτη φορά στην αμερικανική λογοτεχνία ο πόλεμος αντιμετωπίζεται όχι από την πλευρά του καθηλωτικού μεγαλείου και του ηρωισμού αλλά από την πλευρά του φόβου και του συναισθηματικού κλονισμού. Ο ήρωας του Κρέιν, ο Χένρι Φλέμινγκ, ουσιαστικά ένας αντιήρωας που θα μπορούσε να έχει την ηλικία του συγγραφέα, στον πόλεμο αυτό «γίνεται άντρας», όχι γιατί παίρνει μέρος σε μάχες, αλλά γιατί έρχεται αντιμέτωπος με τον θάνατο, και γιατί η ψυχή του αλλάζει επειδή περνάει μέσα από το καθαρτήριο του αίματος, μέσα από τον αρχετυπικά βιβλικό αγρό του αίματος. από την εισαγωγή του Νίκου Μπακουνάκη',
    'http://books.google.com/books/content?id=VcWWDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'SOT',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180321005',
    'Πάντα πλάι σου',
    'Metaichmio Publications',
    672,
    'Η ευτυχία δεν είναι κάτι που µπορεί να σου προσφέρει ένας άλλος άνθρωπος. Προέρχεται από µέσα σου. Στα τριάντα δύο του, ο Ράσελ Γκριν τα έχει όλα: µια εντυπωσιακή σύζυγο, µια αξιαγάπητη εξάχρονη κόρη, µια πετυχηµένη καριέρα ως διαφηµιστικό στέλεχος και ένα ωραίο σπίτι. Ζει ονειρεµένη ζωή, και ο γάµος του µε τη σαγηνευτική Βίβιαν είναι το κέντρο της. Κάτω, όµως, από τη γυαλιστερή επιφάνεια αυτής της τέλειας ύπαρξης, αρχίζουν να διακρίνονται ρήγµατα… και κανείς δεν εκπλήσσεται περισσότερο από τον ίδιο τον Ρας όταν κάθε πτυχή της ζωής του που θεωρούσε δεδοµένη ανατρέπεται. Μέσα σε λίγους µήνες, ο Ρας βρίσκεται, χωρίς δουλειά και σύζυγο, να πασχίζει να προσαρµοστεί σε µια νέα, περίπλοκη πραγµατικότητα. Αναλαµβάνοντας να φροντίσει την κορούλα του ως γονιός πλήρους απασχόλησης, ξεκινά ένα ταξίδι που τον τροµοκρατεί και τον αποζηµιώνει εξίσου – ένα ταξίδι που θα δοκιµάσει τις ικανότητές του και τη συναισθηµατική του αντοχή περισσότερο απ’ ό,τι είχε ποτέ φανταστεί. Ένα συγκινητικό µυθιστόρηµα µε θέµα την απώλεια, τη διάψευση των προσδοκιών αλλά και τη δύναµη της ανιδιοτελούς αγάπης.',
    'http://books.google.com/books/content?id=rqCaDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    1.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180321012',
    'Τσάι στη Σαχάρα',
    'Metaichmio Publications',
    448,
    'Περιγραφή βιβλίου Ύστερα από δέκα χρόνια γάμου, ο Πορτ και η Κιτ Μόρσμπερι, ένα σοφιστικέ ζευγάρι Αμερικανών, διαπιστώνουν πως, καθώς έχουν απομακρυνθεί ψυχικά και έχουν αποξενωθεί σεξουαλικά, δυσκολεύονται όλο και περισσότερο να συνεχίσουν να συμβιώνουν. Προσπαθώντας να βγουν από αυτό το αδιέξοδο, ταξιδεύουν στη Βόρεια Αφρική με σκοπό να διασχίσουν την Αλγερία – δεν έχουν καταλήξει στον ακριβή προορισμό τους, αλλά είναι αποφασισμένοι να αφήσουν πίσω τους τον σύγχρονο κόσμο. Αυτή η ανέμελή τους απόφαση όμως θα έχει τρομερές συνέπειες και για τους δύο. ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Ένα από τα πιο πρωτότυπα, θα έλεγε κανείς ενορατικά, λογοτεχνικά έργα του 20ού αιώνα. Tobias Wolff, συγγραφέας Ένα έργο που στέκεται επάξια στην πρώτη γραμμή της αγγλόφωνης μεταπολεμικής λογοτεχνίας. New Republic Ευφυές… Ένα βιβλίο δυνατό και διεισδυτικό, με εντάσεις που συγκλονίζουν. Evening Standard Μεταφέρθηκε στον κινηματογράφο από τον Μπερνάρντο Μπερτολούτσι, με πρωταγωνιστές την Ντέμπρα Γουίνκερ και τον Τζον Μάλκοβιτς. Ήταν ένα απόγευμα του Ιουλίου του 1947. Είχα μόλις ξυπνήσει από μια σιέστα που μου επέβαλλε η ζέστη, γιατί η Φεζ μπορεί να έχει πολύ υψηλές θερμοκρασίες το καλοκαίρι. Θυμάμαι την αποπνικτική ατμόσφαιρα στο κλειστοφοβικό δωμάτιο. «Θα ανοίξω το παράθυρο» σκέφτηκα «και από κάτω θα είναι το λιμάνι του Ουαχράν, και ο αέρας θα είναι φρέσκος και δροσερός». Ήμουν ήδη μέσα στο βιβλίο που ήθελα να γράψω. Paul Bowles Από τον πρόλογό του στο βιβλίο',
    'http://books.google.com/books/content?id=87SaDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.33
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322309',
    'Φονικό μονοπάτι',
    'Metaichmio Publications',
    376,
    'Ο νοµπελίστας ποιητής Μανάς Ισµαήλ και η αγαπηµένη του σύ¬ζυγος Αµίνα δραπετεύουν από το Ιράν προκειµένου να ζήσουν µια ήρεµη ζωή στη Δανία µακριά από τις πολιτικές διώξεις και τις φυλακές. Στη διάρκεια του ταξιδιού τους όµως χωρίζονται και ο Μανάς καταλήγει σε έναν καταυλισµό προσφύγων χωρίς να γνωρίζει τι απέγινε η Αµίνα και χωρίς να µπορεί να επικοινωνήσει µαζί της. Η Νόρα Σαν ενηµερώνεται ότι ο Μανάς δέχεται να της δώσει µια αποκλειστική συνέντευξη εφ’ όλης της ύλης και πηγαίνει στη Δανία να τον συναντήσει. Τότε µαθαίνει ότι σε αντάλλαγµα θα πρέπει να τον βοηθήσει να βρει την αγαπηµένη σύντροφο της ζωής του. Η αναζήτηση της Αµίνα στέλνει τη Νόρα σε µυστικές πολιτείες όπου οι πρόσφυγες κρύβονται από τις αρχές και σύντοµα η παράτολµη δηµοσιογράφος γίνεται επικίνδυνη για τον ίδιο της τον εαυτό καθώς µπλέκεται σε έναν κόσµο όπου ορισµένες ζωές έχουν µικρότερη αξία από άλλες. ΕΠΙΚΙΝΔΥΝΕΣ ΔΙΑΔΡΟΜΕΣ ΜΕΣΑ ΣΤΟΥΣ ΛΑΒΥΡΙΝΘΟΥΣ ΤΟΥ ΕΓΚΛΗΜΑΤΟΣ ΚΑΙ ΤΗΣ ΑΓΑΠΗΣ ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Η Τέιλς έχει γράψει ένα σύγχρονο αστυνομικό μυθιστόρημα που δίνει απαντήσεις σε πολλά σημαντικά ερωτήματα. Μια συναρπαστική ιστορία γεμάτη τρόμο αλλά και απροσδόκητα ευχάριστες στιγμές. Crime Garden Μια άκρως συναρπαστική, δραματική ιστορία με τη σωστή δόση σασπένς που πρέπει να έχει ένα θρίλερ για να μην μπορείς να το αφήσεις από τα χέρια σου. Ostra Smaland Nyheter',
    'http://books.google.com/books/content?id=H36zDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322316',
    'Ματωμένη έρημος',
    'Metaichmio Publications',
    544,
    'ΕΝΑΣ ΒΑΣΑΝΙΣΜΕΝΟΣ ΜΠΑΤΣΟΣ Ο Αλµπέρτους Μπίσλααρ έχει εγκαταλείψει το απαιτητικό αστυνοµικό του πόστο και µια αποτυχηµένη σχέση στο Γιοχάνεσµπουργκ για µια θέση στα µετόπισθεν – στις παρυφές της ερήµου Καλαχάρι. Αλλά το όνειρό του να ζήσει µια ήρεµη ζωή στην ύπαιθρο σύντοµα γκρεµίζεται από το ξέσπασµα της βίας στην περιοχή. ΜΙΑ ΑΓΡΙΑ ΔΟΛΟΦΟΝΙΑ. ΜΙΑ ΣΥΓΚΛΟΝΙΣΜΕΝΗ ΝΟΤΙΟΑΦΡΙΚΑΝΙΚΗ ΚΟΙΝΟΤΗΤΑ Όταν µια εκκεντρική λευκή καλλιτέχνιδα και η µαύρη τετράχρονη θετή της κόρη δολοφονούνται στη φάρµα τους, οι εξαγριωµένοι λευκοί αγρότες στρέφουν τις υποψίες τους εναντίον του ιθαγενούς επιστάτη. ΤΑ ΜΥΣΤΙΚΑ ΟΛΩΝ ΓΥΜΝΑ ΣΤΟ ΑΝΕΛΕΗΤΟ ΦΩΣ ΤΗΣ ΕΡΗΜΟΥ Στην προσπάθειά του να βρει τον δολοφόνο ο Μπίσλααρ θα βυθιστεί στις ραδιουργίες και τις φυλετικές εντάσεις της κοινότητας και θα διαπιστώσει ότι η βία δεν έχει γεωγραφικά και εθνικά σύνορα. ΥΠΟΨΗΦΙΟ ΓΙΑ ΤΟ INTERNATIONAL DAGGER AWARD ΒΡΑΒΕΙΟ ΠΡΩΤΟΕΜΦΑΝΙΖΟΜΕΝΟΥ ΣΥΓΓΡΑΦΕΑ ΤΟΥ ΠΑΝΕΠΙΣΤΗΜΙΟΥ ΤΟΥ ΓΙΟΧΑΝΕΣΜΠΟΥΡΓΚ ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Μία σηµαντική νέα φωνή από την Αφρική µάς εισάγει σε έναν κόσµο συχνά αθέατο. Ένα καθηλωτικό θρίλερ που διερευνά το συγκρουσιακό παρελθόν της Νότιας Αφρικής. Sawubona Πλοκή που βάζει φωτιά στις σελίδες. Η αστυνοµική λογοτεχνία στο απόγειό της. Mike Nicol, συγγραφέας',
    'http://books.google.com/books/content?id=oYWzDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'CHI',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322330',
    'Γκίλιαντ',
    'Metaichmio Publications',
    336,
    'ΔΙΕΘΝΕΣ ΜΠΕΣΤ ΣΕΛΕΡ ΒΡΑΒΕΙΟ ΤΟΥ ΚΥΚΛΟΥ ΤΩΝ ΑΜΕΡΙΚΑΝΩΝ ΚΡΙΤΙΚΩΝ Μια από τις µεγαλύτερες µορφές της σύγχρονης αµερικανικής πεζογραφίας, η πολυβραβευµένη Marilynne Robinson µε αυτό το βιβλίο µάς προσφέρει ένα βαθιά ανθρώπινο µυθιστόρηµα που αφηγείται την ιστορία τριών γενιών και καλύπτει χρονικά την περίοδο από τον αµερικανικό Εµφύλιο ως τον 20ό αιώνα. Στον πυρήνα του βρίσκονται οι σχέσεις ανάµεσα σε πατέρες και γιους, καθώς και οι µεγάλες πνευµατικές διαµάχες που ακόµη µαίνονται στην καρδιά της Αµερικής. Το µυθιστόρηµα της Robinson, που ακολουθεί τη συγγραφική παράδοση των Έµιλι Ντίκινσον και Γουόλτ Γουίτµαν, είναι µεγάλο όσο ένα έθνος, ήσυχο όσο µια σκέψη, κατανυκτικό όσο µια προσευχή. Μέσα από τη λαµπρή και αξέχαστη φωνή του ήρωά του, του πάστορα Τζον Έιµς, το Γκίλιαντ µάς αποκαλύπτει την ανθρώπινη συνθήκη και τη συχνά αβάσταχτη οµορφιά µιας συνηθισµένης ζωής. ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Το Γκίλιαντ µάς θυµίζει πως οι λέξεις έχουν τη δύναµη να µας προσφέρουν έλεος, συγχώρεση και να αποδώσουν δικαιοσύνη. Independent Σε µια εποχή που η πολιτιστική µας ιστορία κατακλύζεται από το εφήµερο, το επιφανειακό, το εύκολο, η Marilynne Robinson είναι µια θαυµαστή ανωµαλία: µια συγγραφέας που µε περίσκεψη, προσοχή και επιµονή διερευνά κάποια από τα βαθύτερα ζητήµατα που αφορούν το ανθρώπινο είδος... Εύστοχο, καθηλωτικό, λυρικό... Η Robinson καταφέρνει να µας µεταδώσει το θαύµα της ίδιας της ύπαρξης. Los Angeles Times Book Review.',
    'http://books.google.com/books/content?id=p4WzDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322644',
    'Θέα Ακρόπολη',
    'Metaichmio Publications',
    216,
    'Kαλοκαίρι του 1992. Πίσω από την επιβλητική πρόσοψη του ξενοδοχείου Athens Excelsior στην πλατεία Συντάγματος, μια αόρατη κυψέλη εργαζομένων ζει και δρα μακριά από τα βλέμματα της πελατείας, στα γραφεία, στα υπόγεια, στους διαδρόμους και στα δωμάτια των ορόφων. Ανάμεσά τους, ένας υποδειγματικός ρεσεψιονίστ, μια ιδιόρρυθμη καμαριέρα, ένας πρώην σεκιουριτάς και μια νεαρή διοικητική υπάλληλος αποκαλύπτουν τα οικογενειακά τους δράματα, τους δυνατούς έρωτες και τους προσωπικούς τους δαίμονες. Παράλληλα, ένα πλήθος επώνυμων και μη πελατών ζωντανεύουν το κλίμα της εποχής και την ατμόσφαιρα του ξενοδοχείου. Μυστικά του επαγγέλματος και απόκρυφα της γοητευτικής παράστασης που δίνουν οι ένστολοι υπάλληλοι χρωματίζουν τους χαρακτήρες τους, ενώ όταν ο ρόλος του καθενός έχει τελειώσει, σαν ηθοποιοί αλλάζουν ρούχα και επιστρέφουν σε μια πολύ διαφορετική καθημερινότητα. Πίσω από το γκισέ είχε καλλιεργήσει το προσωπικό του γούστο ο Μάκης, παρατηρώντας τους πελάτες και αποκτώντας σιγά σιγά γνώση και άποψη για το στιλ της δικής του εμφάνισης. Όταν είχε πρωτοπιάσει δουλειά, οι γυναίκες που έμεναν εκεί ήταν, στα μάτια του, σαν βγαλμένες από περιοδικά, απλησίαστες, σχεδόν τέλειες, γιατί κινούνταν με άνεση, σαν να κυκλοφορούσαν στο σπίτι τους, σαν το μεγαλοπρεπές και επιβλητικό λόμπι του ξενοδοχείου να ήταν το σαλόνι τους. Για μια τέτοια ψευδαίσθηση πλήρωναν, μαζί και την ικανοποίηση πως φαίνονταν και ήταν πελάτες του Athens Excelsior• ακόμα κι αν σε μερικούς προκαλούσε αμηχανία η πολυτέλεια των χώρων και το απόμακρο αλλά άψογο ύφος των υπαλλήλων• ακόμα κι αν κάποιοι από αυτούς προσπαθούσαν να ντυθούν και να συμπεριφερθούν έτσι ώστε να ταιριάξουν στο προφίλ των πελατών του ξενοδοχείου ή είχαν τον φόβο μήπως ξεπέσουν στα μάτια του προσωπικού, το οποίο περίμενε από αυτούς, εκτός από μια συγκεκριμένη εμφάνιση και συμπεριφορά, και γερά φιλοδωρήματα.',
    'http://books.google.com/books/content?id=7aC6DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322668',
    'Δεσμοί αίματος',
    'Metaichmio Publications',
    384,
    'ΑΣΤΥΝΟΜΙΚΟ ΜΥΘΙΣΤΟΡΗΜΑ ΤΗΣ ΧΡΟΝΙΑΣ (2015) ΣΥΜΦΩΝΑ ΜΕ ΤΟΥΣ NEW YORK TIMES, ΤΟΥΣ LOS ANGELES TIMES, ΤΟΥΣ IRISH TIMES Εφτά χρόνια πριν, ο δωδεκάχρονος τότε Κίαρον Ντιβάιν έγινε πρωτοσέλιδο στις εφηµερίδες, καθώς οµολόγησε τη στυγνή δολοφονία του ανάδοχου κηδεµόνα του. Χάρη στην κατάθεσή του, η ποινή του µεγαλύτερου αδερφού του Τόµας, που επίσης βρέθηκε στη σκηνή του εγκλήµατος, βουτηγµένος στο αίµα, µειώθηκε. Αλλά η αρχιεπιθεωρήτρια Σερίνα Φλάναγκαν, η µοναδική αστυνοµικός που µπόρεσε να πείσει τον φοβισµένο Κίαρον να µιλήσει, έχει διατηρήσει τις αµφιβολίες της σχετικά µε την οµολογία του όλα αυτά τα χρόνια. Η αποφυλάκιση του Κίαρον σηµαίνει πλέον πολλά πράγµατα: την επανένωση µε τον αδερφό του Τόµας, που εξακολουθεί να ασκεί επικίνδυνη επιρροή στον µικρό του αδερφό• την πυροδότηση µιας φονικής αλυσίδας, καθώς ο γιος του θύµατος έχει ορκιστεί να εκδικηθεί τον φόνο του πατέρα του, και πολλά προβλήµατα για την επιτηρήτρια αναστολής του Κίαρον. Στο µεταξύ, η Σερίνα Φλάναγκαν έχει µόλις επιστρέψει στην ενεργό δράση έπειτα από τη µάχη που έδωσε µε τον καρκίνο του µαστού και δεν έχει να αντιµετωπίσει µόνο ένα βουνό από ανοιχτές υποθέσεις αλλά και τα γεµάτα λύπηση βλέµµατα των συναδέλφων της. Σύντοµα θα ανακαλύψει ότι ακόµα και οι υποθέσεις που έχουν κλείσει µπορούν να σκορπίσουν τον τρόµο στους δρόµους του Μπέλφαστ.',
    'http://books.google.com/books/content?id=P6G6DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'KIK',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322682',
    'Η ανθρώπινη μοίρα',
    'Metaichmio Publications',
    408,
    'Το µυθιστόρηµα διαδραµατίζεται στη Σανγκάη, το 1927, την περίοδο της συντριβής των Κοµµουνιστών από τον, µέχρι πρότινος σύµµαχό τους, Τσανγκ Κάι-σεκ και τους εθνικιστές. Οι κεντρικοί ήρωες είναι Κινέζοι κοµµουνιστές και Ευρωπαίοι πλάνητες που πέφτουν θύµατα προδοσίας από τους εθνικιστές και τους Σοβιετικούς. Καθένας τους είναι µια πολυσχιδής και στοχαστική προσωπικότητα που επηρεάζεται διαφορετικά από το τραγικό πεπρωµένο του, αλλά η συντροφικότητα και ο κοινός αγώνας µοιάζουν να είναι το µόνο αντίδοτο στη θλιβερή µοναξιά που σφραγίζει την ανθρώπινη µοίρα. Εκρηκτικό και επίκαιρο σήµερα όπως και την εποχή που εκδόθηκε, το 1933, το βιβλίο θεωρείται το αριστούργηµα του Αντρέ Μαλρό, που χάρισε στον δηµιουργό του διεθνή αναγνώριση και το βραβείο Goncourt. «Το µυθιστόρηµα του Μαλρό µε την αδιάλειπτη ένταση, τον σχεδόν βίαιο ρυθµό, που διακόπτεται από παύσεις στοχαστικές, άκρως φιλοσοφικές, εξελίσσεται σε ένα µάθηµα συνειδησιακής ροής. Το ιδιότυπο χιούµορ του συγγραφέα ξεπηδά από τη διάθεση των ηρώων του να κόψουν κατά σηµεία το νήµα της αφήγησης, παίρνοντας µια ανάσα από τα συγκλονιστικά γεγονότα στα οποία συµµετέχουν και αφηγούνται. Η Ανθρώπινη µοίρα θα µπορούσε άνετα να τοποθετηθεί σε οποιοδήποτε λιµάνι της Ευρώπης, αλλά τοποθετείται στη Σανγκάη του µεσοπολέµου, η οποία αναδεικνύεται σε πρωτεύουσα της οδύνης. […] Η αναγνωστική εµπειρία της Ανθρώπινης µοίρας µάς θυµίζει ότι κάθε ιστορικό γεγονός γίνεται γρήγορα µύθος και ως τέτοιος προσφέρεται προκειµένου να αναδειχθεί ξανά µέσα από αυτόν ένας Σίσυφος, ένας Άµλετ ή ένας Προµηθέας. Στο µυθιστόρηµα του Μαλρό βαραίνει η σκιά του Προµηθέα, ενός υπεράνθρωπου επαναστάτη που φέρεται να δηλώνει: «Εν αρχή ην η πράξη και όχι ο λόγος!». Από τον πρόλογο του Δηµήτρη Στεφανάκη ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Ένα γνήσιο ποιητικό δηµιούργηµα. J. B. Priestley, συγγραφέας',
    'http://books.google.com/books/content?id=q8e8DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180322798',
    'Ένα παιδί από το πουθενά',
    'Metaichmio Publications',
    176,
    'Τον λένε Ίκαρο Λαμπρίδη, είναι δέκα χρονών και μένει στο Παγκράτι με τη θεία του Ελένη Ιοκάστη Καποδίστρια. Θα ’θελε να είχε πατέρα τον Τζο Νέσμπο, που όλοι λένε ότι του μοιάζει. Ζηλεύει που η θεία αποκαλεί αγόρι της τον παπαγάλο. Φίλοι του είναι μεγαλύτεροι σε ηλικία, ένας άστεγος και ο γυμναστής του. Δεν καταλαβαίνει γιατί οι συμμαθητές του τον κοροϊδεύουν. Και κυρίως δεν καταλαβαίνει γιατί οι γονείς των συμμαθητών του δεν αφήνουν τα προσφυγόπουλα να μπουν στην αυλή του σχολείου. Η θεία όμως… H Άλκη Ζέη γράφει μια ιστορία για τα παιδιά και τα προβλήματά τους σήμερα.',
    'http://books.google.com/books/content?id=BOm9DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180323887',
    'Η ανάκριση',
    'Metaichmio Publications',
    144,
    'Η Μαρίνα είναι μία οργισμένη καλλιτέχνις, μία ηδονοθήρας που πασχίζει να δραπετεύσει από την εμμονή της με τον σωματικό και ψυχικό βιασμό που υπέστη ο πατέρας της στα κολαστήρια της ΕΑΤ/ΕΣΑ. Καμβάς της τέχνης της και σάκος του μποξ το σώμα της, το οποίο βασανίζει η ίδια εξαιτίας των διατροφικών της διαταραχών. Όταν αποφασίζει να υποβάλει τον πατέρα της σε μια νέα άτυπη ανάκριση έρχεται η στιγμή της μεγάλης σύγκρουσης. Μια ιδιότυπη ματιά στην Αθήνα του σήμερα, με αναδρομές στα σκοτεινά χρόνια της δικτατορίας. Μια φρέσκια, σπαρταριστή, καθαρή ανάγνωση, καθόλου φορτισμένη πολιτικά, καθόλου νοσταλγική, καθόλου αφοριστική. Ο συγγραφέας δεν χαρίζεται σε κανέναν, ούτε σε βασανιστές, ούτε σε θύματα. Εξάλλου οι ήρωές του είναι συνεχώς και τα δύο: θύματα και βασανιστές. Το βιβλίο μεταφέρθηκε στον κινηματογράφο σε σκηνοθεσία Παναγιώτη Πορτοκαλάκη.',
    'http://books.google.com/books/content?id=GfvLDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180324082',
    'Κρίση ταυτότητας',
    'Metaichmio Publications',
    464,
    'Η συνέχεια των περιπετειών ενός από τους πιο εμβληματικούς χαρακτήρες του μεσογειακού νουάρ γραμμένη από έναν σύγχρονο συγγραφέα.',
    'http://books.google.com/books/content?id=iSJeEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180324112',
    'Μαύρη λίστα',
    'Metaichmio Publications',
    544,
    'Ένα συναρπαστικό θρίλερ για μια σειρά δολοφονιών στο κατεστραμμένο από τους βομβαρδισμούς Βερολίνο, από τον διακριθέντα με το βραβείο Friedrich Glauser, Harald Gilbers.',
    'http://books.google.com/books/content?id=5XT_DwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'BUR',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180324129',
    'Παραπλάνηση',
    'Metaichmio Publications',
    480,
    'Ο συγγραφέας Ιωάννης Πατρίκιος βλέπει την καριέρα του να βυθίζεται, ύστερα από την έκδοση του τρίτου βιβλίου του, καθώς η έμπνευση φαίνεται να τον έχει εγκαταλείψει. Η φίλη του Ηλιάνα Πετράκη τον φέρνει σε επαφή με μια ιδιόρρυθμη ψυχολόγο, την Άρτεμις Βάλενταλ. Η Βάλενταλ αντιλαμβάνεται σύντομα την εμμονή του Πατρίκιου να γράψει ένα μπεστ σέλερ που θα περιγράφει μια σειρά αποτρόπαιων, φρικιαστικών εγκλημάτων. Και τότε η Αστυνομία ανακαλύπτει το πτώμα μιας νεαρής κοπέλας από το οποίο έχει αφαιρεθεί η καρδιά. Η δολοφονία πυροδοτεί τον εμμονικό συγγραφέα κι αρχίζει να γράφει πυρετωδώς το νέο του μυθιστόρημα. Κι όταν ακολουθεί ένα δεύτερο πτώμα δολοφονημένο με το ίδιο μοτίβο, ο Πατρίκιος συνεχίζει τη συγγραφή με ιλιγγιώδη ρυθμό κι η Βάλενταλ συνειδητοποιεί ότι κάτι τρομακτικό κρύβεται πίσω από τις διαδοχικές δολοφονίες. Η αστυνόμος Τρύπη και η ομάδα ερευνών του Τμήματος Εγκλημάτων κατά Ζωής έχουν αυτή τη φορά απέναντί τους τον πιο ιδιόμορφο, διαταραγμένο σίριαλ κίλερ στα σύγχρονα εγκληματολογικά χρονικά. Κι όσο οι φόνοι συνεχίζονται, η Τρύπη και η ομάδα της νιώθουν να βυθίζονται στα έγκατα του σκοτεινού τρόμου, σ’ ένα απύθμενο τούνελ χωρίς την παραμικρή φωτεινή αχτίδα.',
    'http://books.google.com/books/content?id=llnwDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'CEB',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180324143',
    'Ο Παριζιάνος',
    'Metaichmio Publications',
    752,
    'Ενώ ο Πρώτος Παγκόσμιος Πόλεμος διαλύει οικογένειες, καταστρέφει φιλίες και σκοτώνει εραστές, ένας νεαρός Παλαιστίνιος ονειροπόλος προσπαθεί να ανακαλύψει τον εαυτό του. Ο Μιντχάτ Καμάλ κινείται σε έναν θρυμματισμένο κόσμο, από τις πολιτικές εξελίξεις στη Μέση Ανατολή στα σαλόνια του Μονπελιέ και ενός τρικυμιώδους Παρισιού. Διαπιστώνει πως όλα είναι εύθραυστα: ο έρωτας γίνεται απώλεια, οι φίλοι εχθροί και όλοι ψάχνουν κάπου να ανήκουν. Μια βαθιά ανθρώπινη ιστορία εν μέσω μιας παγκόσμιας σύρραξης· ένα ιστορικό μυθιστόρημα με εξαιρετικά σύγχρονη φωνή. ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Τεκμηριωμένο και σαγηνευτικό… Η ακριβής ανάκληση του τόπου και των χαρακτήρων εξασφαλίζει ότι ο αναγνώστης δεν θα χαθεί ποτέ… Η δεξιοτέχνισσα συγγραφέας τον τοποθετεί σταθερά στον χώρο, κρατώντας έτσι αμείωτη την προσοχή του στις ζωές που διασταυρώνονται. Wall Street Journal Υπέροχο… Η συγγραφέας ελέγχει το θέμα της με μεγάλη κομψότητα… Ο Παριζιάνος γράφει ιστορία και οι πρωταγωνιστές του ζουν ακόμα μια φορά. Boston Globe',
    'http://books.google.com/books/content?id=KRjkDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'KUR',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180324440',
    'Ο τόπος',
    'Metaichmio Publications',
    112,
    'Η Annie Ernaux, μία από τις σημαντικότερες σύγχρονες συγγραφείς της Γαλλίας, σ’ αυτό το εμβληματικό αυτοβιογραφικό αφήγημα γράφει με βάση την προσωπική της εμπειρία για όλα όσα συνδέουν αλλά και απομακρύνουν τους πατεράδες από τις κόρες αναλύοντας τι σημαίνει να χάνεις έναν γονιό, τα παιχνίδια που παίζει η μνήμη, τη σταδιακή αποξένωση ανάμεσα σε άτομα διαφορετικών γενιών και κοινωνικών τάξεων. Ένα βιβλίο πάνω στο ορυκτό βίωμα. Πώς οι σπουδές αλλάζουν τον άνθρωπο. Πώς ανοίγει κάτω απ’ τα πόδια σου γκρεμός, που σε ξεκόβει από την παλιά ζωή. Πώς ο γονιός πεθαίνει, γίνεται ανάμνηση. Δεν λες τα λόγια που πρέπει την ώρα που πρέπει, γιατί δεν ξέρεις πώς να τα πεις. Και εκ των υστέρων, τα γράφεις. Ο πόνος αγκαλιά με τη χαρά. Η βαθιά περηφάνια του πατέρα. Η κόρη του ανήκει πια «στον κόσμο που τον είχε καταφρονήσει». Το βιβλίο αυτό μιλάει για τους ανθρώπους που μας γέννησαν. Για τη μέγγενη του περιβάλλοντος, το τι σημαίνει να είσαι πατέρας, αλλά και να είσαι η κόρη αυτού του πατέρα. από το προλογικό σημείωμα της Σοφίας Νικολαΐδου ΕΓΡΑΨΑΝ ΓΙΑ ΤΟ ΒΙΒΛΙΟ Όμορφη γραφή γεμάτη χάρη… Η Ερνό αξίζει και με το παραπάνω τη διεθνή της φήμη που ξεπερνάει όλο και περισσότερα σύνορα. New York Times Ένα λαμπρό λογοτεχνικό επίτευγμα, που πάλλεται από συγκρατημένο συναίσθημα. Le Monde Αριστούργημα… Σε κατακλύζει… Paris-Match',
    'http://books.google.com/books/content?id=kPHXDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180325539',
    'Καλό μου παιδί',
    'Metaichmio Publications',
    416,
    'Ένα καθηλωτικό θρίλερ που ξεκινάει από εκεί που τα άλλα σταματούν.',
    'http://books.google.com/books/content?id=X3knEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180325560',
    'Το Μαγικό Αρωματοπωλείο 4: Το Τουρνουά των Χιλίων Εκλεκτών',
    'Metaichmio Publications',
    168,
    'Βαθιά μέσα της, η Λούτσι το ξέρει: η πρόσκληση που κρατάει στα χέρια της δεν είναι καθόλου αθώα. Η αντίπαλός της, η Ελοντί ντε Ριτσμόντ, την προσκαλεί στο «Τουρνουά των Χιλίων Εκλεκτών» - μία αναμέτρηση που στόχο έχει να αναδείξει τους καλύτερους αρωματοποιούς στον κόσμο. Στην πραγματικότητα, πρόκειται για μια προσπάθεια της Ελοντί να ανακαλύψει ταλαντούχους Sentifleurs και να τους βάλει να εργαστούν στα αρωματοπωλεία της. Η Λούτσι δεν έχει άλλη επιλογή: πηγαίνει στην Αγγλία για να λάβει μέρος στον αγώνα. Μαζί της ο Ματς, ο Λέον και ο Νταν ντε Μπραν. Σύντομα όμως το παιχνίδι εξελίσσεται σε αγώνα επιβίωσης και η Λούτσι κινδυνεύει να χάσει όλα όσα αγάπησε ποτέ της.',
    'http://books.google.com/books/content?id=iyJeEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180326376',
    '1984',
    'Metaichmio Publications',
    448,
    'Ένα από τα πιο εμβληματικά και ταυτόχρονα τρομακτικά μυθιστορήματα που γράφτηκαν ποτέ, το 1984 είναι ένα σπάνιο έργο που μας στοιχειώνει όλο και περισσότερο καθώς το δυστοπικό μέλλον το οποίο περιγράφει γίνεται όλο και πιο αληθινό.',
    'http://books.google.com/books/content?id=f1lcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180326550',
    'Πριν χαθούν τα πουλιά',
    'Metaichmio Publications',
    392,
    'Μια ωδή στους άγριους τόπους και τα πλάσματα που τώρα απειλούνται, και μια επική ιστορία για τη δυνατότητα της ελπίδας πέρα από κάθε πρόβλεψη. Ένα άγριο, καθηλωτικό και βαθιά συγκινητικό μυθιστόρημα.',
    'http://books.google.com/books/content?id=6VhcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180326956',
    'Το ένστικτο',
    'Metaichmio Publications',
    360,
    'Ένα μυθιστόρημα για τη δημιουργία και τη διάλυση μιας οικογένειας, μέσα από τα μάτια μιας γυναίκας που βιώνει τη μητρότητα τελείως διαφορετικά απ’ ό,τι ονειρευόταν – στην πραγματικότητα, τη βιώνει ακριβώς όπως φοβόταν...',
    'http://books.google.com/books/content?id=N1hcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'LUG',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180326970',
    'Πότε διάβολος πότε άγγελος',
    'Metaichmio Publications',
    256,
    'Ένα μυθιστόρημα που δεν είναι ακριβώς ιστορικό, αλλά μάλλον μια σύγχρονη εξιστόρηση που από τη μια ψάχνει να ανακαλύψει ποιος ήταν ο Καραϊσκάκης και από την άλλη τι σημαίνει να είσαι ένας οιονεί απόγονός του.',
    'http://books.google.com/books/content?id=na0mEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180327007',
    'Ένοχος μέχρι αποδείξεως του εναντίου',
    'Metaichmio Publications',
    464,
    'Η τέταρτη περιπέτεια του Χάρη Νικολόπουλου θα τον οδηγήσει από τη Ναύπακτο στην Αθήνα, όπου θα βρει μια πόλη αλλαγμένη από την οικονομική κρίση.',
    'http://books.google.com/books/content?id=o1hcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'HUN',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180327090',
    'Η τέχνη και τα αντίδοτα του Έρωτα',
    'Metaichmio Publications',
    240,
    'Το έμμετρο αυτό εγχειρίδιο περιλαμβάνει 3 βιβλία ερωτικής κατήχησης. Στα δύο πρώτα ο Οβίδιος, προφέσορας του έρωτα, μοιράζει αφειδώς συμβουλές στους επίδοξους γόητες της Ρώμης. Στο τρίτο καλεί τις γυναίκες να ενισχύσουν το «σεξ απίλ» τους και να ασκηθούν στις κατάλληλες «στάσεις» – για χάρη των ανδρών.',
    'http://books.google.com/books/content?id=M1hcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180327717',
    'Το μπλουζ της πεταλούδας',
    'Metaichmio Publications',
    232,
    'Ένα μαύρο αστυνομικό μυθιστόρημα, με έντονη σατιρική διάθεση, που διαδραματίζεται στην Αθήνα και στη Μύκονο.',
    'http://books.google.com/books/content?id=XClcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180328134',
    'Ιστορία του κόσμου σε 10 μισό κεφάλαια (ebook/ePub)',
    'Metaichmio Publications',
    464,
    'Ο Μπαρνς συνθέτει μια ιστορία ασυνήθιστη, ελαφρώς παράξενη, που συνιστά μια απολαυστική πρόκληση για τη φαντασία του αναγνώστη.',
    'http://books.google.com/books/content?id=ZqwzEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180328226',
    'Το καλοκαίρι',
    'Metaichmio Publications',
    296,
    'Η συνέχεια του πρότζεκτ των τεσσάρων εποχών του Luca Ricci. Μετά Το φθινόπωρο έρχεται Το καλοκαίρι, μια ιστορία ερωτικής εμμονής.',
    'http://books.google.com/books/content?id=3CdcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180328356',
    'Σάγκι Μπέιν',
    'Metaichmio Publications',
    528,
    'Είναι 1981. Η Γλασκόβη πεθαίνει, οι πολιτικές της Θάτσερ έχουν βυθίσει συζύγους και γιους στην ανεργία, και τίμιες οικογένειες καταφεύγουν σε κομπίνες για να επιβιώσουν. Η Agnes Bain ανέκαθεν είχε μεγαλύτερες προσδοκίες από τη ζωή. Ονειρεύεται πράγματα πιο σπουδαία: ένα σπίτι με δική του κεντρική είσοδο και μια ζωή αγορασμένη και εξοφλημένη αμέσως, σαν τα τέλεια, αλλά ψεύτικα, δόντια της. Όμως ο άντρας της, ένας γυναικάς ταξιτζής, την παρατάει, και σύντομα η Agnes και τα τρία παιδιά της βρίσκονται παγιδευμένοι σε μια διαλυμένη πόλη ανθρακωρύχων. Καθώς η μητέρα τους κατρακυλάει ακόμα βαθύτερα στον αλκοολισμό, τα παιδιά κάνουν ό,τι μπορούν για να τη βοηθήσουν, όμως ένα ένα αναγκάζονται να φύγουν για να σωθούν. Μόνο ο μικρός της γιος, ο Shuggie, αρνείται να σταματήσει να ελπίζει. Ένα σκληρό μυθιστόρημα που αποκαλύπτει τις δυσκολίες της φτώχειας, τα όρια της αγάπης, και την κενότητα της περηφάνιας.',
    'http://books.google.com/books/content?id=CpY0EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180328394',
    'Αυτοί που επέζησαν',
    'Metaichmio Publications',
    448,
    'Το πολυαναμενόμενο τέταρτο μυθιστόρημα της βραβευμένης Jane Harper, που αυτή τη φορά μας ταξιδεύει στις ακτές της Τασμανίας. ΜΠΕΣΤ ΣΕΛΕΡ ΤΩΝ NEW YORK TIMES ΥΠΟΨΗΦΙΟ ΓΙΑ ΤΑ INDIE BOOK AWARDS 2021 Μερικοί τύποι δεν καταλαβαίνουν παρά μόνο ένα δυνατό, σταθερό «ΟΧΙ». Η ζωή του Κίρεν Έλιοτ μέσα σε μια μέρα άλλαξε για πάντα, από μια απερισκεψία με ολέθριες συνέπειες. Η ενοχή που ακόμα τον κατατρύχει αναδύεται στη διάρκεια μιας οικογενειακής επίσκεψης στη μικρή παραθαλάσσια κοινότητα που κάποτε αποκαλούσε σπίτι του. ΜΕΡΙΚΟΙ ΔΕΝ ΚΑΤΑΛΑΒΑΙΝΟΥΝ ΟΥΤΕ ΚΑΝ ΑΥΤΟ. Οι γονείς του Κίρεν παλεύουν να επιβιώσουν σε μια πόλη όπου η θάλασσα ορίζει τις μοίρες των ανθρώπων. Ανάμεσά τους στέκει πάντα η ανάμνηση του αδερφού του, του Φιν, που χάθηκε πριν δώδεκα χρόνια κατά τη διάρκεια της μεγαλύτερης καταιγίδας των τελευταίων ογδόντα χρόνων. Όταν το πτώμα μιας γυναίκας βρεθεί στην παραλία, βαθιά θαμμένα μυστικά απειλούν να έρθουν στο φως. Ένα ναυάγιο, ένα αγνοούμενο κορίτσι και ερωτήματα που δεν τα πήρε ποτέ το κύμα…',
    'http://books.google.com/books/content?id=gs02EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180328981',
    'Το εξπρές των αρουραίων',
    'Metaichmio Publications',
    448,
    'Η πέμπτη υπόθεση του επιθεωρητή Οπενχάιμερ. Βερολίνο 1947, αρχές του Ψυχρού Πολέµου: Ο επιθεωρητής Οπενχάιµερ φτάνει στη σκηνή του εγκλήµατος. Δεν υπάρχουν πολλά στοιχεία. Το θύµα είναι ένας ληστής που πιάστηκε επ’ αυτοφώρω από τον ιδιοκτήτη του σπιτιού. Εκ πρώτης όψεως όλα δείχνουν ότι πρόκειται για αυτοάµυνα. Ο Οπενχάιµερ, όµως, έχει ορισµένες αµφιβολίες σχετικά µε την αλληλουχία των γεγονότων, αµφιβολίες που σύντοµα θα επαληθευτούν όταν ένα διαβατήριο µε το όνοµα του δράστη της επίθεσης βρεθεί στο σπίτι του δολοφονηµένου. Όταν και ο επιθεωρητής Μπίλχαρντ βρεθεί βαριά τραυµατισµένος µέσα σε ένα κτίριο παγιδευµένο µε εκρηκτικά, ο Οπενχάιµερ θα ανακαλύψει ότι είναι µπλεγµένος σε ένα κύκλωµα παράνοµης φυγάδευσης ναζί. Πρώην µέλη των SS περνούν, µέσω Βατικανού, στην Αργεντινή ακολουθώντας το λεγόµενο «Εξπρές των αρουραίων». Οι υποστηρικτές των ναζί εξακολουθούν να βρίσκονται σε υψηλές θέσεις — όπως επίσης και στην αστυνοµία του Βερολίνου...',
    'http://books.google.com/books/content?id=qrJFEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    1.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329001',
    'England, England',
    'Metaichmio Publications',
    424,
    'Υποψήφιο για το βραβείο Booker το 1998 το βιβλίο England, England του Τζούλιαν Μπαρνς είναι ένα από τα πιο ευφυή και απολαυστικά μυθιστορήματα της σύγχρονης αγγλικής λογοτεχνίας. Υποψήφιο για το βραβείο Booker το 1998 το βιβλίο England, England του Τζούλιαν Μπαρνς είναι ένα από τα πιο ευφυή και απολαυστικά μυθιστορήματα της σύγχρονης αγγλικής λογοτεχνίας. Με αφετηρία την παραδοχή ότι η σύγχρονη Αγγλία ζει ουσιαστικά από τον τουρισμό της και ότι οι περισσότεροι τουρίστες ενδιαφέρονται μόνο για τα βασικά αξιοθέατα της πόλης και ικανοποιούνται εξίσου με ένα ομοίωμα του αληθινού, ο ιδιόρρυθμος μεγιστάνας σερ Τζακ Πίτμαν συλλαμβάνει την εξαιρετική ιδέα να μεταφέρει εικονικά την Αγγλία στη Νήσο Γουάιτ και να επωφεληθεί επιχειρηματικά από αυτό. Για την υλοποίηση αυτού του μεγαλόπνοου Σχεδίου προσλαμβάνει τη Μάρθα Κοχρέιν ως Επαγγελματία Κυνική για να συνεργαστεί με τον Υπεύθυνο έργου, τον Καταγραφέα Ιδεών και τον Επίσημο Ιστορικό. Ο σερ Τζακ Πίτμαν μετατρέπει τη Νήσο Γουάιτ σε ένα κολοσσιαίο πάρκο – κέντρο εθνικής κληρονομιάς – όπου υπάρχουν από τον Ρομπέν των Δασών και την αγαπημένη του Μάριον, μέχρι τα Ανάκτορα του Μπάκιγχαμ, το Στόουνχεντζ, τα μαύρα ταξί, η βασιλική οικογένεια, οι πράκτορες της Σκότλαντ Γιάρντ, η Μάντσεστερ Γιουνάιτεντ και τα Βράχια του Ντόβερ. Η νήσος Γουάιτ μετονομάζεται σε England-England και το Σχέδιο, τερατώδες, ριψοκίνδυνο και εφιαλτικό γνωρίζει απόλυτη επιτυχία. Τόση που το England-England ανταγωνίζεται την αληθινή Αγγλία και απειλεί να την εκτοπίσει. Ο κόσμος της τρίτης χιλιετίας είναι αναπόφευκτα μοντέρνος και είναι πνευματικό μας χρέος να υποταχτούμε σ’ αυτόν το μοντερνισμό και να απορρίψουμε ως μελοδραματική και εγγενώς απατηλή κάθε λαχτάρα για το διφορούμενα αποκαλούμενο αυθεντικό. Πρέπει να απαιτήσουμε τη ρεπλίκα καθώς η πραγματικότητα, η αλήθεια, η αυθεντικότητα της ρεπλίκας είναι αυτό που μπορούμε να κατακτήσουμε, να αποικήσουμε, να αναδιατάξουμε..., λέει σε ένα παραληρηματικό μονόλογο ο γάλλος διανοούμενος του μυθιστορήματος. Ο Τζούλιαν Μπαρνς μάς δίνει ένα ανελέητο μυθιστόρημα. Αιχμηρό και διεισδυτικό τόσο στους χαρακτήρες όσο και στη μυθοπλασία του England, England είναι το ευαγγέλιο του σύγχρονου κόσμου. Δραματικό όσο και σατιρικό το βιβλίο του Τζούλιαν Μπαρνς θα σας οδηγήσει σε ανατροπές και απολαύσεις υψηλής αισθητικής. Επισκεφθείτε το site του συγγραφέα.',
    'http://books.google.com/books/content?id=uLJFEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329049',
    'Το χαμένο κορίτσι',
    'Metaichmio Publications',
    264,
    'Η καινούρια μαθήτρια Λίζι Γουόκερ στο λύκειο Σέιντισαϊντ Χάι παρασύρεται σε μια τραγική ιστορία προδοσίας που πηγαίνει περισσότερο από 60 χρόνια πριν. Η καινούρια µαθήτρια Λίζι Γουόκερ είναι το θέµα συζήτησης στο λύκειο Σέιντισαϊντ Χάι. Ο Μάικλ και το κορίτσι του, η Πέπερ, γίνονται φίλοι µαζί της, όµως όσο περισσότερο τη γνωρίζουν, τόσο πιο παράξενη τη βρίσκουν... κι ο Μάικλ πιο ελκυστική. Την καλεί να πάει µαζί του σε έναν αγώνα σνόουµοµπιλ, που καταλήγει όµως σε τραγικό ατύχηµα. Σύντοµα οι φίλοι του Μάικλ αρχίζουν να δολοφονούνται και η Πέπερ είναι σίγουρη ότι πίσω από τους φόνους κρύβεται η Λίζι. Έντροµη όµως ανακαλύπτει ότι εκείνη και ο Μάικλ έχουν παρασυρθεί σε µια σκοτεινή ιστορία προδοσίας και εκδίκησης που πηγαίνει περισσότερο από 60 χρόνια πριν. Ο Ρ. Λ. Στάιν επιστρέφει θριαµβευτικά στην εξαιρετικά πετυχηµένη σειρά Οδός Τρόµου, απ’ όπου ξεκίνησε την καριέρα του ως συγγραφέας ιστοριών θρίλερ για το εφηβικό κοινό.',
    'http://books.google.com/books/content?id=5LJFEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329087',
    'Οι φαροφύλακες',
    'Metaichmio Publications',
    472,
    'Μια ιστορία για την απομόνωση και την εμμονή, την κλειστοφοβία και τη βαναυσότητα, την πραγματικότητα και την ψευδαίσθηση – και για το φως που πρέπει να μείνει αναμμένο όταν όλα τα άλλα τα καταπίνει το σκοτάδι… Εμπνευσμένο από πραγματικά γεγονότα.',
    'http://books.google.com/books/content?id=K3xGEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'NYA',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329094',
    'Το ημερολόγιο ενός κλέφτη',
    'Metaichmio Publications',
    344,
    'Το αυτοβιογραφικό μυθιστόρημα του Μαύρου Πρίγκιπα των Γραμμάτων της Γαλλίας, Jean Genet. Το ημερολόγιο ενός κλέφτη είναι ένα κείμενο αυτοβιογραφικό. Ωμό, άγριο, διαστροφικό, άκρως ερωτικό, βαθιά ποιητικό, σκιαγραφεί έναν κόσμο που μας τρομάζει και μας σαγηνεύει συνάμα. Ο Ζενέ γνωρίζει πολύ καλά το κάτεργο, τους φονιάδες, τους κλέφτες, την απαγορευμένη λαγνεία, το πάθος που φουντώνει (και κατατρώει και τον ίδιον)… Υπάρχει και το παρελθόν που τον στοιχειώνει: η εκπόρνευση σε δημόσια ουρητήρια για πενταροδεκάρες, ο φόνος που διαπράττει, η ζωή του ως άστεγος και ρακένδυτος, οι φυλακές… Παρουσιάζει το Κακό σκληρό και ωμό, όπως είναι, και, την ίδια στιγμή, το εξιδανικεύει ως ύψιστο μέσο άντλησης της ηδονής. «Το γράψιμο του ημερολογίου δεν είναι μια μορφή λογοτεχνικής χαλάρωσης. Όσο προχωρώ, βάζοντας σε τάξη ό,τι μου προσφέρει η περασμένη μου ζωή, όσο εμμένω στην ακρίβεια της συγγραφής –των κεφαλαίων, των φράσεων, του ίδιου του βιβλίου–, τόσο περισσότερο αισθάνομαι πως εδραιώνεται η θέλησή μου να χρησιμοποιήσω, για τους σκοπούς της αρετής, την αλλοτινή μου εξαθλίωση. Νιώθω τη δύναμή της».',
    'http://books.google.com/books/content?id=dN5IEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329278',
    'Ταξί',
    'Metaichmio Publications',
    496,
    'Μια σύγχρονη Οδύσσεια εμπνευσμένη από τους Clash και τη φιγούρα του Ταξιτζή όπως τον υποδύθηκε ο Ρόμπερτ Ντε Νίρο.',
    'http://books.google.com/books/content?id=mCdcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329292',
    'Mary',
    'Metaichmio Publications',
    224,
    'Το Mary είναι μια θαυμάσια, κωμική, μεταφυσική, ερωτική ιστορία, ένα νοσταλγικό έργο – το πρώτο μυθιστόρημα του Nabokov.',
    'http://books.google.com/books/content?id=KfRNEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180329667',
    'Utopia avenue',
    'Metaichmio Publications',
    720,
    'Ένα σαγηνευτικό μυθιστόρημα για τη δύναμη της μουσικής να υπερβαίνει τους διαχωρισμούς, να ορίζει τις εποχές και να συνεπαίρνει τις ψυχές.',
    'http://books.google.com/books/content?id=K09PEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180330793',
    'Άνθρωπος Μαρίκα. Από τη Σμύρνη στην Κοκκινιά',
    'Metaichmio Publications',
    128,
    'Τα τραγούδια αφηγούνται τη σύντομη αλλά γεμάτη ζωή μιας γυναίκας που θα μπορούσε να είναι η Μαρίκα Νίνου. Είναι η άνθρωπος Μαρίκα.',
    'http://books.google.com/books/content?id=fJhcEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180332421',
    'Η καμαριέρα',
    'Metaichmio Publications',
    472,
    'Μυστήριο κλειδωμένου δωματίου και συγκινητικό πνευματικό ταξίδι, Η καμαριέρα διερευνά τι σημαίνει να είσαι ίδιος με όλους τους άλλους και ταυτόχρονα ολότελα διαφορετικός – και αποκαλύπτει ότι όλα τα μυστήρια λύνονται, όταν ακούς την καρδιά.',
    'http://books.google.com/books/content?id=3NduEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180332438',
    'Τζακ',
    'Metaichmio Publications',
    432,
    'H βραβευμένη με Πούλιτζερ Marilynne Robinson επιστρέφει στον κόσμο του Γκίλιαντ με το Τζακ, το τέταρτο μυθιστόρημα μιας από τις πιο σημαντικές σειρές της σύγχρονης αμερικάνικης λογοτεχνίας.',
    'http://books.google.com/books/content?id=jNhuEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'TUR',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180333190',
    'Αίμα στις στάχτες',
    'Metaichmio Publications',
    216,
    'Μια ιστορία γεμάτη ψέματα, διαφθορά και αίμα και μια αλήθεια όμοια με το Κουτί της Πανδώρας, επικίνδυνη και έτοιμη να τα κάνει όλα στάχτη.',
    'http://books.google.com/books/content?id=4gpyEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180336108',
    'Παρακαταθήκη',
    'Metaichmio Publications',
    353,
    'Σαγηνευτικό, αινιγματικό και καυστικά επίκαιρο, το δεύτερο μυθιστόρημα του Hernan Diaz Παρακαταθήκη είναι ένα αλησμόνητο, πολύπλευρο έπος που τον καθιερώνει ως έναν από τους σημαντικότερους χρονογράφους της αμερικανικής χίμαιρας.',
    'http://books.google.com/books/content?id=0LOxEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'YOR',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180337389',
    'Ένα καλοκαίρι χωρίς κανόνες',
    'Metaichmio Publications',
    319,
    'Ένα ρομαντικό μυθιστόρημα εμπνευσμένο από τα τραγούδια της Taylor Swift.',
    'http://books.google.com/books/content?id=beHAEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MAI',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180400373',
    'Kρητικοί γάμοι - 1ος τόμος',
    'Pelekanos Books',
    346,
    'Η πρωτεύουσα του βασιλείου που ξεκινά το ιστορικό μυθιστόρημα Κρητικοί γάμοι βρίσκεται στη βενετοκρατούμενη Κρήτη του 16ου αιώνα. Πρωτεύουσα με όχι μεγάλη έκταση που διατηρεί ακέραια τη μεσαιωνική κατήφεια μιας δευτερεύουσας σημασίας ιταλικής πόλης. Έλληνες, Ιταλοί και Εβραίοι συνθέτουν τον πληθυσμό της φθάνοντας περίπου τις 20.000 ψυχές. Η αντίθεση των μεγαλόπρεπων αρχοντικών σπιτιών, των αξιόλογων δημόσιων κτηρίων με τα ζοφερά και υγρά στενά των φτωχόσπιτων κορυφώνεται με τον ρατσισμό απέναντι στους Εβραίους της εβραϊκής συνοικίας και το πάντοτε φιλύποπτο και ανακριτικό βλέμμα των περιπόλων. Η ανομία των αρχόντων, ο ρατσισμός, οι διακρίσεις και η φτώχεια πρωταγωνιστούν στον καθημερινό βίο των πολιτών. Οι αγροτικοί πληθυσμοί στενάζουν κάτω από τη βενετσιάνικη κατοχή και αποφασίζουν με επικεφαλής τον ριζάρχη Γεώργιο Καντανολέο να περιορίσουν τους Βενετούς στα τέσσερα κάστρα του νησιού, Μεγαλόκαστρο, Χανιά, Ρέθυμνο και Σητεία. Την κρίσιμη τούτη ώρα, ο γιος του αρχηγού του ξεσηκωμού, Πέτρος, και η Σοφία Δα Μολίνου, κόρη του Κρητοβενετού Φραντζέσκου, Δα Μολίνου αναγγέλλουν τους γάμους τους, που ο πολύπαθος λαός του νησιού θεωρεί ευαγγέλιο εθνεγερσίας, ονομάζοντάς τους έκτοτε Κρητικούς γάμους.',
    'http://books.google.com/books/content?id=M6C8BwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180400557',
    'O Mανόλης ο Ντελμπεντέρης',
    'Pelekanos Books',
    190,
    'Ο «Μανόλης ο Ντελμπεντέρης» είναι το μοναδικό μυθιστόρημα του πρωτεργάτη του κινήματος του δημοτικισμού Αργύρη Εφταλιώτη και είδε το φως της δημοσιότητας μετά τον θάνατό του. Κεντρικό πρόσωπο του μυθιστορήματος είναι ένας όμορφος νεαρός είκοσι χρόνων. Ο Μανόλης, όπως είναι το όνομά του, κατάγεται από μία πρώην εύπορη οικογένεια. Το όνειρο του πατέρα του να τον δει κάποια στιγμή μεγάλο και τρανό, βασανίζει διαρκώς τον φιλόδοξο νεαρό. Ώσπου ξάφνου παρουσιάζεται η ευκαιρία να αφήσει πίσω το νησί του και να ταξιδέψει σε νέους τόπους. Ένα εγγλέζικο καράβι κάνει την εμφάνισή του στο λιμάνι του νησιού του. Ο Μανόλης δεν αφήνει την ευκαιρία να πάει χαμένη. Αρραβωνιάζεται στα γρήγορα τη γειτονοπούλα που του προξενεύουν ως πρόφαση για να ταξιδέψει στα ξένα, να προκόψει και πετυχημένος να γυρίσει πίσω και να την παντρευτεί. Από το σημείο αυτό και έπειτα, ο Μανόλης ασυγκράτητος αναπτύσσει μία καταπληκτική εμπορική δραστηριότητα με ασίγαστη φιλοδοξία για οικονομική και κοινωνική άνοδο, χωρίς ηθικούς φραγμούς και τύψεις.',
    'http://books.google.com/books/content?id=kE_wCAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9786180702408',
    'Ο κήπος του Μένγκελε',
    'Patakis',
    376,
    'Η Περλ έχει την ευθύνη για: τα θλιβερά, το παρελθόν, τα καλά. Η Στάσα πρέπει να νοιάζεται για: τα αστεία, το μέλλον, τα άσχημα. To φθινόπωρο του 1944 οι δωδεκάχρονες δίδυμες αδερφές Περλ και Στάσα, μαζί με τη μητέρα τους και τον παππού τους, εκτοπίζονται στο Άουσβιτς. Μέσα σε αυτόν τον άγνωστο και απειλητικό κόσμο, οι δύο αδερφές βρίσκουν καταφύγιο στη δίδυμη φύση τους και παρηγοριά στη δική τους γλώσσα και στα κοινά παιχνίδια της παιδικής τους ηλικίας. Τραβώντας την προσοχή του Γιόζεφ Μένγκελε, του διαβόητου «αγγέλου του θανάτου» του Άουσβιτς, και αποτελώντας μέρος ενός πειραματικού πλήθους από δίδυμα αδέρφια γνωστού ως ο «Ζωολογικός Κήπος του Μένγκελε», τα κορίτσια βιώνουν προνόμια και τρόμους άγνωστους σε άλλους κρατουμένους. Τον ίδιο χειμώνα, σε ένα κοντσέρτο που ενορχηστρώνει ο ίδιος ο Μένγκελε, η Περλ εξαφανίζεται. Η Στάσα πενθεί για τη δίδυμη αδερφή της, αλλά δεν εγκαταλείπει την ελπίδα να είναι ακόμη ζωντανή. Όταν ο Κόκκινος Στρατός απελευθερώνει το στρατόπεδο, η Στάσα και ο φίλος της ο Φίλιξ –ένα αγόρι αποφασισμένο να εκδικηθεί για τον χαμένο δίδυμο αδερφό του– ταξιδεύουν μέσα στην ερειπωμένη Πολωνία. Απτόητοι από τους τραυματισμούς, την πείνα και το χάος που τους περιβάλλει, με τον κίνδυνο και την ελπίδα να τους παρακινούν εξίσου, έρχονται σε επαφή με εχθρικούς χωρικούς, μαχητές της εβραϊκής αντίστασης, άλλους πρόσφυγες και συνεχίζουν την αναζήτησή τους πιστεύοντας ότι θα καταφέρουν να συλλάβουν τον Μένγκελε και να τον φέρουν ενώπιον της δικαιοσύνης μέσα στα ερείπια του ζωολογικού κήπου της Βαρσοβίας. Ο Κήπος του Μένγκελε (Mischling*) μιλάει για μια από τις πιο σκοτεινές στιγμές στην ιστορία του ανθρώπου δείχνοντάς μας τον δρόμο προς τη δύναμη της ψυχής και την ελπίδα. (*Mischling /misch·ling/, υβρίδιο· μιγάς. Χρησιμοποιήθηκε από το Τρίτο Ράιχ για να δηλώσει άτομο μεικτής καταγωγής).',
    'http://books.google.com/books/content?id=25GGEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9788873047476',
    'Ο χορός του φεγγαριού (βιβλίο 1ο)',
    'Tektime',
    284,
    'Η Ζωή της Ένβι ήταν τέλεια. Είχε έναν υπέροχο αδερφό. έναν υπέροχο σύντροφο και την καλύτερη δουλειά που θα μπορούσε να ζητήσει μία κοπέλα...σύχναζε στα πιο πολυσύχναστα κλαμπς της πόλης. Όλα ήταν τέλεια, μέχρι τη στιγμή που της τηλεφώνησε ένας από τους καλύτερους της φίλους, για να της πει ότι το αγόρι της χόρευε κατακόρυφο λίμπο στην πίστα του Μούνντανς. Η απόφασή της να πάει να τον βρει πυροδοτεί μία σειρά από γεγονότα, που θα την αναγκάσουν να γνωρίσει έναν παράλληλο μεταφυσικό κόσμο, καλά κρυμμένο πίσω από την ανιαρή πραγματικότητα. Έναν κόσμο στον οποίον οι άνθρωποι μπορούν να μεταμορφωθούν σε ιαγουάρους, πραγματικά βαμπίρ που τριγυρνούν στους δρόμους και έκπτωτους αγγέλους που περπατούν ανάμεσά μας. Ο Ντέβον είναι ένας ανθρωπόμορφος ιαγουάρος, που ζει στα άκρα, και ένας από τους δύο ιδιοκτήτες του Μούνντανς. Η ζωή του κλονίζεται μία νύχτα, όταν στην πίστα του κλαμπ του παρατηρεί τον αισθησιακό χορό μίας φλογερής αλλά κυνικής κοκκινομάλλας. Με τον πόλεμο των βαμπίρ να μαίνεται γύρω τους ο Ντέβον ορκίζεται ότι αυτήν τη γυναίκα θα... και πολεμά μέχρι θανάτου για να την αποκτήσει. PUBLISHER: TEKTIME',
    'http://books.google.com/books/content?id=acxeDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789464447675',
    'On Books',
    'LYSA Publishers',
    40,
    'This anthology presents a sample from Henri Estienne’s writings across his career and from different genres. These range from letters, to poetry, to essays, to his Encomium of the Frankfurt Fair. They reveal him as a remarkable scholar with an astonishing grasp of Latin and Greek literature, while highlighting also his problems both as a publisher and as a scholar. Estienne’s elaborate essays on the ancient Greek historians Xenophon and Herodotus use ancient examples to support contemporary arguments. His verses preserve a strong sense of the life of a scholar turned businessman, both at work and at play. In remarkably fluid Latin, Estienne reveals in these writings his aspiration to be worthy of his father’s legacy, his affection for family and friends, his humour, and his gripes with other scholars and publishers.',
    'http://books.google.com/books/content?id=yA9oEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'BEN',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600322439',
    'Οι Μάγισσες της Σμύρνης',
    'Εκδόσεις Καστανιώτη',
    560,
    'Σμύρνη στα 1887. Η Κατίνα είναι μια έξυπνη κι αδίστακτη Σμυρνιά. Στους φτωχομαχαλάδες όπου ζει γνωρίζει την Αττάρτη, μια Τούρκα, που τη μυεί στη μαγεία. Κανένα εμπόδιο δε σταματά πλέον μια μάγισσα, κι η Κατίνα βάζει μπρος να ανέβει ψηλά. Ερωτικά φίλτρα, μπουγιούμ, λιώματα και μαγικά αποδεικνύονται αλάνθαστα. Καταφέρνει να πάρει τέσσερις άντρες, τον ένα καλύτερο από τον άλλον, τον ένα πλουσιότερο από τον άλλον. Ανεβαίνοντας όλο και πιο ψηλά στο ράγκο (κοινωνική τάξη), η Κατίνα ανακατεύεται στις δουλειές τους και κουμαντάρει άξια τα εμπόρια, τις μπάνκες, τα καπνά, φτάνοντας μια μέρα να διαφεντέψει και την ίδια τη Σμύρνη. Οι γραφές της, τα ξόρκια και τα μαγικά βρέθηκαν σ ένα σκονισμένο μπαουλάκι, εκατό χρόνια μετά, στο σπίτι της Αίγινας.',
    'http://books.google.com/books/content?id=UGV2BQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600353990',
    'Ο πάπυρος του Μωυσή',
    'Εκδόσεις Καστανιώτη',
    272,
    'Στην έρημο της Ιουδαίας, στις δυσπρόσιτες σπηλιές του Κουμράν, ανακαλύπτεται ένα άγνωστο αρχαίο χειρόγραφο της Αδελφότητας των Εσσαίων, που κρύβει το τρομερότερο μυστικό όλων των εποχών. Ένα μυστικό που έχει τις ρίζες του στα χρόνια του Μωυσή και δίνει την αφορμή για την πιο επικίνδυνη πολιτικοστρατιωτική συνωμοσία που εξυφάνθηκε ποτέ στον πλανήτη. Η ιερή πόλη της Ιερουσαλήμ γίνεται το επίκεντρο μιας φοβερής σύγκρουσης των Δυνάμεων του Σκότους με τις Δυνάμεις του Φωτός, ενώ η ανθρωπότητα βιώνει τις κρισιμότερες ώρες της ιστορίας της, αντιμέτωπη με το φάσμα ενός εσχατολογικών διαστάσεων πυρηνικού ολοκαυτώματος, που ωστόσο έχει προφητευθεί αιώνες πριν. Ολόκληρος ο κόσμος θα ζήσει ένα πρωτόγνωρο δράμα, του οποίου το τέλος δεν το υποπτεύεται κανείς.',
    'http://books.google.com/books/content?id=i4V2BQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GLE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600354072',
    'Limit',
    'Εκδόσεις Καστανιώτη',
    1344,
    '2025 Πρωτοποριακές τεχνολογίες έχουν φέρει επανάσταση στην αστροναυτική. Σε έναν λυσσαλέο αγώνα Αμερικανοί και Κινέζοι εξορύσσουν στο φεγγάρι ήλιον-3, ένα στοιχείο που υπόσχεται να λύσει όλα τα ενεργειακά προβλήματα παγκοσμίως. Παράλληλα ο ντετέκτιβ Όουεν Τζέρικο αναλαμβάνει να βρει την αντικαθεστωτική Γιόγιο, που έχει εξαφανιστεί μυστηριωδώς. Αυτό που μοιάζει με υπόθεση ρουτίνας εξελίσσεται σε ένα εφιαλτικό ανθρωποκυνηγητό, καθώς η όμορφη όσο και κουραστική Κινέζα έχει στην κατοχή της μερικά αυστηρά κρυμμένα μυστικά και η ζωή της τώρα πια κινδυνεύει. Τα ίχνη οδηγούν σε όλη την υφήλιο, και στη Σελήνη, όπου ένα γκρουπ τουριστών του διαστήματος ανακαλύπτει κάτι πραγματικά απειλητικό. Τέσσερα χρόνια μετά την παγκόσμια επιτυχία του Σμήνους, ο Φρανκ Σέτσινγκ μεταπηδάει από τον κόσμο της θάλασσας στον κόσμο του διαστήματος για να μας ταξιδέψει σε ένα μέλλον που δεν φαντάζει ιδιαιτέρως μακρινό, με όχημα ένα μυθιστόρημα που κόβει την ανάσα. Περισσότερα',
    'http://books.google.com/books/content?id=RcaDBQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600354713',
    'Πάσχα στο χωριό',
    'Εκδόσεις Καστανιώτη',
    144,
    'Τρεις φίλοι –δυο άντρες και μια γυναίκα– διασχίζουν μ ένα μεθυσμένο ντεσεβό τη μισή Ελλάδα για να κάνουν Πάσχα στο χωριό, τέτοιο που βλέπανε στις ζωγραφιές των σχολικών βιβλίων όταν ήταν παιδιά. Τίποτα όμως απ αυτά δεν υπάρχει. Ούτε οικογένειες να τρώνε ευτυχισμένες στο γρασίδι, ούτε αρνάκια να τρώνε το γρασίδι, ούτε και τσολιάδες να χοροπηδάνε γύρω τους. Υπάρχει όμως ανάσταση. Άσχετα αν δε χτυπούν καμπάνες, δεν πέφτουν τουφεκιές και δε σκάνε πυροτεχνήματα στον ουρανό. Μια ανάσταση που δε φαίνεται, δεν ακούγεται και κανείς από τους τρεις τους δε μιλάει γι αυτή. «... Πάσχα στο χωριό δε σημαίνει αναγκαστικά άσπρες λαμπάδες, κόκκινα αβγά και σουβλιστό αρνί την εποχή που βγαίνουν οι παπαρούνες. Ούτε και σταυρωτά φιλιά. Παπαρούνες μπορούν ν ανθίσουν και τον Γενάρη, φτάνει να το θες. Ο καθένας μπορεί ν αναστηθεί, όπου θέλει κι όποτε θέλει. Θα το καταλάβει όταν ασπαστεί τον εαυτό του. Κι επειδή μόνοι μας ερχόμαστε στον κόσμο και μόνοι μας φεύγουμε, ε, πρέπει, αν θέλουμε ν αναστηθούμε, να είμαστε κι εκεί μόνοι, ολομόναχοι. Για να μην υπάρχουν μάρτυρες και να μην το πιστεύει κανείς. Έτσι ώστε να είμαστε συνεχώς αναγκασμένοι να πράττουμε για να μας πιστέψουν οι άλλοι κι όχι συνεχώς να μιλάμε».',
    'http://books.google.com/books/content?id=tIZ2BQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600357288',
    'Το τέλος του γαλάζιου ρόδου',
    'Εκδόσεις Καστανιώτη',
    392,
    'Λευκή Γλυκοφρύδη: Ένα κορίτσι που η τύχη όρισε να ζήσει την παιδική της ηλικία σε ένα ροδώνα. Μια έφηβη που πολύ νωρίς αρχίζει να συνειδητοποιεί πως ο αγώνας για το ωραίο και το αρμονικό αποτελεί μονόδρομο. Μια φοιτήτρια που συλλαμβάνεται αργότερα και βασανίζεται από τη δικτατορία. Μια γυναίκα που ερωτεύεται παράφορα και παντρεύεται έναν επαναστάτη – έναν επαναστάτη που γίνεται υπουργός της Μεταπολίτευσης… Το τέλος του γαλάζιου ρόδου: Η συγκλονιστική ιστορία μιας γυναίκας, ενός άντρα, ενός έρωτα, μιας γενιάς που σημάδεψε τη σύγχρονη Ελλάδα υποθηκεύοντας το μέλλον των επερχόμενων γενεών. Το τρίτο μέρος της «Τριλογίας των Αθηνών», που ξεκίνησε με το Όπως ήθελα να ζήσω (Βραβείο Αναγνωστών ΕΚΕΒΙ 2010) και συνεχίστηκε με το Για τ όνειρο πώς να μιλήσω. Ένα μυθιστόρημα που μας ταξιδεύει από τη δεκαετία του ’60 έως τις μέρες μας, από το περίφημο «γυάλινο σπίτι», όπου μια παρέα ονειροπόλων αγωνίζεται για τη δημιουργία του «γαλάζιου ρόδου», μέχρι την αυγή της νέας χιλιετίας και τον ερχομό ενός κόσμου πλέον αγνώριστου. Ένα βιβλίο όπου πραγματικοί ήρωες είναι το πάθος, η επανάσταση και η ελπίδα.',
    'http://books.google.com/books/content?id=2Xp2BQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600358834',
    'Η Άκρα Ταπείνωση',
    'Εκδόσεις Καστανιώτη',
    336,
    'Το μυθιστόρημα εστιάζεται στη νύχτα που πυρπολήθηκε η Αθήνα, την Κυριακή 12 Φεβρουαρίου του 2012. Μια πρώην φιλόλογος και μια πρώην ζωγράφος, που βρίσκονται να συγκατοικούν σε έναν «ξενώνα» του υποβαθμισμένου κέντρου, βγαίνουν κρυφά στις διαδηλώσεις. Η λοξή ματιά τους εισδύει –με τον δικό της ιδιαίτερο τρόπο– στην αόρατη και συμβολική πλευρά των βίαιων συγκρούσεων. Πανικοβάλλονται, χάνονται μέσα στη δική τους πόλη, εξωθούνται στην επαιτεία, χωρίς να χάσουν την προσωπική τους αίσθηση πραγμάτων. Επιστρέφοντας είναι πιο κοντά στην ανέφικτη Ιθάκη. Ο αναρχικός γιος της μιας, ο χρυσαυγίτης μιας τρίτης που τις φροντίζει, μια νεαρή μετανάστρια και το παιδί της, ο γιατρός και η κοινωνική λειτουργός, τα φαντάσματα ενός ετοιμόρροπου αθηναϊκού σπιτιού και, φυσικά, οι νεοάστεγοι διασταυρώνονται με ποικίλους τρόπους μαζί τους είτε στη σπαρασσόμενη Αθήνα είτε λίγο αργότερα. Σ’ αυτό το ανθρωποκεντρικό πολιτικό μυθιστόρημα, η απερχόμενη γενιά του Πολυτεχνείου ανοίγει τον δύσκολο, τον αναγκαίο, αν όχι και μοιραίο διάλογό της με τις σημερινές εξεγέρσεις, με τη μεγάλη ανατροπή της ζωής τα τελευταία χρόνια, με τη μνήμη αλλά και με την Άκρα Ταπείνωση του άστεως.',
    'http://books.google.com/books/content?id=Qj5fCAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600358896',
    'Τα άγρια περιστέρια',
    'Εκδόσεις Καστανιώτη',
    192,
    'Άνθρωποι στα όρια της αντοχής τους, γυναίκες και άντρες που φτάνουν στα άκρα και καμιά φορά τα ξεπερνούν: ο σύζυγος που αισθάνεται απέχθεια για την τετράπαχη γυναίκα του, η μάνα που αρνείται να συμβιβαστεί με την εικόνα του ναρκομανούς παιδιού της, η πρωταγωνίστρια που παθαίνει κρίση πανικού πριν από την πρεμιέρα, η πρώην ταβερνιάρισσα που δολοπλοκεί προκειμένου να εκδικηθεί έναν άντρα. Υπάρχουν ωστόσο και κάποιοι δυνατοί, ή τουλάχιστον κάποιοι που καταφέρνουν να σταθούν και να στηρίξουν και τους άλλους: ο άντρας μιας γυναίκας που έχει καταρρεύσει μετά από την απώλεια της κόρης τους, η ανύπαντρη μεγαλοκοπέλα που διακριτικά αποσύρεται από τη ζωή της νύφης της. Δεν πρόκειται για αγγέλους, όπως και οι άλλοι δεν είναι σατανικά πλάσματα, μοχθηροί ή σαλταρισμένοι εκ γενετής. Eίναι απλώς από εκείνους που η ζωή τούς επιφύλαξε μια δοκιμασία μεγαλύτερη απ’ ό,τι μπορούσαν να αντέξουν – ή που θα μπορούσαμε να αντέξουμε κι εμείς. Από τη συγγραφέα του βιβλίου Πολύ χιόνι μπροστά στο σπίτι (2012), που απέσπασε το Κρατικό Βραβείο Μυθιστορήματος, το Βραβείο Μυθιστορήματος του ηλεκτρονικού περιοδικού Ο Αναγνώστης και το βραβείο του λογοτεχνικού περιοδικού Κλεψύδρα.',
    'http://books.google.com/books/content?id=HT5fCAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600359831',
    'Αφανισμός',
    'Εκδόσεις Καστανιώτη',
    208,
    'Μια τετραμελής ομάδα –μια ψυχολόγος, μια βιολόγος, μια ανθρωπολόγος και μια χωρομέτρης– στέλνεται να εξερευνήσει την αποκλεισμένη, μυστηριώδη Περιοχή Χ (είναι η δωδέκατη αποστολή που αναλαμβάνει τούτη την εξερεύνηση). Εκεί, μες στην παρθένα ερημιά, όπου δεν απομένουν παρά μόνο τα χαλάσματα ενός εγκαταλειμμένου χωριού, τα τέσσερα μέλη βρίσκουν έναν μυστηριώδη πύργο βυθισμένο στη γη, που στους τοίχους του ξετυλίγεται μια παράξενη γραφή φτιαγμένη από μύκητες, και στην άλλη άκρη της Περιοχής Χ ένα φάρο με ίχνη, μέσα, ενός τρομερού μακελειού. Πατώντας στέρεα στη λογοτεχνία του Χ. Φ. Λάβκραφτ και του Τζ. Γκ. Μπάλαρντ, μα και στο Σολάρις, ίσως, του Στάνισλαβ Λεμ, και στην αίσθηση που δίνει μια ταινία όπως το Στάλκερ του Αντρέι Ταρκόφσκι, ο Τζεφ Βάντερμιερ στον Αφανισμό (βραβευμένο με το Βραβείο Nebula το 2014), το πρώτο μυθιστόρημα της Τριλογίας της Νότιας Ζώνης, πλάθει μια εφιαλτική και συνάμα μαγευτική μα εντελώς μοναδική ιστορία επιστημονικής φαντασίας, ένα από εκείνα τα σπάνια βιβλία που εντέλει, και παρά τις όποιες ομοιότητες και αναφορές, στέκουν μόνα τους, δίχως στην πραγματικότητα να έχουν όμοιό τους.',
    'http://books.google.com/books/content?id=Q98_CwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600360226',
    'Μια νύχτα με την Κόκκινη',
    'Εκδόσεις Καστανιώτη',
    144,
    'Μια ιστορία δρόμου. Μια γυναίκα, χωρίζοντας απ’ τον μεγάλο της έρωτα, παίρνει τους δρόμους. Ο πόνος την σπρώχνει να κάνει ένα μακρύ ταξίδι. Αφήνει πίσω της την Πάτρα, τους φίλους, τα μπαρ, τον εαυτό της. Από την Πάτρα με οτοστόπ στην Ήπειρο. Χειμώνα, σ’ έρημους δρόμους, με οδηγούς άγνωστους άντρες. Από τα Γιάννενα θα βρεθεί σ’ ένα νησί, την Πάτμο. Κι από την Πάτμο στην κορυφή της αγωνίας της. Θα υποχρεωθεί να περάσει πολλά για να ξανακερδίσει την ανεξαρτησία του κορμιού της. Θα κινδυνέψει να χάσει και την ψυχή της, αλλά θα την ξαναβρεί στο σχήμα ενός παιδιού που κοιμάται. Τότε, μέσα στην απόρριψη, μέσα στον φόβο και στη σιωπή, ανακαλύπτει τη φύση και το μεγαλείο του έρωτα και του εαυτού της. Οι αισθήσεις και τα αισθήματά της οξύνονται σε απρόσμενο βαθμό και ο ίδιος της ο πόνος γίνεται ο δρόμος μιας πρωτόγνωρης αυτογνωσίας. Επειδή ο έρωτας, για εκείνους που τον τολμούν και τον αντέχουν, παραμένει η σπουδαιότερη αφορμή για να εξερευνήσουμε τις πιο απρόσιτες, τις θεϊκές εκτάσεις της ύπαρξής μας.',
    'http://books.google.com/books/content?id=yKR9DQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600360639',
    'Το νησί της εφηβείας',
    'Εκδόσεις Καστανιώτη',
    544,
    'Στις αρχές της δεκαετίας του 1970 μια τετραμελής οικογένεια –η μητέρα, ο πατέρας και τα δύο αγόρια τους– μετακομίζει σε ένα ολοκαίνουργιο σπίτι στη Νότια Νορβηγία. Το μέλλον τους φαντάζει ανέφελο. Κάποια στιγμή όμως το μέλλον συμβαίνει και αρχίζει να τους κυκλώνει ασφυκτικά. Το τρίτο βιβλίο της εξάτομης μυθιστορηματικής αυτοβιογραφίας του Καρλ Ούβε Κνάουσγκορντ είναι μια θαρραλέα καταβύθιση στην παιδική και εφηβική ηλικία, αλλά και στα μυστήρια της οικογένειας. Ένα βιβλίο για την εξερεύνηση του σώματος, τα πρώτα ερωτικά σκιρτήματα και τη διαμόρφωση του χαρακτήρα υπό τη συνεχή απειλή ενός φοβιστικού και αυταρχικού πατέρα. Στο Νησί της εφηβείας ο διάσημος Νορβηγός συγγραφέας αφήνει την πεζογραφία του να ζωηρέψει μέσα από τα μάτια ενός παιδιού που προσπαθεί να ανακαλύψει τον εαυτό του και να τοποθετηθεί στον κόσμο. Αποκρυπτογραφεί τους τρόπους που έχει το παρελθόν να καθορίζει το παρόν και καταγράφει την αγωνία του ανθρώπου να ζήσει ουσιαστικά. Γράφει για τα ανεξιχνίαστα πράγματα που βιώνουμε όλοι μας χωρίς απαραιτήτως να τα κατανοούμε.',
    'http://books.google.com/books/content?id=D6R9DQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600361087',
    'Ο Πουλημένος',
    'Εκδόσεις Καστανιώτη',
    416,
    '**Βραβείο Man Booker 2016** Μια δηκτική, βαθιά πολιτική σάτιρα για την ταυτότητα της σύγχρονης Αμερικής, ένα μυθιστόρημα που περιγράφει την εκκεντρική ανατροφή ενός Αφροαμερικανού και μια δίκη άνευ προηγουμένου στην ιστορία των Ηνωμένων Πολιτειών. Ο αφηγητής, γεννημένος στο «αγροτικό γκέτο» του Ντίκενς στο Λος Άντζελες, αποδέχεται μοιρολατρικά το περιθώριο. Τον μεγαλώνει ο πατέρας του, ένας ιδιόρρυθμος επιστήμονας, ο οποίος τον χρησιμοποιεί ως πειραματόζωο στις αιρετικές ψυχολογικές μελέτες του για τον ρατσισμό. Ο γιος πιστεύει ότι η πρωτοποριακή εργασία του πατέρα –και ένα βιβλίο που θα προκαλέσει αίσθηση, όταν κυκλοφορήσει– θα επιλύσει τα οικονομικά τους προβλήματα. Όταν όμως αστυνομικοί σκοτώνουν τον πατέρα του, ο πρωταγωνιστής συνειδητοποιεί ότι το μόνο που έχει στα χέρια του είναι ο λογαριασμός μιας κηδείας. Παρακινημένος από την ματαίωση και την παρακμή του τόπου του, αναλαμβάνει μια εξωφρενική πρωτοβουλία: την επαναφορά της δουλείας και του φυλετικού διαχωρισμού, πράγμα που θα τον οδηγήσει ως κατηγορούμενο στο Ανώτατο Δικαστήριο της χώρας. Ο Πουλημένος του Πωλ Μπέιτι σηματοδοτεί το δημιουργικό αποκορύφωμα ενός ιδιοφυούς συγγραφέα. Το βιβλίο τιμήθηκε με το Βραβείο Booker 2016. Το 2015 απέσπασε το Εθνικό Βραβείο του Κύκλου των Κριτικών στις ΗΠΑ. «Ο Πουλημένος είναι ένα μυθιστόρημα για την εποχή μας. Μια σύγχρονη σάτιρα, ακούραστη και ευφάνταστη, το χιούμορ της οποίας μεταμφιέζει τη ριζοσπαστική σοβαρότητα του συγγραφέα της. Ο Πωλ Μπέιτι εξουδετερώνει με τρόπο αχαλίνωτο τις “ιερές αγελάδες” και βάζει στο στόχαστρό του τα φυλετικά και πολιτικά ταμπού με οξύνοια, ζωντάνια και αμεσότητα». ΑΜΑΝΤΑ ΦΟΡΜΑΝ, πρόεδρος της κριτικής επιτροπής του Βραβείου Booker 2016 «Οι εκατό πρώτες σελίδες του Πουλημένου είναι οι πιο καυστικές και ζόρικες σε αμερικανικό μυθιστόρημα τα τελευταία δέκα χρόνια τουλάχιστον... Τα αστεία σε χτυπάνε κατευθείαν στο στομάχι... Οι αυτοσχεδιασμοί είναι ασταμάτητοι σε αυτό το σατιρικό, βαθυστόχαστο μυθιστόρημα που συνιστά σταθμό». The New York Times «Μια απίστευτη σάτιρα για τη φυλετική ταυτότητα στην Αμερική... Ο Πουλημένος συνδυάζει τη ζωηρή κωμωδία και τη δριμεία κοινωνική κριτική, αλλά το πλέον εντυπωσιακό προτέρημα του βιβλίου είναι η ολοζώντανη ανθρωπιά των χαρακτήρων του». The New Yorker «Ένα αστείο και τολμηρό βιβλίο που ανατρέπει τις επιζήμιες συμβάσεις της κουλτούρας... Είναι αυτή η συνειδητή ανατροπή... που κάνει αυτό το θαρραλέο και σκληρό μυθιστόρημα τόσο απολαυστικό». The Guardian «Ο Πουλημένος ανήκει στα σημαντικότερα και πλέον δύσκολα αμερικανικά μυθιστορήματα που έχουν γραφτεί στον 21ο αιώνα... Είναι ένα επώδυνο βιβλίο που οι αναγνώστες δύσκολα θα ξεχάσουν». Los Angeles Times',
    'http://books.google.com/books/content?id=MQ2VDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600361223',
    'Ιούδας',
    'Εκδόσεις Καστανιώτη',
    368,
    'Ιερουσαλήμ, 1959. Ο νεαρός φοιτητής Σμούελ Ας αναγκάζεται να διακόψει τις σπουδές του και βρίσκει καταφύγιο σε ένα πέτρινο σπίτι με παράξενους ένοικους. Εκεί κερδίζει τα προς το ζην κρατώντας συντροφιά σε έναν εβδομηντάχρονο άνδρα, μορφωμένο όσο και εκκεντρικό, τον Γκέρσομ Βαλντ. Οι συζητήσεις τους για την ιστορία, την πολιτική, τη θρησκεία, την ανθρώπινη φύση, είναι παθιασμένες. Όμως κάτω από την ίδια στέγη, μένει η σαγηνευτική και μυστηριώδης Ατάλια Αμπραβανέλ. Η ίδια συνδέεται με μια παραγνωρισμένη φυσιογνωμία του σιωνιστικού κινήματος, με κάποιον που προσπάθησε να αλλάξει την ίδια τη συγκρότηση του κράτους του Ισραήλ. Ο ντροπαλός και ευαίσθητος Σμούελ αναστατώνεται από την παρουσία της και αρχίζει να ερωτεύεται τη μεγαλύτερή του γυναίκα. Ο Ιούδας, το τελευταίο αριστούργημα του Άμοζ Οζ, είναι ένα προκλητικό μυθιστόρημα ιδεών και συγχρόνως η αφήγηση μιας απεγνωσμένης αγάπης, με υποβλητικό σκηνικό τα χειμωνιάτικα τοπία μιας διχοτομημένης πόλης. Ένα σπουδαίο έργο αναφοράς για να κατανοήσουμε την ψυχή μιας ολόκληρης χώρας, τη σχέση ανάμεσα στον ιουδαϊσμό και τον χριστιανισμό, καθώς και μια συναρπαστική σπουδή πάνω στις μορφές του «προδότη». «Ένα μεγαλειώδες μυθιστόρημα… Ο Ιούδας είναι ένα έργο ωριμότητας, ένα βιβλίο συναρπαστικό και ευφυές, γραμμένο από έναν μεγάλο συγγραφέα που μας προσκαλεί σε μια μεθυστική κατάδυση, να απολαύσουμε το βάθος των παρατηρήσεων του, απαλλαγμένοι από κάθε αυταπάτη» Haaretz (Ισραήλ) «Ένα αριστούργημα: ο έλεγχος της κάθε λέξης, η περίτεχνη δομή, η ικανότητα του Άμος Οζ να διεγείρει όλες τις αισθήσεις του αναγνώστη» Le Reppublica (Ιταλία) «Ο Άμος Οζ συγκαταλέγεται μεταξύ των κορυφαίων συγγραφέων της παγκόσμιας λογοτεχνικής σκηνής». Süddeutsche Zeitung (Γερμανία) «Ο Ισραηλινός συγγραφέας επέστρεψε με μια μύχια ιστορία, όπου συναντιούνται τα βασικότερα θέματα του έργου του». Le Monde (Γαλλία)',
    'http://books.google.com/books/content?id=OOuxDQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MON',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600361407',
    'Έρωτας φονιάς',
    'Εκδόσεις Καστανιώτη',
    256,
    'Ο κοσμοπολίτης, γοητευτικός άντρας που ακροβατεί ανάμεσα στο σκοτάδι και στο φως. Τα πρόσωπα και οι ρόλοι που αλλάζει με μοναδική μαεστρία. Η γλυκιά κι ευαίσθητη αεροσυνοδός στο μοιραίο ταξίδι στη Σαντορίνη. Η ξεχασμένη αποθήκη και η βαλίτσα με τα θαμμένα μυστικά. Η μονοκατοικία του τρόμου. Η ταλαντούχα μουσικός και ο παραμυθένιος γάμος στη στολισμένη με εντελβάις εκκλησία του Γολγοθά. Η ανυποψίαστη νεαρή, τα φρικτά βασανιστήρια και το μωρό που δεν γεννήθηκε ποτέ. Η συνοδός πολυτελείας στη σουίτα γνωστού ξενοδοχείου, όπου τα κρίνα βάφτηκαν με αίμα. Το μικρό αγόρι που έγινε μάρτυρας εγκλήματος. Μια περιπλάνηση στον κόσμο του μυστηρίου από την Αθήνα, την Ιθάκη και τη Σαντορίνη ως τη Βιέννη και τη λίμνη του ονειρικού Χάλστατ. Ένα μυθιστόρημα που ξετυλίγει το νήμα μιας σκοτεινής ιστορίας και ακολουθεί την αιματοβαμμένη διαδρομή της. Θύματα γυναίκες, σε μια σειρά άγριων εγκλημάτων, που έρχονται στο φως με διαδοχικές αποκαλύψεις και αλλεπάλληλες ανατροπές. Ένα βιβλίο όπου η δημοσιογράφος-ερευνήτρια μπαίνει στο στόχαστρο του δολοφόνου, μετατρέπεται σε τιμωρό και δικαιώνει τα θύματα.',
    'http://books.google.com/books/content?id=fqR9DQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600363524',
    'Η διαφάνεια του χρόνου',
    'Εκδόσεις Καστανιώτη',
    576,
    'Ο Μάριο Κόντε, καθώς πλησιάζει όλο και πιο πολύ τα εξήντα του χρόνια, αναζητεί τρόπους να ξεπεράσει την προσωπική κρίση που αντιμετωπίζει αλλά, συγχρόνως, ανησυχεί όλο και περισσότερο για την κατάσταση της χώρας του. Και τότε παρουσιάζεται μια απρόσμενη δουλειά: ένας παλιός συμμαθητής του, ο Μπόμπι, ζητάει τη βοήθειά του και του αναθέτει να ξαναβρεί το άγαλμα μιας Μαύρης Παρθένου που του έχουν κλέψει. Ο Κόντε ανακαλύπτει ότι το συγκεκριμένο άγαλμα μπορεί τελικά να είναι ακόμα πιο πολύτιμο απ ό,τι του έχουν πει. Με την έρευνά του θα οδηγηθεί στο μακρινό παρελθόν, θα μάθει ακόμα και για τον άνθρωπο που – προσπαθώντας να ξεφύγει απ τον Ισπανικό Εμφύλιο– ταξίδεψε ως λαθρεπιβάτης μέχρι την Κούβα, φέρνοντας την Μαύρη Παρθένο από τα Καταλανικά Πυρηναία. Ο Κόντε σιγά σιγά καταδύεται στον υπόκοσμο μιας σκοτεινής Αβάνας που καταρρέει, πέφτει πάνω σε ύποπτους και πτώματα ενώ, την ίδια στιγμή, έρχεται σε επαφή με το απίστευτο κύκλωμα των εμπόρων και των συλλεκτών έργων τέχνης. Στο νέο εκπληκτικό του μυθιστόρημα ο Λεονάρδο Παδούρα αφηγείται μια επική ιστορία που ξεκινάει από τις Σταυροφορίες και φτάνει μέχρι τις μέρες μας. «Είναι ο σπουδαιότερος συγγραφέας της σημερινής Κούβας. Με σταθερά βήματα οδεύει προς το λογοτεχνικό πάνθεο όπου βρίσκονται ο Γκαμπριέλ Γκαρσία Μάρκες και ο Μάριο Βάργκας Λιόσα. Και κανείς δεν μπορεί να τον σταματήσει». The Washington Post «Με κάθε του βιβλίο επιβεβαιώνει ότι πλέον είναι ο καλύτερος αφηγητής αστυνομικών ιστοριών στην ισπανική γλώσσα, ένας άξιος διάδοχος του Μανουέλ Βάθκεθ Μονταλμπάν». The Times «O Λεονάρδο Παδούρα είναι ο Ντάσιελ Χάμετ της Αβάνας». The Guardian',
    'http://books.google.com/books/content?id=fcnnDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600364187',
    'Τυλ, ο σαλτιμπάγκος',
    'Εκδόσεις Καστανιώτη',
    384,
    'Ο Τυλ Ούλενσπιγκελ –περιπλανώμενος καλλιτέχνης και παράτολμος σαλτιμπάγκος– γεννιέται σ ένα χωριό της Γερμανίας στις αρχές του δέκατου έβδομου αιώνα. Ο πατέρας του, μυλωνάς και παθιασμένος ερασιτέχνης φιλόσοφος και ερευνητής, μπλέκεται στα πλοκάμια της εκκλησίας. Ο Τυλ αναγκάζεται να δραπετεύσει με τη συνομήλική του Νέλε. Περιδιαβαίνοντας μια χώρα ρημαγμένη από τον πόλεμο συναντούν πολλούς ταπεινούς, μα και «μεγάλους». Η μοίρα όλων αυτών των ανθρώπων συναρμόζεται σ ένα χρονικό πλέγμα γύρω από την τραγωδία του Τριακονταετούς Πολέμου και γύρω από τον μυστηριώδη Τυλ. Στο αριστούργημά του ο Ντάνιελ Κέλμαν επανεφευρίσκει τον Τυλ Όιλενσπιγκελ, τη θρυλική φιγούρα της γερμανικής κουλτούρας, και τη μεταθέτει σ ένα σύμπαν αντιθέσεων, όπου ο βασιλιάς συνυπάρχει με τον παλιάτσο, το παραμύθι με το ελισαβετιανό θέατρο, ο Μεσαίωνας με τους Νέους Χρόνους, η πραγματικότητα με τα φαντάσματα και η ποίηση με τη φρίκη. Σ έναν κόσμο που παραπαίει, η τέχνη και η απόφαση του περιπλανώμενου καλλιτέχνη να μην πεθάνει ποτέ είναι το νήμα που συνδέει τις απαρχές της σύγχρονης ευρωπαϊκής Ιστορίας με τη σημερινή εποχή: «Γιατί δεν έχει περάσει πολύς καιρός από τότε». «Το Τυλ, ο σαλτιμπάγκος είναι το καλύτερο έργο του μέχρι σήμερα. Είναι και πάλι ένα ιστορικό βιβλίο, όπως και Η μέτρηση του κόσμου, που τον ανέδειξε σε παγκόσμιο λογοτεχνικό αστέρα. Όμως αυτό το νέο μυθιστόρημα εισχωρεί βαθιά μέσα σου, είναι ωμό, μοντέρνο, γεμάτο ζωντάνια και με έξοχα άμεση γραφή, ένα ρομαντικό γερμανικό έπος. Είναι η νίκη του Ντάνιελ Κέλμαν επί της Ιστορίας, ο προσωπικός του θρίαμβος». Φόλκερ Βάιντερμαν, Der Spiegel «Η μεγάλη διαφορά με τη Μέτρηση του κόσμου έγκειται στο ύφος που προκύπτει απ’ το φρικτό πρωτογενές υλικό: την ερήμωση του κόσμου. Τραύμα, απώθηση, η δύναμη (αλλά και η αδυναμία) της αφήγησης αποτελούν ένα από τα κεντρικά θέματα του Τυλ, ο σαλτιμπάγκος, πέρα από το ιστορικό πλαίσιο. Η λογοτεχνία του Κέλμαν σε αφήνει διαρκώς έκπληκτο, είναι ανάλαφρη, είναι αντιπροσωπευτική, είναι σχοινοβασία σε ιλιγγιώδες ύψος» Die Welt «Ένα λαμπρό μείγμα φαντασίας, εμπεριστατωμένης γνώσης και ανατρεπτικού χιούμορ – απολαυστικά κωμικό και άκρως θλιβερό μαζί» dpa (Γερμανικό Πρακτορείο Ειδήσεων) «Μεγαλειώδες μυθιστόρημα» Frankfurter Allgemeine Zeitung «Ένα ατελείωτο γλέντι» Die Zeit «Αριστούργημα» Der Standard',
    'http://books.google.com/books/content?id=XwvbDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'KOR',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600367638',
    'Η χορτοφάγος',
    'Εκδόσεις Καστανιώτη',
    208,
    'Η ΓιόνγκΧιε και ο σύζυγός της είναι δύο άνθρωποι του μέσου όρου. Εκείνος πηγαινοέρχεται δουλοπρεπώς στο γραφείο του, δεν διακατέχεται από καμία φιλοδοξία. Εκείνη δεν τη χαρακτηρίζει κανένα πάθος, είναι απλώς μια αφοσιωμένη νοικοκυρά. Η μονοτονία του γάμου τους ανατρέπεται όταν η ΓιόνγκΧιε αποφασίζει μια μέρα να μην ξαναφάει κρέας. Δεν δίνει εξηγήσεις. «Είδα ένα όνειρο», αυτό λέει μονάχα. Πρόκειται για μια μικρή ένδειξη ανεξαρτησίας, η οποία όμως μπορεί να θεωρηθεί ακραία και να αποδειχθεί ιδιαίτερα επικίνδυνη σε μια χώρα όπως η Νότια Κορέα. Και δεν φτάνει αυτό. Η παθητική αντίσταση της ΓιόνγκΧιε, μια διαδικασία ιδιότυπης μεταμόρφωσης, ξεπερνά κάθε όριο γκροτέσκου. Ποτέ δεν φορούσε με ευχαρίστηση σουτιέν, αλλά τώρα αρχίζει να το κάνει και δημοσίως. Επιπλέον, ονειρεύεται να ζήσει σαν φυτό. Σύσσωμη η οικογένεια θα στραφεί τελικά εναντίον της. Η βραβευμένη Χορτοφάγος είναι μια ιστορία καφκικής σύλληψης που αναπτύσσεται σε τρεις πράξεις. Ένα μυθιστόρημα σαγηνευτικό και αλλόκοτο, βίαιο και αισθησιακό, με το οποίο η ΧανΓκανγκ, από τις δημοφιλέστερες λογοτεχνικές φωνές της Άπω Ανατολής, διερευνά την επιθυμία και την ντροπή, την καταπίεση και την εξουσία. «Η Χορτοφάγος είναι ένα αξέχαστο μυθιστόρημα, σφοδρό και αυθεντικό, που απέσπασε πανάξια και ομόφωνα το Διεθνές Βραβείο Booker 2016. Η Χαν Γκανγκ αφηγείται μέσα από τρεις φωνές, τρεις διαφορετικές οπτικές γωνίες, τούτη την πυκνή, παράξενη και εξαίρετα δομημένη ιστορία, περιγράφοντας πώς ακριβώς μια συνηθισμένη γυναίκα απορρίπτει τις συμβάσεις και τις προκαταλήψεις που τη δένουν με το σπίτι της, την οικογένειά της, την κοινωνία μέσα στην οποία ζει. Με ύφος λυρικό και συγχρόνως διαπεραστικό, το βιβλίο αποκαλύπτει τις συνέπειες που επιφέρει αυτή η μεγάλη άρνηση όχι μόνο στην ίδια την ηρωίδα αλλά και στους ανθρώπους του περιβάλλοντός της. Αυτό το συμπαγές, θαυμάσιο και ανατριχιαστικό έργο θα παραμείνει για καιρό στις σκέψεις, ίσως και στα όνειρα, των αναγνωστών. Ένας απίστευτος και αδιάκοπος συνδυασμός ομορφιάς και ανατριχίλας διατρέχει κάθε του σελίδα». Μπόιντ Τόνκιν, πρόεδρος της κριτικής επιτροπής του Διεθνούς Βραβείου Booker 2016 «Μια ασυνήθιστη, αναπάντεχη αναγνωστική εμπειρία». The Guardian',
    'http://books.google.com/books/content?id=z4zZDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600367645',
    'Αθώα Πλάσματα',
    'Εκδόσεις Καστανιώτη',
    272,
    'Ο Στέφανος, ένας μοναχικός άντρας, επιστρέφει στην Αθήνα ύστερα από καιρό απουσίας σε περιοχή του μακρινού Βορρά. Η φυγή του σχετίζεται με ένα έντονο συναισθηματικό τραύμα από τη σχέση του με μια γυναίκα. Με ανεπούλωτες τις πληγές του, προσπαθεί να εργαστεί ως ιδιωτικός ερευνητής. Δεν έχει ιδιαίτερη δουλειά, ώσπου κάποια μέρα τον επισκέπτεται μια υποψήφια πελάτισσα, η Μαριάννα, που του ζητά κάτι ασυνήθιστο: Να την παρακολουθήσει. Αυτός αρχικά αρνείται, αλλά εντέλει παρασύρεται σε μια μυστηριώδη υπόθεση, στα σκοτεινά μονοπάτια ενός άλλου κόσμου, όπου κυριαρχεί το Κακό με μια μορφή που δεν έχει ξανασυναντήσει, ούτε έχει καν διανοηθεί. Στο νέο βιβλίο του Αλέξη Σταμάτη το πανάρχαιο δίπολο έρωτας-θάνατος είναι η κινητήρια δύναμη του μυθιστορηματικού του κόσμου. Είτε ταλαντώνεται σαν απειλητικό εκκρεμές, είτε πέφτει σαν σκιά στα γεγονότα, οδηγεί την ιστορία σε μια αναπάντεχη διαδρομή που σημαδεύει ανεξίτηλα όλους τους εμπλεκομένους.',
    'http://books.google.com/books/content?id=bZHZDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600367843',
    'Διηγήματα',
    'Εκδόσεις Καστανιώτη',
    176,
    'Έντεκα διηγήματα, έντεκα διαφορετικές ματιές στην πραγματικότητα και τον μύθο, στα αισθήματα και τα πάθη, στο όνειρο ή την τιμωρία, στα σύνορα μνήμης και λήθης. Και στα άλλα όμως σύνορα, αυτά που ενώνουν, που χωρίζουν, που σημαίνουν πόλεμο και προσφυγιά. Έντεκα διηγήματα, έντεκα απόπειρες για να ειπωθούν, όσο είναι δυνατόν να ειπωθούν, τα ανείπωτα. Για να ζυγιστεί, όσο κι αν είναι δύσκολο να ζυγιστεί, το σωστό και το λάθος στις ζωές των ηρώων, αλλά και στις δικές μας τις ζωές. Τι σώζει, ή τι στήνει ίσως την παγίδα της μοίρας. Έντεκα διηγήματα, καράβια να μας ταξιδέψουν, να μας κάνουν να σκεφτούμε, να συναισθανθούμε. Να μας πάνε παραπέρα. Σ’ αυτό το βιβλίο συγκεντρώνονται όλα τα διηγήματα (1984-2018) της Ρέας Γαλανάκη, η οποία, εκτός από το Κρατικό Βραβείο Μυθιστορήματος (1999), έχει τιμηθεί και με το Κρατικό Βραβείο Διηγήματος (2005).',
    'http://books.google.com/books/content?id=nUfhDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600368345',
    'Το σκοτάδι',
    'Εκδόσεις Καστανιώτη',
    288,
    'Το πτώμα μιας νεαρής Ρωσίδας εντοπίζεται σε μια ερημική γωνιά της Ισλανδίας. Η αστυνομία, έπειτα από επιπόλαιη έρευνα, καταλήγει στο συμπέρασμα πως πρόκειται για αυτοκτονία και κλείνει αθόρυβα την υπόθεση. Έναν χρόνο αργότερα, η εξηντατετράχρονη επιθεωρήτρια Χούλντα Χερμανσντότιρ εξαναγκάζεται σε πρόωρη συνταξιοδότηση. Έχει όμως δυο βδομάδες καιρό για να επιλέξει ποια παλιά ιστορία θα ανακινήσει. Και δεν δυσκολεύεται να αποφασίσει. Γρήγορα θυμάται εκείνη τη μετανάστρια που είδε τις ελπίδες της για μια καινούργια αρχή να ξεβράζονται στις ακτές αυτής της άγνωστης χώρας. Η Χούλντα, πεπεισμένη ότι η γυναίκα δολοφονήθηκε, ανοίγει ξανά την ξεχασμένη υπόθεση. Ωστόσο, κανένας δεν της λέει όλη την αλήθεια. Ακόμα και οι συνάδελφοί της μοιάζουν αποφασισμένοι να σαμποτάρουν τις προσπάθειές της. Καθώς ο χρόνος μετράει αντίστροφα, φαντάσματα του παρελθόντος έρχονται να τη στοιχειώσουν και να την οδηγήσουν σε μοιραία λάθη. Όμως η Χούλντα, η φοβερή ηρωίδα του Ράγκναρ Γιόνασον, θα επιχειρήσει να βρει τον δολοφόνο ακόμα και με κίνδυνο της ζωής της. Το Σκοτάδι είναι ένα πρωτότυπο, συναρπαστικό, ατμοσφαιρικό αστυνομικό θρίλερ, με φόντο τα παγωμένα, σκοτεινά και άγρια τοπία του απώτατου Βορρά. «Το τέλος του μυθιστορήματος μου έκοψε στ αλήθεια την ανάσα, κι όπως υποψιάζεστε, αυτό πλέον δεν μου συμβαίνει συχνά. Ήταν μια απίστευτη έκπληξη, την οποία δεν μπόρεσα να προβλέψω. Η Χούλντα είναι μια φανταστική, τρισδιάστατη ηρωίδα και θέλω να διαβάσω κι άλλα για αυτή». Ίαν Ράνκιν «Το Σκοτάδι είναι ένα αυθεντικό αριστούργημα της σύγχρονης αστυνομικής λογοτεχνίας». Ίρσα Σιγκουρδαρντότιρ «Ράγκναρ Γιόνασον, ένας συγγραφέας νουάρ παγκόσμιας κλάσης». The Sunday Times «Συνδυασμός ψυχολογικής εμβάθυνσης και σφιχτής πλοκής που μετουσιώνεται σε εξαιρετική μυθοπλασία». The Washington Post',
    'http://books.google.com/books/content?id=4SYNEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789600368352',
    'Μισθοφόροι του χρήματος',
    'Εκδόσεις Καστανιώτη',
    576,
    'Οι νεκροί πελάτες βλάπτουν σοβαρά τις δουλειές και υπάρχει κάποιος που το γνωρίζει καλά αυτό. Ο θάνατος ενός σεΐχη, τον οποίο βρίσκουν απανθρακωμένο στα βουνά της Ελβετίας, φέρνει αμέσως την αναστάτωση στις διακριτικές δραστηριότητες μιας εγχώριας ιδιωτικής τράπεζας. Δεν θα μπορούσε να γίνει κι αλλιώς, γιατί εκείνες οι αραβικές επενδύσεις σε πυρηνικά εργοστάσια έχουν πλέον κινήσει, μεταξύ άλλων, και το ενδιαφέρον της Εθνικής Υπηρεσίας Ασφαλείας των ΗΠΑ. Ο Τομ Βίντερ, υπεύθυνος ασφαλείας στη συγκεκριμένη τράπεζα, αποφασίζει να ακολουθήσει τα ίχνη του χρήματος, που τον οδηγούν στο Κάιρο, στο Μπέργκεν, στη Βοστόνη και πίσω στην Ελβετία. Ψύχραιμος, λιγομίλητος και με δηκτικό χιούμορ, προσπαθεί μαζί με τη Φάτιμα, μια ελκυστική όσο και μυστηριώδη Αιγύπτια επιχειρηματία, να διασχίσει την επικίνδυνη, αιματηρή ζούγκλα της δολοπλοκίας. Όμως τα εκρηκτικά συμπεράσματα στα οποία καταλήγουν θα μετατρέψουν σύντομα και τους ίδιους σε θηράματα. Οι Μισθοφόροι του χρήματος είναι ένα διεθνές οικονομικό θρίλερ γεμάτο δράση και ένταση, ένα μυθιστόρημα με ιλιγγιώδη ρυθμό και συνεχείς ανατροπές. Ο Πέτερ Μπεκ, συνταιριάζοντας ποικίλες αποχρώσεις του σύγχρονου νουάρ, αιχμαλωτίζει την αμέριστη προσοχή μας ως την τελευταία αράδα. «Ένα συγκλονιστικό θρίλερ! Πανέξυπνο και εύστροφο… Δυσκολευόμουν αφάνταστα να το αφήσω από τα χέρια μου». Μαρκ Χιμένες «Ειλικρινά υπέροχο. Αν σας αρέσει η παγκόσμια δράση, το έγκλημα και η κατασκοπεία, διαβάστε το οπωσδήποτε, γιατί ανήκει στα ωραιότερα βιβλία του είδους του». Ρόμπερτ Πάρκερ «Ο καλύτερος Ελβετός συγγραφέας θρίλερ». Lesefieber «Η δράση είναι καταιγιστική και οι υψηλού ρίσκου οικονομικές συναλλαγές εξαιρετικά πειστικές, ενώ ο Τομ Βίντερ αποτελεί μια εκπληκτική, μοντέρνα εκδοχή του Τζέιμς Μποντ». Library Journal «Το βιβλίο είναι εξαιρετικά εμπεριστατωμένο, ειδικά σε ό,τι αφορά τα παρασκήνια του τραπεζικού κόσμου. Η απολαυστική πλοκή του ανάγει τον Πέτερ Μπεκ σε έναν αριστοτέχνη του σασπένς». Crime Review',
    'http://books.google.com/books/content?id=0foOEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601645209',
    'Όλα σου τα \'μαθα μα ξέχασα μια λέξη',
    'Patakis',
    376,
    'Ο καθηγητής Νίκος Αλεξίου προσπαθούσε να συνειδητοποιήσει αν ζούσε έναν εφιάλτη στον ύπνο του ή την ωμή πραγματικότητα. Ξαφνικά ένιωσε πως κατέρρευσε ένα κομμάτι του εαυτού του: η υπερηφάνεια που ένιωθε κάθε φορά που σκεφτόταν ότι θ άφηνε πίσω κληρονομιά του την Άννα μετατράπηκε σε αγωνία, ίσως και ενοχή. Το μυαλό του και η ψυχή του βασανιστικά αναζητούσαν αυτοκριτική και λύση. Έπρεπε τώρα να ψάξει από την αρχή, καρέ καρέ, τη ζωή της Άννας και τη δική του ευθύνη σ αυτή. Μόνη σωτηρία της ψυχής του ήταν η μετάνοια. Να της ζητήσει συγγνώμη για όσα έκανε ή δεν έκανε και την έφτασαν ως εδώ, να βρει τι ξέχασε να της μάθει. Κι αν μπορούσε, να της το μάθει έστω και τώρα. Πριν να είναι αργά.',
    'http://books.google.com/books/content?id=Cw8oDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.67
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601645230',
    'Επί σκηνής χωρίς πρόβα',
    'Patakis',
    472,
    'Καθημερινά στη ζωή μας βρισκόμαστε «επί σκηνής χωρίς πρόβα» και παίζουμε, λίγο ή πολύ σημαντικές, αλλά κάθε φορά μοναδικές και διαφορετικές, πράξεις, κάνοντας τις δικές μας επιλογές σχετικά με το σενάριο και τους ρόλους μας. Κι εμείς, δυστυχώς, δεν έχουμε την «πολυτέλεια» των προκαθορισμένων ρόλων και της πρόβας που έχουν οι ηθοποιοί. Συνεπώς, η μόνη προετοιμασία που μπορούμε να έχουμε είναι να εφοδιαστούμε με έννοιες, αρχές, μεθόδους, ικανότητες και αξίες ώστε να κάνουμε σωστές επιλογές για να παίξουμε όσο γίνεται καλύτερα για μας και γι’ αυτούς που αγαπάμε επί σκηνής χωρίς πρόβα. Άλλωστε, η ανάπτυξη ενός τέτοιου υποβάθρου συμβάλλει στο μαθησιακό μας ταξίδι, στην ολοκλήρωση και την ωριμότητά μας, που αποτελούν προϋποθέσεις για να καθορίσουμε εμείς το πεπρωμένο μας, να μην αφεθούμε στο μοιραίο, να πραγματώσουμε τις δυνατότητές μας και να ζήσουμε όσο γίνεται τη ζωή που εμείς θέλουμε σ’ έναν κόσμο γεμάτο αβεβαιότητες, περιορισμούς και επιβολές.Στο βιβλίο αυτό παρουσιάζονται γνώσεις από τις κοινωνικές επιστήμες που ο συγγραφέας θεωρεί χρήσιμες για το θέατρο της ζωής μας, με δοκιμιακό, αλλά απλό και εκλαϊκευμένο λόγο, προσωπικές ιστορίες, μεταφορές, παραβολές και παραδείγματα. Οι δύσκολες και επικίνδυνες καταστάσεις που βιώνουμε σήμερα ως κοινωνία προσδιορίζουν άμεσα την προσωπική μας ζωή και απαιτούν από τον καθένα μας, με τρόπο επιτακτικό πλέον, να οξύνουμε την πολιτική νοημοσύνη μας ώστε να κάνουμε σωστές πολιτικές επιλογές για μας και για το μέλλον των παιδιών μας. Είθε το πλαίσιο των πολιτικών ιδεών που περιλαμβάνονται στο βιβλίο να συμβάλει προς αυτή την κατεύθυνση.',
    'http://books.google.com/books/content?id=aP0nDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'AZE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601645322',
    'Οι κατάσκοποι των Βαλκανίων',
    'Patakis',
    432,
    'ΕΛΛΑΔΑ, 1940. Όχι η Ελλάδα των ηλιόλουστων διακοπών, αλλά η Ελλάδα του Βορρά, της Μακεδονίας, των Βαλκανίων – και, πιο συγκεκριµένα, η Θεσσαλονίκη. Σ’ αυτό το λιµάνι µε την αρχαία ιστορία, τις αποβάθρες και τους οίκους ανοχής, τα σκοτεινά σοκάκια και τα τουρκικά αρχοντικά, εκτυλίσσεται ένα αγωνιώδες πολιτικό δράµα. Στα βόρεια σύνορα, ο ελληνικός στρατός έχει αναχαιτίσει την επίθεση του Μουσσολίνι, απωθώντας τις ιταλικές µεραρχίες πίσω στην Αλβανία – κατάγοντας την πρώτη νίκη ενάντια σε µέλος του Άξονα, που έχει υποτάξει ήδη το µεγαλύτερο µέρος της Ευρώπης. Αλλά ο Αδόλφος Χίτλερ δε θα ανεχτεί τέτοια προσβολή: την άνοιξη θα εισβάλει στα Βαλκάνια, και το µόνο που µπορεί να κάνει ο λαός της Θεσσαλονίκης είναι να παρακολουθεί και να περιµένει.Στο επίκεντρο αυτού του δράµατος βρίσκεται ο Κωνσταντίνος –Κώστας– Ζαννής, υψηλόβαθµο στέλεχος της αστυνοµίας, επικεφαλής µιας υπηρεσίας που χειρίζεται πολιτικές υποθέσεις «ειδικού» ενδιαφέροντος. Και ενώ επίκειται η εισβολή των Ναζί, αρχίζει ο χορός των κατασκόπων – τουρκικό προξενείο, γερ­µανικές µυστικές υπηρεσίες, Βρετανοί...Την ίδια στιγµή, τα ερωτικά πάθη φουντώνουν στην πόλη. Ο Ζαννής δεν αποτελεί εξαίρεση· ζει τον έρωτα στην αγκαλιά µιας εκπατρισµένης Αγγλίδας, ιδιοκτήτριας σχολής µπαλέτου, µιας Ελληνίδας µε κάπως ιδιαίτερα γούστα και της συζύγου ενός ντόπιου βαθύπλουτου εφοπλιστή... Από τη Θεσσαλονίκη στο Παρίσι, στο Βερολίνο και πάλι πίσω, οι Κατάσκοποι των Βαλκανίων είναι ένα καθηλωτικό µυθιστόρηµα για έναν άντρα που δοκιµάζει τα πάντα και ρισκάρει τα πάντα ορθώνοντας το ανάστηµά του στη µεγαλύτερη κτηνωδία που έχει γνωρίσει ο κόσµος. «Υπάρχουν πολλοί τρόποι να διατηρηθεί η αγωνία του αναγνώστη στα αστυνοµικά µυθιστορήµατα... ο Άλαν Φερστ δεν ακολουθεί τη συνταγή. Και είναι σπουδαίος στο είδος του». Στάθης Ευσταθιάδης, Το Βήµα «Ο ήρωας του Άλαν Φερστ είναι αφοσιωµένος στο ούζο, στις γυναίκες και στη σω­τηρία των ανθρώπων από τους Ναζί. Ο Φερστ είναι ένας δεξιοτέχνης της πλοκής». Justin Cartwright, The New York Times Book Review «Ο Φερστ δηµιουργεί εξαιρετικούς χαρακτήρες και µοναδικά αληθινή κατασκοπική ατµόσφαιρα σε γοητευτικό φόντο». Publishers Weekly «Εξαιρετικό!» The Guardian «Αν και τοποθετηµένα σε συγκεκριµένο τόπο και χρόνο, τα βιβλία του Φερστ είναι σαν τα “Νυχτερινά” του Σοπέν: άχρονα, υπερβατικά, οικουµενικά. Έχει κανείς την αίσθηση ότι δεν τα διαβάζει απλώς, αλλά ότι αιχµαλωτίζεται στη µαγεία τους». Jonathan Shapiro, Los Angeles Times «Ένα αστυνοµικό, ναι, αλλά µε “αληθινούς” ανθρώπους και “αληθινή” ιστορία. Περιµένω ήδη µε αγωνία το επόµενο βιβλίο του». Denis MacShane, The Independent',
    'http://books.google.com/books/content?id=bSomDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'CAT',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601646572',
    'Από το ίδιο ποτήρι και άλλες ιστορίες',
    'Patakis',
    264,
    'Έντεκα χρόνια, μετά την πρώτη έκδοση, επανακυκλοφορεί αναθεωρημένη η συλλογή διηγημάτων του Μισέλ Φάις «Από το ίδιο ποτήρι και άλλες ιστορίες». Δεκατρείς πολύτροπες ιστορίες που φωτίζουν, μέσα από φάσμα του θανάτου, του πένθους και της απουσίας, τη συλλογική μνήμη και τις αθέατες όψεις της ζωής. Ένα βιβλίο που διακρίθηκε (Κρατικό Βραβείο Διηγήματος 2000), μεταφράστηκε (γαλλικά, ισπανικά, αγγλικά), ενώ ιστορίες του πρωτοδημοσιεύτηκαν σε αμερικάνικα περιοδικά και συμπεριλήφθησαν σε γερμανικές, ισπανικές, τσέχικες και κινέζικες ανθολογίες.',
    'http://books.google.com/books/content?id=ReUnDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601647500',
    'Ανεξαρτησία',
    'Patakis',
    488,
    'Ένας τριανταεξάχρονος μαθηματικός, που μεγάλωσε στην Αμερική και ζει με την άσβεστη μνήμη της μητέρας του, αναζητεί τα προγονικά του ίχνη στο απώτερο και στο απώτατο παρελθόν.Το ταξίδι της μνήμης θα ξεκινήσει από τις οικογενειακές αφηγήσεις για την ένοπλη αντίσταση κατά των συνταγματαρχών (τα όπλα θα πουν τον λόγο τους και στα μεταπολιτευτικά χρόνια), θα περάσει στην Ανατολική Γερμανία και στα σκοτεινά παιχνίδια των υπηρεσιών της Στάζι λίγο πριν από την κατάρρευση του κομμουνισμού και θα καταλήξει στον αγώνα των Ελλήνων για την απελευθέρωση από τον οθωμανικό ζυγό. Μια περιπλάνηση που περνάει μέσα από τις πιο διαφορετικές εμπειρίες: πανεπιστημιακές διαμάχες στην Αμερική, συγκρούσεις στο εσωτερικό των οργανώσεων της Αριστεράς κατά τη διάρκεια της δικτατορίας στην Ελλάδα, ατελείωτες παρτίδες τάβλι στα πολυσύχναστα παζάρια της Μέσης Ανατολής, υποψίες για την προδοσία ενός μεγάλου έρωτα, τη ζωή μέσα στην πολιορκημένη Τριπολιτσά του 1821 -και όλα αυτά ενώ οι πυρκαγιές μαίνονται στην Πύλο και η κρίση είναι έτοιμη να ξεσπάσει. Ο γκουρού της πληροφορικής ξαναχτυπά: αυτή τη φορά με ένα φιλόδοξο μυθιστόρημα ποταμό πεντακοσίων σελίδων, που αφηγείται, χωρίς να είναι σάγκα, την ιστορία τουλάχιστον τριών γενεών και μαζί τη σύγχρονη ελληνική ιστορία σε κάποιες κρίσιμες στιγμές της. Μανώλης Πιμπλής, Τα Νέα, 15-9-2012',
    'http://books.google.com/books/content?id=89kcDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601647623',
    'Το κουμπί και το φόρεμα',
    'Patakis',
    176,
    '«Bρήκα ένα κουμπί και για χάρη του έραψα ένα φόρεμα» λέει μια παροιμία. Εξηγεί –μεταφερμένη στη λογοτεχνία– την αναγωγή ενός στοιχείου σε διήγημα. Αυτός ο τρόπος ίσως είναι ο συνήθης. Όπως δεν υπάρχει στη φύση ευθεία γραμμή ή τέλειος κύκλος, δεν υπάρχει και στην κοινωνία αυτοτελές και ανεξάρτητο διήγημα. Και έτοιμο να φαίνεται, πάντα είναι μια αυθαίρετη διάκριση συγγραφέα. Ακόμα κι ένας αφηγητής προσωπικής εμπειρίας όχι μόνο κόβει και ράβει αλλά και –βαθύτερα– αγνοεί τα πάμπολλα ρυάκια που διαμόρφωσαν τη συγκεκριμένη κοίτη.Το βιβλίο περιέχει τριάντα πέντε ετερόκλητα διηγήματα. Τα σκηνικά τους είναι η δυτική μεθόριος, η επαρχία, η Αθήνα αλλά και οριακοί ψυχικοί τόποι.Μερικά διηγήματα είναι γραμμένα στη χωριάτικη, ποιητική γλώσσα.',
    'http://books.google.com/books/content?id=CJNMDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'QUE',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601647838',
    'Ο τύπος του διπλανού τάφου',
    'Patakis',
    288,
    'Η Ντεζιρέ επισκέπτεται συχνά τον τάφο του άντρα της, που είχε το «θράσος» να πεθάνει πολύ νέος. Βιβλιοθηκάριος και παιδί της πόλης, ζει σ’ ένα κάτασπρο μίνιμαλ διαμέρισμα γεμάτο βιβλία. Στο νεκροταφείο, διασταυρώνεται συχνά με τον τύπο του διπλανού τάφου, η εμφάνιση του οποίου την εκνευρίζει όσο και η φανταχτερή επιτύμβια στήλη που επιμένει να ανθοστολίζει. Μετά τον θάνατο της μητέρας του, ο Μπένι μένει μόνος στο οικογενειακό κτήμα με τις είκοσι τέσσερις γαλακτοφόρες αγελάδες του. Τα φέρνει βόλτα όπως όπως, με τη χωριάτικη κοινή λογική του και μια γερή δόση αυτοσαρκασμού. Κάθε φορά που τη συναντάει, τον πιάνει απελπισία με τη γειτόνισσά του στο νεκροταφείο, τον τσόχινο σκούφο και το μικρό σημειωματάριό της με τα ποιήματα. Μια μέρα, ωστόσο, ένα χαμόγελο ανθίζει ταυτόχρονα στα χείλη τους, αφήνοντας και τους δύο σαστισμένους… Είναι η αρχή ενός ακόρεστου πάθους. Με εξαιρετικό ρομαντισμό και καυστικό χιούμορ, αυτό το τρυφερό και αχαλίνωτο ερωτικό μυθιστόρημα θέτει το πολύ σοβαρό ερώτημα του πολιτισμικού σοκ και κατακτά το ευρωπαϊκό κοινό. «Βάλτε δίπλα δίπλα στο παγκάκι ενός νεκροταφείου ένα γοητευτικό γεροντοπαλίκαρο και μια άχρωμη νεαρή χήρα. Εκείνη είναι βιβλιοθηκάριος και δε σκέφτεται παρά την κουλτούρα, εκείνος είναι αγρότης και δε φαντάζεται πώς μπορεί κανείς να διαβάζει “με τη θέλησή του”. Μ’ αυτά τα υλικά, η Καταρίνα Μασέττι κατέκτησε τους Σουηδούς αναγνώστες, που έκαναν ανάρπαστο τον “Τύπο του διπλανού τάφου”. Όμως αυτό το μυθιστόρημα που μιλάει για έναν ασυνήθιστο έρωτα αποδεικνύει επίσης πως η χειραφέτηση από την κοινωνική μας τάξη δεν είναι ανώδυνη: όταν πρέπει να διαλέξουμε ανάμεσα στην όπερα και στο άρμεγμα των αγελάδων, το πάθος αποτελεί προαπαιτούμενο. Και είναι το λιγότερο που μας χρειάζεται». Epok, το εβδομαδιαίο περιοδικό της Fnac «Γοητευτική και απρόβλεπτη ιστορία αγάπης, απολαυστική και εθιστική». The Times «Τα ετερώνυμα έλκονται. Ναι, είναι παλιό το θέμα, αλλά, όπως αποδεικνύει περίτρανα ο “Τύπος του διπλανού τάφου”, εξακολουθεί να είναι από τα καλύτερα...» Daily Mail «Μεγάλο μπεστ σέλερ από τη Σουηδία, αυτή η ασυνήθιστη και τόσο αληθινή ερωτική ιστορία είναι απίστευτα διασκεδαστική και εθιστική ταυτόχρονα...» The Observer «Η πιο ωραία ιστορία αγάπης φέτος, η πιο διασκεδαστική, η πιο συγκινητική. Μια ευφορία που δε σε αφήνει...» Cosmopolitan «Μια διανοούμενη ντυμένη στα μπεζ. Ένας δυνατός αγρότης με σαρκώδη χείλη και φουσκωμένα μπράτσα, που ξετρελαίνουν τις γυναίκες της περιοχής του. Στο σπίτι της λίγα έπιπλα ντιζάιν, το δικό του στρωμένο με κεντήματα σε έντονα χρώματα. Βάλτε αυτούς τους δυο σ’ ένα νεκροταφείο... Εκείνη έχει χάσει τον άντρα της, εκείνος τη μητέρα του. Ένας μεγάλος έρωτας, ο ωραιότερος εδώ και καιρό...» περ. Télé 7 «Ένα μυθιστόρημα τρυφερό και γεμάτο χιούμορ για μια παράξενη ιστορία αγάπης. Εξαιρετικό!» περ. Prima',
    'http://books.google.com/books/content?id=OeUcDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'HIN',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601647883',
    'Το πράσινο ακρογιάλι της πατρίδας',
    'Patakis',
    576,
    'Στο δεξιοτεχνικό πρώτο µυθιστόρηµά της που διαδραµατίζεται στην Αθήνα και το Παρίσι, η Νάταλι Μπακόπουλος µας γνωρίζει δύο αδελφές, την εικοσάχρονη Σοφία και τη δεκαεξάχρονη Άννα, και µας διηγείται τις σπαρακτικές ιστορίες αγάπης και αντίστασης στις οποίες πρωταγωνιστούν, µε φόντο µια τραγική στιγµή της ελληνικής ιστορίας: τη δικτατορία του 1967. «Η Νάταλι Μπακόπουλος διαθέτει ένα σπάνιο ταλέντο, την ικανότητα να ανακαλεί µια δραµατική περίοδο της ιστορίας χρησιµοποιώντας τις ζωές των απλών ανθρώπων και τις λεπτοµέρειες της καθηµερινότητας. Το Πράσινο ακρογιάλι της πατρίδας είναι ένα συναρπαστικό βιβλίο, γεµάτο προσωπικές και αληθινές στιγµές». Ελίζαµπεθ Κόστοβα, συγγραφέας του The Historian «Το Πράσινο ακρογιάλι της πατρίδας είναι ένα γοητευτικό µυθιστόρηµα µε θέµα την πολιτική καταπίεση και τις επιπτώσεις της σε προσωπική και οικογενειακή κλίµακα. Η Μπακόπουλος χαρτογραφεί την αδιόρατη, διαβρωτική αγωνία της ζωής υπό τη χούντα των συνταγµαταρχών, τον αδιάκοπο καθηµερινό εξαναγκασµό – µε ακρίβεια και ειλικρινή κατανόηση. Η συγγραφέας περιγράφει µε άκρως οξυδερκή και συγχρόνως συγκινητικό τρόπο τον έρωτα υπό καθεστώς τυραννίας – διστακτικό, λαθραίο αλλά απελευθερωτικό». Πίτερ Χο Ντέιβις συγγραφέας του The Welsh Girl «Η Νάταλι Μπακόπουλος θίγει µε οξυδέρκεια και βαθιά κατανόηση δύο θέµατα: τη σταδιακή επιβολή της πολιτικής καταπίεσης και την εισβολή της στην προσωπική ζωή. Οι ήρωές της, που εντυπώνονται βαθιά στην ψυχή του αναγνώστη, “φλέγονται, εκρήγνυνται εσωτερικά”». Τσαρλς Μπάξτερ, συγγραφέας του The Feast of Love «Η οικογένεια στο επίκεντρο του συγκλονιστικού πρώτου µυθιστορήµατος της Νάταλι Μπακόπουλος βρίσκεται στο σταυροδρόµι όπου το προσωπικό συναντά το πολιτικό. Δράµα που αναζητά την κάθαρση, αλλά και στοχασµός πάνω στον πόνο και την αδιάκοπη νοσταλγία για τις στιγµές και τους τόπους που έχουµε χάσει». Εleni Ν. Gage, συγγραφέας του North of Ithaca',
    'http://books.google.com/books/content?id=6eIcDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'KAL',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601648392',
    'Πενήντα αποχρώσεις του Γκρι - Απελευθέρωση',
    'Patakis Publishers',
    816,
    'Η ολοκλήρωση της τριλογίας-φαινόμενο που άλλαξε τον τρόπο που βλέπουμε τον έρωτα... Από την πρώτη στιγμή που η Άνα Στιλ συνάντησε τον δυναμικό, όσο και προβληματικό, επιχειρηματία Κρίστιαν Γκρέυ, γεννήθηκε μεταξύ τους μια αισθησιακή σχέση που άλλαξε αμετάκλητα τη ζωή και των δύο. Η Άνα ήξερε από την αρχή πως η αγάπη για τις Πενήντα Αποχρώσεις της δε θα ήταν εύκολη δουλειά και η κοινή ζωή τους δημιουργεί προκλήσεις που κανένας τους δεν είχε προβλέψει. Εκείνη πρέπει να μάθει να μοιράζεται τον πολυτελή τρόπο ζωής του Γκρέυ χωρίς να θυσιάζει την ακεραιότητα και την ανεξαρτησία της, και ο Γκρέυ πρέπει να ξεπεράσει την παρόρμησή του να ελέγχει τους άλλους και να αφήσει πίσω του τις αναμνήσεις που εξακολουθούν να τον στοιχειώνουν. Τώρα, επιτέλους μαζί, έχουν αγάπη, πάθος κι έναν κόσμο με άπειρες δυνατότητες. Aκριβώς όμως τη στιγμή που φαίνεται πως πραγματικά έχουν τα πάντα, η τραγωδία και η μοίρα συνδυάζονται για να κάνουν πραγματικότητα τους χειρότερους εφιάλτες της Άνα…',
    'http://books.google.com/books/content?id=O3TBBwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601651606',
    'Το συμβόλαιο του Παγκανίνι',
    'Patakis',
    616,
    'Μια νεαρή γυναίκα βρίσκεται νεκρή πάνω σ’ ένα ακυβέρνητο γιοτ στο αρχιπέλαγος της Στοκχόλμης. Τα πνευμόνια της είναι γεμάτα θαλασσινό νερό, κι όμως δεν βρίσκεται ούτε σταγόνα στα ρούχα της. Η αδελφή του θύματος, μια διάσημη ακτιβίστρια για την ειρήνη, καταδιώκεται από έναν αδυσώπητο φονιά. Την ίδια μέρα, ένα πτώμα ανακαλύπτεται κρεμασμένο από σχοινί μπουγάδας σ’ ένα διαμέρισμα της Στοκχόλμης. Πρόκειται για τον Καρλ Παλμκρόνα, τον γενικό διευθυντή της Επιθεώρησης Στρατηγικών Προϊόντων, τον άνθρωπο που επικυρώνει τα συμβόλαια εξοπλισμών της Σουηδίας. Όλα δείχνουν ότι πρόκειται για φόνο, γιατί το δωμάτιο είναι άδειο και δεν είχε τρόπο να σκαρφαλώσει ως τον διπλό κόμπο που τον έπνιξε. Ωστόσο ο επιθεωρητής Γιούνα Λίννα είναι σίγουρος ότι πρόκειται για αυτοκτονία… Διεξάγοντας ταυτόχρονα τις δύο έρευνες, ο Λίννα αγνοεί ότι εισχωρεί σ’ έναν ύποπτο κόσμο αποτελούμενο από μυστικές προμήθειες, σιωπηρές συμφωνίες και διαβολικά συμβόλαια. Έναν κόσμο όπου τα μακιαβελλικά σχέδια συναγωνίζονται με τους χειρότερους εφιάλτες. Έναν κόσμο όπου τα συμβόλαια δεν μπορούν να σπάσουν ούτε με τον θάνατο. Μετά τον Υπνωτιστή, ο Λαρς Κέπλερ υπογράφει άλλη μια φορά ένα συναρπαστικό θρίλερ και συνεχίζει να εξερευνά τη σκοτεινή όψη της Σουηδίας.',
    'http://books.google.com/books/content?id=UpQbDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601651736',
    'Το βιβλίο της Κατερίνας',
    'Patakis',
    256,
    'Η ιστορία μου αρχίζει από το τέλος – το δικό της και το δικό μου. Έτσι ξεκινά το Βιβλίο της Κατερίνας, μιας γυναίκας που πάλεψε μια ζωή με την ψυχική αρρώστια, και που, αν νικήθηκε, έζησε και μεγαλούργησε ταπεινά χάρη στην αγάπη. Μια οικογενειακή σάγκα γεμάτη ζοφερά μυστικά και θανάσιμες ενοχές, ένα βιβλίο μυστηρίου γύρω από έναν αδιανόητο φόνο και τα δυο του θύματα, και μια κατάδυση σε μια ψυχή που συγκλονίζει με το φως και το σκοτάδι της.Μας λέει η Κατερίνα: Αυτό το βιβλίο δεν έχει σκοπό να πληγώσει κανέναν, εκτός απ’ αυτούς που θα το διαβάσουν. Αυτό το βιβλίο, θα πουν, είναι γεμάτο ψέματα. κακοήθειες, ανακρίβειες, παραχάραξη της οικογενειακής μας ιστορίας από ένα μυαλό χολωμένο κι άρρωστο, που γυρεύει εκδίκηση για τον θάνατο που μόνο του επέλεξε. Ωστόσο εμένα αυτή είναι η αλήθεια μου, κι από κει και πέρα, ο καθείς ας διαλέξει τη λήθη που του ταιριάζει, που τον ανακουφίζει. έτσι είναι αν έτσι νομίζουνε. Αυτό το βιβλίο με διαλύει. Αυτό το βιβλίο έχει σκοπό να με διαλύσει, να με κάνει κομμάτια. Μέσα στα κομμάτια μου είμαι. Κι όποιος την ακούσει δεν θα την ξεχάσει ποτέ.',
    'http://books.google.com/books/content?id=joMbDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'RUN',
    3.25
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601655581',
    'Εκεί και πάντα αλλού',
    'Patakis',
    320,
    'Εκεί και πάντα αλλού… σ’ ένα άλλο όνειρο, σε µια παράλληλη σχέση, σε µια λάθος εποχή. Οι ήρωες της ιστορίας ζούνε το όνειρο σε δόσεις, µην τολµώντας να αλλάξουν τη ζωή τους ουσιαστικά. Η Δώρα, παντρεµένη πολλά χρόνια µε τον Γρηγόρη, εργάζεται νοσηλεύτρια σε δηµόσιο νοσοκοµείο. Εκεί θα γνωρίσει και θα συνδεθεί µε τη Σαπφώ, µιαν ηλικιωµένη γυναίκα. Μέσα από το ηµερολόγιό της, η Δώρα θα παρακολουθήσει έναν µεγάλο έρωτα σε µια Ελλάδα διαφορετική. Αυτές οι σελίδες µιας άλλης ζωής θα τη βοηθήσουν να ξεκινήσει ένα ταξίδι αναζήτησης της προσωπικής της αλήθειας. Κι ας είναι τελείως διαφορετική η δική της ιστορία και οι δικές της απώλειες. Φαίνεται οι ίσκιοι όλοι µοιάζουν.',
    'http://books.google.com/books/content?id=zMhMDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601655666',
    'Η κατάσκοπος της Ταγγέρης',
    'Patakis',
    752,
    'Υπάρχουν βιβλία που γίνονται αµέσως κλασικά, γιατί αφηγούνται ιστορίες που µοιάζουν να περίµεναν πάντα τον συγκεκριµένο συγγραφέα να τις φέρει στο φως. Αυτό συνέβη µε το βιβλίο αυτό, το πρώτο µυθιστόρηµα της Μαρία Ντουένιας, ένα εκπληκτικό µυθιστόρηµα που πιάνει ρίζες στην ψυχή του αναγνώστη σελίδα τη σελίδα, διασχίζοντας τις αρτηρίες της ευρωπαϊκής ιστορίας του εικοστού αιώνα µέσα από πρωτοφανέρωτες διαδροµές.1935... Η Σίρα Κιρόγα, η νεαρή κόρη µιας µοδίστρας στη Μαδρίτη, ενώ ετοιµάζεται για τον γάµο της, ερωτεύεται παράφορα έναν χαρισµατικό άνδρα, επιχειρηµατία και κοσµοπολίτη, τον Ραµίρο Αρρίµπας. Τις ίδιες µέρες έρχεται αναπάντεχα αντιµέτωπη µε µια συνταρακτική αποκάλυψη για την ίδια της την ύπαρξη: την πραγµατική ταυτότητα του πατέρα της, που δεν είναι άλλος από τον Γκονθάλο Αλβαράδο, έναν από τους επιφανέστερους κατοίκους της πόλης... Κι ενώ οι δραµατικές ανατροπές µοιάζουν να διαδέχονται η µία την άλλη, η Σίρα, λίγο πριν από το ξέσπασµα του εµφυλίου, εγκαταλείπει τα πάντα για να ακολουθήσει τον Ραµίρο στο Μαρόκο… Μαζί εγκαθίστανται στην Ταγγέρη, µια κοσµική και εξωτική πόλη όπου καθετί αδιανόητο µπορεί να γίνει πραγµατικότητα. Ακόµη και η προδοσία και η εγκατάλειψη…Η Κατάσκοπος της Ταγγέρης είναι ένα υπέροχο µυθιστόρηµα στο οποίο η λογοτεχνική µαεστρία συναντάει τη µεγάλη περιπέτεια, όπου τα ατελιέ υψηλής ραπτικής, η λάµψη των µεγάλων ξενοδοχείων, οι πολιτικές συνωµοσίες και οι σκοτεινές αποστολές των µυστικών υπηρεσιών συνυφαίνονται µε την αφοσίωση προς όσους αγαπάµε και µε την ασυγκράτητη δύναµη του έρωτα. «Η Μαρία Ντουένιας εκθρόνισε την E L James!» Buchreport «Αυτό το εκπληκτικό ντεµπούτο µε την αψεγάδιαστη γλώσσα και την εξαιρετική σύλληψη και πλοκή καθιέρωσε διαµιάς τη δηµιουργό του». Publishers Weekly «Μην ξεκινήσετε για διακοπές χωρίς το βιβλίο αυτό!» Kirkus Reviews «Και ξαφνικά ένα µυθιστόρηµα… Ένα µυθιστόρηµα σαν τα παλιά, σαν τα παντοτινά, σαν αυτά που δε γράφονται σχεδόν ποτέ… Μαδρίτη, Ταγγέρη, Τετουάν, Λισσαβόνα, µια µοδίστρα beautiful and damned που ρίχνεται στην περιπέτεια, στην αγάπη και στο µίσος, στον πόλεµο και στην ειρήνη, και σ έναν κόσµο κατασκόπων, φυγάδων, απατεώνων, µαταιωµένων ή όχι ονείρων, και της αµαρτωλής γοητείας όλων όσα χάθηκαν, ανεπιστρεπτί, στο διάβα του χρόνου… Εθιστικό, συναρπαστικό, σαρωτικό». El Mundo «Ανοίξτε το βιβλίο αυτό και ετοιµαστείτε για ένα υπέροχο ταξίδι...» Kate Morton «Είναι ευχάριστο µια φρενήρης πλοκή να προσελκύει αναγνώστες, αλλά είναι ακόµη πιο ευχάριστο να µην έχει ούτε παγίδες ούτε παραπλανητικά τεχνάσµατα». ABC',
    'http://books.google.com/books/content?id=AVBLDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'AZE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601656052',
    'Δυο φορές Άνοιξη',
    'Patakis',
    408,
    'Σπουδαστές ήταν η Aνθή και ο Δηµήτρης, όταν γνωριστήκανε, ερωτευθήκανε και, προτού καν κλείσουνε τα είκοσί τους χρόνια, παντρευτήκανε. Η Ανθή είχε µείνει έγκυος.Το πρώτο παιδί γρήγορα θα το ακολουθήσει ένα δεύτερο. Κι ενώ ο Δηµήτρης ανέρχεται επαγγελµατικά, η Ανθή αισθάνεται –και είναι– εγκλωβισµένη σε µια ζωή οικογενειακής ρουτίνας.Η εισβολή στην καθηµερινότητά της του γοητευτικού φωτογράφου Μανουήλ θα της φανερώσει το τι σηµαίνει να σε ερωτεύονται µε πάθος, αλλά και το τι η ίδια είναι ικανή να δηµιουργήσει. Μα όταν ο Μανουήλ θα της προτείνει να τον ακολουθήσει, εκείνη θα προτιµήσει να µείνει κοντά στον άντρα και στα δυο αγόρια της. Όµως η ίδια η ζωή έχει διαφορετικά αποφασίσει.Ένα τρίτο παιδί έρχεται – κορίτσι αυτή τη φορά.Κι έτσι εκείνο που κάποιος σχεδιάζει δε σηµαίνει πως είναι και αυτό που θα συµβεί. Η Ανθή θα πρέπει να αντιµετωπίσει τις επιθυµίες της – κι αυτές που αργοσβήνουνε κι όσες ζητάνε να ανθοφορήσουν.',
    'http://books.google.com/books/content?id=l_YPDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.75
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601657660',
    'H σιωπηλή σύζυγος',
    'Patakis',
    400,
    'Ο γάµος της Τζόντι και του Τοντ βρίσκεται σε κρίσιµη στιγµή. Πολλά διακυβεύονται, συµπεριλαµβανοµένης της άνετης ζωής τους στο πανέµορφο διαµέρισµα στο Σικάγο δίπλα στο νερό, καθώς εκείνη και εκείνος προχωρούν µε ιλιγγιώδη ταχύτητα προς το κεντρικό γεγονός. Εκείνος ζει διπλή ζωή. Εκείνη ζει και αναπνέει την άρνηση. Εκείνος αποφασίζει να φύγει. Εκείνη δεν έχει τίποτα πια να χάσει.Μέσα από την εναλλαγή των φωνών, η Σιωπηλή σύζυγος µιλάει για έναν γάµο που διαλύεται, για ένα ζευγάρι που οδεύει προς την καταστροφή, για παραχωρήσεις που είναι αδύνατον να γίνουν, για υποσχέσεις που δεν πρόκειται να εκπληρωθούν... «Με την κοµψή και επιδέξια πένα της σκιαγραφεί τα αντιµαχόµενα ψυχολογικά πορτρέτα δύο εραστών που µετατρέπονται σε υποτιθέµενο δολοφόνο και άτυχο θύµα, σε µια ιστορία που κανείς δεν πρόκειται να ξεχάσει σύντοµα. Δεν µπορούσα να αφήσω το βιβλίο από τα χέρια µου». Elizabeth George «Το ανατριχιαστικό πορτρέτο µιας σχέσης που πήγε τροµερά λάθος. Μια ιστορία που κόβει την ανάσα και που θα σας κρατήσει πάνω από το βιβλίο µέχρι πολύ αργά τη νύχτα, ξάγρυπνους για πολλή ώρα ακόµα κι όταν φτάσετε στην τελευταία σελίδα». New York Times «Η ανάγνωση της Σιωπηλής συζύγου είναι µια αµαρτωλή απόλαυση!» Kate Atkinson «Σαν µικροσκοπική ρωγµή στο γυαλί του πεπρωµένου, η Σιωπηλή σύζυγος εξετάζει την έσχατη συντριβή ενός απολύτως πολιτισµένου γάµου. Έντονη, σαγηνευτική και απολύτως συναρπαστική, η πένα της Harrison προκαλεί τους χαρακτήρες της να ξεπεράσουν τα όριά τους και να βγουν σε έναν κόσµο όπου τα πάντα είναι πιθανά, ακόµη και ο φόνος». Elizabeth Brundage «ΥΠΕΡΟΧΟ… Καλύτερο από το Gone Girl της Gillian Flynn». Sophie Hannah',
    'http://books.google.com/books/content?id=lDdLDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601660073',
    'Το σοφό παιδί (νέα έκδοση)',
    'Patakis',
    464,
    'Δεκαπέντε χρόνια μετά την πρώτη του έκδοση, το Σοφό παιδί, το μυθιστόρημα του Χρήστου Χωμενίδη που ενθουσίασε κοινό και κριτικούς και έγινε σημείο αναφοράς για τη γενιά της Μεταπολίτευσης, ξανακυκλοφορεί από τις Εκδόσεις Πατάκη.Για την καινούρια έκδοση το κείμενο έχει στοιχειοθετηθεί από την αρχή. Περιλαμβάνονται επίσης αποσπάσματα από τις κριτικές, πρόλογος του συγγραφέα, αναπαραγωγή της πρώτης χειρόγραφης σελίδας, ενώ το εξώφυλλο κοσμεί έργο του Δημήτρη Παπαϊωάννου που φιλοτέχνησε το 1990 διαβάζοντας το χειρόγραφο του μυθιστορήματος.',
    'http://books.google.com/books/content?id=9b8PDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601666587',
    'Χιόνι',
    'Patakis',
    498,
    'Ο Κα, εξόριστος στη Γερµανία Τούρκος ποιητής, επιστρέφει στην πατρίδα του για να ταξιδέψει σε µια αποµακρυσµένη πόλη κοντά στα σύνορα µε την Αρµενία, το Καρς. Σκοπός του είναι η πραγµατοποίηση µιας δηµοσιογραφικής έρευνας για τις µαζικές αυτοκτονίες κοριτσιών που τους απαγορεύεται να φορούν την ισλαµική µαντίλα. Στο Καρς όµως τον οδηγούν επίσης οι αναµνήσεις του για τη λαµπερή Ιπέκ, την προσφάτως διαζευγµένη παλιά του συµφοιτήτρια. Εν µέσω διαρκούς χιονόπτωσης και καθολικής καχυποψίας, ο Κα θα βρεθεί στο επίκεντρο της σύγκρουσης των ισλαµιστών µε το κεµαλικό κατεστηµένο και θα µπει στο στόχαστρο του πρώην συζύγου της Ιπέκ, ενός τροµοκράτη και άλλων.',
    'http://books.google.com/books/content?id=aMW8EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    2.20
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601668062',
    'Τα μηχανάκια',
    'Patakis',
    304,
    'Τέσσερις έφηβοι τη δεκαετία του ’50, τέσσερις ιστορίες: Ο Αναστάσης παίζει μηχανάκια για να ξεφύγει από τον κλοιό της οικογένειας, της γειτονιάς και της ασυνεννοησίας των φίλων· ο Χαράλαμπος στο Λουτρό γίνεται υποχείριο μιας αδηφάγας μητρικής στοργής· ο Κίτσος ανθίζει και μαραίνεται μέσα στο τέλμα της Επαρχίας Λοκρίδος· τέλος, ο Δημητρούλης, ασουλούπωτος φαντάρος στη Δόξα του σκαπανέα, είναι το αιώνιο θύμα της στρατοκρατίας. Με τα Μηχανάκια ο Μένης Κουμανταρέας έκανε το 1962 την πρώτη του εμφάνιση στην ελληνική πεζογραφία. Οι ήρωές του στοχάζονται, μα προπάντων ζουν ή τουλάχιστον προσπαθούν να ζήσουν. Και δεν είναι μόνο άτομα, αλλά και ολόκληροι κόσμοι, ολόκληρες καταστάσεις που μπαίνουν πλάι-πλάι, σε αντιπαραβολή, και συζητούν και αντιδικούν. Πέτρος Χάρης',
    'http://books.google.com/books/content?id=6G3WDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601673196',
    'Ιστανμπούλ. Πόλη και αναμνήσεις',
    'Patakis',
    309,
    '«Δεν µπορεί να είναι τόσο χάλια η ζωή» σκέφτοµαι καµιά φορά. «Ό,τι και να γίνει, ο άνθρωπος στο τέλος µπορεί να πάει να περπατήσει στον Βόσπορο». Ο Ορχάν Παµούκ αφηγείται τα παιδικά και νεανικά του χρόνια. Η αφήγηση ξεκινά από τη στιγµή που ο συγγραφέας αντιλαµβάνεται τον εαυτό του ως «εγώ», µιλά για την οικογένειά του, αναζητά την πηγή της ευτυχίας και της δυστυχίας στα στενά της Ιστανµπούλ και στα υπέροχα νερά του Βοσπόρου, στρέφεται στους συγγραφείς και τους ζωγράφους –Τούρκους και µη, της Δύσης και της Ανατολής– που συνέβαλαν στην αυτογνωσία τη δική του και της πόλης του. Με ταχύτητα αστυνοµικού µυθιστορήµατος παρακολουθούµε τη διαµόρφωση του ψυχικού κόσµου του Παµούκ και ανακαλύπτουµε, µέσα από τη διεισδυτική µατιά του, τα σοκάκια της Ιστανµπούλ της δεκαετίας του 1950, τις λιθόστρωτες λεωφόρους της, τα κατεστραµµένα από τις πυρκαγιές ξύλινα αρχοντικά, την εξαφάνιση ενός αλλοτινού κόσµου και πολιτισµού και τις δυσκολίες ανάδυσης ενός καινούριου µέσα στα ερείπια του πρώτου. Ένα πορτρέτο της θρυλικής πόλης –αυτοπροσωπογραφία επίσης του συγγραφέα– και της χιουζούν, της θλίψης, της µελαγχολίας, της tristesse, του πιο δυνατού και µόνιµου αισθήµατος «που µεταδίδουν ο ένας στον άλλο οι κάτοικοι της Ιστανµπούλ και η ίδια η Ιστανµπούλ» και ζει στα ερείπια µιας χαµένης αυτοκρατορίας. Η αφήγηση, στην εµπλουτισµένη αυτή έκδοση, µε 200 επιπλέον φωτογραφίες, συνοµιλεί µε φωτογραφικό υλικό από το προσωπικό αρχείο του συγγραφέα και φωτογραφίες µεγάλων φωτογράφων, µε πρώτο τον Αρά Γκιουλέρ.',
    'http://books.google.com/books/content?id=ysa8EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601685427',
    'Ο κυνηγός του σκότους',
    'Patakis',
    339,
    'Δεν υπάρχουν ενδείξεις, αλλά σημάδια. Δεν υπάρχουν εγκλήματα, μόνο ανωμαλίες. Και κάθε θάνατος είναι η αρχή μιας αφήγησης. Αυτή είναι η ιστορία ενός άντρα που δεν έχει πια τίποτα –δεν έχει ταυτότητα, δεν έχει μνήμη, δε νιώθει αγάπη, ούτε μίσος– εκτός από την οργή του… Και ένα μυστικό χάρισμα. Γιατί ο Μάρκους είναι ο τελευταίος από τους πνευματικούς: είναι ένας ιερέας που έχει την ικανότητα να ξετρυπώνει τις ανωμαλίες και να ξεχωρίζει τα νήματα που συνυφαίνουν την πλοκή κάθε ανθρωποκτονίας. Αλλά ακόμα κι αυτός κινδυνεύει να μην μπορέσει να ανασυνθέσει αυτή την πλοκή. Αυτή είναι επίσης η ιστορία μιας γυναίκας που προσπαθεί να ανασυγκροτήσει τον ίδιο της τον εαυτό. Και η Σάντρα δουλεύει στις σκηνές του εγκλήματος αλλά, αντίθετα με τον Μάρκους, δεν πρέπει να κρύβεται παρά μόνο πίσω από τον φακό της φωτογραφικής μηχανής της. Γιατί η Σάντρα είναι φωτογράφος της αστυνομίας: το ταλέντο της είναι να φωτογραφίζει το τίποτα, για να το καταστήσει ορατό. Αλλά αυτή τη φορά το τίποτα απειλεί να την καταπιεί. Ο Κυνηγός του σκότους είναι, τέλος, η υπόθεση της σύλληψης ενός τρελού δολοφόνου στους δρόμους της Ρώμης, που υπακούει σ ένα σχέδιο τρομερό κι εντούτοις σαγηνευτικό. Και κάθε φορά που ο Μάρκους και η Σάντρα νομίζουν πως έχουν καταλάβει ένα κομμάτι της αλήθειας, ανακαλύπτουν ένα ακόμα πιο ανησυχητικό και απειλητικό σενάριο. Διαβάζοντάς το, θα δίνετε την ίδια μάχη με τον Μάρκους, πέφτοντας πάνω στα ίδια αινίγματα που ταλανίζουν τη Σάντρα, βιώνοντας τις ίδιες προσδοκίες και τους ίδιους φόβους μέχρι την τελευταία αράδα. Και δε θα το ξεχάσετε ποτέ πια.',
    'http://books.google.com/books/content?id=9XN8EAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'SWA',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789601686370',
    'Κυνηγός κουνελιών',
    'Patakis',
    616,
    'Όλα ξεκινούν με ένα παιδικό ποιηματάκι. Δεκαεννέα λεπτά μετά, πεθαίνεις… Ο Γιούνα Λίννα έχει εκτίσει ποινή δύο χρόνων σε μία φυλακή υψίστης ασφαλείας, όταν του δίνεται η ευκαιρία να εξασφαλίσει την ελευθερία του: η αστυνομία χρειάζεται τη βοήθειά του για να σταματήσει έναν μυστηριώδη δολοφόνο που ακούει στο όνομα Κυνηγός Κουνελιών. Το μόνο που συνδέει τα θύματα είναι ότι όλα ακούνε ένα παιδί να απαγγέλλει ένα παιδικό ποίημα προτού χτυπήσει ο δολοφόνος. Ένα παιχνίδι της μοίρας τοποθετεί απροσδόκητα τον διάσημο σεφ Ρεξ Μύλλερ στο επίκεντρο. Τη στιγμή που ετοιμάζεται να περάσει για πρώτη φορά τρεις βδομάδες χαλάρωσης με τον γιο του, βρίσκεται να δίνει μια τρομακτική μάχη επιβίωσης. Κι ο Γιούνα Λίννα πρέπει να σταματήσει έναν διαταραγμένο δoλοφόνο του οποίου τα καταστροφικά ίχνη οδηγούν τριάντα χρόνια πίσω σε μία φρικιαστική βραδιά βίας με αδιανόητες συνέπειες... Ο Κυνηγός Κουνελιών αναδείχτηκε το πρώτο σε πωλήσεις μυθιστόρημα στη Σουηδία το 2016, καθώς και το πρώτο σε πωλήσεις αστυνομικό μυθιστόρημα στη Νορβηγία την ίδια χρονιά. Είναι αδύνατο να αφήσεις από τα χέρια σου το βιβλίο αυτό προτού διαβάσεις και τις 616 σελίδες του. Ο Κυνηγός Κουνελιών είναι το καλύτερο βιβλίο του Κέπλερ! Fædrelandsvennen, Νορβηγία Το βιβλίο αυτό είναι ένα πραγματικό αριστούργημα. Fyens Stiftstidende, Δανία Μου είναι αδύνατο να αντισταθώ στον Κέπλερ: ξεκινάει με απίστευτη ορμή που κορυφώνεται καθώς ο Κυνηγός Κουνελιών αγγίζει τους πρωταγωνιστές. Dagens Nyheter, Σουηδία',
    'http://books.google.com/books/content?id=YjTWDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789604007837',
    'Κατάδικος',
    'Pelekanos Books',
    145,
    'Ο Κατάδικος είναι ένα εκτεταμένο αφήγημα που γράφτηκε το 1919 από τον ρεαλιστή πεζογράφο Κωνσταντίνο Θεοτόκη. Η υπόθεση του έργου εκτυλίσσεται σε ένα αγροτικό χωριό της Κέρκυρας με πρωταγωνιστές τον Γιώργη Αράθυμο, την όμορφη σύζυγό του Μαργαρίτα, τα τρία παιδιά τους και τον υποτακτικό τους Τουρκόγιαννο, παιδί μίας Χριστιανής Αρβανίτισσας. Ο γάμος του Γιώργη και της Μαργαρίτας, προερχόμενος κατά τα ήθη της εποχής από συνοικέσιο, κυλά ανέφελος μέχρι που εμφανίζεται στη ζωή της οικογένειας ο Πέτρος Πέπονας, ένας γείτονας που ερωτεύεται με πάθος και διεκδικεί τη Μαργαρίτα από το σύζυγό της. Το γεγονός δεν περνά απαρατήρητο και υποψίες γεννιούνται στον Τουρκόγιαννο, που διαβλέπει το πιθανό ολίσθημα της Μαργαρίτας, την πιθανή ανατροπή της οικογενειακής της γαλήνης… Ο Θεοτόκης επιλέγει μία ιστορία καθημερινών ανθρώπων, ανθρώπων του νησιού του, μία ερωτική αντιζηλία κι όχι μία αφήγηση με πρωταγωνιστές ήρωες και ανθρώπους που ξεπερνούν το ανθρώπινο μέτρο. Χωρίς ίχνος μελοδραματισμού, με λιτές περιγραφές, αφήνει τα γεγονότα να μιλήσουν από μόνα τους για μια γυναίκα που αποτελεί το μήλον της έριδος…',
    'http://books.google.com/books/content?id=UjVxBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605665951',
    'Η αρραβωνιαστικιά του Αχιλλέα',
    'Metaichmio Publications',
    347,
    '«Κανείς από τη γενιά μας δεν πρόλαβε. Μας προλάβαιναν άλλα. Πόλεμος, Δεκέμβρης, εμφύλιος, δικτατορία. Όλο τα παλιά θυμόμαστε. Μας βαριούνται. Δεν λέμε να τα ξεχάσουμε, είναι όλη μας η ζωή. Πόσες φορές είπαμε να τη φτιάξουμε από την αρχή! Δεν είναι το κουράγιο που μας έλειψε...» απόσπασμα από το βιβλίο Με αιφνιδιαστικά καθαρό βλέμμα και κρυστάλλινη διαύγεια, η Ελένη, η γήινη αρραβωνιαστικιά του καπετάνιου Αχιλλέα, που έφτασε στα πέρατα της γης, ως την Τασκένδη, για να σμίξει μαζί του, ανακαλεί το παρελθόν της. Πετράδι πετράδι συνθέτει το ψηφιδωτό της σημαντικότερης τριακονταετίας (’40-’70) της Ελλάδας, ξύνοντας παλιές και νεότερες πληγές που άφησαν ανεξίτηλα σημάδια σε ψυχές και σώματα.',
    'http://books.google.com/books/content?id=f5d6CAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605666477',
    'Τότε που ζούσαμε',
    'Metaichmio Publications',
    397,
    'Γραμμένο μες στη δικτατορία της χούντας, το Τότε που ζούσαμε αποτελεί μια πράξη αντίστασης και μαζί μιαν απολογία της γενιάς του Ασημάκη Πανσέληνου (1903-1984). Ο Ασημάκης Πανσέληνος αναθυμάται τη ζωή του γνωρίζοντας πως ζει κανείς την εποχή που αγωνίζεται για κάτι καλύτερο, την εποχή που κάνει το χρέος του σαν πολίτης και σαν άνθρωπος προς τους συμπολίτες του και προς τους ανθρώπους του τόπου του και όλου του κόσμου. Οι αναμνήσεις του είναι η τελευταία του προσπάθεια να αγωνιστεί ξανά, η προσφορά του. Η μνήμη πρέπει να διατηρείται, να επιβιώνει, να ξαναγίνεται μαγιά για τις γενιές που ακολουθούν και που έχουν τους δικούς τους αγώνες να δώσουν. Ένα μαγευτικό βιβλίο αναμνήσεων, ένα βιβλίο με συγκλονιστικές μαρτυρίες, με γοητευτική ατμόσφαιρα και με ιδέες τολμηρές και ανατρεπτικές, μας βοηθά σήμερα να θυμόμαστε πως τίποτα στη ζωή δεν μας χαρίζεται –ούτε στους ανθρώπους ούτε στους λαούς– αν δεν πολεμήσουμε και αν δεν αντισταθούμε.',
    'http://books.google.com/books/content?id=qTZ6CAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605720285',
    'Μια ζωή ψαρεύοντας',
    'Εκδόσεις Ίκαρος',
    152,
    'Το ψάρεμα είναι η απόλυτη ελευθερία. Να πηγαίνεις πάνω-κάτω, περιμένοντας το ψάρι να τσιμπήσει και να ξεδιψάς στις πηγές. Να είσαι εντελώς μόνος για μια ώρα, για λίγες μέρες, για λίγες εβδομάδες, είναι αυτό που πάντα αποζητούσα στη ζωή… Να τι πιστεύω πως είναι ελευθερία. …………………………………………………………………………….... Ένα 10χρονο αγόρι αναλαμβάνει την ευθύνη της οικογένειάς του, όταν ο πατέρας και τ’ αδέλφια του στέλνονται σε στρατόπεδα συγκέντρωσης κατά τη διάρκεια της γερμανικής κατοχής στην Τσεχοσλοβακία. Κυνηγάει και ψαρεύει και φροντίζει την ακριβή του μάνα. Σαν ελεύθερο πουλί, όπως εκείνο το χέλι στό διήγημα “Ο μέγας αλήτης των υδάτων”, που ξεγλιστράει από τα δεσμά του για να καταφύγει στην ελευθερία του ποταμού, έτσι κι ο μικρός Ότα Πάβελ, σαν ένας άλλος Τομ Σώγερ της Κεντρικής Ευρώπης τρέχει πάνω-κάτω σε ποτάμια, λίμνες και λιβάδια, γιατί βιάζεται να μεγαλώσει και να αποδράσει από μια δύσκολη εποχή που περνούσε η Ευρώπη και που τα σημάδια δείχνανε πως δεν θα ήτανε κι η τελευταία.',
    'http://books.google.com/books/content?id=Cl5uBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605720575',
    'Δώσε μου λίγη ζωή',
    'Εκδόσεις Ίκαρος',
    208,
    'Τορίνο, Φεβρουάριος 1926. Μέσα στη δίνη του μουσολινικού φασισμού, ο Μοράλντο, ένας φοβισμένος, ανασφαλής κι αναποφάσιστος νεαρός αναζητά τον εαυτό του, έχοντας ως ίνδαλμά του τον συνομήλικό του Πιέρο. Στον αντίποδα του Μοράλντο, ο εικοσιπεντάχρονος Πιέρο μάχεται με πείσμα και πάθος ενάντια στη δικτατορία του Μουσολίνι. Χάρη σε μια βαλίτσα, οι ζωές των δύο νεαρών θα συναντηθούν στο Παρίσι, όπου ο Πιέρο θα βρει καταφύγιο κυνηγημένος από το φασιστικό καθεστώς και ο Μοράλντο κυνηγώντας έναν απρόσμενο έρωτα. Ο Πάολο ντι Πάολο, το «θαύμα των ιταλικών γραμμάτων», υποψήφιος για τα λογοτεχνικά βραβεία Strega και Campiello, περιγράφει την Ιταλία της δεκαετίας του ’20 και παράλληλα αποτίει φόρο τιμής στον Τορινέζο αγωνιστή, δημοσιογράφο, πολιτικό και διανοούμενο Πιέρο Γκομπέτι. Ένα μυθιστόρημα για τη δύσκολη μα αναπόφευκτη μετάβαση των νέων προς την ενηλικίωση και συνάμα ένα μάθημα ζωής και ιστορίας',
    'http://books.google.com/books/content?id=4ryzBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605721138',
    'Σταθμός Έντεκα',
    'Εκδόσεις Ίκαρος',
    317,
    'Μια χιονισμένη νύχτα, ο Άρθουρ Λιάντερ, διάσημος ηθοποιός του Χόλιγουντ, παθαίνει καρδιακή προσβολή πάνω στη σκηνή κατά τη διάρκεια μιας παράστασης του Βασιλιά Ληρ. Ο Τζιβαν Σόντρι, ένας νεαρός παπαράτσι που σπουδάζει νοσηλευτική, βρίσκεται στο κοινό και σπεύδει να βοηθήσει, υπό το βλέμμα μιας οχτάχρονης ηθοποιού, της Κίρστεν Ρεϊμόντ. Όμως παρά τις προσπάθειές του, ο Άρθουρ καταλήγει νεκρός. Καθώς ο Τζίβαν γυρίζει σπίτι διασχίζοντας το χιονισμένο Τορόντο, πληροφορείται ότι έχει ξεσπάσει μια θανατηφόρα γρίπη που εξαπλώνεται ραγδαία. Αποφασίζει να οχυρωθεί στο διαμέρισμα του αδερφού του, σε ένα ουρανοξύστη, απ’ όπου παρατηρεί τον κόσμο, όπως τον ήξερε, να καταρρέει. Είκοσι χρόνια αργότερα, η Κίρστεν είναι ηθοποιός στην Περιπλανώμενη Συμφωνία, μια ομάδα ηθοποιών και μουσικών που ταξιδεύει στους οικισμούς του αλλαγμένου πια κόσμου, ανεβάζοντας Σαίξπηρ και παίζοντας μουσική. Η ζωή τους είναι ένας καθημερινός αγώνας επιβίωσης, καθώς οι αναμνήσεις τους μπλέκονται επώδυνα με τη νέα τους πραγματικότητα, ενώ το κακό μπορεί να καραδοκεί παντού. Ο Σταθμός Έντεκα είναι ένα υποβλητικό δυστοπικό μυθιστόρημα, σκοτεινό και ελεγειακό μα συνάμα λαμπερό και αισιόδοξο. Ένα μυθιστόρημα για την τέχνη, τη νοσταλγία, τους ανθρώπους που μας σημαδεύουν και την ομορφιά του κόσμου που μας περιβάλλει.',
    'http://books.google.com/books/content?id=FPGZEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    3.50
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605721213',
    'Στο πίσω κάθισμα',
    'Εκδόσεις Ίκαρος',
    440,
    'Ένας σκηνοθέτης βρίσκεται άγρια δολοφονημένος στο υπόγειο του Θεάτρου Πλάκας. Ο Αστυνόμος Χάρης Κόκκινος και οι συνεργάτες του θα κληθούν να διαλευκάνουν μια υπόθεση που αναμένεται να απασχολήσει την κοινή γνώμη. Σύντομα θα αντιληφθούν ότι θα χρειαστεί να αναζητήσουν τα αίτια της δολοφονίας στο σκοτεινό παρελθόν του σκηνοθέτη, ξετυλίγοντας ένα κουβάρι κοινών μυστικών, συγκάλυψης και βίας στην καρδιά της σημερινής Αθήνας. Ταυτόχρονα, ο γιος του σαρανταπεντάρη Αστυνόμου συλλαμβάνεται με κατηγορίες που θα τον αναγκάσουν να βουτήξει στο δικό του οικογενειακό παρελθόν. Η πίεση του χρόνου και τα σφραγισμένα στόματα θα αποδείξουν ότι τα πράγματα δεν είναι ποτέ απλά για όσους βρέθηκαν στο πίσω κάθισμα. Σε μια κοινωνία όπου όλοι είναι ένοχοι, κάποιοι θα πληρώσουν το τίμημα, μεταξύ αυτών και ο Χάρης Κόκκινος. Οι ανακρίσεις θα συνθέσουν μια τοιχογραφία των κατοίκων της Αθήνας που πρωταγωνιστεί σε μια ιστορία που δεν θα υπήρχε, αν δεν υπήρχε η πόλη και τίποτα δεν θα μείνει στο σκοτάδι κάτω από τον λαμπρό ήλιο της.',
    'http://books.google.com/books/content?id=J2qJDAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605721336',
    'Ο τσάρος της αγάπης και της τέκνο',
    'Εκδόσεις Ίκαρος',
    372,
    'Η εξαιρετικά καλογραμμένη συλλογή διηγημάτων του Anthony Marra, σκιαγραφεί μια πλειάδα αξέχαστων χαρακτήρων των οποίων οι ζωές διασταυρώνονται μεταξύ τους με τρόπο σπαραχτικό. Την δεκαετία του 1930 στο Λένινγκραντ, ένας ζωγράφος-διορθωτής επεξεργάζεται επίμαχες φωτογραφίες για λογαριασμό του Κόμματος του Στάλιν, σβήνοντας και αλλοιώνοντας πρόσωπα με τον αερογράφο του. Μαγεμένος από την εικόνα μιας μπαλαρίνας, βρίσκεται κατηγορούμενος για σχέση με την πολωνική κατασκοπεία. Μια ομάδα γυναικών αφηγείται τις ιστορίες της αλλά και αυτές των γιαγιάδων τους, πρώην κρατουμένων της Γκουλάγκ, που εγκαταστάθηκαν σε πόλη ορυχείων της Σιβηρίας. Δύο ζεύγη αδερφών μοιράζονται μια άγρια, προστατευτική αγάπη. Νεαροί άνδρες σε ολόκληρη τη πρώην Σοβιετική Ένωση αντιμετωπίζουν τη βία στο σπίτι και στο στρατόπεδο. Μεγάλες θυσίες γίνονται και στο όνομα ενός πετρελαιοειδούς τοπίου, το οποίο είναι συνηθισμένο εκτός από το σχεδόν ακατανόητο ειρηνικό παρελθόν που απεικονίζει. Ο Τσάρος της αγάπης και της τέκνο, με εκπληκτική πρόζα μιλά για τη ματαιότητα της προσπάθειας να εξαλειφθούν άνθρωποι και γεγονότα, για την ανθρώπινη προσαρμοστικότητα, το παράλογο της ζωής και του πολέμου, αλλά και το πόσο μικρή είναι η ζωή μας σε σχέση με το μέγεθος του σύμπαντος.',
    'http://books.google.com/books/content?id=M3s6DQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605721466',
    'Οι ιστορίες είναι πάντα ξένες',
    'Εκδόσεις Ίκαρος',
    568,
    'Το βιβλίο αυτό συγκεντρώνεται το σύνολο του έως τώρα διηγηματογραφικού έργου του βραβευμένου συγγραφέα. Από τα πρώτα αφηγήματα της Πολυξένης μέχρι την τελευταία συλλογή Στον Τόπο, τα διηγήματα διατρέχουν τη νεότερη ιστορία της Ελλάδας, εστιάζοντας στα θέματα που εδώ και χρόνια απασχολούν τον Δημήτρη Νόλλα: ο ξένος, η πατρώα γη, η μοναξιά, η περιδίνηση του σύγχρονου ανθρώπου στην παράλογη καθημερινότητα. Παράλληλα, καθώς τα κείμενα δημοσιεύονται διατηρώντας τον χαρακτήρα της πρώτης τους γραφής, αναδεικνύεται η ματιά του συγγραφέα στον κόσμο τον συγκεκριμένο χρόνο, και ταυτόχρονα η εξέλιξη στον τρόπο γραφής του. «...Ένας τροχός που δεν σταματάει να γυρίζει η ζωή κι ο κόσμος. Τις σπίθες της τριβής του αποτυπώνει μαστορικά στα διηγήματά του ο Δημήτρης Νόλλας, μαζί με τις ουλές από τα εγκαύματα που προκαλούν στα σώματα και στις ψυχές. Παρακαταθήκη πολύτιμη στη νεοελληνική λογοτεχνία.» Τιτίκα Δημητρούλια',
    'http://books.google.com/books/content?id=QZS4DQAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'DEU',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605721695',
    'Στο Κάσελ δεν υπάρχει λογική',
    'Εκδόσεις Ίκαρος',
    273,
    'Ένα περίεργο τηλεφώνημα διακόπτει την καθημερινότητα ενός συγγραφέα. Η μυστηριώδης γυναικεία φωνή στην άλλη άκρη της γραμμής τού λέει ότι οι ΜακΓκάφιν θέλουν να τον προσκαλέσουν σε δείπνο για να του αποκαλύψουν τη λύση στο μυστήριο του σύμπαντος. Σύντομα θ’ ανακαλύψει ότι πρόκειται για μια πρόσκληση συμμετοχής στην Ντοκουμέντα του Κάσελ, τη θρυλική έκθεση σύγχρονης τέχνης. Η αποστολή του συγγραφέα θα είναι να καθίσει να γράφει κάθε πρωί σε ένα κινέζικο εστιατόριο στα προάστια της πόλης, μετατρέποντας τον εαυτό του σε μια ζωντανή καλλιτεχνική εγκατάσταση. Στο Κάσελ, ο συγγραφέας διαπιστώνει έκπληκτος ότι η ψυχολογία του δεν πέφτει όταν σουρουπώνει και ότι, αντιθέτως, τον πλημμυρίζει η αισιοδοξία όταν κάνει περίπατο, διότι τον παρασύρει η αστείρευτη ενέργεια που κάνει την καρδιά της έκθεσης να χτυπά. Είναι η αυθόρμητη και ευφάνταστη απάντηση της τέχνης που ορθώνει ανάστημα μπροστά την απαισιοδοξία.',
    'http://books.google.com/books/content?id=ObyZEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605722241',
    'Περί φυσικής της μελαγχολίας',
    'Εκδόσεις Ίκαρος',
    238,
    'Έχοντας συμπεριληφθεί στη μακρά λίστα των βραβείων Strega Europeo (Ρώμη, 2014) και Gregor von Rezzori (Φλωρεντία, 2014) και τιμηθεί με το σύνολο των λογοτεχνικών βραβείων στη Βουλγαρία, το μυθιστόρημα Περί φυσικής της μελαγχολίας κατατάσσει τον Georgi Gospodinov στους πιο εφευρετικούς και τολμηρούς συγγραφείς της Ευρώπης. Χρησιμοποιώντας τον μύθο του Μινώταυρου ως κεντρική εικόνα του, ο αφηγητής του βιβλίου (το alter ego του συγγραφέα) κατασκευάζει έναν λαβύρινθο ιστοριών για την οικογένειά του, μεταπηδά σε διαφορετικές εποχές και οπτικές, εξερευνώντας τη νοοτροπία και τα αδιέξοδα των Ανατολικοευρωπαίων. Ένα απίστευτα συγκινητικό αλλά και γεμάτο χιούμορ βιβλίο για τις ανθρώπινες ανησυχίες, την ενσυναίσθηση και την απώλειά της, που φωτίζει ζητήματα όπως η εγκατάλειψη και η απομόνωση. Η πρωτότυπη δομή και η εκπληκτική αφήγησή του γοήτευσαν τη διεθνή κριτική, που το χαρακτήρισε ως ένα από τα κορυφαία ευρωπαϊκά μεταμοντέρνα μυθιστορήματα.',
    'http://books.google.com/books/content?id=NVOZEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605722470',
    'Ο Δύτης',
    'Εκδόσεις Ίκαρος',
    172,
    'Όλοι φοράνε τις μάσκες τους, το φως υποχωρεί. Όλοι εκτός από έναν, που πάντα παραμένει αθέατος. Οι εντολές ακούγονται ξεκάθαρα, για λίγο στέκονται απολύτως ακίνητοι. Κάποιος θα νόμιζε ότι προσεύχονται. Κι όμως. Μια περιπλάνηση που αρχίζει από το νυχτερινό Αμβούργο για να καταλήξει στον βυθό της ελληνικής θάλασσας. Η αλυσίδα διαδοχικών αυτοκτονιών και ανεξήγητων θανάτων περιστρέφεται γύρω από μια ταινία διάρκειας λίγων λεπτών. Μέσα της ξαναζωντανεύει «Ο Δύτης». Ο ντετέκτιβ Κρις Πάπας θα αναγκαστεί να την παρακολουθήσει για να καταλάβει. Κάποιες φορές το ταξίδι στο παρελθόν δεν είναι τίποτα άλλο παρά μια βουτιά στον πυρήνα της φρίκης. Εκεί όπου η πραγματικότητα υπερβαίνει την ανθρώπινη φαντασία.',
    'http://books.google.com/books/content?id=4qqXEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605722579',
    'Θρυμματισμένη φρυγανιά',
    'Εκδόσεις Ίκαρος',
    424,
    '«... με διέλυσε με την ίδια ευκολία που λιώνει στο τσάι μια θρυμματισμένη φρυγανιά». Δυο παλιοί γνώριμοι, από τη δεκαετία του ’50, ο Τέλης Δημητρέλης, δημοφιλής Έλληνας ποιητής, και ο Αλέξανδρος Τεφλιώνης ή Alex Teff, μεγάλης φήμης μαθηματικός με καριέρα στις ΗΠΑ και συγγραφέας ενός αστυνομικού μυθιστορήματος με διεθνή επιτυχία, συναντιούνται μετά από πολλά χρόνια στη γενέθλια πόλη τους, τη Θεσσαλονίκη. Η συνάντηση αυτή πυροδοτεί καταλυτικές εξελίξεις, καθώς ο Δημητρέλης αναλαμβάνει ρόλο ντετέκτιβ και φέρνει στο φως μια υπόθεση που έχει τις ρίζες της στα χρόνια της Κατοχής: έναν περιβόητο θησαυρό που ο θρύλος λέει πως κλάπηκε από τους Ναζί και έχει θαφτεί κάπου στη Βόρειο Ελλάδα. Η πρώτη περιπέτεια του ποιητή Δημητρέλη υφαίνει τον καμβά ενός νουάρ μυθιστορήματος με αναρίθμητα θύματα, ανεξιχνίαστους φόνους, συμφέροντα οικογενειών και μυστικές υπηρεσίες υπερδυνάμεων, που αλληλεπιδρούν φέρνοντας στην επιφάνεια απόκρυφα γεγονότα και μυστικά.',
    'http://books.google.com/books/content?id=zKqXEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605723231',
    'Φυσικό μυθιστόρημα',
    'Εκδόσεις Ίκαρος',
    141,
    'Ο Georgi Gospodinov δημιουργεί τη δική του εκδοχή ενός «φυσικού μυθιστορήματος» προερχόμενου από τις στιγμές της καθημερινής ζωής. Με ιδιαίτερο χιούμορ, ο συγγραφέας και αφηγητής του βιβλίου εκφράζει την ανάγκη να αποδεχτεί τον διαλυμένο γάμο του και την απιστία της συζύγου του. Ο κεντρικός χαρακτήρας ίσως να υποφέρει από διαταραχή ελλειμματικής προσοχής· ίσως να είναι εγκλωβισμένος σε μια προκατειλημμένη, αν και στωική εκτίμηση της ακατάστατης ροής της ζωής. Όποια κι αν είναι η αιτία, ο μονόλογός του μετατρέπεται σ’ ένα πρωτότυπο, συναρπαστικό βιβλίο, που υπονοεί άψογα στον πυρήνα του το κενό και τη θλίψη. Με υπαινικτικές συνδέσεις με τη σύγχρονη γαλλική φιλοσοφία, ο Georgi Gospodinov μοιράζεται μαζί μας ένα μεταμοντέρνο μυθιστόρημα για τις προσωπικές σχέσεις και τις απρόσμενες συνέπειές τους.',
    'http://books.google.com/books/content?id=gimWEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605723316',
    'Αύριο θα μας λένε αλλιώς',
    'Εκδόσεις Ίκαρος',
    312,
    'Ζουν στη Μαδρίτη. Εκείνη είναι αρχιτέκτονας, φοβάται να κάνει μελλοντικά σχέδια και έχει επινοήσει την ύπαρξη ενός εραστή. Εκείνος γράφει δοκίμια, είναι πέντε χρόνια μαζί της και ποτέ δεν φαντάστηκε ότι μια μέρα θα ήταν και πάλι εργένης· βρίσκεται σε σύγχυση μπροστά στη νέα, ακατανόητη πραγματικότητα. Στην είδηση του χωρισμού τους έρχονται οι φίλοι και οι συμβουλές τους, τις περισσότερες φορές φέρνοντας περισσότερες αμφιβολίες παρά λύσεις. Είναι η γενιά του Tinder, άνθρωποι που εξαλείφουν ο ένας τον άλλο με μια απλή κίνηση και σχεδόν όλοι τους καταλήγουν εκτεθειμένοι και απογοητευμένοι τελικά. Ο χωρισμός ενός ζευγαριού αποκαλύπτει πολλά για τη χώρα, τη στιγμή, αλλά και την ίδια την ιδέα της συνύπαρξης. Και η ανάλυση της εποχής είναι σκληρή: γονείς που συνυπάρχουν από υποχρέωση, πειράματα προσωπικής ανάπτυξης που λειτουργούν σαν παραστάσεις χωρίς κοινό, τεχνολογία που διεισδύει στα πάντα, ακόμη και στην ιδιωτικότητα. Εκείνη κι Εκείνος, ήδη κοντά στα σαράντα, αρχίζουν να αποδέχονται τη νέα κατάσταση πραγμάτων χωρίς ρομαντικά δάκρυα, αλλά με μια μυστηριώδη νοσταλγία, που ενδεχομένως να τους επανασυνδέσει.',
    'http://books.google.com/books/content?id=UNHmDwAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605723699',
    'Από την αρχή',
    'Εκδόσεις Ίκαρος',
    220,
    'Όλα είναι αλήθεια ώσπου να τα γράψεις σε ένα βιβλίο και να πεις πως είναι ψέματα. Μνήμες από τα παιδικά σου χρόνια, ιστορίες που σου αφηγήθηκαν, βιβλία που διάβασες, μουσικές που άκουσες, ταινίες που είδες, στιγμές που μοιράστηκες, λόγια και πράξεις αγαπημένων ανθρώπων, σπαράγματα ονείρων… Κι αν κάποια αλήθεια-ψέμα σού φέρει τα πάνω κάτω, τότε είσαι έτοιμος να ξεκινήσεις τη ζωή σου από την αρχή. Ένα βιβλίο για τις δεύτερες ευκαιρίες και τις αποφάσεις που μας κάνουν να ξεκινήσουμε από την αρχή. Μια προσωπική αναζήτηση, που μας ταξιδεύει στην Ελλάδα από τη δεκαετία του 60 ως τις μέρες μας.',
    'http://books.google.com/books/content?id=y_SVEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    5.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605723736',
    'Κβάντι',
    'Εκδόσεις Ίκαρος',
    177,
    'Η δολοφονία ενός άντρα χωρίς ταυτότητα στους δρόμους της Μονμάρτης οδηγεί τις έρευνες της γαλλικής αστυνομίας σε αδιέξοδο. Την ίδια ώρα στο νεκροταφείο κάποιου ελληνικού χωριού ο ντετέκτιβ Κρις Πάπας κρατάει στα χέρια του έναν παλιό χάρτη γεμάτο σημάδια: αλλεπάλληλα ταξίδια, τεθλασμένες γραμμές, παράλληλες πορείες, που οδηγούν στην άκρη της ερήμου Καλαχάρι. Τα τελευταία ίχνη τον παρασύρουν πάνω στις παρισινές στέγες. Εκεί θα καταλάβει ότι οι τίγρεις τρέχουν γρήγορα και δεν ξεχνούν ποτέ. Πρωτοπήγα στην Αφρική το 2003 και επέστρεψα δύο ακόμη φορές. Η Μαύρη Ήπειρος είναι ένας άλλος κόσμος. Στην αρχή νόμιζα πως κρατούσα κάποιου είδους ημερολόγιο, τελικά όμως ήταν το προσχέδιο ενός βιβλίου. Δεν πρόκειται για ταξιδιωτικό χρονικό, αλλά για μια ιστορία αίματος. Τόσο πραγματική όσο και ο κάθε καθρέφτης. Το αίμα ακολουθεί περίεργες διαδρομές, που κανείς δεν μπορεί να προβλέψει. Και ίσως να είναι καλύτερα έτσι. Μ.Ε.',
    'http://books.google.com/books/content?id=ZOqVEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605723897',
    'Χιλιανός ποιητής',
    'Εκδόσεις Ίκαρος',
    352,
    'Ο Γκονσάλο είναι ένας «κακός ποιητής» που ονειρεύεται μια μέρα να γίνει αληθινός ποιητής, αλλά κι ένας πατριός που συμπεριφέρεται σαν να είναι ο βιολογικός πατέρας του Βισέντε, ενός αγοριού εθισμένου στις γατοτροφές. Χρόνια αργότερα, ο Βισέντε αρνείται να σπουδάσει στο πανεπιστήμιο γιατί το όνειρό του είναι να γίνει κι αυτός ποιητής, παρά τις συμβουλές της Κάρλας, της περήφανης και μοναχικής του μητέρας, και του Λεόν, ενός μέτριου πατέρα που έχει αφοσιωθεί στη συλλογή του από μινιατούρες αυτοκινήτων. Ο ισχυρός μύθος της χιλιανής ποίησης (όπως σημειώνει ένας χαρακτήρας του βιβλίου, «οι Χιλιανοί, σύμφωνα με την Σουηδική Ακαδημία, είναι δις παγκόσμιοι πρωταθλητές της ποίησης») τίθεται υπό αμφισβήτηση από την Πρου, μιαν αμερικανίδα δημοσιογράφο που εμπλέκεται τυχαία σε μια πολυπληθή και σπαρταριστή κοινότητα λογοτεχνικών ηρώων και καμποτίνων. Ο Χιλιανός ποιητής πραγματεύεται τα πάνω και τα κάτω του έρωτα και της οικογένειας (επίμονο μοτίβο στις μυθοπλασίες του Zambra), την πάντα παρούσα δυσπιστία στους θεσμούς και την εξουσία, την εμπειρία της συγγραφής και της ανάγνωσης σ’ έναν κόσμο εχθρικό που μοιάζει να καταρρέει.',
    'http://books.google.com/books/content?id=Et2VEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    3.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605724382',
    'Γυρίζοντας το βλέμμα πίσω',
    'Εκδόσεις Ίκαρος',
    391,
    '«…σκέφτηκε πως οι αναμνήσεις είναι αόρατες όπως το φως, κι έτσι όπως ο καπνός έκανε το φως να φαίνεται, θα ’πρεπε να υπάρχει κάποιος τρόπος να γίνονται ορατές και οι αναμνήσεις». Τον Οκτώβριο του 2016, ο κολομβιανός σκηνοθέτης Σέρχιο Καμπρέρα, που παρευρίσκεται σ’ ένα αναδρομικό αφιέρωμα των ταινιών του στη Βαρκελώνη, αντιμετωπίζει μια δύσκολη προσωπική στιγμή: ο πατέρας του μόλις πέθανε, ο γάμος του περνάει κρίση, ο λαός της Κολομβίας απέρριψε τις ειρηνευτικές συμφωνίες που θ’ άνοιγαν το δρόμο για τη λήξη ενός πενηντάχρονου αιματηρού εμφυλίου, κι όλα αυτά τον ωθούν να ξανακάνει νοερά τη διαδρομή τριών γενεών της οικογένειάς του. Από τον Ισπανικό Εμφύλιο ώς την αυτοεξορία του παππού του στη Λατινική Αμερική, και από την Πολιτιστική Επανάσταση της Κίνας ώς τα ένοπλα αντάρτικα κινήματα της δεκαετίας του 1970, ο αναγνώστης θ’ ανακαλύψει μια περιπετειώδη ζωή μισού αιώνα. Το Γυρίζοντας το βλέμμα πίσω είναι ένα συναρπαστικό αφήγημα και, ταυτόχρονα, μια εμβριθής πολιτικοκοινωνική μελέτη. Στα χέρια ενός αριστοτέχνη μυθιστοριογράφου όπως ο Vásquez, η απλή εξιστόρηση αληθινών γεγονότων μετατρέπεται στο σκοτεινό πορτρέτο μιας οικογένειας στη δίνη της Iστορίας.',
    'http://books.google.com/books/content?id=XbiVEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605724948',
    'Οι ναυαγοί του Αυγούστου',
    'Εκδόσεις Ίκαρος',
    314,
    'Αθήνα. Τατόι. Πάρος. Αστυπάλαια. Αύγουστος 2021. «Ξέρω ποιος σκότωσε τον Ταχτσή», ψιθυρίζει ο παλαιοβιβλιοπώλης, ενώ ένας καθηγητής του Ποινικού Δικαίου, υποψήφιος για την Ακαδημία Αθηνών, βρίσκεται νεκρός στη μονοκατοικία του στο Ψυχικό, δίπλα σε γυναικεία ρούχα, σε έναν τόπο εγκλήματος που μοιάζει με θεατρικό σκηνικό. Ο αστυνόμος Χάρης Κόκκινος επιστρέφει εσπευσμένα από τις διακοπές του στην Πάρο σε μια φλεγόμενη πόλη, για να βρεθεί αντιμέτωπος με μια περίπλοκη υπόθεση, που ξεδιπλώνεται σαν μια μεγάλη παρτίδα σκάκι. Θα χρειαστεί να φωτιστεί το παρελθόν, η μυστική ζωή θυτών και θυμάτων, αλλά και του ίδιου του αστυνόμου, προκειμένου να ξετυλιχτεί το κουβάρι αυτής της υπόθεσης, που τον φέρνει αντιμέτωπο με τον μικρόκοσμο του πανεπιστημίου, με κυκλώματα παράνομων υιοθεσιών, σχέσεις εξουσίας, πάθους και εκδίκησης, στόματα που παραμένουν ερμητικά κλειστά, όταν χρειάζεται να προστατεύσουν το δικό τους μυστικό, και σκιές που κυκλοφορούν στο υπόγειο δίκτυο των αγωγών της Αθήνας. Οι ναυαγοί του Αυγούστου, το τρίτο μέρος της «Τριλογίας του βυθού», ισορροπεί στο λεπτό όριο όπου ένα πραγματικό και ανεξιχνίαστο έγκλημα, η δολοφονία του συγγραφέα Κώστα Ταχτσή, και ένα χαμένο χειρόγραφο τρυπώνουν στη μυθοπλασία, πυροδοτώντας μια ιστορία για όσους παλεύουν με τη φωτιά.',
    'http://books.google.com/books/content?id=iv6SEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'ENG',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789605725556',
    'Η πρόποση',
    'Εκδόσεις Ίκαρος',
    117,
    '«Ξέρεις, η αδελφή σου θα χαιρόταν πολύ αν έκανες μια πρόποση τη μέρα της τελετής». Είναι η αρχή ενός οικογενειακού δείπνου κατά τη διάρκεια του οποίου ο Αντριάν, σαραντάρης σε κατάθλιψη, περιμένει απελπισμένα μια απάντηση στο μήνυμα που μόλις έστειλε στην πρώην του. Ανάμεσα στις πατάτες ογκρατέν και τα προσχέδια της πρόποσης, όλα το ένα πιο παράλογο απ’ το άλλο, διαγράφεται μια συγκινητική και απογοητευμένη συναισθηματική διαδρομή, εφάμιλλη των καλύτερων ρομαντικών κομεντί. Μια επιμελώς δομημένη αφήγηση που θα προκαλέσει αβίαστο γέλιο σε κάθε αναγνώστη.',
    'http://books.google.com/books/content?id=y9WtEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789609527002',
    'Δυο νουβέλες',
    'Εκδόσεις Ίκαρος',
    166,
    'Η πρώτη νουβέλα, που περιλαμβάνεται στο βιβλίο, είναι η Οικογενειακή υπόθεση. Προδημοσιεύτηκε στο περιοδικό LanouvelleRevue το 1881 και πρωτοεμφανίστηκε στα ελληνικά τη δεκαετία του ‘20 με τον τίτλο «Οικογενειακά» στη συλλογή διηγημάτων του Γκυ ντε Μωπασαν Εκλεκτά διηγήματα, χωρίς ένδειξη του μεταφραστή. Είναι από τις σημαντικότερες νουβέλες του Γκυ ντε Μωπασάν. Η Κληρονομιά, η δεύτερη νουβέλα του βιβλίου, πρωτοδημοσιεύτηκε το 1884 σε εβδομαδιαίες συνέχειες στη LavieMilitaire και περιλήφθηκε στη συλλογή Η μις Χάρριετ (1884). Στα ελληνικά δημοσιεύτηκε στην Εφημερίδα του Κορομηλά το 1889 χωρίς ένδειξη του μεταφραστή αλλά οι Ν.Δ. Τριανταφυλλόπουλος και Λ. Τριανταφυλλοπούλου αποδίδουν τη μετάφραση στον Αλέξανδρο Παπαδιαμάντη. Με την Κληρονομιά ο Μωπασάν συνθέτει μία από τις αριστουργηματικότερες νουβέλες του, όπου δείχνει όλη την αφηγηματική δεξιοτεχνία του και την εκ μέρους του αριστοτεχνική περιγραφή διαφόρων χαρακτήρων. Ο μεταφραστής Φοίβος Ι. Πιομπίνος συμπληρώνει την έκδοση με σημειώσεις, χρονολόγιο και βιβλιογραφία.',
    'http://books.google.com/books/content?id=WmBuBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'FRA',
    1.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789609527101',
    'Μη σκάψετε παρακαλώ εδώ είναι θαμμένος ένας σκύλος',
    'Εκδόσεις Ίκαρος',
    34,
    'Πρόκειται για τη δεύτερη ποιητική συλλογή του Γιώργου Κ. Ψάλτη. Η πρώτη, με τον τίτλο «Επιστροφή στην ενιαία χώρα», Ίκαρος 2008, περιλήφθηκε στην βραχεία λίστα για το βραβείο πρωτοεμφανιζόμενου συγγραφέα 2009, του περιοδικού Διαβάζω. Ποιήματά του έχουν δημοσιευτεί στο περιοδικό Λέξη. Από το βιβλίο: ΣΤΟ ΔΩΜΑΤΙΟ ΜΟΥ μικρό παιδί συνέβαινα σ’ ένα δωμάτιο χωρίς λέξεις και μια φορά ζωγράφισα κόκκινο τον ουρανό και γαλανό τονήλιο κιέβαλα τον κόσμο αυτόν σε στρογγυλή κορνίζα και ονειρεύτηκα έναν αετό που κυνηγούσε φίδια κιείχε παντού σιτάρι και μόνο μια στιλπνή ντομάτα και ξύπνησα στον ορίζοντα κιείδα τον ήλιο κόκκινο ψεύτη κιείπα στο μικρό παιδί «τώρα πάει να κοιμηθεί» και με ρώτησε για τη Σελήνη και τούπα «είναι όμορφη θεά εδώ και γέρος κουρασμένος σε άλλα μέρη» και τούδειξα την Πούλια καθώς την προσπερνούσε τρομαγμένη κι έψαχνε στην πίσω θάλασσα τον Αυγερινό και μούπε «δεν καταλαβαίνω» και τούπα «τότε δεν έχει ποτέ συμβεί»',
    'http://books.google.com/books/content?id=II2aEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'MSA',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789609527200',
    'Εκτός σχεδίου',
    'Εκδόσεις Ίκαρος',
    120,
    'Σε μορφή σχολίου, χρονογραφήματος ή μικρού διηγήματος τα κείμενα αυτά έχουν αυτοβιογραφικό, εξομολογητικό ή άλλοτε ηθογραφικό περιεχόμενο καθρεφτίζοντας την εποχή που γράφτηκαν αλλά και έναν ολόκληρο κόσμο, βιώματα, σκέψεις και συναισθήματα, που γνωρίσαμε στην ποίηση της Κικής Δημουλά. Τα κείμενα αυτά είναι επιλογή από τα «Κυκλογραφήματα» που γράφτηκαν την περίοδο 1959- 1967 και δημοσιεύτηκαν στο περιοδικό «Κύκλος» της Τράπεζας της Ελλάδος, στην οποία εργαζόταν η Κική Δημουλά. Στον πρόλογο της έκδοσης η ποιήτρια αιτιολογεί απολαυστικά την απόφαση για αυτήν την «εκτός σχεδίου» έκδοση.',
    'http://books.google.com/books/content?id=MI2aEAAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    2.25
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789609527637',
    'Η πιο κρυφή πληγή',
    'Εκδόσεις Ίκαρος',
    464,
    'Μια σύγχρονη ερωτική ιστορία, με φόντο τα Δεκεμβριανά του ’44. Ένας ισόβιος έρωτας στην εποχή των στιγμιαίων ερώτων και ο εφιάλτης του εμφυλίου στα χρόνια της κρίσης.',
    'http://books.google.com/books/content?id=sGRuBgAAQBAJ&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GUI',
    0.00
  );
INSERT INTO
  `book` (
    `ISBN`,
    `Title`,
    `Publisher`,
    `PageNumber`,
    `Summary`,
    `Picture`,
    `Language`,
    `Rating`
  )
VALUES
  (
    '9789939004938',
    'Հեքիաթներ',
    'Yavruhrat Publishing',
    260,
    'Գրքում զետեղված են հայ մեծագույն գրող ու բանաստեղծ Հովհաննես Թումանյանի քառասունից ավելի հեքիաթներ, որոնց մի մասը հայկական ժողովրդական հեքիաթների մշակումներ են («Տերն ու ծառան», «Ոսկու կարասը», «Ձախորդ Փանոսը», «Անբան Հուռին», «Քաջ Նազարը» եւ այլն), մյուսները փոխադրություն են այլ ժողովուրդների հեքիաթներից («Անգին քարը», «Կարմիր Ծաղիկը», «Աներեւույթ թագավորությունը», «Ճերմակ օձը» եւ այլն):',
    'http://books.google.com/books/content?id=OeiW9sRWlUYC&printsec=frontcover&img=1&zoom=1&edge=curl&source=gbs_api',
    'GRE',
    4.67
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book_categories
# ------------------------------------------------------------

INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9789605721213'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9789601666587');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789609527002');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9789601651736');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9789601651736');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9786180400373');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180400373');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9789601645230'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9789601645230');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπλανήσεις (Journeys)', '9786180329001');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9789601667744');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9789601667744');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789601648392');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9789600358834'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9786180324082');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9786180313826');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κοινωνιολογία (Sociology)', '9789601646572');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789601646572');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9781912322015');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9781912322015');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9781912322015');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9788873042204');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9788873042204');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9788873042204');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9786180319774');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180324440');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9786180324440');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9789601645858');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9781909550018');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κωμωδία (Comedy)', '9789601698359');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9789605720285');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9789600359831');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9789600360677');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789600360677');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9786180322644');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9781909550032');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπλανήσεις (Journeys)', '9781909550032');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9781909550032'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9781908362391');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9781908362391');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9789605721466');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789605721466');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9789605721466');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9786180322675'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9789600363524');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9786180317640');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9786180317640'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9786180317640');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9789600367638'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9789600367638');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9786180336108');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9786180336108');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9781310259654'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9786180333190');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9786180333190'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9786180324112');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9786180324112');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9786180317602');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601647623');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9789601647623');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9786180317879');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αρχιτεκτονική (Architecture)', '9781547523986');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9789601667751');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9786180319934');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9789605724924'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789609412797');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9781909550544');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9781547524365');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9789601659541');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9785041658434');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9788873047476');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789600358896');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9789601645322');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601647883');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9781987904215');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9781987904215');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κοινωνιολογία (Sociology)', '9789605723316');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9786180317695');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9789600354713');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9781909550650');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9789600360226'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789605721336');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9789605721336');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9789600367782'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9789600367782');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789600367782');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9789600357288');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9786180322293');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9786180322293');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9786180322293'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9789601647371');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601647371');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9786180327090');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9786180327090');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9786180327090');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9786180324143');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9786180320138');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9786180328226');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9786180328226');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9786180332421'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9786180320114');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9789600367843');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9789600367843');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789601660073');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601660073');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9786180322897'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789601686370');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9789601686370'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9786180327717');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9789600360455');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9786180320107');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9788873047681');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9788873047681');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9788873047681');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9789600367867');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9789600367867'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9789600368352');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9789600368352');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9789605722012'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9789601657844');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9789601657844');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9781912322886'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9786180329094');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Φαντασία (Science Fiction)',
    '9786180329094'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9789606796616'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9789606796616');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9789606796616');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9786180322798'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Φανταστική Νεανική Λογοτεχνία (Young Adult Fantasy)',
    '9786180328394'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9786180328394'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9786180328134'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789605721794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9781667429625'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789600363661');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9789600363661'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9786180324853');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κωμωδία (Comedy)', '9786180320794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9786180320794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9786180320794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9786180314694');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9789601673196');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9781912322640');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9781912322640');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9781912322640'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9789605722647');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9789605722647');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9789605722579');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9786180325539');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9786180317701'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9786180317701');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9789605722241');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9786180328257');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9781909550360');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9786180330793');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9786180330793'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9789601647500');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9789601647500');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9789601647500');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9789605724948');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9789605724948'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9789605724948');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9786180313819');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9786180313819'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9786180313819'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789939004938');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9789939004938');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9789939004938');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9786180321005');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9789605724139');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9789601668062');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9789601668062');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9786180320787');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9786180320787'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9786180329667');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Φανταστική Νεανική Λογοτεχνία (Young Adult Fantasy)',
    '9786180337389'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αρχιτεκτονική (Architecture)', '9786180337389');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9786180337389');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9789605723699'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9789605723699');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κοινωνιολογία (Sociology)', '9786180326376');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9786180323887');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9786180323887');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180326970');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9789601685427');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9789601645032');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789601645032');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαγειρική (Cooking)', '9786180326550');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9786180326550');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180326550');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9789600361223'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9789600361223'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789605666477');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9786180327007'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9786180327007');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9781547532742');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789600361087');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9789600361087');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9789600361087');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9781071526767');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789600368338');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9789600368338'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κωμωδία (Comedy)', '9781071532997');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9781071532997'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9789601656052');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9789601656052'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9789601656052'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9786180325560'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9786180320091'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789609527750');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9789609527750');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9781909550780');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9789605721138');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789601651750');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789601651750');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9786180702408'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9786180702408');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9786180322682');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9789601647470');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789601647470');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9789601647470');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9781547574667');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9781547574667');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Φαντασία (Science Fiction)',
    '9789600322439'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9789601645704');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9789601645704'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9789601645704');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9786180321012'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9786180328981'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9786180328981');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Φανταστική Νεανική Λογοτεχνία (Young Adult Fantasy)',
    '9786180328981'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9781667411767');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9786180329292');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9786180329292'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9786180329292');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789600367645');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9786180314687');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9789600364187');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9789605723897'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180317589');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9786180317589'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9789464447675');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9789464447675');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9789464447675');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789600358100');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9786180322651'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9786180322651');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9786180322651');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9786180317794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9786180317794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαγειρική (Cooking)', '9786180317794');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789600353990');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9789600353990'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9781667407227');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9786180322309'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9786180322309');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9789605721695');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9789605721695');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9781912322046');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Βιογραφίες (Biographies)', '9781912322046');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αρχιτεκτονική (Architecture)', '9781912322046');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολεμική Λογοτεχνία (War Literature)',
    '9789604007837'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαγειρική (Cooking)', '9781547510740');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9786180319750');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9781910714324'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9789601651606');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9789601651606'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9789601651606'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9789609527637');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9789609527637'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9789609527637');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9789609527200');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789609527200');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9786180322668'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιβάλλον (Environment)', '9786180322668');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9781667405148');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9781667405148'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9781667405148'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9789601657660');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9789601657660');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601657660');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9781911352709'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9781911352709');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9781911352709');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9789601655581'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9789601655581');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9789600354072'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9789600354072');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9789600354072');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9789605720575');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαγειρική (Cooking)', '9789605720575');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9786180329049');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9786180329049');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9789605723736'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9789600367690');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789600367690');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9789601699837'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Μαγικό Ρεαλισμό (Magical Realism)',
    '9781005226350'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9786180329278');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπλανήσεις (Journeys)', '9786180329278');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180329278');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9786180317831');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9786180317831');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Φαντασία (Science Fiction)',
    '9786180317831'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Φανταστική Νεανική Λογοτεχνία (Young Adult Fantasy)',
    '9789600360639'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Δικαίωμα (Law)', '9786180315110');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9786180315110'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9786180320800');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9786180320800'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9789600361407'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9786180322323');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9786180322323'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9786180313321');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Περιπέτεια (Adventure)', '9781329008045');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Φαντασία (Science Fiction)',
    '9781329008045'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9789608869530');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9789608869530');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ταξίδια (Travel)', '9789601645209');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαγειρική (Cooking)', '9789601645209');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9789601655666');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Επιστημονικά (Science)', '9789601655666');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9789601655666');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9786180328356');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9786180328356'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180329087');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9789605721664');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθολογία (Mythology)', '9789605721664');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Πολιτική (Politics)', '9786180326956');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9786180326956'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Οικονομία (Economics)', '9789600368345');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9786180319125');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9781632913234'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Διηγήματα (Short Stories)', '9786180332438');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9786180332438');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9789605722470');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9789605725556');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9789605725556');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ποίηση (Poetry)', '9789605725556');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρίλερ (Thriller)', '9786180322385');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9781987904185'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9789601647838');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9789601647838');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9789601647838'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9786180400557'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Εκπαίδευση (Education)', '9786180313925');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9786180313925');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9786180324129');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9781547535682');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9789601639406');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Παιδικά βιβλία (Childrens Books)',
    '9789605665951'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τραγωδία (Tragedy)', '9781912322961');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κωμωδία (Comedy)', '9781912322961');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9789605724382'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αστυνομική Λογοτεχνία (Crime Fiction)',
    '9781071599594'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθολογία (Mythology)', '9781071599594');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9789609527101');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θρησκεία (Religion)', '9789609527101');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ρομαντικό (Romance)', '9781667432564');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9781667432564'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φιλοσοφία (Philosophy)', '9789605722876');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9789605722876');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Γλωσσολογία (Linguistics)', '9786180317770');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστήμη της Υγείας (Health Science)',
    '9786180320329'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9786180320329'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9781071523902'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μαθηματικά (Mathematics)', '9781071523902');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9781071523902');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τέχνη (Art)', '9786180329766');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9786180329766');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αρχιτεκτονική (Architecture)', '9786180329766');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Τεχνολογία (Technology)', '9789601681986');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9789601681986');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Ιστορικό Μυθιστόρημα (Historical Novel)',
    '9789601681986'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Θέατρο (Theater)', '9786180322316');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9785043340351'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Φαντασία (Fantasy)', '9781387567997');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9789605723231'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυθιστόρημα (Novel)', '9786180319767');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κοινωνιολογία (Sociology)', '9786180319767');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9786180322330'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αυτοβιογραφία (Autobiography)', '9781071526521');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9781071526521');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μουσική (Music)', '9781071526521');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9783966103473'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9785041512521'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9781507198025');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Επιστημονική Διαφήμιση (Science Non-Fiction)',
    '9781507198025'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ιστορία (History)', '9785043797230');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Κλασική Λογοτεχνία (Classic Literature)',
    '9781071510032'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Κοινωνιολογία (Sociology)', '9786180322736');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Παραμύθια (Fairy Tales)', '9781465549976');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Θρησκευτική Λογοτεχνία (Religious Literature)',
    '9781465549976'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Αυτοβελτίωση (Self-Improvement)',
    '9786180324075'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  (
    'Πολιτισμολογία (Cultural Studies)',
    '9786180324075'
  );
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Μυστήριο (Mystery)', '9786180317848');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Αθλητισμός (Sports)', '9781909550513');
INSERT INTO
  `book_categories` (`Category`, `ISBN`)
VALUES
  ('Ψυχολογία (Psychology)', '9786180320121');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book_keywords
# ------------------------------------------------------------

INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789605721213');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9789605721213');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9789605721213');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9789601666587');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9789601666587');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789609527002');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9789609527002');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9789609527002');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789601651736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9786180400373');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9786180400373');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνία', '9786180400373');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9789601645230');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τυριά', '9786180329001');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αυτοκράτορες', '9789601667744');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9789601667744');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνα παιχνίδια', '9789601648392');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9789601648392');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9789600358834');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9789600358834');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9789600358834');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('σχολείο', '9786180324082');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλίες', '9786180324082');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9786180313826');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9786180313826');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789601646572');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789601646572');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9789601646572');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9781912322015');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9788873042204');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9786180319774');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9786180319774');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9786180324440');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9786180324440');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9789601645858');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789601645858');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ελλάδα', '9781909550018');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9789601698359');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789601698359');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789605720285');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9789605720285');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αποκαλύψεις', '9789600359831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δράκοι', '9789600359831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αυτοκράτορες', '9789600359831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9789600360677');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789600360677');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('βυζάντιο', '9789600360677');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9786180322644');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές σχέσεις', '9786180322644');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('σχολείο', '9786180322644');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9781909550032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9781909550032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9781909550032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781908362391');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9789605721466');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9789605721466');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9789605721466');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές σχέσεις', '9786180322675');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9786180322675');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Περιηγήσεις', '9789600363524');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνία', '9789600363524');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9789600363524');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9786180317640');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9789600367638');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9786180336108');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9786180336108');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9781310259654');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('θρύλοι', '9781310259654');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9781310259654');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9786180333190');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτική', '9786180333190');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9786180333190');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9786180324112');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180324112');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9786180317602');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9789601647623');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9789601647623');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9789601647623');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9786180317879');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνιολογία', '9786180317879');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9786180317879');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τυριά', '9781547523986');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9781547523986');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9789601667751');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9786180319934');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δράκοι', '9786180319934');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9786180319934');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9789605724924');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνα παιχνίδια', '9789605724924');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9789609412797');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές σχέσεις', '9789609412797');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9789609412797');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9781909550544');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9781909550544');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9781909550544');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9781547524365');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9781547524365');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9789601659541');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789601659541');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9789601659541');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9785041658434');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9788873047476');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9788873047476');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9789600358896');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9789600358896');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789601645322');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9789601645322');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9789601647883');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789601647883');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9789601647883');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('λογική', '9781987904215');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δράκοι', '9789605723316');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9789605723316');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9786180317695');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9786180317695');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9789600354713');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλοσοφία', '9789600354713');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9789600354713');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9781909550650');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9781909550650');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9781909550650');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789600360226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789600360226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('θρύλοι', '9789600360226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789605721336');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9789605721336');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9789605721336');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ερωτες', '9789600367782');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9789600367782');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789600357288');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9786180322293');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9786180322293');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('θρύλοι', '9786180322293');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9789601647371');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9789601647371');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9786180327090');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9786180327090');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9786180327090');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αποκαλύψεις', '9786180324143');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9786180324143');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9786180324143');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9786180320138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9786180320138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9786180320138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9786180328226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αναζήτηση του θρύλου', '9786180328226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αυτοκράτορες', '9786180328226');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9786180332421');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9786180332421');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9786180320114');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9786180320114');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9786180320114');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνιολογία', '9789600367843');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9789600367843');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9789600367843');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9789601660073');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Περιηγήσεις', '9786180322897');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτική', '9789601686370');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9786180327717');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180327717');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('σχολείο', '9786180327717');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('βυζάντιο', '9789600360455');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνιολογία', '9786180320107');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9786180320107');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9786180320107');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9788873047681');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9788873047681');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9788873047681');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9789600367867');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9789600367867');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9789600368352');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9789600368352');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789600368352');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9789605722012');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9789605722012');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789605722012');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789601657844');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9789601657844');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9781912322886');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9781912322886');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9781912322886');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9786180329094');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυστήρια', '9786180329094');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9786180329094');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9789606796616');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789606796616');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9786180322798');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9786180322798');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9786180322798');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9786180328394');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9786180328394');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9786180328134');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9786180328134');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9789605721794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9789605721794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789605721794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('λογική', '9781667429625');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9781667429625');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9781667429625');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789600363661');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9789600363661');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9786180324853');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9786180324853');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αισθητική', '9786180324853');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνία', '9786180320794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ελλάδα', '9786180320794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9786180314694');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9786180314694');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9789601673196');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9789601673196');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9781912322640');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9781912322640');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9781912322640');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9789605722647');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9789605722647');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9789605722647');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9789605722579');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789605722579');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9786180325539');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9786180325539');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9786180325539');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180317701');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αναζήτηση του θρύλου', '9786180317701');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9786180317701');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ερωτες', '9789605722241');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9789605722241');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διακοπές', '9786180328257');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9781909550360');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλίες', '9781909550360');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9781909550360');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9786180330793');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789601647500');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9789601647500');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ερωτες', '9789605724948');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυστήρια', '9789605724948');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9789605724948');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ηθική', '9786180313819');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9786180313819');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9786180313819');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9789939004938');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9789939004938');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789939004938');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9786180321005');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9789605724139');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9789605724139');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789601668062');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9789601668062');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9789601668062');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Περιηγήσεις', '9786180320787');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9786180320787');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ελλάδα', '9786180329667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9786180329667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ερωτες', '9786180329667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9786180337389');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180337389');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9786180337389');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9789605723699');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9789605723699');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τυριά', '9789605723699');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180326376');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9786180326376');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9786180326376');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γλυκά', '9786180323887');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9786180323887');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9786180326970');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9786180326970');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9786180326970');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνα παιχνίδια', '9789601685427');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9789601645032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9789601645032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9786180326550');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9786180326550');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9789600361223');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9789600361223');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789605666477');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ηθική', '9789605666477');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αυτοκράτορες', '9789605666477');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9786180327007');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180327007');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9781547532742');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9781547532742');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('λογική', '9789600361087');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλοσοφία', '9781071526767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9781071526767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781071526767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9789600368338');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9789600368338');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9789600368338');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9781071532997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνα παιχνίδια', '9781071532997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9781071532997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9789601656052');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9786180325560');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('θρύλοι', '9786180325560');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τυριά', '9786180320091');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ηθική', '9789609527750');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9781909550780');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9781909550780');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789605721138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9789605721138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ηθική', '9789605721138');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789601651750');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9789601651750');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9786180702408');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9786180322682');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστημονική φιλοσοφία', '9786180322682');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9789601647470');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9789601647470');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9781547574667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9781547574667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9781547574667');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9789600322439');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9789600322439');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9789601645704');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9789601645704');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνα παιχνίδια', '9789601645704');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9786180321012');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλοσοφία', '9786180321012');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9786180328981');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9786180328981');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστημονική φιλοσοφία', '9786180328981');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνιολογία', '9781667411767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9781667411767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9781667411767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9786180329292');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9786180329292');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9786180329292');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9789600367645');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9789600367645');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9789600367645');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9786180314687');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9786180314687');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9786180314687');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9789600364187');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789605723897');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9786180317589');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9786180317589');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτική', '9786180317589');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διακοπές', '9789464447675');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9789464447675');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9789600358100');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνία', '9786180322651');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κρεατικά', '9786180317794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9786180317794');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9789600353990');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9789600353990');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9789600353990');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9781667407227');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('θρύλοι', '9781667407227');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αναζήτηση του θρύλου', '9781667407227');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9786180322309');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9786180322309');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9786180322309');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9789605721695');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789605721695');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9789605721695');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781912322046');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αισθητική', '9781912322046');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9781912322046');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789604007837');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9789604007837');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9781547510740');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9781547510740');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλίες', '9786180319750');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9781910714324');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9781910714324');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9781910714324');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789601651606');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9789601651606');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9789609527637');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αισθητική', '9789609527637');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9789609527200');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9789609527200');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυθιστόρημα', '9786180322668');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνία', '9786180322668');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9781667405148');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαίοι', '9781667405148');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9781667405148');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9789601657660');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9789601657660');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9781911352709');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9781911352709');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9781911352709');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789601655581');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9789601655581');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789601655581');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παιχνίδια', '9789600354072');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9789600354072');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('βυζάντιο', '9789600354072');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτισμός', '9789605720575');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9789605720575');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9786180329049');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυστήρια', '9786180329049');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9786180329049');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789605723736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάγισσες', '9789605723736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9789600367690');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλίες', '9789600367690');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυστήρια', '9789600367690');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9789601699837');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9781005226350');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διανομή', '9781005226350');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9786180329278');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9786180329278');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ελλάδα', '9786180329278');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9786180317831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180317831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές σχέσεις', '9786180317831');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9789600360639');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9789600360639');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9789600360639');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9786180315110');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρικές τεχνικές', '9786180315110');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9786180320800');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180320800');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ηθική', '9786180320800');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('περιπέτεια', '9789600361407');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789600361407');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9789600361407');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180322323');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9786180313321');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9786180313321');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διακοπές', '9781329008045');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9781329008045');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνιολογία', '9781329008045');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτική', '9789608869530');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9789608869530');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9789601645209');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9789601645209');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αναζήτηση του θρύλου', '9789601645209');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9789601655666');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9789601655666');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9789601655666');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9786180328356');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9786180329087');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9789605721664');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9789605721664');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9789605721664');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Μνημεία', '9786180326956');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9786180326956');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αποκαλύψεις', '9786180326956');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9789600368345');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9789600368345');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('οντολογία', '9789600368345');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλοσοφία', '9786180319125');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180319125');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9781632913234');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9781632913234');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('συμμορίες', '9781632913234');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9786180332438');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9789605722470');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ζωάκια', '9789605722470');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αισθητική', '9789605725556');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('βυζάντιο', '9786180322385');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολυπολιτισμικότητα', '9781987904185');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9781987904185');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστημονική φιλοσοφία', '9781987904185');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φαντασία', '9789601647838');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789601647838');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789601647838');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('ιστορία', '9786180400557');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9786180313925');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστημονική φιλοσοφία', '9786180313925');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Περιηγήσεις', '9786180313925');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9786180324129');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180324129');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρχαία ρώμη', '9781547535682');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανακαλύψεις', '9781547535682');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πίτσες', '9781547535682');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789601639406');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9789601639406');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μεταφυσική', '9789605665951');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολέμοι', '9789605665951');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9789605665951');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αναζήτηση του θρύλου', '9781912322961');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9781912322961');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781912322961');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επανάσταση', '9789605724382');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9789605724382');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9789605724382');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9781071599594');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9781071599594');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθι', '9789609527101');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αυτοκράτορες', '9789609527101');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781667432564');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9781667432564');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9781667432564');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9789605722876');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9789605722876');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κριτική', '9789605722876');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αποκαλύψεις', '9786180317770');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γευστικά πιάτα', '9786180317770');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9786180320329');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9786180320329');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('παραμύθια', '9786180320329');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9781071523902');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ανθρωπιστικές επιστήμες', '9781071523902');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('λογική', '9786180329766');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9786180329766');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διακοπές', '9789601681986');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φιλοσοφία', '9789601681986');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνική ανισότητα', '9789601681986');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μυστήρια', '9786180322316');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9786180322316');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9785043340351');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9785043340351');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9781387567997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9781387567997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9781387567997');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('αρετές', '9789605723231');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Διακοπές', '9786180319767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστήμη', '9786180319767');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κέικ', '9786180322330');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('σχολείο', '9786180322330');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('τέρατα', '9786180322330');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μάχες', '9781071526521');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('κουζίνες του κόσμου', '9781071526521');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φανταστικοί κόσμοι', '9783966103473');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9785041512521');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9785041512521');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('νεράιδες', '9785041512521');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('εφηβικά', '9781507198025');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('γλυκά', '9781507198025');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγεία', '9781507198025');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επιστημονική φιλοσοφία', '9785043797230');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγειρική', '9785043797230');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781071510032');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικές περιπέτειες', '9786180322736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('δυνατά κορίτσια', '9786180322736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('χορτοφαγικά', '9786180322736');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Φύση', '9781465549976');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Πολιτισμός', '9781465549976');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('πολιτική φιλοσοφία', '9781465549976');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ιστορία', '9786180324075');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Ταξίδια', '9786180324075');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('φίλοι', '9786180324075');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('επικίνδυνες αποστολές', '9786180317848');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Τοπία', '9786180317848');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('μαγικά πλάσματα', '9781909550513');
INSERT INTO
  `book_keywords` (`Keyword`, `ISBN`)
VALUES
  ('Κοινωνικές αλλαγές', '9786180320121');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book_writers
# ------------------------------------------------------------

INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lone Theils\']', '9789605721213');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σπυρίδων Ζαμπέλιος\']', '9789601666587');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789601666587');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Karl Ove Knausgård\']', '9789609527002');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Yrsa Sigurdardottir\']', '9789609527002');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κωνσταντίνος Θεοτόκης\']', '9789601651736');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Amanda Mariel\']', '9786180400373');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Aristophanes\']', '9789601645230');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9789601645230');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Peter Beck\']', '9786180329001');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ελευθερία Κυρίμη\']', '9789601667744');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χρήστος Χωμενίδης\']', '9789601648392');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Հովհաննես Թումանյան\', \'Hovhannes Tumanyan\']',
    '9789600358834'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Angeliki Darlasi\']', '9786180324082');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Hannah Kent\']', '9786180313826');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lone Theils\']', '9789601646572');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Emily St. John Mandel\']', '9789601646572');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Barbara Athanassiadis, Βαρβάρα-Ρίτα Αθανασι',
    '9781912322015'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Γρηγόρης Αζαριάδης\']', '9788873042204');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χίλντα Παπαδημητρίου\']', '9786180319774');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jeff VanderMeer\']', '9786180324440');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'R. L. Stine\']', '9786180324440');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χριστίνα Πουλίδου\']', '9786180324440');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αύγουστος Κορτώ\']', '9789601645858');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νίκη Αναστασέα\']', '9789601645858');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πάνος Καζόλης\']', '9781909550018');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'\tPamuk, Orhan\']', '9789601698359');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9789605720285');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'E. L. James\']', '9789605720285');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Hanya Yanagihara\']', '9789600359831');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789600360677');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Julian Barnes\']', '9786180322644');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ashley Audrain\']', '9781909550032');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ragnar Jónasson\']', '9781909550032');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'VD Cain\']', '9781908362391');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Owen Jones\']', '9781908362391');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σάκης Σερέφας\']', '9789605721466');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Μαρία Βαρσάμη - Καρακίτσιου\']',
    '9786180322675'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Auster\']', '9786180322675');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μάρα Μεϊμαρίδη\']', '9786180322675');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Απόστολος Δοξιάδης\']', '9789600363524');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Núria Añó\']', '9789600363524');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Christophe Noël\']', '9786180317640');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stuart Neville\']', '9789600367638');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Christopher Bunn\']', '9786180336108');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'E. L. James\']', '9786180336108');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Owen Jones\']', '9781310259654');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζωρζ Σαρή\']', '9786180333190');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9786180333190');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Carlos Zanón\']', '9786180324112');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Christophe Noël\']', '9786180317602');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ρέα Γαλανάκη\']', '9789601647623');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζοέλ Ντικέρ\']', '9786180317879');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Danilo Clementoni\']', '9781547523986');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ted Chiang\']', '9781547523986');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Karin Brynard\']', '9789601667751');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9786180319934');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Άλκη Ζέη\']', '9786180319934');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευτυχία Γιαννάκη\']', '9789605724924');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789605724924');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789609412797');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Henri Estienne\']', '9781909550544');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Federico Betti\']', '9781547524365');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χ.Α. Χωμενίδης\']', '9781547524365');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9781547524365');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νίκη Αναστασέα\']', '9789601659541');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Maurizio Dagradi\']', '9785041658434');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ε. Λ. Τζέιμς\']', '9785041658434');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Niklas Natt och Dag\']', '9788873047476');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ε. Λ. Τζέιμς\']', '9789600358896');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Anna Ruhe\']', '9789600358896');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ernesto Sabato\']', '9789601645322');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Yrsa Sigurdardottir\']', '9789601645322');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ashley Audrain\']', '9789601645322');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κυριάκος Μαργαρίτης\']', '9789601647883');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κέπλερ, Λαρς\']', '9781987904215');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Beatty\']', '9781987904215');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Carlos Zanon\']', '9789605723316');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Nita Prose\']', '9789605723316');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μάνος Κοντολέων\']', '9786180317695');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Λαρς Κέπλερ\']', '9786180317695');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Bowles\']', '9789600354713');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Andre Aciman\']', '9781909550650');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κώστας Ακρίβος\']', '9789600360226');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lize Spit\']', '9789600360226');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9789600360226');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζοέλ Ντικέρ\']', '9789605721336');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Annie Ernaux\']', '9789600367782');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χ.Α. Χωμενίδης\']', '9789600367782');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ντονάτο Καρρίζι\']', '9789600357288');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Julian Barnes\']', '9789600357288');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Maurizio Dagradi\']', '9789600357288');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Λουκία Δέρβη\']', '9786180322293');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'R. L. Stine\']', '9786180322293');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Δημήτρης Νόλλας\']', '9789601647371');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Barbara Athanassiadis\', \'Βαρβάρα-Ρίτα Αθανα',
    '9786180327090'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ράνια Συνοδινού\']', '9786180324143');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Elaina J. Davidson\']', '9786180320138');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αγγελική Νικολούλη\']', '9786180328226');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Βαγγέλης Ραπτόπουλος\']', '9786180328226');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αύγουστος Κορτώ\']', '9786180332421');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lize Spit\']', '9786180320114');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789600367843');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Yrsa Sigurdardottir\']', '9789601660073');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lone Theils\']', '9786180322897');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κώστας Ακρίβος\']', '9789601686370');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέλλα Σελήνη\']', '9789601686370');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κώστας Ακρίβος\']', '9786180327717');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Kateřina Tučková\']', '9789600360455');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Carlos Zanon\']', '9786180320107');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζωρζ Σαρή\']', '9786180320107');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Άλκη Ζέη\']', '9788873047681');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζοέλ Ντικέρ\']', '9788873047681');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μαρία Παπαγιάννη\']', '9789600367867');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αγγελική Νικολούλη\']', '9789600368352');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Peter Beck\']', '9789600368352');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Αναστασιάδης\']', '9789605722012');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μάρκος Κρητικός\']', '9789601657844');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Hernán Diaz\']', '9781912322886');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ράνια Συνοδινού\']', '9781912322886');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Vladimir Nabokov\']', '9786180329094');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Celeste Ng\']', '9786180329094');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Αναστασιάδης\']', '9786180329094');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ντονάτο Καρρίζι\']', '9789606796616');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Amy Blankenship\']', '9786180322798');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ηλίας Μαγκλίνης\']', '9786180322798');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Vladimir Nabokov\']', '9786180328394');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νάταλι Μπακόπουλος\']', '9786180328134');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Άλκη Ζέη\']', '9786180328134');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Arne Dahl\']', '9789605721794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ε. Λ. Τζέιμς\']', '9781667429625');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέφανος Τσιτσόπουλος\']', '9789600363661');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μαριάνθη Ντεβάκη\']', '9789600363661');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Abigail Reynolds\']', '9786180324853');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πέτρος Τατσόπουλος\']', '9786180324853');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αύγουστος Κορτώ\']', '9786180324853');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Valeria De Luca\']', '9786180320794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Arne Dahl\']', '9786180320794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Georgi Gospodinov\']', '9786180314694');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Barbara Athanassiadis, Βαρβάρα-Ρίτα Αθανασι',
    '9789601673196'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μανώλης Ανδριωτάκης\']', '9789601673196');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κική Δημουλά\']', '9781912322640');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Annie Ernaux\']', '9789605722647');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jerzy Kosinski\']', '9789605722579');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Danilo Clementoni\']', '9789605722579');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Susie Steiner\']', '9786180325539');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9786180317701');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μαρία Παπαγιάννη\']', '9789605722241');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Celeste Ng\']', '9789605722241');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Καταρίνα Μασέττι\']', '9786180328257');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κική Δημουλά\']', '9781909550360');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Καταρίνα Μασέττι\']', '9781909550360');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Maurizio Dagradi\']', '9786180330793');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Christopher Bunn\']', '9789601647500');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Τζέφρυ Ευγενίδης\']', '9789605724948');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σκάι Κόργκαν\']', '9786180313819');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Auster\']', '9789939004938');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Anthony Marra\']', '9789939004938');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νάταλι Μπακόπουλος\']', '9786180321005');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Δημήτρης Καρακούσης\']', '9789605724139');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Somerset Maugham\']', '9789601668062');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9786180320787');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χαν Γκανγκ\']', '9786180329667');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jerzy Kosinski\']', '9786180337389');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χριστίνα Πουλίδου\']', '9789605723699');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αύγουστος Κορτώ\']', '9786180326376');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ragnar Jónasson\']', '9786180323887');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευάγγελος Βλάχος\']', '9786180326970');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χ.Α. Χωμενίδης\']', '9789601685427');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ashley Audrain\']', '9789601645032');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Beatty\']', '9786180326550');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Αναστασιάδης\']', '9789600361223');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789600361223');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Marilyn Robinson\']', '9789600361223');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αργύρης Εφταλιώτης\']', '9789605666477');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9786180327007');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χριστίνα Πουλίδου\']', '9786180327007');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'E. L. James\']', '9781547532742');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jean Genet\']', '9789600361087');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Frank Schätzing\']', '9781071526767');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευτυχία Γιαννάκη\']', '9789600368338');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Βαγγέλης Ραπτόπουλος\']', '9781071532997');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'A.G. Lombardo\']', '9789601656052');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stendhal\']', '9786180325560');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Αναστασιάδης\']', '9786180325560');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Τάσος Καλούτσας\']', '9786180320091');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Beatty\']', '9789609527750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Καταρίνα Μασέττι\']', '9789609527750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χρήστος Χωμενίδης\']', '9789609527750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ashley Audrain\']', '9781909550780');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χίλντα Παπαδημητρίου\']', '9781909550780');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Οβίδιος\']', '9789605721138');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Σουρούνης\']', '9789601651750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Julian Barnes\']', '9786180702408');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Julian Barnes\']', '9786180322682');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέλλα Σελήνη\']', '9786180322682');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νάταλι Μπακόπουλος\']', '9789601647470');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νίκος Ζ. Κομνηνός\']', '9781547574667');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πέτρος Τατσόπουλος\']', '9781547574667');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέλλα Σελήνη\']', '9789600322439');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Charley Brindley\']', '9789601645704');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Emma Stonex\']', '9786180321012');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Owen Jones\']', '9786180328981');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ζωρζ Σαρή\']', '9781667411767');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Fabrice Caro\']', '9786180329292');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Abigail Reynolds\']', '9789600367645');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σωτήρης Δημητρίου\']', '9786180314687');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Carlos Zanon\']', '9789600364187');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κωνσταντίνος Θεοτόκης\']', '9789605723897');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9789605723897');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'A.G. Lombardo\']', '9789605723897');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Johannes Valentinus Andreae\']',
    '9786180317589'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stendhal\']', '9786180317589');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Niklas Natt och Dag\']', '9789464447675');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Lone Theils\']', '9789464447675');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Amanda Mariel\']', '9789464447675');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χ.Α. Χωμενίδης\']', '9789600358100');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πάνος Καζόλης\']', '9786180322651');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9786180317794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Carlos Zanon\']', '9786180317794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Charlotte McConaghy\']', '9786180317794');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Camilla Lackberg\']', '9789600353990');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευτυχία Γιαννάκη\']', '9781667407227');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χαν Γκανγκ\']', '9781667407227');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μοργκαν  Ραις\']', '9781667407227');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stuart Neville\']', '9786180322309');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χρήστος Γιαννάκενας\']', '9786180322309');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Luca Ricci\']', '9789605721695');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αύγουστος Κορτώ\']', '9781912322046');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'R. L. Stine\']', '9789604007837');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9789604007837');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ηλίας Μαγκλίνης\']', '9789604007837');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Juan Gabriel Vásquez\']', '9781547510740');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'VD Cain\']', '9786180319750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ράνια Συνοδινού\']', '9786180319750');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Don Winslow\']', '9781910714324');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σπυρίδων Ζαμπέλιος\']', '9789601651606');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Kateřina Tučková\']', '9789609527637');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9789609527200');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9786180322668');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Peter Beck\']', '9781667405148');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ντάνιελ Κέλμαν\']', '9789601657660');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Vladimir Nabokov\']', '9789601657660');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χαν Γκανγκ\']', '9781911352709');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Elaina J. Davidson\']', '9781911352709');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Άλαν Φερστ\']', '9789601655581');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'_¹____ ______\']', '9789601655581');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Δημήτρης Μπουραντάς\']', '9789600354072');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'VD Cain\']', '9789605720575');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Núria Añó\']', '9789605720575');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κωνσταντίνος Θεοτόκης\']', '9786180329049');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Luca Ricci\']', '9789605723736');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9789600367690');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Τζώρτζης Μηλιάς\']', '9789601699837');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Beatty\']', '9781005226350');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'π. Σάββας Δαυίδ Βασιλειάδης\']',
    '9781005226350'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πέτρος Τατσόπουλος\']', '9781005226350');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9786180329278');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ρέα Γαλανάκη\']', '9786180317831');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μίνως Ευσταθιάδης\']', '9786180317831');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χίλντα Παπαδημητρίου\']', '9789600360639');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αγγελική Νικολούλη\']', '9789600360639');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέλλα Σελήνη\']', '9786180315110');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Emily St. John Mandel\']', '9786180315110');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέλλα Σελήνη\']', '9786180320800');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πάνος Καζόλης\']', '9789600361407');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Núria Añó\']', '9789600361407');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κέπλερ, Λαρς\']', '9786180322323');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Νίκος Ζ. Κομνηνός\']', '9786180313321');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9781329008045');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μαρία Παπαγιάννη\']', '9789608869530');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Σωτήρης Δημητρίου\']', '9789608869530');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Πάνος Καζόλης\']', '9789601645209');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Guy de Maupassant\']', '9789601655666');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Οβίδιος\']', '9789601655666');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stephen Crane\']', '9786180328356');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στήβ Βέρνον\']', '9786180328356');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Alejandro Zambra\']', '9786180329087');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'KL Walther\']', '9789605721664');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Andre Malraux\']', '9789605721664');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Δημήτρης Μπουραντάς\']', '9786180326956');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stuart Neville\']', '9789600368345');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Marilynne Robinson\']', '9786180319125');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Aristophanes\']', '9786180319125');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9781632913234');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Yrsa Sigurdardottir\']', '9786180332438');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Arne Dahl\']', '9786180332438');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Auster\']', '9789605722470');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Guy de Maupassant\']', '9789605725556');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Paul Beatty\']', '9786180322385');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ragnar Jónasson\']', '9781987904185');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ragnar Jónasson\']', '9789601647838');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9789601647838');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Konar, Affinity\']', '9786180400557');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Juan Gabriel Vásquez\']', '9786180313925');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'David Mitchell\']', '9786180313925');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Haylen Beck\']', '9786180324129');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Luca Ricci\']', '9781547535682');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Charlotte McConaghy\']', '9789601639406');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jeff VanderMeer\']', '9789605665951');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μίνως Ευσταθιάδης\']', '9781912322961');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Στέφανος Τσιτσόπουλος\']', '9789605724382');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Giselle Renarde\']', '9781071599594');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Donatella Di Pietrantonio\']',
    '9781071599594'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Άλκη Ζέη\']', '9789609527101');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Konar, Affinity\']', '9781667432564');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  (
    '[\'Johannes Valentinus Andreae\']',
    '9789605722876'
  );
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Βαγγέλης Ραπτόπουλος\']', '9786180317770');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μισέλ Φάις\']', '9786180320329');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9781071523902');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Amanda Mariel\']', '9786180329766');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευτυχία Γιαννάκη\']', '9789601681986');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Danilo Clementoni\']', '9786180322316');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Harald Gilbers\']', '9785043340351');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Christophe Noël\']', '9781387567997');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μάρκος Κρητικός\']', '9781387567997');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Amanda Mariel\']', '9789605723231');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Λεονάρδο Παδούρα\']', '9786180319767');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αλέξης Σταμάτης\']', '9786180322330');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Τάσος Καλούτσας\']', '9781071526521');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χίλντα Παπαδημητρίου\']', '9781071526521');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κική Δημουλά\']', '9781071526521');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μισέλ Φάις\']', '9783966103473');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Μίνως Ευσταθιάδης\']', '9785041512521');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Charlotte McConaghy\']', '9781507198025');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ηλίας Μαγκλίνης\']', '9785043797230');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'George Orwell\']', '9781071510032');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χρήστος Χωμενίδης\']', '9781071510032');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Κική Δημουλά\']', '9786180322736');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Stendhal\']', '9786180322736');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9786180322736');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Emily St. John Mandel\']', '9781465549976');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Jane Harper\']', '9786180324075');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Αντώνης Σουρούνης\']', '9786180324075');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Enrique Vila-Matas\']', '9786180317848');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Aristophanes\']', '9781909550513');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Ευτυχία Γιαννάκη\']', '9781909550513');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Χίλντα Παπαδημητρίου\']', '9786180320121');
INSERT INTO
  `book_writers` (`WriterName`, `ISBN`)
VALUES
  ('[\'Karin Brynard\']', '9786180320121');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: borrowing
# ------------------------------------------------------------

INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-19', 'True', 72, '9786180323887');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-06', 'True', 60, '9789939004938');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-31', 'True', 110, '9789605722012');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-09', 'True', 10, '9789601656052');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-25', 'True', 110, '9789601699837');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-27', 'True', 63, '9781310259654');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-09', 'False', 58, '9789601651750');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-11', 'True', 91, '9781912322886');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-15', 'False', 110, '9789605722876');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-23', 'False', 42, '9789609527002');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-15', 'False', 91, '9789605724382');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-27', 'True', 5, '9789601645858');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-21', 'True', 72, '9786180317640');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-09', 'False', 86, '9781071532997');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-19', 'True', 42, '9789601660073');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-26', 'False', 42, '9781667432564');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-24', 'True', 58, '9789605724382');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-08', 'False', 5, '9789601645858');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-19', 'True', 63, '9789609527002');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-04', 'False', 80, '9786180317695');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-05', 'True', 80, '9786180322897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-10', 'True', 5, '9786180317640');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-11', 'True', 80, '9781547523986');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-22', 'False', 10, '9786180323887');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-06', 'False', 53, '9789600367690');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-22', 'True', 10, '9786180328981');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-30', 'True', 27, '9781909550513');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-24', 'True', 63, '9781909550032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-10', 'True', 72, '9789601647838');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-27', 'False', 27, '9789600367843');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-03', 'True', 60, '9789600367843');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-17', 'True', 5, '9781667432564');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-15', 'True', 53, '9789601647500');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-19', 'True', 10, '9789605721138');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-18', 'False', 58, '9789601651750');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-06', 'True', 60, '9781667407227');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-31', 'True', 27, '9786180319767');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-01', 'True', 5, '9786180322897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-02', 'True', 53, '9786180325560');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-18', 'True', 104, '9786180329667');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-05', 'False', 97, '9789600367638');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-07', 'True', 104, '9781909550018');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-24', 'True', 9, '9781912322046');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-24', 'True', 98, '9789601647623');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-14', 'True', 9, '9789605723897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-09', 'True', 39, '9781987904185');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-22', 'True', 39, '9786180322644');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-25', 'True', 75, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-27', 'True', 75, '9789600367690');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-02', 'True', 23, '9786180317794');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-08', 'False', 23, '9789600363661');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-14', 'True', 39, '9789605723736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-03', 'False', 23, '9781547510740');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-24', 'True', 75, '9789605724382');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-26', 'False', 98, '9789601647371');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-28', 'True', 9, '9785041512521');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-09', 'True', 75, '9789600354072');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-04', 'True', 75, '9789600358896');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-19', 'False', 75, '9789605666477');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-11', 'False', 9, '9789601698359');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-05', 'True', 103, '9781909550018');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-13', 'True', 77, '9786180320107');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-30', 'True', 48, '9789464447675');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-18', 'True', 57, '9786180321005');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-18', 'True', 87, '9789609412797');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-20', 'False', 2, '9789605723897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-18', 'True', 28, '9789601647883');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-28', 'False', 48, '9789605722241');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-27', 'True', 48, '9789605724139');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-10', 'False', 61, '9781667429625');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-22', 'False', 61, '9785043340351');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-18', 'False', 2, '9786180328257');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-28', 'True', 87, '9786180315110');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-15', 'True', 37, '9789605723897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-08', 'True', 87, '9789600368345');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-19', 'False', 57, '9789605723736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-15', 'False', 77, '9789605722876');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-08', 'False', 103, '9786180320091');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-28', 'True', 87, '9789605722579');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-31', 'False', 77, '9789601645704');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-10', 'True', 48, '9786180322644');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-04', 'True', 37, '9786180313321');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-05', 'True', 87, '9786180327007');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-23', 'True', 48, '9786180329094');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-26', 'False', 37, '9786180317701');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-01', 'True', 87, '9781912322886');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-31', 'True', 28, '9786180317602');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-28', 'True', 106, '9786180322316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-11', 'False', 85, '9786180324143');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-22', 'False', 6, '9789600354713');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-15', 'True', 29, '9786180328981');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-21', 'True', 105, '9786180324082');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-25', 'False', 101, '9786180322316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-13', 'True', 105, '9786180328981');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-09', 'False', 29, '9789600360677');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-16', 'False', 13, '9786180322644');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-08', 'True', 46, '9781071523902');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-14', 'True', 106, '9789601655581');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-28', 'True', 106, '9789609527200');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-19', 'True', 59, '9786180321012');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-03', 'False', 19, '9786180317848');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-10', 'True', 46, '9789605721695');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-31', 'True', 13, '9786180327090');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-18', 'True', 105, '9786180329292');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-21', 'False', 19, '9786180324143');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-09', 'False', 105, '9789605723699');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-11', 'True', 106, '9786180328394');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-26', 'False', 13, '9789605722647');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-17', 'True', 46, '9781909550780');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-15', 'False', 106, '9786180329001');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-10', 'True', 46, '9786180313826');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-01', 'True', 6, '9789601660073');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-22', 'False', 29, '9789605722647');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-22', 'False', 59, '9786180329001');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-25', 'False', 59, '9786180328356');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-07', 'True', 6, '9786180322316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-12', 'True', 6, '9781912322961');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-05', 'True', 109, '9789601647883');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-01', 'True', 31, '9783966103473');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-12', 'False', 109, '9789609527002');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-24', 'True', 52, '9781071510032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-15', 'True', 52, '9789601645230');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-28', 'True', 68, '9789601645322');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-13', 'True', 69, '9789605722470');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-28', 'False', 95, '9789605721466');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-11', 'True', 31, '9789601667744');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-29', 'False', 41, '9786180337389');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-01', 'True', 12, '9781987904215');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-13', 'True', 12, '9781547524365');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-14', 'False', 12, '9781071526767');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-23', 'True', 41, '9789601651736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-09', 'True', 12, '9789605724924');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-15', 'True', 31, '9789600357288');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-18', 'True', 12, '9781667432564');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-24', 'False', 3, '9789601645230');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-23', 'True', 22, '9789609527200');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-01', 'True', 3, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-15', 'False', 31, '9786180322644');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-28', 'True', 31, '9781667429625');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-18', 'True', 15, '9789601656052');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-18', 'True', 14, '9786180327717');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-10', 'True', 15, '9786180328394');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-13', 'False', 3, '9781667405148');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-10', 'True', 99, '9781329008045');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-22', 'False', 15, '9786180317602');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-04', 'False', 99, '9786180320329');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-08', 'True', 66, '9789605724924');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-30', 'False', 66, '9786180320121');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-24', 'True', 88, '9789605722579');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-21', 'True', 66, '9781547524365');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-18', 'True', 81, '9789600360639');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-02', 'True', 41, '9789605722012');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-08', 'True', 67, '9786180337389');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-25', 'True', 15, '9789600359831');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-03', 'True', 66, '9781547574667');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-05', 'True', 15, '9789601667744');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-23', 'False', 81, '9781910714324');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-24', 'True', 14, '9786180329766');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-21', 'False', 52, '9781910714324');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-08', 'False', 31, '9786180314694');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-23', 'True', 47, '9786180322385');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-02', 'True', 69, '9789600367843');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-09', 'False', 68, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-20', 'False', 68, '9786180326550');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-31', 'True', 67, '9781547524365');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-16', 'True', 66, '9786180324129');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-27', 'True', 47, '9789600361087');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-13', 'True', 69, '9781912322046');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-17', 'False', 88, '9789605721695');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-29', 'True', 69, '9781547523986');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-05', 'True', 52, '9781071526767');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-11', 'True', 82, '9781547523986');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-04', 'True', 24, '9789600367843');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-16', 'False', 62, '9789601668062');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-30', 'False', 62, '9781547523986');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-28', 'True', 74, '9789601645858');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-03', 'True', 43, '9786180322316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-25', 'True', 51, '9789609527200');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-15', 'True', 82, '9786180328257');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-05', 'False', 24, '9789605723897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-03', 'True', 43, '9789605721138');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-02', 'False', 82, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-25', 'False', 74, '9786180333190');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-17', 'True', 74, '9789600361087');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-16', 'True', 55, '9789605723699');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-07', 'True', 74, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-03', 'False', 55, '9781909550544');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-07', 'False', 43, '9789600367843');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-03', 'False', 43, '9783966103473');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-15', 'True', 74, '9789601639406');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-19', 'True', 24, '9789604007837');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-16', 'True', 73, '9786180322330');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-21', 'True', 24, '9781547523986');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-30', 'True', 73, '9786180322682');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-26', 'True', 51, '9789601668062');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-27', 'True', 17, '9786180702408');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-03', 'True', 30, '9789605721466');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-15', 'True', 40, '9781909550513');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-16', 'True', 34, '9786180328134');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-11', 'False', 30, '9789605723736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-07', 'True', 34, '9789939004938');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-27', 'True', 107, '9789601647470');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-06', 'True', 84, '9789600361223');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-07', 'True', 40, '9781909550032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-18', 'False', 32, '9789601645858');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 'True', 64, '9789605723316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-25', 'False', 84, '9789601645032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-24', 'False', 107, '9786180702408');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-28', 'True', 100, '9789601647470');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-12', 'True', 30, '9786180317794');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-24', 'True', 32, '9786180337389');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-08', 'False', 56, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-03', 'True', 83, '9789601645209');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-07', 'True', 40, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-30', 'True', 70, '9789600360639');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-19', 'False', 34, '9789600364187');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-01', 'True', 30, '9781547535682');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-23', 'True', 102, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-14', 'True', 17, '9786180322651');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-29', 'True', 32, '9781987904185');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-27', 'True', 102, '9781547535682');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-22', 'True', 17, '9786180329667');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-24', 'True', 108, '9786180322798');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-28', 'True', 32, '9785043340351');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-23', 'True', 102, '9786180322330');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-26', 'True', 100, '9781912322886');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-30', 'True', 17, '9781667411767');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-15', 'True', 40, '9781071510032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-04', 'True', 17, '9786180321012');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-30', 'True', 32, '9789601699837');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-16', 'True', 17, '9786180324082');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-12', 'True', 102, '9785043340351');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-01', 'False', 108, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-25', 'False', 32, '9789609527637');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-19', 'False', 102, '9786180317848');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-12', 'True', 83, '9786180332438');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-23', 'False', 64, '9781310259654');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-12-09', 'True', 36, '9789609527200');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-27', 'True', 36, '9789600361087');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-11', 'True', 20, '9789600354072');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-11', 'True', 49, '9781909550780');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-28', 'False', 93, '9789601645209');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-13', 'True', 78, '9789601651736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-16', 'True', 94, '9789601647500');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-10', 'True', 25, '9781632913234');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-25', 'True', 8, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-14', 'False', 36, '9781909550544');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-14', 'False', 25, '9789601686370');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-17', 'True', 25, '9789939004938');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-08', 'False', 94, '9789605665951');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-19', 'True', 16, '9786180324112');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-08', 'True', 25, '9786180313826');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-18', 'False', 8, '9789600358896');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-07', 'True', 16, '9786180326956');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-16', 'True', 89, '9789601651736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-11', 'True', 49, '9786180315110');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-09-27', 'True', 90, '9786180321012');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-28', 'True', 90, '9789601645209');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-31', 'True', 90, '9786180322798');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-01', 'False', 20, '9789605722647');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-17', 'False', 8, '9789601673196');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-08', 'True', 36, '9786180322316');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-26', 'True', 90, '9789601668062');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-16', 'True', 16, '9786180322385');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-27', 'False', 90, '9786180313826');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-16', 'True', 20, '9781912322015');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-31', 'True', 20, '9786180317701');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-20', 'False', 49, '9786180322644');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-29', 'True', 25, '9786180400373');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-26', 'True', 16, '9789601645209');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-01-27', 'True', 54, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-10', 'True', 71, '9786180325560');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-11', 'False', 79, '9786180325539');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-18', 'True', 7, '9789605720285');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-19', 'False', 18, '9789606796616');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-01', 'True', 38, '9786180317589');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-04', 'True', 35, '9789601651736');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-08-05', 'False', 35, '9781910714324');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-01', 'True', 35, '9786180322897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-31', 'False', 79, '9781329008045');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-12', 'True', 35, '9786180327717');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-05-30', 'False', 35, '9789600368352');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-31', 'True', 18, '9789605721336');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-08', 'True', 71, '9789601698359');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-17', 'False', 7, '9789600360226');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-28', 'True', 7, '9786180322897');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-11', 'False', 7, '9781909550018');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-09-07', 'False', 71, '9789605721336');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-25', 'True', 18, '9781387567997');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-17', 'True', 18, '9781632913234');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-24', 'True', 38, '9781310259654');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-23', 'False', 4, '9781912322961');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-07', 'True', 33, '9786180325539');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-29', 'True', 1, '9786180325539');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-09', 'True', 21, '9786180337389');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-21', 'False', 45, '9786180326376');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-31', 'True', 50, '9786180314687');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-03-03', 'False', 21, '9789605723699');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-29', 'True', 21, '9781911352709');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-18', 'True', 65, '9786180320787');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-11-13', 'False', 76, '9786180314687');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-17', 'True', 65, '9786180321005');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-10-13', 'True', 76, '9789601645032');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-08', 'True', 50, '9786180324129');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-08-05', 'True', 11, '9789601685427');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-25', 'True', 11, '9789601656052');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-03-24', 'True', 76, '9789600353990');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-02-25', 'True', 50, '9786180702408');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-06-07', 'True', 65, '9786180324082');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-05-30', 'True', 45, '9786180322293');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-26', 'True', 45, '9786180320787');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-30', 'True', 26, '9785043797230');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-11', 'True', 45, '9789601657660');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-07-03', 'True', 4, '9786180324075');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-14', 'True', 65, '9789600359831');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-18', 'True', 1, '9786180328134');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-28', 'True', 21, '9786180317794');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-04-05', 'False', 76, '9786180314687');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-07-17', 'False', 65, '9781912322046');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-08', 'False', 44, '9781547510740');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-06-21', 'False', 1, '9786180322293');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-12-28', 'False', 92, '9786180324082');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-06', 'True', 65, '9781911352709');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-13', 'True', 44, '9789605720575');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-01', 'True', 26, '9786180314687');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-11-14', 'False', 21, '9788873042204');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-01-04', 'False', 45, '9789601651750');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-02-01', 'True', 65, '9789601656052');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2021-10-29', 'True', 26, '9789601666587');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2022-04-29', 'True', 50, '9786180317602');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: generaladmin
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: reservation
# ------------------------------------------------------------

INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-24', 27, '9786180317695');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 110, '9789600364187');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 91, '9786180317640');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 42, '9789605722241');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 86, '9786180313826');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 9, '9789601673196');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 23, '9789600360639');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 104, '9786180317589');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 9, '9786180320329');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 39, '9781912322046');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 61, '9781912322886');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 28, '9786180326376');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 37, '9781909550513');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 37, '9789609527750');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-24', 61, '9786180317831');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 13, '9781912322961');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 19, '9789600363661');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 105, '9786180329094');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 59, '9789605721695');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 19, '9781909550650');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 15, '9789601645230');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-24', 31, '9789601647838');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 66, '9786180319774');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 15, '9789600361087');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 52, '9786180328394');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 51, '9789601647883');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-28', 73, '9785043340351');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 62, '9781909550544');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-28', 73, '9786180332438');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 55, '9789601668062');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 84, '9789601645858');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 70, '9786180322651');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 102, '9789939004938');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 30, '9786180332438');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 32, '9788873047681');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 89, '9781547510740');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-24', 90, '9781912322886');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 25, '9786180322385');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 20, '9786180321012');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 8, '9786180326376');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-27', 35, '9789939004938');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 35, '9786180332421');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-22', 38, '9789601639406');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 18, '9781908362391');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-23', 54, '9786180320329');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 76, '9789605720575');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 50, '9786180326550');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-26', 65, '9786180326376');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-25', 21, '9786180319934');
INSERT INTO
  `reservation` (`ReservationDate`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-24', 76, '9786180314694');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: review
# ------------------------------------------------------------

INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    72,
    '9786180323887'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    60,
    '9789939004938'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    110,
    '9789605722012'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    10,
    '9789601656052'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    110,
    '9789601699837'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    63,
    '9781310259654'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    91,
    '9781912322886'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    5,
    '9789601645858'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    72,
    '9786180317640'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    42,
    '9789601660073'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    58,
    '9789605724382'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    63,
    '9789609527002'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    80,
    '9786180322897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    5,
    '9786180317640'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    80,
    '9781547523986'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    10,
    '9786180328981'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    27,
    '9781909550513'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    63,
    '9781909550032'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    72,
    '9789601647838'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    60,
    '9789600367843'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    5,
    '9781667432564'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    53,
    '9789601647500'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    10,
    '9789605721138'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    60,
    '9781667407227'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    27,
    '9786180319767'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    5,
    '9786180322897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    53,
    '9786180325560'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    104,
    '9786180329667'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    104,
    '9781909550018'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    9,
    '9781912322046'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    98,
    '9789601647623'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    9,
    '9789605723897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    39,
    '9781987904185'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    39,
    '9786180322644'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    75,
    '9789601666587'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    75,
    '9789600367690'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    23,
    '9786180317794'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    39,
    '9789605723736'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    75,
    '9789605724382'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    9,
    '9785041512521'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    75,
    '9789600354072'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    75,
    '9789600358896'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    103,
    '9781909550018'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    77,
    '9786180320107'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    48,
    '9789464447675'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    57,
    '9786180321005'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    87,
    '9789609412797'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    28,
    '9789601647883'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    48,
    '9789605724139'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    87,
    '9786180315110'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    37,
    '9789605723897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    87,
    '9789600368345'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    87,
    '9789605722579'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    48,
    '9786180322644'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    37,
    '9786180313321'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    87,
    '9786180327007'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    48,
    '9786180329094'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    87,
    '9781912322886'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    28,
    '9786180317602'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    106,
    '9786180322316'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    29,
    '9786180328981'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    105,
    '9786180324082'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    105,
    '9786180328981'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    46,
    '9781071523902'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    106,
    '9789601655581'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    106,
    '9789609527200'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    59,
    '9786180321012'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    46,
    '9789605721695'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    13,
    '9786180327090'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    105,
    '9786180329292'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    106,
    '9786180328394'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    46,
    '9781909550780'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    46,
    '9786180313826'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    6,
    '9789601660073'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    6,
    '9786180322316'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    6,
    '9781912322961'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    109,
    '9789601647883'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    31,
    '9783966103473'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    52,
    '9781071510032'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    52,
    '9789601645230'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    68,
    '9789601645322'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    69,
    '9789605722470'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    31,
    '9789601667744'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    12,
    '9781987904215'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    12,
    '9781547524365'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    41,
    '9789601651736'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    12,
    '9789605724924'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    31,
    '9789600357288'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    12,
    '9781667432564'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    22,
    '9789609527200'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    3,
    '9789601666587'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    31,
    '9781667429625'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    15,
    '9789601656052'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    14,
    '9786180327717'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    15,
    '9786180328394'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    99,
    '9781329008045'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    66,
    '9789605724924'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    88,
    '9789605722579'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    66,
    '9781547524365'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    81,
    '9789600360639'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    41,
    '9789605722012'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    67,
    '9786180337389'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    15,
    '9789600359831'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    66,
    '9781547574667'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    15,
    '9789601667744'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    14,
    '9786180329766'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    47,
    '9786180322385'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    69,
    '9789600367843'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    67,
    '9781547524365'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    66,
    '9786180324129'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    47,
    '9789600361087'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    69,
    '9781912322046'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    69,
    '9781547523986'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    52,
    '9781071526767'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    82,
    '9781547523986'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    24,
    '9789600367843'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    74,
    '9789601645858'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    43,
    '9786180322316'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    51,
    '9789609527200'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    82,
    '9786180328257'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    43,
    '9789605721138'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    74,
    '9789600361087'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    55,
    '9789605723699'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    74,
    '9789601666587'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    74,
    '9789601639406'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    24,
    '9789604007837'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    73,
    '9786180322330'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    24,
    '9781547523986'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    73,
    '9786180322682'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    51,
    '9789601668062'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    17,
    '9786180702408'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    30,
    '9789605721466'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    40,
    '9781909550513'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    34,
    '9786180328134'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    34,
    '9789939004938'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    107,
    '9789601647470'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    84,
    '9789600361223'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    40,
    '9781909550032'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    64,
    '9789605723316'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    100,
    '9789601647470'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    30,
    '9786180317794'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    32,
    '9786180337389'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    83,
    '9789601645209'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    40,
    '9789601685427'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    70,
    '9789600360639'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    30,
    '9781547535682'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    102,
    '9789601685427'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    17,
    '9786180322651'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    32,
    '9781987904185'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    102,
    '9781547535682'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    17,
    '9786180329667'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    108,
    '9786180322798'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    32,
    '9785043340351'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    102,
    '9786180322330'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    100,
    '9781912322886'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    17,
    '9781667411767'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    40,
    '9781071510032'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    17,
    '9786180321012'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    32,
    '9789601699837'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    17,
    '9786180324082'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    102,
    '9785043340351'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    83,
    '9786180332438'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    36,
    '9789609527200'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    36,
    '9789600361087'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    20,
    '9789600354072'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    49,
    '9781909550780'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    78,
    '9789601651736'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    94,
    '9789601647500'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    25,
    '9781632913234'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    8,
    '9789601685427'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    25,
    '9789939004938'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    16,
    '9786180324112'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    25,
    '9786180313826'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    16,
    '9786180326956'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    89,
    '9789601651736'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    49,
    '9786180315110'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    90,
    '9786180321012'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    90,
    '9789601645209'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    90,
    '9786180322798'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    36,
    '9786180322316'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    90,
    '9789601668062'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    16,
    '9786180322385'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απολαυστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    20,
    '9781912322015'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    20,
    '9786180317701'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    25,
    '9786180400373'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    16,
    '9789601645209'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    54,
    '9789601666587'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    71,
    '9786180325560'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    7,
    '9789605720285'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    38,
    '9786180317589'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    35,
    '9789601651736'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    35,
    '9786180322897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    35,
    '9786180327717'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    18,
    '9789605721336'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    71,
    '9789601698359'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    7,
    '9786180322897'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    18,
    '9781387567997'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    18,
    '9781632913234'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    38,
    '9781310259654'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    33,
    '9786180325539'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    1,
    '9786180325539'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    21,
    '9786180337389'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    50,
    '9786180314687'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    21,
    '9781911352709'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    65,
    '9786180320787'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    65,
    '9786180321005'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι φανταστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'30',
    76,
    '9789601645032'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    50,
    '9786180324129'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'30',
    11,
    '9789601685427'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    11,
    '9789601656052'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εκπληκτικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    76,
    '9789600353990'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    50,
    '9786180702408'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    65,
    '9786180324082'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'31',
    45,
    '9786180322293'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι αδιάφορο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    45,
    '9786180320787'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    26,
    '9785043797230'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    45,
    '9789601657660'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    4,
    '9786180324075'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    65,
    '9789600359831'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    4,
    X'31',
    1,
    '9786180328134'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι εξαιρετικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    21,
    '9786180317794'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'31',
    65,
    '9781911352709'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι ανούσιο. Δεν προτείνω αυτό το βιβλίο.',
    2,
    X'30',
    44,
    '9789605720575'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι συναρπαστικό! Το προτείνω ανεπιφύλακτα για όποιον ψάχνει ένα καλό ανάγνωσμα.',
    5,
    X'31',
    26,
    '9786180314687'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι βαρετό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'30',
    65,
    '9789601656052'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό δεν είναι κάτι ιδιαίτερο, το προτείνω μόνο εάν δεν έχετε κάτι άλλο να διαβάσετε.',
    3,
    X'30',
    26,
    '9789601666587'
  );
INSERT INTO
  `review` (
    `ReviewText`,
    `RatingLikert`,
    `Approval`,
    `IdUsers`,
    `ISBN`
  )
VALUES
  (
    'Το βιβλίο αυτό είναι απογοητευτικό. Δεν προτείνω αυτό το βιβλίο.',
    1,
    X'31',
    50,
    '9786180317602'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: schooladmin
# ------------------------------------------------------------

INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (111, 1, 'Σολομών-Ερρίκος Χρυσικός');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (112, 2, 'Ησαΐας-Αριστόβουλος Τριβέλλας');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (113, 3, 'Ηλιάνα Σοκολάκη');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (114, 4, 'Λάμπρος Νασιόπουλος');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (115, 5, 'Ρωμανός Χατζόπουλος');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (116, 6, 'Σώζων Τεμουρτζίδης');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (117, 7, 'Νικηφόρος Καραΐσκος');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (118, 8, 'Σταμάτιος Ανδρουλιδάκης');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (119, 9, 'Προμηθέας Κουκλατζής');
INSERT INTO
  `schooladmin` (`IdUsers`, `IdSchool`, `Name`)
VALUES
  (120, 10, 'Ίκαρος Πευκιανάκης');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: schoolunit
# ------------------------------------------------------------

INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    1,
    '9 Λύκειο Αθήνας',
    'Πατησίων',
    12,
    'Αθήνα',
    '9.lukeio.athenas@school.com',
    'Μενέλαος Παληός',
    'Σολομών-Ερρίκος Χρυσικός'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    2,
    '7 Δημοτικό Αθήνας',
    'Λεωφόρος Κηφισίας',
    105,
    'Αθήνα',
    '7.demotiko.athenas@school.com',
    'Γεώργιος Μπλανάς',
    'Ησαΐας-Αριστόβουλος Τριβέλλας'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    3,
    '7 Λύκειο Αθήνας',
    'Λεωφόρος Μεσογείων',
    78,
    'Αθήνα',
    '7.lukeio.athenas@school.com',
    'Βερόνικα Μαλλή',
    'Ηλιάνα Σοκολάκη'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    4,
    '5 Λύκειο Θεσσαλονίκης',
    'Λεωφόρος Ευαγγελισμού',
    32,
    'Θεσσαλονίκη',
    '5.lukeio.thessalonikes@school.com',
    'Βλαδίμηρος Σταμέλος',
    'Λάμπρος Νασιόπουλος'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    5,
    '5 Λύκειο Καβάλας',
    'Οδός Καβάλας',
    19,
    'Καβάλα',
    '5.lukeio.kabalas@school.com',
    'Τριανταφυλλιά Μιχαλάρου',
    'Ρωμανός Χατζόπουλος'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    6,
    '3 Λύκειο Ιωαννίνων',
    'Οδός Ιωαννίνων',
    45,
    'Ιωάννινα',
    '3.lukeio.ioanninon@school.com',
    'Φαίδρα Ταυλαρίδου',
    'Σώζων Τεμουρτζίδης'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    7,
    '10 Λύκειο Παλλήνης',
    'Λεωφόρος Παλλήνης',
    57,
    'Παλλήνη',
    '10.lukeio.pallenes@school.com',
    'Λαζαρία-Καλλίνικη Τζιόβα',
    'Νικηφόρος Καραΐσκος'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    8,
    '10 Λύκειο Καρδίτσας',
    'Οδός Καρδίτσης',
    9,
    'Καρδίτσα',
    '10.lukeio.karditsas@school.com',
    'Λέανδρος Αγγελής',
    'Σταμάτιος Ανδρουλιδάκης'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    9,
    '5 Δημοτικό Αλεξανδρούπολης',
    'Οδός Αλεξανδρούπολης',
    22,
    'Αλεξανδρούπολη',
    '5.demotiko.alexandroupoles@school.com',
    '',
    'Προμηθέας Κουκλατζής'
  );
INSERT INTO
  `schoolunit` (
    `IdSchool`,
    `Name`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `Email`,
    `SchoolPrinciple`,
    `SchoolAdmin`
  )
VALUES
  (
    10,
    '1 Λύκειο Θεσσαλονίκης',
    'Οδός Καλαμαριάς',
    71,
    'Θεσσαλονίκη',
    '1.lukeio.thessalonikes@school.com',
    'Ευσταθία Βαϊραμίδου',
    'Ίκαρος Πευκιανάκης'
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: student
# ------------------------------------------------------------

INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Μαγδαληνή Παπανώτα',
    'Σπηλαίων',
    29,
    'Θεσσαλονίκη',
    'magdalene.papanota@example.com',
    '2006-10-31',
    1,
    1,
    1,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ειρηναίος Παλαιολόγος',
    'Σιόλου',
    88,
    'Αθήνα',
    'eirenaios.palaiologos@example.com',
    '2007-06-06',
    0,
    0,
    2,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λουλουδένια Μαρτζούκου',
    'Αντωνάκη',
    126,
    'Καβάλα',
    'louloudenia.martzoukou@example.com',
    '2015-06-14',
    0,
    0,
    3,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αθανασία Μποζίκη',
    'Πάρ. Γρηγορίου',
    228,
    'Θεσσαλονίκη',
    'athanasia.mpozike@example.com',
    '2014-10-16',
    1,
    1,
    4,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Πολυχρόνιος Γαρουφαλής',
    'Μάγειρα',
    18,
    'Αθήνα',
    'polukhronios.garouphales@example.com',
    '2013-03-28',
    1,
    0,
    5,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χρύσανθος Μαυροειδάκος',
    'Καπνιά',
    211,
    'Θεσσαλονίκη',
    'khrusanthos.mauroeidakos@example.com',
    '2008-10-03',
    1,
    2,
    6,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Μηλιά-Ερμιόνη Νίκα',
    'Λεωφόρος Αγίων Παρασκιών',
    204,
    'Αλεξανδρούπολη',
    'meliaermione.nika@example.com',
    '2016-10-19',
    0,
    0,
    7,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βαρδής Κακοσαίος',
    'Πλατεία Μικρού Περιστερίου',
    225,
    'Καρδίτσα',
    'bardes.kakosaios@example.com',
    '2005-04-25',
    0,
    1,
    8,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βερονίκη-Κοκκώνα Αναστασίου',
    'Λεωφόρος Κουτσελιού',
    15,
    'Αθήνα',
    'beronikekokkona.anastasiou@example.com',
    '2006-10-17',
    1,
    0,
    9,
    2
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φοίβος Ρόκας',
    'Αρχάκη',
    36,
    'Αθήνα',
    'phoibos.rokas@example.com',
    '2012-09-23',
    1,
    2,
    10,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ιωνάς Στραβοσνίχης',
    'Οθωνών',
    231,
    'Θεσσαλονίκη',
    'ionas.strabosnikhes@example.com',
    '2013-08-24',
    2,
    1,
    11,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ισίδωρος Γιαννακουδάκης',
    'Πάροδος Γραμπιάς',
    62,
    'Καβάλα',
    'isidoros.giannakoudakes@example.com',
    '2012-09-21',
    1,
    2,
    12,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φιλαρέτη Καρακυρίου',
    'Καρδιτσομαγούλας',
    84,
    'Θεσσαλονίκη',
    'philarete.karakuriou@example.com',
    '2013-08-14',
    0,
    1,
    13,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ζησούλα Μαρτιάδου',
    'Πορφυριάδου',
    216,
    'Καβάλα',
    'zesoula.martiadou@example.com',
    '2007-05-18',
    2,
    2,
    14,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Πελοπίδας Μαυρουδής',
    'Κρικέλλου',
    113,
    'Καβάλα',
    'pelopidas.mauroudes@example.com',
    '2003-08-08',
    1,
    0,
    15,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αρετή-Προδρομία Σπασέγκου',
    'Σχοινούσσης',
    101,
    'Καρδίτσα',
    'areteprodromia.spasegkou@example.com',
    '2010-02-02',
    2,
    1,
    16,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Κάρολος Σφύρλας',
    'Τραχειάς',
    26,
    'Παλλήνη',
    'karolos.sphurlas@example.com',
    '2013-02-15',
    2,
    2,
    17,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ντανιέλα Κουθούρη',
    'Χρονοπούλου',
    60,
    'Αλεξανδρούπολη',
    'ntaniela.kouthoure@example.com',
    '2003-10-04',
    1,
    1,
    18,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Πολυχρόνιος-Ορέστης Φωκάς',
    'Κερίου',
    195,
    'Θεσσαλονίκη',
    'polukhroniosorestes.phokas@example.com',
    '2010-06-12',
    0,
    0,
    19,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Πύρρος Ευαγγελάτος',
    'Παλαιομοναστήρου',
    171,
    'Καρδίτσα',
    'purros.euaggelatos@example.com',
    '2012-09-29',
    1,
    1,
    20,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ζαφείριος Δημόπουλος',
    'Δριμίσκου',
    186,
    'Θεσσαλονίκη',
    'zapheirios.demopoulos@example.com',
    '2013-03-10',
    0,
    1,
    21,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λουλουδένια Πολέμη',
    'Πάροδος Αμπελικού',
    167,
    'Καβάλα',
    'louloudenia.poleme@example.com',
    '2017-04-02',
    2,
    0,
    22,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αιμίλιος Πιπεράκης',
    'Γραμμούσης',
    223,
    'Αθήνα',
    'aimilios.piperakes@example.com',
    '2017-02-22',
    0,
    1,
    23,
    2
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αντύπας Χουλιάρας',
    'Κωστοπούλου',
    8,
    'Ιωάννινα',
    'antupas.khouliaras@example.com',
    '2009-02-25',
    1,
    0,
    24,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σωτήριος Ασημόπουλος',
    'Πολυνέρου',
    148,
    'Καρδίτσα',
    'soterios.asemopoulos@example.com',
    '2011-12-02',
    1,
    1,
    25,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Στεργιαννώ Κοφινάκη',
    'Καμαριώτου',
    72,
    'Θεσσαλονίκη',
    'stergianno.kophinake@example.com',
    '2016-02-12',
    2,
    2,
    26,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Στέφανος Θεολόγος',
    'Οινουσσών',
    231,
    'Αθήνα',
    'stephanos.theologos@example.com',
    '2008-07-21',
    1,
    1,
    27,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χρυσάνθη Τουλούπη',
    'Λεωφ. Κολλινών',
    202,
    'Αθήνα',
    'khrusanthe.touloupe@example.com',
    '2016-07-16',
    2,
    1,
    28,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βαλεντίνος Αγαλιώτης',
    'Πλατεία Δωρικού',
    125,
    'Θεσσαλονίκη',
    'balentinos.agaliotes@example.com',
    '2016-06-17',
    0,
    2,
    29,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ξενοφών Δόβας',
    'Ανωγείου',
    71,
    'Παλλήνη',
    'xenophon.dobas@example.com',
    '2017-05-24',
    1,
    1,
    30,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βενιαμίν Μποτσώλης',
    'Ραΐκου',
    6,
    'Καβάλα',
    'beniamin.mpotsoles@example.com',
    '2011-05-13',
    0,
    1,
    31,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ελισσαίος Νταβάς',
    'Υψηλής Ράχης',
    145,
    'Παλλήνη',
    'elissaios.ntabas@example.com',
    '2004-06-13',
    0,
    1,
    32,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Καλλιρόη Δαγλή',
    'Παπαθωμά',
    13,
    'Θεσσαλονίκη',
    'kalliroe.dagle@example.com',
    '2005-05-27',
    2,
    2,
    33,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Γιολάντα Τρίκα',
    'Αποικίων',
    168,
    'Παλλήνη',
    'giolanta.trika@example.com',
    '2011-10-20',
    1,
    2,
    34,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Στέλλιος Κουλίδης',
    'Θρακομακεδόνων',
    24,
    'Αλεξανδρούπολη',
    'stellios.koulides@example.com',
    '2006-07-05',
    0,
    0,
    35,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σαράντης Ιντζές',
    'Πάρ. Απροβάτου',
    90,
    'Καρδίτσα',
    'sarantes.intzes@example.com',
    '2010-03-16',
    1,
    0,
    36,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σαββούλα Ευαγγελίδη',
    'Πάρ. Αγίας Μαρίνης',
    27,
    'Αθήνα',
    'sabboula.euaggelide@example.com',
    '2008-04-09',
    1,
    0,
    37,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Παράσχος Κοκορδέλης',
    'Θυμιανών',
    173,
    'Αλεξανδρούπολη',
    'paraskhos.kokordeles@example.com',
    '2008-03-25',
    2,
    1,
    38,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φλώρα Γαβριηλίδη',
    'Πάροδος Μεταμορφώσεως',
    29,
    'Αθήνα',
    'phlora.gabrielide@example.com',
    '2008-03-01',
    2,
    1,
    39,
    2
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ανθούλης Κεχαγιάς',
    'Λεωφόρος Λυρκείας',
    188,
    'Παλλήνη',
    'anthoules.kekhagias@example.com',
    '2009-09-19',
    2,
    1,
    40,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Γλυκερία Θεοδοσίου',
    'Κανταρελή',
    197,
    'Καβάλα',
    'glukeria.theodosiou@example.com',
    '2008-04-21',
    1,
    1,
    41,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αμφιθέα Αντωνίου',
    'Δοξάτου',
    90,
    'Αθήνα',
    'amphithea.antoniou@example.com',
    '2009-08-10',
    0,
    1,
    42,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Δάφνη Τριφτανίδου',
    'Βαβουρίου',
    140,
    'Ιωάννινα',
    'daphne.triphtanidou@example.com',
    '2003-11-26',
    0,
    0,
    43,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Περσεφόνη Γαβριήλ',
    'Μποζικά',
    168,
    'Θεσσαλονίκη',
    'persephone.gabriel@example.com',
    '2011-05-24',
    1,
    0,
    44,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Καλλίνικη Φασουλίδου',
    'Οβριάς',
    201,
    'Θεσσαλονίκη',
    'kallinike.phasoulidou@example.com',
    '2016-02-21',
    0,
    2,
    45,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χαράλαμπος Λαφατζής',
    'Αντιμαχείας',
    235,
    'Θεσσαλονίκη',
    'kharalampos.laphatzes@example.com',
    '2011-10-30',
    2,
    1,
    46,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βεατρίκη-Στυλιανή Τζιρατούδη',
    'Αγιοφύλλου',
    152,
    'Καβάλα',
    'beatrikestuliane.tziratoude@example.com',
    '2005-03-25',
    2,
    2,
    47,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ζαχαρίας Δερμιτζάκης',
    'Λαμπαίνης',
    166,
    'Αθήνα',
    'zakharias.dermitzakes@example.com',
    '2016-01-06',
    1,
    0,
    48,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αθηνά Κωνσταντινίδου',
    'Αρκαδικού',
    34,
    'Καρδίτσα',
    'athena.konstantinidou@example.com',
    '2015-08-23',
    1,
    2,
    49,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ασημούλα Πάντου',
    'Υμηττού',
    81,
    'Θεσσαλονίκη',
    'asemoula.pantou@example.com',
    '2004-01-26',
    2,
    1,
    50,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ασημάκης Δουλγεράκης',
    'Χρωμίου',
    77,
    'Ιωάννινα',
    'asemakes.doulgerakes@example.com',
    '2008-11-22',
    2,
    1,
    51,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Μάρθα Τσούρα',
    'Θερμών',
    228,
    'Καβάλα',
    'martha.tsoura@example.com',
    '2007-12-07',
    1,
    1,
    52,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ιερόθεος Κουρκουτάς',
    'Σπαθαραίων',
    41,
    'Αθήνα',
    'ierotheos.kourkoutas@example.com',
    '2014-05-21',
    1,
    1,
    53,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Άρης Κωνσταντόπουλος',
    'Αλατόπετρας',
    157,
    'Αλεξανδρούπολη',
    'ares.konstantopoulos@example.com',
    '2006-04-11',
    2,
    1,
    54,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ερατώ Μασίκα',
    'Αρχαγγέλου',
    29,
    'Ιωάννινα',
    'erato.masika@example.com',
    '2016-01-30',
    1,
    1,
    55,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βαρδής Βλαχονικολέας',
    'Χανίων',
    67,
    'Παλλήνη',
    'bardes.blakhonikoleas@example.com',
    '2015-01-08',
    1,
    2,
    56,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ρούσα Ντριβαλά',
    'Αγίου Αδριανού',
    163,
    'Αθήνα',
    'rousa.ntribala@example.com',
    '2007-09-02',
    1,
    0,
    57,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Έλλη-Εριέτα Σταυρίδου',
    'Λεωφ. Γαλατσάδων',
    221,
    'Αθήνα',
    'elleerieta.stauridou@example.com',
    '2007-03-25',
    0,
    0,
    58,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Δημούλα Μπιμπίρη',
    'Σταφιδοκάμπου',
    24,
    'Θεσσαλονίκη',
    'demoula.mpimpire@example.com',
    '2003-07-10',
    0,
    1,
    59,
    4
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φρίξος Καρτάς',
    'Χατζηδάκη',
    49,
    'Αθήνα',
    'phrixos.kartas@example.com',
    '2011-02-04',
    2,
    1,
    60,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Κομνηνή Διαμαντοπούλου',
    'Καλλυντήριον',
    188,
    'Αθήνα',
    'komnene.diamantopoulou@example.com',
    '2008-09-07',
    0,
    0,
    61,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Διονύσιος Σαλίχος',
    'Τσουκαλαιίκων',
    103,
    'Ιωάννινα',
    'dionusios.salikhos@example.com',
    '2011-07-30',
    0,
    1,
    62,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σπυρίδων Λεντζίου',
    'Καστανώνος Ζαγορίου',
    38,
    'Αθήνα',
    'spuridon.lentziou@example.com',
    '2010-02-25',
    2,
    1,
    63,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βασίλειος-Θεοδόσης Σοφιανός',
    'Αδάμ',
    34,
    'Παλλήνη',
    'basileiostheodoses.sophianos@example.com',
    '2014-11-06',
    1,
    0,
    64,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αυγέρης Καρανίκας',
    'Τζάγκα',
    182,
    'Θεσσαλονίκη',
    'augeres.karanikas@example.com',
    '2013-04-16',
    1,
    1,
    65,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φωκάς-Φανούριος Χρονόπουλος',
    'Πογωνίας',
    107,
    'Καβάλα',
    'phokasphanourios.khronopoulos@example.com',
    '2004-03-22',
    1,
    1,
    66,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ρεβέκα Τσούρα',
    'Λεωφόρος Σιλάτων',
    132,
    'Καβάλα',
    'rebeka.tsoura@example.com',
    '2009-09-06',
    2,
    2,
    67,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φραγκίσκος Μακρυγιάννης',
    'Μεγαλοβρύσου',
    152,
    'Καβάλα',
    'phragkiskos.makrugiannes@example.com',
    '2006-01-22',
    0,
    0,
    68,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σπυράννα Σίββα',
    'Περουλάδων',
    22,
    'Καβάλα',
    'spuranna.sibba@example.com',
    '2011-03-20',
    2,
    1,
    69,
    5
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χρυσή Παλιούρα',
    'Μουζακαίων',
    2,
    'Παλλήνη',
    'khruse.palioura@example.com',
    '2012-03-02',
    2,
    1,
    70,
    7
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χρυσοβαλάντου Μασαούτη',
    'Μωραΐτη',
    250,
    'Αλεξανδρούπολη',
    'khrusobalantou.masaoute@example.com',
    '2008-05-17',
    1,
    0,
    71,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Τηλεμαχος Σμπονιάς',
    'Πάροδος Παλαιοχούνης',
    231,
    'Αθήνα',
    'telemakhos.smponias@example.com',
    '2006-08-01',
    2,
    2,
    72,
    1
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ραλλία Μαυρίδου',
    'Καλλιμασιάς',
    223,
    'Ιωάννινα',
    'rallia.mauridou@example.com',
    '2007-03-25',
    2,
    0,
    73,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ευστράτιος Λάτσκος',
    'Πάροδος Χρυσαυγής',
    41,
    'Ιωάννινα',
    'eustratios.latskos@example.com',
    '2012-12-09',
    1,
    1,
    74,
    6
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ζηνοβία Προύβα',
    'Αραχναίου',
    234,
    'Αθήνα',
    'zenobia.prouba@example.com',
    '2016-08-07',
    1,
    0,
    75,
    2
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αντύπας Ροϊδούλης',
    'Λεοντίου',
    221,
    'Θεσσαλονίκη',
    'antupas.roidoules@example.com',
    '2013-02-25',
    0,
    0,
    76,
    10
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Άρτεμις Καζαντζή',
    'Αρήνης',
    205,
    'Αθήνα',
    'artemis.kazantze@example.com',
    '2006-03-13',
    0,
    2,
    77,
    3
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Μαύρα Χωριανοπούλου',
    'Ανεμοδουρίου',
    218,
    'Καρδίτσα',
    'maura.khorianopoulou@example.com',
    '2015-12-26',
    2,
    2,
    78,
    8
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Αντύπας Τσιτούρας',
    'Πρασιών',
    41,
    'Αλεξανδρούπολη',
    'antupas.tsitouras@example.com',
    '2015-08-20',
    0,
    1,
    79,
    9
  );
INSERT INTO
  `student` (
    `StudentName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `StudentEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λουκία Σακκή',
    'Ακρίων',
    107,
    'Αθήνα',
    'loukia.sakke@example.com',
    '2014-02-27',
    1,
    0,
    80,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: teacher
# ------------------------------------------------------------

INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Εύα Σκυλογιάννη',
    'Πετρωτών',
    66,
    'Καβάλα',
    'eua.skulogianne@example.com',
    '1964-10-12',
    0,
    1,
    81,
    5
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φαίδρα Ταυλαρίδου',
    'Σαρακηνάδου',
    98,
    'Ιωάννινα',
    'phaidra.taularidou@example.com',
    '1988-11-21',
    0,
    1,
    82,
    6
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βασίλειος Κατσίφος',
    'Αμελάντων',
    226,
    'Παλλήνη',
    'basileios.katsiphos@example.com',
    '1969-06-19',
    1,
    0,
    83,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ηλίας Ξανθάκης',
    'Λεωφ. Αράχου',
    36,
    'Παλλήνη',
    'elias.xanthakes@example.com',
    '1965-01-06',
    0,
    0,
    84,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Γλυκερία Κοντογιάννη',
    'Καλλιανού',
    46,
    'Θεσσαλονίκη',
    'glukeria.kontogianne@example.com',
    '1982-10-18',
    0,
    0,
    85,
    4
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Τίτος Βολικάκης',
    'Λεωφόρος Δουμενών',
    88,
    'Αθήνα',
    'titos.bolikakes@example.com',
    '1987-06-07',
    0,
    0,
    86,
    1
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Θεμιστόκλεια Βαλιάκα',
    'Βουνιχώρας',
    161,
    'Αθήνα',
    'themistokleia.baliaka@example.com',
    '1967-07-19',
    1,
    0,
    87,
    3
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Νεφέλη Κουκουθάκη',
    'Κούφης',
    236,
    'Καβάλα',
    'nephele.koukouthake@example.com',
    '1996-08-17',
    0,
    1,
    88,
    5
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Γεωργία Κανελή',
    'Καλουτά',
    171,
    'Καρδίτσα',
    'georgia.kanele@example.com',
    '1994-05-22',
    1,
    0,
    89,
    8
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χαρίλαος Μυλωνάς',
    'Πλατεία Φιλύρας',
    114,
    'Καρδίτσα',
    'kharilaos.mulonas@example.com',
    '1980-06-27',
    0,
    0,
    90,
    8
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ρωμανός Πίσσιος',
    'Λεωφ. Λεβεντοχωρίου',
    50,
    'Αθήνα',
    'romanos.pissios@example.com',
    '1998-04-18',
    0,
    0,
    91,
    1
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λαυρεντία-Διαλεκτή Προύβα',
    'Πλεμενιανών',
    24,
    'Θεσσαλονίκη',
    'laurentiadialekte.prouba@example.com',
    '1978-01-01',
    0,
    1,
    92,
    10
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σεβαστιανή Μπαλανίκα',
    'Γιαννιτσίου',
    97,
    'Καρδίτσα',
    'sebastiane.mpalanika@example.com',
    '1976-09-24',
    0,
    0,
    93,
    8
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λέανδρος Αγγελής',
    'Τυχερού',
    142,
    'Καρδίτσα',
    'leandros.aggeles@example.com',
    '1981-08-28',
    0,
    0,
    94,
    8
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Σταμάτιος-Αθηνόδωρος Ζούνης',
    'Πραιτωρίων',
    118,
    'Καβάλα',
    'stamatiosathenodoros.zounes@example.com',
    '1980-06-03',
    0,
    1,
    95,
    5
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ευσταθία Βαϊραμίδου',
    'Κριμηνίου',
    114,
    'Θεσσαλονίκη',
    'eustathia.bairamidou@example.com',
    '1992-09-30',
    1,
    0,
    96,
    10
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ίων Ριζούλης',
    'Λαλαούνη',
    248,
    'Αθήνα',
    'ion.rizoules@example.com',
    '1957-12-31',
    0,
    0,
    97,
    2
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ολύμπια-Ποθητή Καρκαλέτση',
    'Περιβολίου Δομοκού',
    130,
    'Αθήνα',
    'olumpiapothete.karkaletse@example.com',
    '1966-11-02',
    0,
    0,
    98,
    2
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ζαχαρίας Ταχτσίδης',
    'Βρούτση',
    171,
    'Καβάλα',
    'zakharias.takhtsides@example.com',
    '1968-09-16',
    0,
    1,
    99,
    5
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ανδροκλής Ζευγίτης',
    'Λιόντη',
    83,
    'Παλλήνη',
    'androkles.zeugites@example.com',
    '1983-09-14',
    1,
    1,
    100,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Κυβέλη Βουλγαρίδου',
    'Καπνιά',
    198,
    'Θεσσαλονίκη',
    'kubele.boulgaridou@example.com',
    '1996-01-16',
    0,
    1,
    101,
    4
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Ευτέρπη Σκασίλα',
    'Βαλκάνου',
    112,
    'Παλλήνη',
    'euterpe.skasila@example.com',
    '1991-04-21',
    0,
    0,
    102,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βερόνικα Μαλλή',
    'Καρών Κισσάμου',
    126,
    'Αθήνα',
    'beronika.malle@example.com',
    '1977-05-10',
    0,
    1,
    103,
    3
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Γεώργιος Μπλανάς',
    'Πλ. Βρουχά',
    12,
    'Αθήνα',
    'georgios.mplanas@example.com',
    '1996-08-10',
    1,
    0,
    104,
    2
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Χαράλαμπος Βουτσάς',
    'Μαλετιάνων',
    97,
    'Θεσσαλονίκη',
    'kharalampos.boutsas@example.com',
    '1959-09-07',
    0,
    0,
    105,
    4
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Βλαδίμηρος Σταμέλος',
    'Λαδά',
    28,
    'Θεσσαλονίκη',
    'bladimeros.stamelos@example.com',
    '1996-01-17',
    0,
    0,
    106,
    4
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Φωκάς Αργυρόπουλος',
    'Κατωγής',
    152,
    'Παλλήνη',
    'phokas.arguropoulos@example.com',
    '1985-07-03',
    0,
    0,
    107,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Λαζαρία-Καλλίνικη Τζιόβα',
    'Μεσελέρων',
    154,
    'Παλλήνη',
    'lazariakallinike.tzioba@example.com',
    '1976-12-07',
    0,
    1,
    108,
    7
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Τριανταφυλλιά Μιχαλάρου',
    'Δώρη',
    87,
    'Καβάλα',
    'triantaphullia.mikhalarou@example.com',
    '1958-11-14',
    0,
    1,
    109,
    5
  );
INSERT INTO
  `teacher` (
    `TeacherName`,
    `Adress_street`,
    `Adress_number`,
    `Adress_city`,
    `TeacherEmail`,
    `BirthDate`,
    `BooksToBorrow`,
    `BooksToReserve`,
    `IdUsers`,
    `IdSchool`
  )
VALUES
  (
    'Μενέλαος Παληός',
    'Φιλαδελφείας',
    135,
    'Αθήνα',
    'menelaos.paleos@example.com',
    '1993-04-07',
    0,
    0,
    110,
    1
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: telephone
# ------------------------------------------------------------

INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (1, '2870792272');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (2, '+302369988189');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (3, '2103842680');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (4, '22740 92 991');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (5, '6978 702845');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (6, '+30 2383 235901');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (7, '(+30) 2820 570808');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (8, '210 3699297');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (9, '+30 6981 059221');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (10, '2150038010');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (1, '+306947441402');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (2, '+302226484792');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (3, '2080393813');
INSERT INTO
  `telephone` (`IdSchool`, `PhoneNumber`)
VALUES
  (4, '6962 642 752');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: telephoneuser
# ------------------------------------------------------------

INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (1, '+30 6924 967733');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (2, '(+30) 2501 821040');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (3, '20890 13 733');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (4, '210 1513381');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (5, '2903005561');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (6, '2750960909');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (7, '6970830022');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (8, '+30 6915 731200');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (9, '210 976 8167');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (10, '210 819 2369');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (11, '+30 2119 682573');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (12, '+30 6944 206269');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (13, '2101367902');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (14, '2870273830');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (15, '2065016588');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (16, '(+30) 2472 076516');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (17, '+30 2362 130047');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (18, '6950693636');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (19, '(+30) 2058 787589');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (20, '2728068038');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (21, '+302631109747');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (22, '24870 87 198');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (23, '2860369283');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (24, '6983 670 073');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (25, '(+30) 2256 169577');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (26, '6942 170 918');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (27, '6965 943187');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (28, '+30 2702 907329');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (29, '+30 6980 729073');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (30, '210 7633176');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (31, '2706038793');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (32, '+306980790333');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (33, '27770 22 984');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (34, '(+30) 6967 606758');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (35, '+302183300861');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (36, '6943 386699');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (37, '2750 980 133');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (38, '28660 51 333');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (39, '2473065639');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (40, '210 355 7077');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (41, '2103524009');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (42, '+30 2751 987144');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (43, '2610 654 512');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (44, '2996088508');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (45, '6965 976 053');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (46, '2031012965');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (47, '6905 077046');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (48, '210 9441832');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (49, '+30 2746 510663');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (50, '2830 848 544');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (51, '+30 6965 379273');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (52, '6962 735964');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (53, '2930573874');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (54, '210 633 6463');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (55, '210 286 3719');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (56, '2540138291');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (57, '2670 770 690');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (58, '+302310825235');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (59, '2480 285 610');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (60, '2103672902');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (61, '+302193400253');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (62, '2680 331 725');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (63, '+30 6951 812897');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (64, '6957 632 005');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (65, '210 0881339');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (66, '2380 394275');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (67, '2590 265 896');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (68, '2106808138');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (69, '2920 037 699');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (70, '210 269 2603');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (71, '+306979504920');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (72, '2104467667');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (73, '6994763455');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (74, '2103156300');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (75, '2350 156 640');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (76, '6912 070 096');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (77, '6928 273937');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (78, '2230 282174');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (79, '+30 2011 668517');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (80, '2980 678721');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (81, '+30 2532 676715');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (82, '6986 847910');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (83, '+30 6928 004277');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (84, '210 8482143');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (85, '25060 96 652');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (86, '6988 220760');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (87, '(+30) 6962 361401');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (88, '+30 2103 561493');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (89, '6976 036 356');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (90, '2035014838');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (91, '20890 48 597');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (92, '6971 555 528');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (93, '6958 506272');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (94, '+30 2680 113984');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (95, '2800 241567');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (96, '20370 60 586');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (97, '+30 6925 476925');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (98, '2104505387');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (99, '210 526 8784');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (100, '6972 449057');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (101, '2340687684');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (102, '21300 14 661');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (103, '+302818766338');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (104, '2467078694');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (105, '(+30) 2473 031023');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (106, '2104379053');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (107, '6942 514 579');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (108, '+30 2814 354064');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (109, '2850 308842');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (110, '2350787959');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (111, '+306907134065');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (112, '210 6766609');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (113, '+302256346831');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (114, '210 084 9242');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (115, '2350472825');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (116, '6930 241 216');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (117, '2780 796 212');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (118, '2901068315');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (119, '210 0193325');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (120, '+302906376288');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (21, '2920 880857');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (59, '2041026682');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (27, '2107392440');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (113, '+302484138675');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (46, '2350 605881');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (7, '25090 74 626');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (55, '2104194973');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (43, '210 471 9235');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (71, '2070759341');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (72, '210 2430800');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (119, '6998 886236');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (6, '6926 950514');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (105, '(+30) 2973 823950');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (30, '2109824194');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (85, '6976649282');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (23, '2160146808');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (66, '6979343414');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (6, '(+30) 6988 319386');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (98, '2124063688');
INSERT INTO
  `telephoneuser` (`IdUsers`, `PhoneNumber`)
VALUES
  (43, '+30 6927 891544');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: users
# ------------------------------------------------------------

INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    1,
    'magdalene.papanota',
    'V@91!Ugyi!',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    2,
    'eirenaios.palaiologos',
    'C0OY$Xgq(g',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    3,
    'louloudenia.martzoukou',
    '20Tkxi+f$5',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    4,
    'athanasia.mpozike',
    '&wC)V9Xjh_',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    5,
    'polukhronios.garouphales',
    'EP8Kbcdhi$',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    6,
    'khrusanthos.mauroeidakos',
    'K_59LTj6)I',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    7,
    'melia-ermione.nika',
    'RN&6z0HnI7',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    8,
    'bardes.kakosaios',
    'tt3Pg@Gh&R',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    9,
    'beronike-kokkona.anastasiou',
    '$46NIVw_F7',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    10,
    'phoibos.rokas',
    'R+s6AHd9qo',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    11,
    'ionas.strabosnikhes',
    'sN)80UMtjw',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    12,
    'isidoros.giannakoudakes',
    'fOT8)8f4V@',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    13,
    'philarete.karakuriou',
    '(0RL9gg9LS',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    14,
    'zesoula.martiadou',
    'bqw5IZZ6*6',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    15,
    'pelopidas.mauroudes',
    '%73T^j%N+v',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    16,
    'arete-prodromia.spasegkou',
    'w+^4IFxGD$',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    17,
    'karolos.sphurlas',
    'S(!8JIIbbu',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    18,
    'ntaniela.kouthoure',
    '$4eBXKEz0Y',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    19,
    'polukhronios-orestes.phokas',
    '!Fp(7DuFm3',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    20,
    'purros.euaggelatos',
    'eAlrwQDB@3',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    21,
    'zapheirios.demopoulos',
    'o#@&5eZyi#',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    22,
    'louloudenia.poleme',
    '65LTOumf*!',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    23,
    'aimilios.piperakes',
    'je(8dWdlvr',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    24,
    'antupas.khouliaras',
    '8A*E8XvtW%',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    25,
    'soterios.asemopoulos',
    '_jg^AcU90t',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    26,
    'stergianno.kophinake',
    ')Jh3r#vu$^',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    27,
    'stephanos.theologos',
    ')2l6N4+x)Z',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    28,
    'khrusanthe.touloupe',
    ')2EUF)ga5h',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    29,
    'balentinos.agaliotes',
    'T*6g$XJBhc',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    30,
    'xenophon.dobas',
    '*3GVPELn_q',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    31,
    'beniamin.mpotsoles',
    'N*S0&FKl_(',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    32,
    'elissaios.ntabas',
    'YTVjiQ9y@7',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    33,
    'kalliroe.dagle',
    ')zkHnxrda4',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    34,
    'giolanta.trika',
    '0*3N@%Qi+J',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    35,
    'stellios.koulides',
    '@S&9R6p&IY',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    36,
    'sarantes.intzes',
    'p5YBhs!B!6',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    37,
    'sabboula.euaggelide',
    '!(6O9(o^Sh',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    38,
    'paraskhos.kokordeles',
    'x$)9lIDk+M',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    39,
    'phlora.gabrielide',
    'W4eXRiex%S',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    40,
    'anthoules.kekhagias',
    '^dtcN9C74N',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    41,
    'glukeria.theodosiou',
    'lLv5Lbn5^g',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    42,
    'amphithea.antoniou',
    'CkQpO8^t*8',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    43,
    'daphne.triphtanidou',
    ')3sh7Guvbu',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    44,
    'persephone.gabriel',
    'Z$V6Mfr%Km',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    45,
    'kallinike.phasoulidou',
    '+FE2Q(!ecX',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    46,
    'kharalampos.laphatzes',
    '@6enEVhvIK',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    47,
    'beatrike-stuliane.tziratoude',
    '$+8!SDJ*bm',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    48,
    'zakharias.dermitzakes',
    '9O9De^r*E+',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    49,
    'athena.konstantinidou',
    '$qTKPqIHF2',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    50,
    'asemoula.pantou',
    ')44By#ix2R',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    51,
    'asemakes.doulgerakes',
    'K)c3)1Mf+u',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    52,
    'martha.tsoura',
    'ftf$0ZPc5#',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    53,
    'ierotheos.kourkoutas',
    '%KC9eFSew(',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    54,
    'ares.konstantopoulos',
    '0!(V5AUeg9',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    55,
    'erato.masika',
    '+6VEifWs#w',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    56,
    'bardes.blakhonikoleas',
    'm6QMiFD6$f',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    57,
    'rousa.ntribala',
    '+dTRN3uxp5',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    58,
    'elle-erieta.stauridou',
    'i+9D@sKbty',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    59,
    'demoula.mpimpire',
    '(9kWyYhQ%v',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    60,
    'phrixos.kartas',
    '#GUI&nbl7B',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    61,
    'komnene.diamantopoulou',
    'gPl0CFAmP&',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    62,
    'dionusios.salikhos',
    '+DCkz#Mn_0',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    63,
    'spuridon.lentziou',
    '_2&7UxzsC8',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    64,
    'basileios-theodoses.sophianos',
    '*1#2q8Iyro',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    65,
    'augeres.karanikas',
    '_9tQYQJazN',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    66,
    'phokas-phanourios.khronopoulos',
    '!7f^%A$LiV',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    67,
    'rebeka.tsoura',
    'VTItmByI(9',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    68,
    'phragkiskos.makrugiannes',
    'U)+2ZT_fAZ',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    69,
    'spuranna.sibba',
    'zH6G*G3r!%',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    70,
    'khruse.palioura',
    '%3o$D^2axL',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    71,
    'khrusobalantou.masaoute',
    '@UxuOKht46',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    72,
    'telemakhos.smponias',
    '%XSpwcA%6k',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    73,
    'rallia.mauridou',
    '49Y)IhDz^e',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    74,
    'eustratios.latskos',
    '*zyhX1Hg#k',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    75,
    'zenobia.prouba',
    'hS0_Htvd3!',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    76,
    'antupas.roidoules',
    'P15GBtFw!o',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    77,
    'artemis.kazantze',
    '229SS0X%@g',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    78,
    'maura.khorianopoulou',
    'B0wAvDqM$1',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    79,
    'antupas.tsitouras',
    ')Ic8T4ty1)',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    80,
    'loukia.sakke',
    'i&A7LfJmz_',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    81,
    'eua.skulogianne',
    'p73_yM7n@E',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    82,
    'phaidra.taularidou',
    '7iNYR8@4^t',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    83,
    'basileios.katsiphos',
    '@qkGZiI_+5',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    84,
    'elias.xanthakes',
    ')3uBcl)!3j',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    85,
    'glukeria.kontogianne',
    'q@16ILqWN3',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    86,
    'titos.bolikakes',
    'Xs42+KFmN_',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    87,
    'themistokleia.baliaka',
    '^MK7Dz6Q#0',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    88,
    'nephele.koukouthake',
    '*MBXQ5Jh#9',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    89,
    'georgia.kanele',
    ')2DGmmulbb',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    90,
    'kharilaos.mulonas',
    '*$5hL6Wia2',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    91,
    'romanos.pissios',
    'T%2$(pOu)%',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    92,
    'laurentia-dialekte.prouba',
    'N0gBVaVf&I',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    93,
    'sebastiane.mpalanika',
    'O_jw3RO9Hx',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    94,
    'leandros.aggeles',
    'Gyg6aPLp^V',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    95,
    'stamatios-athenodoros.zounes',
    '*a3Nqe6Dek',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    96,
    'eustathia.bairamidou',
    'j59FWiO9^C',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    97,
    'ion.rizoules',
    'n_3Qh$Ynn1',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    98,
    'olumpia-pothete.karkaletse',
    '%XP4Nbpi77',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    99,
    'zakharias.takhtsides',
    '!@@D0f&w)7',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    100,
    'androkles.zeugites',
    'Z_9CYUo!#y',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    101,
    'kubele.boulgaridou',
    '^KoBbTpeL1',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    102,
    'euterpe.skasila',
    'UK@EEna4$1',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    103,
    'beronika.malle',
    ')kYO*8Awrg',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    104,
    'georgios.mplanas',
    '!6RuYzmiEn',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    105,
    'kharalampos.boutsas',
    '(q4QUrEk%4',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    106,
    'bladimeros.stamelos',
    'IU99BzPe#J',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    107,
    'phokas.arguropoulos',
    '+$47Blfr$X',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    108,
    'lazaria-kallinike.tzioba',
    'ivDto2q_(0',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    109,
    'triantaphullia.mikhalarou',
    'Wt1MDfr0J&',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    110,
    'menelaos.paleos',
    'x&q9TmSv6S',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    111,
    'solomon-errikos.khrusikos',
    'psiTaap9_9',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    112,
    'esaIas-aristoboulos.tribellas',
    '!yBM5!nc8G',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    113,
    'eliana.sokolake',
    'Xu2U)%Cei%',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    114,
    'lampros.nasiopoulos',
    '^QdIfa1OH5',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    115,
    'romanos.khatzopoulos',
    'X%8mOuX*$_',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    116,
    'sozon.temourtzides',
    '5@#J9!Iz$!',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    117,
    'nikephoros.karaIskos',
    '@GjuE*y!o2',
    X'30'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    118,
    'stamatios.androulidakes',
    '(hw_fEf20D',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    119,
    'prometheas.kouklatzes',
    '(2x^InPN@m',
    X'31'
  );
INSERT INTO
  `users` (`IdUsers`, `Username`, `Password`, `Approved`)
VALUES
  (
    120,
    'ikaros.peukianakes',
    'v6Y%_Fa6+v',
    X'31'
  );

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
