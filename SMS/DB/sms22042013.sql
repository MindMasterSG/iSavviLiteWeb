/*
SQLyog Ultimate v8.82 
MySQL - 5.0.19-nt : Database - quantaed
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`quantaed` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `quantaed`;

/*Table structure for table `ages` */

DROP TABLE IF EXISTS `ages`;

CREATE TABLE `ages` (
  `agegroupid` int(4) unsigned NOT NULL auto_increment,
  `agegroup` varchar(10) default NULL,
  PRIMARY KEY  (`agegroupid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `ages` */

insert  into `ages`(`agegroupid`,`agegroup`) values (1,'18-30'),(2,'31-40'),(3,'41-50'),(4,'51-60'),(5,'61-70'),(6,'70+');

/*Table structure for table `assessments` */

DROP TABLE IF EXISTS `assessments`;

CREATE TABLE `assessments` (
  `AssessmentId` int(10) unsigned NOT NULL auto_increment,
  `StudentId` int(10) unsigned default NULL,
  `LessonId` int(10) unsigned default NULL,
  `QuestionsPresent` int(3) default NULL,
  `QuestionsAnswered` int(3) default NULL,
  `QuestionsCorrect` int(3) default NULL,
  `Score` decimal(5,0) default NULL,
  `IsCompleted` tinyint(1) default NULL,
  `CompletionDate` datetime default NULL,
  `QuantaPoints` int(3) default '0',
  PRIMARY KEY  (`AssessmentId`),
  KEY `FK_assessments` (`StudentId`),
  KEY `FK_assessments_less` (`LessonId`),
  CONSTRAINT `FK_assessments` FOREIGN KEY (`StudentId`) REFERENCES `users` (`UserId`),
  CONSTRAINT `FK_assessments_less` FOREIGN KEY (`LessonId`) REFERENCES `lessons` (`LessonId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `assessments` */

insert  into `assessments`(`AssessmentId`,`StudentId`,`LessonId`,`QuestionsPresent`,`QuestionsAnswered`,`QuestionsCorrect`,`Score`,`IsCompleted`,`CompletionDate`,`QuantaPoints`) values (1,7,1,10,10,3,'30',1,'2013-04-22 08:44:05',6),(2,6,1,0,0,0,'0',0,NULL,NULL);

/*Table structure for table `customerlessonstatus` */

DROP TABLE IF EXISTS `customerlessonstatus`;

CREATE TABLE `customerlessonstatus` (
  `CustomerLessonStatusId` int(10) unsigned NOT NULL auto_increment,
  `Status` varchar(50) default NULL,
  `Description` varchar(100) default NULL,
  PRIMARY KEY  (`CustomerLessonStatusId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customerlessonstatus` */

insert  into `customerlessonstatus`(`CustomerLessonStatusId`,`Status`,`Description`) values (1,'New','New'),(2,'InProcess','InProcess'),(3,'Assessed','Assessed'),(4,'Completed','Completed');

/*Table structure for table `customerslessons` */

DROP TABLE IF EXISTS `customerslessons`;

CREATE TABLE `customerslessons` (
  `CustomerLessonId` int(10) unsigned NOT NULL auto_increment,
  `CustomerId` int(10) unsigned default NULL,
  `LessonId` int(10) unsigned default NULL,
  `OrderNumber` varchar(15) default NULL,
  `RegistrationDate` datetime default NULL,
  `OrderDate` datetime default NULL,
  `OrderPrice` int(10) default NULL,
  `CustomerLessonStatusId` int(10) unsigned default NULL,
  `IsAssessed` tinyint(1) default '0',
  `ValidTill` datetime default NULL,
  `TotalSeatLicenses` int(4) default NULL,
  `UsedSeatLicenses` int(4) default NULL,
  `IsQuantaChallengeOptional` tinyint(1) default NULL,
  PRIMARY KEY  (`CustomerLessonId`),
  KEY `FK_customerslessons` (`CustomerLessonStatusId`),
  KEY `FK_customerslessons_users` (`CustomerId`),
  KEY `FK_customerslessons_lessons` (`LessonId`),
  CONSTRAINT `FK_customerslessons` FOREIGN KEY (`CustomerLessonStatusId`) REFERENCES `customerlessonstatus` (`CustomerLessonStatusId`),
  CONSTRAINT `FK_customerslessons_lessons` FOREIGN KEY (`LessonId`) REFERENCES `lessons` (`LessonId`),
  CONSTRAINT `FK_customerslessons_users` FOREIGN KEY (`CustomerId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `customerslessons` */

insert  into `customerslessons`(`CustomerLessonId`,`CustomerId`,`LessonId`,`OrderNumber`,`RegistrationDate`,`OrderDate`,`OrderPrice`,`CustomerLessonStatusId`,`IsAssessed`,`ValidTill`,`TotalSeatLicenses`,`UsedSeatLicenses`,`IsQuantaChallengeOptional`) values (1,4,1,'11223344','2013-01-31 17:05:27','2013-01-31 17:05:27',15,1,0,'2014-03-11 17:05:27',100,7,1),(2,4,2,'22334455','2013-01-31 17:05:27','2013-01-31 17:05:27',10,2,0,'2014-03-11 17:05:27',100,6,0),(4,10,1,'12345678','2013-03-12 17:05:27','2013-03-12 17:05:27',10,1,0,'2014-03-11 17:05:27',100,0,1);

/*Table structure for table `feedback` */

DROP TABLE IF EXISTS `feedback`;

CREATE TABLE `feedback` (
  `FeedbackId` int(10) unsigned NOT NULL auto_increment,
  `FeedbackType` int(10) unsigned default NULL,
  `Description` varchar(500) default NULL,
  `EmailId` varchar(50) default NULL,
  `GivenDate` datetime default NULL,
  `UserId` int(10) default NULL,
  `LessonId` int(10) default NULL,
  PRIMARY KEY  (`FeedbackId`),
  KEY `FK_feedback` (`FeedbackType`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `feedback` */

insert  into `feedback`(`FeedbackId`,`FeedbackType`,`Description`,`EmailId`,`GivenDate`,`UserId`,`LessonId`) values (1,1,'Great idea','daya.bits@yahoo.com','2013-02-05 00:00:00',0,0),(2,2,'Good suggestion','daya.bits@yahoo.com','2013-02-05 23:36:16',0,0),(3,3,'No issues','daya.bits@yahoo.com','2013-02-05 23:44:23',2,1),(4,2,'gosh.. wonderful.','daya.bits@yahoo.com','2013-02-06 08:59:05',2,2),(5,2,'Good work buddy','daya.sssihl@yahoo.com','2013-02-15 16:04:23',6,1),(6,2,'','','2013-02-15 16:10:04',6,1),(7,0,'good work','gghgh','2013-02-15 16:56:07',6,1),(8,0,'hhfghfh','fghfgh','2013-02-15 16:57:46',6,1);

/*Table structure for table `feedbacktypes` */

DROP TABLE IF EXISTS `feedbacktypes`;

CREATE TABLE `feedbacktypes` (
  `FeedbackTypeId` int(10) unsigned NOT NULL auto_increment,
  `FeedbackName` varchar(400) default NULL,
  PRIMARY KEY  (`FeedbackTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `feedbacktypes` */

insert  into `feedbacktypes`(`FeedbackTypeId`,`FeedbackName`) values (1,'Idea'),(2,'Suggestion'),(3,'Issue'),(4,'General');

/*Table structure for table `lessonobjectives` */

DROP TABLE IF EXISTS `lessonobjectives`;

CREATE TABLE `lessonobjectives` (
  `LOId` int(10) unsigned NOT NULL auto_increment,
  `Lessonid` int(10) unsigned default NULL,
  `objective1` varchar(200) default NULL,
  `objective2` varchar(200) default NULL,
  `objective3` varchar(200) default NULL,
  `objective4` varchar(200) default NULL,
  `objective5` varchar(200) default NULL,
  `objective6` varchar(200) default NULL,
  `objective7` varchar(200) default NULL,
  `objective8` varchar(200) default NULL,
  `objective9` varchar(200) default NULL,
  `objective10` varchar(200) default NULL,
  `objective11` varchar(200) default NULL,
  `objective12` varchar(200) default NULL,
  `objective13` varchar(200) default NULL,
  `objective14` varchar(200) default NULL,
  `objective15` varchar(200) default NULL,
  PRIMARY KEY  (`LOId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `lessonobjectives` */

insert  into `lessonobjectives`(`LOId`,`Lessonid`,`objective1`,`objective2`,`objective3`,`objective4`,`objective5`,`objective6`,`objective7`,`objective8`,`objective9`,`objective10`,`objective11`,`objective12`,`objective13`,`objective14`,`objective15`) values (1,1,'Basic Principles','Kinematics of Gyros','Gyro Performance Specification','Dynamics of Linear and Torsional Vibratory Gyros','Resonant Characteristics','Drive Mode Operation','The Coriolis Response',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `lessonoutline` */

DROP TABLE IF EXISTS `lessonoutline`;

CREATE TABLE `lessonoutline` (
  `OutlineId` int(10) unsigned NOT NULL auto_increment,
  `Lessonid` int(10) unsigned default NULL,
  `outline1` varchar(200) default NULL,
  `outline2` varchar(200) default NULL,
  `outline3` varchar(200) default NULL,
  `outline4` varchar(200) default NULL,
  `outline5` varchar(200) default NULL,
  `outline6` varchar(200) default NULL,
  `outline7` varchar(200) default NULL,
  `outline8` varchar(200) default NULL,
  `outline9` varchar(200) default NULL,
  `outline10` varchar(200) default NULL,
  `outline11` varchar(200) default NULL,
  `outline12` varchar(200) default NULL,
  `outline13` varchar(200) default NULL,
  `outline14` varchar(200) default NULL,
  `outline15` varchar(200) default NULL,
  `outline16` varchar(200) default NULL,
  `outline17` varchar(200) default NULL,
  `outline18` varchar(200) default NULL,
  `outline19` varchar(200) default NULL,
  `outline20` varchar(200) default NULL,
  `outline21` varchar(200) default NULL,
  `outline22` varchar(200) default NULL,
  `outline23` varchar(200) default NULL,
  `outline24` varchar(200) default NULL,
  `outline25` varchar(200) default NULL,
  PRIMARY KEY  (`OutlineId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `lessonoutline` */

insert  into `lessonoutline`(`OutlineId`,`Lessonid`,`outline1`,`outline2`,`outline3`,`outline4`,`outline5`,`outline6`,`outline7`,`outline8`,`outline9`,`outline10`,`outline11`,`outline12`,`outline13`,`outline14`,`outline15`,`outline16`,`outline17`,`outline18`,`outline19`,`outline20`,`outline21`,`outline22`,`outline23`,`outline24`,`outline25`) values (1,1,'Suggested reading','Learning Objectives','What is a Gyro and What are Its Applications','Lesson Overview (operating principle; MEMS gyroscope; classification by application space; operating principle of FOG; MEMS vibratory gyroscopes: linear, torsional, single-axis)','The Conventional Gyroscope','Gyro Types by Performance (Inertial, Tactical, etc.)','Gyro Types by Operating Principles (FOG, Spinning Disk, etc.)','Why the Focus on Vibratory Gyros and Types of Vibratory Gyros','Basic Principles of Vibratory Gyros','Kinematics of Vibratory Gyros','Gyro Performance Specifications','Resonant Characteristics for 1DOF System','Dynamics of Linear Vibratory Rate Gyros','Dynamics of Tortional Vibratory Rate Gyros','Drive Mode Operation','Mode Matching and &#916;f','Phase Relations and Proof Mass Trajectory','Challenges in Gyro Design','Suggested Reading',NULL,NULL,NULL,NULL,NULL,NULL);

/*Table structure for table `lessons` */

DROP TABLE IF EXISTS `lessons`;

CREATE TABLE `lessons` (
  `LessonId` int(10) unsigned NOT NULL auto_increment,
  `LessonName` varchar(100) NOT NULL,
  `VideoPath` varchar(100) default NULL,
  `AddedDate` datetime default NULL,
  `ThumbPath` varchar(100) default NULL,
  `Description` varchar(500) default NULL,
  `Duration` varchar(12) default NULL,
  `QuantaPoints` int(3) default NULL,
  PRIMARY KEY  (`LessonId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `lessons` */

insert  into `lessons`(`LessonId`,`LessonName`,`VideoPath`,`AddedDate`,`ThumbPath`,`Description`,`Duration`,`QuantaPoints`) values (1,'QLDG 1 - MEMS Gyro Design 1','~/content/video/Big_Buck_Bunny_1.avi','2013-01-24 22:48:48','~/Content/images/ThumbGyroLesson1.PNG','MEMS Gyro Design 1','30',20),(2,'QLDG 2 - MEMS Gyro Design 2','~/content/video/movie.mp4','2013-01-24 10:48:48','~/Content/images/videoThumb.jpg','Test video','10',20);

/*Table structure for table `questions` */

DROP TABLE IF EXISTS `questions`;

CREATE TABLE `questions` (
  `QuestionId` int(10) unsigned NOT NULL auto_increment,
  `ActualQuestion` varchar(500) default NULL,
  `A` varchar(500) default NULL,
  `B` varchar(500) default NULL,
  `C` varchar(500) default NULL,
  `D` varchar(500) default NULL,
  `E` varchar(500) default NULL,
  `ActualAnswer` varchar(20) default NULL,
  `QuestionImagePath` varchar(100) default NULL,
  `AImagePath` varchar(100) default NULL,
  `BImagePath` varchar(100) default NULL,
  `CImagePath` varchar(100) default NULL,
  `DImagePath` varchar(100) default NULL,
  `EImagePath` varchar(100) default NULL,
  `LessonId` int(10) unsigned default NULL,
  PRIMARY KEY  (`QuestionId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `questions` */

insert  into `questions`(`QuestionId`,`ActualQuestion`,`A`,`B`,`C`,`D`,`E`,`ActualAnswer`,`QuestionImagePath`,`AImagePath`,`BImagePath`,`CImagePath`,`DImagePath`,`EImagePath`,`LessonId`) values (1,'1). Reena took a loan of Rs. 1200 with simple interest for as many years as the rate of interest. If she paid Rs. 432 as interest at the end of the loan period, what was the rate of interest? ','3.6','6','18','Cannot be determined','None of these','C',NULL,NULL,NULL,NULL,NULL,NULL,2),(2,'2). A watch which gains uniformly is 2 minutes low at noon on Monday and is 4 min. 48 sec fast at 2 p.m. on the following Monday. When was it correct?','2 p.m. on Tuesday','2 p.m. on Wednesday','3 p.m. on Thursday','1 p.m. on Friday',NULL,'B',NULL,NULL,NULL,NULL,NULL,NULL,2),(3,'3). A tap can fill a tank in 6 hours. After half the tank is filled, three more similar taps are opened. What is the total time taken to fill the tank completely?','3 hrs 15 min','3 hrs 45 min','4 hrs','4 hrs 15 min',NULL,'C',NULL,NULL,NULL,NULL,NULL,NULL,2),(4,'4). Two students appeared at an examination. One of them secured 9 marks more than the other and his marks was 56% of the sum of their marks. The marks obtained by them are:','39, 30','41, 32','42, 33','43, 34',NULL,'D',NULL,NULL,NULL,NULL,NULL,NULL,2),(5,'5). A can lay railway track between two given stations in 16 days and B can do the same job in 12 days. With help of C, they did the job in 4 days only. Then, C alone can do the job in:',NULL,NULL,NULL,'10',NULL,'A',NULL,'../../QAImages/5A.jpg','../../QAImages/5B.jpg','../../QAImages/5C.jpg',NULL,NULL,2),(6,'Q1 – A tuning fork is oriented along the x axis, with its tines resonating anti–phase in the x–y plane. Which of the following is true.','The resonant frequency is lower than that for the in-phase resonance mode.','The resonant frequency is higher than that for the in-phase resonance mode.','The resonant frequency is the same as that for the in-phase resonance mode.','The Coriolis force induces opposing y axis deflections of the tines.',NULL,'A',NULL,NULL,NULL,NULL,NULL,NULL,1),(7,'Q2 – A  tuning fork is oriented along the x axis, with its tines resonating in–phase in the x–y plane. The device is experiencing a rotation about the x axis. Which of the following is true.','The Coriolis force induces the same y axis deflection of the tines.','The Coriolis force induces opposing z axis deflections of the tines.','The Coriolis force induces the same z axis deflection of the tines.','The Coriolis force induces opposing y axis deflections of the tines.',NULL,'C',NULL,NULL,NULL,NULL,NULL,NULL,1),(8,'Q3 – When considering a vibrating ring gyro structure versus a tuning fork gyro structure, which of these statements is not true.','Comparatively higher resonant frequencies for the ring structure, leading to reduced vibration sensitivity.','Comparatively higher resonant frequencies for the ring structure because of lower stiffness.','Comparatively smaller drive and sense displacements for the ring structure, adding burden to  the interface electronics design. ','Comparatively lower temperature sensitivity for the ring structure due to better symmetry.',NULL,'B',NULL,NULL,NULL,NULL,NULL,NULL,1),(9,'Q4 – Which of these statements about specifications of low-cost MEMS gyros is correct.','Device needs to have a bandwidth of at least 10 Hz.','Device needs to have a linear scale factor of ~100 degrees/sec.','Device needs to have a dynamic range >500 dB.','Device needs to have a cross-axis sensitivity of at least 5%.',NULL,'A',NULL,NULL,NULL,NULL,NULL,NULL,1),(10,'Q5 – In designing a MEMS vibratory gyro, which of these statements is not true.','Increasing the drive mode displacement amplitude increases the scale factor.','Use of vacuum packaging provides an independent means of increasing Q-factor.','Use of vacuum packaging can eliminate damping all together. ','Going to high stiffness structural designs in high-Q structures increases bandwidth. ',NULL,'C',NULL,NULL,NULL,NULL,NULL,NULL,1),(11,'Q6 – What is the assumption for approximating the bandwidth as natural frequency over Q-factor?','Drive displacement amplitude is high.','Sense displacement amplitude is low.','Proof mass is large.','Damping is small.',NULL,'D',NULL,NULL,NULL,NULL,NULL,NULL,1),(12,'Q7 – Which of these statements is true?','Vibratory gyros are operated at matched sense/drive resonant mode frequencies.','Vibratory gyros are not operated at matched sense/drive resonant mode frequencies.','Vibratory gyros are resonant type gyros.','Vibratory gyros are by nature immune to vibration rectification.',NULL,'B',NULL,NULL,NULL,NULL,NULL,NULL,1),(13,'Q8 – In the simplified dynamics equations of a linear vibratory gyro, why is there no Coriolis force term in the drive mode equation?','Angular acceleration is assumed to be zero.','There is no Coriolis force affecting the drive mode.','This term is neglected compared to the drive force, which is much higher.','This term is accounted for in the sense mode equation.',NULL,'C',NULL,NULL,NULL,NULL,NULL,NULL,1),(14,'Q9 – Which of these statements is not true?','When the sense and drive mode resonant frequencies are matched, the sense mode\'s displacement amplitude is independent on that of the drive mode\'s.','When the sense and drive mode resonant frequencies are matched, the sense and drive modes\' displacements are out of phase by 180 degrees.','When the sense and drive mode resonant frequencies are not matched, the sense and drive modes\' displacements are out of phase by other than 180 degrees.','When the sense and drive mode resonant frequencies are not matched, the sense mode\'s displacement amplitude is dependent on that of the drive mode\'s.',NULL,'A',NULL,NULL,NULL,NULL,NULL,NULL,1),(15,'Q10 – Which of these statements is not true.','Tuning fork gyros can be realized from single-crystal Quartz, using Quartz\'\'s piezoelectricity for both the sense and the drive modes.','Vibratory gyros can be realized from single-crystal silicon, using capacitive sensing and electrostatic drive.','Vibratory gyros can be realized from nickel, using capacitive sensing and electrostatic drive.','Tuning fork gyros can be realized from single-crystal silicon, using silicon\'s piezoresistivity for the sense mode and piezoelectricity for the drive mode.',NULL,'D',NULL,NULL,NULL,NULL,NULL,NULL,1);

/*Table structure for table `studentanswers` */

DROP TABLE IF EXISTS `studentanswers`;

CREATE TABLE `studentanswers` (
  `StudentAnswerId` int(10) unsigned NOT NULL auto_increment,
  `StudentId` int(10) unsigned default NULL,
  `QuestionId` int(10) unsigned default NULL,
  `GivenAnswer` varchar(20) default NULL,
  `LessonId` int(10) unsigned default NULL,
  PRIMARY KEY  (`StudentAnswerId`),
  KEY `FK_studentanswers` (`QuestionId`),
  KEY `FK_studentanswers_l` (`LessonId`),
  KEY `FK_studentanswers_u` (`StudentId`),
  CONSTRAINT `FK_studentanswers` FOREIGN KEY (`QuestionId`) REFERENCES `questions` (`QuestionId`),
  CONSTRAINT `FK_studentanswers_l` FOREIGN KEY (`LessonId`) REFERENCES `lessons` (`LessonId`),
  CONSTRAINT `FK_studentanswers_u` FOREIGN KEY (`StudentId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `studentanswers` */

/*Table structure for table `studentlessons` */

DROP TABLE IF EXISTS `studentlessons`;

CREATE TABLE `studentlessons` (
  `StudentLessonId` int(10) unsigned NOT NULL auto_increment,
  `StudentId` int(10) unsigned default NULL,
  `LessonId` int(10) unsigned default NULL,
  `RegistrationDate` datetime default NULL,
  `UnRegistrationDate` datetime default NULL,
  `Status` int(10) unsigned default NULL,
  `AssessmentId` int(10) unsigned default NULL,
  `StartedDate` datetime default NULL,
  `LastLaunchDate` datetime default NULL,
  PRIMARY KEY  (`StudentLessonId`),
  KEY `FK_studentlessons_assess` (`AssessmentId`),
  KEY `FK_studentlessons_user` (`StudentId`),
  KEY `FK_studentlessons_lessons` (`LessonId`),
  KEY `FK_studentlessons` (`Status`),
  CONSTRAINT `FK_studentlessons` FOREIGN KEY (`Status`) REFERENCES `customerlessonstatus` (`CustomerLessonStatusId`),
  CONSTRAINT `FK_studentlessons_lessons` FOREIGN KEY (`LessonId`) REFERENCES `lessons` (`LessonId`),
  CONSTRAINT `FK_studentlessons_user` FOREIGN KEY (`StudentId`) REFERENCES `users` (`UserId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `studentlessons` */

insert  into `studentlessons`(`StudentLessonId`,`StudentId`,`LessonId`,`RegistrationDate`,`UnRegistrationDate`,`Status`,`AssessmentId`,`StartedDate`,`LastLaunchDate`) values (5,11,1,'2013-03-12 21:00:49','0001-01-01 00:00:00',2,0,'2013-03-12 21:01:06','0001-01-01 00:00:00'),(14,6,1,'2013-03-14 20:25:24','0001-01-01 00:00:00',1,0,'0001-01-01 00:00:00','0001-01-01 00:00:00'),(15,7,1,'2013-03-14 20:25:24','0001-01-01 00:00:00',4,0,'2013-03-19 07:39:47','2013-04-22 08:43:33');

/*Table structure for table `users` */

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `UserId` int(10) unsigned NOT NULL auto_increment,
  `UserTypeId` int(10) unsigned NOT NULL,
  `FirstName` varchar(50) NOT NULL default '',
  `LoginId` varchar(50) NOT NULL default '',
  `Password` varchar(50) NOT NULL default '',
  `Mobile` varchar(20) NOT NULL default '',
  `EmailId` varchar(100) NOT NULL default '',
  `CreatedDate` datetime NOT NULL,
  `CreatedBy` int(10) unsigned default NULL,
  `LastName` varchar(50) default NULL,
  `ParentId` int(10) unsigned default NULL,
  `ParentTypeId` int(10) unsigned default NULL,
  `LogoPath` varchar(100) default NULL,
  `AgeGroupId` int(4) unsigned default NULL,
  PRIMARY KEY  (`UserId`),
  KEY `FK_Users_UserTypes` (`UserTypeId`),
  KEY `FK_users` (`ParentId`),
  KEY `FK_users_parenttypes` (`ParentTypeId`),
  KEY `FK_users_ages` (`AgeGroupId`),
  CONSTRAINT `FK_users_ages` FOREIGN KEY (`AgeGroupId`) REFERENCES `ages` (`agegroupid`),
  CONSTRAINT `FK_Users_UserTypes` FOREIGN KEY (`UserTypeId`) REFERENCES `usertypes` (`UserTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `users` */

insert  into `users`(`UserId`,`UserTypeId`,`FirstName`,`LoginId`,`Password`,`Mobile`,`EmailId`,`CreatedDate`,`CreatedBy`,`LastName`,`ParentId`,`ParentTypeId`,`LogoPath`,`AgeGroupId`) values (1,1,'dayakar','dayakar','sairam','8019520736','dayakar@iyouse.com','2013-01-31 17:05:27',0,'pm',NULL,NULL,'../../Content/images/q.png',NULL),(2,5,'sairam','sairam','sairam','8888888888','daya.sssihl@yahoo.com','2013-01-24 22:48:48',1,'sri',NULL,NULL,'../../Content/images/q.png',NULL),(3,2,'madhuri','madhuri','sairam','9898989898','daya.bits@yahoo.com','2013-01-31 17:05:27',1,'m',NULL,NULL,'../../Content/images/q.png',NULL),(4,3,'dennis','dennis','sairam','665444456','dennis@yahoo.com','2013-02-01 21:37:42',1,'ritchie',NULL,NULL,'../../Content/images/q.png',NULL),(5,5,'student1','student1','sairam','9773443','student1@yahoo.com','2013-02-06 23:49:25',1,'student1',NULL,NULL,'../../Content/images/q.png',NULL),(6,5,'student2','student2@yahoo.com','sairam','5464564','student2@yahoo.com','2013-02-06 23:55:30',1,'student2',4,0,'../../Content/images/q.png',NULL),(7,5,'student3','student3','sairam','8455','student3@yahoo.com','2013-02-06 23:58:35',1,'student3',4,0,'../../Content/images/q.png',3),(9,5,'student123','student123','sairam','9192939495','student123@yahoo.com','2013-02-25 11:03:52',1,'madh',4,0,'../../Content/images/q.png',NULL),(10,3,'Dave','dave.monk@freescale.com','freescale','6025094897','dave.monk@freescale.com','2013-03-12 20:56:47',1,'Monk',2,0,'../../Content/images/freescale.png',NULL),(11,5,'Stephen','stephen.king@inin.com','sairam','1234567890','stephen.king@inin.com','2013-03-12 21:00:37',1,'King',10,0,'../../Content/images/q.png',NULL);

/*Table structure for table `usertypes` */

DROP TABLE IF EXISTS `usertypes`;

CREATE TABLE `usertypes` (
  `UserTypeId` int(10) unsigned NOT NULL auto_increment,
  `UserType` varchar(50) NOT NULL default '',
  `Description` varchar(500) default NULL,
  `CreatedDate` datetime default NULL,
  `Parent` varchar(50) NOT NULL default '',
  `Level` int(10) unsigned default NULL,
  PRIMARY KEY  (`UserTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usertypes` */

insert  into `usertypes`(`UserTypeId`,`UserType`,`Description`,`CreatedDate`,`Parent`,`Level`) values (1,'Admin','admin','2012-08-18 10:09:39','',0),(2,'Sales','','2012-08-18 10:11:13','Admin',1),(3,'CAM','','2012-08-18 10:11:23','Sales',2),(4,'Supervisor','','2012-08-18 10:11:32','CAM',3),(5,'Student','','2012-08-18 10:11:32','Supervisor',4),(6,'Vendor','','2012-08-18 10:11:32','Sales',3);

/* Procedure structure for procedure `AddAssessment` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddAssessment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddAssessment`(IN p_StudentId INT, IN p_LessonId INT,in p_QuestionsPresent INT, in p_QuestionsAnswered INT,
		in p_QuestionsCorrect INT,  IN p_Score INT, p_IsCompleted INT, p_QuantaPoints INT)
BEGIN
	insert into `assessments`(`StudentId`,`LessonId`,`QuestionsPresent`,`QuestionsAnswered`,`QuestionsCorrect`,`Score`,`IsCompleted`,`QuantaPoints`)
	values(p_StudentId,p_LessonId,p_QuestionsPresent,p_QuestionsAnswered,p_QuestionsCorrect,p_Score,p_IsCompleted,p_QuantaPoints);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddFeedback` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddFeedback` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddFeedback`(in p_FeedbackTypeId INT, in p_Description varchar(500),
		in p_EmailId varchar(50),  IN p_UserId INT, p_LessonId INT)
BEGIN
	insert into `feedback`(`FeedbackType`,`Description`,`EmailId`,`GivenDate`,`UserId`,`LessonId`)
	values(p_FeedbackTypeId,p_Description,p_EmailId,NOW(),p_UserId,p_LessonId);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddStudentAnswer` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddStudentAnswer` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddStudentAnswer`(IN p_StudentId INT, IN p_QuestionId INT, IN p_GivenAnswer VARCHAR(20), IN p_LessonId INT)
BEGIN
	insert into `studentanswers`(`StudentId`,`QuestionId`,`GivenAnswer`,`LessonId`)
	values (p_StudentId,p_QuestionId,p_GivenAnswer, p_LessonId);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddStudentLesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddStudentLesson` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddStudentLesson`(IN p_StudentId int,IN p_LessonId INT,IN p_RegistrationDate datetime,IN p_UnRegistrationDate DATETIME,
	IN p_StatusId INT,IN p_AssessmentId INT,IN p_StartedDate DATETIME,IN p_LastLaunchDate DATETIME)
BEGIN
insert into `studentlessons` 
(`StudentId`,`LessonId`,`RegistrationDate`,`UnRegistrationDate`,`Status`,`AssessmentId`,`StartedDate`,`LastLaunchDate`)
    values (
    p_StudentId, p_LessonId, NOW(), p_UnRegistrationDate, p_StatusId, p_AssessmentId,p_StartedDate,p_LastLaunchDate);
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddUserDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddUserDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddUserDetails`( p_UserTypeId int, p_LoginId varchar(50),p_FirstName VARCHAR(50),p_LastName VARCHAR(50),
	 p_Password varchar(50), p_EmailId varchar(100), p_Mobile varchar(20), p_CreatedBy INT,p_CreatedDate datetime, 
	 p_ParentId INT, p_ParentTypeId INT, p_LogoPath VARCHAR(100), p_AgeGroupId INT)
BEGIN
insert into users(`UserTypeId`,`LoginId`,`FirstName`,`LastName`,`Password`,`EmailId`,`Mobile`,`CreatedBy`,`CreatedDate`,
`ParentId`,`ParentTypeId`,`LogoPath`,`AgeGroupId`)
    values (
    p_UserTypeId,
    p_LoginId,
    p_FirstName,
    p_LastName,
    p_Password,
    p_EmailId,
    p_Mobile,
    p_CreatedBy,
    p_CreatedDate,
    p_ParentId,
    p_ParentTypeId,
    p_LogoPath,
    p_AgeGroupId
    );
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddUsertype` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddUsertype` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddUsertype`(in p_UserType varchar(45), in p_Description varchar(500),
		in p_Parent varchar(45), in p_level int)
BEGIN
	insert into `usertypes`(`UserType`,`Description`,`CreatedDate`,`Parent`,`level`)
	values(p_UserType,p_Description,curdate(),p_Parent,p_level);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `CanUserChangePass` */

/*!50003 DROP PROCEDURE IF EXISTS  `CanUserChangePass` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `CanUserChangePass`(IN p_LoginID VARCHAR(50), IN p_Password VARCHAR(50))
BEGIN
	SELECT `UserId`
	FROM `users`
	WHERE `LoginId` = p_LoginId AND `Password` = p_Password;	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `ChangePassword` */

/*!50003 DROP PROCEDURE IF EXISTS  `ChangePassword` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `ChangePassword`(p_LoginId INT, p_Password VARCHAR(50))
BEGIN
	UPDATE `users` 
	SET  
	     `Password` = p_Password
	WHERE `LoginId` = p_LoginId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteAllStudentAnswers` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteAllStudentAnswers` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteAllStudentAnswers`(in p_StudentId int)
BEGIN
	delete from `studentanswers` where `StudentId` = p_StudentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteAssessment` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteAssessment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteAssessment`(in p_AssessmentId int)
BEGIN
	DELETE FROM `assessments` WHERE `AssessmentId` = p_AssessmentId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteStudent` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteStudent` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteStudent`(in p_UserId int)
BEGIN
DELETE FROM `studentanswers` WHERE `StudentId` = p_UserId;
	DELETE FROM `studentlessons` WHERE `StudentId` = p_UserId;
	DELETE FROM `assessments` WHERE `StudentId` = p_UserId;
	Delete from `users` where `UserId` = p_UserId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteStudentAnswer` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteStudentAnswer` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteStudentAnswer`(in p_StudentId int, IN p_QuestionId INT)
BEGIN
	delete from `studentanswers` where `StudentId` = p_StudentId AND `QuestionId` = p_QuestionId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteStudentLesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteStudentLesson` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteStudentLesson`(in p_StudentId int, IN p_LessonId INT)
BEGIN
	delete from `studentlessons` where `StudentId` = p_StudentId AND `LessonId` = p_LessonId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteUser` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteUser`(in p_UserId int)
BEGIN
	delete from `users` where `UserId` = p_UserId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteUsertype` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteUsertype` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteUsertype`(in p_UserTypeId int)
BEGIN
	delete from `usertypes` where `UserTypeId` = p_UserTypeId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAgeGroups` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAgeGroups` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAgeGroups`()
BEGIN
	SELECT `agegroupid`,`agegroup`
	FROM `ages`;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAllCustomerRegisteredLessons` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAllCustomerRegisteredLessons` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAllCustomerRegisteredLessons`( IN p_CustomerId INT)
BEGIN
	SELECT
    `customerslessons`.`CustomerLessonId`
    , `customerslessons`.`CustomerId`
    , `customerslessons`.`LessonId`
    , `customerlessonstatus`.`Status`
    , `customerslessons`.`OrderNumber`
    , `customerslessons`.`RegistrationDate`
    , `customerslessons`.`ValidTill`
    , `customerslessons`.`OrderDate`
    , `customerslessons`.`OrderPrice`
    , `customerslessons`.`IsAssessed`
    , `customerslessons`.`TotalSeatLicenses`
    , `customerslessons`.`UsedSeatLicenses`
    , `customerslessons`.`IsQuantaChallengeOptional`
    , `lessons`.`LessonName`
    , `lessons`.`Description`
    , `lessons`.`ThumbPath`
    , `lessons`.`VideoPath`
    , `lessons`.`Duration`
    , `lessons`.`QuantaPoints`
FROM
    `quantaed`.`customerslessons`
    INNER JOIN `quantaed`.`customerlessonstatus` 
        ON (`customerslessons`.`CustomerLessonStatusId` = `customerlessonstatus`.`CustomerLessonStatusId`)
    INNER JOIN `quantaed`.`lessons` 
        ON (`customerslessons`.`LessonId` = `lessons`.`LessonId`)
    WHERE `customerslessons`.`CustomerId` = p_CustomerId 
GROUP BY `lessons`.`LessonName` ;
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAllLessons` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAllLessons` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAllLessons`()
BEGIN
	SELECT `LessonId`,`LessonName`,`VideoPath`,`AddedDate`,`ThumbPath`,`Description`,`Duration`,`QuantaPoints`
	FROM `lessons`;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAllStudentAnswers` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAllStudentAnswers` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAllStudentAnswers`(IN p_StudentId INT, IN p_LessonId INT)
BEGIN
	SELECT `StudentAnswerId`,`StudentId`,`QuestionId`,`GivenAnswer`,`LessonId`
	FROM `studentanswers`
	where `StudentId` = p_StudentId AND `LessonId` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAllStudentRegisteredLessons` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAllStudentRegisteredLessons` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAllStudentRegisteredLessons`( IN p_StudentId INT)
BEGIN
	SELECT
    `studentlessons`.`StudentLessonId`,
    `studentlessons`.`StudentId`,
    `studentlessons`.`LessonId`,
    `studentlessons`.`RegistrationDate`,
    `studentlessons`.`UnRegistrationDate`,
    `studentlessons`.`AssessmentId`,
    `studentlessons`.`Status`
    , `lessons`.`LessonName`
    , `lessons`.`Description`
    , `lessons`.`ThumbPath`
    , `lessons`.`VideoPath`
    , `lessons`.`Duration`
    , `lessons`.`QuantaPoints`
FROM
    `quantaed`.`studentlessons`
    INNER JOIN `quantaed`.`lessons` 
        ON (`studentlessons`.`LessonId` = `lessons`.`LessonId`)
    WHERE `studentlessons`.`StudentId` = p_StudentId 
GROUP BY `lessons`.`LessonName` ;
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetAssessment` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetAssessment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetAssessment`(IN p_StudentId INT,IN p_LessonId INT)
BEGIN
	SELECT `AssessmentId`,`StudentId`,`LessonId`,`QuestionsPresent`,`QuestionsAnswered`,`QuestionsCorrect`,
	`Score`,`IsCompleted`,`CompletionDate`,`QuantaPoints`
	FROM `assessments`
	where `StudentId` = p_StudentId AND `LessonId` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetCustomerLesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetCustomerLesson` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetCustomerLesson`( IN p_CustomerId INT, IN p_LessonId INT)
BEGIN
	SELECT
    `customerslessons`.`CustomerLessonId`
    , `customerslessons`.`CustomerId`
    , `customerslessons`.`LessonId`
    , `customerslessons`.`OrderNumber`
    , `customerslessons`.`RegistrationDate`
    , `customerslessons`.`ValidTill`
    , `customerslessons`.`OrderDate`
    , `customerslessons`.`OrderPrice`
    , `customerslessons`.`IsAssessed`
    , `customerslessons`.`TotalSeatLicenses`
    , `customerslessons`.`UsedSeatLicenses`
    , `customerslessons`.`IsQuantaChallengeOptional`
    , `lessons`.`LessonName`
    , `lessons`.`Description`
    , `lessons`.`ThumbPath`
    , `lessons`.`VideoPath`
    , `lessons`.`Duration`
FROM
    `quantaed`.`customerslessons`
    INNER JOIN `quantaed`.`lessons` 
        ON (`customerslessons`.`LessonId` = `lessons`.`LessonId`)
    WHERE `customerslessons`.`LessonId` = p_LessonId and `customerslessons`.`CustomerId`=p_CustomerId
GROUP BY `lessons`.`LessonName` ;
		
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetCustomerRegisteredLessonsWithStatus` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetCustomerRegisteredLessonsWithStatus` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetCustomerRegisteredLessonsWithStatus`( IN p_CustomerId INT, IN p_CustomerLessonStatusId INT)
BEGIN
	SELECT
    `customerslessons`.`CustomerLessonId`
    , `customerslessons`.`CustomerId`
    , `customerslessons`.`LessonId`
    , `customerlessonstatus`.`Status`
    , `customerslessons`.`OrderNumber`
    , `customerslessons`.`RegistrationDate`
    , `customerslessons`.`OrderDate`
    , `customerslessons`.`OrderPrice`
    , `customerslessons`.`IsAssessed`
    , `customerslessons`.`IsQuantaChallengeOptional`
    , `lessons`.`LessonName`
    , `lessons`.`Description`
    , `lessons`.`ThumbPath`
    , `lessons`.`VideoPath`
    , `lessons`.`Duration`
FROM
    `quantaed`.`customerslessons`
    INNER JOIN `quantaed`.`customerlessonstatus` 
        ON (`customerslessons`.`CustomerLessonStatusId` = `customerlessonstatus`.`CustomerLessonStatusId`)
    INNER JOIN `quantaed`.`lessons` 
        ON (`customerslessons`.`LessonId` = `lessons`.`LessonId`)
    WHERE `customerslessons`.`CustomerId` = p_CustomerId AND `customerslessons`.`CustomerLessonStatusId` = p_CustomerLessonStatusId
GROUP BY `lessons`.`LessonName` ;
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetFeedbackTypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetFeedbackTypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetFeedbackTypes`()
BEGIN
	SELECT `FeedbackTypeId`,`FeedbackName`
	FROM `feedbacktypes`;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLessonById` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLessonById` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLessonById`(IN p_LessonId INT)
BEGIN
	SELECT `LessonId`,`LessonName`,`VideoPath`,`AddedDate`,`ThumbPath`,`Description`,`Duration`,`QuantaPoints`
	FROM `lessons`
	WHERE `LessonId` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLessonObjectivesByLessonId` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLessonObjectivesByLessonId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLessonObjectivesByLessonId`(IN p_LessonId INT)
BEGIN
	SELECT `LOId`,`Lessonid`,`objective1`,`objective2`,`objective3`,`objective4`,`objective5`,
	`objective6`,`objective7`,`objective8`,`objective9`,`objective10`,
	`objective11`,`objective12`,`objective13`,`objective14`,`objective15`
	FROM `lessonobjectives`
	WHERE `Lessonid` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLessonOutlineByLessonId` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLessonOutlineByLessonId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLessonOutlineByLessonId`(IN p_LessonId INT)
BEGIN
	SELECT `OutlineId`,`Lessonid`,`outline1`,`outline2`,`outline3`,`outline4`,`outline5`,
	`outline6`,`outline7`,`outline8`,`outline9`,`outline10`,
	`outline11`,`outline12`,`outline13`,`outline14`,`outline15`,
	`outline16`,`outline17`,`outline18`,`outline19`,`outline20`,
	`outline21`,`outline22`,`outline23`,`outline24`,`outline25`
	FROM `lessonoutline`
	WHERE `Lessonid` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetQuestions` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetQuestions` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetQuestions`(IN p_LessonId INT)
BEGIN
	SELECT `QuestionId`,`ActualQuestion`,`A`,`B`,`C`,`D`,`E`,`ActualAnswer`,`QuestionImagePath`,
	`AImagePath`,`BImagePath`,`CImagePath`,`DImagePath`,`EImagePath`,`LessonId`
	FROM `questions`
	where `LessonId` = p_LessonId
	ORDER BY `QuestionId`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetStudentAnswer` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetStudentAnswer` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetStudentAnswer`(IN p_StudentId INT, IN p_QuestionId INT)
BEGIN
	SELECT `StudentAnswerId`,`StudentId`,`QuestionId`,`GivenAnswer`,`LessonId`
	FROM `studentanswers`
	where `StudentId` = p_StudentId AND `QuestionId` = p_QuestionId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetStudentLesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetStudentLesson` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetStudentLesson`(IN p_StudentId INT, IN p_LessonId INT)
BEGIN
	SELECT `StudentLessonId`,`StudentId`,`LessonId`,`RegistrationDate`,`Status`,`AssessmentId`,`StartedDate`,`LastLaunchDate`
	FROM `studentlessons`
	where `StudentId` = p_StudentId AND `LessonId` = p_LessonId;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetStudentRegisteredLessonsWithStatus` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetStudentRegisteredLessonsWithStatus` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetStudentRegisteredLessonsWithStatus`( IN p_StudentId INT, IN p_Status INT)
BEGIN
	SELECT
    `studentlessons`.`StudentLessonId`,
    `studentlessons`.`StudentId`,
    `studentlessons`.`LessonId`,
    `studentlessons`.`RegistrationDate`,
    `studentlessons`.`UnRegistrationDate`,
    `studentlessons`.`AssessmentId`,
    `studentlessons`.`Status`
    , `lessons`.`LessonName`
    , `lessons`.`Description`
    , `lessons`.`ThumbPath`
    , `lessons`.`VideoPath`
    , `lessons`.`Duration`
FROM
    `quantaed`.`studentlessons`
    INNER JOIN `quantaed`.`customerlessonstatus` 
        ON (`studentlessons`.`Status` = `customerlessonstatus`.`CustomerLessonStatusId`)
    INNER JOIN `quantaed`.`lessons` 
        ON (`studentlessons`.`LessonId` = `lessons`.`LessonId`)
    WHERE `studentlessons`.`StudentId` = p_StudentId AND `studentlessons`.`Status` = p_Status
GROUP BY `lessons`.`LessonName` ;
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserByIdOrName` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserByIdOrName` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserByIdOrName`(IN p_LoginId VARCHAR(50), in p_UserId int)
BEGIN
	SELECT `UserId`,`UserTypeID`,`LoginId`,`FirstName`,`LastName`,`Password`,`EmailID`,`Mobile`,
	`CreatedBy`,`CreatedDate`,`ParentId`,`ParentTypeId`,`LogoPath`,`AgeGroupId`
	FROM `users`
	where `UserId` = p_UserId OR `LoginId` = p_LoginId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserdetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserdetails`()
BEGIN
	SELECT `UserId`,`UserTypeID`,`LoginId`,`FirstName`,`LastName`,`EmailID`,`Mobile`,`CreatedBy`,`CreatedDate`,`ParentId`,`ParentTypeId`, `LogoPath`,`AgeGroupId`
	FROM `users`;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUsersByParentId` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUsersByParentId` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUsersByParentId`(in p_UserId int)
BEGIN
	SELECT `UserId`,`UserTypeID`,`LoginId`,`FirstName`,`LastName`,`Password`,`EmailID`,`Mobile`,`CreatedBy`,`CreatedDate`,`ParentId`,`ParentTypeId` 
	FROM `users`
	where `ParentId` = p_UserId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserTypeByIdOrName` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserTypeByIdOrName` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserTypeByIdOrName`(IN p_UserType VARCHAR(50),in p_UserTypeId int)
BEGIN
	SELECT `UserTypeId`,`UserType`,`Description`,`CreatedDate`,`Parent`,`level` FROM `usertypes`
	where `UserTypeId` = p_UserTypeId OR `UserType` = p_UserType;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserTypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserTypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserTypes`()
BEGIN
	select `UserTypeId`,`UserType` from `usertypes`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `IsUserExists` */

/*!50003 DROP PROCEDURE IF EXISTS  `IsUserExists` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `IsUserExists`(IN p_LoginID VARCHAR(50), IN p_EmailId VARCHAR(100),IN p_Mobile VARCHAR(20))
BEGIN
	select `UserId` 
	FROM `users`
	WHERE `LoginId` = p_LoginID OR `EmailId` = p_EmailId OR `Mobile` = p_Mobile;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `IsValidUser` */

/*!50003 DROP PROCEDURE IF EXISTS  `IsValidUser` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `IsValidUser`(IN p_LoginID VARCHAR(50), IN p_EmailId VARCHAR(100))
BEGIN
	select `UserId` 
	FROM `users`
	WHERE `LoginId` = p_LoginID AND `EmailId` = p_EmailId ;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `Login` */

/*!50003 DROP PROCEDURE IF EXISTS  `Login` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `Login`(IN p_LoginId VARCHAR(50), IN p_Password VARCHAR(50))
BEGIN
	SELECT `UserId`,`UserTypeId`,`LoginId`,`FirstName`,`LastName`,`EmailId`,`Mobile`,`CreatedBy`,`CreatedDate`,`ParentId`,`ParentTypeId`,`LogoPath`
	FROM `users`
	WHERE `LoginId` = p_LoginId AND `Password` = p_Password;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateAssessment` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateAssessment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateAssessment`(IN p_AssessmentId INT,IN p_StudentId INT, IN p_LessonId INT, IN p_QuestionsPresent INT, IN p_QuestionsAnswered INT,
		IN p_QuestionsCorrect INT,  IN p_Score INT, IN p_IsCompleted INT, IN p_CompletionDate datetime, IN p_QuantaPoints INT)
BEGIN
	UPDATE `assessments` 
	SET  
	`StudentId` = p_StudentId,
	`LessonId` = p_LessonId,
	`QuestionsPresent` = p_QuestionsPresent,
	`QuestionsAnswered` = p_QuestionsAnswered,
	`QuestionsCorrect` = p_QuestionsCorrect,
	`Score` = p_Score,
	`IsCompleted` = p_IsCompleted,
	`CompletionDate` = p_CompletionDate,
	`QuantaPoints` = p_QuantaPoints
	WHERE `AssessmentId` = p_AssessmentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateCustomerLessonLicensesCount` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateCustomerLessonLicensesCount` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateCustomerLessonLicensesCount`(p_CustomerLessonId INT, p_UsedSeatLicenses int)
BEGIN
UPDATE `customerslessons`
    SET `UsedSeatLicenses` = p_UsedSeatLicenses
    WHERE `CustomerLessonId` = p_CustomerLessonId;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateStudentAnswer` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateStudentAnswer` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateStudentAnswer`(p_StudentAnswerId INT, p_StudentId int, p_QuestionId INT, p_GivenAnswer VARCHAR(20), p_LessonId INT)
BEGIN
UPDATE `studentanswers`
    SET 
    `StudentId` = p_StudentId,
    `QuestionId` =  p_QuestionId,
    `GivenAnswer` = p_GivenAnswer,
    `LessonId` = p_LessonId
    where `StudentAnswerId` = p_StudentAnswerId;
    
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateStudentLesson` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateStudentLesson` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateStudentLesson`(p_StudentLessonId INT, p_StudentId int, p_LessonId INT, p_RegistrationDate datetime, p_UnRegistrationDate DATETIME,
	 p_StatusId INT, p_AssessmentId INT,IN p_StartedDate DATETIME,IN p_LastLaunchDate DATETIME)
BEGIN
UPDATE `studentlessons`
    SET 
    `StudentId` = p_StudentId,
    `LessonId` = p_LessonId,
    `RegistrationDate` = p_RegistrationDate,
    `UnRegistrationDate` = p_UnRegistrationDate,
    `Status` = p_StatusId,
    `AssessmentId` = p_AssessmentId,
    `StartedDate` = p_StartedDate,
    `LastLaunchDate` = p_LastLaunchDate
    where `StudentLessonId` = p_StudentLessonId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateUserDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateUserDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateUserDetails`(p_UserId INT, p_UserTypeId INT, p_FirstName VARCHAR(50),p_LastName VARCHAR(50),p_LoginId VARCHAR(50),
	 p_Password VARCHAR(50), p_EmailId VARCHAR(100), p_Mobile VARCHAR(20), p_AgeGroupId INT)
BEGIN
	UPDATE `users` 
	SET  `UserTypeID` = p_UserTypeID,
	     `FirstName` = p_FirstName,
	     `LastName` = p_LastName,
	     `LoginId` = p_LoginId,
	     `Password` = p_Password,
	     `EmailId` = p_EmailId,
	     `Mobile` = p_Mobile,
	     `AgeGroupId` = p_AgeGroupId
	WHERE `UserId` = p_UserId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateUsertype` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateUsertype` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateUsertype`(in p_UserTypeId int, in p_UserType varchar(45),
		in p_Description varchar(500), in p_Parent varchar(45), in p_level int)
BEGIN
	update `usertypes` 
	set `UserType`=p_UserType, 
		`Description`= p_Description,
		`Parent` = p_Parent, 
		`level` = p_level 
	where `UserTypeId` = p_UserTypeId;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
