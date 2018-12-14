
--
-- Current Database: `sotaapi`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `sotaapi` /*!40100 DEFAULT CHARACTER SET utf8 */;

USE `sotaapi`;

--
-- Table structure for table `alterations`
--

DROP TABLE IF EXISTS `alterations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alterations` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Submitter` bigint(20) NOT NULL,
  `SceneName` bigint(20) NOT NULL,
  `Monster` bigint(20) NOT NULL,
  `Category` varchar(200) NOT NULL,
  `NewValue` varchar(8000) DEFAULT NULL,
  `Status` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `idx_Alterations_Submitter` (`Submitter`),
  KEY `idx_Alterations_SceneName_Monster` (`SceneName`,`Monster`)
) ENGINE=InnoDB AUTO_INCREMENT=134 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `alterationsitems`
--

DROP TABLE IF EXISTS `alterationsitems`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `alterationsitems` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Archetype` bigint(20) DEFAULT NULL,
  `Submitter` bigint(20) DEFAULT NULL,
  `Category` varchar(200) DEFAULT NULL,
  `NewValue` varchar(200) DEFAULT NULL,
  `Status` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `archetypes`
--

DROP TABLE IF EXISTS `archetypes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `archetypes` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Archetype` varchar(200) DEFAULT NULL,
  `DisplayName` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_Archetypes_Archetype` (`Archetype`)
) ENGINE=InnoDB AUTO_INCREMENT=9839 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailyarchetypetotals`
--

DROP TABLE IF EXISTS `dailyarchetypetotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailyarchetypetotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Archetype` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_DailyArchetypeTotals_timestamp_Archetype` (`date`,`Archetype`),
  KEY `idx_DailyArchetypeTotals_timestamp_LocationEvent_Archetype` (`date`,`LocationEvent`,`Archetype`),
  KEY `idx_DailyArchetypeTotals_timestamp` (`date`,`SceneName`),
  KEY `idx_DailyArchetypeTotals_Archetype` (`Archetype`),
  KEY `idx_DailyArchetypeTotals_B` (`Archetype`,`date`,`SceneName`,`LocationEvent`),
  KEY `idx_DailyArchetypeTotals_SceneName_LocationEvent_timestamp` (`SceneName`,`LocationEvent`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=27270161 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailycraftingtotals`
--

DROP TABLE IF EXISTS `dailycraftingtotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailycraftingtotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Archetype` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_DailyCraftingTotals_date_Archetype` (`date`,`Archetype`),
  KEY `idx_DailyCraftingTotals_date_LocationEvent_Archetype` (`date`,`LocationEvent`,`Archetype`),
  KEY `idx_DailyCraftingTotals_Archetype` (`Archetype`,`LocationEvent`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=6056158 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dailykillstotals`
--

