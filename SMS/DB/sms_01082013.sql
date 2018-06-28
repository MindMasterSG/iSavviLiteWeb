/*
SQLyog Ultimate v8.82 
MySQL - 5.0.19-nt : Database - sms
*********************************************************************
*/

/*!40101 SET NAMES utf8 */;

/*!40101 SET SQL_MODE=''*/;

/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;
CREATE DATABASE /*!32312 IF NOT EXISTS*/`sms` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `sms`;

/*Table structure for table `companies` */

DROP TABLE IF EXISTS `companies`;

CREATE TABLE `companies` (
  `CompanyId` int(10) unsigned NOT NULL auto_increment,
  `CompanyName` varchar(100) default NULL,
  `Address` varchar(500) default NULL,
  `ContactNumber` varchar(15) default NULL,
  `DeploymentId` int(10) default NULL,
  PRIMARY KEY  (`CompanyId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `companies` */

insert  into `companies`(`CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId`) values (2,'Keerti Technologies','Hyd','',2),(3,'Microsoft','HYD','999998888',1),(4,'Company 5656','HYD','234566',2),(5,'WESTMERE EXEC CONDO','','',8),(7,'WISMA','520 , north beach road , ','63343565',11),(8,'Henderson 203','','62744845',9),(18,'B698','Changi Court','',10),(19,'B700','Changi Court','',10),(20,'B702','Changi Court','',10),(21,'B704','Changi Court','',10),(22,'B706','Changi Court','',10),(23,'B708','Changi Court','',10),(24,'B710','Management Office','',10);

/*Table structure for table `deployments` */

DROP TABLE IF EXISTS `deployments`;

CREATE TABLE `deployments` (
  `DeploymentId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentName` varchar(100) NOT NULL,
  `Description` varchar(500) default NULL,
  `AddedDate` datetime default NULL,
  `ClientName` varchar(100) default NULL,
  `Address` varchar(200) default NULL,
  PRIMARY KEY  (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `deployments` */

insert  into `deployments`(`DeploymentId`,`DeploymentName`,`Description`,`AddedDate`,`ClientName`,`Address`) values (1,'Hyd Public',NULL,'2012-12-31 00:00:00','HYD Govt','Somajiguda HYD'),(2,'KV',NULL,'2013-01-28 00:00:00','K V','K V Gachibowli'),(4,'CA',NULL,'2013-03-18 00:00:00','CA Technologies','Hyderbad'),(5,'TPTY',NULL,'2013-03-21 00:00:00','HDFC','T.K Road'),(8,'WESTMERE EXEC CONDO',NULL,'2013-06-02 00:00:00','SMA SECURITY SERVICES','NO 75 JURONG EAST ST 13'),(9,'HENDERSON',NULL,'2013-06-26 00:00:00','HENDERSON','HENDERSON'),(10,'COURT',NULL,'2013-06-26 00:00:00','COURT','COURT'),(11,'WISMA',NULL,'2013-06-26 00:00:00','WISMA','WISMA');

/*Table structure for table `eventmasterlist` */

DROP TABLE IF EXISTS `eventmasterlist`;

CREATE TABLE `eventmasterlist` (
  `eventid` int(10) unsigned NOT NULL auto_increment,
  `startdate` datetime default NULL,
  `enddate` datetime default NULL,
  `locationid` int(10) unsigned default NULL,
  `numberofguards` int(4) default NULL,
  `specialdutyforguard` varchar(100) default NULL,
  `eventname` varchar(200) default NULL,
  `notes` varchar(500) default NULL,
  `optionalguestlist` varchar(2000) default NULL,
  `personinchargename` varchar(100) default NULL,
  `personinchargenric` varchar(100) default NULL,
  `personinchargecontactnumber` varchar(20) default NULL,
  `DeploymentId` int(10) unsigned default NULL,
  `Remarks` varchar(500) default NULL,
  PRIMARY KEY  (`eventid`),
  KEY `FK_eventmasterlist` (`locationid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `eventmasterlist` */

insert  into `eventmasterlist`(`eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`,`DeploymentId`,`Remarks`) values (2,'2013-08-01 13:35:00','2013-08-01 19:19:00',2,8,'3','Wedding','Birth day','afsda','99999','99999','33333',1,''),(3,'2013-04-01 10:00:00','2013-04-01 12:00:00',1,0,'','reception','','','','','989898998',1,''),(4,'2013-06-01 16:00:00','2013-06-01 21:00:00',2,10,'','Reception','','','1234555','1234555','99999999',2,'');

/*Table structure for table `events` */

DROP TABLE IF EXISTS `events`;

CREATE TABLE `events` (
  `EventId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `EventName` varchar(100) NOT NULL default '',
  `EventDate` datetime default NULL,
  `Remarks` varchar(500) default NULL,
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`EventId`),
  KEY `FK_events_1` (`DeploymentId`),
  CONSTRAINT `FK_events_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `events` */

/*Table structure for table `gates` */

DROP TABLE IF EXISTS `gates`;

CREATE TABLE `gates` (
  `GateId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `GateName` varchar(100) NOT NULL default '',
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`GateId`),
  KEY `FK_gates_1` (`DeploymentId`),
  CONSTRAINT `FK_gates` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `gates` */

insert  into `gates`(`GateId`,`DeploymentId`,`GateName`,`AddedDate`) values (1,1,'Gate 444','2013-01-24 00:00:00'),(2,2,'Gate 88','2013-01-25 00:00:00'),(4,2,'Gate 786','2013-02-06 00:00:00');

/*Table structure for table `incidents` */

DROP TABLE IF EXISTS `incidents`;

CREATE TABLE `incidents` (
  `incidentid` int(10) NOT NULL auto_increment,
  `reportdate` datetime default NULL,
  `natureofincident` varchar(20) default NULL,
  `dateofincident` datetime default NULL,
  `locationid` int(10) unsigned default NULL,
  `particularsofpersons` varchar(500) default NULL,
  `briefdescription` varchar(500) default NULL,
  `remarksandactionstaken` varchar(500) default NULL,
  `snapshotpath` varchar(100) default NULL,
  `deploymentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`incidentid`),
  KEY `FK_incidents` (`locationid`),
  KEY `FK_incidents_d` (`deploymentid`),
  CONSTRAINT `FK_incidents_d` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `incidents` */

insert  into `incidents`(`incidentid`,`reportdate`,`natureofincident`,`dateofincident`,`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`,`snapshotpath`,`deploymentid`) values (1,'2013-04-21 16:27:10','Stolen','2013-02-24 00:00:00',2,'qwerqwr','This incident','sdfasfsf','../Snapshots/2013421162718741.png',2),(3,'2013-03-21 09:15:57','car','2012-01-04 10:24:00',1,'id=\"incidentTime\"','','','~/Content/images/incident.jpg',2),(8,'2013-03-21 21:00:19','bus accident','2013-01-15 11:17:00',1,'hari','','','~/Content/images/incident.jpg',4),(9,'2013-03-22 07:37:48','theft','2013-04-20 16:19:00',1,'raj','','','~/Content/images/incident.jpg',4),(10,'2013-06-26 16:24:14','Good work','2013-01-01 00:00:00',4,'','','',NULL,2),(11,'2013-06-26 16:25:14','appreciation','2013-07-17 16:17:00',4,'','','',NULL,2),(14,'2013-07-10 11:59:43','test','2013-10-07 12:00:00',6,'test i am testing , i am testing ','test i am testing , i am testingtest i am testing , i am testingtest i am testing , i am testingtest i am testing , i am testingtest i am testing , i am testing','test i am testing , i am testingtest i am testing , i am testingtest i am testing , i am testingtest i am testing , i am testing','~/Content/images/incident.jpg',11);

/*Table structure for table `keys` */

DROP TABLE IF EXISTS `keys`;

CREATE TABLE `keys` (
  `KeyId` int(10) unsigned NOT NULL auto_increment,
  `KeyName` varchar(45) NOT NULL default '',
  `DeploymentId` int(10) unsigned NOT NULL,
  `Status` int(10) unsigned default NULL,
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`KeyId`),
  KEY `FK_keys_1` (`DeploymentId`),
  KEY `FK_keys` (`Status`),
  CONSTRAINT `FK_keys` FOREIGN KEY (`Status`) REFERENCES `keystatuses` (`StatusID`),
  CONSTRAINT `FK_keys_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `keys` */

insert  into `keys`(`KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate`) values (2,'New key',2,1,'2013-03-20 00:00:00');

/*Table structure for table `keystatuses` */

DROP TABLE IF EXISTS `keystatuses`;

CREATE TABLE `keystatuses` (
  `StatusID` int(3) unsigned NOT NULL auto_increment,
  `StatusType` varchar(30) default NULL,
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`StatusID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `keystatuses` */

insert  into `keystatuses`(`StatusID`,`StatusType`,`AddedDate`) values (1,'Stolen','2013-03-19 00:00:00'),(2,'Broken','2013-03-19 00:00:00'),(3,'Working','2013-03-19 00:00:00');

/*Table structure for table `locations` */

DROP TABLE IF EXISTS `locations`;

CREATE TABLE `locations` (
  `LocationId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `LocationName` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`LocationId`),
  KEY `FK_locations_1` (`DeploymentId`),
  CONSTRAINT `FK_locations_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `locations` */

insert  into `locations`(`LocationId`,`DeploymentId`,`LocationName`) values (1,2,'Location 111'),(4,2,'Rajahmundry'),(6,11,'WISMA'),(7,8,'SINGAPORE'),(8,9,'HENDERSON'),(10,10,'B700'),(11,10,'B702'),(12,10,'B704'),(13,10,'B706'),(14,10,'B708'),(16,10,'B698'),(17,10,'B710');

/*Table structure for table `lostandfound` */

DROP TABLE IF EXISTS `lostandfound`;

CREATE TABLE `lostandfound` (
  `lostandfoundreportid` int(10) NOT NULL auto_increment,
  `nameofperson` varchar(100) default NULL,
  `nric` varchar(30) default NULL,
  `reporteddate` datetime default NULL,
  `remarks` varchar(500) default NULL,
  `deploymentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`lostandfoundreportid`),
  KEY `FK_lostandfound` (`deploymentid`),
  CONSTRAINT `FK_lostandfound` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `lostandfound` */

insert  into `lostandfound`(`lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid`) values (1,'V Sriram','23456','2013-02-14 00:00:00','this is testing for eding',NULL),(2,'csr','12344','2013-03-02 00:00:00','water bottle stolen',NULL),(3,'Subbarao','12333','2003-10-09 00:00:00','he lost his head phones',NULL),(4,'csr','12322','2013-03-11 00:00:00','lkdjfsalkfjdlf',NULL),(5,'Raj','233333','2013-01-05 00:00:00','Car keys lost',1),(6,'Harry','88888','2013-01-05 00:00:00','Parked ticket',1),(9,'SO Razak','SMA Security Service','2013-07-09 00:00:00','Whilst checking at the Gymnasium at about 1945hrs, SO Razak found a hand phone :Brand: Nokia, Model: C3-00, Color : Beige.\r\nThe hand phone was handed over to SS Jahari for safekeeping pending claim.\r\nAt about 2140hrs Mr.Manjeet from B702 #10-08 came to guard room and inquired about his lost hand phone after describing the brand and model of his hand phone SS Kamal handed over the found hand phone to Mr.Manjeet.',10);

/*Table structure for table `occurances` */

DROP TABLE IF EXISTS `occurances`;

CREATE TABLE `occurances` (
  `occuranceid` int(10) NOT NULL auto_increment,
  `serialnumber` varchar(20) default NULL,
  `reportdate` datetime default NULL,
  `occurancetype` varchar(15) default NULL,
  `notes` varchar(3000) default NULL,
  `important` tinyint(1) default NULL,
  `heading` varchar(500) default NULL,
  `deploymentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`occuranceid`),
  KEY `FK_occurances` (`deploymentid`),
  CONSTRAINT `FK_occurances` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `occurances` */

insert  into `occurances`(`occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`) values (1,NULL,'2013-03-05 00:00:00',NULL,'231412343241',0,'First Occurance',NULL),(3,NULL,'2013-08-03 00:00:00',NULL,'Need to follow up',1,'GoodWork',NULL),(9,NULL,'2013-03-22 16:12:54',NULL,'major work happening in the day of holi and new year holidays.',1,'Adding another occurrence',2),(10,NULL,'2013-03-24 12:39:16',NULL,'Accident',1,'Very imp occurance',2),(12,NULL,'2013-04-17 09:08:06',NULL,'S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)',0,'Main occurrence',2),(13,NULL,'2013-04-17 22:13:18',NULL,'sfsfjsklfj,',1,'tjsdfh',2),(14,NULL,'2013-04-21 16:15:35',NULL,'S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)',1,'TOD',2),(15,NULL,'2013-05-08 18:52:20',NULL,'Occurance',0,'VIP',1),(16,NULL,'2013-06-07 09:37:56',NULL,'Imp',1,'Last occurrance',2),(17,NULL,'2013-06-07 09:38:42',NULL,'Not very imp',0,'Last but one occ',2),(20,NULL,'2013-06-28 17:01:22',NULL,'SS Jahari stationed at Guard Post, \r\nSO Razak stationed at Main Entrance,\r\nSO Tarmizi stationed at Clubhouse,\r\n',0,'Deployment',10),(21,NULL,'2013-06-28 19:42:50',NULL,'Updated as server is not responding from 1755hrs.\r\nSS Jahari stationed at Clubhouse\r\nSO Razak stationed at Main Entrance,\r\nSO Tarmizi stationed at Main Gate,\r\n\r\nSS Jahari opened the Tennis Court 1 for resident from B708 #02-03 booking from 1900hrs to 2100hrs (Mr.Eddie Boey)',0,'Deployment',10),(22,NULL,'2013-06-28 20:26:02',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(23,NULL,'2013-06-28 21:01:30',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Handed Over Duty',10),(24,NULL,'2013-06-28 21:02:34',NULL,'SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(25,NULL,'2013-06-29 10:03:14',NULL,'	SS RAZAK took over duty with situation as normal.',0,'Took Over Duty',10),(26,NULL,'2013-06-29 10:05:35',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(27,NULL,'2013-06-29 10:09:17',NULL,'SO Razak and SO Tarmizi standby at main gate. ',0,'DEPLOYMENT',10),(28,NULL,'2013-06-29 11:06:49',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(29,NULL,'2013-06-29 12:28:39',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(30,NULL,'2013-06-29 13:23:31',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(31,NULL,'2013-06-29 14:11:49',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(32,NULL,'2013-06-29 16:12:08',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(33,NULL,'2013-06-29 17:22:17',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(34,NULL,'2013-06-29 18:10:22',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(35,NULL,'2013-06-29 19:06:18',NULL,'SO TARMIZI AT MAIN/GATE SO RAZAK AT C/HOUSE UNLOCK TENNIS COURT',0,'DEPLOYMENT',10),(36,NULL,'2013-06-29 21:01:45',NULL,'	SSRazak handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Handed Over Duty',10),(37,NULL,'2013-06-29 21:03:45',NULL,'	SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(38,NULL,'2013-06-29 21:18:04',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'DEPLOYMENT',10),(39,NULL,'2013-06-29 22:12:58',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO RAZAK WENT TO CLOSE ALL FACILITY AS NORMAL',0,'DEPLOYMENT',10),(40,NULL,'2013-06-30 00:02:43',NULL,'Diary closed for dated 29/6/13 (Saturday) ',1,'Diary Close',10),(41,NULL,'2013-06-30 00:08:39',NULL,'Diary opened for dated 30/06/13 (Sunday)',1,'Diary Open',10),(42,NULL,'2013-06-30 01:56:42',NULL,'SS KAMAL AND SO RAZAK MAIN ENTRANCE SO ALI WENT FOR CLOCKING',0,'DEPLOYMENT',10),(43,NULL,'2013-06-30 04:01:37',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO RAZAK WENT FOR CLOCKING',0,'DEPLOYMENT',10),(44,NULL,'2013-06-30 06:01:46',NULL,'SS KAMAL AND SO RAZAK MAIN ENTRANCE SO ALI WENT FOR CLOCKING',0,'DEPLOYMENT',10),(45,NULL,'2013-06-30 06:58:47',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO RAZAK AT CLUB HOUSE',0,'DEPLOYMENT',10),(47,NULL,'2013-06-30 08:34:10',NULL,'	SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'DEPLOYMENT',10),(50,NULL,'2013-06-30 09:08:44',NULL,'		SSKAMAL handed over duty to SS JAHARI with situation reported normal with all keys and equipment intact and briefed accordingl',0,'HAND OVER DUTY',10),(51,NULL,'2013-06-30 09:11:51',NULL,'SS Jahari took over duty with situation normal.',0,'Took Over Duty',10),(52,NULL,'2013-06-30 09:58:29',NULL,'SS Jahari at Guard post, SS Kamal at Main Entrance, SO Razak at Clubhouse,',0,'Deployment',10),(53,NULL,'2013-06-30 09:59:28',NULL,'Clocking was cancelled due to heavy rain',0,'Clocking',10),(54,NULL,'2013-06-30 12:17:46',NULL,'SS Jahari stationed at Guard post,\r\nSO Razak stationed at Main gate',0,'Deployment',10),(55,NULL,'2013-06-30 13:27:31',NULL,'SS Jahari went for his lunch break\r\nSO Razak stand by at Guard post',0,'Lunch Break/Stand by',10),(56,NULL,'2013-06-30 15:34:15',NULL,'At about 1430hrs, SS Jahari relieved SO Razak at Guard post for his lunch break.\r\nAt 1431hrs, SS Jahari stand by at Guard post,\r\nSO Razak stand by at Main gate.',0,'Relief',10),(57,NULL,'2013-06-30 16:05:37',NULL,'Clocking was cancelled due to rain.\r\nSS Jahari and SO Razak stationed at the Guard post',0,'Clocking',10),(60,NULL,'2013-06-30 19:00:18',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate',0,'Deployment',10),(61,NULL,'2013-06-30 19:49:40',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate',0,'Deployment',10),(62,NULL,'2013-06-30 21:04:22',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly',0,'Handed Over Duty',10),(63,NULL,'2013-06-30 21:05:33',NULL,'	SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(66,NULL,'2013-06-30 21:23:02',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'DEPLOYMENT',10),(67,NULL,'2013-06-30 21:57:08',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO RAZAK WENT TO LOCKED ALL FACILITY SITUATION NORMAL',0,'DEPLOYMENT',10),(71,NULL,'2013-07-01 00:13:22',NULL,'Diary closed for dated 30/06/13',1,'Diary Close',10),(72,NULL,'2013-07-01 00:18:54',NULL,'Diary opened for dated 01/07/13 (Sunday)',1,'Diary Close',10),(73,NULL,'2013-07-01 01:51:23',NULL,'SS KAMAL AND SO RAZAK AT MAIN ENTRANCE SO ALI WENT FOR CLOCKING ROUND',0,'Clocking',10),(74,NULL,'2013-07-01 01:54:39',NULL,'SS KAMAL AND SO RAZAK AT MAIN ENTRANCE SO ALI WENT FOR CLOCKING ROUND',0,'Clocking',10),(75,NULL,'2013-07-01 06:00:49',NULL,'S KAMAL AND SO RAZAK MAIN ENTRANCE SO ALI WENT FOR CLOCKIN',0,'DEPLOYMENT',10),(77,NULL,'2013-07-01 07:58:20',NULL,'	SS KAMAL AND SO ALI MAIN ENTRANCE SO RAZAK AT CLUB HOUSE',0,'Deployment',10),(78,NULL,'2013-07-01 09:09:04',NULL,'SMA Director Mr.Alsagoff visited Changi Court Condo, SO\'s Kamal, Ali and Razak on duty and alert.',1,'Visit',10),(79,NULL,'2013-07-01 09:14:40',NULL,'situation reported normal with all keys and equipment intact and briefed according',0,'Handed Over Duty',10),(80,NULL,'2013-07-01 09:15:50',NULL,'SS Razak took over duty with situation as normal.\r\n\r\n',0,'Took Over Duty',10),(81,NULL,'2013-07-01 09:56:45',NULL,'SO Razak went for clocking around the estate.',0,'Clocking',10),(82,NULL,'2013-07-01 10:02:24',NULL,'SS Jahari stationed at Guard Post\r\nSO Tarmizi stationed at Main Gate',0,'Stand by',10),(83,NULL,'2013-07-01 11:10:12',NULL,'SO Razak returned from clocking and patrolling around the estate, reported all in order',0,'Return',10),(84,NULL,'2013-07-01 12:00:41',NULL,'SS Jahari stationed at Guard Post\r\nSO Tarmizi stationed at Main Gate\r\nSO Razak went for his lunch break',0,'Deployment',10),(85,NULL,'2013-07-01 13:02:36',NULL,'SO Razak relieved SO Tarmizi at the Main Gate.\r\nSO Tarmizi went for his lunch break',0,'Relief',10),(86,NULL,'2013-07-01 14:00:46',NULL,'SO Tarmizi relieved SS Jahari at the Guard post,\r\nSS Jahari went for his lunch break',0,'Relief',10),(87,NULL,'2013-07-01 14:58:40',NULL,'	SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse',0,'Deployment',10),(88,NULL,'2013-07-01 16:42:45',NULL,'SO Tarmizi went for clocking at 1600hrs around the estate.',0,'Clocking',10),(89,NULL,'2013-07-01 16:59:53',NULL,'SO Tarmizi returned from clocking and patrolling, reported all in order',0,'Return',10),(90,NULL,'2013-07-01 17:02:42',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard Post,SO Tarmizi stationed at Main Gate',0,'Deployment',10),(91,NULL,'2013-07-01 17:59:16',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Guard Post,SO Tarmizi stationed at Main Gate',0,'Deployment',10),(92,NULL,'2013-07-01 18:56:08',NULL,'SS Jahari at Guard post,SO Tarmizi at Main Entrance, SO Razak at Clubhouse,',0,'Deployment',10),(93,NULL,'2013-07-01 19:24:57',NULL,'At about 1910hrs, SS Jahari noticed a visitor to B702 #06 10 heading to the swimming pool with her swimming costume via the CCTV, SO Razak was deployed to checked the visitor and informed her that, the resident have to be present is she wanted to swim in the pool. At about 1935hrs the visitor left the estate.\r\nThat is all',1,'Swimmimg Pool',10),(94,NULL,'2013-07-01 21:00:39',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Handed Over Duty',10),(95,NULL,'2013-07-01 21:01:30',NULL,'SS Kamal took over duty to SS Jahari with situation reported normal.',0,'Took Over Duty',10),(96,NULL,'2013-07-01 21:50:36',NULL,'SS KAMAL AND SO JOHARI MAIN ENTRANCE SO ALI CLUB HOUSE',0,'Deployment',10),(97,NULL,'2013-07-01 21:59:23',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO JOHARI LOCKED BADMINTON CRT AND SWITCH OFF CLUB HOUSE LIGHT',0,'Deployment',10),(98,NULL,'2013-07-01 22:13:12',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(99,NULL,'2013-07-01 23:53:37',NULL,'DIARY CLOSE FOR 1\\7\\13 (MONDAY)DIARY OPEN FOR 2\\7\\13 (TUESDAY)',1,'Diary Close',10),(100,NULL,'2013-07-02 00:15:28',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO JOHARI WENT TO LOCKED GYM',0,'CLOSING',10),(101,NULL,'2013-07-02 02:00:20',NULL,'SS KAMAL AND SO JOHARI AT MAIN ENTRANCE SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'DEPLOYMENT',10),(102,NULL,'2013-07-02 04:02:41',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Deployment',10),(103,NULL,'2013-07-02 06:07:23',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Deployment',10),(105,NULL,'2013-07-02 07:12:02',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(106,NULL,'2013-07-02 08:59:43',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH SITUATION NORMAL WITH ALL KEY AND EQUIQMENT INTACT AND BRIEF ACCORDINGLY',0,'HAND OVER DUTY',10),(107,NULL,'2013-07-02 09:06:24',NULL,'SS Jahari took over duty from SS Kamal with situation normal.',0,'Took Over Duty',10),(108,NULL,'2013-07-02 09:54:37',NULL,'Late Entry 0910hrs,\r\nSS Jahari stationed at Guard post, SS Kamal at Main Gate,\r\nSO Razak stationed at Main entrance.',0,'Deployment',10),(109,NULL,'2013-07-02 10:04:31',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Gate, SO Tarmizi stationed at Main Entrance',0,'Deployment',10),(110,NULL,'2013-07-02 11:06:33',NULL,'SS Jahari went for patrolling around the estate, reported all in order',0,'Patrolling',10),(111,NULL,'2013-07-02 12:09:39',NULL,'SS Jahari stationed at Guard Post, SO Tarmizi stationed at Main Entrance, SO Razak went for his lunch break,',0,'Deployment',10),(112,NULL,'2013-07-02 12:57:42',NULL,'SO Razak relieved SO Tarmizi at the main entrance,\r\nSO Tarmizi went for his lunch break',0,'Relief',10),(113,NULL,'2013-07-02 14:00:48',NULL,'SO Tarmizi relieved SS Jahari at the Guard Post,\r\nSS Jahari went for his lunch break',0,'Relief',10),(114,NULL,'2013-07-02 14:58:40',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(115,NULL,'2013-07-02 16:00:21',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(116,NULL,'2013-07-02 16:51:01',NULL,'SO Tarmizi returned from clocking and reported all in order.',0,'Return',10),(117,NULL,'2013-07-02 17:01:28',NULL,'SS Jahari at Clubhouse, SO Tarmizi at Main Entrance, SO Razak at Guard House,',0,'Deployment',10),(118,NULL,'2013-07-02 18:09:53',NULL,'	SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(119,NULL,'2013-07-02 18:56:59',NULL,'	SS Jahari at Clubhouse, SO Tarmizi at Main Entrance, SO Razak at Guard House,',0,'Deployment',10),(120,NULL,'2013-07-02 20:06:47',NULL,'	SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(121,NULL,'2013-07-02 21:30:34',NULL,'	SSRazak handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordin',0,'Hand Over Duty',10),(122,NULL,'2013-07-02 21:32:09',NULL,'	SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(123,NULL,'2013-07-02 21:49:45',NULL,'SO Razak andS?S/S KAMAL standby at main gate.',0,'Deployment',10),(124,NULL,'2013-07-02 23:26:52',NULL,'	SO Razak andS?S/S KAMAL standby at main gate.',0,'Deployment',10),(125,NULL,'2013-07-02 23:59:09',NULL,'Diary Close For 2\\7\\13 (Tuesday)',1,'Diary close',10),(126,NULL,'2013-07-03 00:02:41',NULL,'Diary Open For 3\\7\\13 (Wednesday) ',1,'Diary Open',10),(127,NULL,'2013-07-03 00:05:49',NULL,'SS KAMAL AT MAIN ENTRANCE SO RAZAK WENT TO LOCKED GYM',0,'Deployment',10),(128,NULL,'2013-07-03 01:58:16',NULL,'SS KAMAL STAND BY MAIN ENTRANCE',0,'Deployment',10),(129,NULL,'2013-07-03 02:01:30',NULL,'SO RAZAK WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(130,NULL,'2013-07-03 02:39:01',NULL,'SO RAZAK RETURN FROM CLOCKING REPORT SITUATION AS NORMAL',0,'Return',10),(131,NULL,'2013-07-03 04:00:32',NULL,'	SO Razak andS?S/S KAMAL standby at main gate.',0,'Deployment',10),(132,NULL,'2013-07-03 05:21:24',NULL,'	SO Razak andS?S/S KAMAL standby at main gate.',0,'Deployment',10),(133,NULL,'2013-07-03 06:08:12',NULL,'	SO Razak andS?S/S KAMAL standby at main gate.',0,'Deployment',10),(134,NULL,'2013-07-03 07:00:01',NULL,'SS KAMAL AND SO RAZAK STANB BY AT MAIN ENTRANCE',0,'Deployment',10),(135,NULL,'2013-07-03 08:05:53',NULL,'	SS KAMAL AND SO RAZAK STANB BY AT MAIN ENTRANCE',0,'Deployment',10),(136,NULL,'2013-07-03 08:56:33',NULL,'	SSKAMAL handed over duty to SS JAHARI with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Hand Over Duty',10),(137,NULL,'2013-07-03 08:58:34',NULL,'SS Jahari took over duty with situation as normal.',0,'Took Over Duty',10),(138,NULL,'2013-07-03 09:56:53',NULL,'Late Entry 0905hrs\r\nSS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(139,NULL,'2013-07-03 10:06:32',NULL,'Clocking was cancelled due to rain.',0,'Clocking',10),(140,NULL,'2013-07-03 11:00:26',NULL,'SS Jahari went for patrolling around car park and perimeter area, reported all in order',0,'Patrolling',10),(141,NULL,'2013-07-03 12:29:37',NULL,'SS Jahari stationed at Guard post\r\nSO Tarmizi stationed at main gate\r\nSO Razak went for his lunch break',0,'Deployment',10),(142,NULL,'2013-07-03 13:00:33',NULL,'SS Jahari stationed at Guard post,SO Razak stationed at main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(143,NULL,'2013-07-03 14:01:31',NULL,'SO Razak stationed at the Guard post, SO Tarmizi stationed at the Main gate, SS Jahari went for his lunch break',0,'Deployment',10),(144,NULL,'2013-07-03 15:09:37',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(145,NULL,'2013-07-03 16:19:31',NULL,'SO Tarmizi went for clocking around the estate.',0,'Clocking',10),(146,NULL,'2013-07-03 18:16:07',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(147,NULL,'2013-07-03 19:03:16',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(148,NULL,'2013-07-03 20:05:50',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(149,NULL,'2013-07-03 21:00:13',NULL,'SS Jahari handed over duty to SS Kamal with situation normal ',0,'Handed Over Duty',10),(150,NULL,'2013-07-03 21:01:27',NULL,'SS Kamal took over duty from SS Jahari with situation as normal.',0,'Took Over Duty',10),(151,NULL,'2013-07-03 21:37:33',NULL,'SS KAMAL AND SO RAZAK MAIN ENTRANCE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(152,NULL,'2013-07-03 21:59:40',NULL,'SS KAMAL AND SO RAZAK MAIN ENTRANCE SO JOHARI WENT TO LOCKED BADMINTON CRT AND SWITCH OFF CLUB HOUSE LIGHT',0,'Deployment',10),(153,NULL,'2013-07-03 22:05:57',NULL,'SO RAZAK WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(154,NULL,'2013-07-03 22:45:56',NULL,'SO RAZAK RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(155,NULL,'2013-07-03 23:59:38',NULL,'DIARY CLOSE FOR 3/7/13(WESNESDAY)',1,'Diary Close',10),(156,NULL,'2013-07-04 00:03:00',NULL,'DIARY OPEN FOR 4/7/13(THURSDAY)',1,'DIARY OPEN',10),(157,NULL,'2013-07-04 00:05:06',NULL,'SO JOHARI WENT TO LOCK GYM',0,'Deployment',10),(158,NULL,'2013-07-04 01:58:04',NULL,'SS KAMAL AND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(159,NULL,'2013-07-04 02:01:54',NULL,'SO JOHARI WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(160,NULL,'2013-07-04 02:47:49',NULL,'	SO JOHARIReturn From CLOCKING AROUND ESTATE AREA',0,'RETURN',10),(161,NULL,'2013-07-04 04:00:09',NULL,'	SO RAZAK WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(163,NULL,'2013-07-04 05:32:39',NULL,'	SORazakReturn From CLOCKING AROUND ESTATE ARE',0,'RETURN',10),(164,NULL,'2013-07-04 05:56:57',NULL,'S/OJOHARIWentCLOCKING AROUND ESTATE AREA',0,'Clocking',10),(165,NULL,'2013-07-04 06:34:05',NULL,'	SO JOHARIReturn From CLOCKING AROUND ESTATE AREA',0,'RETURN',10),(166,NULL,'2013-07-04 06:59:29',NULL,'	SS KAMAL AND SO RAZAK MAIN ENTRANCE SO JOHARI AT CLUB HOUS',0,'Deployment',10),(167,NULL,'2013-07-04 07:59:25',NULL,'	SS KAMAL AND SO RAZAK MAIN ENTRANCE SO JOHARI AT CLUB HOUS',0,'Deployment',10),(168,NULL,'2013-07-04 10:16:55',NULL,'SS Kamal handed over duty to SS Jahari with situation normal ',0,'Handed Over Duty',10),(169,NULL,'2013-07-04 10:18:22',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(170,NULL,'2013-07-04 10:19:11',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Main Entrance.',0,'Deployment',10),(171,NULL,'2013-07-04 10:27:39',NULL,'SO Razak went for clocking surrounding the estate.',0,'Clocking',10),(172,NULL,'2013-07-04 11:08:39',NULL,'SO Razak returned from clocking and reported all in order.',0,'Return',10),(173,NULL,'2013-07-04 13:41:18',NULL,'Late entry, 1200hrs\r\nSS Jahari stationed at Guard post,\r\nSO Tarmizi stationed at Main gate,\r\nSO Razak went for his lunch break,',0,'Deployment',10),(174,NULL,'2013-07-04 13:43:22',NULL,'Late entry, 1300hrs SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi went for his lunch break,',0,'Deployment',10),(175,NULL,'2013-07-04 15:51:49',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Main entrance.',0,'Deployment',10),(176,NULL,'2013-07-04 16:26:18',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(177,NULL,'2013-07-04 16:55:17',NULL,'SO Tarmizi returned from clocking, reported all in order',0,'Return',10),(178,NULL,'2013-07-04 17:00:33',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(179,NULL,'2013-07-04 17:55:14',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(180,NULL,'2013-07-04 19:07:15',NULL,'SS Jahari went to checked car park and perimeter reported all in order',0,'Patrolling',10),(181,NULL,'2013-07-04 21:09:31',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly',0,'Handed Over Duty',10),(182,NULL,'2013-07-04 21:34:52',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(183,NULL,'2013-07-04 22:03:47',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE SO JOHARI WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT SITUATION NORMAL',0,'Deployment',10),(184,NULL,'2013-07-04 22:07:54',NULL,'clocking cancel due to rain .',0,'Clocking',10),(185,NULL,'2013-07-05 00:01:34',NULL,'DIARY CLOSE FOR 4/7/13 (THURSDAY)',1,'Diary Close',10),(186,NULL,'2013-07-05 00:02:58',NULL,'DIARY OPEDED FOR 5/7/13 (FRIDAY)',1,'DIARY OPEN',10),(187,NULL,'2013-07-05 00:03:49',NULL,'S/S KAMAL WENT TO LOCKED GYM ',0,'GYM',10),(188,NULL,'2013-07-05 02:02:58',NULL,'SS KAMAL AND SO JOHARI AT MAIN ENTRANCE',0,'Deployment',10),(189,NULL,'2013-07-05 02:05:26',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(190,NULL,'2013-07-05 04:00:12',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE',0,'Deployment',10),(191,NULL,'2013-07-05 04:04:03',NULL,'CLOCKING CANCELLED DUE TO RAIN',0,'Clocking',10),(192,NULL,'2013-07-05 06:05:02',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE',0,'Deployment',10),(193,NULL,'2013-07-05 06:06:41',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA ',0,'Clocking',10),(194,NULL,'2013-07-05 06:53:33',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(195,NULL,'2013-07-05 07:02:01',NULL,'SS KAMAL AND SO ALI MAIN ENTRANCE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(196,NULL,'2013-07-05 08:59:11',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH ALL KEY INTACT AND SITUATION AS NORMAL',0,'Handed Over Duty',10),(197,NULL,'2013-07-05 09:03:51',NULL,'SS Jahari took over duty from SS Kamal with situation as normal',0,'Took Over Duty',10),(198,NULL,'2013-07-05 10:06:31',NULL,'	SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Main Entrance.',0,'Deployment',10),(199,NULL,'2013-07-05 10:42:09',NULL,'SO Razak went for clocking around the estate',0,'Clocking',10),(200,NULL,'2013-07-05 12:08:32',NULL,'Late Entry\r\nSO Razak returned from clocking at 1120hrs reported all in order',0,'Return',10),(201,NULL,'2013-07-05 12:09:47',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate,\r\nSO Razak went for his lunch break',0,'Deployment',10),(202,NULL,'2013-07-05 12:17:30',NULL,'SMA Mr.Alsagoff visited Changi Court condo.\r\nSS Jahari and So Tarmizi at main gate alert.',1,'Visit',10),(203,NULL,'2013-07-05 13:00:27',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(204,NULL,'2013-07-05 14:46:57',NULL,'SS Razak stationed at Guard post, SO Tarmizi stationed at Main gate,S?S Jahari went for his lunch break',0,'Deployment',10),(205,NULL,'2013-07-05 16:13:46',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate,\r\n',0,'Deployment',10),(206,NULL,'2013-07-05 16:14:27',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(207,NULL,'2013-07-05 16:30:11',NULL,'CM Michael Quek called and informed SS Jahari verbally that Maintenance Tan is authorized to take his \"Bicycle\" out from the estste.',1,'Information',10),(208,NULL,'2013-07-05 17:02:59',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard house, SO Tarmizi stationed at Main entrance after returning from clocking.',0,'Deployment',10),(209,NULL,'2013-07-05 18:11:12',NULL,'	SS Jahari stationed at Club House, SO Razak stationed at Main gate, SO Tarmizi stationed at Main Entrance.',0,'Deployment',10),(210,NULL,'2013-07-05 19:13:16',NULL,'SS Jahari went for patrolling around the estate to checked on lighting and perimeter, reported all in order',0,'Patrolling',10),(211,NULL,'2013-07-05 21:01:20',NULL,'SS Jahari handed over duty to SS Razak with situation normal',0,'Handed Over Duty',10),(212,NULL,'2013-07-05 21:02:05',NULL,'SS Razak took over duty with situation as normal.',0,'Took Over Duty',10),(213,NULL,'2013-07-05 21:50:04',NULL,'S/O RAZAK AT G/HOUSE, S/O ALI AT M/GATE, S/O JOHARI WENT TO LOCKED ALL FACILITY REPORTING S/NORMAL .',0,'DEPLOYMENT ',10),(214,NULL,'2013-07-05 22:03:04',NULL,'S/O ALI LEFT FOR CLOCKING .',0,'CLOCKING',10),(215,NULL,'2013-07-05 22:42:32',NULL,'S/O ALI RETURN FROM CLOCKING REPORTING S/NORMAL .',0,'RETURN',10),(216,NULL,'2013-07-05 22:54:17',NULL,'	s/o johari AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'Deployment',10),(217,NULL,'2013-07-06 00:13:41',NULL,'DIARY CLOSED FOR 5/7/13 (FRIDAY)',1,'Diary Close',10),(218,NULL,'2013-07-06 00:14:36',NULL,'DIARY OPENED FOR 6/7/13 (SATURDAY)',1,'DIARY OPENED',10),(219,NULL,'2013-07-06 00:15:23',NULL,'S/O RAZAK WENT TO LOCKED GYM .',0,'GYM',10),(220,NULL,'2013-07-06 00:15:49',NULL,'S/O RAZAK G/HOUSE, S/O JOHARI & S/O ALI AT M/GATE .',0,'DEPLOYMENT',10),(221,NULL,'2013-07-06 02:15:12',NULL,'S/O ALI LEFT FOR CLOCKING',0,'CLOCKING',10),(222,NULL,'2013-07-06 04:01:22',NULL,'	SO RAZAK WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(223,NULL,'2013-07-06 04:46:33',NULL,'S/O RAZAK RETURN FROM CLOCKING REPORTING S/NORMAL .',0,'RETURN',10),(224,NULL,'2013-07-06 06:04:22',NULL,'S/O JOHARI LEFT FOR CLOCKING .',0,'CLOCKING',10),(225,NULL,'2013-07-06 06:08:36',NULL,'S/O RAZAK G/HOUSE, S/O ALI M/GATE .',0,'DEPLOYMENT',10),(226,NULL,'2013-07-06 06:42:49',NULL,'S/O jOHARI RETURN FROM CLOCKING REPORTING S/NORMAL',0,'RETURN',10),(227,NULL,'2013-07-06 07:04:35',NULL,'	s/o johari AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'Deployment',10),(228,NULL,'2013-07-06 08:33:05',NULL,'	S/O RAZAK G/HOUSE, S/O JOHARI & S/O ALI AT M/GATE .',0,'Deployment',10),(229,NULL,'2013-07-06 09:00:17',NULL,'S/O RAZAK RESUME DUTY AS A NORMAL .',0,'RESUME',10),(230,NULL,'2013-07-06 10:30:15',NULL,'	SSRazak stationed at Guard post, SO Tarmizi stationed at Main Entrance.',0,'Deployment',10),(231,NULL,'2013-07-06 13:51:09',NULL,'	SO Razak relieved SO Tarmizi at the main entrance, SO Tarmizi went for his lunch break',0,'Deployment',10),(232,NULL,'2013-07-06 14:21:52',NULL,'	S/OTARMIZIAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(233,NULL,'2013-07-06 16:21:48',NULL,'	S/OTARMIZIAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(234,NULL,'2013-07-06 16:21:48',NULL,'	S/OTARMIZIAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(235,NULL,'2013-07-06 17:55:07',NULL,'S/O RAZAK went for patrolling around the estate, reported all in order',0,'Deployment',10),(236,NULL,'2013-07-06 18:54:21',NULL,'S/O TARMIZI AND S/O RAZAK AT MAIN GATE	     ',0,'Deployment',10),(237,NULL,'2013-07-06 19:53:24',NULL,'	S/OTARMIZIAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(238,NULL,'2013-07-06 21:02:41',NULL,'S/O Tarmizi\r\n\r\n+	  handed over duty to SS Razak with situation normal',0,'Handed Over Duty',10),(239,NULL,'2013-07-06 21:07:03',NULL,'	SS Razak took over duty with situation as normal. ',0,'Took Over Duty',10),(240,NULL,'2013-07-06 21:56:56',NULL,'S/O ALI	 IAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(241,NULL,'2013-07-06 23:01:53',NULL,'	S/O ALI IAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(242,NULL,'2013-07-07 00:07:19',NULL,' 	Diary closed for dated 6/7/13 (Saturday) ',1,'Diary Close',10),(243,NULL,'2013-07-07 00:09:05',NULL,' 	Diary opened for dated 7/7/13 (Sunday)',1,'DIARY OPEN',10),(244,NULL,'2013-07-07 01:29:35',NULL,'	SO Razak and S/O ALI standby at main gate.',0,'Deployment',10),(245,NULL,'2013-07-07 04:06:48',NULL,'	S/O ALI IAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(246,NULL,'2013-07-07 07:24:04',NULL,'	SO Razak and S/O ALI standby at main gate.',0,'Deployment',10),(247,NULL,'2013-07-07 08:40:37',NULL,'	S/O ALI IAND SO RAZAK AT MAIN ENTRANCE',0,'Deployment',10),(248,NULL,'2013-07-07 09:04:31',NULL,'	SSRazak handed over duty to SS JAHARIwith situation reported normal with all keys and equipment intact and briefed accordingl',0,'Handed Over Duty',10),(249,NULL,'2013-07-07 09:05:43',NULL,'SS Jahari took over duty with situation as normal.',0,'Took Over Duty',10),(250,NULL,'2013-07-07 09:49:49',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate',0,'Deployment',10),(251,NULL,'2013-07-07 10:44:13',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(252,NULL,'2013-07-07 12:12:56',NULL,'SS Jahari opened the Function room for resident from B702 #09-04, SO Tarmizi stationed at the Main entrance.',0,'Deployment',10),(253,NULL,'2013-07-07 13:03:10',NULL,'SS Jahari stationed at Guard post, SO Tarmizi went for his lunch break',0,'Deployment',10),(255,NULL,'2013-07-07 14:01:41',NULL,'SO Tarmizi relieved SS Jahari at the Guard post for his lunch break',0,'Deployment',10),(256,NULL,'2013-07-07 15:13:52',NULL,'SS Jahari stand by at Guard post, SO Tarmizi at Main Entrance',0,'Stand By',10),(257,NULL,'2013-07-07 16:01:49',NULL,'SS Jahari went for patrolling around the estate reported all in order',0,'Patrolling',10),(258,NULL,'2013-07-07 19:15:25',NULL,'Late Entry,\r\nSS Jahari locked \"Function Room\" at 1700hrs and stand by at Clubhouse.',0,'Deployment',10),(259,NULL,'2013-07-07 19:16:55',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance.',0,'Deployment',10),(260,NULL,'2013-07-07 20:18:17',NULL,'Situation all as normal',0,'Report',10),(261,NULL,'2013-07-07 21:02:14',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal.',0,'Handed Over Duty',10),(262,NULL,'2013-07-07 21:02:44',NULL,'SS Kamal took over duty from SS Jahari with situation reported normal.',0,'Took Over Duty',10),(263,NULL,'2013-07-07 21:32:23',NULL,'SS KAMAL AND SO ALI AT MAIN ENTRANCE',0,'Deployment',10),(264,NULL,'2013-07-07 22:04:55',NULL,'SO ALI STAND BY MAIN GATE SS KAMAL LOCKED ALL FACILITY',0,'Deployment',10),(265,NULL,'2013-07-07 22:08:27',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(266,NULL,'2013-07-07 22:44:09',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(267,NULL,'2013-07-08 00:05:16',NULL,'diary close for 7\\7]13 (SUNDAY)',1,'Diary Close',10),(268,NULL,'2013-07-08 00:07:31',NULL,'DIARY OPEN FOR 8\\7\\13 (MONDAY)',0,'DIARY OPEN',10),(269,NULL,'2013-07-08 00:09:51',NULL,'diary open for 8\\7\\13 (sunday)',1,'DIARY OPEN',10),(270,NULL,'2013-07-08 00:18:08',NULL,'S KAMAL WENT TO LOCKED GYM',0,'GYM',10),(271,NULL,'2013-07-08 02:02:36',NULL,'SO ALI STAND BY AT GUARD POST',0,'Deployment',10),(272,NULL,'2013-07-08 02:05:38',NULL,'SS KAMAL WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(273,NULL,'2013-07-08 02:49:47',NULL,'SS KAMAL RETURN FROM REPORT SITUATION NORMAL',0,'CLOCKING',10),(274,NULL,'2013-07-08 04:02:42',NULL,'SS KAMAL STAND AT GUARD HOUSE',0,'Deployment',10),(275,NULL,'2013-07-08 04:04:44',NULL,'SO ALI WENT FOR CLOCING AROUND ESTATE AREA',0,'CLOCKING',10),(276,NULL,'2013-07-08 06:01:47',NULL,'SS KAMAL STAND BY AT GUARD HOUSE',0,'Deployment',10),(277,NULL,'2013-07-08 06:04:04',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(278,NULL,'2013-07-08 06:54:49',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(279,NULL,'2013-07-08 06:59:33',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(280,NULL,'2013-07-08 08:59:49',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEYS INTACT ALL IN ORDER',0,'Handed Over Duty',10),(281,NULL,'2013-07-08 09:04:01',NULL,'SS Jahari took over duty from SS Kamal with situation reported normal.',0,'Took Over Duty',10),(282,NULL,'2013-07-08 10:03:31',NULL,'SS Jahari stationed at Guard post,\r\nSO Tarmizi stationed at Main gate,\r\nSO Razak went for clocking around the estate',0,'Deployment',10),(283,NULL,'2013-07-08 10:55:32',NULL,'SO Razak returned from clocking and reported all in order.',0,'Return',10),(284,NULL,'2013-07-08 11:15:21',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak stationed at Clubhouse',0,'Deployment',10),(285,NULL,'2013-07-08 12:02:29',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance, SO Razak went for his lunch break',0,'Deployment',10),(286,NULL,'2013-07-08 13:05:32',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main entrance, SO Tarmizi went for his lunch break',0,'Deployment',10),(287,NULL,'2013-07-08 14:10:19',NULL,'SS Jahari went for his lunch break, SO Razak stationed at Guard post, SO Tarmizi stationed at the Main entrance.',0,'Deployment',10),(288,NULL,'2013-07-08 15:53:00',NULL,'SS Jahari stationed at Clubhouse,SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(289,NULL,'2013-07-08 18:03:41',NULL,'SS Jahari stationed at Clubhouse,SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(290,NULL,'2013-07-08 19:39:06',NULL,'Weavepact Director Mr.Thomas Leom and his staff\'s is still in the \"Function Room\" doing work.',1,'Report',10),(291,NULL,'2013-07-08 20:37:56',NULL,'Weavepact staff\'s Ms.Zuraidah, Catherine and Maint. Tan left the estate.',0,'Report',10),(292,NULL,'2013-07-08 20:42:38',NULL,'Weavepact Director Mr.Thomas and Mr.Michael Quek left the estate',0,'Report',10),(293,NULL,'2013-07-08 21:04:48',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Handed Over Duty',10),(294,NULL,'2013-07-08 21:05:20',NULL,'SS Kamal took over duty from SS Jahari with situation normal',0,'Took Over Duty',10),(295,NULL,'2013-07-08 21:11:44',NULL,'SS kamal and so ali main gate so johari at club house',0,'Deployment',10),(296,NULL,'2013-07-08 22:02:06',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI LOCKED BADMINTON CRT AND SWITCH OFF CLUB HOUSE LIGHT',0,'Deployment',10),(297,NULL,'2013-07-08 22:06:40',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(298,NULL,'2013-07-09 09:08:25',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEY IN ORDER SITUATION AS NORMAL',0,'Handed Over Duty',10),(299,NULL,'2013-07-09 09:57:28',NULL,'Late Entry\r\nSS Jahari took over duty from SS Kamal with situation norrmal.',0,'Took Over Duty',10),(300,NULL,'2013-07-09 09:58:23',NULL,'Late Entry\r\nAt about 0905hrs, a tenant from B700 #01-04 namely Mr.Mahesh requested SS Jahari to view the CCTV footage of a taxi as he claimed that he had left his Passport in the taxi on the 07/07/13 at about 2130hrs. \r\nCCTV footage shows that he had entered the estate with \"Comfort\"taxi nos SHA 2033S ',1,'Report',10),(301,NULL,'2013-07-09 10:04:15',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate,\r\nSO Razak went for clocking around the estate',0,'Deployment',10),(302,NULL,'2013-07-09 11:57:26',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance, SO Razak went for his lunch break',0,'Deployment',10),(303,NULL,'2013-07-09 12:11:19',NULL,'Mr.Thomas Leom from Weavepact and his staff\'s left the condo',0,'Report',10),(304,NULL,'2013-07-09 13:02:18',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main entrance, SO Tarmizi went for his lunch break',0,'Deployment',10),(305,NULL,'2013-07-09 15:18:22',NULL,'1400hrs, SS Jahari went for his lunch break,, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate',0,'Deployment',10),(306,NULL,'2013-07-09 15:21:10',NULL,'SS Jahari stationed at Clubhouse,SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(307,NULL,'2013-07-09 16:09:38',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(308,NULL,'2013-07-09 16:50:34',NULL,'SO Tarmizi returned from clocking and reported all in order.',0,'Return',10),(309,NULL,'2013-07-09 16:57:49',NULL,'SS Jahari stationed at Clubhouse,SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(310,NULL,'2013-07-09 17:59:01',NULL,'shariff came here to install the system',0,'system',11),(311,NULL,'2013-07-09 17:59:58',NULL,'s/o shaikh went to patroll the car park everything is alright',1,'rounds',11),(312,NULL,'2013-07-09 19:11:06',NULL,'	SS Jahari stationed at Clubhouse,SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate',0,'Deployment',10),(313,NULL,'2013-07-09 19:40:43',NULL,'At about 1700hrs, Mr.Gary from Knight Frank management came to Guard post and took the \"Seal Management Key\" from the SO Razak.',1,'Management Key',10),(314,NULL,'2013-07-09 21:01:42',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal.',0,'Handed Over Duty',10),(315,NULL,'2013-07-09 21:18:44',NULL,'SS KAMAL AND SO ALI MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(316,NULL,'2013-07-09 22:02:20',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT',0,'Deployment',10),(317,NULL,'2013-07-09 22:05:22',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(318,NULL,'2013-07-09 22:48:24',NULL,'SO JOHARI RETURN BACK FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(319,NULL,'2013-07-09 23:55:13',NULL,'DIARY CLOSE FOR 9\\7\\13 ( TUESDAY)',1,'Diary Close',10),(320,NULL,'2013-07-10 00:00:52',NULL,'DIARY open for 1o\\7\\13 (WEDNESDAY)',0,'DIARY OPEN',10),(321,NULL,'2013-07-10 00:03:22',NULL,'SO JOHAHARI WENT TO LOCK GYM',0,'GYM',10),(322,NULL,'2013-07-10 00:04:22',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE SO ALI AT CLUB HOUSE',0,'Deployment',10),(323,NULL,'2013-07-10 02:01:28',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(324,NULL,'2013-07-10 02:02:55',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(325,NULL,'2013-07-10 02:47:32',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(326,NULL,'2013-07-10 03:58:22',NULL,'SS kamal and so ALI AT MAIN GATE   ',0,'Deployment',10),(327,NULL,'2013-07-10 04:00:41',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(328,NULL,'2013-07-10 05:03:29',NULL,'s/o ali return from clocking reportinf s/normal .',0,'RETURN',10),(329,NULL,'2013-07-10 06:24:46',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(330,NULL,'2013-07-10 06:26:55',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(331,NULL,'2013-07-10 06:51:59',NULL,' SO JOHARI RETURN BACK FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(332,NULL,'2013-07-10 07:01:07',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(333,NULL,'2013-07-10 08:59:19',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'Handed Over Duty',10),(334,NULL,'2013-07-10 09:04:32',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(335,NULL,'2013-07-10 10:00:12',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate,\r\nSO Razak went for clocking around the estate.',0,'Deployment',10),(336,NULL,'2013-07-10 10:54:05',NULL,'SO Razak returned from clocking and reported all in order',0,'Return',10),(337,NULL,'2013-07-10 11:15:59',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak stationed at Main entrance.',0,'Deployment',10),(338,NULL,'2013-07-10 12:03:35',NULL,'SS Jahari stationed at Guard Post SO Tarmizi stationed at Main Gate SO Razak went for his lunch break',0,'Deployment',10),(339,NULL,'2013-07-10 14:00:10',NULL,'Late Entry, 1300hrs,\r\nSS Jahari stationed at Guard post, SoRazak stationed at Main gate, SO Tarmizi went for his lunch break.',0,'Deployment',10),(340,NULL,'2013-07-10 14:01:21',NULL,'SO Razak  stationed at Guard post, SO Tarmizi stationed at Main gate, SS Jahari went for his lunch break.',0,'Deployment',10),(341,NULL,'2013-07-10 16:36:09',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(342,NULL,'2013-07-10 17:00:39',NULL,'SO Tarmizi returned from clocking around the estate reported all in order',0,'Return',10),(343,NULL,'2013-07-10 17:01:54',NULL,'SS Jahari stationed at Clubhouse, SO Tarmizi stationed at Main gate, SO Razak stationed at Guard post',0,'Deployment',10),(344,NULL,'2013-07-10 18:15:10',NULL,'	SS Jahari stationed at Clubhouse, SO Tarmizi stationed at Main gate, SO Razak stationed at Guard post',0,'Deployment',10),(345,NULL,'2013-07-10 19:56:18',NULL,'SS Jahari went for patrolling around the estate, reported all in order',0,'Patrolling',10),(346,NULL,'2013-07-10 21:01:40',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Handed Over Duty',10),(347,NULL,'2013-07-10 21:14:17',NULL,'SS KAMAL AND SO ALI MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(348,NULL,'2013-07-10 22:08:59',NULL,'SS KAMAL AND SO ALI MAIN GATE SO JOHARI LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT',0,'Deployment',10),(349,NULL,'2013-07-10 22:12:05',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(350,NULL,'2013-07-10 22:43:16',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(351,NULL,'2013-07-10 23:58:47',NULL,'DIARY CLOSE FOR 1o\\7\\13 (WEDNESDAY)',1,'Diary Close',10),(352,NULL,'2013-07-11 00:00:34',NULL,'DIARY OPEN FOR 11\\7\\13 (THURDAY)',0,'DIARY OPEN',10),(353,NULL,'2013-07-11 00:01:48',NULL,'SO JOHARI WENT TO LOCKED GYM',0,'GYM',10),(354,NULL,'2013-07-11 00:03:40',NULL,'SS KAMAL AND SO JOHARI MAIN GATE SO ALI CLUB HOUSE',0,'Deployment',10),(355,NULL,'2013-07-11 01:59:33',NULL,'SS KAMAL AND SO ALI AT MAIN GATE ',0,'Deployment',10),(356,NULL,'2013-07-11 02:00:54',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(357,NULL,'2013-07-11 02:57:27',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(358,NULL,'2013-07-11 04:00:08',NULL,'SS KAMAL WENT TO checked LIGHT ON ALL BLOCK',0,'PATROLLING',10),(359,NULL,'2013-07-11 06:20:55',NULL,'SS KAMAL AND SO ALI MAIN GATE',0,'Deployment',10),(360,NULL,'2013-07-11 06:23:27',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(361,NULL,'2013-07-11 06:59:29',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(362,NULL,'2013-07-11 07:01:00',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(363,NULL,'2013-07-11 09:04:13',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'Handed Over Duty',10),(364,NULL,'2013-07-11 09:06:18',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(365,NULL,'2013-07-11 10:05:44',NULL,'SS Jahari stationed at Guard Post, SO Tarmizi stationed at Main Entrance,',0,'Deployment',10),(366,NULL,'2013-07-11 10:06:24',NULL,'SO Razak went for clocking around the estate',0,'Clocking',10),(367,NULL,'2013-07-11 10:46:27',NULL,'SO Razak return from clocking reported all in order.',0,'Return',10),(368,NULL,'2013-07-11 10:47:39',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(369,NULL,'2013-07-11 12:15:10',NULL,'SS Jahari stationed at Guard Post, SO Tarmizi stationed at Main Entrance,\r\nSO Razak went for his lunch break, ',0,'Deployment',10),(370,NULL,'2013-07-11 12:58:49',NULL,'SO Razak relieved SO Tarmizi at the Main Gate. SO Tarmizi went for his lunch break',0,'Relief',10),(371,NULL,'2013-07-11 14:05:29',NULL,'SO Tarmizi relieved SS Jahari at the Guard post. SS Jahari went for his lunch break',0,'Relief',10),(372,NULL,'2013-07-11 15:23:56',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(373,NULL,'2013-07-11 16:20:03',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(374,NULL,'2013-07-11 16:56:25',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(375,NULL,'2013-07-11 16:58:15',NULL,'SS Jahari stationed at  Clubhouse, SO Razak stationed at Guard Post, SO Tarmizi stationed at Main Entrance,',0,'Deployment',10),(376,NULL,'2013-07-11 19:30:13',NULL,'SO Razak and SO Tarmizi stationed at Main entrance. SS Jahari went for patrolling around the estate, reported all in order.',0,'Deployment',10),(377,NULL,'2013-07-11 21:00:26',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Handed Over Duty',10),(378,NULL,'2013-07-11 21:07:20',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'Took Over Duty',10),(379,NULL,'2013-07-11 21:30:07',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(380,NULL,'2013-07-11 21:57:07',NULL,'SO JOHARI WENT TO LOCKED BADMINTON AND SWITCH OFF CLUB HOUSE RETURN REPORT SITUATION NORMAL',0,'LOCKED FACILITY',10),(381,NULL,'2013-07-11 22:03:02',NULL,' SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(382,NULL,'2013-07-11 22:06:27',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(383,NULL,'2013-07-11 22:51:05',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(384,NULL,'2013-07-11 23:57:18',NULL,'SO JOHARI WENT TO LOCKED GYM',0,'GYM',10),(385,NULL,'2013-07-11 23:59:08',NULL,'DIARY CLOSE FOR 11\\7\\13 (THURSDAY)',1,'Diary Close',10),(386,NULL,'2013-07-12 00:01:29',NULL,'DIARY OPEN FOR 12\\7\\13 (FRIDAY)',1,'DIARY OPENED',10),(387,NULL,'2013-07-12 00:03:20',NULL,'SS KAMAL AND SO JOHARI MAN GATE SO ALI AT CLUB HOUSE',0,'Deployment',10),(388,NULL,'2013-07-12 02:00:10',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(389,NULL,'2013-07-12 02:01:24',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(390,NULL,'2013-07-12 04:05:07',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(391,NULL,'2013-07-12 04:06:00',NULL,'SO JOHARI WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(392,NULL,'2013-07-12 06:08:07',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(393,NULL,'2013-07-12 06:09:22',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(394,NULL,'2013-07-12 07:00:24',NULL,'SO JOHARI RETURN BACK FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(395,NULL,'2013-07-12 07:02:00',NULL,'SS KAMAL AND SO ALI STATIONED AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(396,NULL,'2013-07-12 09:00:32',NULL,'SS KAMAL HAND OVER DUTY TO SS  JAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'Handed Over Duty',10),(397,NULL,'2013-07-12 09:03:01',NULL,'SS Jahari took over duty from SS Kamal with situation reported normal.',0,'Took Over Duty',10),(398,NULL,'2013-07-12 10:25:19',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance,\r\nSO Razak went for clocking around the estate',0,'Deployment',10),(399,NULL,'2013-07-12 11:04:09',NULL,'SO Razak returned from clocking and reported all in order',0,'Return',10),(400,NULL,'2013-07-12 12:15:32',NULL,'SS Jahari stationed at Main gate, SO Tarmizi stationed at Main entrance,\r\nSO Razak went for his lunch break',0,'Deployment',10),(402,NULL,'2013-07-12 14:58:57',NULL,'Late entry 1300hrs, SS Jahari stationed at Main gate, SO Razak stationed at Main entrance, SO Tarmizi went for his lunch break',0,'Deployment',10),(403,NULL,'2013-07-12 15:00:08',NULL,'Late Entry 1400hrs,\r\nSS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Main entrance',0,'Deployment',10),(404,NULL,'2013-07-12 15:01:29',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Main entrance',0,'Deployment',10),(405,NULL,'2013-07-12 15:27:07',NULL,'S/Sgt Ngiam from Changi NPP arrived to visit the Management office.\r\nQX 485 G',1,'POLICE VISIT',10),(406,NULL,'2013-07-12 15:40:32',NULL,'Reference s/no 370 left Changi Court condo',1,'Left',10),(407,NULL,'2013-07-12 15:56:29',NULL,'SO Tarmizi went for clocking around the esttate.',0,'Clocking',10),(408,NULL,'2013-07-12 17:40:43',NULL,'	SO Tarmizi returned from clocking and reported all in order',0,'RETURN',10),(409,NULL,'2013-07-12 19:05:20',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(410,NULL,'2013-07-12 20:04:29',NULL,'SS Jahari went for patrolling around the estate reported all in order',0,'Patrolling',10),(411,NULL,'2013-07-12 21:04:59',NULL,'S?S Jahari HAND OVER DUTY TO S?O RAzak WITH KEYS INTACT SITUATION AS NORMA',0,'Handed Over Duty',10),(412,NULL,'2013-07-12 21:10:25',NULL,'S/O Razak took over duty from SS Jahari with situation reported normal',0,'Took Over Duty',10),(413,NULL,'2013-07-12 21:25:32',NULL,'	S/O Razak stationed at Clubhouse, SOAli stationed at Main Entrance, SO Johari stationed at Main Gate ',0,'Deployment',10),(414,NULL,'2013-07-12 22:15:53',NULL,'S/O RAZAK WENT TO LOCKED BADMINTON & TENNIS COURT & SWITCH OFF C/HOUSE LIGHTS . S/O JOHARI & S/O ALI AT M/GATE .',0,'DEPLOYMENT',10),(415,NULL,'2013-07-12 22:17:21',NULL,'CLOCKING CANCELLED DUE TO DRIZZLING .',1,'CLOCKING',10),(416,NULL,'2013-07-12 23:53:48',NULL,'S/O RAZAK WENT TO LOCKED GYM .',0,'GYM',10),(418,NULL,'2013-07-12 23:59:08',NULL,'DIARY CLOSED ON 12/7/13 (FRIDAY)',1,'Diary Close',10),(419,NULL,'2013-07-13 00:00:17',NULL,'DIARY OPENED ON 13/7/13 (SATURDAY)',1,'DIARY OPENED',10),(420,NULL,'2013-07-13 00:02:50',NULL,'S/O JOHARI & S/O RAZAK AT M/GATE . S/O ALI AT C/HOUSE .',0,'Deployment',10),(421,NULL,'2013-07-13 01:56:05',NULL,'	S/O Razak stationed at Clubhouse, SOAli stationed at Main Entrance, SO Johari stationed at Main Gate ',0,'Deployment',10),(422,NULL,'2013-07-13 04:24:26',NULL,'	S/O Razak stationed at Clubhouse, SOAli stationed at Main Entrance, SO Johari stationed at Main Gate ',0,'Deployment',10),(423,NULL,'2013-07-13 06:18:05',NULL,'S/O RAZAK & S/O ALI AT M/GATE . S/O JOHARI AT C/HOUSE .',0,'DEPLOYMENT',10),(424,NULL,'2013-07-13 08:08:56',NULL,'S/O RAZAK & S/O ALI AT M/GATE . S/O JOHARI AT C/HOUSE .',0,'Deployment',10),(425,NULL,'2013-07-13 09:11:17',NULL,'y	SSRazak handed over duty to SSJahari with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Handed Over Duty',10),(426,NULL,'2013-07-13 09:12:31',NULL,'	SS Jahari took over duty with situation as normal.',0,'Took Over Duty',10),(427,NULL,'2013-07-13 11:34:45',NULL,'Late entry 0905hrs, SS Jahari at Guard post, SS Kamal at Main Entrance, SO Razak at Main gate,',0,'Deployment',10),(428,NULL,'2013-07-13 11:35:30',NULL,'SS Jahari at Guard post, SS Kamal at Main Entrance, SO Razak at Main gate,',0,'Deployment',10),(429,NULL,'2013-07-13 12:03:54',NULL,'SS Jahari stationed at Guard Post SO Tarmizi stationed at Main Gate SO Razak went for his lunch break',0,'Deployment',10),(430,NULL,'2013-07-13 13:06:48',NULL,'SS Jahari stationed at Guard Post SO Razak stationed at Main Gate SO Tarmizi went for his lunch break',0,'Deployment',10),(431,NULL,'2013-07-13 13:56:36',NULL,'SO Razak stationed at Guard Post SO Tarmizi stationed at Main Gate SS Jahari went for his lunch break',0,'Deployment',10),(432,NULL,'2013-07-13 15:05:53',NULL,'SS Jahari stationed at Guard Post SO Razak stationed at Main Gate SO Tarmizi stationed at Main entrance',0,'Deployment',10),(433,NULL,'2013-07-13 15:59:22',NULL,'SO Tarmizi went for clocking around the estate.',0,'Clocking',10),(434,NULL,'2013-07-13 17:00:16',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(435,NULL,'2013-07-13 17:01:04',NULL,'SS Jahari stationed at Clubhouse SO Razak stationed at Main Gate SO Tarmizi stationed at Main entrance',0,'Deployment',10),(436,NULL,'2013-07-13 18:13:06',NULL,'SS Jahari went for patrolling around the estate.',0,'Patrolling',10),(437,NULL,'2013-07-13 19:25:21',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi stationed at Clubhouse',0,'Deployment',10),(438,NULL,'2013-07-13 20:57:19',NULL,'	SSRazak handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingl',0,'HAND OVER DUTY',10),(439,NULL,'2013-07-13 20:59:22',NULL,'	SS Kamal took over duty with situation as normal.',0,'TOOK OVER DUTY',10),(440,NULL,'2013-07-13 21:26:17',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'DELOYMENT',10),(441,NULL,'2013-07-13 21:59:42',NULL,'SS KAMAL AND SO ALI MAIN GATESO RAZAK WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE',0,'DEPLOYMENT',10),(442,NULL,'2013-07-13 22:06:16',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(443,NULL,'2013-07-13 22:08:16',NULL,'SS KAMAL AND SO RAZAK MAIN GATE',0,'DEPLOYMENT',10),(444,NULL,'2013-07-13 22:44:27',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(445,NULL,'2013-07-13 23:56:45',NULL,'SO RAZAK WENT TO LOCKED GYM ',0,'gym',10),(446,NULL,'2013-07-14 00:00:34',NULL,'DIARY CLOSED FOR 13\\7\\13 (SATURDAY)',1,'DIARY CLOSED',10),(447,NULL,'2013-07-14 00:02:44',NULL,'DIARY OPEN FOR 14\\7\\13 (SUNDAY)',1,'DIARY OPEN',10),(449,NULL,'2013-07-14 00:05:18',NULL,'SS KAMAL AND SO RAZAK AT MAIN GATE SO ALI AT CLUB HOUSE',0,'DEPLOYMENT',10),(451,NULL,'2013-07-14 02:03:36',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(452,NULL,'2013-07-14 02:04:33',NULL,'SO RAZAK WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(454,NULL,'2013-07-14 02:42:48',NULL,'SO RAZAK RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(455,NULL,'2013-07-14 04:02:09',NULL,'SS KAMA',0,'DEPLOYMENT',10),(456,NULL,'2013-07-14 04:03:30',NULL,'SSKAMAL AND SO RAZAK AT MAIN GAYE ',0,'DEPLOYMENT',10),(457,NULL,'2013-07-14 04:05:02',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(458,NULL,'2013-07-14 07:00:15',NULL,'CLOCKING CANCEL DUE TO RAIN',1,'CLOCKING',10),(459,NULL,'2013-07-14 07:04:51',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE ',0,'DEPLOYMENT',10),(460,NULL,'2013-07-14 08:58:13',NULL,'SS KAMAL HAND OVER DUTY TO SS RAZAK WITH KEY INTACT SITUATION AS NORMAL',0,'HAND OVER DUTY',10),(461,NULL,'2013-07-14 09:01:36',NULL,'SS RAZAK TOOK OVER DUTY FROM SS KAMAL SITUATION AS NORMAL',0,'TOOK OVER DUTY',10),(462,NULL,'2013-07-14 09:39:56',NULL,'	SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(463,NULL,'2013-07-14 10:19:11',NULL,'	SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(464,NULL,'2013-07-14 14:06:13',NULL,'	Late Entry 1400hrs,   SO Razak stationed at Main gate, SO Tarmizi stationed at Main entrance',0,'DEPLOYMENT',10),(465,NULL,'2013-07-14 16:36:25',NULL,'	SO Razak and SO Tarmizi standby at main gate.',0,'DEPLOYMENT',10),(466,NULL,'2013-07-14 18:56:14',NULL,' SO Razak stationed at Main gate, SO Tarmizi stationed at Main entrance',0,'DEPLOYMENT',10),(467,NULL,'2013-07-14 20:55:19',NULL,'	SSRAZAK HAND OVER DUTY TO SSKAMAL WITH KEY INTACT SITUATION AS NORMAL',0,'HAND OVER DUTY',10),(468,NULL,'2013-07-14 20:57:32',NULL,'	SS Kamal took over duty with situation as normal.',0,'TOOK OVER DUTY',10),(469,NULL,'2013-07-14 21:33:43',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'DEPLOYMENT',10),(470,NULL,'2013-07-14 21:59:37',NULL,'SO RAZAK WENT TO LOCKED FACILITY SITUATION AS NORMAL',0,'LOCKED FACILITY',10),(471,NULL,'2013-07-14 22:02:08',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(472,NULL,'2013-07-14 22:03:25',NULL,'SS KAMAL AND SO RAZAK STAND BY AT MAIN GATE',0,'DEPLOYMENT',10),(473,NULL,'2013-07-14 22:39:53',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(474,NULL,'2013-07-14 23:57:20',NULL,'SO RAZAK WENT TO LOCKED GYM',0,'GYM',10),(475,NULL,'2013-07-14 23:58:53',NULL,'DIARY CLOSED FOR 14\\7\\13 (SUNDAY}',1,'DIARY CLOSED',10),(476,NULL,'2013-07-15 00:01:20',NULL,'DIARY GPEN FOR 15\\7\\13 ( MONDAY )',1,'DIARY OPEN',10),(477,NULL,'2013-07-15 00:04:07',NULL,'SS KAMAL AND SO RAZAK AT MAIN GATE SO ALI AT CLUB HOUSE',0,'DEPLOYMENT',10),(478,NULL,'2013-07-15 02:00:16',NULL,'SS KAMAL AND SO ALI MAIN GATE',0,'DEPLOYMENT',10),(479,NULL,'2013-07-15 02:02:48',NULL,'SO RAZAK WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(480,NULL,'2013-07-15 02:51:17',NULL,'SO RAZAK RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'CLOCKING',10),(481,NULL,'2013-07-15 03:58:35',NULL,'SO RAZAK AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(482,NULL,'2013-07-15 03:59:35',NULL,'CLOCKING CANCEL DUE TO DRIZZLE RAIN',1,'CLOCKING',10),(483,NULL,'2013-07-15 05:57:18',NULL,' 	CLOCKING CANCEL DUE TO DRIZZLE RAIN',1,'CLOCKING',10),(484,NULL,'2013-07-15 06:01:19',NULL,'	SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'DEPLOYMENT',10),(485,NULL,'2013-07-15 07:01:32',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'DEPLOYMENT',10),(486,NULL,'2013-07-15 09:00:31',NULL,'SS KAMAL HAND OVER DUTY TO SSJAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'HAND OVER DUTY',10),(487,NULL,'2013-07-15 09:04:10',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(488,NULL,'2013-07-15 09:51:32',NULL,'SS Jahari at Guard post , SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(489,NULL,'2013-07-15 10:22:35',NULL,'SO Razak went for clocking around the estate, reported all in order',0,'Clocking',10),(490,NULL,'2013-07-15 11:29:57',NULL,'SO Razak returned from clocking and reported all in order',0,'Return',10),(491,NULL,'2013-07-15 12:14:38',NULL,'SS Jahari at Guard post, SO Tarmizi at Main gate, SO RAzak went for his lunch break',0,'Deployment',10),(492,NULL,'2013-07-15 13:10:19',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(493,NULL,'2013-07-15 14:04:51',NULL,'SS Jahari at went for his lunch break, SO Razak at Guard post, SO Tarmizi at Main gate',0,'Deployment',10),(494,NULL,'2013-07-15 15:08:34',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(495,NULL,'2013-07-15 16:30:20',NULL,'SO Tarmizi went for clocking around the estate.',0,'Clocking',10),(496,NULL,'2013-07-15 17:01:44',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(497,NULL,'2013-07-15 17:02:29',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(498,NULL,'2013-07-15 17:58:58',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(499,NULL,'2013-07-15 19:25:27',NULL,'SS Jahari went for patrolling around the estate, reported all in order',0,'Patrolling',10),(500,NULL,'2013-07-15 20:03:22',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate,',0,'Deployment',10),(501,NULL,'2013-07-15 21:00:09',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Hand Over Duty',10),(502,NULL,'2013-07-15 21:00:47',NULL,'SS Kamal took over duty from SS Jahari with situation normal',0,'Took Over Duty',10),(503,NULL,'2013-07-15 21:30:18',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(504,NULL,'2013-07-15 22:06:05',NULL,'SO ALI STAND BY AT MAIN GATE',0,'Deployment',10),(505,NULL,'2013-07-15 22:07:21',NULL,'SS KAMAL WENT TO LOCKED ALL FACILITY AND SWITCH OFF CLUB HOUSE LIGHT',0,'LOCKED FACILITY',10),(506,NULL,'2013-07-15 22:10:06',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(507,NULL,'2013-07-15 22:43:30',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(508,NULL,'2013-07-15 23:58:57',NULL,'DIARY CLOSED FOR 15\\7\\13 (MONDAY)',1,'DIARY CLOSED',10),(509,NULL,'2013-07-16 00:01:33',NULL,'DIARY OPEN FOR 16\\7\\13 (TUESDAY )',1,'DIARY OPEN',10),(510,NULL,'2013-07-16 00:03:49',NULL,'SS KAMAL WENT TO LOCKED GYM',0,'GYM',10),(511,NULL,'2013-07-16 00:05:05',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(512,NULL,'2013-07-16 00:15:48',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(513,NULL,'2013-07-16 01:59:34',NULL,'SO ALI AT MAIN GATE',0,'Deployment',10),(514,NULL,'2013-07-16 02:08:52',NULL,'SS KAMAL WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(515,NULL,'2013-07-16 02:58:39',NULL,'SS KAMAL RETURN FROM REPORT SITUATION NORMAL',0,'Return',10),(516,NULL,'2013-07-16 03:56:21',NULL,'ss kamal AT MAIN GATE',0,'Deployment',10),(517,NULL,'2013-07-16 03:58:17',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'ClockingL',10),(518,NULL,'2013-07-16 09:49:31',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEYS INTACT',0,'Hand Over Duty',10),(519,NULL,'2013-07-16 09:51:23',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(520,NULL,'2013-07-16 10:01:28',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate. SO Razak went for clocking around the estate.',0,'Deployment',10),(521,NULL,'2013-07-16 11:09:17',NULL,'SS Jahari at Guard post, SO Tarmizi at Main gate,\r\nSO Razak returned from clocking and reported all in order and proceeded to stand by at Clubhouse',0,'Deployment',10),(522,NULL,'2013-07-16 12:09:17',NULL,'SS Jahari at Guard post, SO Tarmizi at Main gate, SO Razak went for his lunch break',0,'Deployment',10),(523,NULL,'2013-07-16 12:10:17',NULL,'SMA Mr.Alsagoff and Mr. Syed Kadir visited Changi Court,\r\nSS Jahari and SO Tarmizi standby at Main entrance',1,'VISIT',10),(524,NULL,'2013-07-16 12:41:21',NULL,'Mr Alsagoff and Mr.Kadir from SMA left Changi Court premises',0,'Left',10),(525,NULL,'2013-07-16 13:01:21',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(526,NULL,'2013-07-16 14:00:15',NULL,'SS Jahari went for his lunch break SO Razak stand by at Guard post, SO Tarmizi stand by at Main entrance',0,'Deployment',10),(527,NULL,'2013-07-16 15:07:04',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(528,NULL,'2013-07-16 16:13:16',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(529,NULL,'2013-07-16 16:54:06',NULL,'SO Tarmizi returned from clocking, reported all in order,',0,'Return',10),(530,NULL,'2013-07-16 16:54:52',NULL,'SS Jahari at Clubhouse, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(531,NULL,'2013-07-16 18:25:36',NULL,'	SS Jahari at Clubhouse, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(532,NULL,'2013-07-16 19:16:04',NULL,'SS Jahari went for patrolling around the estate and reported all in order',0,'Patrolling',10),(533,NULL,'2013-07-16 20:05:43',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(534,NULL,'2013-07-16 21:00:30',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Hand Over Duty',10),(535,NULL,'2013-07-16 21:00:54',NULL,'SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(536,NULL,'2013-07-16 21:36:44',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(537,NULL,'2013-07-16 21:58:14',NULL,'SO JOHARI WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT SITUATION NORMAL',0,'LOCKED FACILITY',10),(538,NULL,'2013-07-16 22:03:11',NULL,'SO JOHARI WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(539,NULL,'2013-07-16 22:45:30',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(540,NULL,'2013-07-16 23:58:46',NULL,'DIARY CLOSED FOR 16\\7\\13 ( TUESDAY)',1,'DIARY CLOSED',10),(541,NULL,'2013-07-17 00:01:13',NULL,'DIARY OPEN FOR 17\\7\\13 ( WEDNESDAY )',1,'DIARY OPEN',10),(542,NULL,'2013-07-17 00:05:00',NULL,'SS KAMAL AND SO JOHARI MAIN GATE SO ALI AT CLUB HOUSE',0,'Deployment',10),(543,NULL,'2013-07-17 02:00:16',NULL,'SS KAMAL AND SO JOHARI MAIN GATE',0,'Deployment',10),(544,NULL,'2013-07-17 02:01:39',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'ClockingL',10),(545,NULL,'2013-07-17 02:43:02',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMSL',0,'Return',10),(546,NULL,'2013-07-17 03:58:09',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(547,NULL,'2013-07-17 03:59:11',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(548,NULL,'2013-07-17 06:01:38',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(549,NULL,'2013-07-17 06:02:54',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(550,NULL,'2013-07-17 06:57:26',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMRL',0,'Return',10),(551,NULL,'2013-07-17 06:58:49',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE  ',0,'Deployment',10),(552,NULL,'2013-07-17 08:57:48',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'Hand Over Duty',10),(553,NULL,'2013-07-17 09:03:07',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(554,NULL,'2013-07-17 10:31:48',NULL,'Late Entry\r\nSS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak stationed at Main entrance',0,'Deployment',10),(555,NULL,'2013-07-17 11:03:52',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance, SO Razak stationed at Main gate',0,'Deployment',10),(556,NULL,'2013-07-17 12:10:37',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak went for his lunch break',0,'Deployment',10),(557,NULL,'2013-07-17 13:10:13',NULL,'SO Razak relieved SO Tarmizi at the Main Gate. SO Tarmizi went for his lunch break',0,'Relief',10),(558,NULL,'2013-07-17 16:22:05',NULL,'Late entry, 1405hrs\r\nSO Tarmizi relieved SS Jahari at Guard post,\r\nSS Jahari went for his lunch break',0,'Relief',10),(559,NULL,'2013-07-17 16:23:03',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(560,NULL,'2013-07-17 17:03:14',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(561,NULL,'2013-07-17 17:03:52',NULL,'SS Jahari stationed at Clubhouse, SO Razak at Guard post, SO Tarmizi at Main entrance',0,'Deployment',10),(562,NULL,'2013-07-17 18:37:52',NULL,'	SS Jahari stationed at Clubhouse, SO Razak at Guard post, SO Tarmizi at Main entrance',0,'Deployment',10),(563,NULL,'2013-07-17 19:15:28',NULL,'SS Jahari went for patrolling around the estate, reported all in order',0,'Patrolling',10),(564,NULL,'2013-07-17 20:12:31',NULL,'SS Jahari stand by at Guard post, SO Razak stand by at Main gate. SO Tarmizi at Main entrance',0,'Deployment',10),(565,NULL,'2013-07-17 21:00:52',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Hand Over Duty',10),(566,NULL,'2013-07-17 21:01:18',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI',0,'Took Over Duty',10),(567,NULL,'2013-07-17 21:41:47',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(568,NULL,'2013-07-17 22:00:23',NULL,'SO JOHARI WENT LOCKED BADMINTON COURT AND SWICTH OFF CLUB HOUSE LIGHT',0,'LOCKED FACILITY',10),(569,NULL,'2013-07-17 22:02:41',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(570,NULL,'2013-07-17 22:03:36',NULL,'SO JOHARI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(571,NULL,'2013-07-17 22:42:17',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(572,NULL,'2013-07-17 23:59:47',NULL,'DIARY CLOSED FOR 17\\7\\13 (WEDNESDAY)',1,'DIARY CLOSED',10),(573,NULL,'2013-07-18 00:01:35',NULL,'DIARY OPEN FOR 18\\7\\13 (THURSDAY)',0,'DIARY OPEN',10),(574,NULL,'2013-07-18 00:03:02',NULL,'SO JOHARI WENT TO LOCKED GYM',0,'GYM',10),(575,NULL,'2013-07-18 00:04:56',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE SO ALI AT CLUB HOUSE',0,'Deployment',10),(576,NULL,'2013-07-18 02:00:39',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(577,NULL,'2013-07-18 02:01:48',NULL,'SO JOHARI WENT CLOCKING AROUND E5TATE AREA',0,'Clocking',10),(578,NULL,'2013-07-18 02:40:38',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(579,NULL,'2013-07-18 04:00:22',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(580,NULL,'2013-07-18 04:01:41',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(581,NULL,'2013-07-18 06:08:06',NULL,'SS KAMAL AND SO ALI AT MAJN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(582,NULL,'2013-07-18 06:09:35',NULL,'CLOCKING CANCEL DUE TO RAIN',1,'Clocking',10),(583,NULL,'2013-07-18 07:02:51',NULL,'SS KAMAL AND SO ALI AT MAJN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(584,NULL,'2013-07-18 08:59:36',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI ALL KEYS SITUATION AS NORMAL',0,'Hand Over Duty',10),(585,NULL,'2013-07-18 09:05:21',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(586,NULL,'2013-07-18 10:01:28',NULL,'SS Jahari stationed at guard post, SO Tarmizi at main entrance, SO Razak at clubhouse',0,'Deployment',10),(587,NULL,'2013-07-18 10:04:19',NULL,'Clocking was cancelled due to heavy rain',1,'Clocking',10),(588,NULL,'2013-07-18 11:10:43',NULL,'SS Jahari at guard post, SO Razak at clubhouse, SO Tarmizi at main gate',0,'Deployment',10),(589,NULL,'2013-07-18 11:51:55',NULL,'SO Razak went for his lunch break',0,'Lunch Break',10),(590,NULL,'2013-07-18 13:45:12',NULL,'Late Entry 1300hrs\r\nSO Razak relieved SO Tarmizi at main gate.\r\nSO Tarmizi went for his lunch break.',0,'Relief',10),(591,NULL,'2013-07-18 14:13:50',NULL,'SO Tarmizi relieved SS Jahari at guard post.\r\nSS Jahari went for his lunch break',0,'Relief',10),(592,NULL,'2013-07-18 15:01:09',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(593,NULL,'2013-07-18 16:06:04',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate. SO Tarmizi went for clocking around the estate.',0,'Deployment',10),(594,NULL,'2013-07-18 17:07:32',NULL,'SS Jahari stationed at Clubhouse, SO Razak at Guard post, SO Tarmizi returned from clocking and stand by at main gate',0,'Deployment',10),(595,NULL,'2013-07-18 19:11:52',NULL,'SO Razak stationed at guard post, SO Tarmizi stationed at main gate',0,'Deployment',10),(596,NULL,'2013-07-18 19:12:30',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(597,NULL,'2013-07-18 21:00:17',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly',0,'Hand Over Duty',10),(598,NULL,'2013-07-18 21:00:50',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'Took Over Duty',10),(599,NULL,'2013-07-18 21:15:31',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'Deployment',10),(600,NULL,'2013-07-18 21:59:36',NULL,'SO RAZAK WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT SITUATION NORMAL ',0,'LOCKED FACILITY',10),(601,NULL,'2013-07-18 22:02:02',NULL,'CLOCKING CANCEL DUE DRIZZLE RAIN',1,'Clocking',10),(602,NULL,'2013-07-18 22:03:32',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'Deployment',10),(603,NULL,'2013-07-18 23:59:21',NULL,'DIARY CLOSED FOR 18\\7\\13 (THURSDAY)',1,'DIARY CLOSED',10),(604,NULL,'2013-07-19 00:01:32',NULL,'DIARY OPEN FOR 19\\7\\13 (FRIDAY )',1,'DIARY OPEN',10),(605,NULL,'2013-07-19 00:02:48',NULL,'SO RAZAK WENT TO LOCKED GYM',0,'GYM',10),(606,NULL,'2013-07-19 00:04:59',NULL,'SS KAMAL AND SO RAZAK AT MAIN GATE SO ALI AT CLUB HOUSE',0,'Deployment',10),(607,NULL,'2013-07-19 02:00:17',NULL,'	SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK AT CLUB HOUSE',0,'Deployment',10),(608,NULL,'2013-07-19 02:02:11',NULL,'	SO ALI WENT CLOCKING AROUND ESTATE AREA',1,'Clocking',10),(609,NULL,'2013-07-19 02:41:44',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(610,NULL,'2013-07-19 03:57:14',NULL,'	S/O Razak AND SO Ali AT MAIN GATE S/S Kamal  AT CLUB HOUSE',0,'Deployment',10),(611,NULL,'2013-07-19 04:00:20',NULL,' 	SORazak  WENT CLOCKING AROUND ESTATE AREA',1,'Clocking',10),(612,NULL,'2013-07-19 04:41:55',NULL,'	S/O Razak RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'Return',10),(614,NULL,'2013-07-19 05:58:53',NULL,'	SS KAMAL AND SO ALI AT MAIN GATE SO RAZAK Left For Clocking S/Normal ',0,'Deployment',10),(615,NULL,'2013-07-19 06:02:00',NULL,' 	SORazak WENT CLOCKING AROUND ESTATE AREA',1,'Clocking',10),(616,NULL,'2013-07-19 06:49:53',NULL,'SO RAZAK RETURN FROM CLOCKING REPORT SITUATION AS NORMAL',0,'Return',10),(617,NULL,'2013-07-19 07:08:03',NULL,'SS KAMAL AND SO ALI AT MALN GATE SO RAZAK AT CLUB HOUSE',0,'Deployment',10),(618,NULL,'2013-07-19 09:11:19',NULL,'	SSKAMAL handed over duty to SS JAHARI with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Hand Over Duty',10),(619,NULL,'2013-07-19 09:12:19',NULL,'	SS Jahari took over duty with situation normal',0,'Took Over Duty',10),(620,NULL,'2013-07-19 10:18:55',NULL,'	SS Jahari at Guard post, s/o Tarmizi at Main Entrance, SO Razak at Clubhouse,',0,'Deployment',10),(621,NULL,'2013-07-19 11:08:14',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(622,NULL,'2013-07-19 14:19:11',NULL,'Late Entry 1200hrs,SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak went for his lunch break',0,'Deployment',10),(623,NULL,'2013-07-19 14:20:10',NULL,'Late Entry, 1300hrs,\r\nSS Jahari stationed at Guard post, SO Razak at Main entrance, SO Tarmizi went for his lunch break.',0,'Deployment',10),(624,NULL,'2013-07-19 14:21:19',NULL,'Late entry, 1400hrs,\r\nSS Jahari went for his lunch break, SO Razak at Guard post, SO Tarmizi at Main entrance.',0,'Deployment',10),(625,NULL,'2013-07-19 16:11:12',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(626,NULL,'2013-07-19 16:11:39',NULL,'SMA OP Manager Mr. Syed Kadir visited Changi Court condo, SS Jahari and SO Razak on duty at guard post.',1,'VISIT',10),(627,NULL,'2013-07-19 17:35:15',NULL,'Late Entry 1700hrs,\r\nSO Tarmizi returned from clocking and reported all in order.',0,'Return',10),(628,NULL,'2013-07-19 17:36:47',NULL,'SMA OP Manager Mr. Syed Kadir left Changi Court condo, ',0,'Left',10),(629,NULL,'2013-07-19 17:37:18',NULL,'SSJahari stationed at Clubhouse, SO RAzak stationed at Guard post, SO Tarmizi stationed at Main gate',0,'Deployment',10),(630,NULL,'2013-07-19 19:18:02',NULL,'SS Jahari went for patrolling around the estate, reported all in order',0,'Patrolling',10),(631,NULL,'2013-07-19 21:00:00',NULL,'S/o jAHARI handed over duty to s/o RAZAK  with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Hand Over Duty',10),(632,NULL,'2013-07-19 21:03:32',NULL,'S/O Razak  took over duty with situation normal',0,'Took Over Duty',10),(633,NULL,'2013-07-19 21:26:34',NULL,'S/S Razak at G/Post S/O ali at Main Gate',0,'Deployment',10),(634,NULL,'2013-07-19 22:55:36',NULL,'	S/S Razak at G/Post S/O ali at Main Gate',0,'Deployment',10),(635,NULL,'2013-07-19 23:55:42',NULL,'	SO RAZAK WENT TO LOCKED GYM',0,'GYM',10),(636,NULL,'2013-07-19 23:56:57',NULL,' 	Diary closed for dated 19/7/13 ( friday) ',1,'DIARY CLOSED',10),(637,NULL,'2013-07-19 23:58:07',NULL,' 	Diary opened for dated 20///7/13 ( saturday)',1,'DIARY OPEN',10),(638,NULL,'2013-07-20 04:46:42',NULL,'	S/S Razak at G/Post S/O ali at Main Gate',0,'Deployment',10),(639,NULL,'2013-07-20 06:06:26',NULL,'	S/S Razak at G/Post S/O ali at Main Gate',0,'Deployment',10),(640,NULL,'2013-07-20 08:02:35',NULL,'	S/S Razak at G/Post S/O ali at Main Gate',0,'Deployment',10),(641,NULL,'2013-07-20 10:09:21',NULL,'late ENTRY 0900 hrs S/O Razak Hand Over Duty To SS JAHARI WITH All In Order',0,'Hand Over Duty',10),(642,NULL,'2013-07-20 10:14:13',NULL,'Late Entry 0900hrs,\r\nSS Jahari took over duty from SO Razak with situation normal.',0,'Took Over Duty',10),(643,NULL,'2013-07-20 10:32:18',NULL,'Late Entry 0905hrs,\r\nSS Jahari at Guard post, SO Tarmizi at Main gate, SO Razak at Clubhouse.',0,'Deployment',10),(644,NULL,'2013-07-20 10:33:21',NULL,'SS Jahari went for patrolling around the estate,reported all in order',0,'Patrolling',10),(645,NULL,'2013-07-20 11:20:11',NULL,'SS Jahari at Guard post, SO Tarmizi at Main gate, SO Razak at Clubhouse.',0,'Deployment',10),(646,NULL,'2013-07-20 12:25:35',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak went for his lunch break.',0,'Deployment',10),(647,NULL,'2013-07-20 13:08:28',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi went for his lunch break.',0,'Deployment',10),(648,NULL,'2013-07-20 14:09:22',NULL,'SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate, SS Jahari went for his lunch break.',0,'Deployment',10),(649,NULL,'2013-07-20 15:16:34',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate,SO Tarmizi stationed at Main entrance',0,'Deployment',10),(650,NULL,'2013-07-20 16:11:26',NULL,'SO Tarmizi went for clocking around the estate',0,'Clocking',10),(651,NULL,'2013-07-20 16:40:54',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(652,NULL,'2013-07-20 18:20:10',NULL,'	SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main Gate ',0,'Deployment',10),(653,NULL,'2013-07-20 19:14:17',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(655,NULL,'2013-07-20 20:38:20',NULL,'Pls refer to security report on Swimming Pool Incident Report dated 20/07/13 incident happen at about 1608hrs.',1,'SWIMMING POOL INCIDENT',10),(656,NULL,'2013-07-20 21:14:42',NULL,'	SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Hand Over Duty',10),(657,NULL,'2013-07-20 21:15:25',NULL,'	SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(658,NULL,'2013-07-20 21:42:01',NULL,'ss kamal and so ali at main gate so razak at club club house',0,'Deployment',10),(659,NULL,'2013-07-20 22:02:06',NULL,'so razak went to locked badminton court and switch off club house light ',0,'LOCKED FACILITY',10),(660,NULL,'2013-07-20 22:04:24',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(661,NULL,'2013-07-20 22:05:11',NULL,'so razak went patrolling around estate area',0,'patrolling',10),(662,NULL,'2013-07-20 23:27:30',NULL,'while ss kamal went to rest room spotted tenant from block 698 02-06 smoking at poolside area  ss kamal advise the tenant and he oblige',1,'report',10),(663,NULL,'2013-07-21 00:00:36',NULL,'diary closed for 20\\7\\13 (saturday )',1,'DIARY CLOSED',10),(664,NULL,'2013-07-21 00:03:21',NULL,'diary opened for 21\\7\\13 (sunday )',1,'DIARY OPEN',10),(665,NULL,'2013-07-21 00:05:44',NULL,'so razak went to locked gym ',0,'GYM',10),(666,NULL,'2013-07-21 00:06:38',NULL,'ss kamal and so razak at main gate so ali at club house',0,'Deployment',10),(667,NULL,'2013-07-21 01:57:53',NULL,'ss kamal and so razak at main gate',0,'Deployment',10),(668,NULL,'2013-07-21 01:59:08',NULL,'so ali went patrolling aroud estate area',0,'Patrolling',10),(669,NULL,'2013-07-21 02:42:02',NULL,'so ali return from patrol report situation normal',0,'Return',10),(671,NULL,'2013-07-21 03:59:59',NULL,'	S/o ALI and SO Razak standby at main gate.S/S Kamal Went For BREAK',0,'Deployment',10),(672,NULL,'2013-07-21 04:04:04',NULL,'	Clocking was cancelled due to heavy rain',1,'Clocking',10),(674,NULL,'2013-07-21 05:57:47',NULL,'	SS KAMAL AND SO ALI MAIN ENTRANCE SO RAZAK WENT FOR CLOCKING',0,'Deployment',10),(676,NULL,'2013-07-21 06:57:50',NULL,'so razak return from patrol report situation normal',0,'Return',10),(677,NULL,'2013-07-21 06:59:40',NULL,'ss kamal and so ali at main gate so razak at club house',0,'Deployment',10),(678,NULL,'2013-07-21 08:58:58',NULL,'ss kamal hand over duty to ss jahari with all keys intact situation as normal',0,'Hand Over Duty',10),(679,NULL,'2013-07-21 09:03:39',NULL,'SS Jahari took over duty from SS Kamal with situation as normal.',0,'Took Over Duty',10),(680,NULL,'2013-07-21 11:22:56',NULL,'Late Entry 0905hrs,\r\nSS Jahari stationed Guard post, SO Razak stationed at Main entrance.',0,'Deployment',10),(681,NULL,'2013-07-21 11:24:09',NULL,'SS Jahari went for patrolling around the estate reported all in order. ',0,'Patrolling',10),(682,NULL,'2013-07-21 15:35:17',NULL,'Late entry 1230hrs, \r\nSS Jahari stationed at the Guard post, SO Razak stationed at the Main gate.',0,'Deployment',10),(683,NULL,'2013-07-21 15:36:44',NULL,'Late entry 1430hrs, \r\nSS Jahari stationed at the Clubhouse, SO Razak stationed at the Guard house.',0,'Deployment',10),(684,NULL,'2013-07-21 16:10:42',NULL,'MP Mr. Malaki Osman and his grassroot from Siglap came Changi Court Condo with car no: SJR 8924 T for \"House Visit\" at B698 & B700.',1,'VISIT',10),(685,NULL,'2013-07-21 17:17:57',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance,',0,'Deployment',10),(686,NULL,'2013-07-21 17:22:57',NULL,'Reference serial nos. 640 left Changi Court condo. ',1,'LEFT',10),(687,NULL,'2013-07-21 18:33:08',NULL,'Late entry 1800 hrs,\r\nSS Jahari at Guard post, SO Razak stationed at main entrance.',0,'Deployment',10),(688,NULL,'2013-07-21 18:33:57',NULL,'Police Officer from Bedok Police Statione Name: SGT Abdul Rahman came to Changi Court with QX 4906 H to B702 #04-03 as the tenant had called for Police as they are having a dispute among themselve',1,'POLICE',10),(689,NULL,'2013-07-21 18:50:55',NULL,'Reference serial nos 644 left estate.',0,'LEFT',10),(690,NULL,'2013-07-21 19:15:18',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(691,NULL,'2013-07-21 21:00:50',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Hand Over Duty',10),(692,NULL,'2013-07-21 21:02:56',NULL,'SS Kamal took over duty with situation as normal.',0,'Took Over Duty',10),(693,NULL,'2013-07-21 21:59:02',NULL,'so razak went to locked badminton court and switch club house light',0,'LOCKED FACILITY',10),(694,NULL,'2013-07-21 22:02:18',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(695,NULL,'2013-07-21 22:03:02',NULL,'so razak went clocking around estate area',0,'Clocking',10),(696,NULL,'2013-07-21 22:48:30',NULL,'so razak return from clocking report situation normal',0,'Return',10),(697,NULL,'2013-07-21 23:59:08',NULL,'diary closed for 21\\7\\13 (sunday )',1,'DIARY CLOSED',10),(698,NULL,'2013-07-22 00:01:13',NULL,'diary open for 22\\7\\13 ( monday )',0,'DIARY OPEN',10),(699,NULL,'2013-07-22 00:02:32',NULL,'so razak went to locked gym and switch off light',0,'GYM',10),(700,NULL,'2013-07-22 00:03:58',NULL,'ss kamal and so razak at main gate',0,'Deployment',10),(701,NULL,'2013-07-22 00:07:47',NULL,'so ali went for his break',0,'break',10),(702,NULL,'2013-07-22 01:02:02',NULL,'so ali return from break',0,'Return',10),(703,NULL,'2013-07-22 01:03:23',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(704,NULL,'2013-07-22 01:04:04',NULL,'so razak went for his break',0,'break',10),(705,NULL,'2013-07-22 01:59:48',NULL,'so razak return from break',0,'Return',10),(706,NULL,'2013-07-22 01:59:48',NULL,'so razak return from break',0,'Return',10),(707,NULL,'2013-07-22 02:08:29',NULL,'so ali went for clocking around estate are',0,'Clocking',10),(708,NULL,'2013-07-22 02:53:22',NULL,'so ali return from clocking report situation as normal',0,'Return',10),(709,NULL,'2013-07-22 02:56:01',NULL,'ss kamal guard post so ali and so razak at main gate',0,'Deployment',10),(710,NULL,'2013-07-22 03:59:14',NULL,'SS KAMAL AND SO RAZAK MAIN ENTRANCE SO ALI WENT FOR CLOCKING',0,'Deployment',10),(711,NULL,'2013-07-22 05:48:36',NULL,'so ali return from clocking report situation as normal',0,'Return',10),(712,NULL,'2013-07-22 06:53:25',NULL,'so razak return from clocking report situation normal',0,'Return',10),(713,NULL,'2013-07-22 06:54:45',NULL,'ss kamal and so ali at main gate so razak at guard house',0,'Deployment',10),(714,NULL,'2013-07-22 09:01:45',NULL,'ss kamal hand over duty to ss jahari with all keys intact situation normal',0,'Hand Over Duty',10),(715,NULL,'2013-07-22 09:03:30',NULL,'SS Jahari took over duty from SS Kamal with situation normal',0,'Took Over Duty',10),(716,NULL,'2013-07-22 11:13:29',NULL,'Late entry 0905hrs,SS Jahari stationed at Guard post, SS Kamal at Main gate, SO Tarmizi stationed at Main entrance.',0,'Deployment',10),(717,NULL,'2013-07-22 11:14:29',NULL,'Late entry, 0930hrs to 1030hrs,\r\nSS Jahari went to management office to briefed Ms Hanis event happening on Saturday and Sunday and submit Security report.',0,'Report',10),(718,NULL,'2013-07-22 11:16:26',NULL,'SS Jahari went for patrolling around the estate to checked on contractors working and reported all in order.',0,'Patrolling',10),(719,NULL,'2013-07-22 14:11:50',NULL,'Late Entry 1200hrs,\r\nSS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance,',0,'Deployment',10),(720,NULL,'2013-07-22 14:12:56',NULL,'Late Entry 1300hrs,\r\nSO Tarmizi went for his lunch break',0,'Lunch Break',10),(721,NULL,'2013-07-22 14:13:37',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main entrance',0,'Deployment',10),(722,NULL,'2013-07-22 15:31:36',NULL,'SS Jahari stationed at the Guard post, SS Tarmizi stationed at the Main entrance',0,'Deployment',10),(723,NULL,'2013-07-22 20:08:53',NULL,'Late entry 1700hrs,\r\nSS Jahari and SO Tarmizi stationed at the main entrance.',0,'Deployment',10),(724,NULL,'2013-07-22 20:09:43',NULL,'Situation all as normal',0,'Report',10),(725,NULL,'2013-07-22 21:05:42',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Hand Over Duty',10),(726,NULL,'2013-07-22 21:06:25',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI SITUATION NORMAL',0,'Took over duty',10),(727,NULL,'2013-07-22 21:28:47',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(728,NULL,'2013-07-22 22:08:41',NULL,'SS KAMAL WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT',0,'LOCKED FACILITY',10),(729,NULL,'2013-07-22 22:11:41',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(730,NULL,'2013-07-22 22:12:45',NULL,'SS KAMAL STAND BY AT MAIN GATE',0,'DEPLOYMENT',10),(731,NULL,'2013-07-22 22:58:24',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(732,NULL,'2013-07-22 23:57:55',NULL,'DIARY CLOSED FOR 22\\7\\13 (monday )',1,'DIARY CLOSE',10),(733,NULL,'2013-07-23 00:00:10',NULL,'DIARY OPENED FOR 23\\7\\13 (tuesday )',1,'DIARY OPENED',10),(734,NULL,'2013-07-23 00:10:55',NULL,'SS KAMAL WENT TO LOCKED GYM',0,'GYM',10),(735,NULL,'2013-07-23 00:11:55',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(736,NULL,'2013-07-23 02:06:42',NULL,'SO ALI STAND BY MAIN GATE',0,'DEPLOYMENT',10),(737,NULL,'2013-07-23 02:07:49',NULL,'SS KAMAL WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(738,NULL,'2013-07-23 03:08:42',NULL,'SS KAMAL RETURN BACK FROM CLOCKING REPORT SITUATION NORMAL',0,'R',10),(739,NULL,'2013-07-23 03:59:02',NULL,'SO ALI STAND BY AT MAIN GATE',0,'DEPLOYMENTS',10),(740,NULL,'2013-07-23 04:00:21',NULL,'SS KAMAL WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(741,NULL,'2013-07-23 06:22:41',NULL,'SO ALI WENT CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(742,NULL,'2013-07-23 06:24:32',NULL,'SS KAMAL STAND BY AT MAIN GATE',0,'DEPLOYMENT',10),(743,NULL,'2013-07-23 06:52:02',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(744,NULL,'2013-07-23 06:53:38',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(745,NULL,'2013-07-23 09:00:58',NULL,'SS KAMAL HAND OVER DUTY TO SS JAHARI WITH ALL KEYS INTACT SITUATION NORMAL',0,'HAND OVER DUTY',10),(746,NULL,'2013-07-23 09:03:10',NULL,'SS Jahari took over duty from SS Kamal with situation reported all in order.',0,'Took Over Duty',10),(747,NULL,'2013-07-23 09:41:25',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi at main gate',0,'Deployment',10),(748,NULL,'2013-07-23 11:09:10',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(749,NULL,'2013-07-23 11:09:56',NULL,'SO Razak informed Tech Abdullah that B702B Fireman lift 2 door could not closed.',1,'B702 Fiereman Lift 2',10),(750,NULL,'2013-07-23 16:58:08',NULL,'Late entry 1200hrs,\r\nSS Jahari at guard post, SO Tarmizi at Main gate,\r\nSO Razak went for his lunch break',0,'Deployment',10),(751,NULL,'2013-07-23 16:59:15',NULL,'Late Entry 1300hrs,\r\nSS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(752,NULL,'2013-07-23 17:00:18',NULL,'Late Entry 1400hrs,\r\nSO Tarmizi at Guard post, SO Razak at Main gate, SS Jahari went for his lunch break',0,'Deployment',10),(753,NULL,'2013-07-23 17:08:47',NULL,'Late entry 1600hrs,\r\nSO Tarmizi went for clocking around the estate reported all in order.',0,'Clocking',10),(754,NULL,'2013-07-23 17:09:39',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(755,NULL,'2013-07-23 19:01:57',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse,',0,'Deployment',10),(756,NULL,'2013-07-23 21:00:30',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Hand Over Duty',10),(757,NULL,'2013-07-23 21:01:15',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI',0,'TOOK OVER DUTY',10),(758,NULL,'2013-07-23 21:33:49',NULL,'SS KAMAL AND SO ALI MAIN GATE SO JOHARI AT CLUB HOUSE',0,'DEPLOYMENT',10),(759,NULL,'2013-07-23 21:58:51',NULL,'SO JOHARI WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT',0,'LOCKED FACILITY',10),(760,NULL,'2013-07-23 22:00:50',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'CLOCKING',10),(761,NULL,'2013-07-23 22:01:47',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'DEPLOYMENT',10),(762,NULL,'2013-07-23 22:52:40',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'RETURN',10),(763,NULL,'2013-07-23 23:58:30',NULL,'DIARY CLOSED FOR 23\\7\\13 (tuesday )',1,'DIARY CLOSE',10),(764,NULL,'2013-07-24 00:00:23',NULL,'DIARY OPENED FOR 24\\7\\13 (wednesday )',1,'DIARY OPENED',10),(765,NULL,'2013-07-24 00:03:05',NULL,'so johari went to locked gym',0,'GYM',10),(766,NULL,'2013-07-24 00:04:05',NULL,'ss kamal and so johari at main gate so ali at club house',0,'DEPLOYMENT',10),(767,NULL,'2013-07-24 02:01:22',NULL,'ss kamal and so ali at main gate',0,'DEPLOYMENT',10),(768,NULL,'2013-07-24 02:02:13',NULL,'so johari went clocking around estate area',0,'CLOCKING',10),(769,NULL,'2013-07-24 03:00:15',NULL,'so ali return from clocking report situation  normal',0,'RETURN',10),(770,NULL,'2013-07-24 04:03:39',NULL,'ss kamaland so johari at main gate ',0,'DEPLOYMENT',10),(771,NULL,'2013-07-24 04:05:36',NULL,'so ali went for clocking around estate area',0,'CLOCKING',10),(772,NULL,'2013-07-24 06:42:32',NULL,'so johari went clocking around estate area',0,'CLOCKINGso',10),(773,NULL,'2013-07-24 06:44:16',NULL,'ss kamal and so ali at main gate',0,'DEPLOYMENT',10),(774,NULL,'2013-07-24 06:56:00',NULL,'so johari return from clocking report situation normal',0,'RETURN',10),(775,NULL,'2013-07-24 06:57:16',NULL,'ss kamal and so ali at main gate so johari at club house',0,'DEPLOYMENT',10),(776,NULL,'2013-07-24 08:53:42',NULL,'sma operation manager mr syed kader visit changi court',1,'visit by sma om',10),(777,NULL,'2013-07-24 08:59:08',NULL,'ss kamal hand over duty to ss jahari with all key intact situation as normal',0,'HAND OVER DUTY',10),(778,NULL,'2013-07-24 09:01:28',NULL,'SS Jahari took over duty from SS Kamal with situation as normal',0,'Took Over Duty',10),(779,NULL,'2013-07-24 10:07:59',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi at main gate',0,'Deployment',10),(780,NULL,'2013-07-24 11:33:09',NULL,'Late Entry 1030hrs,\r\nSO Razak went for clocking around the estate, reported all in order.',0,'Clocking',10),(781,NULL,'2013-07-24 11:54:58',NULL,'SS Jahari stationed at Guard Post, SO Tarmizi stationed at Main Entrance, SO Razak went for his lunch break ',0,'Deployment',10),(782,NULL,'2013-07-24 13:05:56',NULL,'SO Razak relieved SO Tarmizi at Main gate for his lunch break',0,'Relief',10),(783,NULL,'2013-07-24 14:04:15',NULL,'SO Tarmizi relieved SS Jahari at Guard post for his lunch break',0,'Relief',10),(784,NULL,'2013-07-24 15:59:36',NULL,'SGT Ng from Changi NPP arrived to visit the management office with car no: QX 542 A',1,'POLICE TO MANAGEMENT OFFCE',10),(785,NULL,'2013-07-24 16:10:24',NULL,'Reference serial nos 471 left the estate',0,'Left',10),(786,NULL,'2013-07-24 17:22:20',NULL,'Late Entry 1615hrs,\r\nSO Tarmizi went for clocking around the estate, reported all in order.',0,'Clocking',10),(787,NULL,'2013-07-24 17:23:23',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(788,NULL,'2013-07-24 18:12:12',NULL,'S/O Tarmizi stationed at Guard Post, SO Razak stationed at Main Entr S/SJahari stationed at Clubhouse, ',0,'Deployment',10),(789,NULL,'2013-07-24 19:12:11',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(790,NULL,'2013-07-24 20:58:20',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Deployment',10),(791,NULL,'2013-07-24 21:02:08',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI',0,'hand over duty',10),(792,NULL,'2013-07-24 21:34:23',NULL,'ss kamal and so ali at main gate so johari club house',0,'Deployment',10),(793,NULL,'2013-07-24 22:00:10',NULL,'so johari went to locked badminton court and switch off club house light',0,'locked facilityl',10),(794,NULL,'2013-07-24 22:03:44',NULL,'ss kamal and so johari at main gate',0,'Deployments',10),(795,NULL,'2013-07-24 22:04:56',NULL,'so ali went clocking around estate area',0,'Clocking',10),(796,NULL,'2013-07-24 23:58:28',NULL,'diary closed for 24\\7\\13 (wednesday )',1,'diary closed',10),(797,NULL,'2013-07-25 00:02:10',NULL,'diary opened for 25\\7\\13 ( thursday )',0,'diary opened',10),(798,NULL,'2013-07-25 00:03:56',NULL,'so johari went to locked gym',0,'gym',10),(799,NULL,'2013-07-25 00:04:58',NULL,'ss kamal and so johari at main gate so ali at club house',0,'Deployment',10),(800,NULL,'2013-07-25 01:57:44',NULL,'ss kamal and so ali main gate',0,'Deployment',10),(801,NULL,'2013-07-25 02:01:04',NULL,'so johari went clocking around estate area',0,'Clocking',10),(802,NULL,'2013-07-25 02:58:30',NULL,'johari return from clocking report situation normal',0,'return',10),(803,NULL,'2013-07-25 04:06:14',NULL,'S/O KAMAL & S/O JOHARI AT M/GATE .',0,'Deployment',10),(804,NULL,'2013-07-25 04:06:56',NULL,'S/O ALI WENT FOR CLOCKING AROUND THE ESTATE .',0,'Clocking',10),(805,NULL,'2013-07-25 05:29:41',NULL,'S/O ALI RETURN FROM CLOCKING REPORTING S/NORMAL ',0,'return',10),(806,NULL,'2013-07-25 06:08:28',NULL,'SS KAMAL AND SO ALI AT MAIN GATE',0,'Deployment',10),(807,NULL,'2013-07-25 06:09:41',NULL,'SO JOHARI WENT CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(808,NULL,'2013-07-25 07:13:00',NULL,'SO JOHARI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'return',10),(809,NULL,'2013-07-25 07:14:24',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(810,NULL,'2013-07-25 08:58:58',NULL,'SS KAMAL HAND OVER TO SS JAHARI WITH KEYS INTACT SITUATION AS NORMAL',0,'hand over duty',10),(811,NULL,'2013-07-25 09:01:01',NULL,'SS Jahari took over duty from SS Kamal with situation reported normal',0,'Took Over Duty',10),(812,NULL,'2013-07-25 10:02:47',NULL,'Late Entry 0905hrs,\r\nSS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi at main gate',0,'Deployment',10),(813,NULL,'2013-07-25 10:18:11',NULL,'SO Razak went for clocking around the estate, reported all in order',0,'Clocking',10),(814,NULL,'2013-07-25 11:20:35',NULL,'SO Razak returned from clocking reported all in order',0,'Return',10),(815,NULL,'2013-07-25 12:53:32',NULL,'Late Entry 1200hrs,\r\nSS Jahari at Guard post, SO Tarmizi at Main gate, SO Razak went for his lunch break',0,'Deployment',10),(816,NULL,'2013-07-25 12:54:28',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(817,NULL,'2013-07-25 17:12:33',NULL,'Late entry 1400hrs,\r\nSS Jahari went for his lunch break, SO Razak at Guard post, SO Tarmizi at Main gate.',0,'Deployment',10),(818,NULL,'2013-07-25 17:13:25',NULL,'Late entry 1500hrs,\r\nSS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(819,NULL,'2013-07-25 17:14:16',NULL,'Late entry 1600hrs\r\nSO Tarmizi went for clocking around the estate.',0,'Clocking',10),(820,NULL,'2013-07-25 17:14:59',NULL,'Late entry 1645hrs\r\nSO Tarmizi returned from clocking and reported all in order',0,'Return',10),(821,NULL,'2013-07-25 17:16:12',NULL,'At about 1650hrs, guard house MCB tripped and caused ::\r\nEntrance and exit barrier and the CCTV tripped.\r\nSS Jahari and SO Razak manually lift up the barrier to free the flow of traffic and Tech Abdullah was informed.\r\nTech Abdullah came and reseted the circuit breaker and CCTV and the exit barrier was back to normal except for 16 CCTV no video and Visitor barrier not functioning.',1,'TRIPPED',10),(822,NULL,'2013-07-25 17:51:26',NULL,'SS Jahari at Clubhouse, SO Tarmizi at Main gate, SO Razak at Guard post.',0,'Deployment',10),(823,NULL,'2013-07-25 18:54:31',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Guard Post,SO Tarmizi stationed at Main Gate',0,'Deployment',10),(824,NULL,'2013-07-25 21:00:26',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Hand Over Duty',10),(825,NULL,'2013-07-25 21:01:10',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI',0,'TOOK OVER DUTY',10),(826,NULL,'2013-07-25 21:49:00',NULL,'SS KAMAL AND SO ALI MAIN GATE SO JOHARI AT CLUB HOUSE',0,'Deployment',10),(827,NULL,'2013-07-25 22:07:01',NULL,'SO JOHARI WENT TO LOCKED BADMINTON COURT AND SWITCH OFF CLUB HOUSE LIGHT',0,'locked facilityl',10),(828,NULL,'2013-07-25 22:08:30',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(829,NULL,'2013-07-25 22:09:14',NULL,'SS KAMAL AND SO JOHARI AT MAIN GATE',0,'Deployment',10),(830,NULL,'2013-07-25 22:50:35',NULL,'SO ALI RETURN FROM CLOCKING REPORT SITUATION NORMAL',0,'return',10),(831,NULL,'2013-07-25 23:57:47',NULL,'DIARY CLOSED FOR 25\\7\\13 (THURSDAY )',1,'diary closed',10),(832,NULL,'2013-07-26 00:00:26',NULL,'DIARY OPENED FOR 26\\7\\13 (friday )\r\n',0,'diary opened',10),(833,NULL,'2013-07-26 00:02:34',NULL,'so johari went to locked gym',0,'gym',10),(835,NULL,'2013-07-26 00:06:00',NULL,'ss kamal and so johari at main gate so ali at club house',0,'Deployment',10),(836,NULL,'2013-07-26 02:01:32',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(837,NULL,'2013-07-26 02:02:54',NULL,'so johari went for clocking around estate area',0,'Clocking',10),(838,NULL,'2013-07-26 02:37:46',NULL,'so johari from clocking report situation normal',0,'return',10),(839,NULL,'2013-07-26 04:01:24',NULL,'ss kamal and so johari at main gate',0,'Deployment',10),(840,NULL,'2013-07-26 04:02:21',NULL,'S/O ALI WENT FOR CLOCKING AROUND THE ESTATE .',0,'Clocking',10),(841,NULL,'2013-07-26 06:53:20',NULL,'SO ALI WENT FOR CLOCKING AROUND ESTATE AREA',0,'Clocking',10),(842,NULL,'2013-07-26 06:54:41',NULL,'ss kamal and so ali at main gate so johari at club house',0,'Deployment',10),(843,NULL,'2013-07-26 08:58:13',NULL,'ss kamal hand over duty to ss jahari with all keys intact situation as normal',0,'hand over duty',10),(844,NULL,'2013-07-26 09:00:41',NULL,'SS Jahari took over duty from SS Kamal situation as normal',0,'Took Over Duty',10),(845,NULL,'2013-07-26 11:16:25',NULL,'Late Entry 0905hrs,\r\nSS Jahri stationed at Guard post, SS Kamal at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(846,NULL,'2013-07-26 11:17:29',NULL,'SS Jahari went for patrolling around the estate reported all in order',0,'Patrolling',10),(847,NULL,'2013-07-26 13:23:30',NULL,'SS Jahari stationed at guard post, SO Tarmaizi went for his lunch break.',0,'Deployment',10),(851,NULL,'2013-07-26 16:04:15',NULL,'so tan on routed clocking',0,'clocking',9),(852,NULL,'2013-07-26 16:34:39',NULL,'so chia at loading bay so yap at command post',0,'deployment',9),(853,NULL,'2013-07-26 16:43:27',NULL,'so mohd proceed for second session of clocking',0,'clocking',9),(854,NULL,'2013-07-26 16:47:28',NULL,'so yap at command post so ali at loading bay',0,'deployment',9),(855,NULL,'2013-07-26 16:52:29',NULL,'Late entry 1500hrs,\r\nSS Jahari at guard post. SO Tarmizi stationed at main entrance.',0,'Deployment',10),(856,NULL,'2013-07-26 16:53:14',NULL,'Late entry 1600hrs,\r\nClocking was cancelled due to heavy rain.',1,'Clocking',10),(857,NULL,'2013-07-26 16:54:46',NULL,'SS Jahari at guard post. SO Tarmizi stationed at main entrance.',0,'Deployment',10),(858,NULL,'2013-07-26 18:35:15',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(859,NULL,'2013-07-26 21:04:25',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly',0,'Hand Over Duty',10),(860,NULL,'2013-07-26 21:05:07',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'TOOK OVER DUTY',10),(862,NULL,'2013-07-26 21:45:28',NULL,'S/O KAMAL AT G/HOUSE, S/O ALI & S/O JOHARI AT M/GATE . REPORTING S/NORMAL .',0,'Deployment',10),(863,NULL,'2013-07-26 22:46:15',NULL,'SS KAMAL AND SO ALI AT MAIN GATE SO JOHARI CLUB HOUSE',0,'Deployment',10),(864,NULL,'2013-07-26 23:58:49',NULL,'DIARY CLOSED FOR 26\\7\\13 ( friday )',1,'diary closed',10),(865,NULL,'2013-07-27 00:00:32',NULL,'diary opened for 27\\7\\13 (ssturday )',1,'diary opened',10),(866,NULL,'2013-07-27 00:01:55',NULL,'so johari went to locked gym',0,'gym',10),(867,NULL,'2013-07-27 00:02:49',NULL,'ss kamal and so johari at main gate so ali at club house',0,'Deployment',10),(868,NULL,'2013-07-27 02:00:42',NULL,'so johari went for clocking around estate area',0,'Clocking',10),(869,NULL,'2013-07-27 02:02:06',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(870,NULL,'2013-07-27 02:37:47',NULL,'so johari return from clocking report situation normal',0,'Return',10),(871,NULL,'2013-07-27 03:55:42',NULL,'so ali went for clocking around estate area',0,'Clocking',10),(872,NULL,'2013-07-27 04:02:24',NULL,'ss kamal and so johari at main gate',0,'Deployment',10),(873,NULL,'2013-07-27 06:06:51',NULL,'so johari went clocking around the estate area',0,'Clocking',10),(874,NULL,'2013-07-27 06:07:51',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(875,NULL,'2013-07-27 06:39:13',NULL,'so johari return from clocking report situation as normal',0,'return',10),(876,NULL,'2013-07-27 06:59:24',NULL,'ss kamal and so ali main gate so johari at club house',0,'Deployment',10),(877,NULL,'2013-07-27 08:22:33',NULL,'SO yap take over duty from SO osman with all in order',0,'tOD',9),(878,NULL,'2013-07-27 08:27:31',NULL,'so yap at command post\r\nsos ali and osman at loading bay',0,'deployment',9),(879,NULL,'2013-07-27 08:38:32',NULL,'SO ali disabled the affected zones in the system to facilitate the carrying out routine site fogging',0,'isolation of FAP',9),(880,NULL,'2013-07-27 08:43:47',NULL,'SO yap notified the monitoring station on such disablement',0,'ADEMCO',9),(881,NULL,'2013-07-27 08:48:02',NULL,'ALL FACILITIES ARE FOUND TO BE IN NORMAL OPERATION ACCEPT P LIFE 11 IS STILL UNDER OMS',0,'LITE CHECKING',9),(882,NULL,'2013-07-27 08:59:39',NULL,'THE PERIODIC FOGGING WAS ENDED AT THE INDICTED TIME VIDE ITS SERVICE REPORT01781',0,'COMPLECTION OF FOGGING',9),(883,NULL,'2013-07-27 09:04:10',NULL,'ss kamal hand over duty to so razak with all keys intact situation normal',0,'hand over duty',10),(884,NULL,'2013-07-27 09:03:24',NULL,'SO YAP AT COMMAND POST\r\nSOS CHIA AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(885,NULL,'2013-07-27 09:06:03',NULL,'SO Razak took over duty from SS Kamal situation normal',0,'Took Over Duty',10),(886,NULL,'2013-07-27 09:58:32',NULL,'SUP YAP AT COMMAND POST\r\nSOS CHIA AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(887,NULL,'2013-07-27 10:33:08',NULL,'SS Jahari at Guard post,S?O Tarmizi at Main Entrance, SO Razak at Clubhouse,',0,'Deployment',10),(888,NULL,'2013-07-27 10:51:36',NULL,'SO CHIA AT COMMAND POST\r\nSO SAAD AY LAODING BAY\r\nSUP YAP ON IMTERIN BREAK',0,'DEPLOYMENT',9),(889,NULL,'2013-07-27 11:51:58',NULL,'SUP YAP AT LOADING BAY\r\nSO CHIA ON BREAK\r\nSO SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(890,NULL,'2013-07-27 12:58:43',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA AT LOADING BAY\r\nSO SAAD ON LUNCH BREAK',0,'DEPLOYMENT',9),(891,NULL,'2013-07-27 13:56:50',NULL,'Late entry 1200hrs,\r\nSS Jahari at Guard post,S?O Tarmizi at Main Entrance, SO Razak went for his lunch break,',0,'Deployment',10),(892,NULL,'2013-07-27 13:57:39',NULL,'SS Jahari at Guard post, SO Razak at Main Entrance, SO Tarmizi went for his lunch break',0,'Deployment',10),(893,NULL,'2013-07-27 13:54:08',NULL,'SUP YAP NORMALIZED THE DISABLEMENT AND NOTIFIED MISS FRANK OF ADEMCO OF SUCH RESETTLMENT',0,'NORMALAZATION OF FRP',9),(894,NULL,'2013-07-27 14:02:03',NULL,'SUP YAP AT COMMAND POST\r\nSO SAAD AT LOADING BAY\r\nSO CHIA ON FIRST SESSION OF ROUTED CIOCKING',0,'DEPLOYMENT',9),(895,NULL,'2013-07-27 14:50:09',NULL,'ONLY INTERNAL CLOCKING POINTS COVERED DUE TO INTERMITTENTLY RAINS\r\nGROUND SITUATION APPEARS TO BE SAFE AND SECURE',0,'REPORT',9),(896,NULL,'2013-07-27 14:55:27',NULL,'SUP YAP AT COMMAND POST\r\nSOS CHIA AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(897,NULL,'2013-07-27 15:11:31',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(898,NULL,'2013-07-27 16:00:27',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA AT LOADING\r\nSO SAAD ON SECOND SESSION OF ROUTED CLOCKING',0,'DEPLOYMENT',9),(899,NULL,'2013-07-27 16:27:24',NULL,'IT WAS COMPELLED TO SUSPENDED THE EXTERIOR CLOCKING IN LIGHT OF WET WEATHER CONDITION\r\nGROUND ORDERLINESS REMAINS NORMALCY',0,'REPORT',9),(900,NULL,'2013-07-27 16:58:53',NULL,'Late entry 1600hrs,\r\nSO Tarmizi went for clocking around the estate, reported all in order',0,'Clocking',10),(901,NULL,'2013-07-27 16:59:48',NULL,'SS Jahari stationed at Clubhouse, SO Razak at Guard post, SO Tarmizi at Main gate',0,'Deployment',10),(902,NULL,'2013-07-27 17:00:10',NULL,'SUP YAP AT COMMAND POST\r\nSO SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(903,NULL,'2013-07-27 17:52:38',NULL,'SUP YAP AT COMMAND POST\r\nSO SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(904,NULL,'2013-07-27 18:50:57',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(905,NULL,'2013-07-27 21:00:20',NULL,'SS Jahari handed over duty to SS Kamal with situation normal',0,'Hand Over Duty',10),(906,NULL,'2013-07-27 21:00:56',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI ',0,'TOOK OVER DUTY',10),(907,NULL,'2013-07-27 21:23:20',NULL,'SS KAMAL AND SO RAZAK AT MAIN GATE',0,'Deployment',10),(908,NULL,'2013-07-27 22:13:59',NULL,'so razak went to locked badminton and switch off club house light',0,'loccked facility',10),(909,NULL,'2013-07-27 22:16:46',NULL,'ss kamal stand by at main gate',0,'Deployment',10),(910,NULL,'2013-07-27 23:58:58',NULL,'diary closed for 27\\7\\13 (saturday)',1,'diary closed',10),(911,NULL,'2013-07-28 00:00:51',NULL,'diary opened for 28\\7\\13 (sunday)',1,'diary opened',10),(912,NULL,'2013-07-28 00:02:31',NULL,'so razak went to locked gym',0,'gym',10),(913,NULL,'2013-07-28 00:03:16',NULL,'ss kamal and so razak at main gate',0,'Deployment',10),(914,NULL,'2013-07-28 01:59:50',NULL,'so razak went clocking around estate area',0,'Clocking',10),(915,NULL,'2013-07-28 02:01:22',NULL,'ss kamal stand by at main gate',0,'Deployment',10),(916,NULL,'2013-07-28 02:43:52',NULL,'so razak return from clocking situation normal',0,'return',10),(917,NULL,'2013-07-28 03:56:50',NULL,'ss kamal and so razak at main gate',0,'Deployment',10),(918,NULL,'2013-07-28 06:00:09',NULL,'so razak went patrol around estate area',0,'patrol ',10),(919,NULL,'2013-07-28 06:40:54',NULL,'so razak return from patrol report situation normal',0,'return',10),(920,NULL,'2013-07-28 07:00:27',NULL,'ss kamal and so razak at main gate',0,'Deployment',10),(921,NULL,'2013-07-28 07:08:52',NULL,'sup yap TOOK OVER DUTY FROM SO OSMAN WITH ALL IN ORDER',0,'TOD',9),(922,NULL,'2013-07-28 07:11:52',NULL,'SUP YAP AT COMMAND POST\r\nSOS ALI AND OSMAN AT LOADING BAY',0,'DEPLOYMENT',9),(923,NULL,'2013-07-28 07:22:10',NULL,'ALL FACILITIES ARE FOUND TO BE IN NORMAL OPERATION ORDER ACCEPT PASSENGER LIFT 11 IS STILL UNDER OMS',0,'LIFT CHECKING',9),(924,NULL,'2013-07-28 08:12:04',NULL,'SUP YAP AT COMMAND POST\r\nSOS OSMAN  AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(925,NULL,'2013-07-28 08:49:19',NULL,'SO OSMAN AT COMMAND POST\r\nSO MOHD AT LOADING BAY\r\nSUP YAP ON ROUTED CIOCKING',0,'DEPLOYMENT',9),(926,NULL,'2013-07-28 09:05:32',NULL,'ss kamal hand over duty to ss razak with all keys intact situayion as normal',0,'Hand Over Duty',10),(927,NULL,'2013-07-28 09:07:14',NULL,'ss razak took over duty from ss kamal situation normal',0,'TOOK OVER DUTY',10),(928,NULL,'2013-07-28 09:45:06',NULL,'SUP YAP AT COMMAND POST\r\nSO MOHD AT LOADING BAY\r\nSO OSMAN ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(929,NULL,'2013-07-28 09:47:51',NULL,'NO ABNORMALITIES WERE REVEALED',0,'REP0RT',9),(930,NULL,'2013-07-28 09:54:09',NULL,'SUP YAP AT COMMAND POST\r\nSOS MOHD AND OSMAN AT LOADING BAY',0,'DEPLOYMENT',9),(931,NULL,'2013-07-28 10:01:12',NULL,'S/O Razak AT Main Gate S/O Tarmizi At Main Entrance',0,'Deployment',10),(932,NULL,'2013-07-28 10:44:23',NULL,'SUP YAP ON BREAK\r\nSO OOSMAN ATCOMMAND POST\r\n\r\nSO MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(933,NULL,'2013-07-28 11:45:03',NULL,'SO Razak and SO Tarmizi standby at main gate. ',0,'Deployment',10),(934,NULL,'2013-07-28 11:43:38',NULL,'SUP YAP AT COMMAND POST\r\nSOS MOHD AND OSMAN AT LOADING BAY',0,'DEPLOYMENT',9),(935,NULL,'2013-07-28 12:59:15',NULL,'SUP YAP AT COMMAND POST\r\nSO OSMAN AT LOADING BAY\r\nSO MOHD ON BREAK',0,'DEPLOYMENT',9),(936,NULL,'2013-07-28 13:49:46',NULL,'SO OSMAN AT COMMAND POST\r\nSO MOHD AT LOADING AT LOADING BAY\r\nSUP YAP ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(937,NULL,'2013-07-28 13:49:46',NULL,'SO OSMAN AT COMMAND POST\r\nSO MOHD AT LOADING AT LOADING BAY\r\nSUP YAP ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(938,NULL,'2013-07-28 13:58:09',NULL,'SO Razak and SO Tarmizi standby at main gate. ',0,'Deployment',10),(939,NULL,'2013-07-28 14:26:23',NULL,'GROUND SITUATION REMAINS NORMAICY',0,'REPORT',9),(940,NULL,'2013-07-28 14:59:42',NULL,'SUP YAP AT COMMAND POST\r\nSOS OSMAN AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(941,NULL,'2013-07-28 15:57:03',NULL,'SUP YAP AT COMMAND POST\r\nSO OSMAN AT LOADING BAY\r\nSO MOHD ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(942,NULL,'2013-07-28 16:16:13',NULL,'SO Razak and SO Tarmizi standby at main gate. ',0,'Deployment',10),(943,NULL,'2013-07-28 16:49:09',NULL,'GROUND SITUATION SEEMED TO BE IN SOUND ORDER',0,'REPORTGROUND ORDERLINESS',9),(944,NULL,'2013-07-28 16:52:29',NULL,'SUP YAP AT COMMAND POST\r\nSOSMOHD AND OSMAN AT LOADING BAY',0,'DEPLOYMENT',9),(945,NULL,'2013-07-28 17:56:47',NULL,'SUP YAP AT COMMAND POST\r\nSOS MOHD AND OSMAN AT LOADING BAY',0,'DEPLOYMENT',9),(946,NULL,'2013-07-28 17:59:17',NULL,'SUP YAP HOD TO SO OSMAN WITH AIO',0,'HOD',9),(947,NULL,'2013-07-28 18:07:46',NULL,'SO OSMAN TOD FROM SUP YAP WITH ATO',0,'TOD',9),(949,NULL,'2013-07-28 18:13:25',NULL,'SO OSMAN COMMAND POST SO MOHD LOBBY',0,'DEPLOYMENT',9),(950,NULL,'2013-07-28 18:34:28',NULL,'SO Razak and SO Tarmizi standby at main gate. ',0,'Deployment',10),(951,NULL,'2013-07-28 19:31:22',NULL,'SO OSMAM COMMAND POST SO MOHD LOBBY',0,'DEPLOYMENT',9),(952,NULL,'2013-07-28 19:58:29',NULL,'SO Razak and SO Tarmizi standby at main gate.',0,'Deployment',10),(953,NULL,'2013-07-28 20:04:45',NULL,'SO OSMAN ON CLOSING MAIN GATE CARPARK AREA',0,'CLOSING',9),(954,NULL,'2013-07-28 20:08:28',NULL,'SO OSMAN RETURNED CLOSING SITUATION NORMAL',0,'RETURNED',9),(955,NULL,'2013-07-28 20:15:10',NULL,'SO OSMAN COMMAND POSP SO ALI LOBBY\r\n',0,'DEPLOYMENT',9),(956,NULL,'2013-07-28 20:56:43',NULL,'SSRazak handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingl',0,'Hand Over Duty',10),(957,NULL,'2013-07-28 20:58:35',NULL,'SS Kamal took over duty with situation as normal.',0,'TOOK OVER DUTY',10),(958,NULL,'2013-07-28 20:56:34',NULL,'SO OSMAN 0N 1ST CLOCKING SURROUNDING AREA',0,'clocking',9),(959,NULL,'2013-07-28 21:40:53',NULL,'S0 OSMAN RETURNED CLOCKING SITUATION NORMAL',0,'RETURNED',9),(960,NULL,'2013-07-28 21:47:48',NULL,'S0 OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(961,NULL,'2013-07-28 21:56:33',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'Deployment',10),(962,NULL,'2013-07-28 23:58:52',NULL,'diary closed for 28\\7\\13 (sunday )',1,'diary closed',10),(963,NULL,'2013-07-29 00:01:15',NULL,'diary opened for 29\\7\\13 (monday )',1,'diary opened',10),(964,NULL,'2013-07-29 00:02:48',NULL,'so razak went to locked gym',0,'gym',10),(965,NULL,'2013-07-29 00:01:18',NULL,'CLOSING DIARY FOR28-07-2013 SUNDAY',0,'CLOSING',9),(966,NULL,'2013-07-29 00:03:39',NULL,'ss kamal and so razak at main gate so ali at club house',0,'Deployment',10),(967,NULL,'2013-07-29 00:04:30',NULL,'OPENING DIARY FOR 29-07-2013 MONDAY',0,'OPENING',9),(968,NULL,'2013-07-29 00:39:50',NULL,'S0 OSMAN ON PATROL SURROUNDING AREA',0,'PATROL',9),(969,NULL,'2013-07-29 01:00:00',NULL,'SO OSMAN PATROL SITURNED SITUATION NORMAL',0,'RETURNED',9),(970,NULL,'2013-07-29 01:59:06',NULL,'so razak went clocking around estate area',0,'Clocking',10),(971,NULL,'2013-07-29 03:57:18',NULL,'so razak went for  colking ',0,'Clocking',10),(972,NULL,'2013-07-29 04:32:46',NULL,'SO OSMAN COMMAND POST SO ALI BREAK',0,'DEPLOYMENT',9),(973,NULL,'2013-07-29 04:37:11',NULL,' SO OSMAN BREAK SO ALI LOBBY',0,'DEPLOYMENT',9),(974,NULL,'2013-07-29 04:44:10',NULL,'SO OSMAN COMMAND POSY SO ALI LOBBY',0,'DEPLOYMENT',9),(975,NULL,'2013-07-29 05:03:35',NULL,'SO ALI ON 2ND CLOCKING SURROUNDING AREA',0,'clocking',9),(976,NULL,'2013-07-29 05:43:29',NULL,'SO ALI RETURNED CLOCKINGR SITURNED SITUATION NOMRAL',0,'RETURNED',9),(977,NULL,'2013-07-29 05:47:16',NULL,'SO OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(978,NULL,'2013-07-29 06:06:15',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'Deployment',10),(979,NULL,'2013-07-29 06:59:16',NULL,'SO OSMAN HOD TO SUP YAP WITH AIO',0,'HOD',9),(980,NULL,'2013-07-29 07:05:22',NULL,'SUP YAP TOOK OVER DUTY FROM SO OSMAN WITH IN OREDER',0,'TOD',9),(981,NULL,'2013-07-29 07:07:03',NULL,'SUP YAP AT COMMAND POST\r\nSOS OSMAN ANDALI AT LOADING BAY',0,'DEPLOYMENT',9),(982,NULL,'2013-07-29 07:08:36',NULL,'ALL CARS ARE FOUND TO BE IN NORMAL OPERATION ACCEPT PASSENGER LIFT 11 IS STILL UNDER OMS',0,'LIFT CHECKING',9),(983,NULL,'2013-07-29 07:25:10',NULL,'ss kamal report blk 706 passenger lift faulty',1,'report',10),(984,NULL,'2013-07-29 07:55:56',NULL,'SUP YAP AT COMMAND POST\r\nSOS SAAD ANDMOHD AT LOADING BAY',0,'DEPLOYMENT',9),(985,NULL,'2013-07-29 08:00:45',NULL,'SSKAMAL AND SO ALI AT MAIN GATE SO RAZAK CLUB HOUSE',0,'Deployment',10),(986,NULL,'2013-07-29 08:54:25',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA AT SECURITY POST\r\nSOS SAAD AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(987,NULL,'2013-07-29 09:03:35',NULL,'SS Kamal handed over duty to SS Jahari with situation normal ',0,'TOOK OVER DUTY',10),(988,NULL,'2013-07-29 09:05:41',NULL,'SS Jahari took over duty from SS Kamal with situation as normal',0,'Took Over Over',10),(989,NULL,'2013-07-29 09:53:29',NULL,'SUP YAP AT COMMAND POST\r\nSO SAAD AT SECURITY POST\r\nSOS CHIA AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(990,NULL,'2013-07-29 10:11:43',NULL,'Late entry 0915hrs,\r\nSMA Syed Kadir visited Changi Court Condo,\r\nSS Kamal and SO Razak alert at Main entrance\r\nLeft condo at 1100hrs',1,'VISIT',10),(991,NULL,'2013-07-29 10:50:35',NULL,'SUP YAP ON BREAK\r\nSO MOHD AT COMMAND POST\r\nSOSCHIA AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(992,NULL,'2013-07-29 11:51:28',NULL,'Late entry 1000hrs\r\nSO Razak went for cloking around the estate reported all in order',0,'Clocking',10),(993,NULL,'2013-07-29 11:52:55',NULL,'Late entry 1100hrs,\r\nSS Jahari at Guard post, SO Razak at main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(994,NULL,'2013-07-29 12:03:17',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA ON BREAK\r\nSOS MOHD AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(995,NULL,'2013-07-29 12:13:15',NULL,'SS Jahari at Guard post, SO Tarmizi at Main gate.SO Razak went for his lunch break',0,'Deployment',10),(996,NULL,'2013-07-29 12:55:49',NULL,'SUP YAP AT COMMAND POST\r\nSO SAAD ON BREA\r\nSOS MOHD AND CHIA AT LOADING BAY',0,'DEPLOYMENT',9),(997,NULL,'2013-07-29 12:59:07',NULL,'SS Jahari at Guard post, SO Razak at Main gate,\r\nSO Tarmizi went for his lunch break.',0,'Relief',10),(998,NULL,'2013-07-29 14:02:46',NULL,'SUP YAP AT COMMAND POST\r\nSO MOHD ON BREACK\r\nSOS CHIA AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(999,NULL,'2013-07-29 14:51:23',NULL,'SUP YAP AT COMMAND POST\r\nSOS SAAD AND MOHD AT LOADING BAY\r\nSO CHIA ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(1000,NULL,'2013-07-29 15:21:37',NULL,'KONE REPAIR TEAM ARRIVED AND FOLLOW UP REMEDIAL WORKS ON OMS LIFT 11',0,'LIFT REMEDIAL',9),(1001,NULL,'2013-07-29 15:38:51',NULL,'Late entry 1400hrs,\r\nSS Jahari went for his lunch break, SO Razak at Guard post, SO Tarmizi at Main gate',0,'Deployment',10),(1002,NULL,'2013-07-29 15:42:28',NULL,'SS Jahari at Guard post, SO Razak at Main gate, SO Tarmizi at Main entrance',0,'Deployment',10),(1003,NULL,'2013-07-29 15:55:16',NULL,'SITUATION REPORTED AS PER NORMAL',0,'REPORT',9),(1004,NULL,'2013-07-29 16:02:56',NULL,'SO Tarmizi went for clocking around the estate.',0,'Clocking',10),(1005,NULL,'2013-07-29 16:11:23',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA AT SECURITY POST\r\nSOS MOHD AND SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(1006,NULL,'2013-07-29 16:42:26',NULL,'THE LIFT RESTORED NORMAL OPERATION AFTER COMPLECTION OF REQUIRED REMEDIAL WORKS',0,'RESTORATION OF LIFT 11',9),(1007,NULL,'2013-07-29 16:48:00',NULL,'SUP YAP AT COMMAND POST\r\nSO MOHD AT LOADING BAY\r\nSO SAAD ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(1008,NULL,'2013-07-29 17:24:00',NULL,'SO Tarmizi returned from clocking situation normal',0,'Return',10),(1009,NULL,'2013-07-29 17:30:17',NULL,'GROUND SITUATION REMAINS NORMALCY',0,'REPORT',9),(1010,NULL,'2013-07-29 17:56:27',NULL,'SUP YAP AT COMMAND POST\r\nSOS MOHD AND SO SAAD AT LOADING BAY',0,'DEPLOYMENT',9),(1011,NULL,'2013-07-29 18:29:24',NULL,'SO YAP HOD TO SO OSMAN WITH AIO',0,'HOD',9),(1012,NULL,'2013-07-29 18:30:31',NULL,'SO OSMAN TOD FROM SUP YAP WITH AIO',0,'TOD',9),(1013,NULL,'2013-07-29 18:55:08',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(1014,NULL,'2013-07-29 18:55:51',NULL,'SO OSMAN COMMAND POST SO MOHD SO SAAD LOBBY',0,'DEPLOYMENT',9),(1015,NULL,'2013-07-29 19:32:41',NULL,'SO OSMAN COMMAND POST SO MOHD SO SAAD LOBBY',0,'DEPLOYMENT',9),(1016,NULL,'2013-07-29 19:59:12',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(1017,NULL,'2013-07-29 20:04:53',NULL,'SO OSMAN ON CLOSING MAIN GATE CARPARK AREA',0,'CLOSING',9),(1018,NULL,'2013-07-29 20:09:28',NULL,'SO OSMAN RETURNED CLOSIMG SITUATION NORMAL',0,'RETURNED',9),(1019,NULL,'2013-07-29 20:15:25',NULL,'SO OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(1020,NULL,'2013-07-29 20:59:36',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Hand Over Duty',10),(1021,NULL,'2013-07-29 20:59:51',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'TOOK OVER DUTY',10),(1022,NULL,'2013-07-29 21:00:53',NULL,'SO SOMAN ON CIOCKING SURROUNDING AREA',0,'CLOCKING',9),(1023,NULL,'2013-07-29 21:31:20',NULL,'SSkamal and so ali at main gate so joharj at club house',0,'Deployment',10),(1024,NULL,'2013-07-29 21:43:16',NULL,'SO OSMAN RETURNED CLOCKING SITUATION NORMAL',0,'RETURNED',9),(1025,NULL,'2013-07-29 22:00:20',NULL,'SO OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(1026,NULL,'2013-07-29 22:04:00',NULL,'so johari went to locked badminton court and switch off club house light',0,'loccked facility',10),(1027,NULL,'2013-07-29 22:06:10',NULL,'ss kamal and so johari at main gate',0,'Deployment',10),(1028,NULL,'2013-07-29 22:09:28',NULL,'so ali went for clocking around estate area',0,'Clocking',10),(1029,NULL,'2013-07-29 23:08:20',NULL,'so ali return from clocking report situation normal',0,'Return',10),(1030,NULL,'2013-07-30 00:01:49',NULL,'diary closed for 29\\7\\13 (monday )',1,'diary closed',10),(1031,NULL,'2013-07-30 00:00:13',NULL,'CLOSING DIARY FOR 29-07-2013 MONDAY',0,'CLOSING',9),(1032,NULL,'2013-07-30 00:02:53',NULL,'diary opened for 30\\13 (tuesday )',1,'diary opened',10),(1033,NULL,'2013-07-30 00:03:35',NULL,'OPENING DIARY FOR 30-07-2013 TUERSDY',0,'OPENING',9),(1034,NULL,'2013-07-30 00:04:38',NULL,'so johari went to locked gym',0,'gym',10),(1035,NULL,'2013-07-30 00:05:28',NULL,'ss kamal and so johari at main gate so ali at club house',0,'Deployment',10),(1036,NULL,'2013-07-30 00:45:53',NULL,'SO OSMAN ON PATROL SURROUNDING AREA',0,'PATROL',9),(1037,NULL,'2013-07-30 01:06:37',NULL,'S0 OSMAN RETURNED PATROL SITUATION NORMAL',0,'RETURNED',9),(1039,NULL,'2013-07-30 02:01:54',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(1040,NULL,'2013-07-30 02:03:22',NULL,'so johari went clocking around estate area',0,'Clocking',10),(1041,NULL,'2013-07-30 02:19:44',NULL,'SO OSMAN COMMAND POST SO ALI BREAK',0,'DEPLOYMENT',9),(1042,NULL,'2013-07-30 02:56:18',NULL,'so johari return from clocking report siyuation normal',0,'return',10),(1043,NULL,'2013-07-30 03:56:04',NULL,'so ali went clocking around estate area',0,'Clocking',10),(1044,NULL,'2013-07-30 03:57:01',NULL,'ss kamal and so johari at main gate',0,'Deployment',10),(1045,NULL,'2013-07-30 04:46:29',NULL,'SO OSMAN BREAK SO ALI LOBBY ',0,'DEPLOYMENT',9),(1046,NULL,'2013-07-30 04:50:57',NULL,'SO OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(1047,NULL,'2013-07-30 05:09:55',NULL,'S0 ALI 0N CLOCKING SURROUNDING AREA',0,'CLOCKING',9),(1048,NULL,'2013-07-30 05:40:25',NULL,'SO ALI RETURNED  CLOCKING SITUATION NORMAL',0,'RETURNED',9),(1049,NULL,'2013-07-30 05:44:08',NULL,'S0 OSMAN COMMAND POST SO ALI LOBBY',0,'DEPLOYMENT',9),(1050,NULL,'2013-07-30 06:10:20',NULL,'ss kamal and so ali at main gate',0,'Deployment',10),(1051,NULL,'2013-07-30 06:11:40',NULL,'so johari went for clocking round estate area',0,'Clocking',10),(1052,NULL,'2013-07-30 06:56:06',NULL,'so johari return from clocking report situation normal',0,'Return',10),(1053,NULL,'2013-07-30 06:57:20',NULL,'ss kamal and so ali at main gate so johari at club house',0,'Deployment',10),(1054,NULL,'2013-07-30 07:01:37',NULL,'SO OSMAN HOD TO SUP YAP WITH AIO',0,'HOD',9),(1055,NULL,'2013-07-30 07:06:28',NULL,'SUP YAP TOOK OVER DUTY FROM SO OSMAN WITH IN ORDER',0,'TOD',9),(1056,NULL,'2013-07-30 07:08:11',NULL,'SUP YAP AT COMMAND POST\r\nSOS OSMAN AND ALI AT LOADING BAY',0,'DEPLOYMENT',9),(1057,NULL,'2013-07-30 07:09:28',NULL,'ALL CARS ARE FOUND TO BE IN NORMAL OPERATION STUTS',0,'LIFT CHECKING',9),(1058,NULL,'2013-07-30 07:50:06',NULL,'SUP YAP AT COMMAND POST\r\nSOS OSMAN AND SAAD AT L0ADING BAY',0,'DEPLOYMENT',9),(1059,NULL,'2013-07-30 08:48:22',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA AT SECURITY POST\r\nSOS SAAD AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(1060,NULL,'2013-07-30 09:01:03',NULL,'ss kamal hand over duty to ss jahari with all keys intact situation normal',0,'Hand Over Duty',10),(1061,NULL,'2013-07-30 09:02:59',NULL,'SS Jahari took over duty from SS Kamal situation normal',0,'Took Over Over',10),(1062,NULL,'2013-07-30 09:57:08',NULL,'SUP YAP AT COMMAND POST\r\nSOS CHIA SAAD AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(1063,NULL,'2013-07-30 10:13:40',NULL,'SO Razak went for clocking around the estate,reported all in order',0,'Clocking',10),(1064,NULL,'2013-07-30 10:51:05',NULL,'SUP YAP ON BREAK\r\nSO MOHD AT COMMAND POST\r\nSOS CHIA AND SAAD AT LOADING',0,'DEPLOYMENT',9),(1065,NULL,'2013-07-30 11:49:20',NULL,'Late entry 1100hrs,\r\nSS Jahari stationed at Guard post, SO Razak at main gate, SO Tarmizi at main entrance.',0,'Deployment',10),(1066,NULL,'2013-07-30 11:57:15',NULL,'SUP YAP AT COMMAND POST\r\nSO CHIA ON BREAK\r\nSOS SAAD AND MOHD AT LOADING BAY',0,'DEPLOYMENT',9),(1067,NULL,'2013-07-30 12:41:48',NULL,'SO MOHD RESETTLED THE ALLEGED POWER TRIP WHICH AFFECTED THE COMMON LIGHTING OF LOADING BAY AT WING B\r\nLIGHTS RESTORED WHEN THE TRIPPING WAS BEING REACTIED',0,'POWER TRIPPING',9),(1068,NULL,'2013-07-30 13:00:44',NULL,'Late entry 1200hrs,\r\nSS Jahari at guard post, SO Tarmizi at main gate, SO Razak went for his lunch break',0,'Deployment',10),(1069,NULL,'2013-07-30 13:02:07',NULL,'SS Jahari at guard post, SO Razak at main gate, SO Tarmizi went for his lunch break',0,'Deployment',10),(1070,NULL,'2013-07-30 13:53:11',NULL,'SUP YAP AT COMMAND POST\r\nSO MOHD ON BREAK\r\nSOS CHIA AND SAAD AT LOADING',0,'DEPLOYMENT',9),(1071,NULL,'2013-07-30 14:03:39',NULL,'SMA Syed Kader visited Changi Court, SS Jahari and SO Razak on duty at main gate.',1,'Visit',10),(1072,NULL,'2013-07-30 15:06:05',NULL,'SMA Mr.Syed Kader left Changi Court and reported all in order.',1,'Left',10),(1073,NULL,'2013-07-30 15:07:19',NULL,'SS Jahari stationed at Guard post, SO Tarmizi at Main gate, SO Razak at main entrance.',0,'Deployment',10),(1074,NULL,'2013-07-30 15:10:16',NULL,'SUP YAP AT COMMAND POST\r\nSOS SAAD AND MOHD AT LOADING BAY\r\nSO CHIA ON ROUTED CLOCKING',0,'DEPLOYMENT',9),(1075,NULL,'2013-07-30 15:55:41',NULL,'GROUND SITUATION SEEMED TO BE AS PER NORMOL',0,'RREPORT',9),(1076,NULL,'2013-07-30 16:17:26',NULL,'SO Tarmizi went for clocking around the estate,',0,'Clocking',10),(1077,NULL,'2013-07-30 17:56:23',NULL,'SO Tarmizi returned from clocking and reported all in order',0,'Return',10),(1078,NULL,'2013-07-30 18:56:36',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(1079,NULL,'2013-07-30 21:01:27',NULL,'SS Jahari handed over duty to SS Kamal with situation normal,',0,'Hand Over Duty',10),(1080,NULL,'2013-07-30 21:02:20',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'TOOK OVER DUTY',10),(1081,NULL,'2013-07-30 22:08:36',NULL,'S/O JOHARI TOOK OVER DUTY FROM S/S JAHARI WITH ALL IN ORDER .',0,'TOOK OVER DUTY',10),(1082,NULL,'2013-07-30 22:09:50',NULL,'S/O JOHARI WENT TO LOCKED BADMINTON & OFF C/HOUSE LIGHTS . S/O ALI AT M/GATE .',0,'Deployment',10),(1083,NULL,'2013-07-30 22:10:59',NULL,'S/O JOHARI WENT FOR CLOCKING AROUND THE ESTATE .',0,'Clocking',10),(1084,NULL,'2013-07-30 22:44:25',NULL,'S/O JOHARI RETURN FRON CLOCKING REPORTING S/NORMAL .',0,'Return',10),(1085,NULL,'2013-07-30 23:12:16',NULL,'S/O JOHARI G/house & S/O ALI M/GATE .',0,'Deployment',10),(1086,NULL,'2013-07-31 00:04:32',NULL,'S/O JOHARI WENT TO LOCKED GYM .',0,'gym',10),(1087,NULL,'2013-07-31 00:06:56',NULL,'DIARY CLOSED FOR 30/7/13 (TUESDAY)',1,'diary opened',10),(1088,NULL,'2013-07-31 00:07:45',NULL,'DIARY OPENED FOR 31/7/13 (WEDNESDAY)',1,'diary opened',10),(1089,NULL,'2013-07-31 00:08:34',NULL,'S/O JOHARI AT M/GATE, S/O ALI AT G/HOUSE .',0,'Deployment',10),(1090,NULL,'2013-07-31 02:08:09',NULL,'S/O ALI WENT FOR CLOCKING AROUND THE ESTATE .',0,'Clocking',10),(1091,NULL,'2013-07-31 02:09:08',NULL,'S/O JOHARI AT M/GATE .',0,'Deployment',10),(1092,NULL,'2013-07-31 02:50:57',NULL,'S/P ALI RETURN FROM CLOCKING AROUND THE ESTATE REPORTING S/NORMAL .',0,'Return',10),(1093,NULL,'2013-07-31 06:06:54',NULL,'S/O JOHARI WENT FOR CLOCKING AROUND THE ESTATE .',0,'Clocking',10),(1094,NULL,'2013-07-31 06:07:30',NULL,'S/O ALI AT M/GATE .',0,'Deployment',10),(1095,NULL,'2013-07-31 07:00:58',NULL,'S/O JOHARI RETURN FROM CLOCKING REPORTING S/NORMAL .',0,'Return',10),(1096,NULL,'2013-07-31 07:01:31',NULL,'S/O JOHARI AT G/HOUSE, S/O ALI AT M/GATE .',0,'Deployment',10),(1097,NULL,'2013-07-31 09:00:08',NULL,'s/o jOHARI handed over duty to SS jAHARI with situation reported normal with all keys and equipment intact and briefed accordingly.',0,'Hand Over Duty',10),(1098,NULL,'2013-07-31 09:02:39',NULL,'S/S Jahari took over duty from SO Johari with situation reported as normal.',0,'Took Over Over',10),(1099,NULL,'2013-07-31 10:16:30',NULL,'Late entry 0905hrs,\r\nSS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(1100,NULL,'2013-07-31 10:54:04',NULL,'Late enrty,\r\nClocking was cancelled due to heavy rain',0,'Clocking',10),(1101,NULL,'2013-07-31 10:55:39',NULL,'SS Jahari stationed at Guard Post, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Clubhouse, ',0,'Deployment',10),(1102,NULL,'2013-07-31 12:27:21',NULL,'SS Jahari stationed at Guard post, SO Tarmizi stationed at Main gate, SO Razak went for his lunch break.',0,'Deployment',10),(1103,NULL,'2013-07-31 13:08:52',NULL,'SS Jahari stationed at Guard post, SO Razak stationed at Main gate, SO Tarmizi went for his lunch break.',0,'Deployment',10),(1104,NULL,'2013-07-31 13:39:13',NULL,'SMA Mr.Syed Kader visit Changi court,\r\nSS Jahari and SO Razak on duty at Main entrance.',1,'Visit',10),(1105,NULL,'2013-07-31 14:06:17',NULL,'SO Razak stationed at Guard post, SO Tarmizi stationed at Main gate, SS Jahari went for his lunch break.',0,'Deployment',10),(1106,NULL,'2013-07-31 15:50:32',NULL,'SMA Syed Kadir left Changi court condo.',0,'Left',10),(1107,NULL,'2013-07-31 15:55:31',NULL,'SO Tarmizi went for clocking around the estate,',0,'Clocking',10),(1108,NULL,'2013-07-31 16:03:57',NULL,'SS Jahari at guard post, SS Razak at main gate,',0,'Deployment',10),(1109,NULL,'2013-07-31 16:04:32',NULL,'SO Tarmizi went for clocking around the estate.Reported all in order',0,'Clocking',10),(1110,NULL,'2013-07-31 16:59:59',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(1111,NULL,'2013-07-31 19:43:45',NULL,'SS Jahari went for patrolling around the estate, reported all in order.',0,'Patrolling',10),(1112,NULL,'2013-07-31 20:14:27',NULL,'SS Jahari stationed at Clubhouse, SO Razak stationed at Main Entrance, SO Tarmizi stationed at Main gate, ',0,'Deployment',10),(1113,NULL,'2013-07-31 21:00:45',NULL,'SS Jahari handed over duty to SS Kamal with situation reported normal',0,'Hand Over Duty',10),(1114,NULL,'2013-07-31 21:01:16',NULL,'SS KAMAL TOOK OVER DUTY FROM SS JAHARI WITH SITUATION NORMAL',0,'TOOK OVER DUTY',10),(1115,NULL,'2013-07-31 22:02:14',NULL,'so johari went to locked badminton and switch off club house light',0,'loccked facility',10),(1116,NULL,'2013-07-31 22:04:42',NULL,'ss kamal and so johari main gate ',0,'deployment',10),(1117,NULL,'2013-07-31 22:05:58',NULL,'so ali went clocking around estate area',0,'Clocking',10),(1118,NULL,'2013-07-31 22:55:01',NULL,'so ali return from clocking report situation normal',0,'return',10),(1119,NULL,'2013-07-31 23:58:56',NULL,'diary closed for 31\\7\\13 (wednesday )',1,'diary closed',10),(1120,NULL,'2013-08-01 00:00:15',NULL,'diary opened for 1\\8\\13 (thursday )',1,'diary opened',10),(1121,NULL,'2013-08-01 00:01:29',NULL,'so johari went to locked gym',0,'gym',10),(1122,NULL,'2013-08-01 00:02:10',NULL,'ss kamal and so johari at main gate so ali  at club house',0,'Deployment',10);

/*Table structure for table `passes` */

DROP TABLE IF EXISTS `passes`;

CREATE TABLE `passes` (
  `PassId` int(10) unsigned NOT NULL auto_increment,
  `PassName` varchar(100) default NULL,
  `PassStatus` varchar(10) default NULL,
  `VisitortypeId` int(10) unsigned default NULL,
  `DeploymentId` int(10) default NULL,
  PRIMARY KEY  (`PassId`),
  KEY `FK_passes_visitortypes` (`VisitortypeId`),
  CONSTRAINT `FK_passes` FOREIGN KEY (`VisitortypeId`) REFERENCES `visitortypes` (`VisitortypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `passes` */

insert  into `passes`(`PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId`) values (6,'pass 222','1',3,2),(7,'C-01','1',2,10),(8,'C-02','1',2,10),(9,'C-03','1',2,10),(10,'C-04','1',2,10),(11,'C-05','1',2,10),(12,'C-06','1',2,10),(13,'C-07','1',2,10),(14,'C-08','1',2,10),(15,'C-09','1',2,10),(16,'C-10','1',2,10),(17,'V-01','1',4,10),(18,'V-02','1',4,10),(19,'V-03','1',4,10),(20,'V-04','1',4,10),(21,'V-05','1',4,10),(22,'V-06','1',4,10),(23,'V-07','1',4,10),(24,'V-08','1',4,10),(25,'V-09','1',4,10),(26,'V-10','1',4,10),(27,'C-01','1',2,11),(28,'C-02','1',2,11),(29,'C-03','1',2,11),(30,'C-04','1',2,11),(31,'C-05','1',2,11),(32,'C-06','1',2,11),(33,'C-07','1',2,11),(34,'C-08','1',2,11),(35,'C-09','1',2,11),(36,'C-10','1',2,11),(37,'V-01','1',4,11),(38,'V-02','1',4,11),(39,'V-03','1',4,11),(40,'V-04','1',4,11),(41,'V-05','1',4,11),(42,'V-06','1',4,11),(43,'V-07','1',4,11),(44,'V-08','1',4,11),(45,'v-09','1',4,11),(46,'V-10','1',4,11),(47,'C-01','1',2,9),(48,'C-02','1',2,9),(49,'C-03','1',2,9),(50,'C-04','1',2,9),(51,'C-05','1',2,9),(52,'C-06','1',2,9),(53,'C-07','1',2,9),(54,'C-08','1',2,9),(55,'C-09','1',2,9),(56,'C-10','1',2,9);

/*Table structure for table `userdetails` */

DROP TABLE IF EXISTS `userdetails`;

CREATE TABLE `userdetails` (
  `UID` int(10) NOT NULL auto_increment,
  `DeploymentID` int(5) default NULL,
  `UserTypeID` int(5) NOT NULL,
  `LoginID` varchar(20) NOT NULL,
  `UserName` varchar(50) default NULL,
  `EmailID` varchar(100) default NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY  (`UID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `userdetails` */

insert  into `userdetails`(`UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID`,`Password`) values (2,2,1,'etracadmin','ETRAC','s@gmail.com','etracadmin'),(3,1,4,'etracguard','vsr','v@hotmail.com','etracguard'),(6,8,2,'westadmin','westadmin','westadmin@etrac.com','westadmin'),(7,8,4,'westguard','westguard','westguard@etrac.com','westguard'),(10,9,2,'hendersonadmin','hendersonadmin','hendersonadmin@henderson.com','hendersonadmin'),(11,9,4,'hendersonguard','hendersonguard','hendersonguard@henderson.com','hendersonguard'),(12,10,2,'courtadmin','courtadmin','courtadmin@court.com','courtadmin'),(13,10,4,'courtguard','courtguard','courtguard@court.com','courtguard'),(14,11,2,'wismaadmin','wismaadmin','wismaadmin@wisma.com','wismaadmin'),(15,11,4,'wismaguard','wismaguard','wismaguard@wisma.com','wismaguard');

/*Table structure for table `usertypes` */

DROP TABLE IF EXISTS `usertypes`;

CREATE TABLE `usertypes` (
  `UserTypeId` int(10) unsigned NOT NULL auto_increment,
  `UserType` varchar(45) NOT NULL,
  `Description` varchar(500) default NULL,
  `CreatedDate` datetime default NULL,
  `Parent` varchar(45) default NULL,
  `level` int(10) unsigned default NULL,
  PRIMARY KEY  (`UserTypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `usertypes` */

insert  into `usertypes`(`UserTypeId`,`UserType`,`Description`,`CreatedDate`,`Parent`,`level`) values (1,'Super Admin',NULL,NULL,NULL,NULL),(2,'Admin',NULL,NULL,NULL,NULL),(3,'Supervisor',NULL,NULL,NULL,NULL),(4,'Guard',NULL,NULL,NULL,NULL);

/*Table structure for table `vehicles` */

DROP TABLE IF EXISTS `vehicles`;

CREATE TABLE `vehicles` (
  `identificationunit` varchar(30) NOT NULL,
  `platenumber` varchar(20) default NULL,
  `containernumber` varchar(30) default NULL,
  `description` varchar(200) default NULL,
  `trailernumber` varchar(30) default NULL,
  `contractor` varchar(30) default NULL,
  `length` varchar(10) default NULL,
  `capacity` varchar(10) default NULL,
  `securityguardname` varchar(100) default NULL,
  `authpersonic` varchar(100) default NULL,
  `authpersonname` varchar(100) default NULL,
  `imagepath` varchar(150) default NULL,
  `deploymentid` int(10) unsigned default NULL,
  PRIMARY KEY  (`identificationunit`),
  KEY `FK_vehicles` (`deploymentid`),
  CONSTRAINT `FK_vehicles` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `vehicles` */

insert  into `vehicles`(`identificationunit`,`platenumber`,`containernumber`,`description`,`trailernumber`,`contractor`,`length`,`capacity`,`securityguardname`,`authpersonic`,`authpersonname`,`imagepath`,`deploymentid`) values ('2342','24333','23423','dfasf','234267','vsr','20','Full','subbu','hjhjhy','Paddu',NULL,NULL),('89898989','52525251','134','hkljh','khkl','dskfj','20','Full','hk','raj','ic',NULL,1);

/*Table structure for table `visitorcheckinout` */

DROP TABLE IF EXISTS `visitorcheckinout`;

CREATE TABLE `visitorcheckinout` (
  `nricid` longtext NOT NULL,
  `name` varchar(100) default NULL,
  `address` varchar(500) default NULL,
  `fromcompany` varchar(100) default NULL,
  `tocompany` int(10) unsigned default NULL,
  `telno` varchar(20) default NULL,
  `persontovisit` varchar(100) default NULL,
  `eventid` int(10) unsigned default NULL,
  `temp` int(10) default NULL,
  `visitortype` int(10) default NULL,
  `keyid` int(10) unsigned default NULL,
  `passid` int(10) unsigned default NULL,
  `gateid` int(10) unsigned default NULL,
  `vehicleplatenumber` varchar(20) default NULL,
  `guardname` varchar(100) default NULL,
  `remarks` varchar(500) default NULL,
  `checkintime` datetime default NULL,
  `checkouttime` datetime default NULL,
  `snapshotpath` varchar(100) default NULL,
  `deploymentid` int(10) unsigned default NULL,
  KEY `FK_visitorcheckinout_companies` (`tocompany`),
  KEY `FK_visitorcheckinout_gates` (`gateid`),
  KEY `FK_visitorcheckinout_events` (`eventid`),
  KEY `FK_visitorcheckinout_passes` (`passid`),
  KEY `FK_visitorcheckinout_ddep` (`deploymentid`),
  CONSTRAINT `FK_visitorcheckinout_ddep` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitorcheckinout` */

insert  into `visitorcheckinout`(`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`) values ('11111','sairam','asdsad','Inno',1,'8878787878','',1,0,2,0,5,3,NULL,'Guru','','2013-03-19 12:09:53','2013-03-19 12:10:55','~/Content/images/default_person.jpg',NULL),('123','hari','San Diego','TCS',3,'878787878','Rai',0,0,1,0,5,0,NULL,'','','2013-04-17 09:04:12','2013-04-17 20:18:22','../Snapshots/201341785820736.png',2),('2222','Gourav','','microsoft',1,'98778837848','',1,0,3,0,6,5,NULL,'Raj','','2013-03-22 09:08:52','2013-03-22 09:13:08','../Snapshots/20133229846297.png',NULL),('344534','sdfh','khkh','khk',1,'skfkh','',0,0,2,0,6,0,NULL,'','','2013-05-07 11:55:11','0001-01-01 00:00:00','~/Content/images/default_person.jpg',2),('7495849','Harish','','microsoft',2,'8898328','',0,0,1,0,6,0,NULL,'','','2013-03-24 23:27:42','2013-03-24 23:28:55','~/Content/images/default_person.jpg',2),('7899930','Harish','4th street','microsoft',2,'8898328','',0,0,1,0,5,0,NULL,'','','2013-03-24 23:25:20','2013-04-21 09:07:23','~/Content/images/default_person.jpg',2),('873475','rajendar','jk','khk',2,'99999999','',0,0,2,0,6,0,NULL,'','','2013-05-08 18:51:02','0001-01-01 00:00:00','../Snapshots/201358185059798.png',1),('123','mr hari','San Diego','TCS',3,'878787878','Rai',0,0,1,0,6,0,NULL,'','','2013-05-08 22:29:52','2013-05-08 22:36:24','../Snapshots/201341785820736.png',2),('NGFSS23435434KKJN','jai','s','sffff',2,'938494929','',0,0,1,1,5,2,NULL,'','','2013-06-05 19:53:23','2013-06-06 21:53:09','../Snapshots/201365195320658.png',2),('S1512795C','mohd jahari ','','may bank',6,'9090','ken',0,38,2,0,7,0,NULL,'','','2013-06-28 15:57:09','2013-06-28 15:57:52','~/Content/images/default_person.jpg',10),('G6864098P250712270713KVW','mD sAIFUL rAHAMAN mD aNSAR aLI','','TRITECH ENRGR & TESTING (S) P.L',6,'9090','',0,0,2,0,7,0,NULL,'Jahari','SURVEYOY','2013-06-28 16:07:41','2013-06-28 16:08:14','~/Content/images/default_person.jpg',10),('S1512795C','mohd jahari ','','may bank',6,'9090','ken',0,38,2,0,7,0,NULL,'','','2013-06-28 16:56:36','2013-06-28 16:58:45','~/Content/images/default_person.jpg',10),('S1512795C','mohd jahari ','','may bank',6,'9090','ken',0,38,2,0,7,0,NULL,'','','2013-06-28 16:59:10','2013-06-28 17:00:07','~/Content/images/default_person.jpg',10),('S1598696D','Razak','','SMA Security',6,'65463948','David Kee',0,0,1,0,7,0,NULL,'','','2013-06-28 17:22:31','2013-06-30 11:37:24','~/Content/images/default_person.jpg',10),('S1512795C','mohd jahari ','','may bank',6,'9090','ken',0,38,2,0,7,0,NULL,'','','2013-06-30 11:01:10','2013-07-01 13:30:19','~/Content/images/default_person.jpg',10),('S1598696D','Razak','','SMA Security',6,'65463948','David Kee',0,0,1,0,7,0,NULL,'','','2013-06-30 11:40:20','2013-06-30 11:40:42','~/Content/images/default_person.jpg',10),('001916033K','Edwin Lidi Edward','Singapore Driving Licence','Nil',6,'Nil','B708 #03 01',0,0,5,0,7,0,NULL,'SS Jahari','Cleaning and Housekeeping','2013-06-30 13:14:05','2013-06-30 13:34:11','~/Content/images/default_person.jpg',10),('S8483125E','Edwin Lidi Edward','','Nil',6,'Nil','B708 #03 01',0,0,5,0,7,0,NULL,'SS Jahari','Housekeeping','2013-06-30 13:33:18','2013-06-30 15:38:15','~/Content/images/default_person.jpg',10),('S7767479I','Lian Teak Chai','','Blk 685 Hougang St.61 #05-164 S 530685',6,'Nil','B700 #04 09',0,0,2,0,8,0,NULL,'','Delivery Curtain','2013-06-30 14:18:49','2013-06-30 16:20:48','~/Content/images/default_person.jpg',10),('S1601986J','Seow Thuan Hwee','IDA','IDA',6,'Nil','',0,0,4,0,9,0,NULL,'','Conduct Survey','2013-06-30 14:53:39','2013-06-30 15:13:16','~/Content/images/default_person.jpg',10),('000132562F','GOH SEOV KWANG','','WATER SEEPAGE PTE LTD',6,'Nil','700#-03-04',0,0,0,0,7,0,NULL,'RAZAK','pelumber work','2013-07-01 09:00:40','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('F0299936Q','Teh Liang Chua','S\'pore Driving License','Goldentech Aircon & Engrg P.L.',6,'Nil','B702 #0209',0,0,2,0,10,0,NULL,'SS Jahari','Plumber','2013-07-01 09:56:02','2013-07-01 16:37:35','~/Content/images/default_person.jpg',10),('062689560051012','Tofazzal Hossain Md MObarak Hossain','','Goldentech Aircon & Engrn P.L',6,'Nil','B702 #0209',0,0,2,0,11,0,NULL,'','Plumber','2013-07-01 10:14:07','2013-07-01 16:30:03','~/Content/images/default_person.jpg',10),('402940425240610','Fon Chew Long','','Goldentech Aircon & Engrg P.L.',6,'Nil','B702 #0209',0,0,2,0,11,0,NULL,'','Plumber','2013-07-01 10:15:23','2013-07-01 16:29:56','~/Content/images/default_person.jpg',10),('031817056031007','Venkatesan Tamilselvan','','Goldentech Aircon & Engrg P.L.',6,'Nil','B702 #0209',0,0,2,0,11,0,NULL,'','Plumber','2013-07-01 10:16:33','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('403409553241012','Tan Guan Sheng','','Auto Pool P.L',6,'Nil','mgmgt',0,0,2,0,12,0,NULL,'SS Jahari','Contractor for Swimming Pool \r\nKey No 21','2013-07-01 10:25:33','2013-07-01 12:47:30','~/Content/images/default_person.jpg',10),('S2195478J','Samsukumar Bin Ali','','LTA',6,'Nil','B698 #01 03',0,0,2,0,12,0,NULL,'SS Jahari','Deliver Parcel','2013-07-01 11:46:52','2013-07-01 11:53:25','~/Content/images/default_person.jpg',10),('5381020911','Mohd Yuslizan Bin Mahmood','','I-Chapter',6,'Nil','B704 #04 07',0,0,2,0,13,0,NULL,'','Painting Work','2013-07-01 11:49:17','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('F1101622R','Chan Sin sing','','Goldentech Aircon & Engrg P.L.',6,'Nil','B702 #0209',0,0,2,0,7,0,NULL,'','Inspection-Checked his Worker','2013-07-01 13:29:10','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('040556','Tan Lian Heng','','Starhub',6,'Nil','B708 #02 03',0,0,2,0,9,0,NULL,'SS Jahari','','2013-07-01 14:04:40','2013-07-01 15:01:46','~/Content/images/default_person.jpg',10),('G6295050T260810260815DME','Singh Suman','G6295050T','Visitor',6,'Nil','B700 #01 07',0,0,4,0,17,0,NULL,'SS Jahari','Visit Tenant','2013-07-01 14:10:33','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1197269A','Tumadi Bin Dulhadi','','PUB to B700 #02 03',6,'Nil','B700 #02 03',0,0,2,0,7,0,NULL,'','Check water flow','2013-07-01 15:23:24','2013-07-01 15:29:43','~/Content/images/default_person.jpg',10),('S1504480B','Mazlan Bin Mohamed Yusoff','Blk 50 Bedok South Ave 3 #02-210 S 150050','PUB TO B704 & 698',6,'Nil','B704 & 698',0,0,2,0,7,0,NULL,'SS Jahari','Checked Meter reading','2013-07-01 17:15:18','2013-07-01 18:18:00','~/Content/images/default_person.jpg',10),('401309144190608','Peter TChong','','Matress Int\'l P.L.',6,'B702 #07 06','',0,0,3,0,8,0,NULL,'','Delivery mattress','2013-07-02 10:32:52','2013-07-02 10:53:07','~/Content/images/default_person.jpg',10),('S6815564I','Lim Siong Hoon','','NTUC',6,'B702 #0209','B702 #0209',0,0,2,0,9,0,NULL,'','Contractor, check ceiling','2013-07-02 10:34:46','2013-07-02 17:33:12','~/Content/images/default_person.jpg',10),('S8240186E','Vincent Tan Yi Tang','Blk 22 Balam Road, #06-130, S 370022','Png Co.',6,'B702 #07 06','B702 #07 06',0,0,2,0,7,0,NULL,'SS Jahari','Contractor','2013-07-02 10:43:59','2013-07-02 10:51:33','~/Content/images/default_person.jpg',10),('S7334609F','Tan Chye Kwee','Blk 643, A.M.Kio Ave 5 #023025 S560643','Faith\'s Cooling Service',6,'B702 #05 04','B702 #05 04',0,0,2,0,10,0,NULL,'','Air Con servicing','2013-07-02 10:50:34','2013-07-03 13:09:52','~/Content/images/default_person.jpg',10),('S1827454Z','Leow Boon Him Tony','nil','S\'pore Driving License',0,'B706 #02 02','B706 #02 02',0,0,3,0,7,0,NULL,'','Delivery carton boxes','2013-07-02 13:18:15','2013-07-02 13:21:57','~/Content/images/default_person.jpg',10),('G8480771R291012111013KVW','Arumugam Mariappan','','Tritech Engrg & Testing S Pte Ltd',6,'Common Area','Nil',0,0,2,0,7,0,NULL,'','Surveyor','2013-07-02 14:42:34','2013-07-02 15:04:20','~/Content/images/default_person.jpg',10),('G8249126R220513240514KVW','Anjapuli Kalaivendan','nil','Tritech Engrg & Testing S pte Lte',6,'Common Area','Nil',0,0,2,0,8,0,NULL,'SS Jahari','Surveyor','2013-07-02 14:44:54','2013-07-02 15:01:54','~/Content/images/default_person.jpg',10),('G5130341K081011081013KVW','Nachiappan Purushothaman','nil','FurnitureMart.SG',6,'B700 #03 08','B700 #03 08',0,0,3,0,7,0,NULL,'SS Jahari','Delivery Mattress','2013-07-02 15:22:11','2013-07-02 15:56:47','~/Content/images/default_person.jpg',10),('G7191768T200412200314KVW','Abdul Malek  Late Abdulkarim','nil','Goldentech Aircon & Electrical P.L.',6,'B702 #02 09','B702 #02 09',0,0,2,0,8,0,NULL,'SS Jahari','Plumber','2013-07-02 15:31:29','2013-07-02 17:19:21','~/Content/images/default_person.jpg',10),('S1513126H','Yeo Ann Thong','Blk 44, Bedok South Road, #05-767 S 460044','Goldentech Aircon & Electrical P.L.',6,'B702 #02 09','B702 #02 09',0,0,2,0,8,0,NULL,'','Plumber','2013-07-02 15:33:53','2013-07-02 17:19:08','~/Content/images/default_person.jpg',10),('S1500167D','Goh Lye Peng','Blk 309A Anchorvale Road, #05-71','Nil',6,'B702 #02 04','B702 #02 04',0,0,2,0,10,0,NULL,'','Delivery','2013-07-02 16:00:03','2013-07-02 16:00:59','~/Content/images/default_person.jpg',10),('S1442574H','LOH TIAN TONG','BLK 411 PANDAN GARDEN #12-88','700 #01-04',6,'NIL','700#01-04',0,0,0,0,13,0,NULL,'Razak','pipe leaking','2013-07-02 17:49:03','2013-07-02 17:54:13','~/Content/images/default_person.jpg',10),('S1442574H','LOH TIAN TONG','BLK 411 PANDAN GARDEN #12-88','TOH GOH TEE',6,'NIL','700#01-04',0,0,0,0,13,0,NULL,'Razak','pipe leaking','2013-07-02 17:57:13','2013-07-02 17:59:35','~/Content/images/default_person.jpg',10),('G2117451W040613300415KVW','Yap Kim MUN','NIL','P FOUR (2007)PTE',6,'706 #02-01','706#02-01',0,0,0,0,7,0,NULL,'RAZAK','GROUNDING FLOOR','2013-07-03 09:43:27','2013-07-03 13:35:54','~/Content/images/default_person.jpg',10),('G6810520Q160513100415KVW','ISLAM TAUHDUL','NIL','P FOUR (2007)PTE',6,'706 #02-01','706#02-01',0,0,0,0,7,0,NULL,'RAZAK','GROUDING FLOOR','2013-07-03 09:49:41','2013-07-03 13:35:38','~/Content/images/default_person.jpg',10),('S1841485F','ABU BAKAR S/O VILVEERANKUTTY','NIL','P FOUR (2007)PTE',6,'706 #02-01','706#02-01',0,0,0,0,7,0,NULL,'RAZAK','GROUNDING FLOOR','2013-07-03 09:55:34','2013-07-03 13:34:47','~/Content/images/default_person.jpg',10),('S0011435I','Arunasalam Balakrishnan','Nil','NEA',6,'Inspection','',0,0,2,0,18,0,NULL,'Jahari','Inspection common area','2013-07-03 10:02:45','2013-07-03 11:38:03','~/Content/images/default_person.jpg',10),('S0106288C','Chua Khee Eng','','NEA',6,'Inspection','',0,0,2,0,18,0,NULL,'Jahari','Inspection common area','2013-07-03 10:03:42','2013-07-03 11:38:28','~/Content/images/default_person.jpg',10),('S0447652B','Tan Peng Lim','','NEA',6,'Inspection','',0,0,2,0,18,0,NULL,'','Inspection common area','2013-07-03 10:04:51','2013-07-03 11:37:36','~/Content/images/default_person.jpg',10),('S0208577A','Loh Qee Teck','S\'pore Driving License','Self Employ',6,'B704 #04 06','B704 #04 06',0,0,2,0,8,0,NULL,'Jahari','Plumber','2013-07-03 10:15:36','2013-07-03 13:11:53','~/Content/images/default_person.jpg',10),('S1500167D','Goh Lye Peng','Blk 309A Anchorvale Road, #05-71','Nil',6,'B702 #02 04','B702 #02 04',0,0,2,0,10,0,NULL,'','Delivery','2013-07-03 10:45:09','2013-07-03 10:48:11','~/Content/images/default_person.jpg',10),('S7126942F','Lee Kay Hong','Blk 988A Jurong West St. 93, #14-627 S 641988','Sanzio',6,'B702 #08 06','B702 #08 06',0,0,3,0,11,0,NULL,'','Delivery Coffee table','2013-07-03 10:55:51','2013-07-03 11:09:01','~/Content/images/default_person.jpg',10),('F7422692L250113120215KVW','Rayjul Perrer Olar','Lau Yie Pheng 23 Mariam Walk','B708 #01 06',0,'Nil','B708 #01 06',0,0,5,0,16,0,NULL,'Jahari','Domestic Helper','2013-07-03 11:47:35','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1442574H','Tan Chye Kwee','Blk 643, Ang Mo Kio Ave 5, #02-3025 S 560643','Nil',6,'B702 #05 04','B702 #05 04',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-03 12:56:00','2013-07-07 13:26:50','~/Content/images/default_person.jpg',10),('S9036357C','Albert Yeo Jun Wei','Singapore Driving Lic','Nil',6,'B702 #05 04','B702 #05 04',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-03 12:58:19','2013-07-22 13:19:40','~/Content/images/default_person.jpg',10),('S1626018E','SURAYA BINTE ASHIKO HUSSEIN','BLK 151 BEDOK RESERVOIR RD #02-1735','CLEANING SERVICING',6,'706#02-04/04-04','706#02-04/04-04',0,0,0,0,24,0,NULL,'RAZAK','CLEANING SERVICING','2013-07-03 14:39:39','2013-07-04 13:44:17','~/Content/images/default_person.jpg',10),('403409553241012','Tan Guan Sheng','','Auto Pool P.L',6,'Nil','mgmgt',0,0,2,0,12,0,NULL,'SS Jahari','Contractor for Swimming Pool \r\nKey No 21','2013-07-03 14:40:33','2013-07-03 15:08:14','~/Content/images/default_person.jpg',10),('G6527529K140812130814KVW','Paritosh Kumer Das Nirod Baran Das','Nil','Menton Technologies P.L',6,'B698 #02 05','B698 #02 05',0,0,2,0,7,0,NULL,'','Checked Internet\r\nKeys nos 05 & 23','2013-07-03 15:21:05','2013-07-03 15:42:28','~/Content/images/default_person.jpg',10),('G7829610R250512270514KVW','Nagarathinam Senthilkumaran','Nil','Menton Technologies P.L',6,'B698 #02 05','',0,0,2,0,7,0,NULL,'','Checked Internet\r\nKeys nos 05 & 23','2013-07-03 15:22:41','2013-07-03 15:42:14','~/Content/images/default_person.jpg',10),('S2041677G','PHANG CHEW FATT','','CHEW WAH',6,'COMMAN AREA','COMMAN AREA',0,0,0,0,7,0,NULL,'RAZAK','TAKE A LOOK ','2013-07-04 08:46:41','2013-07-04 10:21:33','~/Content/images/default_person.jpg',10),('402347910060209','lee shoh chun','nil','yun chai renovation',6,'702#)@-09','702#02-09',0,0,0,0,8,0,NULL,'RAZAK','cONTRACTOR','2013-07-04 09:40:28','2013-07-04 15:55:13','~/Content/images/default_person.jpg',10),('S6815564I','Lim Siong Hoon','','NTUC',6,'B702 #0209','B702 #0209',0,0,2,0,9,0,NULL,'','Contractor, check ceiling','2013-07-04 09:41:07','2013-07-04 15:55:23','~/Content/images/default_person.jpg',10),('F7371803K030613170115KVW','Yeo Eng Soon','','Hwa Glass P.L',6,'B702 #10-09','B702 #10-09',0,0,2,0,9,0,NULL,'Jahari','Glass work','2013-07-04 10:22:53','2013-07-04 16:56:49','~/Content/images/default_person.jpg',10),('G8407632K310113300114KVW','Mahabub Alam Md Abdul Alim Mollah','','Hwa Glass P.L',6,'B702 #10-09','',0,0,2,0,9,0,NULL,'Jahari','Glass work','2013-07-04 10:24:16','2013-07-04 16:56:12','~/Content/images/default_person.jpg',10),('G2191380X090113271014KVW','Choh Yong Hwa','Nil','Comfort A/con & Engrg P.L.',6,'B702 #03-09','B702 #03-09',0,0,2,0,10,0,NULL,'','Air con Installation','2013-07-04 10:25:57','2013-07-04 17:59:22','~/Content/images/default_person.jpg',10),('G8107582X071011061013KVW','Alan Ong Chee Liang','Nil','Comfort A/con & Engrg P.L.',6,'B702 #03-09','B702 #03-09',0,0,2,0,10,0,NULL,'','A/con Installation','2013-07-04 10:27:21','2013-07-04 17:58:51','~/Content/images/default_person.jpg',10),('S1769113I','Chew Kor Wee','','Toll Express',6,'B704 #04-08','B704 #04-08',0,0,3,0,7,0,NULL,'Jahari','Delivery','2013-07-04 10:34:27','2013-07-04 10:40:03','~/Content/images/default_person.jpg',10),('S8200496C','Loehan Bin Hairum','','Ntuc Card',6,'B702 #08-06','',0,0,3,0,11,0,NULL,'Jahari','Delivery','2013-07-04 10:37:36','2013-07-04 10:44:36','~/Content/images/default_person.jpg',10),('F7845633R','Chan Sung Leng','','Self Employed',6,'B706 #02 04','B706 #02 04',0,0,2,0,7,0,NULL,'Jahari','Painting work','2013-07-04 10:46:58','2013-07-04 11:43:36','~/Content/images/default_person.jpg',10),('S7915218H','Ho Kok Peng Lawrence','Blk 129, Bedok North St.2 #04-28 S 460129','Christifori',6,'B708 #04-08','B708 #04-08',0,0,2,0,11,0,NULL,'Jahari','Repair Piano','2013-07-04 10:53:34','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6849827P050613020614KVW','Ong Siang Yong','Nil','Soon Yiap Aluminium Contractor',6,'B702 #08-06','B702 #08-06',0,0,2,0,7,0,NULL,'Jahari','Check Window ','2013-07-04 11:45:44','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1626018E','SURAYA BINTE ASHIKO HUSSEIN','BLK 151 BEDOK RESERVOIR RD #02-1735','CLEANING SERVICING',6,'706#02-04/04-04','706#02-04/04-04',0,0,0,0,24,0,NULL,'RAZAK','CLEANING SERVICING','2013-07-04 13:55:15','2013-07-10 14:22:38','~/Content/images/default_person.jpg',10),('S1198368E','HAM HWEE WOON','Nil','NIL',6,'702#03-08','B702 #03-08',0,0,0,0,11,0,NULL,'RAZAK','Plumber WORK','2013-07-04 15:18:49','2013-07-04 16:07:30','~/Content/images/default_person.jpg',10),('001760778J','Mah Sze LEONG','Nil','NIL',0,'698 #03-03','698#o3-03',0,0,0,0,12,0,NULL,'RAZAK','SEE OWER','2013-07-04 15:35:55','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('063050032150313','Sahin AHMEDABU BAKKOR','Nil','FIBER REACH',6,'MDF','MDF',0,0,0,0,14,0,NULL,'','CABER WORK','2013-07-04 15:43:38','2013-07-04 15:57:46','~/Content/images/default_person.jpg',10),('G8399946U260313190315KVW','Muthuramalingam Naganathan','Nil','Fiber Reach',6,'MDF','MDF',0,0,2,0,13,0,NULL,'Jahari','MDF Room','2013-07-04 15:46:14','2013-07-04 15:57:29','~/Content/images/default_person.jpg',10),('S1419298J','Kong Chee Fai','Blk 302, Tampines St. 32, # 08-34 S 520302','Tai Seng',6,'B700 #04 04','B700 #04 04',0,0,3,0,7,0,NULL,'Jahari','Delivery Food','2013-07-04 15:49:39','2013-07-04 16:11:04','~/Content/images/default_person.jpg',10),('G5901822T310812050914EME','Mohamed Sajin','','NIL',0,'B700 #03-03','B700 #03-03',0,0,2,0,16,0,NULL,'','','2013-07-04 16:10:02','2013-07-04 18:23:10','~/Content/images/default_person.jpg',10),('G8009826Q250311140413KVW','Maruf Miah Tahir Miah','Nil','SBL Engrg',6,'B708 #03 12','B708 #03 12',0,0,2,0,7,0,NULL,'','Contractor doing touch up work','2013-07-04 16:35:12','2013-07-04 17:00:21','~/Content/images/default_person.jpg',10),('G5166447M180711180713KVW','Velladurai arikrishnan','Nil','S T CARGO AGENICIES',6,'706#04-04','706#04-04',0,0,0,0,15,0,NULL,'RAZAK','COLLETION','2013-07-04 17:24:25','2013-07-04 18:06:19','~/Content/images/default_person.jpg',10),('G8410889N230412200713KVW','Tee Tze Fong','Nil','Cosyair AIRCON',6,'708#03-07','708#03-07',0,0,0,0,7,0,NULL,'RAZAK','AIRCON LEAKING','2013-07-04 18:29:48','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6679497R280812270814KVW','Cheng wen kai','Nil','Cosyair AIRCON',6,'708#03-07','708#03-07',0,0,0,0,7,0,NULL,'RAZAK','AIRCON KEAKING','2013-07-04 18:33:40','2013-07-04 18:55:34','~/Content/images/default_person.jpg',10),('S1198368E','HAM HWEE WOON','Nil','NIL',6,'702#03-08','B702 #03-08',0,0,0,0,11,0,NULL,'RAZAK','Plumber WORK','2013-07-05 08:58:31','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6650958W060312141013KVW','TEO CHIN WEI','','AIR PRO ENGINEERING',0,'704 # 02-06','704# 02-06',0,0,0,0,8,0,NULL,'KAMAL','AIR CON SERVICE','2013-07-05 09:58:41','2013-07-05 12:19:56','~/Content/images/default_person.jpg',10),('F7099731L','CHAW CHIN SIONG','Nil','AIR PRO ENGINEERING',0,'704 # 02-06A','704# 02-06',0,0,0,0,8,0,NULL,'KAMAL','AIR CON SERVICE','2013-07-05 10:02:41','2013-07-05 12:19:28','~/Content/images/default_person.jpg',10),('S7011963C','Ng meng Kian','SAF','Nil',6,'B704 #04-08','B704 #04-08',0,0,3,0,7,0,NULL,'','Delivery Parcel','2013-07-05 10:51:05','2013-07-05 10:57:39','~/Content/images/default_person.jpg',10),('S1561805A','Chua Soon Chiong','Blk 427, Chua Chu Kang Ave 4, #06-190 S 680427','IKEA',0,'B702 #10-04','B702 #10-04',0,0,3,0,7,0,NULL,'Jahari','Delivery Chairs','2013-07-05 11:47:34','2013-07-05 12:12:58','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool',6,'Swimming Pool','Pool area',0,0,0,0,7,0,NULL,'RAZAK','Auto Pool Servicing','2013-07-05 15:53:41','2013-07-05 15:56:57','~/Content/images/default_person.jpg',10),('F7581960U170512271213KVW','Yeo BOK KEE','Nil','Fang KWANG Ele',0,'702 #08-02','702#08-02',0,0,0,0,8,0,NULL,'RAZAK','Opennet','2013-07-05 16:02:40','2013-07-05 16:35:57','~/Content/images/default_person.jpg',10),('G8256855M180512100514KVW','Palaniyandi Ramesh','Nil','NIL',6,'702 #08-02','702#08-02',0,0,0,0,8,0,NULL,'RAZAK','Opennet','2013-07-05 16:11:33','2013-07-05 16:36:05','~/Content/images/default_person.jpg',10),('S1367642I','cHEW HOCK SENG','nil','HALIPING HAND',6,'708 0207','708 0207',0,0,0,0,9,0,NULL,'AZIZ','QAUTATION','2013-07-06 09:35:49','2013-07-06 09:51:01','~/Content/images/default_person.jpg',10),('000884573E','TAN PENG LEONG','','NIL',6,'708 0II2','708 0II2',0,0,0,0,7,0,NULL,'AZIZ','AIR SER ','2013-07-06 09:42:40','2013-07-06 10:35:34','~/Content/images/default_person.jpg',10),('000848940D','LAW HAK YONG','Nil','NIL',6,'702 #08-02','702#08-02',0,0,0,0,8,0,NULL,'AZIZ','A\\C SER','2013-07-06 09:52:58','2013-07-06 10:22:11','~/Content/images/default_person.jpg',10),('G2W260882M220513210515KVW','WONG YONG DE','Nil','OPR AIRCON',6,'702#05-05','702#0505',0,0,0,0,9,0,NULL,'RAZAK','AIRCON SER','2013-07-06 10:09:14','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G2248177R220513210515KVW','PENG SWEET WIN','Nil','OPR AIRCON',0,'702#05-05','702 0205',0,0,0,0,9,0,NULL,'RAZAK','AIRCON SER','2013-07-06 10:12:58','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8326013R060513140415KVW','LEE HONG YEE','Nil','COOL ONE SER',6,'702#0507','702#0507',0,0,0,0,10,0,NULL,'RAZAK','AIRCON SER','2013-07-06 10:16:40','2013-07-06 11:15:02','~/Content/images/default_person.jpg',10),('G5280915R030512030514KVW','CHIDAMBARAM SABAPATHI','Nil','COOL ONE SER',6,'702#05-07','702#0507',0,0,0,0,10,0,NULL,'RAZAK','AIRCON SER','2013-07-06 10:21:49','2013-07-06 11:14:38','~/Content/images/default_person.jpg',10),('000671291B','KOH CHER GEE','Nil','STARHUB',6,'702#08-06','702-0806',0,0,0,0,11,0,NULL,'RAZAK','INSTALLATION','2013-07-06 10:39:27','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('001971278B','GOH KIAN HENG','','IKEA',6,'700 04 08','700 0408',0,0,0,0,7,0,NULL,'AZIZ','DEL BOOK SHEEL','2013-07-06 11:10:22','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('403617741171210','CHIN KOK HAU','Nil','TAKASIMA HEAL-MART',6,'702#10-05','702-10-05',0,0,0,0,7,0,NULL,'RAZAKBIC','BICLCLY SER','2013-07-06 11:58:07','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1607175G','LAU YEW LEONG','Nil','NIL',6,'698#03-05','698#0305',0,0,0,0,7,0,NULL,'RAZAK','PIANO SER','2013-07-06 13:31:36','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1546776B','LEE THIAM BENG','Nil','NIL',6,'708-02-10','708#02-10',0,0,0,0,8,0,NULL,'RAZAK','PLUMBER','2013-07-06 14:35:39','2013-07-06 14:36:35','~/Content/images/default_person.jpg',10),('S1282344D','NG SWEE CHOO','Nil','NIL',6,'698 #OI-O8','698#0108',0,0,0,0,7,0,NULL,'RAZAK','PLUMBER WORK','2013-07-08 09:22:03','2013-07-08 14:15:33','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,8,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-08 10:17:16','2013-07-08 11:41:20','~/Content/images/default_person.jpg',10),('S1188606Z','Tan Soon Teck','Nil','First Comm',6,'Clubhouse','Management',0,0,2,0,9,0,NULL,'Jahari','Collect coins from clubhouse coin phone','2013-07-08 12:11:47','2013-07-08 12:22:24','~/Content/images/default_person.jpg',10),('001092932G','jumari bin surok','Nil','NIL',6,'700#oi-io','700#01-10',0,0,0,0,8,0,NULL,'RAZAK','fixer mirron','2013-07-08 14:21:43','2013-07-08 15:07:39','~/Content/images/default_person.jpg',10),('002097864G','marimuthu sivaji','Nil','dyna cool air pte ltd',6,'700#03-02','700#0302',0,0,0,0,9,0,NULL,'RAZAK','aircon ser','2013-07-08 14:52:06','2013-07-08 19:05:44','~/Content/images/default_person.jpg',10),('G5435441Q070613070615KVW','sivasamy palanrajan','Nil','NIL',6,'700#03-02','700#0302',0,0,0,0,10,0,NULL,'RAZAK','Aircon Ser','2013-07-08 14:55:48','2013-07-08 19:05:26','~/Content/images/default_person.jpg',10),('000524866A','lee pui kin christopher','Nil','NIL',6,'708#01-08','706#01-08',0,0,0,0,10,0,NULL,'RAZAK','deliver oven ','2013-07-08 14:59:42','2013-07-08 15:19:17','~/Content/images/default_person.jpg',10),('S1696027F','tang loon huan','Nil','Fang KWANG Ele',6,'702#06-07','702#0607',0,0,0,0,12,0,NULL,'RAZAK','opennet key5','2013-07-08 15:16:58','2013-07-09 13:44:09','~/Content/images/default_person.jpg',10),('4471920472','nilanjala kamini','Nil','NIL',6,'708#01-05','708#01-05',0,0,0,0,7,0,NULL,'RAZAK','partime work','2013-07-08 16:06:40','2013-07-08 17:53:28','~/Content/images/default_person.jpg',10),('S1377267C','ong joo Ann','blk 57 circuit Rd #01-125 spore- 370057','NIL',6,'702#10-02','702#10-02',0,0,0,0,8,0,NULL,'RAZAK','House kepping','2013-07-08 16:15:29','2013-07-08 18:37:16','~/Content/images/default_person.jpg',10),('G7723846N240413200415KVW','Subramaniaan sathiyamoorthy','Nil','Menton Technologies P.L',6,'702#06-07','702#0607',0,0,0,0,10,0,NULL,'RAZAK','opennet key no (6/23) ','2013-07-08 16:23:34','2013-07-08 16:50:46','~/Content/images/default_person.jpg',10),('G6554502R050213230115KVW','MD rony khan MD RUHUL','Nil','NIL',6,'702#0607','702#0607',0,0,0,0,10,0,NULL,'RAZAK','OPENNET','2013-07-08 16:30:13','2013-07-08 16:50:31','~/Content/images/default_person.jpg',10),('S9235130J','l YNNA ONG SI RUI','BLK 218 TEMPINES STREE 24 #09-18','MISTERY MANPOWER',6,'702#06-02 /10-06','702#06-02/10-06',0,0,0,0,7,0,NULL,'RAZAK','SERVEY','2013-07-08 19:19:46','2013-07-08 19:34:26','~/Content/images/default_person.jpg',10),('G6559047L110711190713KVW','Md Rohul Amin Md Mir Kashem','Common Area','Chen Wa Landscape Pte Ltd',6,'Nil','Common Area',0,0,2,0,7,0,NULL,'Jahari','Gardening','2013-07-09 09:43:37','2013-07-09 16:52:27','~/Content/images/default_person.jpg',10),('G6723244K040812211113KVW','Md Jakir Hossain ','','Chen Wa Landscape Pte Ltd',6,'Nil','',0,0,2,0,7,0,NULL,'Jahari','Landscaping','2013-07-09 09:45:50','2013-07-09 16:52:38','~/Content/images/default_person.jpg',10),('G6760393T070912050914KVW','Liton Miah Mohamed Chunnu','','Chen Wa Landscape Pte Ltd',6,'Nil','',0,0,2,0,7,0,NULL,'Jahari','Landscaping','2013-07-09 09:47:03','2013-07-09 16:51:40','~/Content/images/default_person.jpg',10),('S1284815C','Poon Mai Chan','Nil','Changi General Hospital',6,'B708 #02-07','B708 #02-07',0,0,5,0,8,0,NULL,'Jahari','Attend Patiet','2013-07-09 09:49:18','2013-07-09 10:24:08','~/Content/images/default_person.jpg',10),('S1592437C','Ramli Bin Sunyar','Nil','Self Employed',6,'B708 03-11','B708 03-11',0,0,2,0,8,0,NULL,'','Plumber','2013-07-09 10:36:33','2013-07-09 15:43:45','~/Content/images/default_person.jpg',10),('040612/S8309037E','Soon M Y Samuel','','Starhub',0,'B704 #01-04','B704 #01-04',0,0,2,0,9,0,NULL,'Jahari','Istallation','2013-07-09 10:47:28','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7102531D','Yeow Chuan Hock','','Self Employed',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Plumber','2013-07-09 10:52:20','2013-07-09 11:14:18','~/Content/images/default_person.jpg',10),('S8481875E','Ooi Beng Heng','Nil','Self Employed',6,'B706 #02-02','B706 #02-02',0,0,2,0,9,0,NULL,'Jahari','Aircon servicing','2013-07-09 12:38:07','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7315799X','Low Boon Chon','','Self Employed',6,'B706 #02-02','B706 #02-02',0,0,2,0,9,0,NULL,'Jahari','Air con servicing','2013-07-09 12:39:23','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7625224F','Sim Tian Cheng','Nil','Pantos LG',6,'B698 #04-01','B698 #04-01',0,0,2,0,10,0,NULL,'Jahari','Deliver T.V','2013-07-09 13:07:12','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7594102T120711110713KVW','Koh Kok Chuan','Nil','Fang Kwang Electrical P.L',0,'B704 #01-04','B704 #01-04',0,0,2,0,11,0,NULL,'Jahari','Openet Key nos 5','2013-07-09 13:42:51','2013-07-09 14:02:19','~/Content/images/default_person.jpg',10),('S1696027F','tang loon huan','Nil','Fang KWANG Ele',6,'702#06-07','702#0607',0,0,0,0,12,0,NULL,'RAZAK','opennet key5','2013-07-09 14:02:49','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7102531D','Yeow Chuan Hock','','Self Employed',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Plumber','2013-07-09 15:14:50','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S0008663J','mohamad shaikh','','sma',7,'90909','',0,0,2,0,27,0,NULL,'','','2013-07-09 17:56:01','2013-07-09 17:56:41','~/Content/images/default_person.jpg',11),('S1403978C','tengku omar','COMMON AREA','PEST MASTER',6,'PEST MASTER','2',0,0,2,0,7,0,NULL,'s/o johari','FORGING','2013-07-10 09:25:18','2013-07-10 10:44:54','~/Content/images/default_person.jpg',10),('G8256855M180512100514KVW','Palaniyandi Ramesh','Nil','Rainbow Splaash Pte Ltd',6,'702 #04-04','702 #04-04',0,0,2,0,8,0,NULL,'Jahari','Openet','2013-07-10 09:50:33','2013-07-10 12:50:45','~/Content/images/default_person.jpg',10),('F7581960U170512271213KVW','Yeo BOK KEE','Nil','Fang Kwang Electrical P.L',0,'702 #04-04','702 #04-04',0,0,2,0,8,0,NULL,'Jahari','Opennet','2013-07-10 09:51:36','2013-07-10 12:51:04','~/Content/images/default_person.jpg',10),('000653464D/S1460292E','Tan Puay Koon','','APL Aircon Services',6,'B700 #03-06','B700 #03-06',0,0,2,0,9,0,NULL,'Jahari','Air con servicing','2013-07-10 10:19:11','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7190813K190711210713KVW','Sekar Senthil Kumar','','APL Aircon Services',6,'B700 #03-06','B700 #03-06',0,0,2,0,9,0,NULL,'Jahari','Air con servicing','2013-07-10 10:20:30','2013-07-10 11:13:08','~/Content/images/default_person.jpg',10),('G6285755U041011021013KVW','Zhong WeiDong','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,0,0,10,0,NULL,'Jahari','Air con Installation','2013-07-10 10:30:35','2013-07-10 17:26:41','~/Content/images/default_person.jpg',10),('G6652013M090413100414KVW','Kamal Krisnan Bhattacharjee Gopal B.','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,2,0,10,0,NULL,'Jahari','Air con Installation','2013-07-10 10:32:26','2013-07-10 17:26:15','~/Content/images/default_person.jpg',10),('G2268601T150513050515KVW','Wu Ming Huang','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work','2013-07-10 10:50:41','2013-07-10 17:32:00','~/Content/images/default_person.jpg',10),('S2504198D','Lim Foon Tian','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work (Cabinet)','2013-07-10 10:52:09','2013-07-10 17:31:27','~/Content/images/default_person.jpg',10),('S8470820H','Lim Zhi Yong','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work','2013-07-10 10:53:15','2013-07-11 11:01:52','~/Content/images/default_person.jpg',10),('S7538709A','Chew Chuan Thiam','Nil','Self Employed',6,'B702 #04-04','B702 #04-04',0,0,2,0,12,0,NULL,'Jahari','Plumber','2013-07-10 10:59:40','2013-07-10 18:00:45','~/Content/images/default_person.jpg',10),('G6554502R050213230115KVW','Md Rony Khan Md Ruhul','Nil','Menton Technologies P.L',6,'702#04-04','702#04-04',0,0,2,0,7,0,NULL,'Jahari','Check Internet','2013-07-10 11:45:28','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7723846N240413200415KVW','Subramaniaan Sathiyamoorthy','Nil','Menton Technologies P.L',6,'702 #04-04','702 #04-04',0,0,2,0,10,0,NULL,'Jahari','Internet ','2013-07-10 11:46:21','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G5082161M101212271114KVW','Liu GuanGlu','Nil','Aprisin Singapore Pte Ltd',6,'B698 #01-03','B698 #01-03',0,0,2,0,7,0,NULL,'Jahari','Delivery','2013-07-10 12:35:50','2013-07-10 12:44:41','~/Content/images/default_person.jpg',10),('S1592437C','Ramli Bin Sunyar','Nil','Self Employed',6,'B708 03-11','B708 03-11',0,0,2,0,8,0,NULL,'','Plumber','2013-07-10 13:40:46','2013-07-10 17:50:48','~/Content/images/default_person.jpg',10),('040649','xie pingjun malvin','Nil','Starhub',6,'702#06-07','702#0607',0,0,0,0,8,0,NULL,'RAZAK','instai caber','2013-07-10 14:15:51','2013-07-10 15:11:32','~/Content/images/default_person.jpg',10),('057831103250912','yu xiaoyue','Nil','Gain City Best-Electrical Pte.Ltd',6,'702#02-02','B702 #02 02',0,0,0,0,13,0,NULL,'RAZAK','aircon ser','2013-07-10 14:21:56','2013-07-10 17:24:21','~/Content/images/default_person.jpg',10),('S1626018E','SURAYA BINTE ASHIKO HUSSEIN','BLK 151 BEDOK RESERVOIR RD #02-1735','CLEANING SERVICING',6,'706#02-04/04-04','706#02-04/04-04',0,0,0,0,24,0,NULL,'RAZAK','CLEANING SERVICING','2013-07-10 14:23:47','2013-07-11 13:07:24','~/Content/images/default_person.jpg',10),('000544198G','tan see meng','Nil','NIL',6,'702-10-02','702#10-02',0,0,0,0,14,0,NULL,'RAZAK','aircon ser','2013-07-10 14:41:49','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('403409553241012','Tan Guan Sheng','','Auto Pool P.L',6,'Nil','mgmgt',0,0,2,0,15,0,NULL,'RAZAK','Contractor for Swimming Pool \r\nKey No 21','2013-07-10 14:45:52','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,8,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-10 15:10:34','2013-07-12 15:04:58','~/Content/images/default_person.jpg',10),('S1377267C','ong joo Ann','blk 57 circuit Rd #01-125 spore- 370057','NIL',6,'702#10-02','702#10-02',0,0,0,0,15,0,NULL,'RAZAK','House kepping','2013-07-10 17:10:47','2013-07-10 19:25:02','~/Content/images/default_person.jpg',10),('001820888K','tham woei','Nil','NIL',0,'702#06-05','702#06-05',0,0,0,0,8,0,NULL,'','aircon ser','2013-07-10 17:49:29','2013-07-10 18:08:32','~/Content/images/default_person.jpg',10),('G8256855M180512100514KVW','Palaniyandi Ramesh','Nil','Rainbow Splaash Pte Ltd',6,'702 #04-04','702 #04-04',0,0,2,0,7,0,NULL,'Jahari','Openet','2013-07-10 18:31:05','2013-07-10 19:04:00','~/Content/images/default_person.jpg',10),('F7581960U170512271213KVW','Yeo BOK KEE','Nil','Fang Kwang Electrical P.L',0,'702 #04-04','702 #04-04',0,0,2,0,7,0,NULL,'Jahari','Opennet','2013-07-10 18:31:40','2013-07-10 19:03:35','~/Content/images/default_person.jpg',10),('G6285755U041011021013KVW','Zhong WeiDong','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,0,0,10,0,NULL,'Jahari','Air con Installation','2013-07-11 10:18:25','2013-07-11 17:24:03','~/Content/images/default_person.jpg',10),('G6652013M090413100414KVW','Kamal Krisnan Bhattacharjee Gopal B.','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,2,0,10,0,NULL,'Jahari','Air con Installation','2013-07-11 10:18:41','2013-07-11 17:23:26','~/Content/images/default_person.jpg',10),('G8400411T271211141213KVW','Polash Kazi Late Mosharaf Kazi','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,2,0,7,0,NULL,'Jahari','Air con Installation','2013-07-11 10:20:29','2013-07-11 17:23:48','~/Content/images/default_person.jpg',10),('S2504198D','Lim Foon Tian','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work (Cabinet)','2013-07-11 11:01:33','2013-07-11 13:04:47','~/Content/images/default_person.jpg',10),('G2268601T150513050515KVW','Wu Ming Huang','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work','2013-07-11 11:02:01','2013-07-11 13:05:02','~/Content/images/default_person.jpg',10),('G8228134M230513190514KVW','Muthusamy Dever','Nil','Technics Aircon Ent',6,'B698 #04-10','B698 #04-10',0,0,2,0,9,0,NULL,'Jahari','aircon servicing','2013-07-11 11:17:34','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7704257T','Lee Wai Hong','Nil','Self Employed',6,'B698 #02 05','',0,0,2,0,16,0,NULL,'Jahari','Aircon servicing','2013-07-11 11:18:56','2013-07-11 12:40:19','~/Content/images/default_person.jpg',10),('S1267334E','Cheah Yak Hock','Nil','Self Employed',6,'B704 #04-08','B704 #04-08',0,0,2,0,15,0,NULL,'Jahari','Delivery','2013-07-11 11:20:20','2013-07-11 11:42:05','~/Content/images/default_person.jpg',10),('G8388634Q','Win Naung Kyaw','Nil','Singtel',6,'B698 #01-05','B698 #01-05',0,0,2,0,7,0,NULL,'Jahari','Check telephone line','2013-07-11 11:55:08','2013-07-11 12:18:29','~/Content/images/default_person.jpg',10),('S8470820H','Lim Zhi Yong','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,11,0,NULL,'Jahari','Carpentry work','2013-07-11 13:04:38','2013-07-15 11:26:09','~/Content/images/default_person.jpg',10),('001546090A','Tay Geck Hock','Nil','NIL',6,'698#02-12','698#02-12',0,0,0,0,9,0,NULL,'RAZAK','washmecing','2013-07-11 14:39:02','2013-07-11 15:07:41','~/Content/images/default_person.jpg',10),('001892290J','Habeebullah sakul hameed','Nil','NIL',6,'702#03-01','702#03-01',0,0,0,0,7,0,NULL,'RAZAK','move out','2013-07-11 15:11:30','2013-07-11 15:35:40','~/Content/images/default_person.jpg',10),('G8114249T150912140914KVW','Pang Tian Ching','','Heavenly Engrg',6,'706#03-02','706#03-02',0,0,2,0,10,0,NULL,'Jahari','Aircon Service','2013-07-11 15:46:42','2013-07-11 17:17:27','~/Content/images/default_person.jpg',10),('G2083544W120612110614KVW','Goh Zhang Fei','','Heavenly Engrg',6,'706#03-02','706#03-02',0,0,2,0,10,0,NULL,'Jahari','Aircon Sevice','2013-07-11 15:47:58','2013-07-11 17:17:03','~/Content/images/default_person.jpg',10),('S7076994H','Ng Lai Kiang','','Kiang Aircon engrg',6,'B698 #02-09','B698 #02-09',0,0,2,0,7,0,NULL,'Jahari','Aircon servicing','2013-07-11 16:32:23','2013-07-11 17:24:30','~/Content/images/default_person.jpg',10),('S1546776B','LEE THIAM BENG','Nil','NIL',6,'708-02-10','708#02-10',0,0,0,0,8,0,NULL,'RAZAK','PLUMBER','2013-07-11 17:49:49','2013-07-11 18:40:46','~/Content/images/default_person.jpg',10),('G6601524L270313190414KVW','MD RONI MD ABDUL HOSSAIN','Nil','Menton Technologies P.L',6,'702#04-04','702 #04-04',0,0,0,0,8,0,NULL,'RAZAK','OPENNET KEY [5/23]','2013-07-12 09:56:22','2013-07-12 10:31:34','~/Content/images/default_person.jpg',10),('G6285755U041011021013KVW','Zhong WeiDong','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,0,0,9,0,NULL,'Jahari','Air con Installation','2013-07-12 09:57:00','2013-07-12 15:58:06','~/Content/images/default_person.jpg',10),('G6652013M090413100414KVW','Kamal Krisnan Bhattacharjee Gopal B.','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,2,0,9,0,NULL,'Jahari','Air con Installation','2013-07-12 09:57:26','2013-07-12 15:57:54','~/Content/images/default_person.jpg',10),('002056151K','MUHAMMAD NASRUL BIN AHMAD','DRIVING LICENCE','NIL',6,'702-06-10','702-06-10',0,0,0,0,10,0,NULL,'RAZAK','APPOINTMENT WINT OWNNER','2013-07-12 10:09:35','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('000707593H','KOH POH LEONG','Nil','NIL',6,'704#04-05','704#04-05',0,0,0,0,11,0,NULL,'RAZAK','AIRCON SER','2013-07-12 10:12:05','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7013997I','TAN POH SOON ','Nil','NIL',6,'698#01-04','698#01-04',0,0,0,0,12,0,NULL,'RAZAK','AIRCON SER','2013-07-12 10:24:03','2013-07-12 11:03:55','~/Content/images/default_person.jpg',10),('S1315770G','Thien Ee Ho','Nil','S\'pore Driving Lic',6,'B706 #02 04','B706 #02 04',0,0,2,0,10,0,NULL,'','Plumber','2013-07-12 10:28:57','2013-07-12 11:13:49','~/Content/images/default_person.jpg',10),('G7793617W260412280414KVW','Woo Sai Cheong','Nil','Gain City Best-Electrical Pte.Ltd',6,'B702 #02 02','B702 #02 02',0,0,2,0,8,0,NULL,'','','2013-07-12 11:03:28','2013-07-12 14:42:55','~/Content/images/default_person.jpg',10),('S6866144G','Chen JinChun','Blk 556, Woodlands Drive 53 #04-45 S 730556','Self Employed',0,'B708 #02-11','B708 #02-11',0,0,2,0,10,0,NULL,'Jahari','Carpentry work','2013-07-12 11:58:55','2013-07-12 17:02:13','~/Content/images/default_person.jpg',10),('001300424F','Chew Chuan Thiam','Nil','NIL',6,'Nil','Management',0,0,0,0,11,0,NULL,'RAZAK','','2013-07-12 14:02:34','2013-07-12 14:38:05','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,8,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-12 15:53:03','2013-07-15 09:00:15','~/Content/images/default_person.jpg',10),('S1824175G','Chung Chee wai','Driving License','Self Employed',0,'B698 #01-05','B698 #01-05',0,0,2,0,8,0,NULL,'','Plumber','2013-07-12 16:24:10','2013-07-24 10:11:05','~/Content/images/default_person.jpg',10),('S1739628E','Chung Chee Meow','Driving License','Self Employed',6,'B698 #01-05','B698 #01-05',0,0,2,0,8,0,NULL,'Jahari','Plumber','2013-07-12 16:25:23','2013-07-12 17:48:59','~/Content/images/default_person.jpg',10),('S1377267C','ong joo Ann','blk 57 circuit Rd #01-125 spore- 370057','NIL',6,'702#10-02','702#10-02',0,0,0,0,15,0,NULL,'RAZAK','House kepping','2013-07-13 08:06:20','2013-07-13 11:05:42','~/Content/images/default_person.jpg',10),('S1282344D','NG SWEE CHOO','Nil','NIL',6,'698 #OI-O8','698#0108',0,0,0,0,7,0,NULL,'RAZAK','PLUMBER WORK','2013-07-13 08:55:42','2013-07-13 16:10:01','~/Content/images/default_person.jpg',10),('S1301725E','CHUA SENG LONG','Nil','NIL',6,'698#04-07','698#04-07',0,0,0,0,9,0,NULL,'RAZAK','AIRCON SER','2013-07-13 09:09:49','2013-07-13 09:43:57','~/Content/images/default_person.jpg',10),('G8116812T270313080115KVW','WAY LIN NAUNG','Nil','AKTIFF TG ENTERPRISA',6,'702#08-04','70208-04',0,0,0,0,10,0,NULL,'RAZAK','AIRCON SER','2013-07-13 09:43:20','2013-07-13 13:43:47','~/Content/images/default_person.jpg',10),('S7587485E','NG JUNG HUI','Nil','AKTIFF TG ENTERPRISE',6,'702#08-04','702#08-04',0,0,0,0,10,0,NULL,'RAZAK','AIRCON SER','2013-07-13 09:48:56','2013-07-13 13:43:55','~/Content/images/default_person.jpg',10),('G7717990P','HO JIN TIAN','DRIVING LICENCE','JL AIRCON',6,'702#10-05','702#10-05',0,0,0,0,11,0,NULL,'RAZAK','AIRCON SERVICING','2013-07-13 10:55:51','2013-07-13 12:34:25','~/Content/images/default_person.jpg',10),('G6869310T050413030415KVW','QU CHANG SHENG','Nil','RENTOKIL INITIAL PTE LTD',6,'708#01-04','708 #01-04',0,0,0,0,12,0,NULL,'RAZAK','PESTCONTRON','2013-07-13 11:01:56','2013-07-13 11:37:17','~/Content/images/default_person.jpg',10),('S1626018E','Chew Chuan Thiam','','Self Employed',6,'B698 #04-10','B698 #04-10',0,0,2,0,7,0,NULL,'','Air con service','2013-07-13 11:32:50','2013-07-17 11:52:53','~/Content/images/default_person.jpg',10),('S1534178E','Loo Yew Fatt','Nil','Self Employed',6,'B698 #04-10','B698 #04-10',0,0,2,0,7,0,NULL,'','Air con service','2013-07-13 11:33:58','2013-07-13 13:21:18','~/Content/images/default_person.jpg',10),('S8811431J','Norman Bin Atarawi','Blk 185, Boon Lay Ave, #03-154 S 640185','Pest Control',6,'B706 #04 01','B706 #04 01',0,0,2,0,9,0,NULL,'','Pest control','2013-07-13 11:48:31','2013-07-13 12:36:39','~/Content/images/default_person.jpg',10),('G2201204K110513100515KVW','Loo Chun Yep','Nil','Water Seepage S Pte.Ltd',6,'B698 #01-08','B698 #01-08',0,0,2,0,12,0,NULL,'Jahari','Check water seepage','2013-07-13 12:00:49','2013-07-13 13:29:13','~/Content/images/default_person.jpg',10),('S0093414C','Goh Seow Kwang','Driving License','Water Seepage S Pte.Ltd',6,'B698 #01-08','B698 #01-08',0,0,2,0,12,0,NULL,'','Check Water Seepage','2013-07-13 12:02:21','2013-07-13 13:29:04','~/Content/images/default_person.jpg',10),('S7538709A','Chew Chuan Thiam','Nil','Self Employed',6,'B702 #04-04','B702 #04-04',0,0,2,0,12,0,NULL,'Jahari','Plumber','2013-07-13 13:21:04','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G2083544W120612110614KVW','Goh Zhang Fei','','Heavenly Engrg',6,'706#03-02','702#04-10',0,0,2,0,7,0,NULL,'Jahari','Aircon leaking','2013-07-13 14:09:15','2013-07-13 15:37:04','~/Content/images/default_person.jpg',10),('G2253711W230513270115KVW','chey ka kit','Nil','Heavenly Engrg',6,'702#04-10','702#04-10',0,0,0,0,7,0,NULL,'RAZAK','aircon leaking','2013-07-13 14:13:12','2013-07-13 14:13:46','~/Content/images/default_person.jpg',10),('000716812G','ong zu yao','DRIVING LICENCE','Gain City Best-Electrical Pte.Ltd',6,'708#04-01','708#04-01',0,0,0,0,9,0,NULL,'RAZAK','cotation','2013-07-13 15:01:46','2013-07-13 15:36:15','~/Content/images/default_person.jpg',10),('G2253711W230513270115KVW','chey ka kit','Nil','Heavenly Engrg',6,'702#04-10','702#04-10',0,0,0,0,7,0,NULL,'RAZAK','aircon leaking','2013-07-13 15:36:57','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7076994H','Ng Lai Kiang','','Kiang Aircon engrg',6,'B698 #02-09','B698 #02-09',0,0,2,0,7,0,NULL,'Jahari','Aircon servicing','2013-07-14 12:05:05','2013-07-20 10:15:26','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702 08- 09','702 08-09',0,0,0,0,8,0,NULL,'kamal','COLLECTING ITEM','2013-07-15 09:11:52','2013-07-15 11:59:43','~/Content/images/default_person.jpg',10),('S2768496C','Poh Ming fUI','NIL','nil',6,'708#04-08','708#04-08',0,0,0,0,9,0,NULL,'razak','aircon ser','2013-07-15 09:31:40','2013-07-15 10:56:34','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,7,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-15 09:54:25','2013-07-15 10:53:47','~/Content/images/default_person.jpg',10),('G0368238U180213SVP','thupphige tanuja','nil','nil',6,'702#02-02','702-0202',0,0,0,0,0,0,NULL,'','visit','2013-07-15 10:56:02','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S8470820H','Lim Zhi Yong','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,7,0,NULL,'Jahari','Carpentry work','2013-07-15 11:26:10','2013-07-15 11:50:46','~/Content/images/default_person.jpg',10),('G2268601T150513050515KVW','Wu Ming Huang','Nil','Hong Jia Design & Build Pte Ltd',6,'B706 #04-06','B706 #04-06',0,0,2,0,7,0,NULL,'Jahari','Carpentry work','2013-07-15 11:26:31','2013-07-15 11:50:56','~/Content/images/default_person.jpg',10),('G8236628N220212130314KVW','Qu QiuFeng','Nil','Hong Jia Renovation Const',6,'B708 #04-06','B708 #04-06',0,0,2,0,7,0,NULL,'','Carpentry work','2013-07-15 11:28:00','2013-07-15 11:51:05','~/Content/images/default_person.jpg',10),('S1188606Z','Tan Soon Teck','Nil','First Comm',6,'Clubhouse','Management',0,0,2,0,7,0,NULL,'Jahari','Collect coins from clubhouse coin phone','2013-07-15 12:32:06','2013-07-15 12:45:40','~/Content/images/default_person.jpg',10),('F7686823U','Lim Yong Wai','Nil','Driving License',6,'B698 #03-11','B698 #03-11',0,0,2,0,7,0,NULL,'','Plumber','2013-07-15 15:38:31','2013-07-15 16:51:32','~/Content/images/default_person.jpg',10),('G2252925R250413020215KVW','Wong Ching Heng','Nil','Superior Air Conditioner Services',6,'B702 #08-09','B702 #08-09',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-16 10:12:51','2013-07-16 17:20:25','~/Content/images/default_person.jpg',10),('S7176976C','Tang Kok Song','Nil','Superior Air Conditioner Services',6,'B702 #08-09','B702 #08-09',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-16 10:14:06','2013-07-16 17:20:43','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#02-02',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-16 10:14:58','2013-07-16 17:09:42','~/Content/images/default_person.jpg',10),('F8431965K','Pangaru Mookkan','','LPM Contracts',6,'B706 #03-04','B706 #03-04',0,0,2,0,9,0,NULL,'Jahari','Contractor','2013-07-16 10:31:36','2013-07-16 17:28:40','~/Content/images/default_person.jpg',10),('G7290256X020412310314KVW','Chin Yew Huat','Nil','Chuen Sing Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Parquet work','2013-07-16 11:03:30','2013-07-16 12:08:58','~/Content/images/default_person.jpg',10),('G7050583K030912220714KVW','Lee Lun Lung','Nil','Chuen Sing Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Parquet work','2013-07-16 11:04:48','2013-07-16 15:44:45','~/Content/images/default_person.jpg',10),('S7183396H','Lim Ye Kiat','Nil','Nil',6,'702#02-02','702#02-02',0,0,2,0,11,0,NULL,'Jahari','Measurement','2013-07-16 11:07:56','2013-07-16 11:32:00','~/Content/images/default_person.jpg',10),('F7147691W','Tan Bee Hong','Nil','Nil',0,'B702 #08-09','B702 #08-09',0,0,2,0,12,0,NULL,'Jahari','Delivery Air con','2013-07-16 11:09:11','2013-07-16 11:19:11','~/Content/images/default_person.jpg',10),('G8130313X221211050114KVW','Hussin Bin Ismail','Nil','Louis Sin Renovation Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,11,0,NULL,'Jahari','Contractor','2013-07-16 11:43:43','2013-07-16 16:57:54','~/Content/images/default_person.jpg',10),('G8462906K260313190315KVW','Shahin Ahmed Abu Bakkor','Nil','Fiber Reach Pte Ltd',6,'MDF','MDF',0,0,2,0,16,0,NULL,'','Check Internet line','2013-07-16 12:40:03','2013-07-16 12:49:29','~/Content/images/default_person.jpg',10),('G8399946U260313190315KVW','Muthuramalingam Naganathan','Nil','Fiber Reach',6,'MDF','MDF',0,0,2,0,13,0,NULL,'Jahari','MDF Room','2013-07-16 12:40:20','2013-07-16 12:49:46','~/Content/images/default_person.jpg',10),('G2117343L170812160814KVW','Lim Kuan Keat','Nil','Heavenly Engrg',6,'B700 #04-04','B700 #04-04',0,0,2,0,13,0,NULL,'Jahari','Air con servicing','2013-07-16 13:00:17','2013-07-16 13:45:26','~/Content/images/default_person.jpg',10),('G8114249T150912140914KVW','Pang Tian Ching','Nil','Heavenly Engrg',6,'B700 #04-04','B700 #04-04',0,0,2,0,10,0,NULL,'Jahari','Aircon Service','2013-07-16 13:00:55','2013-07-16 13:45:10','~/Content/images/default_person.jpg',10),('G7290256X020412310314KVW','Chin Yew Huat','Nil','Chuen Sing Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,12,0,NULL,'Jahari','Parquet work','2013-07-16 13:20:49','2013-07-16 15:45:00','~/Content/images/default_person.jpg',10),('G2277600U120613110614KVW','veeramani kalaimani','Nil','Louis Sin Renovation Contractor',6,'B708 #03-11','B708 #03-11',0,0,0,0,13,0,NULL,'Razak','collet rabbish','2013-07-16 14:24:11','2013-07-16 16:57:32','~/Content/images/default_person.jpg',10),('F7921999K031212151114KVW','dhanasekaaran vinayaka moorthy','Nil','Louis Sin Renovation Contractor',6,'B708 #03-11','B708 #03-11',0,0,0,0,13,0,NULL,'Razak','collet rabbish','2013-07-16 14:27:38','2013-07-16 16:57:46','~/Content/images/default_person.jpg',10),('S8524373Z','chen yill eric','Nil','victory engineering',6,'B702 #08-09','B702 #08-09',0,0,0,0,14,0,NULL,'Razak','COLLET AIRCON','2013-07-16 14:31:34','2013-07-16 15:09:54','~/Content/images/default_person.jpg',10),('G7712848X191112071114KVW','jia feng jun','Nil','victory engineering',6,'B702 #08-09','B702 #08-09',0,0,0,0,14,0,NULL,'Razak','COLLET AIRCON','2013-07-16 14:33:44','2013-07-16 15:08:54','~/Content/images/default_person.jpg',10),('S8007106Z','Koh Kei Wong','Nil','NIL',6,'706#01-03','706#01-03',0,0,0,0,12,0,NULL,'Razak','CHECKING AIRCON','2013-07-16 15:59:34','2013-07-16 16:07:48','~/Content/images/default_person.jpg',10),('S7322974Z','Lee Fei Loong Tony','Nil','Nil',6,'706#01-03','706#01-03',0,0,0,0,12,0,NULL,'Razak','CHECKING AIRCON','2013-07-16 16:02:23','2013-07-16 16:08:11','~/Content/images/default_person.jpg',10),('403080829100812','LEE ZHE HAU','NIL','SWEE TECK PLASTER DESIGN',6,'NIL','702#08-09',0,0,2,0,7,0,NULL,'S/O KAMAL','PLASTER','2013-07-17 09:20:34','2013-07-17 16:49:32','~/Content/images/default_person.jpg',10),('402675268010410','THIAM KEH KOK','NIL','SWEE TECK PLASTER DESIGN',6,'NIL','702#08-09',0,0,2,0,8,0,NULL,'S/O KAMAK','PLASTER','2013-07-17 09:22:44','2013-07-18 09:24:14','~/Content/images/default_person.jpg',10),('061852417190113','RONY SHAHID MIAH','NIL','HL (D&B) ENGINEERING PTE LTD',6,'NIL','B702 #08-09',0,0,2,0,9,0,NULL,'S/O KAMAL','CONTRACTOR','2013-07-17 09:24:37','2013-07-23 17:02:18','~/Content/images/default_person.jpg',10),('035534482250413','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','B702 #08-09',0,0,0,0,10,0,NULL,'Razak','CONTRACTOR','2013-07-17 09:34:01','2013-07-18 09:28:27','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,11,0,NULL,'Jahari','Renovation','2013-07-17 09:36:05','2013-07-17 12:06:14','~/Content/images/default_person.jpg',10),('F8431965K','Pangaru Mookkan','','LPM Contracts',6,'B706 #03-04','B706 #03-04',0,0,2,0,12,0,NULL,'Jahari','Contractor','2013-07-17 09:37:03','2013-07-17 18:51:35','~/Content/images/default_person.jpg',10),('G7419108N280313150415KVW','Ling Sing Hwang','Nil','Li Sin Renovation',6,'708#03-11','B708 #03-11',0,0,0,0,13,0,NULL,'Razak','Renovation','2013-07-17 09:41:16','2013-07-17 11:39:52','~/Content/images/default_person.jpg',10),('S8024769I','CHEONG MING TSUEN','Nil','Cheong towing services',6,'NIL','GBA49122M',0,0,0,0,24,0,NULL,'RazakTOWING SERVICING','TOWING SERVICING','2013-07-17 09:52:53','2013-07-17 10:02:03','~/Content/images/default_person.jpg',10),('S1403978C','tengku omar','Common Area','Pest Master',6,'Nil','',0,0,2,0,14,0,NULL,'Jahari','Gogging','2013-07-17 10:31:42','2013-07-17 11:25:09','~/Content/images/default_person.jpg',10),('G6615166U191112181113KVW','SR Sugon Shikder Md Yusuf Shikder','Nil','Lian Hong Renovation Contractor',6,'702#02-02','702#02-02',0,0,2,0,15,0,NULL,'Jahari','Delivery Partition','2013-07-17 10:46:52','2013-07-17 11:19:30','~/Content/images/default_person.jpg',10),('S8971248C','Sae Cheong Phanupong','Nil','Hua Chong Plumbing & Renovation',6,'B708 # 03-11','B708 # 03-11',0,0,2,0,16,0,NULL,'Jahari','Plumber','2013-07-17 10:51:46','2013-07-17 11:26:17','~/Content/images/default_person.jpg',10),('G8345081P200513010615KVW','Tan Zheng Zhi','Nil','Hua Chong Plumbing & Renovation',0,'B708 # 03-11','B708 # 03-11',0,0,2,0,16,0,NULL,'Jahari','Plumber','2013-07-17 10:53:18','2013-07-17 11:26:40','~/Content/images/default_person.jpg',10),('G8372403Q230612210614KVW','Koh Kai Jie','Nil','Hua Chong Plumbing & Renovation',6,'B708 #03-11','B708 #03-11',0,0,2,0,16,0,NULL,'Jahari','Plumber','2013-07-17 10:54:23','2013-07-17 11:26:08','~/Content/images/default_person.jpg',10),('F8341760U','Chew Meng Hock','Nil','LCT Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,17,0,NULL,'Jahari','Plumber','2013-07-17 10:55:31','2013-07-17 15:46:50','~/Content/images/default_person.jpg',10),('G6288264L181111181113KVW','Sivaraj Rammoorthy','Nil','Everrise Maintenance Pte Ltd',6,'Management','Management',0,0,2,0,14,0,NULL,'Jahari','Servicing at Pump Room','2013-07-17 11:28:30','2013-07-17 13:59:23','~/Content/images/default_person.jpg',10),('G8165700P021112021114KVW','Sathiah Ranjithkumar','Nil','Everrise Maintenance Pte Ltd',6,'Management','Management',0,0,2,0,14,0,NULL,'Jahari','Servicing at Pump Room','2013-07-17 11:29:41','2013-07-17 13:59:37','~/Content/images/default_person.jpg',10),('S1626018E','Suraya Ashiko Hussein','','Self Employed',6,'B706 # 03-03','B706 # 03-03',0,0,2,0,21,0,NULL,'Jahari','Housekeeping','2013-07-17 11:54:11','2013-07-17 15:24:16','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,11,0,NULL,'Jahari','Renovation','2013-07-17 12:06:28','2013-07-17 17:17:41','~/Content/images/default_person.jpg',10),('G5204374W250912111014KVW','Regunathan Tamilvanan','Nil','GC Chong Enterprise',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Electrical work','2013-07-17 13:03:45','2013-07-17 13:34:51','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,13,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-17 13:27:58','2013-07-17 14:02:11','~/Content/images/default_person.jpg',10),('F8473231K130613120615KVW','MD Tarmizi Bin Hassan','Swimming Pool','Auto Pool Pte Ltd',6,'Management','Management',0,0,2,0,13,0,NULL,'Jahari','Swimming pool cleaning','2013-07-17 13:32:14','2013-07-17 14:01:52','~/Content/images/default_person.jpg',10),('S1650340A','Fong Keen Wah','Nil','Fong Seng Air Con',6,'B698 # 04-01','B698 # 04-01',0,0,2,0,11,0,NULL,'Jahari','Air con checking','2013-07-17 13:36:17','2013-07-17 13:53:13','~/Content/images/default_person.jpg',10),('S2074128G','Chiu Siau Khing','Nil','Fong Seng Air Con',6,'B698 # 04-01','B698 # 04-01',0,0,2,0,11,0,NULL,'Jahari','Air con checking','2013-07-17 13:37:43','2013-07-17 13:52:54','~/Content/images/default_person.jpg',10),('S1282344D','NG SWEE CHOO','Nil','NIL',6,'698 #OI-O8','698#0108',0,0,0,0,7,0,NULL,'RAZAK','PLUMBER WORK','2013-07-17 13:50:19','2013-07-20 08:49:41','~/Content/images/default_person.jpg',10),('G8102145M170811140813KVW','Shang XuFeng','Nil','Gain City Best-Electric Pte Ltd',6,'B702 #03-03','B702 #03-03',0,0,2,0,7,0,NULL,'Jahari','Delivery','2013-07-17 17:05:58','2013-07-17 17:07:14','~/Content/images/default_person.jpg',10),('040614','Leow g s Derrick','Nil','Starhub',6,'702#08-02','702#08-02',0,0,0,0,7,0,NULL,'Razak','delivery','2013-07-17 17:43:12','2013-07-17 18:12:42','~/Content/images/default_person.jpg',10),('G7061598W','Khong Leng Sheng','Nil','Nil',6,'B702 #03-03','B702 #03-03',0,0,2,0,7,0,NULL,'Jahari','Met Owner-Measurement','2013-07-17 20:34:14','2013-07-17 20:47:00','~/Content/images/default_person.jpg',10),('03410218-130511','APPDURAI CHANDRASEKAR','Nil','HL (D&B) ENGINEERING PTE LTD',6,'NIL','B702 #08-09',0,0,0,0,8,0,NULL,'KAMAL','CONTRACTOR','2013-07-18 09:27:42','2013-07-22 16:59:14','~/Content/images/default_person.jpg',10),('530533026120407','LIM GU YEONG','Nil','PACIFIC PAINTING CONTRACTOR',6,'NIL','708 02-10',0,0,0,0,10,0,NULL,'KAMAL','TOUCH UP PAINTING','2013-07-18 09:34:27','2013-07-18 16:56:13','~/Content/images/default_person.jpg',10),('S1761774E','TAN KOON SENG','NL','NIL',6,'NIL','704 04-05',0,0,0,0,11,0,NULL,'S/O KAMAL','','2013-07-18 09:43:45','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('509262438251007','ADRIS BIN RAZAK','Nil','PACIFIC PANTING CONTRACTOR',6,'NIL','708 02-10',0,0,0,0,13,0,NULL,'KAMAL','TOUCH UP PAINTING','2013-07-18 09:53:07','2013-07-18 16:55:59','~/Content/images/default_person.jpg',10),('S0106288C','Chua Khee Eng','','NEA',6,'Inspection','702',0,0,2,0,14,0,NULL,'Jahari','Inspection common area','2013-07-18 09:55:01','2013-07-18 11:40:45','~/Content/images/default_person.jpg',10),('S0011435I','Arunasalam Balakrishnan','Nil','NEA',6,'Inspection','702',0,0,2,0,15,0,NULL,'Jahari','Inspection common area','2013-07-18 09:56:09','2013-07-18 11:41:22','~/Content/images/default_person.jpg',10),('S7717157F','WONG KEEN PING','Nil','NEA',6,'NIL','702',0,0,0,0,16,0,NULL,'KAMAL','INSPECTION COMON AREA','2013-07-18 09:59:33','2013-07-18 11:41:01','~/Content/images/default_person.jpg',10),('F8341760U','Chew Meng Hock','Nil','LCT Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,17,0,NULL,'Jahari','Plumber','2013-07-18 10:00:54','2013-07-18 16:37:18','~/Content/images/default_person.jpg',10),('F8431965K010713090615KVW','Pangaru Mookkan','Nil','LPM Contracts',6,'B706 #03-04','706#03-04',0,0,0,0,18,0,NULL,'','RENOVATION','2013-07-18 10:28:57','2013-07-18 12:57:31','~/Content/images/default_person.jpg',10),('S2630546B','LEM SHYH SHILIN','Nil','Nil',6,'708#02-10','708 02-10',0,0,0,0,19,0,NULL,'Razak','PAINTING','2013-07-18 10:33:24','2013-07-18 11:26:43','~/Content/images/default_person.jpg',10),('G8372403Q230612210614KVW','Koh Kai Jie','Nil','Hua Chong Plumbing & Renovation',6,'B708 #03-11','B708 #03-11',0,0,2,0,11,0,NULL,'Jahari','Plumber','2013-07-18 10:34:31','2013-07-18 12:08:48','~/Content/images/default_person.jpg',10),('G8345081P200513010615KVW','Tan Zheng Zhi','Nil','Hua Chong Plumbing & Renovation',0,'B708 # 03-11','B708 # 03-11',0,0,2,0,11,0,NULL,'Jahari','Plumber','2013-07-18 10:35:13','2013-07-18 12:09:32','~/Content/images/default_person.jpg',10),('S8971248C','Sae Cheong Phanupong','Nil','Hua Chong Plumbing & Renovation',6,'B708 # 03-11','B708 # 03-11',0,0,2,0,11,0,NULL,'Jahari','Plumber','2013-07-18 10:35:39','2013-07-18 12:08:03','~/Content/images/default_person.jpg',10),('G2286285K260613040615KVW','Zhaq Pengping','Nil','HOME SHAPE CONSTRUCTION',6,'708#03-11','B708 #03-11',0,0,0,0,12,0,NULL,'Razak','RENOVATION','2013-07-18 10:46:26','2013-07-18 17:34:51','~/Content/images/default_person.jpg',10),('G5253682R150212150214KVW','Li Bengqing','Nil','TOP HUI DESINGN',6,'708#03-11','B708 #03-11',0,0,0,0,12,0,NULL,'Razak','RENOVATION','2013-07-18 10:49:34','2013-07-18 17:34:58','~/Content/images/default_person.jpg',10),('G6893105W130313270315KVW','Poon chee Hoe','Nil','JH PLUMBING',6,'708#03-07','708-03-07',0,0,0,0,20,0,NULL,'Razak','PLUMBING','2013-07-18 11:06:42','2013-07-18 15:45:21','~/Content/images/default_person.jpg',10),('G2246910Q110413100415KVW','Lim Fook WEI','','JH PLUMBING',6,'708#03-07','708-03-07',0,0,0,0,20,0,NULL,'Razak','PLUMBING','2013-07-18 11:09:36','2013-07-18 15:45:37','~/Content/images/default_person.jpg',10),('S7703119G','Chin Kin SIN','Nil','U N I Pest',6,'Management','M G T',0,0,0,0,21,0,NULL,'Razak','Pest Management','2013-07-18 11:21:02','2013-07-18 11:49:38','~/Content/images/default_person.jpg',10),('S1769113I','Chew Kor Wee','','Toll Express',6,'B704 #04-04','B704 #04-04',0,0,3,0,7,0,NULL,'Jahari','Delivery','2013-07-18 11:31:51','2013-07-18 11:42:52','~/Content/images/default_person.jpg',10),('402675268010410','THIAM KEH KOK','NIL','SWEE TECK PLASTER DESIGN',6,'NIL','702#08-09',0,0,2,0,8,0,NULL,'S/O KAMAK','PLASTER','2013-07-18 12:07:18','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1626018E','Suraya Ashiko Hussein','','Self Employed',6,'B706 # 03-03','B706 # 03-03',0,0,2,0,21,0,NULL,'Jahari','Housekeeping','2013-07-18 13:54:32','2013-07-18 15:24:21','~/Content/images/default_person.jpg',10),('S7764618C','Tan cHAI kZAT','Nil','Nil',6,'706#01-05','706-0105',0,0,0,0,7,0,NULL,'','reaip tv','2013-07-18 15:23:50','2013-07-18 15:46:58','~/Content/images/default_person.jpg',10),('S7238850Z','ong guan chuan','Nil','Nil',6,'702#04-02','702#04-02',0,0,0,0,11,0,NULL,'Razak','colletion','2013-07-18 15:34:59','2013-07-18 16:00:34','~/Content/images/default_person.jpg',10),('035534482250413','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','B702 #08-09',0,0,0,0,10,0,NULL,'Razak','CONTRACTOR','2013-07-18 17:11:23','2013-07-19 08:48:40','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,11,0,NULL,'Jahari','Renovation','2013-07-18 17:11:34','2013-07-19 08:47:53','~/Content/images/default_person.jpg',10),('S8609601C','chin zhong cHENG','Nil','Nil',6,'708#04-03','708#04-03',0,0,0,0,7,0,NULL,'Razak','VISIT OWNER','2013-07-18 17:57:32','2013-07-18 18:28:34','~/Content/images/default_person.jpg',10),('F8431965K010713090615KVW','Pangaru Mookkan','Nil','LPM Contracts',6,'B706 #03-04','706#03-04',0,0,0,0,18,0,NULL,'','RENOVATION','2013-07-19 08:49:30','2013-07-19 15:07:48','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,11,0,NULL,'Jahari','Renovation','2013-07-19 08:50:44','2013-07-19 17:18:05','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'Razak','RENOVATION','2013-07-19 08:53:12','2013-07-19 17:17:50','~/Content/images/default_person.jpg',10),('F7076094X051212251114KVW','MOHAMAD MAZN BIN MOHAMAD MJNID','Nil','PACIFIC PAINTING CONTRACTOR',6,'B708 #03-11','B708 #03-11',0,0,0,0,10,0,NULL,'Razak','PAINTING WORK','2013-07-19 09:10:30','2013-07-19 16:38:40','~/Content/images/default_person.jpg',10),('G7308225R170413230115KVW','LIM GU YEONG','NIL','PACIFIC PANTING CONTRACTOR',6,'B708 #03-11','B708 #03-11',0,0,0,0,11,0,NULL,'Razak','PAINTING','2013-07-19 09:15:25','2013-07-19 16:39:08','~/Content/images/default_person.jpg',10),('F7131055T191011041113KVW','ADRIS BIN RAZAK','Nil','PACIFIC PAINTING CONTRACTOR',6,'708#02-10','708 02-10',0,0,0,0,13,0,NULL,'Razak','PAINTING','2013-07-19 09:18:36','2013-07-19 16:38:57','~/Content/images/default_person.jpg',10),('S7322974Z','Lee Fei Loong Tony','Nil','Nil',6,'706#01-03','706#01-03',0,0,0,0,12,0,NULL,'Razak','CHECKING AIRCON','2013-07-19 09:28:06','2013-07-19 13:07:21','~/Content/images/default_person.jpg',10),('S8007106Z','Koh Kei Wong','Nil','NIL',6,'706#01-03','706#01-03',0,0,0,0,12,0,NULL,'Razak','CHECKING AIRCON','2013-07-19 09:28:40','2013-07-19 13:07:35','~/Content/images/default_person.jpg',10),('G7130525U200513170414KVW','SU XIiaqli ','Nil','Seah Kim Check',6,'B706 #03-04','B706 #03-04',0,0,0,0,14,0,NULL,'Razak','RENOVATION','2013-07-19 09:46:37','2013-07-19 15:08:46','~/Content/images/default_person.jpg',10),('F8341760U','Chew Meng Hock','Nil','LCT Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,16,0,NULL,'Jahari','Plumber','2013-07-19 09:47:32','2013-07-19 14:55:38','~/Content/images/default_person.jpg',10),('S0106288C','Chua Khee Eng','','NEA',6,'Inspection','702',0,0,2,0,14,0,NULL,'Jahari','Inspection common area','2013-07-19 09:48:03','2013-07-19 11:13:16','~/Content/images/default_person.jpg',10),('S0011435I','Arunasalam Balakrishnan','Nil','NEA',6,'Inspection','702',0,0,2,0,15,0,NULL,'Jahari','Inspection common area','2013-07-19 09:48:28','2013-07-19 11:13:28','~/Content/images/default_person.jpg',10),('S8015239F','Senthu Nathan S/O Jaiganathan','Nil','MOM',6,'702','702',0,0,0,0,14,0,NULL,'RazakPEST','MOM','2013-07-19 09:52:22','2013-07-19 11:13:07','~/Content/images/default_person.jpg',10),('S7786827E','Lee Yeou Ming','Nil','Louis Sin Renovation Contractor',6,'B708 #03-11','B708 #03-11',0,0,0,0,17,0,NULL,'Razak','RENOVATION','2013-07-19 10:27:52','2013-07-19 14:05:48','~/Content/images/default_person.jpg',10),('G6818328L','Lek Kok Soon','Nil','MAX',6,'702#09-06','702#09-06',0,0,0,0,24,0,NULL,'Razak','DELIVERY','2013-07-19 10:55:16','2013-07-19 11:04:57','~/Content/images/default_person.jpg',10),('G5253682R150212150214KVW','Li Bengqing','Nil','TOP HUI DESINGN',6,'708#03-11','B708 #03-11',0,0,0,0,12,0,NULL,'Razak','RENOVATION','2013-07-19 11:15:43','2013-07-19 17:07:55','~/Content/images/default_person.jpg',10),('S1497821F','YeoTiong Kiong','Nil','Nil',6,'700#01-10','700#01-10',0,0,0,0,18,0,NULL,'Razak','AIRCON SER','2013-07-19 11:29:30','2013-07-19 12:07:08','~/Content/images/default_person.jpg',10),('G6933011N080713300815KVW','lIM Teong Had ','Nil','gain city best electriic Pte Ltd',6,'702#03-08','702#03-08',0,0,0,0,17,0,NULL,'Razak','aircon ser','2013-07-19 14:40:26','2013-07-19 14:52:17','~/Content/images/default_person.jpg',10),('G7678610R260213120315KVW','CHAng ZE GUI','Nil','Gain City Best-Electric Pte Ltd',6,'702#03-08','702#03-08',0,0,0,0,17,0,NULL,'Razak','aircon ser','2013-07-19 14:44:04','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S2074128G','Chiu Siau Khing','Nil','Fong Seng Air Con',6,'B698 # 04-01','B698 # 04-01',0,0,2,0,11,0,NULL,'Jahari','Air con checking','2013-07-19 15:00:59','2013-07-19 15:33:31','~/Content/images/default_person.jpg',10),('S1650340A','Fong Keen Wah','Nil','Fong Seng Air Con',6,'B698 # 04-01','B698 # 04-01',0,0,2,0,11,0,NULL,'Jahari','Air con checking','2013-07-19 15:01:25','2013-07-19 15:33:48','~/Content/images/default_person.jpg',10),('G5435441Q070613070615KVW','sivasamy palanrajan','Nil','NIL',6,'700#02-03','700#02-03',0,0,0,0,7,0,NULL,'RAZAK','Aircon Ser','2013-07-19 18:06:13','2013-07-19 19:09:17','~/Content/images/default_person.jpg',10),('G8131947U','Marimuthu Sivaji','NIL','dyna cool air pte lltd',6,'700#02-03','702#02-03',0,0,0,0,7,0,NULL,'Razak','aircon ser','2013-07-19 18:11:14','2013-07-19 19:10:09','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-20 08:39:44','2013-07-20 13:15:38','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'Razak','RENOVATION','2013-07-20 08:40:13','2013-07-20 13:15:30','~/Content/images/default_person.jpg',10),('G7067774T130213290115KVW','RONY SHAHID MIAH','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,9,0,NULL,'','','2013-07-20 08:43:36','2013-07-20 13:15:19','~/Content/images/default_person.jpg',10),('G7130525U200513170414KVW','SU XIiaqli ','Nil','Seah Kim Check',6,'B706 #03-04','B706 #03-04',0,0,0,0,10,0,NULL,'Razak','RENOVATION','2013-07-20 09:03:23','2013-07-20 17:06:01','~/Content/images/default_person.jpg',10),('G6785587L','Chee Kar Heng','Nil','Nil',6,'700#03-01','700#03-01',0,0,0,0,12,0,NULL,'Razak','aircon ser','2013-07-20 09:18:58','2013-07-20 10:30:20','~/Content/images/default_person.jpg',10),('S1282344D','NG SWEE CHOO','Nil','NIL',6,'698 #OI-O8','698#0108',0,0,0,0,7,0,NULL,'RAZAK','PLUMBER WORK','2013-07-20 09:22:31','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1812955H','Ngan WAI SHOON','Nil','Nil',6,'700#0301','700#0301',0,0,0,0,13,0,NULL,'Razak','contractor','2013-07-20 10:06:53','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7966208I','TAN Weng Siang','Nil','Nil',6,'698#02#09','698#02-09',0,0,0,0,15,0,NULL,'Razak','Contrator','2013-07-20 10:17:54','2013-07-20 12:49:10','~/Content/images/default_person.jpg',10),('G8432280L130912120913KVW','Hossain MD Akul','Nil','Nil',6,'698#02-09','698#02-09',0,0,0,0,16,0,NULL,'Razak','DELIVER AIRCON','2013-07-20 10:20:57','2013-07-20 10:28:34','~/Content/images/default_person.jpg',10),('G6459492W210512290614KVW','Alagaraj Ponnugopi','Nil','Perfect Cool Air Cond Services',6,'B702 #04 08','B702 #04 08',0,0,2,0,10,0,NULL,'','Air con servicing','2013-07-20 12:48:33','2013-07-20 13:31:35','~/Content/images/default_person.jpg',10),('S7076994H','Ng Lai Kiang','','Kiang Aircon engrg',6,'B698 #02-09','B698 #02-09',0,0,2,0,7,0,NULL,'Jahari','Aircon servicing','2013-07-20 12:48:53','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8287234K','Ho Soon Heng','Nil','Perfect Cool Air Cond Services',6,'B702 #04 08','B702 #04 08',0,0,2,0,10,0,NULL,'Jahari','Air Con servicing','2013-07-20 12:50:20','2013-07-20 13:31:51','~/Content/images/default_person.jpg',10),('S1589792I','Lee Guan Thye','Nil','Soon Chong A/Con',6,'B708 #02 02','B708 #02 02',0,0,2,0,7,0,NULL,'Razak','Air con leaking','2013-07-20 14:19:03','2013-07-20 15:19:35','~/Content/images/default_person.jpg',10),('S8927168A','Ong Zhi Wei','Nil','Elite Mover',6,'B698 #02 06','B698 #02 06',0,0,2,0,8,0,NULL,'Jahari','Move in','2013-07-20 14:34:22','2013-07-20 15:26:28','~/Content/images/default_person.jpg',10),('G6687192X160312200414KVW','Lai Jian Hui','Nil','THL air conditioning System Repairing',6,'B702 #08 05','B702 #08 05',0,0,0,0,7,0,NULL,'Jahari','Air con leaking','2013-07-20 15:39:31','2013-07-20 16:27:58','~/Content/images/default_person.jpg',10),('S1601986J','Seow Thuan Hwee','IDA','IDA',6,'B702 #10 05','B702 #10 05',0,0,4,0,9,0,NULL,'Jahari','Conduct Survey','2013-07-20 16:24:56','2013-07-20 17:10:16','~/Content/images/default_person.jpg',10),('S1385443B','Lau Swee Yam','Nil','Everrise Maintenance Pte Ltd',6,'706#03-04','B706 #03-04',0,0,0,0,7,0,NULL,'Razak','MEASUMENT','2013-07-21 09:35:30','2013-07-21 10:18:44','~/Content/images/default_person.jpg',10),('S1626018E','Suraya Ashiko Hussein','','Self Employed',6,'708#04-11','B708#04-11',0,0,2,0,8,0,NULL,'Jahari','Housekeeping','2013-07-21 10:10:08','2013-07-24 13:54:05','~/Content/images/default_person.jpg',10),('S7767791G','Yew Chee Choong','Nil','Nil',6,'B700 #01-07','B700 #01-07',0,0,2,0,9,0,NULL,'Jahari','Air con leaking','2013-07-21 10:24:41','2013-07-21 11:31:58','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-22 08:52:35','2013-07-22 17:32:24','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'Razak','RENOVATION','2013-07-22 08:53:19','2013-07-22 17:00:32','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,9,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-22 09:00:56','2013-07-22 10:47:50','~/Content/images/default_person.jpg',10),('G6919199T280711270713KVW','cheah chee leong','Nil','hs cool air con specialist pte ltd',6,'Nil','702 # 06-o9',0,0,0,0,10,0,NULL,'kamal','air con service','2013-07-22 09:56:35','2013-07-22 11:18:53','~/Content/images/default_person.jpg',10),('S8084935D','cheah chee chuan','Nil','hs cool air con specialist pte ltd',6,'NIL','702 # 06-o9',0,0,0,0,11,0,NULL,'KAMAL','air con service','2013-07-22 10:00:28','2013-07-22 11:18:44','~/Content/images/default_person.jpg',10),('S1188606Z','Tan Soon Teck','Nil','First Comm',6,'Clubhouse','Management',0,0,2,0,9,0,NULL,'Jahari','Collect coins from clubhouse coin phone','2013-07-22 12:23:03','2013-07-22 12:41:32','~/Content/images/default_person.jpg',10),('S7334609F','Tan Chye Kwee','Blk 643, A.M.Kio Ave 5 #023025 S560643','Faith\'s Cooling Service',6,'B702 #05 04','B702 #05 04',0,0,2,0,10,0,NULL,'','Air Con servicing','2013-07-22 13:19:58','2013-07-22 13:48:52','~/Content/images/default_person.jpg',10),('S9036357C','Albert Yeo Jun Wei','Singapore Driving Lic','Nil',6,'B702 #05 04','B702 #05 04',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-22 13:20:22','2013-07-22 13:48:35','~/Content/images/default_person.jpg',10),('S0449290J','Li Lam Cheong','Nil','Self Employ',6,'B702 #10-02','B702 #10-02',0,0,2,0,9,0,NULL,'Jahari','Check Main Door','2013-07-22 15:36:18','2013-07-22 16:57:51','~/Content/images/default_person.jpg',10),('S1545759G','Chia Pang Seong','Nil','Wave Aircon',6,'B702 #04-05','',0,0,2,0,10,0,NULL,'Jahari','Air con Servicing','2013-07-22 15:49:37','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G5927476M201212201214KVW','Vaithiyanathan Rajamohan','Nil','Silver Star A/con Engrg',6,'B698 #02-03','GT 7252 E',0,0,2,0,11,0,NULL,'Jahari','Air con servicing','2013-07-22 16:06:38','2013-07-22 17:23:40','~/Content/images/default_person.jpg',10),('S7901877E','Phua Hong Hwee','Nil','Silver Star A/con Engrg',6,'B698 #02-03','B698 #02-03',0,0,2,0,11,0,NULL,'','Air con service','2013-07-22 16:07:50','2013-07-22 17:24:28','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-23 08:43:23','2013-07-23 17:01:38','~/Content/images/default_person.jpg',10),('G7067774T130213290115KVW','RONY SHAHID MIAH','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'','','2013-07-23 08:43:53','2013-07-24 08:51:04','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,9,0,NULL,'Razak','RENOVATION','2013-07-23 08:44:21','2013-07-23 17:02:29','~/Content/images/default_person.jpg',10),('F8431965K010713090615KVW','Pangaru Mookkan','Nil','LPM Contracts',6,'B706 #03-04','706#03-04',0,0,0,0,10,0,NULL,'rAZAK','RENOVATION','2013-07-23 09:05:55','2013-07-23 15:23:49','~/Content/images/default_person.jpg',10),('F7968823K291112121013KVW','kASINA tHAN bALASUBRAMANIYAN','NIL','LPM CONSTRUCTION',6,'706#03-04','706#03-04',0,0,0,0,11,0,NULL,'RAZAK','CONTRUCTION','2013-07-23 09:10:26','2013-07-23 15:23:31','~/Content/images/default_person.jpg',10),('G6760393T070912050914KVW','Liton Miah Mohamed Chunnu','','Chen Wa Landscape Pte Ltd',6,'Nil','',0,0,2,0,12,0,NULL,'Jahari','Landscaping','2013-07-23 09:11:02','2013-07-23 16:51:39','~/Content/images/default_person.jpg',10),('G6723244K040812211113KVW','Md Jakir Hossain ','','Chen Wa Landscape Pte Ltd',6,'Nil','',0,0,2,0,12,0,NULL,'RAZAK','Landscaping','2013-07-23 09:11:42','2013-07-23 16:51:50','~/Content/images/default_person.jpg',10),('G6112310K291012131014KVW','Sai Tun Yi','NIL','LANDSCAPE',6,'COMMAN AREA','COMMAN AREA',0,0,0,0,12,0,NULL,'RAZAK','LANDSCAPE','2013-07-23 09:14:37','2013-07-23 16:52:01','~/Content/images/default_person.jpg',10),('063216186100709','MD Rohul Amin Mir Kashem','NIL','LPM CONSTRUCTION',6,'COMMAN AREA','COMMAN AREA',0,0,0,0,12,0,NULL,'RAZAK','LANDSCAPE','2013-07-23 09:18:30','2013-07-23 16:52:35','~/Content/images/default_person.jpg',10),('S1135907H','TAN CHAI SENG','NIL','LPM CONSTRUCTION',6,'706#03-04','706#03-04',0,0,0,0,13,0,NULL,'RAZAK','CONSTRUCTION','2013-07-23 09:49:44','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7271090H','LAI TEIK MOW WONG','NIL','NIL',6,'708#04-02','708#04-02',0,0,0,0,14,0,NULL,'RAZAK','AIRCON SER','2013-07-23 09:55:14','2013-07-23 11:25:44','~/Content/images/default_person.jpg',10),('S2619105Z','LAI TEIK CHUAN','NIL','NIL',6,'708#04-02','708#04-02',0,0,0,0,14,0,NULL,'RAZAK','AIRCON SER','2013-07-23 09:57:16','2013-07-23 11:25:26','~/Content/images/default_person.jpg',10),('S8840113A','MOHAMMAD SYAFUAN BIN SULAIMAN','NIL','COURT',6,'704#01-02','704#01-02',0,0,0,0,15,0,NULL,'RAZAK','DELIVERY ','2013-07-23 10:02:36','2013-07-23 10:34:01','~/Content/images/default_person.jpg',10),('G5204374W250912111014KVW','Regunathan Tamilvanan','Nil','GC Chong Enterprise',6,'B708 #03-11','B708 #03-11',0,0,2,0,16,0,NULL,'Jahari','Electrical work','2013-07-23 10:22:52','2013-07-23 16:12:07','~/Content/images/default_person.jpg',10),('G8314167R151212071213KVW','Mahboob Baschu mENBER','NIL','Bellus Group',6,'708-03-11','708-#03-11',0,0,0,0,18,0,NULL,'RAZAK','CONTRUCTOR','2013-07-23 10:38:36','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S8501577Z','HO Zi Ping','NIL','Bellus Group',6,'708-03-11','708-#03-11',0,0,0,0,18,0,NULL,'RAZAK','COTRATOR','2013-07-23 10:40:41','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1166323J','Teo Kok HAN','NIL','Bellus Group',6,'708-03-11','708-#03-11',0,0,0,0,18,0,NULL,'RAZAK','CONTRATOR','2013-07-23 10:42:50','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1280937I','Teo Chee Kuan','Nil','Interview',6,'David Kee','David Kee',0,0,4,0,22,0,NULL,'','See David','2013-07-23 11:19:00','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1028364G','Raihanah Binte Haji Ali','Nil','Aiko Cleaning Service',6,'David Kee','David Kee',0,0,4,0,22,0,NULL,'','Interview work','2013-07-23 11:20:32','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8085839L250613250615KVW','XU XinGuo','','Seng Thong Disposal Srvice',6,'B702 #08-09','B702 #08-09',0,0,2,0,18,0,NULL,'Jahari','Collect Dumpster','2013-07-23 14:28:19','2013-07-23 14:39:31','~/Content/images/default_person.jpg',10),('S1243769B','Tok Teck Hong','Nil','Excelift',6,'B702 FL2','B702 FL2',0,0,2,0,10,0,NULL,'Jahari','Check Fireman Lift 2','2013-07-23 16:42:38','2013-07-23 18:12:19','~/Content/images/default_person.jpg',10),('G6005240P060313020314KVW','Aung Myo Zaw','Nil','Excelift',6,'B702 FL2','B702 FL2',0,0,2,0,11,0,NULL,'Jahari','Check Fireman Lift 2','2013-07-23 16:43:50','2013-07-23 18:12:03','~/Content/images/default_person.jpg',10),('G8381997P130812050814KVW','Sethu Prabakaran','Nil','Long Heng Air Con Design Pte Ltd',6,'B708 #02-11','B708 #02-11',0,0,2,0,19,0,NULL,'Jahari','Air con servicing','2013-07-23 17:05:00','2013-07-23 18:42:01','~/Content/images/default_person.jpg',10),('G8101536N240212140214KVW','Inderjit Singh','Nil','Long Heng Air Con Design Pte Ltd',6,'B708 #03-11','B708 #03-11',0,0,2,0,24,0,NULL,'Jahari','Air con service','2013-07-23 17:06:32','2013-07-23 18:42:17','~/Content/images/default_person.jpg',10),('G7699134R030512020514KVW','Razdie Bin Hadi','Nil','Long Heng Air Con Design Pte Ltd',6,'B708 #03-11','B708 #03-11',0,0,2,0,24,0,NULL,'Jahari','Air con service','2013-07-23 17:07:55','2013-07-23 18:42:32','~/Content/images/default_person.jpg',10),('S1331455A','Chia Loi Puang David','Nil','StarHub',6,'B702 #08-02','B702 #08-02',0,0,2,0,7,0,NULL,'Jahari','Check Internet Line','2013-07-23 19:56:45','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-24 08:48:58','2013-07-24 10:29:28','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,9,0,NULL,'Razak','RENOVATION','2013-07-24 08:50:10','2013-07-24 10:29:13','~/Content/images/default_person.jpg',10),('G7067774T130213290115KVW','RONY SHAHID MIAH','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'','','2013-07-24 08:51:05','2013-07-24 10:28:45','~/Content/images/default_person.jpg',10),('G6518257U251012201013KVW','wang xia obing','NIL','pan master craft construction pte ltd',6,'nil','B702 #08-09',0,0,0,0,10,0,NULL,'kamal','contractor','2013-07-24 09:15:04','2013-07-24 17:05:53','~/Content/images/default_person.jpg',10),('G7736348W280513210515KVW','Zheng qinliang','NIL','pan master craft construction pte ltd',6,'B702 #08-09','B702 #08-09',0,0,0,0,11,0,NULL,'RAZAK','renovation','2013-07-24 09:21:07','2013-07-24 17:05:41','~/Content/images/default_person.jpg',10),('S1403978C','tengku omar','Common Area','Pest Master',6,'Nil','',0,0,2,0,14,0,NULL,'Jahari','Gogging','2013-07-24 09:29:22','2013-07-24 10:51:58','~/Content/images/default_person.jpg',10),('S1739628E','Chung Chee Meow','Driving License','Self Employed',6,'B698 #01-05','B698 #01-05',0,0,2,0,13,0,NULL,'RAZAK','Plumber','2013-07-24 10:09:28','2013-07-24 10:34:06','~/Content/images/default_person.jpg',10),('S1824175G','Chung Chee wai','Driving License','Self Employed',0,'B698 #01-05','B698 #01-05',0,0,2,0,8,0,NULL,'','Plumber','2013-07-24 10:34:17','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6211144K240811070913KVW','Min Thaw Linn','Nil','Excelift Pte Ltd',6,'B698 & B700','B698 & B700',0,0,2,0,7,0,NULL,'Jahari','Lift servicing at B698 & 700, Management informed','2013-07-24 10:47:58','2013-07-24 14:03:11','~/Content/images/default_person.jpg',10),('G7036272X250313150415KVW','Chong Song Heng','Nil','Gain City best electric Pte Ltd',6,'B702 #03-10','B702 #03-10',0,0,2,0,8,0,NULL,'Jahari','Air con servicing','2013-07-24 10:49:26','2013-07-24 11:32:39','~/Content/images/default_person.jpg',10),('G2230529N120313110315KVW','Chin Soon Hor','Nil','Gain City Best Electric Pte Ltd',6,'B702 #03-10','B702 #03-10',0,0,2,0,8,0,NULL,'Jahari','Air con sevicing','2013-07-24 10:50:56','2013-07-24 11:32:47','~/Content/images/default_person.jpg',10),('S7612683F','Abdul Talib Bin Mohamed Noor','Nil','Power Supply',6,'Common Area','Common Area',0,0,2,0,16,0,NULL,'Jahari','PUB take meter reading','2013-07-24 11:03:15','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('F4519195T040613190515KVW','Shahidul Islam late Dulal Mondal','Nil','Tommy Boyz Plumbing Services',6,'B708 #03-11','B708 #03-11',0,0,2,0,9,0,NULL,'Jahari','Install door','2013-07-24 11:15:36','2013-07-24 13:25:09','~/Content/images/default_person.jpg',10),('G6527529K140812130814KVW','Paritosh Kumer Das Nirod Baran Das','Nil','Menton Technologies P.L',6,'B708 #03-11','B708 #03-11',0,0,2,0,7,0,NULL,'','Checked Internet\r\nKeys nos 23','2013-07-24 11:30:06','2013-07-24 12:49:15','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,13,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-24 11:54:28','2013-07-24 12:22:50','~/Content/images/default_person.jpg',10),('S1385443B','Lau Swee Yam','Nil','Everrise Maintenance Pte Ltd',6,'706#03-04','B706 #03-04',0,0,0,0,7,0,NULL,'Razak','MEASUMENT','2013-07-24 12:51:20','2013-07-24 14:06:43','~/Content/images/default_person.jpg',10),('G7626892X020911020913KVW','Chai Hon Kiong','Nil','GMC Trading Services',6,'B700 #03-02','B700 #03-02',0,0,2,0,12,0,NULL,'','Delivery Refrigerator','2013-07-24 13:50:51','2013-07-24 14:24:42','~/Content/images/default_person.jpg',10),('S1626018E','Suraya Ashiko Hussein','','Self Employed',6,'708#04-11','B708#04-11',0,0,2,0,8,0,NULL,'Jahari','Housekeeping','2013-07-24 13:54:46','2013-07-24 15:29:05','~/Content/images/default_person.jpg',10),('S7563373D','Subbiah Subramanian','Nil','nil',6,'700#92-01','700#02-01',0,0,0,0,7,0,NULL,'Razak','open door','2013-07-24 14:16:50','2013-07-24 15:26:53','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,8,0,NULL,'Jahari','Renovation','2013-07-24 14:40:40','2013-07-24 17:27:58','~/Content/images/default_person.jpg',10),('G8372403Q230612210614KVW','Koh Kai Jie','Nil','Hua Chong Plumbing & Renovation',6,'B708 #03-11','B708 #03-11',0,0,2,0,14,0,NULL,'Jahari','Plumber','2013-07-24 15:06:53','2013-07-24 15:44:36','~/Content/images/default_person.jpg',10),('S8971248C','Sae Cheong Phanupong','Nil','Hua Chong Plumbing & Renovation',6,'B708 # 03-11','B708 # 03-11',0,0,2,0,14,0,NULL,'Jahari','Plumber','2013-07-24 15:07:29','2013-07-24 15:44:18','~/Content/images/default_person.jpg',10),('S1578826G','Tay Meng Poh','Nil','Chew Design',6,'702#10-02','702#10-02',0,0,0,0,9,0,NULL,'Razak','contrator','2013-07-24 15:11:09','2013-07-24 15:28:29','~/Content/images/default_person.jpg',10),('S1578814C','Liew Ching Pang','Nil','Chew Design',6,'702#10-02','702#10-02',0,0,0,0,9,0,NULL,'Razak','contractor','2013-07-24 15:13:19','2013-07-24 15:28:48','~/Content/images/default_person.jpg',10),('S7085007I','Ganapathy Arumugam','Blk 43, Bendemeer Road #08-1026 S 330043','Nil',0,'B708 #01-05','Ms.Uma',0,0,4,0,7,0,NULL,'Jahari','Survey','2013-07-24 16:12:39','2013-07-24 16:30:24','~/Content/images/default_person.jpg',10),('S1359785E','tan bee deen','704 # 02-06','locked smith',6,'nil','704# 02-06',0,0,0,0,26,0,NULL,'kamal','locksmith','2013-07-25 00:36:13','2013-07-25 00:40:55','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','APPADURAI CHANDRASEKAR','NIL','HL(D&B) ENGINEERING PTE LTD',6,'702#02-02','702#08-09',0,0,2,0,7,0,NULL,'Jahari','Renovation','2013-07-25 08:43:46','2013-07-25 17:00:07','~/Content/images/default_person.jpg',10),('G2022922K160513060514KVW','RAJENDRAN BALASUBRAMANIAN','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'Razak','RENOVATION','2013-07-25 08:44:54','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('F7087081U280113230115KVW','SIM CHIN GIAG','NIL','TCUSCS STONE FOCUS',6,'708 # 03-11','708# 03-11',0,0,0,0,9,0,NULL,'KAMAL','CONTRACTOR','2013-07-25 08:56:31','2013-07-25 18:10:32','~/Content/images/default_person.jpg',10),('G7736348W280513210515KVW','Zheng qinliang','NIL','pan master craft construction pte ltd',6,'B702 #08-09','B702 #08-09',0,0,0,0,10,0,NULL,'RAZAK','renovation','2013-07-25 08:58:32','2013-07-25 14:40:22','~/Content/images/default_person.jpg',10),('S7021819D','Tan Meng Hua','Nil','Nil',6,'702#04-09','702#04-09',0,0,0,0,7,0,NULL,'Razak','AIRCON SER','2013-07-25 09:57:22','2013-07-25 11:19:02','~/Content/images/default_person.jpg',10),('S2586524C','Hei See Heong','Nil','Self Employ',6,'B704 #03-04','B704 #03-04',0,0,2,0,11,0,NULL,'Jahari','Air con servicing','2013-07-25 10:16:42','2013-07-25 11:29:14','~/Content/images/default_person.jpg',10),('G6211144K240811070913KVW','Min Thaw Linn','Nil','Excelift Pte Ltd',6,'B702 & B704','B702 & B704',0,0,2,0,7,0,NULL,'Jahari','Lift servicing at B698 & 700, Management informed','2013-07-25 10:42:19','2013-07-25 14:05:30','~/Content/images/default_person.jpg',10),('S7303835I','Firdaus Bin Omar','Nil','Singtel',6,'B706 #04-08','B706 #04-08',0,0,2,0,14,0,NULL,'Jahari','Internet servicing','2013-07-25 10:58:13','2013-07-25 11:12:07','~/Content/images/default_person.jpg',10),('001546090A','Tay Geck Hock','Nil','NIL',6,'698#02-12','698#02-12',0,0,0,0,9,0,NULL,'RAZAK','washmecing','2013-07-25 11:27:31','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('F0276833W290811280813KVW','Tan Kim Seo','Nil','Racha Renovation Pte Ltd',6,'B708 #03-11','B708 #03-11',0,0,2,0,7,0,NULL,'','Contractor','2013-07-25 12:52:25','2013-07-25 14:53:55','~/Content/images/default_person.jpg',10),('F1199981Q','Loo Chee Meng','Nil','LSH Transport',6,'B702 #08-09','B702 #08-09',0,0,2,0,13,0,NULL,'Jahari','Delivery','2013-07-25 13:14:52','2013-07-25 13:22:48','~/Content/images/default_person.jpg',10),('S1626018E','Suraya Ashiko Hussein','','Self Employed',6,'708#04-11','B708#04-11',0,0,2,0,8,0,NULL,'Jahari','Housekeeping','2013-07-25 13:16:23','2013-07-25 14:20:21','~/Content/images/default_person.jpg',10),('S9074226D','Zheng Chengxiong','Nil','Nil',6,'708#03-11','708-03-11',0,0,0,0,7,0,NULL,'Razak','reaip bin chun','2013-07-25 15:03:42','2013-07-25 15:54:33','~/Content/images/default_person.jpg',10),('G7736348W280513210515KVW','Zheng qinliang','NIL','pan master craft construction pte ltd',6,'B702 #08-09','B702 #08-09',0,0,0,0,7,0,NULL,'RAZAK','renovation','2013-07-26 08:53:35','2013-07-26 17:27:39','~/Content/images/default_person.jpg',10),('G7067774T130213290115KVW','RONY SHAHID MIAH','Nil','HL (D&B) ENGINEERING PTE LTD',6,'B702 #08-09','702#08-09',0,0,0,0,8,0,NULL,'','','2013-07-26 08:57:33','2013-07-26 15:32:53','~/Content/images/default_person.jpg',10),('515751459290607','KU TIEN CHIUN','NIL','GK 38 MARBLE POLISHING SERVICE',6,'NIL','B708 #03-11',0,0,2,0,9,0,NULL,'S/O JOHARI','POLISHING','2013-07-26 09:24:35','2013-07-26 11:35:46','~/Content/images/default_person.jpg',10),('026023629220213','DANIEL HERNANDEZ','NIL','ACTIV COMMUNICATION',6,'NIL','708# 03-11',0,0,2,0,10,0,NULL,'S/O JOHARI','INSTALLATION, KEY : TAS RISER KEY','2013-07-26 09:28:36','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6702851T291012281014KVW','Tan Guan Sheng','Nil','Auto Pool P.L.',6,'Swimming Pool','Management',0,0,2,0,13,0,NULL,'Jahari','Swimming Pool Cleaning','2013-07-26 11:14:32','2013-07-26 11:29:15','~/Content/images/default_person.jpg',10),('G6211144K240811070913KVW','Min Thaw Linn','Nil','Excelift Pte Ltd',6,'B702 & B704','B702 & B704',0,0,2,0,7,0,NULL,'Jahari','Lift servicing at B698 & 700, Management informed','2013-07-26 11:14:51','2013-07-26 14:33:30','~/Content/images/default_person.jpg',10),('G8343867W030512080514KVW','Zhong  Gang','Nil','Home Shape Const. Pte Ltd',6,'B708 #03-11','B708 #03-11',0,0,2,0,12,0,NULL,'Jahari','Carpenter','2013-07-26 11:19:52','2013-07-26 12:10:03','~/Content/images/default_person.jpg',10),('G5218023L100712100714KVW','Kunjalu Ganapathy','Nil','Home Shape Const. Pte Ltd',6,'B708 #03-11','B708 #03-11',0,0,2,0,12,0,NULL,'Jahari','Carpenter','2013-07-26 11:20:58','2013-07-26 12:09:50','~/Content/images/default_person.jpg',10),('G2280476L260613250614KVW','Islam Shariful','Nil','De Yi Renovation & Trading',6,'B708 #03-11','B708 #03-11',0,0,2,0,13,0,NULL,'Jahari','Cleaning','2013-07-26 11:22:11','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7512933K110413070415KVW','Chen Kum Wing','Nil','Lixing Air con Engrg',6,'B700 #02-03','B700 #02-03',0,0,2,0,14,0,NULL,'Jahari','Air con servicing','2013-07-26 11:50:15','2013-07-26 13:48:24','~/Content/images/default_person.jpg',10),('S6861650F','Tan Teck An','Nil','IFC Air cond Engrg',6,'B700 #03-12','B700 #03-12',0,0,2,0,10,0,NULL,'','Aircon servicing','2013-07-26 15:11:11','2013-07-26 15:54:20','~/Content/images/default_person.jpg',10),('F7750134R210613200615KVW','Ang Hwa Poh','Nil','IFC Air cond Engrg',6,'B700 #03-12','B700 #03-12',0,0,2,0,10,0,NULL,'Jahari','Air con servicing','2013-07-26 15:12:16','2013-07-26 15:54:50','~/Content/images/default_person.jpg',10),('S1205963I','yap','','sma',8,'99','alsogaff',0,0,2,0,47,0,NULL,'','','2013-07-26 15:51:40','2013-07-26 15:52:16','~/Content/images/default_person.jpg',9),('S1205963I','yap','','sma',8,'99','alsogaff',0,0,2,0,48,0,NULL,'','','2013-07-26 15:53:41','0001-01-01 00:00:00','~/Content/images/default_person.jpg',9),('G7613559U300812290814KVW','Khoo Haun Boon','Nil','Ti Ti Kang Plumbing',6,'B698 #03-06','B698 #03-06',0,0,2,0,8,0,NULL,'','Plumber','2013-07-26 17:18:01','2013-07-26 17:31:57','~/Content/images/default_person.jpg',10),('G6073083R040512240314KVW','Zhang ShouQiang','Nil','A\'Santacool Aircon Biz',6,'B698 #02-03','B698 #02-03',0,0,2,0,9,0,NULL,'','Air con leaking','2013-07-26 17:23:15','2013-07-26 18:09:54','~/Content/images/default_person.jpg',10),('S0915554F','Tan Tai Eng','Nil','A\'Santacool Aircon Biz',6,'B698 #02-03','B698 #02-03',0,0,2,0,9,0,NULL,'Jahari','Air can leaking','2013-07-26 17:24:42','2013-07-26 18:10:24','~/Content/images/default_person.jpg',10),('G6078112K120912050914KVW','Yin FaZhen','Nil','a',6,'B698 #02-03','B698 #02-03',0,0,2,0,9,0,NULL,'Jahari','Air con leaking','2013-07-26 17:25:52','2013-07-26 17:28:06','~/Content/images/default_person.jpg',10),('G6078112K120912050914KVW','Yin FaZhen','Nil','A\'Santacool Aircon Biz',6,'B698 #02-03','B698 #02-03',0,0,2,0,9,0,NULL,'Jahari','Air con leaking','2013-07-26 17:28:42','2013-07-26 18:10:41','~/Content/images/default_person.jpg',10),('F8431965K010713090615KVW','Pangaru Mookkan','Nil','LPM Contracts',6,'B706 #03-04','706#03-04',0,0,0,0,7,0,NULL,'rAZAK','RENOVATION','2013-07-27 09:01:37','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7736348W280513210515KVW','Zheng qinliang','NIL','pan master craft construction pte ltd',6,'B702 #08-09','B702 #08-09',0,0,0,0,8,0,NULL,'RAZAK','renovation','2013-07-27 09:10:15','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7380229L030212090214KVW','Hwang Kwong Huat','Nil','Qpr aircon Engineering',6,'702#05-05','702-0505',0,0,0,0,9,0,NULL,'Razak','AIRCON SER','2013-07-27 09:36:49','2013-07-27 10:02:32','~/Content/images/default_person.jpg',10),('G6837203N120313080415KVW','Hwang Huak tung','Nil','Qpr aircon Engineering',6,'702#05-05','702-0505',0,0,0,0,9,0,NULL,'Razak','AIRCON SER','2013-07-27 09:39:59','2013-07-27 10:02:49','~/Content/images/default_person.jpg',10),('F8341760U','Chew Meng Hock','Nil','LCT Contractor',6,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Plumber','2013-07-27 09:52:58','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G6836710M250113240215KVW','He YOUG','Nil','B D E TECHNOLOGY',6,'710','710',0,0,0,0,11,0,NULL,'Razak','TV CHANNEL','2013-07-27 10:06:38','2013-07-27 10:44:45','~/Content/images/default_person.jpg',10),('G6589439X040213030215KVW','Lee KWONG Wei','Nil','B D E TECHNOLOGY',6,'710 ','710',0,0,0,0,11,0,NULL,'Razak','TV CHANNEL','2013-07-27 10:09:58','2013-07-27 10:48:46','~/Content/images/default_person.jpg',10),('G8249389T240811050813KVW','Esakki Samyrasu','Nil','LEMONCOOL AIRCON',6,'708#0306','B708 #03-06',0,0,0,0,13,0,NULL,'Razak','aircon ser','2013-07-27 10:19:04','2013-07-27 10:52:17','~/Content/images/default_person.jpg',10),('S1432051B','Wong Ming Geok','Nil','LEMONCOOL AIRCON',6,'708#0306','B708 #03-06',0,0,0,0,13,0,NULL,'Razak','aircon ser','2013-07-27 10:28:11','2013-07-27 10:52:43','~/Content/images/default_person.jpg',10),('S8936203B','Yeo Liang Ping','Nil','LEMONCOOL AIRCON',6,'708#0306','B708 #03-06',0,0,0,0,13,0,NULL,'Razak','aircon ser','2013-07-27 10:30:24','2013-07-27 10:52:29','~/Content/images/default_person.jpg',10),('G7849820Q110313180315KVW','Dayalan Kumar','Nil','Abtric System Pte Ltd',16,'B710 # 02-01','Management',0,0,2,0,11,0,NULL,'Jahari','Met management','2013-07-27 11:59:19','2013-07-27 13:54:49','~/Content/images/default_person.jpg',10),('S2570692G','Tey Kian Yew','Nil','TNC Electrical Service',11,'B702 #08-02','#08-02',0,0,2,0,9,0,NULL,'Jahari','Electrical- Change bulb','2013-07-27 13:35:42','2013-07-27 14:40:34','~/Content/images/default_person.jpg',10),('S0224003C','Biasanta Singh','Nil','K C DAT',15,'698#04-01','698#04-01',0,0,0,0,10,0,NULL,'Razak','COLLET ONE TV','2013-07-27 14:17:40','2013-07-27 14:25:10','~/Content/images/default_person.jpg',10),('S1512795C','Jahari','','SMA',0,'Nil','',0,0,4,0,22,0,NULL,'Jahari','','2013-07-27 15:16:47','2013-07-27 15:17:19','~/Content/images/default_person.jpg',10),('S1512795C','Jahari','','SMA',24,'Nil','Management',0,0,4,0,22,0,NULL,'Jahari','','2013-07-27 15:30:07','2013-07-27 15:31:49','~/Content/images/default_person.jpg',10),('G8024300L080612070614KVW','Goh Chee Song','Nil','Heavenly Engrg',22,'B706 #03-06','B706 #03-06',0,0,2,0,11,0,NULL,'Jahari','Aircon leaking','2013-07-27 15:54:11','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G2091157W170513160515KVW','Wong Chin Guang','Nil','Heavenly Engrg',22,'B706 #03-06','B706 #03-06',0,0,2,0,9,0,NULL,'Jahari','','2013-07-27 15:55:08','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8348999K150512140514KVW','Sin Kah Lin','Nil','gain city best electric',20,'702#05-03','702#05-03',0,0,0,0,7,0,NULL,'Razak','aircon leaking','2013-07-28 10:14:31','2013-07-28 10:58:03','~/Content/images/default_person.jpg',10),('G8179411T270412080414KVW','Muthu Ramachandran','Nil','Excelift',24,'Common Area','Management',0,0,2,0,14,0,NULL,'Jahari','Lift servicing','2013-07-29 10:09:56','2013-07-29 10:10:25','~/Content/images/default_person.jpg',10),('G202922K','Rajendran','','HL(DND) Eng Pte Ltd',20,'NIL','',0,0,2,0,7,0,NULL,'','','2013-07-29 10:20:29','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G2244568K150413310314KVW','Jamir ','Nil','Everrrise Maint Pte Ltd',24,'Nil','Management',0,0,2,0,12,0,NULL,'Jahari','Water Tank servicing','2013-07-29 10:22:57','2013-07-29 17:18:10','~/Content/images/default_person.jpg',10),('S1258135A','Wong Ban Tee','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'','Moving out','2013-07-29 10:25:33','2013-07-29 10:42:20','~/Content/images/default_person.jpg',10),('S1642352A','Khoo Say Siong','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'Jahari','Moving Out','2013-07-29 10:26:50','2013-07-29 10:42:07','~/Content/images/default_person.jpg',10),('S7414524H','Toh Kok Meng','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'Jahari','Moving Out','2013-07-29 10:52:11','2013-07-29 13:52:11','~/Content/images/default_person.jpg',10),('S1655848F','Tee Kok Leong','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'Jahari','','2013-07-29 10:53:22','2013-07-29 13:52:03','~/Content/images/default_person.jpg',10),('S8209377Z','Chan Kwong Fei','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'Jahari','','2013-07-29 10:54:27','2013-07-29 13:51:23','~/Content/images/default_person.jpg',10),('S7327151G','Mohamad Bahtiar Bin Ismon','Nil','Pest Control',20,'B702 #08-09','Owner',0,0,4,0,17,0,NULL,'Jahari','Met Owner','2013-07-29 11:39:44','2013-07-29 12:00:18','~/Content/images/default_person.jpg',10),('S1188606Z','Tan Soon Teck','Nil','First Comm.',24,'Clubhouse','',0,0,2,0,17,0,NULL,'Jahari','Collect coin phone coins','2013-07-29 12:15:21','2013-07-29 12:26:42','~/Content/images/default_person.jpg',10),('S1258135A','Wong Ban Tee','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'','Moving out','2013-07-29 13:51:36','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1642352A','Khoo Say Siong','Nil','The Helping Hand',23,'B708 #02-07','B708 #02-07',0,0,2,0,10,0,NULL,'Jahari','Moving Out','2013-07-29 13:51:53','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7234314Z','Leow G S Derrick','Nil','Starhub',20,'B702 #06-10','B702 #06-10',0,0,2,0,23,0,NULL,'Jahari','Check Internet','2013-07-29 15:20:17','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1464231E','Mohamed Ibrahim Bin Abdul Kadar','Nil','SP Power',18,'B698 #04-09','B698 #04-09',0,0,2,0,19,0,NULL,'Jahari','Check meter reading','2013-07-29 15:52:01','2013-07-29 17:07:25','~/Content/images/default_person.jpg',10),('40116328-290310','Chin Yew Huat','Nil','Chuen Sing contractor',23,'B708 #03-11','B708 #03-11',0,0,2,0,10,0,NULL,'Jahari','Touch up work','2013-07-29 15:54:31','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S8628875C','Mohamead Zainori Bin Daud','Nil','Stridek Logistic & Movers',23,'B708 #03-11','B708 #03-11',0,0,2,0,23,0,NULL,'Jahari','Moving In','2013-07-29 16:07:07','2013-07-29 17:44:24','~/Content/images/default_person.jpg',10),('S8223419E','Juraimi Bin Rajab','Nil','Stridek Logistic & Movers',23,'B708 #03-11','B708 #03-11',0,0,2,0,20,0,NULL,'Jahari','Moving In','2013-07-29 16:08:20','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S7703491I','Mohammad Payros Bin Awang','Nil','Stridek Logistic & Movers',23,'B708 #03-11','B708 #03-11',0,0,2,0,16,0,NULL,'','Moving out','2013-07-29 16:27:06','2013-07-29 17:44:49','~/Content/images/default_person.jpg',10),('057018909090511','Zheng Qinliang','NIL','PAN MASTER CRAFT CONSTRUCTION PTD LTD',0,'NIL','702#08-09',0,0,2,0,7,0,NULL,'S/O KAMAL','PAN MASTER CRAFT','2013-07-30 09:08:30','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('404229850030812','Lim Kuan Keat','Nil','Heavenly Engrg',22,'B706 #03-06','B706 #03-06',0,0,2,0,9,0,NULL,'Jahari','Aircon Servicing','2013-07-30 10:11:25','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S8607351Z','Muhammad Nazmi Bin Mahad','Nil','Heavenly Engrg',22,'B706 #03-06','B706 #03-06',0,0,2,0,9,0,NULL,'Jahari','Air con servicing','2013-07-30 10:12:52','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G8345081P200513010615KVW','Tan Zheng Zhi','Nil','Hua Chong Plumbing & Renovation',0,'B708 # 03-11','B708 # 03-11',0,0,2,0,11,0,NULL,'Jahari','Plumber','2013-07-30 10:43:19','2013-07-31 14:33:16','~/Content/images/default_person.jpg',10),('S1367593G','Collar Andrew','Nil','Logwin',23,'B708 #02-11','B708 #02-11',0,0,2,0,9,0,NULL,'Jahari','Delivery','2013-07-30 11:45:22','2013-07-30 11:51:44','~/Content/images/default_person.jpg',10),('G8381028P150313170215KVW','Rahman Rezaur','Nil','Menton Technologies Pte Ltd',20,'B702 #06-04','B702 #06-04',0,0,2,0,10,0,NULL,'Jahari','Open net','2013-07-30 11:47:34','2013-07-30 12:26:27','~/Content/images/default_person.jpg',10),('G8342728R290413240415KVW','Habibul Islam Abdul Rahaman','Nil','Menton Technologies Pte Ltd',20,'B702 #06-04','B702 #06-04',0,0,2,0,11,0,NULL,'Jahari','Open Net','2013-07-30 11:48:53','2013-07-30 12:26:38','~/Content/images/default_person.jpg',10),('S7327151G','Mohamad Bahtiar Bin Ismon','Nil','Pest Control',20,'B702 #08-09','Owner',0,0,4,0,10,0,NULL,'Jahari','Met Owner','2013-07-30 13:21:03','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S8335181J','Mojamad IswanBin Ibrahim','Nil','Pest Control',20,'B702 #08-09','B702 #08-09',0,0,2,0,8,0,NULL,'Jahari','Pest Control','2013-07-30 13:23:44','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1717403G','Lee Eng Hock','Nil','Nil',24,'B710 #02-01','Rizal',0,0,4,0,24,0,NULL,'Jahari','Management office','2013-07-30 16:15:56','2013-07-30 16:49:10','~/Content/images/default_person.jpg',10),('S7113727I','Alfan Bin Rani','NIL','Fire MECH PTE LTD',24,'Comman Area','Rizal',0,0,2,0,7,0,NULL,'Razak','FIRE ALAM SERVICING','2013-07-31 09:21:28','2013-07-31 13:41:17','~/Content/images/default_person.jpg',10),('G8144780U020413180214KVW','Mithun Md Golam Hossan','Nil','Fire MECH PTE LTD',24,'Comman Area','Management',0,0,2,0,8,0,NULL,'Razak','FIRE ALAM SERVICING','2013-07-31 09:25:34','2013-07-31 13:38:25','~/Content/images/default_person.jpg',10),('S1403978C','Tengku Omar Bin Tengku Abdul Aziz','Nil','Pest Control',24,'Nil','Management',0,0,2,0,9,0,NULL,'Razak','PEST CONTROL','2013-07-31 09:38:42','2013-07-31 10:18:53','~/Content/images/default_person.jpg',10),('S2030749H','Musa Bin Ahmad','NIL','Pest Control',24,'Nil','Management',0,0,2,0,10,0,NULL,'Razak','PEST CONTROL','2013-07-31 09:40:53','2013-07-31 10:19:12','~/Content/images/default_person.jpg',10),('G7164801Q230413190315KVW','Kallaperumal Dhavaman','Nil','Fiber Reach PTE LTD',24,'Nil','Management',0,0,2,0,11,0,NULL,'Razak','OPENNET','2013-07-31 09:56:23','2013-07-31 10:09:45','~/Content/images/default_person.jpg',10),('F7277641X160513150515KVW','NG LIAN SIE','Nil','Fiber Reach PTE LTD',24,'Nil','Management',0,0,0,0,12,0,NULL,'Razak','OPENNET','2013-07-31 09:59:48','2013-07-31 10:10:06','~/Content/images/default_person.jpg',10),('G8488393Q290512100514KVW','Tarek Late Ali Sha','Nil','Menton Technologies Pte Ltd',21,'B704 #01-04','B704 #01-04',0,0,2,0,9,0,NULL,'Jahari','Open Net','2013-07-31 12:01:18','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G2209874N080213070214KVW','Hasa Nazmul','Nil','Menton Technologies Pte Ltd',21,'B704 #01-04','B704 #01-04',0,0,2,0,9,0,NULL,'Jahari','Open Net','2013-07-31 12:02:17','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('G7209317N150612010714KVW','Tan Swee Yong','Swimming Pool','Auto Pool Pte Ltd',23,'Management','',0,0,2,0,10,0,NULL,'Jahari','Swimming Pool cleaning','2013-07-31 12:27:03','2013-07-31 12:46:42','~/Content/images/default_person.jpg',10),('G8174262L110513180515KVW','Appadurai chandrasekar','Nil','HL ENGINEERING',20,'B702 #08-09','702#08-09',0,0,0,0,10,0,NULL,'Razak','contractor','2013-07-31 13:26:51','2013-07-31 14:10:53','~/Content/images/default_person.jpg',10),('S1626018E','Suraya  Binte Ashiko Hussein','Nil','Self Employ',22,'B706 #03-06','B706 #03-06',0,0,5,0,7,0,NULL,'','Cleaner','2013-07-31 14:09:00','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10),('S1514993J','Soh Kwee Hock','Nil','Self Employ',21,'B704 #04-08','B704 #04-08',0,0,2,0,7,0,NULL,'Jahari','Moving In','2013-07-31 15:29:04','0001-01-01 00:00:00','~/Content/images/default_person.jpg',10);

/*Table structure for table `visitors` */

DROP TABLE IF EXISTS `visitors`;

CREATE TABLE `visitors` (
  `VisitorId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `NRIC` varchar(45) NOT NULL,
  `FirstName` varchar(100) default NULL,
  `MiddleName` varchar(100) default NULL,
  `LastName` varchar(100) default NULL,
  `Address` varchar(500) default NULL,
  `ContactNumber` varchar(20) default NULL,
  `CompanyName` varchar(100) default NULL,
  `IsBlacklisted` bit(1) default NULL,
  `AddedDate` datetime default NULL,
  `IsCheckInCheckOut` bit(1) default NULL,
  `eventid` int(10) unsigned default NULL,
  PRIMARY KEY  (`VisitorId`),
  KEY `FK_visitors_1` (`DeploymentId`),
  KEY `FK_visitors_em` (`eventid`),
  CONSTRAINT `FK_visitors_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitors` */

insert  into `visitors`(`VisitorId`,`DeploymentId`,`NRIC`,`FirstName`,`MiddleName`,`LastName`,`Address`,`ContactNumber`,`CompanyName`,`IsBlacklisted`,`AddedDate`,`IsCheckInCheckOut`,`eventid`) values (1,1,'11111','Surya',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(2,1,'2222','Mory',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(3,1,'11111','satya',NULL,'sai',NULL,NULL,NULL,'\0','2013-03-19 00:00:00',NULL,2),(4,2,'123456','raj',NULL,'',NULL,NULL,NULL,'\0','2013-05-08 00:00:00',NULL,4),(5,2,'12434','godd',NULL,'jii',NULL,NULL,NULL,'\0','2013-05-08 00:00:00',NULL,4);

/*Table structure for table `visitortypes` */

DROP TABLE IF EXISTS `visitortypes`;

CREATE TABLE `visitortypes` (
  `VisitortypeId` int(10) unsigned NOT NULL auto_increment,
  `VisitorTypeDescription` varchar(45) NOT NULL default '',
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`VisitortypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitortypes` */

insert  into `visitortypes`(`VisitortypeId`,`VisitorTypeDescription`,`AddedDate`) values (1,'VIP',NULL),(2,'Contractor',NULL),(3,'Supplier',NULL),(4,'Guest',NULL),(5,'Helper','2013-05-08 00:00:00');

/* Procedure structure for procedure `AddCompany` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddCompany` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddCompany`(IN p_CompanyName VARCHAR(100), IN p_Address VARCHAR(500), 
		in p_ContactNumber varchar(15), in p_DeploymentId int, OUT p_result INT)
BEGIN
declare result int;
SELECT COUNT(*) into result FROM `companies` WHERE `CompanyName` = p_CompanyName AND `DeploymentId` = p_DeploymentId;
IF (result > 0) THEN
	  SET p_result = 2;
ELSE
	INSERT INTO `companies` (`CompanyName`,`Address`,`ContactNumber`,`DeploymentId`)
	VALUES	(p_CompanyName, p_Address, p_ContactNumber,p_DeploymentId);
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddDeployment` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddDeployment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddDeployment`(IN p_DeploymentName VARCHAR(100), IN p_Description VARCHAR(500), 
				 in p_ClientName varchar(100), in p_Address varchar(200), OUT p_result INT)
BEGIN
declare result int;
SELECT COUNT(*) into result FROM `deployments` WHERE `DeploymentName` = p_DeploymentName;
IF (result > 0) THEN
	  SET p_result = 2;
ELSE
	INSERT INTO `sms`.`deployments` (`DeploymentName`,`Description`,`AddedDate`,`ClientName`,`Address`)
	VALUES	(p_DeploymentName, p_Description, CURDATE(),p_ClientName, p_Address);
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddEvent` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddEvent` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddEvent`(in p_DeploymentId int, in p_EventName varchar(100), 
			in p_EventDate datetime, in p_Remarks varchar(500), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `events` WHERE `EventName` = p_EventName;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
	insert into `events` 
	(`DeploymentId`,`EventName`,`EventDate`,`Remarks`, `AddedDate`)
	values 
	(p_DeploymentId, p_EventName, p_EventDate, p_Remarks, curdate());
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddEventMasterList` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddEventMasterList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddEventMasterList`(in p_startdate datetime, in p_enddate datetime, in p_locationid int, in p_numberofguards int,
 in p_specialdutyforguard varchar(100), in p_eventname varchar(100), in p_notes varchar(500), in p_optionalguestlist varchar(2000),
	in p_personinchargename varchar(100), in p_personinchargenric varchar(100), 
	in p_personinchargecontactnumber varchar(20), in p_DeploymentId int, in p_Remarks varchar(500), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `eventmasterlist` WHERE `eventname` = p_eventname AND `DeploymentId` = p_DeploymentId;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
	insert into `eventmasterlist`
	(`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,`optionalguestlist`,
	`personinchargename`,`personinchargenric`,`personinchargecontactnumber`,`DeploymentId`,`Remarks`)
	values 
	(p_startdate, p_enddate, p_locationid, p_numberofguards, p_specialdutyforguard,p_eventname,p_notes,p_optionalguestlist,
	p_personinchargename,p_personinchargenric,p_personinchargecontactnumber,p_DeploymentId, p_Remarks);
	
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddGate` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddGate` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddGate`(in p_DeploymentId int, in p_GateName varchar(100), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `gates` WHERE `GateName` = p_GateName and DeploymentId = p_DeploymentId;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
    insert into `gates` (`DeploymentId`,`GateName`,`AddedDate`)
	values (p_DeploymentId, p_GateName, curdate());
SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddIncident` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddIncident` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddIncident`(IN p_reportdate datetime, IN p_natureofincident VARCHAR(20), in p_dateofincident datetime,
 in p_locationid int, in p_particularsofpersons varchar(500), in p_briefdescription varchar(500), 
 in p_remarksandactionstaken varchar(500),IN p_snapshotpath VARCHAR(100), IN p_deploymentid INT)
BEGIN
	INSERT INTO `sms`.`incidents` (`reportdate`,`natureofincident`,`dateofincident`,
	`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`,`snapshotpath`, `deploymentid`)
	VALUES	(p_reportdate, p_natureofincident, p_dateofincident,
	p_locationid,p_particularsofpersons,p_briefdescription,p_remarksandactionstaken, p_snapshotpath, p_deploymentid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `AddKey` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddKey` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddKey`(in p_KeyName varchar(45), in p_DeploymentId int, in p_KeyStatusId INT, OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `keys` WHERE `KeyName` = p_KeyName AND `DeploymentId` = p_DeploymentId;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
	insert into `keys` (`KeyName`,`DeploymentId`,`Status`,`AddedDate`)
	values (p_KeyName, p_DeploymentId, p_KeyStatusId, curdate());
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddKeyStatus` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddKeyStatus` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddKeyStatus`(in p_StatusType varchar(30), OUT p_result INT)
BEGIN
   DECLARE result INT;
	SELECT COUNT(*) INTO result FROM `keystatuses` WHERE `StatusType` = p_StatusType;
	IF (result > 0) THEN
		SET p_result = 2;
	ELSE
		insert into `keystatuses` (`StatusType`,`AddedDate`)
		values (p_StatusType, curdate());
		SET p_result = 1;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddLocation` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddLocation` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddLocation`(in p_DeploymentId int, in p_LocationName varchar(100), OUT p_result INT)
BEGIN
DECLARE result INT;
	SELECT COUNT(*) INTO result FROM `locations` WHERE `LocationName` = p_LocationName AND `DeploymentId` = p_DeploymentId;
	IF (result > 0) THEN
		SET p_result = 2;
	ELSE
	insert into `locations` (`DeploymentId`,`LocationName`)
	values (p_DeploymentId, p_LocationName);
	SET p_result = 1;
	END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddLostandfound` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddLostandfound` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddLostandfound`(in p_nameofperson varchar(100), IN p_nric VARCHAR(30), 
in p_reporteddate datetime, in p_remarks varchar(500), IN p_deploymentid INT)
BEGIN
	INSERT INTO `sms`.`lostandfound` (`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid`)
	VALUES	(p_nameofperson, p_nric, p_reporteddate, p_remarks,p_deploymentid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `AddOccurance` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddOccurance` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddOccurance`(in p_serialnumber varchar(20), in p_reportdate datetime, 
		in p_occurancetype varchar(15), in p_notes varchar(3000), in p_important bool, in p_heading varchar(500), IN  p_deploymentid INT)
BEGIN
	INSERT INTO `sms`.`occurances` (`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`)
	VALUES	(p_serialnumber, p_reportdate, p_occurancetype, p_notes,p_important,p_heading,p_deploymentid);
END */$$
DELIMITER ;

/* Procedure structure for procedure `AddPass` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddPass` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddPass`(in p_PassName varchar(100), in p_PassStatus varchar(10), 
in p_VisitortypeId int, in p_DeploymentId int, OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `passes` WHERE `PassName` = p_PassName AND `DeploymentId` = p_DeploymentId;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
	INSERT INTO `sms`.`passes` (`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId`)
	VALUES	(p_PassName, p_PassStatus, p_VisitortypeId, p_DeploymentId);
	SET p_result = 1;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `AddUserDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddUserDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddUserDetails`(p_DeploymentID int, p_UserTypeID int, p_LoginID varchar(20),
	 p_UserName varchar(50), p_EmailID varchar(100), p_Password varchar(20), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `userdetails` WHERE `LoginID` = p_LoginID  AND `DeploymentId` = p_DeploymentId;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
insert into userdetails(`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID`,`Password`)
    values (
    p_DeploymentID,
    p_UserTypeID,
    p_LoginID,
    p_UserName,
    p_EmailID,
    p_Password
    );
    SET p_result = 1;
END IF;
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

/* Procedure structure for procedure `AddVehicle` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddVehicle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddVehicle`(in p_identificationunit varchar(30),in p_platenumber varchar(20), in p_containernumber VARCHAR(30), in p_description VARCHAR(200), 
in p_trailernumber VARCHAR(30), in p_contractor VARCHAR(30),in p_length VARCHAR(10),in p_capacity VARCHAR(10),in p_securityguardname VARCHAR(100),
	 in p_authpersonic VARCHAR(100),in p_authpersonname VARCHAR(100),in p_imagepath VARCHAR(150), IN p_deploymentid INT)
BEGIN
	insert into `vehicles`
	(`identificationunit`,`platenumber`,`containernumber`,`description`,`trailernumber`,`contractor`,`length`,
	`capacity`,`securityguardname`,	`authpersonic`,`authpersonname`,`imagepath`, `deploymentid`)
	values 
	(p_identificationunit, p_platenumber, p_containernumber, p_description, p_trailernumber, p_contractor,p_length,
	p_capacity,p_securityguardname,	p_authpersonic,p_authpersonname,p_imagepath,p_deploymentid);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddVisitorCheckInOut` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddVisitorCheckInOut` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddVisitorCheckInOut`(IN p_nricid VARCHAR(30), IN p_name VARCHAR(100),IN p_address VARCHAR(500), IN p_fromcompany VARCHAR(100),
 IN p_tocompany INT, IN p_telno VARCHAR(20),IN p_persontovisit VARCHAR(100), IN p_eventid INT, IN p_temp INT, 
 IN p_visitortype INT, IN p_keyid  INT, IN p_passid INT, IN p_gateid INT, IN p_vehicleplatenumber  VARCHAR(20),
 IN p_guardname VARCHAR(100),IN p_remarks VARCHAR(500), IN p_checkintime DATETIME, IN p_checkouttime DATETIME, 
 IN p_snapshotpath VARCHAR(100),IN p_deploymentid INT, 
 OUT p_result INT)
BEGIN
DECLARE result INT;
DECLARE result1 INT;
IF(p_eventid != 0) /* Visitor checking in for an event.*/
THEN
SELECT COUNT(*) INTO result FROM `visitors` WHERE `NRIC` = p_nricid AND `eventid` = p_eventid;
SELECT COUNT(*) INTO result1 FROM `visitorcheckinout` WHERE `nricid` = p_nricid AND `eventid` = p_eventid AND `checkouttime` = '0001-01-01 00:00:00';
IF (result = 0 ) THEN SET p_result = 1; /* Visitor not in guest list */
ELSE SET p_result = 0; /* Visitor in guest list */
	IF (result1 = 0) THEN SET p_result = 0; /* If visitor in guest list but not checked in yet */
	ELSE  SET p_result = 2; /* Visitor already checked in .. so need to update check out time.*/
		UPDATE `visitorcheckinout` SET `checkouttime` = p_checkouttime WHERE `nricid` =   p_nricid AND `eventid` = p_eventid AND `checkouttime` = '0001-01-01 00:00:00';
	END IF;
END IF;
IF (p_result = 0) THEN
	INSERT INTO `visitorcheckinout`
	(`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`)
	VALUES 
	(p_nricid,p_name,p_address,p_fromcompany,p_tocompany,p_telno,p_persontovisit,p_eventid,p_temp,
	p_visitortype,p_keyid,p_passid,p_gateid,p_vehicleplatenumber,p_guardname,p_remarks,p_checkintime,p_checkouttime,p_snapshotpath,p_deploymentid);
END IF;
ELSE /* which means a general checkin/out. */
SELECT COUNT(*) INTO result1 FROM `visitorcheckinout` WHERE `nricid` = p_nricid AND `checkouttime` = '0001-01-01 00:00:00';
IF (result1 = 1) THEN SET p_result = 2;
UPDATE `visitorcheckinout` SET `checkouttime` = p_checkouttime WHERE `nricid` = p_nricid AND `checkouttime` = '0001-01-01 00:00:00';
ELSE SET p_result = 0;
END IF;
IF (p_result = 0) THEN
	INSERT INTO `visitorcheckinout`
	(`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`)
	VALUES 
	(p_nricid,p_name,p_address,p_fromcompany,p_tocompany,p_telno,p_persontovisit,p_eventid,p_temp,
	p_visitortype,p_keyid,p_passid,p_gateid,p_vehicleplatenumber,p_guardname,p_remarks,p_checkintime,p_checkouttime,p_snapshotpath,p_deploymentid);
END IF;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddVisitorCheckInOut_old` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddVisitorCheckInOut_old` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddVisitorCheckInOut_old`(IN p_nricid VARCHAR(30), IN p_name VARCHAR(100),IN p_address VARCHAR(500), IN p_fromcompany VARCHAR(100),
 IN p_tocompany INT, IN p_telno VARCHAR(20),IN p_persontovisit VARCHAR(100), IN p_eventid INT, IN p_temp INT, 
 IN p_visitortype INT, IN p_keyid  INT, IN p_passid INT, IN p_gateid INT, IN p_vehicleplatenumber  VARCHAR(20),
 IN p_guardname VARCHAR(100),IN p_remarks VARCHAR(500), IN p_checkintime DATETIME, IN p_checkouttime DATETIME, 
 IN p_snapshotpath VARCHAR(100),IN p_deploymentid INT, 
 OUT p_result INT)
BEGIN
DECLARE result INT;
DECLARE result1 INT;
SELECT COUNT(*) INTO result 
FROM `visitors`
WHERE `NRIC` = p_nricid AND `eventid` = p_eventid;
SELECT COUNT(*) INTO result1 
FROM `visitorcheckinout`
WHERE `nricid` = p_nricid AND `eventid` = p_eventid;
IF (result = 0 ) THEN
SET p_result = 1; /* Visitor not in guest list */
ELSE
SET p_result = 0; /* Visitor in guest list */
IF (result1 = 0) THEN /* If visitor in guest list but not checked in yet */
SET p_result = 0; 
ELSE 
SET p_result = 2; /* Visitor already checked in .. so need to update check out time.*/
UPDATE `visitorcheckinout` SET `checkouttime` = p_checkouttime WHERE `nricid` =   p_nricid AND `eventid` = p_eventid;
END IF;
END IF;
IF (p_result = 0) THEN
INSERT INTO `visitorcheckinout`
(`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`)
VALUES 
(p_nricid,p_name,p_address,p_fromcompany,p_tocompany,p_telno,p_persontovisit,p_eventid,p_temp,
p_visitortype,p_keyid,p_passid,p_gateid,p_vehicleplatenumber,p_guardname,p_remarks,p_checkintime,p_checkouttime,p_snapshotpath,p_deploymentid);
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddVisitors` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddVisitors` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddVisitors`(in p_DeploymentId int, in p_NRIC varchar(45), in p_FirstName varchar(100),
    in p_MiddleName varchar(100), in p_LastName varchar(100), in p_Address varchar(500),
    in p_ContactNumber varchar(20), p_CompanyName varchar(100), in p_IsBlacklisted bit,in p_eventid int)
BEGIN
	insert into `visitors`(`DeploymentId`,`NRIC`,`FirstName`,`MiddleName`,`LastName`,
			`Address`,`ContactNumber`,`CompanyName`,`IsBlacklisted`,`AddedDate`,`eventid`)
	values (p_DeploymentId, p_NRIC, p_FirstName, p_MiddleName, p_LastName, 
		p_Address, p_ContactNumber, p_CompanyName, p_IsBlacklisted, curdate(),p_eventid);
    END */$$
DELIMITER ;

/* Procedure structure for procedure `AddVisitorTypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `AddVisitorTypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `AddVisitorTypes`(in p_VisitorTypeDescription varchar(45), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `visitortypes` WHERE `VisitorTypeDescription` = p_VisitorTypeDescription;
IF (result > 0) THEN
	SET p_result = 2;
ELSE
	insert into `visitortypes` (`VisitorTypeDescription`, `AddedDate`)
	values (p_VisitorTypeDescription, curdate());
	SET p_result = 1;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteCompany` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteCompany` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteCompany`(in p_CompanyId int, OUT p_result INT)
BEGIN
declare result int;
SELECT COUNT(*) into result FROM `companies` WHERE `CompanyId` = p_CompanyId;
IF (result > 0) THEN
	delete from `sms`.`companies` WHERE `CompanyId` = p_CompanyId;
	SET p_result = 1;
ELSE
	SET p_result = 2;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteDeployment` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteDeployment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteDeployment`(in p_DeploymentId int)
BEGIN
	DELETE FROM `gates` where `DeploymentId` = p_DeploymentId;
	DELETE FROM `keys` WHERE `DeploymentId` = p_DeploymentId;
	DELETE FROM `incidents` WHERE `deploymentid` = p_DeploymentId;
	DELETE FROM `lostandfound` WHERE `deploymentid` = p_DeploymentId;
	DELETE FROM `occurances` WHERE `deploymentid` = p_DeploymentId;
	DELETE FROM `vehicles` WHERE `deploymentid` = p_DeploymentId;
	DELETE FROM `visitorcheckinout` WHERE `deploymentid` = p_DeploymentId;
	DELETE FROM `companies` WHERE `DeploymentId` = p_DeploymentId;
	DELETE FROM `passes` WHERE `DeploymentId` = p_DeploymentId;
	delete from `visitors` where `DeploymentId` = p_DeploymentId;
	DELETE FROM `events` WHERE `DeploymentId` = p_DeploymentId;
	DELETE FROM `eventmasterlist` WHERE `DeploymentId` = p_DeploymentId;
	DELETE FROM `locations` WHERE `DeploymentId` = p_DeploymentId;
	DELETE FROM `deployments` WHERE `DeploymentId` = p_DeploymentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteEvent` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteEvent` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteEvent`(in p_EventId int)
BEGIN
	delete from `events` where `EventId` = p_EventId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteEventMasterList` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteEventMasterList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteEventMasterList`(in p_eventid int, OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `eventmasterlist` WHERE `eventid` = p_eventid;
IF (result > 0) THEN
	delete from `eventmasterlist` where `eventid` = p_eventid;
	SET p_result = 1;
ELSE
	SET p_result = 2;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteGate` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteGate` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteGate`(in p_GateId int)
BEGIN
	delete from `gates` where `GateId` = p_GateId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteIncident` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteIncident` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteIncident`(in p_IncidentID int)
BEGIN
	delete from `sms`.`incidents` 	where `incidentid` = p_IncidentID;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteKey` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteKey` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteKey`(in p_KeyId int)
BEGIN
	delete from `keys` where `KeyId` = p_KeyId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteKeyStatus` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteKeyStatus` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteKeyStatus`(in p_StatusID int)
BEGIN
	delete from `keystatuses` where `StatusID` = p_StatusID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteLocation` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteLocation` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteLocation`(in p_LocationId int)
BEGIN
	delete from `locations` where `LocationId` = p_LocationId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteLostandfound` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteLostandfound` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteLostandfound`(in p_lostandfoundreportid int)
BEGIN
	delete from `sms`.`lostandfound` 
	where `lostandfoundreportid` = p_lostandfoundreportid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteOccurance` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteOccurance` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteOccurance`(in p_occuranceid int)
BEGIN
	delete from `sms`.`occurances` 	where `occuranceid` = p_occuranceid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeletePass` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeletePass` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeletePass`(in p_PassId int)
BEGIN
	delete from `sms`.`passes` where `PassId` = p_PassId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteUserdetail` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteUserdetail` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteUserdetail`(in p_UID int)
BEGIN
	delete from `userdetails` where `UID` = p_UID;
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

/* Procedure structure for procedure `DeleteVehicle` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteVehicle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteVehicle`(
  in p_identificationunit varchar (30)
  )
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `vehicles` WHERE `identificationunit` = p_identificationunit;
IF (result > 0) THEN
  Delete from  `vehicles`
  WHERE `identificationunit` = p_identificationunit ;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteVisitor` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteVisitor` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteVisitor`(in p_VisitorId int)
BEGIN
	delete from `visitors` where `VisitorId` = p_VisitorId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteVisitorCheckInOut` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteVisitorCheckInOut` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteVisitorCheckInOut`(in p_nricid varchar(30))
BEGIN
	delete from `visitorcheckinout` where `nricid` = p_nricid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `DeleteVisitortype` */

/*!50003 DROP PROCEDURE IF EXISTS  `DeleteVisitortype` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `DeleteVisitortype`(in p_VisitortypeId int)
BEGIN
	delete from `visitortypes` where `VisitortypeId` = p_VisitortypeId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetCompanies` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetCompanies` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetCompanies`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId` FROM `companies`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId` FROM `companies`;
END IF;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetCompanyByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetCompanyByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetCompanyByID`(in p_CompanyId int)
BEGIN
	select `CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId` from `sms`.`companies` WHERE `CompanyId` = p_CompanyId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetDeploymentByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetDeploymentByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetDeploymentByID`(in p_DeploymentId int)
BEGIN
	select `DeploymentId`,`DeploymentName`,`Description`,`ClientName`,`Address`,`AddedDate` from `deployments` where `DeploymentId` = p_DeploymentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetDeployments` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetDeployments` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetDeployments`()
BEGIN
	select `DeploymentId`,`DeploymentName`,`Description`,`ClientName`,`Address`,`AddedDate` from `deployments`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetEventByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetEventByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetEventByID`(in p_EventId int)
BEGIN
	SELECT `EventId`,`DeploymentId`,`EventName`,`EventDate`,`Remarks`,`ClientName`,`Address`,`AddedDate` FROM `events`
	where `EventId` = p_EventId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetEventMasterList` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetEventMasterList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetEventMasterList`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,
	`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`, `DeploymentId`,`Remarks`
	FROM `eventmasterlist`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,
	`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`, `DeploymentId`,`Remarks`
	FROM `eventmasterlist`;
END IF;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetEventMasterListByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetEventMasterListByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetEventMasterListByID`(in p_eventid int)
BEGIN
	select `eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,
	`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`,`DeploymentId`,`Remarks`
	from `eventmasterlist` 
	where `eventid` = p_eventid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetEvents` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetEvents` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetEvents`()
BEGIN
	select `EventId`,`DeploymentId`,`EventName`,`EventDate`,`Remarks`,`AddedDate` from `events`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetGateByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetGateByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetGateByID`(in p_GateId int)
BEGIN
	SELECT `GateId`,`DeploymentId`,`GateName`,`AddedDate` FROM `gates` where `GateId` = p_GateId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetGates` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetGates` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetGates`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `GateId`,`DeploymentId`,`GateName`,`AddedDate` FROM `gates`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `GateId`,`DeploymentId`,`GateName`,`AddedDate` FROM `gates`;
END IF;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetIncidentByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetIncidentByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetIncidentByID`(in p_incidentid int)
BEGIN
	select `incidentid`,`reportdate`,`natureofincident`,`dateofincident`,
	`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`,`snapshotpath`, `deploymentid`
	from `sms`.`incidents` 
	where `incidentid` = p_incidentid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetIncidents` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetIncidents` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetIncidents`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `incidentid`,`reportdate`,`natureofincident`,`dateofincident`,
	`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`, `snapshotpath`, `deploymentid`
	FROM `incidents`
	WHERE 
	`deploymentid` = p_deploymentId ;
ELSE 
	SELECT `incidentid`,`reportdate`,`natureofincident`,`dateofincident`,
	`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`, `snapshotpath`, `deploymentid`
	FROM `incidents`;
END IF;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetKeyByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetKeyByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetKeyByID`(IN p_KeyId INT)
BEGIN
	SELECT `KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate` FROM `keys` WHERE `KeyId` = p_KeyId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetKeys` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetKeys` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetKeys`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate` FROM `keys`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate` FROM `keys`;
END IF;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetKeyStatusByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetKeyStatusByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetKeyStatusByID`(in p_StatusID int)
BEGIN
	select `StatusID`,`StatusType` from `keystatuses` where `StatusID` = p_StatusID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetKeyStatuses` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetKeyStatuses` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetKeyStatuses`()
BEGIN
	select `StatusID`,`StatusType` from `keystatuses`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLocationByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLocationByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLocationByID`(in p_LocationId int)
BEGIN
	SELECT `LocationId`,`DeploymentId`,`LocationName` FROM `locations` where `LocationId` = p_LocationId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLocations` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLocations` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLocations`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `LocationId`,`DeploymentId`,`LocationName` FROM `locations`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `LocationId`,`DeploymentId`,`LocationName` FROM `locations`;
END IF;
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLostandfoundByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLostandfoundByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLostandfoundByID`(in p_lostandfoundreportid int)
BEGIN
	select `lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid` from `sms`.`lostandfound` 
	where `lostandfoundreportid` = p_lostandfoundreportid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetLostandfounds` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetLostandfounds` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetLostandfounds`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid` FROM `lostandfound`
	WHERE 
	`deploymentid` = p_deploymentId ;
	
ELSE 
	SELECT `lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid` FROM `lostandfound`;
END IF;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetOccuranceByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetOccuranceByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetOccuranceByID`(in p_occuranceid int)
BEGIN
	select `occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`
	from `sms`.`occurances` 
	where `occuranceid` = p_occuranceid
	ORDER BY `reportdate` DESC;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetOccurances` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetOccurances` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetOccurances`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`
	FROM `occurances`
	WHERE 
	`deploymentid` = p_deploymentId 
	ORDER BY `reportdate` ASC;
ELSE 
	SELECT `occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`
	FROM `occurances`
	ORDER BY `reportdate` ASC;
END IF;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetParticipantsByEventID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetParticipantsByEventID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetParticipantsByEventID`(in p_eventid int)
BEGIN
	select `VisitorId`,`DeploymentId`,`NRIC`,`FirstName`,`eventid`,`LastName` from `visitors` where `eventid` = p_eventid;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetPassByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetPassByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetPassByID`(in p_PassId int)
BEGIN
	select `PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId`
	from `sms`.`passes` 
	where `PassId` = p_PassId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetPasses` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetPasses` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetPasses`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId` FROM `passes`
	WHERE 
	`DeploymentId` = p_deploymentId ;
ELSE 
	SELECT `PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId` FROM `passes`;
END IF;
	
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserdetailByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserdetailByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserdetailByID`(in p_UID int)
BEGIN
	SELECT `UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID` 
	FROM `userdetails`
	where `UID` = p_UID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUserdetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUserdetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUserdetails`(IN p_deploymentId int, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT `UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID` FROM `userdetails`
	WHERE 
	`DeploymentID` = p_deploymentId AND
	`UserTypeID` >= currentUserType ;
	
ELSE 
	SELECT `UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID` FROM `userdetails`
	WHERE 
	`UserTypeID` >= currentUserType ;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUsersByDeploymentID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUsersByDeploymentID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUsersByDeploymentID`(IN p_DeploymentId INT)
BEGIN
	SELECT `UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID` 
	FROM `userdetails`
	WHERE `DeploymentID` = p_DeploymentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUsertypeByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUsertypeByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUsertypeByID`(in p_UserTypeId int)
BEGIN
	SELECT `UserTypeId`,`UserType`,`Description`,`CreatedDate`,`Parent`,`level` FROM `usertypes`
	where `UserTypeId` = p_UserTypeId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetUsertypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetUsertypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetUsertypes`()
BEGIN
	select `UserTypeId`,`UserType`,`Description`,`CreatedDate`,`Parent`,`level` from `usertypes`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVehicleByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVehicleByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVehicleByID`(in p_identificationunit varchar(30) )
BEGIN
SELECT
    `identificationunit`, 
    `platenumber`,
    `containernumber`,
    `description`,
    `trailernumber`,
    `contractor`,
    `length`,
    `capacity`,
    `securityguardname`,
    `authpersonic`,
    `authpersonname`,
    `imagepath` ,
    `deploymentid`
    FROM `vehicles`
  WHERE `identificationunit` = p_identificationunit;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVehicles` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVehicles` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVehicles`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT 
    `identificationunit`,
    `platenumber`,
    `containernumber`,
    `description`,
    `trailernumber`,
    `contractor`,
    `length`,
    `capacity`,
    `securityguardname`,
    `authpersonic`,
    `authpersonname`,
    `imagepath` ,
    `deploymentid`
    FROM `vehicles`
	WHERE 
	`deploymentid` = p_deploymentId ;
ELSE 
	
SELECT 
    `identificationunit`,
    `platenumber`,
    `containernumber`,
    `description`,
    `trailernumber`,
    `contractor`,
    `length`,
    `capacity`,
    `securityguardname`,
    `authpersonic`,
    `authpersonname`,
    `imagepath` ,
    `deploymentid`
    FROM `vehicles`;
END IF;
	
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitorByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitorByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitorByID`(in p_VisitorId int)
BEGIN
	SELECT `VisitorId`,`DeploymentId`,`NRIC`,`FirstName`,`MiddleName`,`LastName`,`Address`,`ContactNumber`,
	`CompanyName`,`IsBlacklisted`,`AddedDate` FROM `visitors` where `VisitorId` = p_VisitorId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitorCheckInOut` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitorCheckInOut` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitorCheckInOut`(IN p_deploymentId INT, IN currentUserType INT)
BEGIN
IF(currentUserType != 1) /* Visitor checking in for an event.*/
THEN
SELECT
	`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`
	FROM `visitorcheckinout`
	 WHERE 
	`deploymentid` = p_deploymentId ORDER BY `checkintime` DESC;
	
ELSE 
	SELECT
	`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`
	FROM
	 `visitorcheckinout`
	 ORDER BY `checkintime` DESC;
END IF;
	
	
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitorCheckInOutByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitorCheckInOutByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitorCheckInOutByID`(in p_nricid int, IN p_EventId INT)
BEGIN
	select
	`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`
	from
	 `visitorcheckinout`  
	WHERE `nricid` = p_nricid AND `eventid` = p_EventId 
	ORDER BY `checkintime` DESC;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitors` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitors` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitors`()
BEGIN
	select `VisitorId`,`DeploymentId`,`NRIC`,`FirstName`,`MiddleName`,`LastName`,`Address`,`ContactNumber`,
	`CompanyName`,`IsBlacklisted`,`AddedDate` from `visitors`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitortypeByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitortypeByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitortypeByID`(in p_VisitortypeId int)
BEGIN
	SELECT `VisitortypeId`,`VisitorTypeDescription`,`AddedDate` FROM `visitortypes`
	where `VisitortypeId` = p_VisitortypeId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `GetVisitortypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetVisitortypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetVisitortypes`()
BEGIN
	select `VisitortypeId`,`VisitorTypeDescription`,`AddedDate` from `visitortypes`;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `IsUserExists` */

/*!50003 DROP PROCEDURE IF EXISTS  `IsUserExists` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `IsUserExists`(IN p_LoginID VARCHAR(20), IN p_Password VARCHAR(20))
BEGIN
	SELECT `UID`,`UserName`,`DeploymentID`,`UserType`,`usertypes`.`UserTypeId` 
	FROM `userdetails`,`usertypes` WHERE `userdetails`.`UserTypeID`= `usertypes`.`UserTypeId` 
	AND `LoginID` = p_LoginID AND `Password` = p_Password;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `proc_IF` */

/*!50003 DROP PROCEDURE IF EXISTS  `proc_IF` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `proc_IF`(IN param1 INT)
BEGIN  
    DECLARE variable1 INT;  
    SET variable1 = param1 + 1;  
    IF variable1 = 0 THEN  
        SELECT variable1;  
    END IF;  
    IF param1 = 0 THEN  
        SELECT 'Parameter value = 0';  
    ELSE  
        SELECT 'Parameter value <> 0';  
    END IF;  
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateCompany` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateCompany` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateCompany`(in p_CompanyId int, IN p_CompanyName VARCHAR(100), IN p_Address VARCHAR(500), 
		in p_ContactNumber varchar(15), in p_DeploymentId int, OUT p_result INT)
BEGIN
declare result int;
SELECT COUNT(*) into result FROM `companies` WHERE `CompanyId` = p_CompanyId;
IF (result > 0) THEN
	UPDATE `sms`.`companies` SET 
	`CompanyName` = p_CompanyName,`Address` = p_Address,`ContactNumber` = p_ContactNumber, `DeploymentId` = p_DeploymentId
	WHERE `CompanyId` = p_CompanyId;
	SET p_result = 1;
ELSE
	SET p_result = 2;
END IF;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateDeployment` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateDeployment` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateDeployment`(in p_DeploymentId int, IN p_DeploymentName VARCHAR(100), 
	IN p_ClientName VARCHAR(100), IN p_Address VARCHAR(200), IN p_Description VARCHAR(500))
BEGIN
	update `deployments` set `DeploymentName` = p_DeploymentName,
	`Description` = p_Description, `ClientName`=p_ClientName,`Address`= p_Address 
	where `DeploymentId` = p_DeploymentId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateEvent` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateEvent` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateEvent`(in p_EventId int, IN p_DeploymentId INT, IN p_EventName VARCHAR(100), 
    IN p_EventDate DATETIME, iN p_Remarks VARCHAR(500))
BEGIN
	update `events` set `DeploymentId` = p_DeploymentId,
	`EventName` = p_EventName, `EventDate` = p_EventDate,
	`Remarks` = p_Remarks where `EventId` = p_EventId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateEventMasterList` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateEventMasterList` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateEventMasterList`(in p_eventid int, in p_startdate datetime, in p_enddate datetime, in p_locationid int, in p_numberofguards int,
	in p_specialdutyforguard varchar(100), in p_eventname varchar(100), in p_notes varchar(500), in p_optionalguestlist varchar(2000),
	in p_personinchargename varchar(100), in p_personinchargenric varchar(100), 
	in p_personinchargecontactnumber varchar(20), IN p_DeploymentId INT, IN p_Remarks VARCHAR(500), OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `eventmasterlist` WHERE `eventid` = p_eventid;
IF (result > 0) THEN
	update `eventmasterlist` set
	`startdate` = p_startdate,`enddate` = p_enddate,`locationid` = p_locationid,`numberofguards` = p_numberofguards,
	`specialdutyforguard` = p_specialdutyforguard,`eventname` = p_eventname,`notes` = p_notes,`optionalguestlist` = p_optionalguestlist,
	`personinchargename` = p_personinchargename,`personinchargenric` = p_personinchargenric,
	`personinchargecontactnumber` = p_personinchargecontactnumber, `DeploymentId` = p_DeploymentId, `Remarks`= p_Remarks
	where `eventid` = p_eventid;
	SET p_result = 1;
ELSE
	SET p_result = 2;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateGate` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateGate` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateGate`(in p_GateId int, IN p_DeploymentId INT, IN p_GateName VARCHAR(100))
BEGIN
	update `gates` set `DeploymentId` = p_DeploymentId, `GateName` = p_GateName
	where `GateId` = p_GateId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateIncident` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateIncident` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateIncident`(in p_incidentid int, IN p_reportdate datetime, IN p_natureofincident VARCHAR(20), in p_dateofincident datetime,
 in p_locationid int, in p_particularsofpersons varchar(500), in p_briefdescription varchar(500), 
 in p_remarksandactionstaken varchar(500),IN p_snapshotpath VARCHAR(100), IN  p_deploymentid INT)
BEGIN
	update `sms`.`incidents` set `reportdate` = p_reportdate,`natureofincident` = p_natureofincident,
	`dateofincident` = p_dateofincident, `locationid` = p_locationid,`particularsofpersons` = p_particularsofpersons,
	`briefdescription` = p_briefdescription,`remarksandactionstaken` = p_remarksandactionstaken,`snapshotpath`=p_snapshotpath
	, `deploymentid` = p_deploymentid
	where `incidentid` = p_incidentid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateKey` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateKey` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateKey`(in p_KeyId int,IN p_KeyName VARCHAR(45), IN p_DeploymentId INT, IN p_KeyStatusId INT)
BEGIN
	update `keys` set `KeyName` = p_KeyName, `DeploymentId` = p_DeploymentId,
	`Status` = p_KeyStatusId where `KeyId` = p_KeyId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateKeyStatus` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateKeyStatus` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateKeyStatus`(in p_StatusID int, in p_StatusType varchar(30))
BEGIN
	update  `keystatuses` set `StatusType` = p_StatusType where `StatusID` = p_StatusID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateLocation` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateLocation` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateLocation`( in p_LocationId int,IN p_DeploymentId INT, IN p_LocationName VARCHAR(100))
BEGIN
	update `locations` set `DeploymentId` = p_DeploymentId, `LocationName` = p_LocationName
	where `LocationId` = p_LocationId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateLostandfound` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateLostandfound` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateLostandfound`(in p_lostandfoundreportid int, in p_nameofperson varchar(100), IN p_nric VARCHAR(30), 
in p_reporteddate datetime, in p_remarks varchar(500), IN  p_deploymentid INT)
BEGIN
	update `sms`.`lostandfound` set `nameofperson` = p_nameofperson,`nric` = p_nric,
	`reporteddate` = p_reporteddate,`remarks` = p_remarks,`deploymentid` = p_deploymentid
	where `lostandfoundreportid` = p_lostandfoundreportid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateOccurance` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateOccurance` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateOccurance`(in p_occuranceid int, in p_serialnumber varchar(20), in p_reportdate datetime, 
		in p_occurancetype varchar(15), in p_notes varchar(500), IN p_important bool, IN p_heading VARCHAR(500), IN  p_deploymentid INT)
BEGIN
	update `sms`.`occurances` set `serialnumber` = p_serialnumber,`reportdate` = p_reportdate,
	`occurancetype` = p_occurancetype,`notes` = p_notes,`important` = p_important,`heading` = p_heading,`deploymentid` = p_deploymentid
	where `occuranceid` = p_occuranceid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdatePass` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdatePass` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdatePass`(in p_PassId int, in p_PassName varchar(100), in p_PassStatus varchar(10), 
			in p_VisitortypeId int, in p_DeploymentId int)
BEGIN
	update `passes` set `PassName` = p_PassName,`PassStatus` = p_PassStatus,
	`VisitortypeId` = p_VisitortypeId, `DeploymentId` = p_DeploymentId
	where `PassId` = p_PassId;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateUserDetails` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateUserDetails` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateUserDetails`(p_UID INT, p_DeploymentID INT, p_UserTypeID INT, p_LoginID VARCHAR(20),
	 p_UserName VARCHAR(50), p_EmailID VARCHAR(100), p_Password VARCHAR(20))
BEGIN
	UPDATE `userdetails` 
	SET `DeploymentID` = p_DeploymentID, 
	     `UserTypeID` = p_UserTypeID,
	     /*`LoginID` = p_LoginID,*/
	     `UserName` = p_UserName,
	     /*`EmailID` = p_EmailID,*/
	     `Password` = p_Password
	WHERE `UID` = p_UID;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateUsertype` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateUsertype` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateUsertype`(in p_UserTypeId int, in p_UserType varchar(45),
		in p_Description varchar(500), in p_Parent varchar(45), in p_level int)
BEGIN
	update `usertypes` set `UserType`=p_UserType, `Description`= p_Description,
	`Parent` = p_Parent, `level` = p_level where `UserTypeId` = p_UserTypeId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateVehicle` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateVehicle` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateVehicle`(
  in p_identificationunit varchar (30),
  in p_platenumber varchar (20),
  in p_containernumber VARCHAR (30),
  in p_description VARCHAR (200),
  in p_trailernumber VARCHAR (30),
  in p_contractor VARCHAR (30),
  in p_length VARCHAR (10),
  in p_capacity VARCHAR (10),
  in p_securityguardname VARCHAR (100),
  in p_authpersonic VARCHAR (100),
  in p_authpersonname VARCHAR (100),
  in p_imagepath VARCHAR (150),
  IN p_deploymentid INT,
  OUT p_result INT
  )
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `vehicles` WHERE `identificationunit` = p_identificationunit;
IF (result > 0) THEN
UPDATE 
    `vehicles` 
  SET
    `platenumber` = p_platenumber,
    `containernumber` = p_containernumber,
    `description` = p_description,
    `trailernumber` = p_trailernumber,
    `contractor` = p_contractor,
    `length` = p_length,
    `capacity` = p_capacity,
    `securityguardname` = p_securityguardname,
    `authpersonic` = p_authpersonic,
    `authpersonname` = p_authpersonname,
    `imagepath` = p_imagepath,
    `deploymentid` = p_deploymentid
  WHERE `identificationunit` = p_identificationunit ;
	SET p_result = 1;
ELSE
  
  SET p_result = 2;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateVisitorCheckInOut` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateVisitorCheckInOut` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateVisitorCheckInOut`(in p_nricid varchar(30), in p_name varchar(100),in p_address VARCHAR(500), in p_fromcompany VARCHAR(100),
 in p_tocompany int, in p_telno VARCHAR(20),in p_persontovisit VARCHAR(100), in p_eventid int, in p_temp int, 
 in p_visitortype int, in p_keyid INT, in p_passid int, in p_gateid int, in p_vehicleplatenumber  VARCHAR(20),
 in p_guardname VARCHAR(100),in p_remarks VARCHAR(500), in p_checkintime datetime, in p_checkouttime datetime, OUT p_result INT)
BEGIN
DECLARE result INT;
SELECT COUNT(*) INTO result FROM `visitorcheckinout` WHERE `nricid` = p_nricid;
IF (result > 0) THEN
	update `visitorcheckinout` set
	`name` = p_name,`address` = p_address,`fromcompany` = p_fromcompany,`tocompany` = p_tocompany,`telno` = p_telno,
	`persontovisit` = p_persontovisit,`eventid` = p_eventid,`temp` = p_temp,
	`visitortype` = p_visitortype,`keyid` = p_keyid,`passid` = p_passid,`gateid` = p_gateid,
	`vehicleplatenumber` = p_vehicleplatenumber,`guardname` = p_guardname,`remarks` = p_remarks,
	`checkintime` = p_checkintime,`checkouttime` = p_checkouttime
	where `nricid` = p_nricid;
SET p_result = 1;
ELSE
	SET p_result = 2;
END IF;
END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateVisitors` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateVisitors` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateVisitors`(in p_VisitorId int, IN p_DeploymentId INT, IN p_NRIC VARCHAR(45), IN p_FirstName VARCHAR(100),
    IN p_MiddleName VARCHAR(100), IN p_LastName VARCHAR(100), IN p_Address VARCHAR(500),
    IN p_ContactNumber VARCHAR(20), p_CompanyName VARCHAR(100), IN p_IsBlacklisted BIT)
BEGIN
	update `visitors` set `DeploymentId` = p_DeploymentId, `NRIC` = p_NRIC, `FirstName` = p_FirstName,
	`MiddleName` = p_MiddleName, `LastName` = p_LastName, `Address` = p_Address, 
	`ContactNumber` = p_ContactNumber, `CompanyName` = p_CompanyName, `IsBlacklisted` = p_IsBlacklisted
	where `VisitorId` = p_VisitorId;
    END */$$
DELIMITER ;

/* Procedure structure for procedure `UpdateVisitorTypes` */

/*!50003 DROP PROCEDURE IF EXISTS  `UpdateVisitorTypes` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `UpdateVisitorTypes`(in p_VisitortypeId int, IN p_VisitorTypeDescription VARCHAR(45))
BEGIN
	update `visitortypes` set `VisitorTypeDescription` = p_VisitorTypeDescription
	where `VisitortypeId` = p_VisitortypeId;
    END */$$
DELIMITER ;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
