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
# SCHEMA DUMP FOR TABLE: loggeduser
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `loggeduser` (
  `IdLogged` int(11) NOT NULL AUTO_INCREMENT,
  PRIMARY KEY (`IdLogged`)
) ENGINE = InnoDB AUTO_INCREMENT = 3 DEFAULT CHARSET = utf8mb4 COLLATE = utf8mb4_general_ci;

# ------------------------------------------------------------
# SCHEMA DUMP FOR TABLE: reservation
# ------------------------------------------------------------

CREATE TABLE IF NOT EXISTS `reservation` (
  `ReservationId` int(11) NOT NULL AUTO_INCREMENT,
  `ReservationDate` date NOT NULL,
  `Active` int(1) NOT NULL,
  `ISBN` varchar(17) NOT NULL,
  `IdUsers` int(11) DEFAULT NULL,
  PRIMARY KEY (`ReservationId`),
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
  (2, 2, 10, '9781005226350');
INSERT INTO
  `availability` (`Copies`, `AvailableCopies`, `IdSchool`, `ISBN`)
VALUES
  (2, 2, 10, '9781005226350');

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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book_keywords
# ------------------------------------------------------------

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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: book_writers
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: borrowing
# ------------------------------------------------------------

INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-01', 'True', 1, '9781005226350');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-01', 'False', 1, '9781005226350');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-06-01', 'False', 1, '9781005226350');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-01', 'True', 1, '9781005226350');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-05-01', 'False', 1, '9781005226350');
INSERT INTO
  `borrowing` (`BorrowDate`, `Returned`, `IdUsers`, `ISBN`)
VALUES
  ('2023-06-01', 'False', 1, '9781005226350');

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: generaladmin
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: loggeduser
# ------------------------------------------------------------

INSERT INTO
  `loggeduser` (`IdLogged`)
VALUES
  (1);
INSERT INTO
  `loggeduser` (`IdLogged`)
VALUES
  (2);

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: reservation
# ------------------------------------------------------------


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
    'qefqe',
    3,
    X'30',
    1,
    '9781005226350'
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
    'qefqe',
    3,
    X'30',
    1,
    '9781005226350'
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

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: schooladmin
# ------------------------------------------------------------


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
    2,
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
    2,
    10
  );

# ------------------------------------------------------------
# DATA DUMP FOR TABLE: teacher
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: telephone
# ------------------------------------------------------------


# ------------------------------------------------------------
# DATA DUMP FOR TABLE: telephoneuser
# ------------------------------------------------------------


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

/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