DROP TABLE IF EXISTS `dailykillstotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dailykillstotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `date` date DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Victim` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_DailyKillsTotals_date_LocationEvent_Victim` (`LocationEvent`,`SceneName`,`date`),
  KEY `idx_DailyKillsTotals_date` (`SceneName`,`date`),
  KEY `idx_DailyKillsTotals_Victim` (`Victim`,`date`)
) ENGINE=InnoDB AUTO_INCREMENT=1923014 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `dataloader`
--

DROP TABLE IF EXISTS `dataloader`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `dataloader` (
  `ID` varbinary(50) DEFAULT NULL,
  `ypos` decimal(7,3) DEFAULT NULL,
  `zpos` decimal(7,3) DEFAULT NULL,
  `xpos` decimal(7,3) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `SceneName` varchar(100) DEFAULT NULL,
  `LocationEvent` varchar(100) DEFAULT NULL,
  `PlayerName` varchar(50) DEFAULT NULL,
  `Killer` varchar(50) DEFAULT NULL,
  `Victim` varchar(50) DEFAULT NULL,
  `ItemID` varbinary(50) DEFAULT NULL,
  `Archetype` varchar(100) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  `PricePerUnit` decimal(10,0) DEFAULT NULL,
  `Price` decimal(10,0) DEFAULT NULL,
  KEY `idxIDcrap` (`ID`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `errors`
--

DROP TABLE IF EXISTS `errors`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `errors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `source` varchar(100) DEFAULT NULL,
  `errorFile` varchar(200) DEFAULT NULL,
  `errorNo` int(11) DEFAULT NULL,
  `error` varchar(8000) DEFAULT NULL,
  `timestamp` timestamp NULL DEFAULT NULL,
  `errorLine` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=550246 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hourlyarchetypetotals`
--

DROP TABLE IF EXISTS `hourlyarchetypetotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hourlyarchetypetotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Archetype` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  `x` smallint(6) DEFAULT NULL,
  `y` smallint(6) DEFAULT NULL,
  `z` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_HourlyArchetypeTotals_timestamp_Archetype` (`timestamp`,`Archetype`),
  KEY `idx_HourlyArchetypeTotals_timestamp_LocationEvent_Archetype` (`timestamp`,`LocationEvent`,`Archetype`),
  KEY `idx_HourlyArchetypeTotals_timestamp` (`timestamp`,`SceneName`),
  KEY `idx_HourlyArchetypeTotals_Archetype` (`Archetype`),
  KEY `idx_HourlyArchetypeTotals_B` (`Archetype`,`timestamp`,`SceneName`,`LocationEvent`,`x`,`y`,`z`),
  KEY `idx_HourlyArchetypeTotals_SceneName_LocationEvent_timestamp` (`SceneName`,`LocationEvent`,`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=254275281 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hourlycraftingtotals`
--

DROP TABLE IF EXISTS `hourlycraftingtotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hourlycraftingtotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Archetype` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  `x` smallint(6) DEFAULT NULL,
  `y` smallint(6) DEFAULT NULL,
  `z` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_HourlyCraftingTotals_timestamp_Archetype` (`timestamp`,`Archetype`),
  KEY `idx_HourlyCraftingTotals_timestamp_LocationEvent_Archetype` (`timestamp`,`LocationEvent`,`Archetype`),
  KEY `idx_HourlyCraftingTotals_timestamp` (`timestamp`),
  KEY `idx_HourlyCraftingTotals_Archetype` (`Archetype`)
) ENGINE=InnoDB AUTO_INCREMENT=19884233 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hourlykillstotals`
--

DROP TABLE IF EXISTS `hourlykillstotals`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hourlykillstotals` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `timestamp` datetime DEFAULT NULL,
  `LocationEvent` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Victim` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `x` smallint(6) DEFAULT NULL,
  `y` smallint(6) DEFAULT NULL,
  `z` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_HourlyKillsTotals_timestamp_Victim` (`timestamp`,`Victim`),
  KEY `idx_HourlyKillsTotals_timestamp_LocationEvent_Victim` (`timestamp`,`LocationEvent`,`Victim`),
  KEY `idx_HourlyKillsTotals_timestamp` (`SceneName`,`timestamp`),
  KEY `idx_HourlyKillsTotals_Victim` (`Victim`),
  KEY `idx_HourlyKillsTotals_B` (`Victim`,`SceneName`,`timestamp`,`LocationEvent`,`x`,`y`,`z`)
) ENGINE=InnoDB AUTO_INCREMENT=43620051 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `hourlytimetable`
--

DROP TABLE IF EXISTS `hourlytimetable`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `hourlytimetable` (
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`timestamp`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `importtest`
--

DROP TABLE IF EXISTS `importtest`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `importtest` (
  `id` int(11) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `SceneName` varchar(100) DEFAULT NULL,
  `orientation` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `itemids`
--

DROP TABLE IF EXISTS `itemids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `itemids` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `ItemID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_ItemIDs_ItemID` (`ItemID`)
) ENGINE=InnoDB AUTO_INCREMENT=294048213 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lastupdated`
--

DROP TABLE IF EXISTS `lastupdated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lastupdated` (
  `TableName` varchar(80) NOT NULL,
  `LastUpdated` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `localizationmonsternames`
--

DROP TABLE IF EXISTS `localizationmonsternames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `localizationmonsternames` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `EnglishName` bigint(20) DEFAULT NULL,
  `ForeignName` bigint(20) DEFAULT NULL,
  `Lang` char(2) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_LocalizationMonsterNames_EnglishName` (`EnglishName`),
  KEY `idx_LocalizationMonsterNames_ForeignName` (`ForeignName`),
  KEY `idx_LocalizationMonsterNames_Lang` (`Lang`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `locationevents`
--

DROP TABLE IF EXISTS `locationevents`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `locationevents` (
  `ID` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `LocationEvent` varchar(100) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_LocationEvents_LocationEvent` (`LocationEvent`)
) ENGINE=InnoDB AUTO_INCREMENT=79 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logevent`
--

DROP TABLE IF EXISTS `logevent`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logevent` (
  `ID` bigint(20) NOT NULL,
  `ypos` decimal(7,3) DEFAULT NULL,
  `zpos` decimal(7,3) DEFAULT NULL,
  `xpos` decimal(7,3) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `SceneName` smallint(6) unsigned DEFAULT NULL,
  `LocationEvent` smallint(6) unsigned DEFAULT NULL,
  `PlayerName` int(11) DEFAULT NULL,
  `Killer` int(11) DEFAULT NULL,
  `Victim` int(11) DEFAULT NULL,
  `ItemID` bigint(20) DEFAULT NULL,
  `Archetype` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `EconomyGoldDelta` int(11) DEFAULT NULL,
  `PricePerUnit` decimal(14,3) DEFAULT NULL,
  `Price` decimal(14,3) DEFAULT NULL,
  `x` smallint(6) DEFAULT NULL,
  `y` smallint(6) DEFAULT NULL,
  `z` smallint(6) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_LogEvent_SceneName_LocationEvent_timestamp` (`SceneName`,`LocationEvent`,`timestamp`),
  KEY `idx_LogEvent_PlayerName` (`PlayerName`,`SceneName`),
  KEY `idx_LogEvent_ItemID` (`ItemID`,`SceneName`),
  KEY `idx_LogEvent_SceneNameXYZ` (`SceneName`,`x`,`y`,`z`,`LocationEvent`),
  KEY `idx_LogEvent_Archetype` (`Archetype`,`SceneName`),
  KEY `idx_LogEvent_Killer_SceneName_timestamp` (`Killer`,`timestamp`,`SceneName`),
  KEY `idx_LogEvent_Victim_SceneName_timestamp` (`Victim`,`timestamp`,`SceneName`),
  KEY `idx_LogEvent_timestamp_SceneName` (`timestamp`,`SceneName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 DATA DIRECTORY='F:/MySQL/Data/';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `logids`
--

DROP TABLE IF EXISTS `logids`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `logids` (
  `ID` bigint(20) NOT NULL AUTO_INCREMENT,
  `LogID` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_LogIDs_LogID` (`LogID`)
) ENGINE=InnoDB AUTO_INCREMENT=922824690 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `lootprocess`
--

DROP TABLE IF EXISTS `lootprocess`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `lootprocess` (
  `id` bigint(20) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `loottables`
--

DROP TABLE IF EXISTS `loottables`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `loottables` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `Archetype` int(11) DEFAULT NULL,
  `Name` int(11) DEFAULT NULL,
  `SceneName` int(11) DEFAULT NULL,
  `Quantity` int(11) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `KillID` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_LootTables_Archetype_timestamp` (`Archetype`,`timestamp`),
  KEY `idx_LootTables_SceneName_Name_timestamp` (`SceneName`,`Name`,`timestamp`),
  KEY `idx_LootTables_Name_SceneName_timestamp` (`Name`,`SceneName`,`timestamp`),
  KEY `idx_LootTables_Archetype_Name_SceneName` (`Archetype`,`Name`,`SceneName`)
) ENGINE=InnoDB AUTO_INCREMENT=73108609 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `mapcheck`
--

DROP TABLE IF EXISTS `mapcheck`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `mapcheck` (
  `SceneName` varchar(50) DEFAULT NULL,
  `made` tinyint(1) DEFAULT NULL,
  `MapName` varchar(45) DEFAULT NULL,
  `Orientation` int(11) DEFAULT NULL,
  `mapWidth` int(11) DEFAULT NULL,
  `mapHeight` int(11) DEFAULT NULL,
  `mapXOffset` int(11) DEFAULT NULL,
  `mapYOffset` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `monsterinfo`
--

DROP TABLE IF EXISTS `monsterinfo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `monsterinfo` (
  `NameID` bigint(20) NOT NULL,
  `SceneName` bigint(20) NOT NULL DEFAULT '0',
  `Hitpoints` int(11) NOT NULL DEFAULT '0',
  `Focus` int(11) NOT NULL DEFAULT '0',
  `Experience` int(11) NOT NULL DEFAULT '0',
  `Weakness` bigint(20) NOT NULL DEFAULT '0',
  `Resistance` bigint(20) NOT NULL DEFAULT '0',
  `TamingLevel` int(11) NOT NULL DEFAULT '0',
  `Skinnable` tinyint(1) NOT NULL DEFAULT '0',
  `Notes` varchar(2000) NOT NULL DEFAULT '',
  PRIMARY KEY (`NameID`,`SceneName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `names`
--

DROP TABLE IF EXISTS `names`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `names` (
  `ID` int(11) NOT NULL AUTO_INCREMENT,
  `Name` varchar(100) NOT NULL,
  `Type` int(11) DEFAULT NULL,
  `Localized` tinyint(4) NOT NULL DEFAULT '0',
  PRIMARY KEY (`ID`),
  KEY `idx_Names_Name` (`Name`)
) ENGINE=InnoDB AUTO_INCREMENT=11755 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `releases`
--

DROP TABLE IF EXISTS `releases`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `releases` (
  `id` bigint(20) NOT NULL,
  `starttime` datetime DEFAULT NULL,
  `endtime` datetime DEFAULT NULL,
  `ReleaseNotes` varchar(1000) DEFAULT NULL,
  `Notes` varchar(2000) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenelastupdated`
--

DROP TABLE IF EXISTS `scenelastupdated`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenelastupdated` (
  `SceneName` varchar(80) NOT NULL,
  `LastUpdated` datetime NOT NULL,
  `LastPolled` timestamp NULL DEFAULT NULL,
  `LastCountUpdated` int(11) DEFAULT NULL,
  `UpdatePeriod` int(11) DEFAULT NULL,
  PRIMARY KEY (`SceneName`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `scenenames`
--

DROP TABLE IF EXISTS `scenenames`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `scenenames` (
  `ID` smallint(6) unsigned NOT NULL AUTO_INCREMENT,
  `SceneName` varchar(100) DEFAULT NULL,
  `DisplayName` varchar(100) DEFAULT NULL,
  `made` tinyint(1) DEFAULT NULL,
  `Orientation` int(11) DEFAULT NULL,
  `mapWidth` int(11) DEFAULT NULL,
  `mapHeight` int(11) DEFAULT NULL,
  `mapXOffset` int(11) DEFAULT NULL,
  `mapYOffset` int(11) DEFAULT NULL,
  PRIMARY KEY (`ID`),
  KEY `idx_SceneNames_SceneName` (`SceneName`)
) ENGINE=InnoDB AUTO_INCREMENT=456 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `siteloaddata`
--

DROP TABLE IF EXISTS `siteloaddata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `siteloaddata` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `ip` char(20) DEFAULT NULL,
  `page` varchar(2000) DEFAULT NULL,
  `args` varchar(2000) DEFAULT NULL,
  `starttime` timestamp NULL DEFAULT NULL,
  `endtime` timestamp NULL DEFAULT NULL,
  `totalSecs` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_SiteLoadData_ip` (`ip`),
  KEY `idx_SiteLoadData_page` (`page`(255)),
  KEY `idx_SiteLoadData_totalSecs` (`totalSecs`)
) ENGINE=InnoDB AUTO_INCREMENT=23828 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `snigol`
--

DROP TABLE IF EXISTS `snigol`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snigol` (
  `Series` char(128) NOT NULL,
  `Token` char(128) DEFAULT NULL,
  `LastUsed` timestamp NULL DEFAULT NULL,
  `SetTime` timestamp NULL DEFAULT NULL,
  `Name` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`Series`),
  UNIQUE KEY `Series_UNIQUE` (`Series`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `snigol_attempts`
--

DROP TABLE IF EXISTS `snigol_attempts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `snigol_attempts` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `IP` varchar(20) DEFAULT NULL,
  `characterName` varchar(45) DEFAULT NULL,
  `x` decimal(7,3) DEFAULT NULL,
  `y` decimal(7,3) DEFAULT NULL,
  `z` decimal(7,3) DEFAULT NULL,
  `SceneName` varchar(200) DEFAULT NULL,
  `SceneDisplayName` varchar(200) DEFAULT NULL,
  `entrytime` timestamp NULL DEFAULT NULL,
  `Successful` tinyint(4) DEFAULT NULL,
  `count` tinyint(4) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_Snigol_Attempts_IP` (`IP`),
  KEY `idx_Snigol_Attempts_characterName` (`characterName`),
  KEY `idx_Snigol_Attempts_SceneName` (`SceneName`)
) ENGINE=InnoDB AUTO_INCREMENT=288 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sotastats_logs`
--

DROP TABLE IF EXISTS `sotastats_logs`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sotastats_logs` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `application` varchar(100) DEFAULT NULL,
  `log` varchar(2000) DEFAULT NULL,
  `logtime` datetime DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=389 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `sotastatsloadbalancer`
--

DROP TABLE IF EXISTS `sotastatsloadbalancer`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sotastatsloadbalancer` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `QueryString` varchar(8000) DEFAULT NULL,
  `InsertTime` datetime DEFAULT NULL,
  `QueryAmount` bigint(20) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `idx_SotaSTATSLoadBalancer_QueryString` (`QueryString`(255))
) ENGINE=InnoDB AUTO_INCREMENT=1799355 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `stuckused`
--

DROP TABLE IF EXISTS `stuckused`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `stuckused` (
  `ypos` decimal(10,0) DEFAULT NULL,
  `zpos` decimal(10,0) DEFAULT NULL,
  `xpos` decimal(10,0) DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `SceneName` varchar(50) DEFAULT NULL,
  `PlayerName` varchar(50) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `usersettings`
--

DROP TABLE IF EXISTS `usersettings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `usersettings` (
  `id` bigint(20) NOT NULL AUTO_INCREMENT,
  `User` bigint(20) DEFAULT NULL,
  `Setting` varchar(200) DEFAULT NULL,
  `Value` varchar(200) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8;
/*!40101 SET character_set_client = @saved_cs_client */;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
