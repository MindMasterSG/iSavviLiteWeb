-- MySQL dump 10.13  Distrib 5.5.19, for Linux (x86_64)
--
-- Host: 182.50.133.52    Database: etracsms
-- ------------------------------------------------------
-- Server version	5.0.96-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `companies`
--

DROP TABLE IF EXISTS `companies`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `companies` (
  `CompanyId` int(10) unsigned NOT NULL auto_increment,
  `CompanyName` varchar(100) default NULL,
  `Address` varchar(500) default NULL,
  `ContactNumber` varchar(15) default NULL,
  `DeploymentId` int(10) default NULL,
  PRIMARY KEY  (`CompanyId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `companies`
--

LOCK TABLES `companies` WRITE;
/*!40000 ALTER TABLE `companies` DISABLE KEYS */;
INSERT INTO `companies` VALUES (1,'Info Technologies','Banglore 7678','4445566677',3),(2,'Keerti Technologies','Hyd','1323232',2),(3,'Microsoft','HYD','999998888',1),(4,'Company 5656','HYD','234566',2);
/*!40000 ALTER TABLE `companies` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deployments`
--

DROP TABLE IF EXISTS `deployments`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `deployments` (
  `DeploymentId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentName` varchar(100) NOT NULL,
  `Description` varchar(500) default NULL,
  `AddedDate` datetime default NULL,
  `ClientName` varchar(100) default NULL,
  `Address` varchar(200) default NULL,
  PRIMARY KEY  (`DeploymentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deployments`
--

LOCK TABLES `deployments` WRITE;
/*!40000 ALTER TABLE `deployments` DISABLE KEYS */;
INSERT INTO `deployments` VALUES (1,'Hyd Public',NULL,'2012-12-31 00:00:00','HYD Govt','Somajiguda HYD'),(2,'KV',NULL,'2013-01-28 00:00:00','K V','K V Gachibowli'),(3,'CB',NULL,'2013-01-29 00:00:00','INFY',NULL),(4,'CA',NULL,'2013-03-18 00:00:00','CA Technologies','Hyderbad'),(5,'TPTY',NULL,'2013-03-21 00:00:00','HDFC','T.K Road'),(6,'SKS',NULL,'2013-03-21 00:00:00',NULL,NULL),(7,'SING',NULL,'2013-03-21 00:00:00',NULL,NULL);
/*!40000 ALTER TABLE `deployments` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `eventmasterlist`
--

DROP TABLE IF EXISTS `eventmasterlist`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `eventmasterlist`
--

LOCK TABLES `eventmasterlist` WRITE;
/*!40000 ALTER TABLE `eventmasterlist` DISABLE KEYS */;
INSERT INTO `eventmasterlist` VALUES (1,'2013-02-24 00:00:00','2013-02-24 00:00:00',1,12,'5','Birth Day','sdasa','sda','999999','999999','234234',3,NULL),(2,'2013-08-01 13:35:00','2013-08-01 19:19:00',2,8,'3','Wedding','Birth day','afsda','99999','99999','33333',1,''),(3,'2013-04-01 10:00:00','2013-04-01 12:00:00',1,0,'','reception','','','','','989898998',1,'');
/*!40000 ALTER TABLE `eventmasterlist` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `gates`
--

DROP TABLE IF EXISTS `gates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `gates` (
  `GateId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `GateName` varchar(100) NOT NULL default '',
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`GateId`),
  KEY `FK_gates_1` (`DeploymentId`),
  CONSTRAINT `FK_gates_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `gates`
--

LOCK TABLES `gates` WRITE;
/*!40000 ALTER TABLE `gates` DISABLE KEYS */;
INSERT INTO `gates` VALUES (1,1,'Gate 444','2013-01-24 00:00:00'),(2,2,'Gate 88','2013-01-25 00:00:00'),(3,3,'Gate 100','2013-01-25 00:00:00'),(4,2,'Gate 786','2013-02-06 00:00:00'),(5,3,'G 007','2013-02-06 00:00:00'),(7,3,'G S 456','2013-02-06 00:00:00');
/*!40000 ALTER TABLE `gates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `incidents`
--

DROP TABLE IF EXISTS `incidents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `incidents`
--

LOCK TABLES `incidents` WRITE;
/*!40000 ALTER TABLE `incidents` DISABLE KEYS */;
INSERT INTO `incidents` VALUES (1,'2013-04-21 16:27:10','Stolen','2013-02-24 00:00:00',2,'qwerqwr','This incident','sdfasfsf','../Snapshots/2013421162718741.png',2),(3,'2013-03-21 09:15:57','car','2012-01-04 10:24:00',1,'id=\"incidentTime\"','','','../../Content/images/incident.jpg',NULL),(4,'2013-03-20 18:48:46','bike damaged','2013-01-01 09:30:00',1,'id=\"incidentTime\"','','','../../Content/images/incident.jpg',NULL),(7,'2013-03-21 09:29:33','car','2008-01-01 16:58:00',4,'har','','','../../Content/images/incident.jpg',NULL),(8,'2013-03-21 21:00:19','bus accident','2013-01-15 11:17:00',1,'hari','','','../../Content/images/incident.jpg',NULL),(9,'2013-03-22 07:37:48','theft','2013-04-20 16:19:00',1,'raj','','','../../Content/images/incident.jpg',NULL),(10,'2013-03-22 07:40:13','joy','2008-01-01 05:24:00',1,'j','','','../Snapshots/201332274031730.png',NULL);
/*!40000 ALTER TABLE `incidents` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keys`
--

DROP TABLE IF EXISTS `keys`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keys`
--

LOCK TABLES `keys` WRITE;
/*!40000 ALTER TABLE `keys` DISABLE KEYS */;
INSERT INTO `keys` VALUES (1,'Key-01',3,3,'2013-03-19 00:00:00'),(2,'New key',2,1,'2013-03-20 00:00:00');
/*!40000 ALTER TABLE `keys` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `keystatuses`
--

DROP TABLE IF EXISTS `keystatuses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `keystatuses` (
  `StatusID` int(3) unsigned NOT NULL auto_increment,
  `StatusType` varchar(30) default NULL,
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`StatusID`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `keystatuses`
--

LOCK TABLES `keystatuses` WRITE;
/*!40000 ALTER TABLE `keystatuses` DISABLE KEYS */;
INSERT INTO `keystatuses` VALUES (1,'Stolen','2013-03-19 00:00:00'),(2,'Broken','2013-03-19 00:00:00'),(3,'Working','2013-03-19 00:00:00');
/*!40000 ALTER TABLE `keystatuses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `locations`
--

DROP TABLE IF EXISTS `locations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locations` (
  `LocationId` int(10) unsigned NOT NULL auto_increment,
  `DeploymentId` int(10) unsigned NOT NULL,
  `LocationName` varchar(100) NOT NULL default '',
  PRIMARY KEY  (`LocationId`),
  KEY `FK_locations_1` (`DeploymentId`),
  CONSTRAINT `FK_locations_1` FOREIGN KEY (`DeploymentId`) REFERENCES `deployments` (`DeploymentId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `locations`
--

LOCK TABLES `locations` WRITE;
/*!40000 ALTER TABLE `locations` DISABLE KEYS */;
INSERT INTO `locations` VALUES (1,2,'Location 111'),(2,3,'Location 606'),(4,2,'Rajahmundry');
/*!40000 ALTER TABLE `locations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `lostandfound`
--

DROP TABLE IF EXISTS `lostandfound`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `lostandfound`
--

LOCK TABLES `lostandfound` WRITE;
/*!40000 ALTER TABLE `lostandfound` DISABLE KEYS */;
INSERT INTO `lostandfound` VALUES (1,'V Sriram','23456','2013-02-14 00:00:00','this is testing for eding',NULL),(2,'csr','12344','2013-03-02 00:00:00','water bottle stolen',NULL),(3,'Subbarao','12333','2003-10-09 00:00:00','he lost his head phones',NULL),(4,'csr','12322','2013-03-11 00:00:00','lkdjfsalkfjdlf',NULL);
/*!40000 ALTER TABLE `lostandfound` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `occurances`
--

DROP TABLE IF EXISTS `occurances`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `occurances`
--

LOCK TABLES `occurances` WRITE;
/*!40000 ALTER TABLE `occurances` DISABLE KEYS */;
INSERT INTO `occurances` VALUES (1,NULL,'2013-03-05 00:00:00',NULL,'231412343241',0,'First Occurance',NULL),(3,NULL,'2013-08-03 00:00:00',NULL,'Need to follow up',1,'GoodWork',NULL),(9,NULL,'2013-03-22 16:12:54',NULL,'major work happening in the day of holi and new year holidays.',1,'Adding another occurrence',2),(10,NULL,'2013-03-24 12:39:16',NULL,'Accident',1,'Very imp occurance',2),(12,NULL,'2013-04-17 09:08:06',NULL,'S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)',0,'Main occurrence',2),(13,NULL,'2013-04-17 22:13:18',NULL,'sfsfjsklfj,',1,'tjsdfh',2),(14,NULL,'2013-04-21 16:15:35',NULL,'S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)S/O KASMANI AND S/O REMY T.O.D FROM NITE SHIFT S/O DOLLAH WITH ALL ITEMS IN ORDER.(0805HR)',1,'TOD',2);
/*!40000 ALTER TABLE `occurances` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `passes`
--

DROP TABLE IF EXISTS `passes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `passes` (
  `PassId` int(10) unsigned NOT NULL auto_increment,
  `PassName` varchar(100) default NULL,
  `PassStatus` varchar(10) default NULL,
  `VisitortypeId` int(10) unsigned default NULL,
  `DeploymentId` int(10) default NULL,
  PRIMARY KEY  (`PassId`),
  KEY `FK_passes_visitortypes` (`VisitortypeId`),
  CONSTRAINT `FK_passes` FOREIGN KEY (`VisitortypeId`) REFERENCES `visitortypes` (`VisitortypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `passes`
--

LOCK TABLES `passes` WRITE;
/*!40000 ALTER TABLE `passes` DISABLE KEYS */;
INSERT INTO `passes` VALUES (5,'Test pass 123','1',2,3),(6,'pass 222','1',3,2);
/*!40000 ALTER TABLE `passes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdetails`
--

DROP TABLE IF EXISTS `userdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userdetails` (
  `UID` int(10) NOT NULL auto_increment,
  `DeploymentID` int(5) default NULL,
  `UserTypeID` int(5) NOT NULL,
  `LoginID` varchar(20) NOT NULL,
  `UserName` varchar(50) default NULL,
  `EmailID` varchar(100) default NULL,
  `Password` varchar(20) NOT NULL,
  PRIMARY KEY  (`UID`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdetails`
--

LOCK TABLES `userdetails` WRITE;
/*!40000 ALTER TABLE `userdetails` DISABLE KEYS */;
INSERT INTO `userdetails` VALUES (2,2,1,'admin','Satish Addanki','s@gmail.com','123'),(3,1,4,'guard1','vsr','v@hotmail.com','123'),(4,2,3,'seshu','seshu 123','s@rediffmail.com','123'),(5,3,1,'Ravi','Mahesh','m@gmail.com','123');
/*!40000 ALTER TABLE `userdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usertypes`
--

DROP TABLE IF EXISTS `usertypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usertypes` (
  `UserTypeId` int(10) unsigned NOT NULL auto_increment,
  `UserType` varchar(45) NOT NULL,
  `Description` varchar(500) default NULL,
  `CreatedDate` datetime default NULL,
  `Parent` varchar(45) default NULL,
  `level` int(10) unsigned default NULL,
  PRIMARY KEY  (`UserTypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usertypes`
--

LOCK TABLES `usertypes` WRITE;
/*!40000 ALTER TABLE `usertypes` DISABLE KEYS */;
INSERT INTO `usertypes` VALUES (1,'Super Admin',NULL,NULL,NULL,NULL),(2,'Admin',NULL,NULL,NULL,NULL),(3,'Supervisor',NULL,NULL,NULL,NULL),(4,'Guard',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `usertypes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vehicles`
--

DROP TABLE IF EXISTS `vehicles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vehicles`
--

LOCK TABLES `vehicles` WRITE;
/*!40000 ALTER TABLE `vehicles` DISABLE KEYS */;
INSERT INTO `vehicles` VALUES ('2342','24333','23423','dfasf','234267','vsr','20','Full','subbu','hjhjhy','Paddu',NULL,NULL);
/*!40000 ALTER TABLE `vehicles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitorcheckinout`
--

DROP TABLE IF EXISTS `visitorcheckinout`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitorcheckinout`
--

LOCK TABLES `visitorcheckinout` WRITE;
/*!40000 ALTER TABLE `visitorcheckinout` DISABLE KEYS */;
INSERT INTO `visitorcheckinout` VALUES ('11111','sairam','asdsad','Inno',1,'8878787878','',1,0,2,0,5,3,NULL,'Guru','','2013-03-19 12:09:53','2013-03-19 12:10:55','../../Content/images/default_person.jpg',NULL),('123','mr hari','San Diego','TCS',3,'878787878','Rai',0,0,1,0,5,0,NULL,'','','2013-04-17 09:04:12','2013-04-17 20:18:22','../Snapshots/201341785820736.png',2),('2222','Gourav','','microsoft',1,'98778837848','',1,0,3,0,6,5,NULL,'Raj','','2013-03-22 09:08:52','2013-03-22 09:13:08','../Snapshots/20133229846297.png',NULL),('7495849','Harish','','microsoft',2,'8898328','',0,0,1,0,6,0,NULL,'','','2013-03-24 23:27:42','2013-03-24 23:28:55','../../Content/images/default_person.jpg',2),('7899930','Harish','4th street','microsoft',2,'8898328','',0,0,1,0,5,0,NULL,'','','2013-03-24 23:25:20','2013-04-21 09:07:23','../../Content/images/default_person.jpg',2);
/*!40000 ALTER TABLE `visitorcheckinout` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitors`
--

DROP TABLE IF EXISTS `visitors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
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
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitors`
--

LOCK TABLES `visitors` WRITE;
/*!40000 ALTER TABLE `visitors` DISABLE KEYS */;
INSERT INTO `visitors` VALUES (1,1,'11111','Surya',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(2,1,'2222','Mory',NULL,'D S',NULL,NULL,NULL,'\0','2013-03-18 00:00:00',NULL,1),(3,1,'11111','satya',NULL,'sai',NULL,NULL,NULL,'\0','2013-03-19 00:00:00',NULL,2);
/*!40000 ALTER TABLE `visitors` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `visitortypes`
--

DROP TABLE IF EXISTS `visitortypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `visitortypes` (
  `VisitortypeId` int(10) unsigned NOT NULL auto_increment,
  `VisitorTypeDescription` varchar(45) NOT NULL default '',
  `AddedDate` datetime default NULL,
  PRIMARY KEY  (`VisitortypeId`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `visitortypes`
--

LOCK TABLES `visitortypes` WRITE;
/*!40000 ALTER TABLE `visitortypes` DISABLE KEYS */;
INSERT INTO `visitortypes` VALUES (1,'VIP',NULL),(2,'Contractor',NULL),(3,'Supplier',NULL),(4,'Guest',NULL);
/*!40000 ALTER TABLE `visitortypes` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2013-04-28 10:38:53
