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

insert  into `companies`(`CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId`) values (1,'Info Technologies','Banglore 7678','4445566677',3),(2,'Keerti Technologies','Hyd','1323232',2),(3,'Microsoft','HYD','999998888',1),(4,'Company 5656','HYD','234566',2);

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

insert  into `deployments`(`DeploymentId`,`DeploymentName`,`Description`,`AddedDate`,`ClientName`,`Address`) values (1,'Hyd Public',NULL,'2012-12-31 00:00:00','HYD Govt','Somajiguda HYD'),(2,'KV',NULL,'2013-01-28 00:00:00','K V','K V Gachibowli'),(3,'CB',NULL,'2013-01-29 00:00:00','INFY',NULL),(4,'CA',NULL,'2013-03-18 00:00:00','CA Technologies','Hyderbad'),(5,'TPTY',NULL,'2013-03-21 00:00:00','HDFC','T.K Road'),(6,'SKS',NULL,'2013-03-21 00:00:00',NULL,NULL),(7,'SING',NULL,'2013-03-21 00:00:00',NULL,NULL);

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
  KEY `FK_eventmasterlist` (`locationid`),
  CONSTRAINT `FK_eventmasterlist` FOREIGN KEY (`locationid`) REFERENCES `locations` (`LocationId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `eventmasterlist` */

insert  into `eventmasterlist`(`eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`,`DeploymentId`,`Remarks`) values (1,'2013-02-24 00:00:00','2013-02-24 00:00:00',1,12,'5','Birth Day','sdasa','sda','999999','999999','234234',3,NULL),(2,'2013-08-01 13:35:00','2013-08-01 19:19:00',2,8,'3','Wedding','Birth day','afsda','99999','99999','33333',1,''),(3,'2013-04-01 10:00:00','2013-04-01 12:00:00',1,0,'','reception','','','','','989898998',1,'');

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
  CONSTRAINT `FK_gates_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `gates` */

insert  into `gates`(`GateId`,`DeploymentId`,`GateName`,`AddedDate`) values (1,1,'Gate 444','2013-01-24 00:00:00'),(2,2,'Gate 88','2013-01-25 00:00:00'),(3,3,'Gate 100','2013-01-25 00:00:00'),(4,2,'Gate 786','2013-02-06 00:00:00'),(5,3,'G 007','2013-02-06 00:00:00'),(7,3,'G S 456','2013-02-06 00:00:00');

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
  CONSTRAINT `FK_incidents` FOREIGN KEY (`locationid`) REFERENCES `locations` (`LocationId`),
  CONSTRAINT `FK_incidents_d` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `incidents` */

insert  into `incidents`(`incidentid`,`reportdate`,`natureofincident`,`dateofincident`,`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`,`snapshotpath`,`deploymentid`) values (1,'2013-02-25 00:00:00','Stolen','2013-02-24 00:00:00',2,'qwerqwr','avcvvvv','sdfasfsf','../../Content/images/incident.jpg',NULL),(3,'2013-03-21 09:15:57','car','2012-01-04 10:24:00',1,'id=\"incidentTime\"','','','../../Content/images/incident.jpg',NULL),(4,'2013-03-20 18:48:46','bike damaged','2013-01-01 09:30:00',1,'id=\"incidentTime\"','','','../../Content/images/incident.jpg',NULL),(7,'2013-03-21 09:29:33','car','2008-01-01 16:58:00',4,'har','','','../../Content/images/incident.jpg',NULL),(8,'2013-03-21 21:00:19','bus accident','2013-01-15 11:17:00',1,'hari','','','../../Content/images/incident.jpg',NULL),(9,'2013-03-22 07:37:48','theft','2013-04-20 16:19:00',1,'raj','','','../../Content/images/incident.jpg',NULL),(10,'2013-03-22 07:40:13','joy','2008-01-01 05:24:00',1,'j','','','../Snapshots/201332274031730.png',NULL);

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

insert  into `keys`(`KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate`) values (1,'Key-01',3,3,'2013-03-19 00:00:00'),(2,'New key',2,1,'2013-03-20 00:00:00');

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

insert  into `locations`(`LocationId`,`DeploymentId`,`LocationName`) values (1,2,'Location 111'),(2,3,'Location 606'),(4,2,'Rajahmundry');

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

insert  into `lostandfound`(`lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid`) values (1,'V Sriram','23456','2013-02-14 00:00:00','this is testing for eding',NULL),(2,'csr','12344','2013-03-02 00:00:00','water bottle stolen',NULL),(3,'Subbarao','12333','2003-10-09 00:00:00','he lost his head phones',NULL),(4,'csr','12322','2013-03-11 00:00:00','lkdjfsalkfjdlf',NULL);

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

insert  into `occurances`(`occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`) values (1,NULL,'2013-03-05 00:00:00',NULL,'231412343241',0,'First Occurance',NULL),(3,NULL,'2013-08-03 00:00:00',NULL,'Need to follow up',1,'GoodWork',NULL),(9,NULL,'2013-03-22 16:12:54',NULL,'major work happening in the day of holi and new year holidays.',1,'Adding another occurrence',2),(10,NULL,'2013-03-24 12:39:16',NULL,'Accident',1,'Very imp occurance',2),(12,NULL,'2013-04-17 09:08:06',NULL,'S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)',0,'Main occurrence',2),(13,NULL,'2013-04-17 22:13:18',NULL,'sfsfjsklfj,',1,'tjsdfh',2);

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

insert  into `passes`(`PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId`) values (5,'Test pass 123','1',2,3),(6,'pass 222','1',3,2);

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

insert  into `userdetails`(`UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID`,`Password`) values (2,2,1,'admin','Satish Addanki','s@gmail.com','123'),(3,1,4,'guard1','vsr','v@hotmail.com','123'),(4,2,3,'seshu','seshu 123','s@rediffmail.com','123'),(5,3,1,'Ravi','Mahesh','m@gmail.com','123');

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

insert  into `vehicles`(`identificationunit`,`platenumber`,`containernumber`,`description`,`trailernumber`,`contractor`,`length`,`capacity`,`securityguardname`,`authpersonic`,`authpersonname`,`imagepath`,`deploymentid`) values ('2342','24333','23423','dfasf','234267','vsr','20','Full','subbu','hjhjhy','Paddu',NULL,NULL);

/*Table structure for table `visitorcheckinout` */

DROP TABLE IF EXISTS `visitorcheckinout`;

CREATE TABLE `visitorcheckinout` (
  `nricid` varchar(30) NOT NULL,
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
  PRIMARY KEY  (`nricid`),
  KEY `FK_visitorcheckinout_companies` (`tocompany`),
  KEY `FK_visitorcheckinout_gates` (`gateid`),
  KEY `FK_visitorcheckinout_events` (`eventid`),
  KEY `FK_visitorcheckinout_passes` (`passid`),
  KEY `FK_visitorcheckinout_ddep` (`deploymentid`),
  CONSTRAINT `FK_visitorcheckinout_companies` FOREIGN KEY (`tocompany`) REFERENCES `companies` (`CompanyId`),
  CONSTRAINT `FK_visitorcheckinout_ddep` FOREIGN KEY (`deploymentid`) REFERENCES `deployments` (`DeploymentId`),
  CONSTRAINT `FK_visitorcheckinout_passes` FOREIGN KEY (`passid`) REFERENCES `passes` (`PassId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitorcheckinout` */

insert  into `visitorcheckinout`(`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`) values ('11111','sairam','asdsad','Inno',1,'8878787878','',1,0,2,0,5,3,NULL,'Guru','','2013-03-19 12:09:53','2013-03-19 12:10:55','../../Content/images/default_person.jpg',NULL),('123','mr hari','San Diego','TCS',3,'878787878','Rai',0,0,1,0,5,0,NULL,'','','2013-04-17 09:04:12','2013-04-17 20:18:22','../Snapshots/201341785820736.png',2),('2222','Gourav','','microsoft',1,'98778837848','',1,0,3,0,6,5,NULL,'Raj','','2013-03-22 09:08:52','2013-03-22 09:13:08','../Snapshots/20133229846297.png',NULL),('7495849','Harish','','microsoft',2,'8898328','',0,0,1,0,6,0,NULL,'','','2013-03-24 23:27:42','2013-03-24 23:28:55','../../Content/images/default_person.jpg',2),('7899930','Harish','4th street','microsoft',2,'8898328','',0,0,1,0,5,0,NULL,'','','2013-03-24 23:25:20','2013-04-21 09:07:23','../../Content/images/default_person.jpg',2);

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
  CONSTRAINT `FK_visitors_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`),
  CONSTRAINT `FK_visitors_em` FOREIGN KEY (`eventid`) REFERENCES `eventmasterlist` (`eventid`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitors` */

insert  into `visitors`(`VisitorId`,`DeploymentId`,`NRIC`,`FirstName`,`MiddleName`,`LastName`,`Address`,`ContactNumber`,`CompanyName`,`IsBlacklisted`,`AddedDate`,`IsCheckInCheckOut`,`eventid`) values (1,1,'11111','Surya',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(2,1,'2222','Mory',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(3,1,'11111','satya',NULL,'sai',NULL,NULL,NULL,'\0','2013-03-19 00:00:00',NULL,2);

/*Table structure for table `visitortypes` */

DROP TABLE IF EXISTS `visitortypes`;

CREATE TABLE `visitortypes` (
  `VisitortypeId` int(10) unsigned NOT NULL auto_increment,
  `VisitorTypeDescription` varchar(45) NOT NULL default '',
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`VisitortypeId`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

/*Data for the table `visitortypes` */

insert  into `visitortypes`(`VisitortypeId`,`VisitorTypeDescription`,`AddedDate`) values (1,'VIP',NULL),(2,'Contractor',NULL),(3,'Supplier',NULL),(4,'Guest',NULL);

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
SELECT COUNT(*) INTO result FROM `gates` WHERE `GateName` = p_GateName;
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
	delete from `deployments` where `DeploymentId` = p_DeploymentId;
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

/*!50003 CREATE PROCEDURE `GetCompanies`()
BEGIN
	select `CompanyId`,`CompanyName`,`Address`,`ContactNumber`,`DeploymentId` from `sms`.`companies`;
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

/*!50003 CREATE PROCEDURE `GetEventMasterList`()
BEGIN
	select `eventid`,`startdate`,`enddate`,`locationid`,`numberofguards`,`specialdutyforguard`,`eventname`,`notes`,
	`optionalguestlist`,`personinchargename`,`personinchargenric`,`personinchargecontactnumber`, `DeploymentId`,`Remarks`
	from `eventmasterlist`;
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

/*!50003 CREATE PROCEDURE `GetGates`()
BEGIN
	select `GateId`,`DeploymentId`,`GateName`,`AddedDate` from `gates`;
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

/*!50003 CREATE PROCEDURE `GetIncidents`()
BEGIN
	select `incidentid`,`reportdate`,`natureofincident`,`dateofincident`,
	`locationid`,`particularsofpersons`,`briefdescription`,`remarksandactionstaken`, `snapshotpath`, `deploymentid`
	from `sms`.`incidents`;
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

/*!50003 CREATE PROCEDURE `GetKeys`()
BEGIN
	select `KeyId`,`KeyName`,`DeploymentId`,`Status`,`AddedDate` from `keys`;
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

/*!50003 CREATE PROCEDURE `GetLocations`()
BEGIN
	select `LocationId`,`DeploymentId`,`LocationName` from `locations`;
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

/*!50003 CREATE PROCEDURE `GetLostandfounds`()
BEGIN
	select `lostandfoundreportid`,`nameofperson`,`nric`,`reporteddate`,`remarks`,`deploymentid` from `sms`.`lostandfound`;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetOccuranceByID` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetOccuranceByID` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetOccuranceByID`(in p_occuranceid int)
BEGIN
	select `occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`
	from `sms`.`occurances` 
	where `occuranceid` = p_occuranceid;
END */$$
DELIMITER ;

/* Procedure structure for procedure `GetOccurances` */

/*!50003 DROP PROCEDURE IF EXISTS  `GetOccurances` */;

DELIMITER $$

/*!50003 CREATE PROCEDURE `GetOccurances`()
BEGIN
	select `occuranceid`,`serialnumber`,`reportdate`,`occurancetype`,`notes`,`important`,`heading`,`deploymentid`
	from `sms`.`occurances`;
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

/*!50003 CREATE PROCEDURE `GetPasses`()
BEGIN
	select `PassId`,`PassName`,`PassStatus`,`VisitortypeId`,`DeploymentId` from `sms`.`passes`;
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

/*!50003 CREATE PROCEDURE `GetUserdetails`()
BEGIN
	select `UID`,`DeploymentID`,`UserTypeID`,`LoginID`,`UserName`,`EmailID` from `userdetails`;
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

/*!50003 CREATE PROCEDURE `GetVehicles`( )
BEGIN
select 
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
    from `vehicles`;
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

/*!50003 CREATE PROCEDURE `GetVisitorCheckInOut`()
BEGIN
	select
	`nricid`,`name`,`address`,`fromcompany`,`tocompany`,`telno`,`persontovisit`,`eventid`,`temp`,
	`visitortype`,`keyid`,`passid`,`gateid`,`vehicleplatenumber`,`guardname`,`remarks`,`checkintime`,`checkouttime`,`snapshotpath`,`deploymentid`
	from
	 `visitorcheckinout`;
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
	WHERE `nricid` = p_nricid AND `eventid` = p_EventId;
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
