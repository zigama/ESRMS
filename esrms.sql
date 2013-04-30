-- phpMyAdmin SQL Dump
-- version 3.2.4
-- http://www.phpmyadmin.net
--
-- Serveur: localhost
-- Généré le : Mar 12 Octobre 2010 à 11:24
-- Version du serveur: 5.1.41
-- Version de PHP: 5.3.1

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Base de données: `esrms`
--

-- --------------------------------------------------------

--
-- Structure de la table `academicyears`
--

CREATE TABLE IF NOT EXISTS `academicyears` (
  `YearID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `YearName` varchar(4) NOT NULL,
  `YearStatus` varchar(10) NOT NULL,
  PRIMARY KEY (`YearID`),
  UNIQUE KEY `YearName` (`YearName`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Contenu de la table `academicyears`
--

INSERT INTO `academicyears` (`YearID`, `YearName`, `YearStatus`) VALUES
(1, '2009', 'finished'),
(2, '2010', 'Current');

-- --------------------------------------------------------

--
-- Structure de la table `attendances`
--

CREATE TABLE IF NOT EXISTS `attendances` (
  `AttendanceID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `EnrollmentID` mediumint(9) NOT NULL,
  `CourseID` mediumint(9) NOT NULL,
  `SessionID` mediumint(9) NOT NULL,
  `Abscences` int(11) DEFAULT '0',
  `ExecusedAbscences` int(11) DEFAULT '0',
  `MaxAttendance` int(11) NOT NULL,
  PRIMARY KEY (`AttendanceID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Contenu de la table `attendances`
--

INSERT INTO `attendances` (`AttendanceID`, `EnrollmentID`, `CourseID`, `SessionID`, `Abscences`, `ExecusedAbscences`, `MaxAttendance`) VALUES
(4, 1, 1, 1, 12, 0, 23),
(3, 1, 2, 1, 0, 12, 23),
(5, 2, 3, 1, 10, 2, 20),
(6, 2, 3, 2, 0, 23, 40),
(8, 3, 6, 1, 0, 65, 4500);

-- --------------------------------------------------------

--
-- Structure de la table `classes`
--

CREATE TABLE IF NOT EXISTS `classes` (
  `ClassID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `ClassCode` varchar(15) NOT NULL,
  `DepartmentID` mediumint(9) NOT NULL,
  PRIMARY KEY (`ClassID`),
  UNIQUE KEY `ClassCode` (`ClassCode`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `classes`
--

INSERT INTO `classes` (`ClassID`, `ClassCode`, `DepartmentID`) VALUES
(1, '1 A TC', 3),
(2, '4 A MP', 1),
(3, '5 A BC', 2);

-- --------------------------------------------------------

--
-- Structure de la table `courses`
--

CREATE TABLE IF NOT EXISTS `courses` (
  `CourseID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `CourseName` varchar(30) NOT NULL,
  PRIMARY KEY (`CourseID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `courses`
--

INSERT INTO `courses` (`CourseID`, `CourseName`) VALUES
(1, 'Biologie'),
(2, 'Chemistry'),
(3, 'Mathematics'),
(4, 'Physics'),
(5, 'Geography'),
(6, 'French');

-- --------------------------------------------------------

--
-- Structure de la table `departments`
--

CREATE TABLE IF NOT EXISTS `departments` (
  `DepartmentID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `DepartmentName` varchar(30) DEFAULT NULL,
  `DepartmentShortName` varchar(10) DEFAULT NULL,
  PRIMARY KEY (`DepartmentID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `departments`
--

INSERT INTO `departments` (`DepartmentID`, `DepartmentName`, `DepartmentShortName`) VALUES
(1, 'Mathematics-Physics', 'MP'),
(2, 'Biology-Chemistry', 'BC'),
(3, 'Tronc Commun', 'TC');

-- --------------------------------------------------------

--
-- Structure de la table `discipline`
--

CREATE TABLE IF NOT EXISTS `discipline` (
  `DisciplineID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `EnrollmentID` mediumint(9) NOT NULL,
  `OffenseType` varchar(150) NOT NULL,
  `OffenseOccurence` varchar(30) NOT NULL,
  `OffenseLocation` varchar(150) NOT NULL,
  `DisciplinaryAction` varchar(150) NOT NULL,
  `SessionID` mediumint(9) NOT NULL,
  PRIMARY KEY (`DisciplineID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `discipline`
--

INSERT INTO `discipline` (`DisciplineID`, `EnrollmentID`, `OffenseType`, `OffenseOccurence`, `OffenseLocation`, `DisciplinaryAction`, `SessionID`) VALUES
(1, 1, 'Criminal offense', '2010-09-17', 'A school-related function without appropriate supervision', 'Expulsion', 1),
(3, 1, 'Infraction of school rules', '2010-09-24', 'On school property', 'Physical activity', 2),
(4, 3, 'Chronic truancy', '2010-09-26', 'A school-related function outside of school property', 'Counseling', 1);

-- --------------------------------------------------------

--
-- Structure de la table `districts`
--

CREATE TABLE IF NOT EXISTS `districts` (
  `ID` int(10) NOT NULL AUTO_INCREMENT,
  `DISTRICT_N` varchar(255) DEFAULT NULL,
  `PROV` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=31 ;

--
-- Contenu de la table `districts`
--

INSERT INTO `districts` (`ID`, `DISTRICT_N`, `PROV`) VALUES
(1, 'BURERA', 'NORD'),
(2, 'MUSANZE', 'NORD'),
(3, 'KICUKIRO', 'VILLE DE KIGALI'),
(4, 'KARONGI', 'OUEST'),
(5, 'NYAMAGABE', 'SUD'),
(6, 'RUSIZI', 'OUEST'),
(7, 'NYAGATARE', 'EST'),
(8, 'GATSIBO', 'EST'),
(9, 'NYABIHU', 'OUEST'),
(10, 'RUBAVU', 'OUEST'),
(11, 'GAKENKE', 'NORD'),
(12, 'NGORORERO', 'OUEST'),
(13, 'RUTSIRO', 'OUEST'),
(14, 'NYARUGENGE', 'VILLE DE KIGALI'),
(15, 'KIREHE', 'EST'),
(16, 'BUGESERA', 'EST'),
(17, 'NGOMA', 'EST'),
(18, 'NYAMASHEKE', 'OUEST'),
(19, 'HUYE', 'SUD'),
(20, 'GISAGARA', 'SUD'),
(21, 'RWAMAGANA', 'EST'),
(22, 'KAYONZA', 'EST'),
(23, 'NYANZA', 'SUD'),
(24, 'RUHANGO', 'SUD'),
(25, 'MUHANGA', 'SUD'),
(26, 'KAMONYI', 'SUD'),
(27, 'GICUMBI', 'NORD'),
(28, 'GASABO', 'VILLE DE KIGALI'),
(29, 'RULINDO', 'NORD'),
(30, 'NYARUGURU', 'SUD');

-- --------------------------------------------------------

--
-- Structure de la table `enrollments`
--

CREATE TABLE IF NOT EXISTS `enrollments` (
  `EnrollmentID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `RegNO` varchar(30) NOT NULL,
  `ClassCode` varchar(15) NOT NULL,
  `YearName` varchar(4) NOT NULL,
  PRIMARY KEY (`EnrollmentID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=6 ;

--
-- Contenu de la table `enrollments`
--

INSERT INTO `enrollments` (`EnrollmentID`, `RegNO`, `ClassCode`, `YearName`) VALUES
(1, '1/2010', '4 A MP', '2009'),
(2, '2/2010', '1 A TC', '2009'),
(3, '1/2010', '5 A BC', '2010');

-- --------------------------------------------------------

--
-- Structure de la table `marks`
--

CREATE TABLE IF NOT EXISTS `marks` (
  `MarkID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `EnrollmentID` mediumint(9) NOT NULL,
  `CourseID` mediumint(9) NOT NULL,
  `SessionID` mediumint(9) NOT NULL,
  `MarkQuiz` float NOT NULL,
  `MarkExam` float NOT NULL,
  `MaxScore` float NOT NULL,
  PRIMARY KEY (`MarkID`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=21 ;

--
-- Contenu de la table `marks`
--

INSERT INTO `marks` (`MarkID`, `EnrollmentID`, `CourseID`, `SessionID`, `MarkQuiz`, `MarkExam`, `MaxScore`) VALUES
(1, 1, 1, 1, 12, 12, 40),
(4, 1, 2, 1, 12, 12, 40),
(5, 1, 1, 2, 12, 12, 40),
(16, 2, 2, 1, 12, 16, 40),
(7, 1, 3, 3, 2, 2, 20),
(8, 1, 6, 3, 12, 12, 30),
(9, 1, 5, 2, 12, 12, 20),
(10, 1, 6, 2, 14, 14, 40),
(11, 1, 4, 1, 23, 26, 50),
(19, 3, 6, 1, 12, 23, 40),
(18, 2, 5, 3, 12, 13, 40),
(17, 2, 4, 1, 23, 15, 40),
(20, 5, 2, 1, 23, 4, 34);

-- --------------------------------------------------------

--
-- Structure de la table `ozekimessagein`
--

CREATE TABLE IF NOT EXISTS `ozekimessagein` (
  `id` int(10) unsigned NOT NULL AUTO_INCREMENT,
  `sender` varchar(30) DEFAULT NULL,
  `receiver` varchar(30) DEFAULT NULL,
  `msg` varchar(160) DEFAULT NULL,
  `senttime` varchar(100) DEFAULT NULL,
  `receivedtime` varchar(100) DEFAULT NULL,
  `operator` varchar(30) DEFAULT NULL,
  `msgtype` varchar(30) DEFAULT NULL,
  `reference` varchar(30) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=16 ;

--
-- Contenu de la table `ozekimessagein`
--

INSERT INTO `ozekimessagein` (`id`, `sender`, `receiver`, `msg`, `senttime`, `receivedtime`, `operator`, `msgtype`, `reference`) VALUES
(1, '+250788277501', '+36203214567', 'Hi mon cousin ,ko unyanzeho?Kwifurije amahoro,amahirwe,impuhwe,umugisha,ubushishozi,urukundo,umunezero,ubutabera n''iteramberekandikwifurijestvalentinbon.', '2010-02-13 16:49:26', '2010-10-04 22:27:00', 'GSMMODEM0', 'SMS:TEXT', NULL),
(2, '+250750382476', '+36203214567', 'Bureau de la CEP-UNR ibifurije gutsinda neza ibizamini Kdi mwige cyane ubundi mwiringire Imana izabashoboza. Zaburi 37:5, Yeremiya 17:7-8, Yesaya 50:7. ', '2010-05-11 14:42:11', '2010-10-04 22:27:01', 'GSMMODEM0', 'SMS:TEXT', NULL),
(3, '+25008501411', '+36203214567', 'Muzehe aragusuhuza!ntabwo cyagihe nafashe brousse mpise ngayo ubwo nzakubwira gahunda mukumanuka ,ndi na onatracom mukanya ndanyuraho,umunsi mwiza.', '2007-09-13 15:06:18', '2010-10-04 22:27:01', 'GSMMODEM0', 'SMS:TEXT', NULL),
(4, '+250750202024', '+36203214567', 'Muraho nyakubahwa, umwaka mushya wa 2010 uzabere uwo ishya n''ihirwe kdi imigisha idasanzwe niyo mbasabiye. umwami IMANA abarindishe ukuboko kwe gukomeye.', '2010-01-01 15:36:21', '2010-10-04 22:27:02', 'GSMMODEM0', 'SMS:TEXT', NULL),
(5, '+250788283834', '+36203214567', 'Mukunzi mwiza wiriwe neza? nshuti uranyubaka mubyo ubwira byinshi +  SMS  uringenzi  dans ma vie (je t''aime et je t''aimerai  toustjrs)  Ok bonne nuit.', '2009-11-10 19:22:03', '2010-10-04 22:27:02', 'GSMMODEM0', 'SMS:TEXT', NULL),
(6, '+250750495532', '+36203214567', 'Habari! C''est juste pour vous inviter au mariage de GRACE & GAD: le 29 mai 2010 à SHANGI à 13h00. Votre présence nous honore. ', '2010-05-13 20:38:04', '2010-10-04 22:27:02', 'GSMMODEM0', 'SMS:TEXT', NULL),
(7, '+250788283834', '+36203214567', 'My..., wiriwe neza   nagirango nkubwirengo ijoro ryiza+ week end urote...', '2009-10-30 20:54:43', '2010-10-04 22:27:03', 'GSMMODEM0', 'SMS:TEXT', NULL),
(8, '+25008423997', '+36203214567', 'Tuzagusura ejo saa 14h00 ndikumwe na Alice na Karimu', '2007-12-28 20:09:15', '2010-10-04 22:27:03', 'GSMMODEM0', 'SMS:TEXT', NULL),
(9, '+250788640941', '+36203214567', 'Amakuru y''iminsi?Natweturashima Imana nshuti nkeneye inkunga yaphone naguze yarampfapfaniye,ubunawenziko utaba umeze sawa niyobyabamuri JUIN.Ibihebyiza', '2010-05-16 15:43:24', '2010-10-04 22:27:03', 'GSMMODEM0', 'SMS:TEXT', NULL),
(10, '+250788611126', '+36203214567', '    .  '' 12 ''  .\n  9      !      3\n    '' .   6   . '' \n\nTime & Year will always fly,but peace, blessings& love from God will always be upon you and your family. ', '2009-12-31 23:39:03', '2010-10-04 22:27:04', 'GSMMODEM0', 'SMS:TEXT', NULL),
(11, '+250788352491', '+36203214567', 'Iyooooo! Mwabura mwabura.', '2010-09-03 16:21:15', '2010-10-04 22:27:04', 'GSMMODEM0', 'SMS:TEXT', NULL),
(12, '+250788283834', '+36203214567', 'Nshuti uyu mwaka uzakubere uwi byishimo ,amahoro n''amahirwe avec  votre famille et vos amis nanjye niyemeje kutazakubabaza na rimwe ngomba  kugushimisha  .    ', '2010-01-01 16:51:33', '2010-10-04 22:27:05', 'GSMMODEM0', 'SMS:TEXT', NULL),
(13, '+250785525901', '+36203214567', 'How do you do brother ? urakumbuwe pe ! nice dream .', '2010-08-08 19:36:03', '2010-10-04 22:27:05', 'GSMMODEM0', 'SMS:TEXT', NULL),
(14, '+250788283834', '+36203214567', 'Honey wiriwe ute ?nkoramutima wanjye,simbi risimbiza ibyishimo umutima wanjye ugatuza happy VALENTINE DAY. sinzi icyo ino date yakwibukije njye rwose pe!  ibite', '2010-02-14 12:25:09', '2010-10-04 22:27:05', 'GSMMODEM0', 'SMS:TEXT', NULL),
(15, '+250788759430', '+36203214567', 'Amahoro Numugisha umunezero ibyishimo ubutunzi iterambere umucyo urukundo amahirwe amata&ubuki ubwitonzi no kumenya Imana bibe kurimwe mugire ibihe byiza.', '2009-09-11 22:19:34', '2010-10-04 22:27:06', 'GSMMODEM0', 'SMS:TEXT', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `ozekimessageout`
--

CREATE TABLE IF NOT EXISTS `ozekimessageout` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sender` varchar(30) DEFAULT NULL,
  `receiver` varchar(30) DEFAULT NULL,
  `msg` varchar(160) DEFAULT NULL,
  `senttime` varchar(100) DEFAULT NULL,
  `receivedtime` varchar(100) DEFAULT NULL,
  `operator` varchar(100) DEFAULT NULL,
  `msgtype` varchar(30) DEFAULT NULL,
  `preference` varchar(30) DEFAULT NULL,
  `status` varchar(30) DEFAULT NULL,
  `errormsg` varchar(250) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=62 ;

--
-- Contenu de la table `ozekimessageout`
--

INSERT INTO `ozekimessageout` (`id`, `sender`, `receiver`, `msg`, `senttime`, `receivedtime`, `operator`, `msgtype`, `preference`, `status`, `errormsg`) VALUES
(1, '+250788800967', '+250788660270', 'Didier birimo gucamo usidjari', '2010-08-15 18:05', NULL, NULL, NULL, NULL, 'sent', NULL),
(29, '+250788800967', '+250728660270', 'Bite mwana?', '2010-10-04 21:42:01', NULL, NULL, NULL, NULL, 'sent', NULL),
(61, '+250788660270', '+250788495911', 'ZIGAMA Didier is sanctioned of Counseling for Chronic truancy from 2010-09-26.', '2010-10-06 09:51:19', NULL, NULL, NULL, NULL, 'sent', NULL);

-- --------------------------------------------------------

--
-- Structure de la table `sector`
--

CREATE TABLE IF NOT EXISTS `sector` (
  `SectorCode` int(4) NOT NULL AUTO_INCREMENT,
  `SectorName` varchar(75) DEFAULT NULL,
  `DistID` int(11) NOT NULL,
  PRIMARY KEY (`SectorCode`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=417 ;

--
-- Contenu de la table `sector`
--

INSERT INTO `sector` (`SectorCode`, `SectorName`, `DistID`) VALUES
(1, 'BASE', 29),
(2, 'Bigogwe', 9),
(3, 'Boneza', 13),
(4, 'Bugarama', 6),
(5, 'Bugeshi', 10),
(6, 'Bukure', 27),
(7, 'Bumbogo', 28),
(8, 'Bungwe', 1),
(9, 'BUREGA', 29),
(10, 'Buruhukiro', 5),
(11, 'Busanze', 30),
(12, 'Busasamana', 23),
(13, 'Busasamana', 10),
(14, 'Busengo ', 11),
(15, 'Bushekeri', 18),
(16, 'Bushenge', 18),
(17, 'BUSHOKI', 29),
(18, 'Busogo', 2),
(19, 'Busoro', 23),
(20, 'Butare', 6),
(21, 'Butaro', 1),
(22, 'BUYOGA', 29),
(23, 'Bweramana', 24),
(24, 'Bweyeye', 6),
(25, 'BWIRA', 12),
(26, 'Bwishyura', 4),
(27, 'Bwisige', 27),
(28, 'Byimana', 24),
(29, 'Byumba', 27),
(30, 'Coko ', 11),
(31, 'Cyabakamyi', 23),
(32, 'Cyabingo ', 11),
(33, 'Cyahinda', 30),
(34, 'Cyanika', 5),
(35, 'Cyanika', 1),
(36, 'Cyanzarwe', 10),
(37, 'Cyato', 18),
(38, 'Cyeru', 1),
(39, 'Cyeza', 25),
(40, 'CYINZUZI', 29),
(41, 'Cyumba', 27),
(42, 'CYUNGO', 29),
(43, 'Cyuve', 2),
(44, 'Fumbwe', 21),
(45, 'Gacaca', 2),
(46, 'Gacurabwenge', 26),
(47, 'Gahanga', 3),
(48, 'Gahara', 15),
(49, 'Gahengeri', 21),
(50, 'Gahini', 22),
(51, 'Gahunga', 1),
(52, 'Gakenke ', 11),
(53, 'Gasaka', 5),
(54, 'Gasange', 8),
(55, 'Gashaki', 2),
(56, 'Gashanda', 17),
(57, 'Gashari', 4),
(58, 'Gashenyi ', 11),
(59, 'Gashonga', 6),
(60, 'Gashora', 16),
(61, 'Gataraga', 2),
(62, 'Gatare', 5),
(63, 'Gatebe', 1),
(64, 'Gatenga', 3),
(65, 'Gatore', 15),
(66, 'Gatsata', 28),
(67, 'Gatsibo', 8),
(68, 'GATUMBA', 12),
(69, 'GATUNDA', 7),
(70, 'Gihango', 13),
(71, 'Giheke', 6),
(72, 'Gihombo', 18),
(73, 'Gihundwe', 6),
(74, 'Gikomero', 28),
(75, 'Gikondo', 3),
(76, 'Gikonko', 20),
(77, 'Gikundamvura', 6),
(78, 'Gisenyi', 10),
(79, 'Gishali', 21),
(80, 'Gishamvu', 19),
(81, 'Gishubi', 20),
(82, 'Gishyita', 4),
(83, 'Gisozi', 28),
(84, 'Gitambi', 6),
(85, 'Gitega', 14),
(86, 'Gitesi', 4),
(87, 'Giti', 27),
(88, 'Gitoki', 8),
(89, 'Gitovu', 1),
(90, 'HINDIRO', 12),
(91, 'Huye', 19),
(92, 'Jabana', 28),
(93, 'Jali', 28),
(94, 'Janja ', 11),
(95, 'Jarama', 17),
(96, 'Jenda', 9),
(97, 'Jomba', 9),
(98, 'Juru', 16),
(99, 'Kabacuzi', 25),
(100, 'Kabagali', 24),
(101, 'Kabare', 22),
(102, 'Kabarondo', 22),
(103, 'Kabarore', 8),
(104, 'Kabatwa', 9),
(105, 'KABAYA', 12),
(106, 'Kacyiru', 28),
(107, 'Kaduha', 5),
(108, 'Kagano', 18),
(109, 'Kagarama', 3),
(110, 'KAGEYO', 12),
(111, 'Kageyo', 27),
(112, 'Kageyo', 8),
(113, 'Kagogo', 1),
(114, 'Kamabuye', 16),
(115, 'Kamegeri', 5),
(116, 'Kamembe', 6),
(117, 'Kamubuga ', 11),
(118, 'Kanama', 10),
(119, 'Kaniga', 27),
(120, 'Kanjongo', 18),
(121, 'Kanombe', 3),
(122, 'Kansi', 20),
(123, 'Kanyinya', 14),
(124, 'Kanzenze', 10),
(125, 'Karago', 9),
(126, 'Karama', 19),
(127, 'Karama', 26),
(128, 'KARAMA', 7),
(129, 'Karambi', 18),
(130, 'Karambo ', 11),
(131, 'KARANGAZI', 7),
(132, 'Karembo', 17),
(133, 'Karenge', 21),
(134, 'Karengera', 18),
(135, 'KATABAGEMU', 7),
(136, 'KAVUMU', 12),
(137, 'Kayenzi', 26),
(138, 'Kayumbu', 26),
(139, 'Kazo', 17),
(140, 'Kibangu', 25),
(141, 'Kibeho', 30),
(142, 'Kibilizi', 23),
(143, 'Kibirizi', 20),
(144, 'Kibirizi', 5),
(145, 'Kibumbwe', 5),
(146, 'Kibungo', 17),
(147, 'Kicukiro', 3),
(148, 'Kigabiro', 21),
(149, 'Kigali', 14),
(150, 'Kigarama', 3),
(151, 'Kigarama', 15),
(152, 'Kigembe', 20),
(153, 'Kigeyo', 13),
(154, 'Kigina', 15),
(155, 'Kigoma', 23),
(156, 'Kigoma', 19),
(157, 'Kimihurura', 28),
(158, 'Kimironko', 28),
(159, 'Kimisagara', 14),
(160, 'Kimonyi', 2),
(161, 'Kinazi', 19),
(162, 'Kinazi', 24),
(163, 'Kinigi', 2),
(164, 'Kinihira', 24),
(165, 'KINIHIRA', 29),
(166, 'Kinoni', 1),
(167, 'Kintobo', 9),
(168, 'Kinyababa', 1),
(169, 'Kinyinya', 28),
(170, 'Kiramuruzi', 8),
(171, 'Kirehe', 15),
(172, 'Kirimbi', 18),
(173, 'KISARO', 29),
(174, 'Kitabi', 5),
(175, 'Kivu', 30),
(176, 'Kivumu', 13),
(177, 'Kivuruga ', 11),
(178, 'Kivuye', 1),
(179, 'KIYOMBE', 7),
(180, 'Kiyumba', 25),
(181, 'Kiziguro', 8),
(182, 'Macuba', 18),
(183, 'Mageragere', 14),
(184, 'Mahama', 15),
(185, 'Mahembe', 18),
(186, 'Mamba', 20),
(187, 'Manihira', 13),
(188, 'Manyagiro', 27),
(189, 'Maraba', 19),
(190, 'Mareba', 16),
(191, 'Masaka', 3),
(192, 'MASORO', 29),
(193, 'Mata', 30),
(194, 'Mataba ', 11),
(195, 'MATIMBA', 7),
(196, 'MATYAZO', 12),
(197, 'Mayange', 16),
(198, 'Mbazi', 19),
(199, 'Mbazi', 5),
(200, 'MBOGO', 29),
(201, 'Mbuye', 24),
(202, 'MIMURI', 7),
(203, 'Minazi ', 11),
(204, 'Miyove', 27),
(205, 'Mpanga', 15),
(206, 'Mubuga', 4),
(207, 'Mudende', 10),
(208, 'Mugano', 5),
(209, 'Muganza', 20),
(210, 'Muganza', 30),
(211, 'Muganza', 6),
(212, 'Mugesera', 17),
(213, 'Mugina', 26),
(214, 'Mugombwa', 20),
(215, 'Mugunga ', 11),
(216, 'MUHANDA', 12),
(217, 'Muhanga', 25),
(218, 'Muhazi', 21),
(219, 'Muhima', 14),
(220, 'Muhondo ', 11),
(221, 'MUHORORO', 12),
(222, 'Muhoza', 2),
(223, 'Muhura', 8),
(224, 'MUKAMA', 7),
(225, 'Mukamira', 9),
(226, 'Mukarange', 27),
(227, 'Mukarange', 22),
(228, 'Mukindo', 20),
(229, 'Mukingo', 23),
(230, 'Muko', 2),
(231, 'Muko', 27),
(232, 'Mukura', 19),
(233, 'Mukura', 13),
(234, 'Munini', 30),
(235, 'Munyaga', 21),
(236, 'Munyiginya', 21),
(237, 'Murama', 22),
(238, 'Murama', 17),
(239, 'Murambi', 4),
(240, 'MURAMBI', 29),
(241, 'Murambi', 8),
(242, 'Muringa', 9),
(243, 'Murunda', 13),
(244, 'Murundi', 4),
(245, 'Murundi', 22),
(246, 'Mururu', 6),
(247, 'Musambira', 26),
(248, 'Musange', 5),
(249, 'Musanze', 2),
(250, 'Musasa', 13),
(251, 'Musaza', 15),
(252, 'Musebeya', 5),
(253, 'Musenyi', 16),
(254, 'Musha', 20),
(255, 'Musha', 21),
(256, 'MUSHERI', 7),
(257, 'Mushikiri', 15),
(258, 'Mushishiro', 25),
(259, 'Mushonyi', 13),
(260, 'Mushubati', 13),
(261, 'Mushubi', 5),
(262, 'Mutenderi', 17),
(263, 'Mutete', 27),
(264, 'Mutuntu', 4),
(265, 'Muyira', 23),
(266, 'Muyongwe ', 11),
(267, 'Muyumbu', 21),
(268, 'Muzo ', 11),
(269, 'Mwendo', 24),
(270, 'Mwiri', 22),
(271, 'Mwogo', 16),
(272, 'Mwulire', 21),
(273, 'Nasho', 15),
(274, 'NDARO', 12),
(275, 'Ndego', 22),
(276, 'Ndera', 28),
(277, 'Ndora', 20),
(278, 'Nduba', 28),
(279, 'Nemba', 1),
(280, 'Nemba ', 11),
(281, 'Ngamba', 26),
(282, 'Ngarama', 8),
(283, 'Ngera', 30),
(284, 'Ngeruka', 16),
(285, 'Ngoma', 30),
(286, 'Ngoma', 19),
(287, 'NGOMA', 29),
(288, 'NGORORERO', 12),
(289, 'Niboye', 3),
(290, 'Nkanka', 6),
(291, 'Nkomane', 5),
(292, 'Nkombo', 6),
(293, 'Nkotsi', 2),
(294, 'Nkungu', 6),
(295, 'NTARABANA', 29),
(296, 'Ntarama', 16),
(297, 'Ntongwe', 24),
(298, 'Ntyazo', 23),
(299, 'Nyabimata', 30),
(300, 'Nyabinoni', 25),
(301, 'Nyabirasi', 13),
(302, 'Nyabitekeri', 18),
(303, 'NYAGATARE', 7),
(304, 'Nyagihanga', 8),
(305, 'Nyagisozi', 23),
(306, 'Nyagisozi', 30),
(307, 'Nyakabanda', 14),
(308, 'Nyakabuye', 6),
(309, 'Nyakaliro', 21),
(310, 'Nyakarenzo', 6),
(311, 'Nyakiriba', 10),
(312, 'Nyamabuye', 25),
(313, 'Nyamata', 16),
(314, 'Nyamirama', 22),
(315, 'Nyamirambo', 14),
(316, 'Nyamiyaga', 26),
(317, 'Nyamiyaga', 27),
(318, 'Nyamugari', 15),
(319, 'Nyamyumba', 10),
(320, 'NYANGE', 12),
(321, 'Nyange', 2),
(322, 'Nyankenke', 27),
(323, 'Nyanza', 20),
(324, 'Nyarubaka', 26),
(325, 'Nyarubuye', 15),
(326, 'Nyarugenge', 14),
(327, 'Nyarugenge', 16),
(328, 'Nyarugunga', 3),
(329, 'Nyarusange', 25),
(330, 'Nyundo', 10),
(331, 'Nzahaha', 6),
(332, 'Nzige', 21),
(333, 'Rambura', 9),
(334, 'Rangiro', 18),
(335, 'Remera', 28),
(336, 'Remera', 2),
(337, 'Remera', 8),
(338, 'Remera', 17),
(339, 'Ririma', 16),
(340, 'Rongi', 25),
(341, 'Rubavu', 10),
(342, 'Rubaya', 27),
(343, 'Rubengera', 4),
(344, 'Rubona', 21),
(345, 'Rugabano', 4),
(346, 'Ruganda', 4),
(347, 'Rugarama', 1),
(348, 'Rugarama', 8),
(349, 'Rugarika', 26),
(350, 'Rugendabari', 25),
(351, 'Rugengabari', 1),
(352, 'Rugera', 9),
(353, 'Rugerero', 10),
(354, 'Ruhango', 24),
(355, 'Ruhango', 13),
(356, 'Ruharambuga', 18),
(357, 'Ruhashya', 19),
(358, 'Ruheru', 30),
(359, 'Ruhuha', 16),
(360, 'Ruhunde', 1),
(361, 'Rukara', 22),
(362, 'Rukira', 17),
(363, 'Rukoma', 26),
(364, 'Rukomo', 27),
(365, 'RUKOMO', 7),
(366, 'RUKOZO', 29),
(367, 'Rukumberi', 17),
(368, 'Ruli ', 11),
(369, 'Runda', 26),
(370, 'Ruramba', 30),
(371, 'Ruramira', 22),
(372, 'Rurembo', 9),
(373, 'Rurenge', 17),
(374, 'Rusarabuye', 1),
(375, 'Rusasa ', 11),
(376, 'Rusatira', 19),
(377, 'Rusebeya', 13),
(378, 'Rusenge', 30),
(379, 'Rushaki', 27),
(380, 'Rushashi ', 11),
(381, 'RUSIGA', 29),
(382, 'Rusororo', 28),
(383, 'Rutare', 27),
(384, 'Rutunga', 28),
(385, 'Ruvune', 27),
(386, 'Rwabicuma', 23),
(387, 'Rwamiko', 27),
(388, 'Rwaniro', 19),
(389, 'Rwankuba', 4),
(390, 'Rwaza', 2),
(391, 'RWEMPASHA', 7),
(392, 'Rwerere', 1),
(393, 'Rweru', 16),
(394, 'Rwezamenyo', 14),
(395, 'Rwimbogo', 6),
(396, 'Rwimbogo', 8),
(397, 'RWIMIYAGA', 7),
(398, 'Rwinkwavu', 22),
(399, 'Sake', 17),
(400, 'Save', 20),
(401, 'Shangasha', 27),
(402, 'Shangi', 18),
(403, 'Shingiro', 2),
(404, 'Shyara', 16),
(405, 'Shyira', 9),
(406, 'Shyogwe', 25),
(407, 'SHYORONGI', 29),
(408, 'Simbi', 19),
(409, 'SOVU', 12),
(410, 'TABAGWE', 7),
(411, 'Tare', 5),
(412, 'Tumba', 19),
(413, 'TUMBA', 29),
(414, 'Twumba', 4),
(415, 'Uwinkingi', 5),
(416, 'Zaza', 17);

-- --------------------------------------------------------

--
-- Structure de la table `sessions`
--

CREATE TABLE IF NOT EXISTS `sessions` (
  `SessionID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `SessionName` varchar(30) NOT NULL,
  `SessionType` varchar(30) NOT NULL,
  PRIMARY KEY (`SessionID`),
  UNIQUE KEY `SessionName` (`SessionName`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=4 ;

--
-- Contenu de la table `sessions`
--

INSERT INTO `sessions` (`SessionID`, `SessionName`, `SessionType`) VALUES
(1, '1st Term', 'Term'),
(2, '2nd Term', 'Term'),
(3, '3rd Term', 'Term');

-- --------------------------------------------------------

--
-- Structure de la table `student`
--

CREATE TABLE IF NOT EXISTS `student` (
  `StudID` mediumint(9) NOT NULL AUTO_INCREMENT,
  `FirstName` varchar(30) DEFAULT NULL,
  `LastName` varchar(30) DEFAULT NULL,
  `RegNO` varchar(30) NOT NULL,
  `FatherName` varchar(50) DEFAULT NULL,
  `MotherName` varchar(50) DEFAULT NULL,
  `Sex` varchar(6) DEFAULT NULL,
  `Birthdate` date DEFAULT NULL,
  `Citizenship` varchar(30) DEFAULT NULL,
  `District` int(4) DEFAULT NULL,
  `Sector` int(4) DEFAULT NULL,
  `Cellule` varchar(30) DEFAULT NULL,
  `Village` varchar(30) DEFAULT NULL,
  `GuardianNatID` varchar(30) DEFAULT NULL,
  `GuardianName` varchar(50) DEFAULT NULL,
  `GuardianRelationship` varchar(30) DEFAULT NULL,
  `GuardianPhoneNO` varchar(13) DEFAULT NULL,
  `username` varchar(30) NOT NULL,
  PRIMARY KEY (`StudID`),
  UNIQUE KEY `RegNO` (`RegNO`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=7 ;

--
-- Contenu de la table `student`
--

INSERT INTO `student` (`StudID`, `FirstName`, `LastName`, `RegNO`, `FatherName`, `MotherName`, `Sex`, `Birthdate`, `Citizenship`, `District`, `Sector`, `Cellule`, `Village`, `GuardianNatID`, `GuardianName`, `GuardianRelationship`, `GuardianPhoneNO`, `username`) VALUES
(1, 'Didier', 'ZIGAMA', '1/2010', 'BISHANGARA', 'MUKARUKAKA', 'Male', '1986-01-06', 'Rwandese', 18, 108, 'RWESERO', 'RWESERO', '467723687', 'MUKARUKAKA ', 'Mother', '+250788495911', 'didos'),
(5, 'mahara', 'kelly', '5/2010', 'gdhsjs', 'gsdfhsj', 'Male', '1994-09-09', 'rwandese', 10, 319, 'sdfsg', 'gsfs', 'hfsfsj', 'gdshj', 'Uncle', '64352749', '5/2010'),
(4, 'fsdhg', 'cshgcs', '2/2010', 'cshcgj', 'cdhgcs', 'Female', '2010-09-01', 'fshj', 3, 191, 'vxnb', 'cbn', 'cbnc', 'cxnb', 'Mother', 'cbvn', 'cvcbs'),
(6, 'sadfhj', 'djfs', '6/2010', 'djd', 'hdgvjs', 'Male', '2010-10-14', 'dshfdjs', 13, 355, 'gfdg', 'sahfj', 'gd', 'sdgfd', 'Father', 'dsfg', 'fds');

-- --------------------------------------------------------

--
-- Structure de la table `sys_role`
--

CREATE TABLE IF NOT EXISTS `sys_role` (
  `role_id` smallint(3) DEFAULT NULL,
  `role_name` varchar(30) DEFAULT NULL,
  `super_user` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

--
-- Contenu de la table `sys_role`
--

INSERT INTO `sys_role` (`role_id`, `role_name`, `super_user`) VALUES
(0, 'Super Administrator', 1),
(1, 'Head Master', 0),
(2, 'Head of Studies', 0),
(4, 'Head of Discpline', 0),
(5, 'Lecturer', 0),
(7, 'Student/Parent', 0),
(3, 'Secretary', 0);

-- --------------------------------------------------------

--
-- Structure de la table `sys_sessions`
--

CREATE TABLE IF NOT EXISTS `sys_sessions` (
  `autoid` int(14) NOT NULL AUTO_INCREMENT,
  `sid` varchar(100) NOT NULL,
  `data` text NOT NULL,
  `addr` varchar(100) NOT NULL,
  `opened` varchar(14) DEFAULT NULL,
  `expire` varchar(14) DEFAULT NULL,
  PRIMARY KEY (`autoid`)
) ENGINE=MyISAM DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Contenu de la table `sys_sessions`
--


-- --------------------------------------------------------

--
-- Structure de la table `sys_user`
--

CREATE TABLE IF NOT EXISTS `sys_user` (
  `user_id` mediumint(9) NOT NULL AUTO_INCREMENT,
  `username` varchar(30) NOT NULL,
  `passwd` varchar(100) DEFAULT NULL,
  `full_name` varchar(100) DEFAULT NULL,
  `email_addr` varchar(30) DEFAULT NULL,
  `role_id` smallint(3) DEFAULT NULL,
  `phone_number` varchar(13) DEFAULT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=MyISAM  DEFAULT CHARSET=latin1 AUTO_INCREMENT=54 ;

--
-- Contenu de la table `sys_user`
--

INSERT INTO `sys_user` (`user_id`, `username`, `passwd`, `full_name`, `email_addr`, `role_id`, `phone_number`) VALUES
(1, 'admin', '202cb962ac59075b964b07152d234b70', 'UWANTWALI ZIGAMA Didier', 'zigdidier1986@yahoo.fr', 0, '+250788660270'),
(53, 'hm', '202cb962ac59075b964b07152d234b70', 'Kayumba', 'kayumba@gsob.ac.rw', 1, '+25078308988'),
(51, 'hs', '202cb962ac59075b964b07152d234b70', 'Mugabo Amani', 'hs@gsob.ac.rw', 2, '+250788784298'),
(52, 'hd', '202cb962ac59075b964b07152d234b70', 'Mugisha Malin', 'hd@gsob.ac.rw', 4, '+250782923920'),
(49, 'didos', '202cb962ac59075b964b07152d234b70', 'KARIMBA Assouman', 'assouka@yahoo.fr', 7, '+250788660270'),
(50, 'sec', '202cb962ac59075b964b07152d234b70', 'Magali Contansin', 'magali@yahoo.fr', 3, '+250788660270');

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
