
USE `sotaapi`;

--
-- Dumping routines for database 'sotaapi'
--
/*!50003 DROP FUNCTION IF EXISTS `findItem` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` FUNCTION `findItem`( inName varchar(200)) RETURNS bigint(20)
BEGIN
	declare varArchetype bigint;
    declare Result bigint;
	Select id from Archetypes where DisplayName = inName into varArchetype;
		
	RETURN varArchetype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `findName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` FUNCTION `findName`( inName varchar(200)) RETURNS bigint(20)
BEGIN
	declare varMonsterName bigint;
    declare varLocalized tinyint;
    declare Result bigint;
	Select id, Localized from Names where Name = inName into varMonsterName, varLocalized;
    
	if ( varLocalized = 1 ) THEN
    BEGIN
		Select EnglishName from LocalizationMonsterNames L
		where ForeignName = varMonsterName into varMonsterName;
    END;
    END IF;
		
	RETURN varMonsterName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP FUNCTION IF EXISTS `findScene` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` FUNCTION `findScene`(inScene varchar(200) ) RETURNS bigint(20)
BEGIN
declare varSceneName bigint;
select id from SceneNames where DisplayName = inScene into varSceneName;
RETURN varSceneName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkLoadBalancer` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `checkLoadBalancer`()
proc:BEGIN

declare varCurrentCount int;
declare varTimeWait int;
declare varCurrentAmount int;
declare varAmountTime int;
select count(id) from SotaSTATSLoadBalancer where InsertTime >= (now() - INTERVAL 1 MINUTE) into varCurrentCount;
 
 if (varCurrentCount >= 8 ) THEN
	BEGIN
		select timestampdiff(SECOND,now(),waittime + INTERVAL 1 MINUTE) from (select min(InsertTime) as waittime from (select InsertTime from SotaSTATSLoadBalancer order by id desc limit 10) as B)  as A into varTimeWait;
        select varTimeWait;
        leave proc;
	END;
 END IF;
 
 select sum(case when QueryAmount = 0 then 4000000 else QueryAmount end) from SotaSTATSLoadBalancer where InsertTime>= (now() - INTERVAL 10 MINUTE) into varCurrentAmount;
 if (varCurrentAmount >= 16500000 ) THEN
	BEGIN 
		SET varAmountTime = 600;
		while ( varCurrentAmount >= 16500000 ) DO 
			BEGIN
				SET varAmountTime = varAmountTime - 5;
                select sum(case when QueryAmount = 0 then 4000000 else QueryAmount end) from SotaSTATSLoadBalancer where InsertTime>= (now() - INTERVAL varAmountTime SECOND) into varCurrentAmount;
			END;
        END WHILE;
        set varTimeWait = 600 - varAmountTime;
		select varTimeWait;
        leave proc;
    END;
END IF;
 
select 0 as varTimeWait;	
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `checkMapBackgroundMade` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `checkMapBackgroundMade`( inMap varchar(200))
BEGIN
	select made from SceneNames where DisplayName = inMap;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fsGetArchetypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `fsGetArchetypes`( inName varchar(200) )
BEGIN
	select Archetype as value, DisplayName as label from Archetypes where Archetype is not null and DisplayName like CONCAT('%',inName,'%') limit 100;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fsGetEventTypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `fsGetEventTypes`( inName varchar(200) )
BEGIN
	select LocationEvent as value, DisplayName as label from LocationEvents where DisplayName like CONCAT('%',inName,'%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fsGetMonsterNames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `fsGetMonsterNames`( inName varchar(200) )
BEGIN
	select Name as value, Name as label from Names where Name is not null and Name like CONCAT('%',inName,'%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `fsGetSceneNames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `fsGetSceneNames`( inName varchar(200) )
BEGIN
	select SceneName as value, DisplayName as label from SceneNames where DisplayName is not null and DisplayName like CONCAT('%',inName,'%') order by DisplayName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generateMap` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `generateMap`(inMap varchar(200))
BEGIN
	declare varXRadius int;
    declare varZRadius int;
    declare varWidth int;
    declare varHeight int;
    declare varZMin int;
    declare varXMin int;
    declare varXOffset int;
    declare varYOffset int;
    

    
	CREATE TEMPORARY TABLE IF NOT EXISTS mapData AS (
	select x as x, Count(x) as CountX,  z as z from LogEvent L 
	join SceneNames S 
	on L.SceneName = S.ID 
    where S.DisplayName =  inMap and L.x is not null and L.z is not null group by L.x,L.z);
    
    set varXRadius = 0;
    set varZRadius = 0;
    
    select min(z), min(x) from mapData into varZMin, varXMin;
    
    
     update mapData
     set z = z - varZMin, x = x-varXMin;
    
    select max(z), max(x) from mapData into varZRadius, varXRadius;
    
    
     update mapData
     set z = z + 25, x = (varXRadius - x) + 25;

    
    update SceneNames
    set made = true, mapWidth = varZRadius + 75, mapHeight = varXRadius + 75, mapXoffset = varZMin, mapYoffset = varXMin where DisplayName = inMap;
    
    
    select z as '0', CountX as '2',  x as '1' from mapData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `generateOverlay` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `generateOverlay`(
inMap varchar(200),
inArchetype varchar(200),
inVictim varchar(200)
)
BEGIN
	declare varXRadius int;
    declare varZRadius int;
    declare varXMin int;
    declare varZMin int;
    
    select SceneName from SceneNames S where DisplayName = inMap into inMap;
    
	CREATE TEMPORARY TABLE IF NOT EXISTS mapData AS (
	select x as x, Count(x) as CountX,  z as z from LogEvent L 
	join SceneNames S 
	on L.SceneName = S.ID
    left join Archetypes A 
    on L.Archetype = A.ID
    left join Names V
    on L.Victim = V.ID
    where S.SceneName =  inMap and L.x is not null 
    and ( inArchetype is null OR A.Archetype like concat('%',inArchetype,'%') )
    and ( inVictim is null OR V.Name like concat('%',inVictim,'%') )
    and L.timestamp > now() - INTERVAL 24 HOUR
    group by L.x,L.z);
    
    select mapWidth-75, mapHeight-75, mapXoffset, mapYoffset from SceneNames where SceneName = inMap into varZRadius, varXRadius, varZMin, varXMin;
    
    
    
     update mapData
     set z = z - varZMin, x = x-varXMin;

    
     update mapData
     set z = z + 25, x = (varXRadius - x) + 25;


    
    select z as '0', CountX as '2',  x as '1' from mapData;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getCodexOverlay` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `getCodexOverlay`(
inStartTimestamp datetime,
inEndTimestamp datetime,
inSceneName varchar(100),
inKiller varchar(100),
inVictim varchar(100),
inPlayerName varchar(100),
inArchetype varchar(100),
inItemID varchar(100),
inLocationEvent varchar(100)
)
BEGIN

   declare varXRadius int;
    declare varZRadius int;
    declare varXMin int;
    declare varZMin int;
    
    
    
    CREATE TEMPORARY TABLE IF NOT EXISTS mapData AS (
	select x as x, Count(x) as CountX,  z as z from (Select L.x, L.z
	from LogEvent L
	left join SceneNames S 
	on L.SceneName = S.ID
    left join LocationEvents LE
    on L.LocationEvent = LE.ID
    left join Archetypes A 
    on L.Archetype = A.ID
    left join Names P
    on L.PlayerName = P.ID
    left join Names K
    on L.Killer = K.ID
    left join Names V
    on L.Victim = V.ID
    left join ItemIDs I
    on L.ItemID = I.ID
    where (inStartTimestamp is NULL or L.timestamp >= inStartTimestamp)
    AND (inEndTimestamp is NULL or L.timestamp <= inEndTimestamp)
    AND (inSceneName is NULL or S.DisplayName = inSceneName)
    and (inKiller is NULL or K.Name = inKiller)
    and (inVictim is NULL or V.Name = inVictim)
    and (inPlayerName is NULL or P.name = inPlayerName)
    and (inArchetype is NULL or A.DisplayName = inArchetype)
    and (inItemID is NULL or I.ItemId = inItemID)
    and (inLocationEvent is NULL or LE.DisplayName = inLocationEvent) 
    and L.x is not null 
    limit 25000) as L
    group by L.x,L.z);
    
     select mapWidth-75, mapHeight-75, mapXoffset, mapYoffset from SceneNames where DisplayName = inSceneName into varZRadius, varXRadius, varZMin, varXMin;
    
    
    
     update mapData
     set z = z - varZMin, x = x-varXMin;

    
     update mapData
     set z = z + 25, x = (varXRadius - x) + 25;


    
    select z as '0', CountX as '2',  x as '1' from mapData  limit 1000;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getMapWidthHeight` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `getMapWidthHeight`(inMap varchar(200))
BEGIN

select mapWidth as width, mapHeight as height from SceneNames where DisplayName = inMap;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getRandomCodex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `getRandomCodex`(inLoggedIn tinyint)
BEGIN
    declare varTargetID bigint;
    declare varMinID bigint;
    declare varMaxID bigint;
    select max(ID), min(ID) from LogEvent into varMaxID, varMinID;
    
    
    set varTargetID = ((varMaxID - varMinID) * RAND() ) + varMinID;
    
    set varMinID = varTargetID - 10, varMaxID = varTargetID + 10;
    
    if ( inLoggedIn = 1 ) then
		BEGIN
			set varMinID = varTargetID - 100, varMaxID = varTargetID + 100;
		END;
    END IF;
    
	select timestamp as Timestamp, S.DisplayName as Scene, LE.LocationEvent as EventType, 
    P.Name as PlayerName, K.Name as Killer, V.Name as Victim, I.ItemID as ItemID, 
    A.DisplayName as Archetype, Quantity, EconomyGoldDelta, PricePerUnit, Price, x, y, z
    from LogEvent L
	left join SceneNames S 
	on L.SceneName = S.ID
    left join LocationEvents LE
    on L.LocationEvent = LE.ID
    left join Archetypes A 
    on L.Archetype = A.ID
    left join Names P
    on L.PlayerName = P.ID
    left join Names K
    on L.Killer = K.ID
    left join Names V
    on L.Victim = V.ID
    left join ItemIDs I
    on L.ItemID = I.ID
    where L.ID > varMinID AND L.ID < varMaxID;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSceneDisplayName` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `getSceneDisplayName`(inSceneName varchar(200) )
BEGIN
	select DisplayName from SceneNames where SceneName = inSceneName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `getSpecificCodex` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `getSpecificCodex`(
inStartTimestamp datetime,
inEndTimestamp datetime,
inSceneName varchar(100),
inKiller varchar(100),
inVictim varchar(100),
inPlayerName varchar(100),
inArchetype varchar(100),
inItemID varchar(100),
inLocationEvent varchar(100),
inLoggedIn tinyint
)
BEGIN
    declare varTargetID bigint;
    declare varMinID bigint;
    declare varMaxID bigint;
    select max(ID), min(ID) from LogEvent into varMaxID, varMinID;
    set varTargetID = ((varMaxID - varMinID) * RAND() ) + varMinID;
    
    set varMinID = varTargetID - 10, varMaxID = varTargetID + 10;
    
    if ( inLoggedIn = 1 ) then
		BEGIN
			select timestamp as Timestamp, S.DisplayName as Scene, LE.DisplayName as EventType, 
			P.Name as PlayerName, K.Name as Killer, V.Name as Victim, I.ItemID as ItemID, 
			A.DisplayName as Archetype, Quantity, EconomyGoldDelta, PricePerUnit, Price, x, y, z
			from LogEvent L
			left join SceneNames S 
			on L.SceneName = S.ID
			left join LocationEvents LE
			on L.LocationEvent = LE.ID
			left join Archetypes A 
			on L.Archetype = A.ID
			left join Names P
			on L.PlayerName = P.ID
			left join Names K
			on L.Killer = K.ID
			left join Names V
			on L.Victim = V.ID
			left join ItemIDs I
			on L.ItemID = I.ID
			where (inStartTimestamp is NULL or L.timestamp >= inStartTimestamp)
			AND (inEndTimestamp is NULL or L.timestamp <= inEndTimestamp)
			AND (inSceneName is NULL or S.DisplayName = inSceneName)
			and (inKiller is NULL or K.Name = inKiller)
			and (inVictim is NULL or V.Name = inVictim)
			and (inPlayerName is NULL or P.name = inPlayerName)
			and (inArchetype is NULL or A.DisplayName = inArchetype)
			and (inItemID is NULL or I.ItemId = inItemID)
			and (inLocationEvent is NULL or LE.DisplayName = inLocationEvent)
			limit 200;
		END;
    ELSE
		BEGIN
        select timestamp as Timestamp, S.DisplayName as Scene, LE.DisplayName as EventType, 
			P.Name as PlayerName, K.Name as Killer, V.Name as Victim, I.ItemID as ItemID, 
			A.DisplayName as Archetype, Quantity, EconomyGoldDelta, PricePerUnit, Price, x, y, z
			from LogEvent L
			left join SceneNames S 
			on L.SceneName = S.ID
			left join LocationEvents LE
			on L.LocationEvent = LE.ID
			left join Archetypes A 
			on L.Archetype = A.ID
			left join Names P
			on L.PlayerName = P.ID
			left join Names K
			on L.Killer = K.ID
			left join Names V
			on L.Victim = V.ID
			left join ItemIDs I
			on L.ItemID = I.ID
			where (inStartTimestamp is NULL or L.timestamp >= inStartTimestamp)
			AND (inEndTimestamp is NULL or L.timestamp <= inEndTimestamp)
			AND (inSceneName is NULL or S.DisplayName = inSceneName)
			and (inKiller is NULL or K.Name = inKiller)
			and (inVictim is NULL or V.Name = inVictim)
			and (inPlayerName is NULL or P.name = inPlayerName)
			and (inArchetype is NULL or A.DisplayName = inArchetype)
			and (inItemID is NULL or I.ItemId = inItemID)
			and (inLocationEvent is NULL or LE.DisplayName = inLocationEvent)
			limit 20;
		END;
    END IF;
    
    
	
    
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_entry` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `log_entry`(
applicationIN varchar(100),
logEntryIN varchar(2000)
)
BEGIN
insert into SOTASTATS_LOGS (id,application,log,logtime)
values (null,applicationIN,logEntryIN,now());
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `log_error` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`umuri`@`192.168.%.%` PROCEDURE `log_error`(inSource varchar(100), inError varchar(8000), inErrorNo int, inErrorFile varchar(200), inErrorLine int)
BEGIN
	insert into errors (id, source, error, timestamp, errorNo, errorFile, errorLine)
	values (id, inSource, inError, now(), inErrorNo, inErrorFile, inErrorLine);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `newLoadBalancerQuery` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `newLoadBalancerQuery`( inQueryString varchar(8000) )
BEGIN
insert into SotaSTATSLoadBalancer(id, QueryString, InsertTime, QueryAmount)
values (NULL, inQueryString, now(), -1);

select max(id) as id from SotaSTATSLoadBalancer;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `processOld` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `processOld`(inNumber int)
TheThing:BEGIN
 
 
 
declare inID varBinary(50);
declare varX smallint;
declare varY smallint;
declare varZ smallint;
declare intimestamp datetime;
declare inSceneName varchar(100);
declare inLocationEvent varchar(100);
declare inPlayerName varchar(50);
declare inKiller varchar(50);
declare inVictim varchar(50);
declare inItemID varbinary(50);
declare inArchetype varchar(100);
declare inQuantity int;
declare inEconomyGoldDelta int;
declare inPricePerUnit decimal;
declare inPrice decimal;
declare v_finished bool;
declare varMinID bigint;
declare varMatchHourlyTimestamp datetime;
declare varMatchHourlyID bigint;
declare varCount int default 0;


select max(id) from LootProcess into varMinID; 
if ( varMinID > 67412148 ) THEN
	BEGIN
		leave TheThing;
	END;
END IF;

BEGIN
	 
	 DEClARE LogCursor CURSOR FOR 
	SELECT timestamp, SceneName, LocationEvent, PlayerName, Killer, Victim, Archetype, Quantity, EconomyGoldDelta,x,y,z FROM LogEvent L 
	 where L.id >= varMinID
	 and L.id < (varMinID + inNumber) limit inNumber;
     
 
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = true;

	 
	 OPEN LogCursor;
	 
	 get_log: LOOP
	 
     set v_finished = false;
	 FETCH LogCursor INTO intimestamp, inSceneName, inLocationEvent, inPlayerName, inKiller, inVictim, inArchetype, inQuantity, inEconomyGoldDelta,varX,varY,varZ;

	 IF v_finished = true THEN 
	 LEAVE get_log;
	 END IF;
	 
     set varCount = varCount + 1;
     
	 set varMatchHourlyTimestamp = date(intimestamp) + INTERVAL hour(intimestamp) HOUR;

	if ( inVictim is not null ) THEN 
	BEGIN
		set varMatchHourlyID = null;
		select id from HourlyKillsTotals 
			where timestamp = varMatchHourlyTimestamp
			AND SceneName = inSceneName
			AND LocationEvent = inLocationEvent
			AND Victim = inVictim
			AND x = varX
			and y = varY
			and z = varZ
			into varMatchHourlyID;
		if (  varMatchHourlyID is null )Then
		BEGIN
			INSERT INTO HourlyKillsTotals(id, timestamp, LocationEvent, SceneName, Victim, Quantity,x,y,z)
			values (null, date(intimestamp) + interval hour(intimestamp) HOUR, inLocationEvent, inSceneName, inVictim, 
			1, varX, varY, varZ);
		END;
		else
		BEGIN
			update HourlyKillsTotals
			set Quantity = Quantity + 1
			where id = varMatchHourlyID;
		END;
		END IF;
	END;
	END IF;




	if ( inArchetype is not null) THEN 
	BEGIN
		set varMatchHourlyID = null;
		select id from HourlyArchetypeTotals 
			where timestamp = varMatchHourlyTimestamp
			AND SceneName = inSceneName
			AND Archetype = inArchetype
			and LocationEvent = inLocationEvent
			AND x = varX
			and y = varY
			and z = varZ
			into varMatchHourlyID;
		if (  varMatchHourlyID is null )Then
		BEGIN
			INSERT INTO HourlyArchetypeTotals(id, timestamp, LocationEvent, SceneName, Archetype, Quantity, EconomyGoldDelta,x,y,z)
			values (null, date(intimestamp) + interval hour(intimestamp) HOUR, inLocationEvent, inSceneName, inArchetype, 
			inQuantity, inEconomyGoldDelta, varX, varY, varZ);
		END;
		else
		BEGIN
			update HourlyArchetypeTotals
			set Quantity = Quantity + inQuantity, EconomyGoldDelta = EconomyGoldDelta + inEconomyGoldDelta
			where id = varMatchHourlyID;
		END;
		END IF;
	END;
	END IF;
	 
	 
	 END LOOP get_log;
	 
	 CLOSE LogCursor;
		
END;
insert into LootProcess(id) values (varMinID + inNumber);
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_batches_storeData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_batches_storeData`()
BEGIN
DECLARE inID varBinary(50);
DECLARE inypos decimal(7,3);
DECLARE inzpos decimal(7,3); 
DECLARE inxpos decimal(7,3);
DECLARE intimestamp datetime;
DECLARE inSceneName varchar(100);
DECLARE inLocationEvent varchar(100);
DECLARE inPlayerName varchar(50);
DECLARE inKiller varchar(50);
DECLARE inVictim varchar(50);
DECLARE inItemID varbinary(50);
DECLARE inArchetype varchar(100);
DECLARE inQuantity int;
DECLARE inEconomyGoldDelta int;
DECLARE inPricePerUnit decimal;
DECLARE inPrice decimal;
DECLARE v_finished INTEGER DEFAULT 0;
 
-- declare cursor for employee email
DEClARE batch_cursor CURSOR FOR 
SELECT ID, ypos, zpos, xpos,
timestamp,SceneName,LocationEvent,
PlayerName,Killer,Victim,ItemID,
Archetype,Quantity,EconomyGoldDelta,PricePerUnit,Price
 FROM DataLoader;
 
 -- declare NOT FOUND handler
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = 1;
 
 OPEN batch_cursor;
 
 get_batch: LOOP
 
 FETCH batch_cursor INTO inID, inypos, inzpos, inxpos,
intimestamp,inSceneName,inLocationEvent,
inPlayerName,inKiller,inVictim,inItemID,
inArchetype,inQuantity,inEconomyGoldDelta,inPricePerUnit,inPrice;
 
 IF v_finished = 1 THEN 
 LEAVE get_batch;
 END IF;
 
call storeData(inID, inypos, inzpos, inxpos,
intimestamp,inSceneName,inLocationEvent,
inPlayerName,inKiller,inVictim,inItemID,
inArchetype,inQuantity,inEconomyGoldDelta,inPricePerUnit,inPrice);

delete from DataLoader where id = inID;
 
 END LOOP get_batch;
 
 CLOSE batch_cursor;
 END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd`(inDate date)
BEGIN
if inDate is null then
BEGIN
 set inDate = curDate() - interval 1 day;
END;
END IF;
call process_DayEnd_Kills(inDate);
call process_DayEnd_Crafting(inDate);
call process_DayEnd_Archetypes(inDate);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd_Archetypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd_Archetypes`(inDate date)
BEGIN
delete from DailyArchetypeTotals where date = inDate;
insert into DailyArchetypeTotals(id,date,LocationEvent,SceneName,Archetype,Quantity,EconomyGoldDelta)
select null, date(HAT.timestamp) as date, LocationEvent, SceneName, Archetype, Sum(Quantity) as Quantity, Sum(EconomyGoldDelta) as EconomyGoldDelta from HourlyArchetypeTotals HAT
join ( Select timestamp from HourlyTimeTable where timestamp >= inDate and timestamp < inDate + interval 1 day )  T
on HAT.timestamp = T.timestamp group by date(HAT.timestamp), LocationEvent, SceneName, Archetype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd_Crafting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd_Crafting`(inDate date)
BEGIN

delete from HourlyCraftingTotals where timestamp >= inDate and timestamp < inDate + INTERVAL 1 DAY;
delete from DailyCraftingTotals where date >= inDate and date < inDate + INTERVAL 1 DAY;

insert into HourlyCraftingTotals(id, timestamp, LocationEvent,SceneName, Archetype,Quantity,EconomyGoldDelta,x,y,z)
select NULL, date(L.timestamp) + interval  Hour(L.timestamp) HOUR as timestamp, 10, 
 L.SceneName, L.Archetype, sum(L.Quantity) as Quantity, sum(L.EconomyGoldDelta) as EconomyGoldDelta, L.x, L.y, L.z from LogEvent L
join Archetypes A
on L.Archetype = A.id
join SceneNames S
on L.SceneName = S.id
where L.LocationEvent = 10 
and timestamp >= inDate
and timestamp < inDate + INTERVAL 1 DAY
group by L.SceneName, L.Archetype, L.x, L.y, L.z, Hour(L.timestamp), date(L.timestamp);


insert into HourlyCraftingTotals(id, timestamp, LocationEvent,SceneName, Archetype,Quantity,EconomyGoldDelta,x,y,z)
select NULL, date(L.timestamp) + interval  Hour(L.timestamp) HOUR as timestamp, 11, 
 L.SceneName, L.Archetype, sum(L.Quantity) as Quantity, sum(L.EconomyGoldDelta) as EconomyGoldDelta, L.x, L.y, L.z from LogEvent L
join Archetypes A
on L.Archetype = A.id
join SceneNames S
on L.SceneName = S.id
where L.LocationEvent = 11 
and timestamp >= inDate
and timestamp < inDate + INTERVAL 1 DAY
group by L.SceneName, L.Archetype, L.x, L.y, L.z, Hour(L.timestamp), date(L.timestamp);

insert into HourlyCraftingTotals(id, timestamp, LocationEvent,SceneName, Archetype,Quantity,EconomyGoldDelta,x,y,z)
select NULL, date(L.timestamp) + interval  Hour(L.timestamp) HOUR as timestamp, 23, 
 L.SceneName, L.Archetype, sum(L.Quantity) as Quantity, sum(L.EconomyGoldDelta) as EconomyGoldDelta, L.x, L.y, L.z from LogEvent L
join Archetypes A
on L.Archetype = A.id
join SceneNames S
on L.SceneName = S.id
where L.LocationEvent = 23 
and timestamp >= inDate
and timestamp < inDate + INTERVAL 1 DAY
group by L.SceneName, L.Archetype, L.x, L.y, L.z, Hour(L.timestamp), date(L.timestamp);

insert into DailyCraftingTotals(id, date, LocationEvent, SceneName, Archetype, Quantity, EconomyGoldDelta)
select null, date(timestamp), LocationEvent, SceneName, Archetype, Sum(Quantity), Sum(EconomyGoldDelta)
from HourlyCraftingTotals H
where timestamp >= inDate
and timestamp < inDate + INTERVAL 1 DAY
group by SceneName, Archetype, LocationEvent, date(timestamp);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd_Kills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd_Kills`(inDate date)
BEGIN
delete from DailyKillsTotals where date = inDate;
insert into DailyKillsTotals(id,date,LocationEvent,SceneName,Victim,Quantity)
select null, date(HKT.timestamp) as date, LocationEvent, SceneName, Victim, Sum(Quantity) from HourlyKillsTotals HKT
join ( Select timestamp from HourlyTimeTable where timestamp >= inDate and timestamp < inDate + interval 1 day )  T
on HKT.timestamp = T.timestamp group by date(HKT.timestamp), LocationEvent, SceneName, Victim;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd_LootTables` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd_LootTables`(inLimit int)
BEGIN
declare varLootID bigint;
declare varKillSceneName int;
declare varLootArchetype int;
declare varLootQuantity int;
declare varLootTimestamp datetime;
declare varKillTimestamp datetime;
declare varEconomyGoldDelta int;
declare varLocationEvent int;
declare varKillStartTimestamp datetime default  CURDATE() - INTERVAL 2 DAY;
declare varKillEndTimestamp datetime default  CURDATE() - INTERVAL 1 DAY;
declare varXpos decimal;
declare varYpos decimal;
declare varZpos decimal;
declare v_finished bool;
declare varMax bigint;

select max(id) + 1 from LootProcess into varMax;

BEGIN

DEClARE LogCursor CURSOR FOR 
Select L.id, L.SceneName, Archetype, Quantity, timestamp, xpos, ypos, zpos, EconomyGoldDelta, LocationEvent  from LogEvent L
join SceneNames S
on L.SceneName = S.id
where L.LocationEvent in ( 7,9)
and L.id >= varMax
and L.id <= varMax + inLimit;


 
 
 DECLARE CONTINUE HANDLER 
        FOR NOT FOUND SET v_finished = true;


 OPEN LogCursor;
 
 get_log: LOOP
 
 FETCH LogCursor INTO varLootID, varKillSceneName, varLootArchetype, varLootQuantity, varLootTimestamp, varXpos, varYpos, varZpos, varEconomyGoldDelta, varLocationEvent;
 
 IF v_finished = true THEN 
	LEAVE get_log;
 END IF;
 
 set varKillStartTimestamp = varLootTimestamp - interval 2 minute;
 set varKillEndTimestamp = varLootTimestamp + interval 2 minute;
 
 if ( varLocationEvent = 9 ) then
 BEGIN
	set varLootArchetype = 6219; 
    set varLootQuantity = varEconomyGoldDelta;
 END;
 END IF;



INSERT IGNORE into LootTables(id, Archetype, Name, SceneName, Quantity, timestamp, KillID)
select varLootID, varLootArchetype, max(victim), varKillSceneName, varLootQuantity, max(timestamp), max(Kills.id)
from LogEvent Kills
where Kills.timestamp > varKillStartTimestamp
	and Kills.timestamp < varKillEndTimestamp
	and Kills.xpos < varXpos + 1
	and Kills.xpos > varXpos - 1
	and Kills.ypos < varYpos + 1
	and Kills.ypos > varYpos - 1
	and Kills.zpos < varZpos + 1 
	and Kills.zpos > varZpos - 1
	and Kills.LocationEvent = 4
	and Kills.SceneName = varKillSceneName
	group by Kills.LocationEvent having count(distinct victim) = 1;

 END LOOP get_log;
 
  
CLOSE LogCursor;
END;

insert into LootProcess(id) values (varMax + inLimit);

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_DayEnd_MissingDays` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_DayEnd_MissingDays`()
BEGIN
declare inDate1 date;
declare inDate2 date;
declare inDate3 date;
declare inDate date;

select min(R.date) from (
select H.date, max(D.id) as id from (select distinct date(timestamp) as date from HourlyTimeTable  where timestamp >= "2017-04-27" and timestamp < CurDate() ) H 
left join DailyKillsTotals D
on H.date = D.date group by H.date ) R
where R.id is null into inDate1;



select min(R.date) from (
select H.date, max(D.id) as id from (select distinct date(timestamp) as date from HourlyTimeTable  where timestamp >= "2017-04-27" and timestamp < CurDate() ) H 
left join DailyCraftingTotals D
on H.date = D.date group by H.date ) R
where R.id is null into inDate2;


select min(R.date) from (
select H.date, max(D.id) as id from (select distinct date(timestamp) as date from HourlyTimeTable  where timestamp >= "2017-04-27" and timestamp < CurDate() ) H 
left join DailyArchetypeTotals D
on H.date = D.date group by H.date ) R
where R.id is null into inDate3;


if ( inDate1 > inDate2 ) then
BEGIN
	set inDate = inDate1;
END;
ELSE
BEGIN
	set inDate = inDate2;
END;
END IF;

if ( inDate3 > inDate ) then
BEGIN
	set inDate = inDate3;
END;
END IF;

if inDate is not null then 
BEGIN
call Process_DayEnd(inDate);
END;
END IF;


END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `process_SceneCheck` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `process_SceneCheck`(inScene varchar(200))
BEGIN

if not exists ( select SceneName  from SceneNames where SceneName = inScene ) then
BEGIN
	if not exists ( select SceneName  from SceneLastUpdated where SceneName = inScene ) then
	BEGIN
    
    insert into SceneLastUpdated (SceneName, LastUpdated, LastPolled, LastCountUpdated, UpdatePeriod)
    values (inScene, '2017-05-01 00:00:00', '2017-05-01 00:00:00', 9999, 75);
    
    insert into SceneNames (ID, SceneName, DisplayName, made, Orientation, mapWidth, mapHeight, mapXOffset, mapYOffset)
    values (null, inScene, inScene, 0, 0, null, null, null, null);
	END;
	END IF;
END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `record_pageload_end` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `record_pageload_end`(inIP varchar(20), recordID bigint)
BEGIN
update SiteLoadData set endtime = now(), totalSecs = now() - starttime where id = recordID and ip = inIP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `record_pageload_start` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `record_pageload_start`(inIP varchar(20), inPage varchar(2000), inArgs varchar(2000))
BEGIN
insert into SiteLoadData(id, ip, page, args, starttime, endtime)
values ( null, inIP, inPage, inArgs, now(), null);

 SELECT LAST_INSERT_ID() as ID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `setLoadBalancerQuerySize` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `setLoadBalancerQuerySize`( inID bigint, inSize bigint )
BEGIN
	update SotaSTATSLoadBalancer set QueryAmount = inSize where id = inID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_attempt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_attempt`(
inIP varchar(20),
incharacterName varchar(45),
inX decimal(7,3),
inY decimal(7,3),
inZ decimal(7,3),
inSceneName varchar(200),
inSceneDisplayName varchar(200)
)
BEGIN
		insert into Snigol_Attempts(id,IP,characterName,x,y,z,SceneName,SceneDisplayName,entrytime,Successful, count)
		values (null,inIP,incharacterName,inX,inY,inZ,inSceneName,inSceneDisplayName,now(),0, 1);

select LAST_INSERT_ID() as id from Snigol_Attempts;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_checkAttempts` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_checkAttempts`(inIP varchar(20))
BEGIN
	select sum(count) as count from Snigol_Attempts where IP = inIP and entrytime > now() - interval 15 minute group by IP;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_checkToken` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_checkToken`(inSeries char(128), inToken char(128))
BEGIN
    select N.name as CharName from Snigol SL
    join Names N
    on SL.Name = N.id where Series = inSeries and Token = inToken;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_getSeries` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_getSeries`(inName varchar(200))
BEGIN
	declare varSeries Char(128);
    declare varNameID bigint;
	select ID from Names where Name = inName into varNameID;
    
    if ( varNameID is null ) then
    BEGIN
		insert into Names(id, Name,type) values (null,inName,1);
		select ID from Names where Name = inName into varNameID;    
    END;
    END IF;
    
    delete from Snigol where Name = varNameID;

	set varSeries = SHA2(RANDOM_BYTES(128),512);
    
    
    while EXISTS ( Select 1 from Snigol where Series = varSeries ) DO
		BEGIN
			set varSeries = SHA2(RANDOM_BYTES(128),512);	
		END;
    END WHILE;
    
    insert into Snigol(Series,Token,LastUsed,SetTime, Name)
    values (varSeries, NULL, NOW(), NOW(), varNameID);
    
    select varSeries as Series;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_updateAttempt` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_updateAttempt`(inID bigint, inStatus int)
BEGIN
update Snigol_Attempts set Successful = inStatus, count = count + 1 where id = inID;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `snigol_updateToken` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `snigol_updateToken`(inSeries Char(128), inToken Char(128))
BEGIN
	update Snigol set Token = inToken, LastUsed = now() where Series = inSeries;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_CraftingChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_CraftingChange`(inArchetype varchar(200), inMode int)
BEGIN
	
    CREATE TEMPORARY TABLE IF NOT EXISTS Crafted AS (
    select timestamp as timestamp, A.DisplayName, sum(Quantity) as Quantity from HourlyArchetypeTotals H
	join Archetypes A
	on H.Archetype = A.id
	join SceneNames S
	on H.SceneName = S.id
	join LocationEvents LE
	on H.LocationEvent = LE.id
	where H.LocationEvent = 10
    and A.DisplayName = inArchetype
	group by timestamp, A.DisplayName);
    
    insert into Crafted(timestamp, DisplayName, Quantity)
    select timestamp as timestamp, A.DisplayName, -sum(Quantity) as Quantity from HourlyArchetypeTotals H
	join Archetypes A
	on H.Archetype = A.id
	join SceneNames S
	on H.SceneName = S.id
	join LocationEvents LE
	on H.LocationEvent = LE.id
	where H.LocationEvent = 11
    and A.DisplayName = inArchetype
	group by timestamp, A.DisplayName;
    
    if ( inMode = 1 ) THEN
    BEGIN
		select timestamp, DisplayName, Sum(Quantity) as Quantity from Crafted where timestamp > now() - interval 3 day group by timestamp, DisplayName ;
        
    END;
    ELSEIF ( inMode = 2) THEN
    BEGIN
		select date(timestamp) as timestamp, DisplayName, Sum(Quantity) as Quantity from Crafted where timestamp > now() - interval 90 day group by date(timestamp), DisplayName;
	end;
    END IF;
    
    drop table Crafted;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_DropsFrom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_DropsFrom`(inArchetype varchar(200))
BEGIN

declare varArchetypeID int;

select id from Archetypes where DisplayName = inArchetype into varArchetypeID;
	
select S.DisplayName from dailyarchetypetotals DA
join SceneNames S
on DA.SceneName = S.id
where DA.Archetype = varArchetypeID
and DA.LocationEvent = 7
group by DA.SceneName;
    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_ListByLoot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_ListByLoot`()
BEGIN

select N.DisplayName as Archetype, Quantity from (
Select H.Archetype, H.SceneName, sum(Quantity) as Quantity from DailyArchetypeTotals H
where H.LocationEvent = 7
and date > now() - interval 7 day
 group by Archetype) R
 join Archetypes N
 on N.id = R.Archetype
 order by Quantity desc limit 100;
 
 
 
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_ListBySceneLoot` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_ListBySceneLoot`()
BEGIN

select N.DisplayName as Archetype, case when S.DisplayName is not null then S.DisplayName else "Unknown SceneName" end as SceneName, Quantity from (
Select H.Archetype, H.SceneName, sum(Quantity) as Quantity from DailyArchetypeTotals H
where H.LocationEvent = 7
and date > now() - interval 7 day
 group by Archetype,SceneName ) R
 join SceneNames S
 on S.id = R.SceneName
 join Archetypes N
 on N.id = R.Archetype
 order by Quantity desc limit 100;
 
 
 
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_MonsterDropsFrom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_MonsterDropsFrom`(inArchetype varchar(200))
BEGIN

declare varArchetypeID int;

select id from Archetypes where DisplayName = inArchetype into varArchetypeID;
	
    select N.Name as Monster from LootTables LT
join Names N
on LT.Name = N.id
where LT.Archetype = varArchetypeID
group by LT.Name;

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_NetChange` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_NetChange`(inArchetype varchar(200), inMode int)
BEGIN
	declare startTime datetime;
    declare endTime datetime;
    declare varArchetype bigint;
    
    set varArchetype = findItem(inArchetype);
    
    if ( inMode = 1 ) THEN
    BEGIN
		set startTime = timestamp(current_date) - interval 3 day;
        set endTime = timestamp(current_date);
	END;
	ELSEIF ( inMode = 2) THEN
    BEGIN
		set startTime = timestamp(current_date) - interval 30 day;
        set endTime = timestamp(current_date);
	end;
	END IF;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS Crafted AS (
    select H.date as timestamp, A.DisplayName, sum(Quantity) as Quantity from DailyArchetypeTotals H
	join Archetypes A
	on H.Archetype = A.id
	join LocationEvents LE
	on H.LocationEvent = LE.id
    where H.Archetype = varArchetype
    and H.LocationEvent in (1,2,7,19,11,14,56)
    and H.date >= startTime
    and H.date < endTime
	group by date, A.DisplayName);

    insert into Crafted(timestamp, DisplayName, Quantity)
    select H.date as timestamp, A.DisplayName, -sum(Quantity) as Quantity from DailyArchetypeTotals H
    join Archetypes A
	on H.Archetype = A.id
	join LocationEvents LE
	on H.LocationEvent = LE.id
    where H.Archetype = varArchetype
    and H.LocationEvent in (10,13,16)
    and H.date >= startTime
    and H.date < endTime
	group by date, A.DisplayName;
    
    if ( inMode = 1 ) THEN
    BEGIN
		select timestamp, DisplayName, Sum(Quantity) as Quantity from Crafted group by timestamp, DisplayName ;
        
    END;
    ELSEIF ( inMode = 2) THEN
    BEGIN
		select date(timestamp) as timestamp, DisplayName, Sum(Quantity) as Quantity from Crafted group by date(timestamp), DisplayName;
	end;
    END IF;
    
    drop table Crafted;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_PlaceToBuy` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`umuri`@`192.168.%.%` PROCEDURE `stats_archetype_PlaceToBuy`(inArchetype varchar(1000))
BEGIN

select S.DisplayName as SceneDisplay, S.SceneName, A.DisplayName as ArchetypeDisplay, A.Archetype, Round(AVG(X),2) as x, Round(AVG(y),2) as y, Round(AVG(z),2) as z, Round(AVG(PricePerUnit),0) as price  from logevent L
join scenenames S
on L.SceneName = S.id
join Archetypes A
on l.Archetype = A.id
where locationevent = 1 and A.Archetype = inArchetype group by S.SceneName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_archetype_SceneDropsFrom` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_archetype_SceneDropsFrom`(inArchetype varchar(200))
BEGIN

declare varArchetypeID int;

select id from Archetypes where DisplayName = inArchetype into varArchetypeID;
	
select S.DisplayName from dailyarchetypetotals DA
join SceneNames S
on DA.SceneName = S.id
where DA.Archetype = varArchetypeID
and DA.LocationEvent = 7
group by DA.SceneName;
    

    
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_LootTableMonster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_LootTableMonster`(inName varchar(200), inScene varchar(200))
BEGIN
	
    declare varTotal int;
    
    CREATE TEMPORARY TABLE IF NOT EXISTS LootResults AS (
	select A.DisplayName as Item, count(Quantity) as Occurances, Avg(LT.Quantity) as AvgQuantity from LootTables LT
	join Archetypes A
	on LT.Archetype = A.id
	join Names N
	on LT.Name = N.id
	join SceneNames S
	on LT.SceneName = S.id
	where N.Name = inName 
    and (inScene is NULL or S.DisplayName = inScene)
    group by A.DisplayName);
    
	select max(Occurances) from LootResults into varTotal;


    select Item, Occurances, ROUND(AvgQuantity,2) as AvgQuantity, ROUND((Occurances*100)/varTotal,2) as DropRate from LootResults where (Occurances*100)/varTotal > 1 order by (Occurances*100)/varTotal desc;
    drop table LootResults;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_AuctionsExperied` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_misc_AuctionsExperied`()
BEGIN

select L.timestamp, S.DisplayName as SceneName, A.DisplayName as DisplayName, L.Quantity as Quantity, L.EconomyGoldDelta as EconomyGoldDelta from LogEvent L 
join Archetypes A
on L.Archetype = A.id
join SceneNames S
on L.SceneName = S.id
where LocationEvent = 57 
 and timestamp > now() - interval 7 day order by timestamp desc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_CotoUseWeekly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_misc_CotoUseWeekly`()
BEGIN
select LE.DisplayName as LocationEvent, date(H.timestamp) as timestamp, sum(Quantity) as Quantity from HourlyArchetypeTotals H 
join ( Select timestamp from HourlyTimeTable where timestamp > now() - interval 14 day and timestamp < now() ) HTT 
on H.timestamp = HTT.timestamp
join LocationEvents LE
on H.LocationEvent = LE.id
where Archetype = 375 group by LE.DisplayName, date(H.timestamp) order by date(H.timestamp) asc;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_COTO_rent_60` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`umuri`@`192.168.%.%` PROCEDURE `stats_misc_COTO_rent_60`()
BEGIN
select DATE_FORMAT(timestamp, "%Y-%m-%d") as date, sum(quantity) as Amount, Archetype from logevent L
join scenenames S
on L.SceneName = S.id
where LocationEvent = 59 and timestamp > curdate() - interval 60 day group by  DATE_FORMAT(timestamp, "%Y-%m-%d"), Archetype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_COTO_rent_monthly` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`umuri`@`192.168.%.%` PROCEDURE `stats_misc_COTO_rent_monthly`()
BEGIN
select DATE_FORMAT(timestamp, "%Y-%m") as date, sum(quantity) as Amount, Archetype from logevent L
join scenenames S
on L.SceneName = S.id
where LocationEvent = 59 group by DATE_FORMAT(timestamp, "%Y-%m"), Archetype;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_LotteryTickets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_misc_LotteryTickets`()
BEGIN

select DisplayName, Quantity from (
select Archetype, Sum(Quantity) as Quantity from HourlyArchetypeTotals H
join (select timestamp from HourlyTimeTable H2 
join (select max(starttime) as starttime from releases) R
on H2.timestamp > R.starttime and timestamp < now() )HTT 
on H.timestamp = HTT.timestamp where Archetype in (1975, 1769) group by Archetype ) A
join Archetypes AA
on A.Archetype = AA.id;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_misc_LotteryTicketsPast` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_misc_LotteryTicketsPast`()
BEGIN
declare varStartTime datetime;
declare varEndTime datetime;

select min(starttime) from Releases into varStartTime;
select max(endtime) from Releases into varEndTime;


select ReleaseNo, DisplayName, Quantity from (
select Archetype, Sum(Quantity) as Quantity, R.id as ReleaseNo from HourlyArchetypeTotals H
join (select timestamp from HourlyTimeTable H2 where timestamp > varStartTime and timestamp < varEndTime )HTT 
on H.timestamp = HTT.timestamp 
join Releases R
on H.timestamp <= R.endtime
and H.timestamp >= R.starttime
where Archetype in (1975, 1769) group by Archetype, ReleaseNo ) A
join Archetypes AA
on A.Archetype = AA.id order by ReleaseNo asc, DisplayName asc;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_MonsterScenes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_MonsterScenes`(inMonsterName varchar(200))
BEGIN

declare varMonsterID bigint;

select id from Names where Name = inMonsterName into varMonsterID;

select distinct S.DisplayName as Scene, N.Name as Monster from DailyKillsTotals HK
join Names N
on HK.Victim = N.id
join SceneNames S
on HK.SceneName = S.id
where HK.Victim = varMonsterID;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_monster_ListByKills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_monster_ListByKills`()
BEGIN

select case when S.Name is not null then S.Name else "Unknown MonsterName" end as Monster, Quantity from (
Select H.Victim, sum(Quantity) as Quantity from DailyKillsTotals H
join (select H2.date from DailyKillsTotals H2 where H2.date > now() - interval 7 day
 group by H2.date) H2 
on H.date = H2.date
 group by Victim ) R
 join Names S
 on S.id = R.Victim
 order by Quantity desc limit 100;
 
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_monster_ListBySceneKills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_monster_ListBySceneKills`()
BEGIN

select N.Name as Monster, case when S.DisplayName is not null then S.DisplayName else "Unknown SceneName" end as SceneName, Quantity from (
Select H.Victim, H.SceneName, sum(Quantity) as Quantity from DailyKillsTotals H
join (select H2.date from HourlyKillsTotals H2 where H2.date > now() - interval 7 day
 group by H2.date) H2 
on H.date = H2.date
 group by Victim,SceneName ) R
 join SceneNames S
 on S.id = R.SceneName
 join Names N
 on N.id = R.Victim 
 order by Quantity desc limit 100;
 
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_Monster_LocalizedNames` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_Monster_LocalizedNames`(inMonsterName varchar(200))
BEGIN
	declare varMonsterName bigint;
    declare varLocalized tinyint;
	Select id, Localized from Names where Name = inMonsterName into varMonsterName, varLocalized;
    
	if ( varLocalized = 1 ) THEN
    BEGIN
		Select EnglishName from LocalizationMonsterNames L
		where ForeignName = varMonsterName into varMonsterName;
    END;
    END IF;
    
	Select N.Name from LocalizationMonsterNames L
	join Names N 
	on L.ForeignName = N.id where L.EnglishName = varMonsterName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_monster_sheet` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_monster_sheet`(inMonsterName varchar(200), inSceneName varchar(200))
BEGIN
	declare varMonsterName bigint;
    declare varSceneName bigint;
    declare varHitpoints int;
    declare varFocus int;
    declare varExperience int;
    declare varWeakness int;
    declare varResistance int;
    declare varTamingLevel int;
    declare varSkinnable int;
    
    
    set varMonsterName = findName(inMonsterName);
    set varSceneName = findScene(inSceneName);

    SELECT
    AVG(CASE WHEN (Category='Hitpoints') THEN NewValue ELSE null END) AS Hitpoints,
    AVG(CASE WHEN (Category='Focus') THEN NewValue ELSE null END) AS Focus,
    AVG(CASE WHEN (Category='Experience') THEN NewValue ELSE null END) AS Experience,
    AVG(CASE WHEN (Category='Weakness') THEN NewValue ELSE null END) AS Weakness,
    AVG(CASE WHEN (Category='Resistance') THEN NewValue ELSE null END) AS Resistance,
    AVG(CASE WHEN (Category='TamingLevel') THEN NewValue ELSE null END) AS TamingLevel,
    AVG(CASE WHEN (Category='Skinnable') THEN NewValue ELSE null END) AS Skinnable
	FROM 
    Alterations
    where SceneName = varSceneName and Monster = varMonsterName
	GROUP BY SceneName, Monster into varHitpoints, varFocus, varExperience, varWeakness, varResistance, varTamingLevel, varSkinnable;
    
    select 
    CASE when Hitpoints = 0 and varHitpoints is not null THEN varHitpoints else Hitpoints end as Hitpoints,
    CASE when Focus = 0 and varFocus is not null THEN varFocus else Focus end as Focus,
    CASE when Experience = 0 and varExperience is not null THEN varExperience else Experience end as Experience,
    CASE when Weakness = 0 and varWeakness is not null THEN varWeakness else Weakness end as Weakness,
    CASE when Resistance = 0 and varResistance is not null THEN varResistance else Resistance end as Resistance,
    CASE when TamingLevel = 0 and varTamingLevel is not null THEN varTamingLevel else TamingLevel end as TamingLevel,
    CASE when Skinnable = 0 and varSkinnable is not null THEN varSkinnable else Skinnable end as Skinnable,
    Notes 
    from MonsterInfo where NameID = varMonsterName and SceneName = varSceneName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_player_kills_month` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_player_kills_month`(inName varchar(200))
BEGIN
declare varName bigint;

select id from Names where Name = inName into varName;

select S.DisplayName as SceneName, N.Name as Monster, Quantity 
from ( Select SceneName, Victim, count(Victim) as Quantity from LogEvent LE
where PlayerName = varName and timestamp > now() - interval 30 day and LocationEvent = 4 group by SceneName, Victim) R
join Names N
on  N.ID = R.Victim
join SceneNames S
on S.id = R.SceneName;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_SceneMonsters` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_SceneMonsters`(inSceneName varchar(200))
BEGIN

declare varSceneID bigint;

select id from SceneNames where DisplayName = inSceneName into varSceneID;

select distinct S.DisplayName as Scene, N.Name as Monster from HourlyKillsTotals HK
join SceneNames S
on HK.SceneName = S.id
join Names N
on HK.Victim = N.id
where HK.SceneName = varSceneID and HK.LocationEvent = 4; 

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_scene_ListByArchetypes` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_scene_ListByArchetypes`()
BEGIN

select case when S.DisplayName is not null then S.DisplayName else "Unknown DisplayName" end as SceneName from (
Select SceneName, sum(Quantity) as Quantity from DailyArchetypeTotals H
join (select H2.date from DailyArchetypeTotals H2 where H2.date > now() - interval 8 day
 group by H2.date) H2 
on H.date = H2.date
 group by SceneName ) R
 join SceneNames S
 on S.id = R.SceneName
 order by Quantity desc;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_scene_ListByKills` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_scene_ListByKills`()
BEGIN


select case when S.DisplayName is not null then S.DisplayName else "Unknown DisplayName" end as SceneName, Quantity from (
Select SceneName, sum(Quantity) as Quantity from DailyKillsTotals H
join (select H2.date from DailyKillsTotals H2 where H2.date > now() - interval 7 day
 group by H2.date) H2 
on H.date = H2.date
 group by SceneName ) R
 join SceneNames S
 on S.id = R.SceneName
 order by Quantity desc;
 
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_scene_LootDrops` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_scene_LootDrops`(inScene varchar(200))
BEGIN
declare varSceneName bigint;

select id from SceneNames where DisplayName = inScene into varSceneName;

select A.DisplayName, sum(Quantity) as Quantity from (
 Select H.Archetype, sum(Quantity) as Quantity from DailyArchetypeTotals H
where H.SceneName = varSceneName
 and H.LocationEvent = 7 
 and H.date > now() - interval 7 day
 group by H.Archetype
 ) R
 join Archetypes A
on R.Archetype = A.id
group by A.DisplayName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_scene_WorldDrops` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_scene_WorldDrops`(inScene varchar(200))
BEGIN
declare varSceneName bigint;

select id from SceneNames where DisplayName = inScene into varSceneName;

select A.DisplayName, sum(Quantity) as Quantity from (
 Select H.Archetype, sum(Quantity) as Quantity from DailyArchetypeTotals H
where H.SceneName = varSceneName
 and H.LocationEvent = 14 
 and H.date > now() - interval 7 day
 group by H.Archetype
 ) R
 join Archetypes A
on R.Archetype = A.id
group by A.DisplayName;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_siteLoad` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`umuri`@`192.168.%.%` PROCEDURE `stats_siteLoad`(period int)
BEGIN
if ( period = 0 ) then
BEGIN
	select count(queryAmount) as Count, sum(queryAmount) as Size from SotaSTATSLoadBalancer where InsertTime > (now() - INTERVAL 1 HOUR);
END;
END IF;
if ( period = 1 ) then
BEGIN
	select count(queryAmount) as Count, sum(queryAmount) as Size from SotaSTATSLoadBalancer where InsertTime > (now() - INTERVAL 1 DAY);
END;
END IF;

END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_submit_alteration_item` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_submit_alteration_item`(inSubmitter varchar(200), inArchetype varchar(200), inCategory varchar(200), inValue varchar(8000))
BEGIN

declare varArchetype bigint;
declare varSubmitter bigint;
declare varID bigint;


set varSubmitter = findName(inSubmitter);
set varArchetype = findItem(inArchetype);

select id from AlterationsItems where Submitter = varSubmitter 
and Archetype = varArchetype and Category = inCategory into varID;

if ( varID is null ) THEN
BEGIN
	insert into AlterationsItems(id,Submitter, varArchetype, Category, NewValue)
	values (null, varSubmitter, varArchetype, inCategory, inValue);
END;
ELSE
BEGIN
	update Alterations set NewValue = inValue where id = varID;
END;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_submit_alteration_monster` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_submit_alteration_monster`(inSubmitter varchar(200), inMonsterName varchar(200), inSceneName varchar(200), inCategory varchar(200), inValue varchar(8000))
BEGIN

declare varSceneName bigint;
declare varMonsterName bigint;
declare varSubmitter bigint;
declare varID bigint;


set varSubmitter = findName(inSubmitter);
set varMonsterName = findName(inMonsterName);
set varSceneName = findScene(inSceneName);

select id from Alterations where Submitter = varSubmitter and SceneName = varSceneName
and Monster = varMonsterName and Category = inCategory into varID;

if ( varID is null ) THEN
BEGIN
	insert into Alterations(id,Submitter, SceneName, Monster, Category, NewValue)
	values (null, varSubmitter, varSceneName, varMonsterName, inCategory, inValue);
END;
ELSE
BEGIN
	update Alterations set NewValue = inValue where id = varID;
END;
END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `stats_vlad_presets` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `stats_vlad_presets`(inTime varchar(200), inTimeBack varchar(200), inEvent varchar(200),inArchetype varchar(200))
BEGIN

declare starttime datetime;
declare endtime datetime;
declare idEvent int;
declare idArchetype int;

	if ( inTimeBack = "2Days") then
	BEGIN
		select Now() - interval 2 day into starttime;
	END;
	elseif ( inTimeBack = "7Days") then
	BEGIN
		select ( Now() - interval 7 DAY ) into starttime;
	END;
	elseif ( inTimeBack = "1Month") then
	BEGIN
		select ( Now() - interval 1 MONTH ) into starttime;
	END;
	elseif ( inTimeBack = "3Month") then
	BEGIN
		select ( Now() - interval 3 MONTH ) into starttime;
    END;
	elseif ( inTimeBack = "6Month") then
	BEGIN
		select ( Now() - interval 6 MONTH ) into starttime;
    END;
	elseif ( inTimeBack = "12Month") then
	BEGIN
		select ( Now() - interval 12 MONTH ) into starttime;
    END;
	END IF;
    

	if ( inTime = "2Days") then
	BEGIN
		select ( starttime + interval 2 day ) into endtime;
	END;
	elseif ( inTime = "7Days") then
	BEGIN
		select ( starttime + interval 7 day ) into endtime;
	END;
	elseif ( inTime = "1Month") then
	BEGIN
		select ( starttime + interval 1 month ) into endtime;
	END;
	elseif ( inTime = "3Month") then
	BEGIN
		select ( starttime + interval 3 month ) into endtime;
	END;
	END IF;

	select id from locationevents where locationEvent = inEvent into idEvent;
	select id from Archetypes where archetype = inArchetype into idArchetype;


	if ( inTime = "2Days" ) then -- Hourly
	BEGIN
		select min(timestamp) as timestart, max(timestamp) as timeend, sum(quantity) as quantity, sum(EconomyGoldDelta) as economyGoldDelta from hourlyarchetypetotals 
		where timestamp >= starttime and timestamp <= endtime and locationEvent = idEvent and archetype = idArchetype group by timestamp order by timestamp desc;
	END;
	elseif ( inTime = "3Month") then -- Weekly
	BEGIN
		select min(date) as time, max(date) as timeend, sum(quantity) as quantity, sum(EconomyGoldDelta) as economyGoldDelta from dailyarchetypetotals 
		where date >= starttime and date <= endtime and locationEvent = idEvent and archetype = idArchetype group by week(date) order by date desc;
	END;
	else -- Daily
	BEGIN
		select min(date) as time, max(date) as timeend, sum(quantity) as quantity, sum(EconomyGoldDelta) as economyGoldDelta from dailyarchetypetotals 
		where date >= starttime and date <= endtime and locationEvent = idEvent and archetype = idArchetype group by date order by date desc;
	END;
	END IF;
    
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `storeData` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `storeData`(
inID varBinary(50),
inypos decimal(7,3),
inzpos decimal(7,3), 
inxpos decimal(7,3),
intimestamp datetime,
inSceneName varchar(100),
inLocationEvent varchar(100),
inPlayerName varchar(50),
inKiller varchar(50),
inVictim varchar(50),
inItemID varbinary(50),
inArchetype varchar(100),
inQuantity int,
inEconomyGoldDelta int,
inPricePerUnit decimal,
inPrice decimal)
BEGIN


declare varArchetype varchar(100);
declare varSceneName varchar(100);
declare varLocationEvent varchar(100);
declare varPlayerName varchar(100);
declare varKiller varchar(100);
declare varVictim varchar(100);
declare varItemID varchar(100);
declare varX smallint;
declare varY smallint;
declare varZ smallint;
declare varID bigint;
declare varMatchHourlyID bigint;
declare varMatchHourlyTimestamp datetime;
SET @@session.time_zone='+00:00';

START TRANSACTION;


IF NOT EXISTS (Select id from LogIDs where LogID = inID ) THEN
	BEGIN
		insert into LogIDs(ID,LogID) values (null,inID);
    END;
END IF;    
    
select min(ID) from LogIDs where LogID = inID INTO varID;

IF ( inPlayerName is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from Names where Name = inPlayerName) THEN
		BEGIN
			insert into Names(id,Name,Type) values (null,inPlayerName,null);
		END;
		END IF;
        select min(id) from Names where Name = inPlayerName INTO varPlayerName;
	END;
    ELSE
    BEGIN
		set varPlayerName = null;
    END;
	END IF;
    
IF ( inVictim is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from Names where Name = inVictim) THEN
			BEGIN
			insert into Names(id,Name,Type) values (null,inVictim,null);
            END;
		END IF;
        select min(id) from Names where Name = inVictim INTO varVictim;
	END;
    ELSE
    BEGIN
		set varVictim = null;
    END;
	END IF;
    
IF ( inKiller is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from Names where Name = inKiller) THEN
			BEGIN
			insert into Names(id,Name,Type) values (null,inKiller,null);
            END;
		END IF;
		select min(id) from Names where Name = inKiller INTO varKiller;
	END;
    ELSE
    BEGIN
		set varKiller = null;
    END;
	END IF;    


IF ( inLocationEvent is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from LocationEvents where LocationEvent = inLocationEvent) THEN	
			BEGIN
			insert into LocationEvents(id,LocationEvent,Displayname) values (null,inLocationEvent,null);
            END;
		END IF;
        select min(id) from LocationEvents where LocationEvent = inLocationEvent INTO varLocationEvent;
	END;
    ELSE
    BEGIN
		set varLocationEvent = null;
    END;
	END IF;

set varX = Floor(inxpos/5)*5;
set varY = Floor(inypos/5)*5;
set varZ = Floor(inzpos/5)*5;

IF ( inArchetype is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from Archetypes where Archetype = inArchetype) THEN
			BEGIN
			insert into Archetypes(id,Archetype,Displayname) values (null,inArchetype,null);
            END;
		END IF;
        select min(id) from Archetypes where Archetype = inArchetype INTO varArchetype;
	END;
    ELSE
    BEGIN
		set varArchetype = null;
    END;
	END IF;
    
    
IF ( inSceneName is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from SceneNames where SceneName = inSceneName ) THEN
			BEGIN
			insert into SceneNames(id,SceneName,Displayname) values (null,inSceneName,null);
			insert into SceneLastUpdated(SceneName,LastUpdated,LastPolled,LastCountUpdated,UpdatePeriod) 
            values (inSceneName,'2017-06-01','2017-06-01',9999,75);
            END;
		END IF;
        select min(id) from SceneNames where SceneName = inSceneName INTO varSceneName;
	END;
    ELSE
    BEGIN
		set varSceneName = null;
    END;
	END IF;    
    
    
IF ( inItemID is not null ) THEN
	BEGIN
	IF NOT EXISTS ( select id from ItemIDs where ItemID = inItemID ) THEN
			BEGIN
			insert into ItemIDs(id,ItemID) values (null,inItemID);
            END;
		END IF;
        select min(id) from ItemIDs where ItemID = inItemID INTO varItemID;
	END;
    ELSE
    BEGIN
		set varItemID = null;
    END;
	END IF;    
        
    
INSERT IGNORE INTO LogEvent (LogEvent.ID, LogEvent.ypos, LogEvent.zpos, LogEvent.xpos, LogEvent.timestamp, LogEvent.SceneName, LogEvent.LocationEvent, LogEvent.PlayerName, LogEvent.Killer, LogEvent.Victim, LogEvent.ItemID, LogEvent.Archetype, LogEvent.Quantity, LogEvent.EconomyGoldDelta, LogEvent.PricePerUnit, LogEvent.Price, LogEvent.x, LogEvent.y, LogEvent.z) 
values (varID, inypos, inzpos, inxpos, intimestamp, varSceneName, varLocationEvent, varPlayerName, varKiller, varVictim, varItemID, varArchetype, inQuantity, inEconomyGoldDelta, inPricePerUnit, inPrice, varX, varY, varZ);


set varMatchHourlyTimestamp = date(intimestamp) + INTERVAL hour(intimestamp) HOUR;

if ( varVictim is not null ) THEN 
BEGIN
	set varMatchHourlyID = null;
	select id from HourlyKillsTotals 
		where timestamp = varMatchHourlyTimestamp
		AND SceneName = varSceneName
		AND LocationEvent = varLocationEvent
		AND Victim = varVictim
		AND x = varX
		and y = varY
		and z = varZ
		into varMatchHourlyID;
	if (  varMatchHourlyID is null )Then
	BEGIN
		INSERT INTO HourlyKillsTotals(id, timestamp, LocationEvent, SceneName, Victim, Quantity,x,y,z)
		values (null, date(intimestamp) + interval hour(intimestamp) HOUR, varLocationEvent, varSceneName, varVictim, 
		1, varX, varY, varZ);
	END;
	else
    BEGIN
		update HourlyKillsTotals
		set Quantity = Quantity + 1
		where id = varMatchHourlyID;
	END;
	END IF;
END;
END IF;

if ( varLocationEvent = 9 ) THEN
BEGIN
	set varArchetype = 6219; 
	set inQuantity = inEconomyGoldDelta;
END;
END IF;



if ( varArchetype is not null) THEN 
BEGIN
	set varMatchHourlyID = null;
	select id from HourlyArchetypeTotals 
		where timestamp = varMatchHourlyTimestamp
		AND SceneName = varSceneName
		AND Archetype = varArchetype
		and LocationEvent = varLocationEvent
		AND x = varX
		and y = varY
		and z = varZ
		into varMatchHourlyID;
	if (  varMatchHourlyID is null )Then
	BEGIN
		INSERT INTO HourlyArchetypeTotals(id, timestamp, LocationEvent, SceneName, Archetype, Quantity, EconomyGoldDelta,x,y,z)
		values (null, date(intimestamp) + interval hour(intimestamp) HOUR, varLocationEvent, varSceneName, varArchetype, 
		inQuantity, inEconomyGoldDelta, varX, varY, varZ);
	END;
	else
    BEGIN
		update HourlyArchetypeTotals
		set Quantity = Quantity + inQuantity, EconomyGoldDelta = EconomyGoldDelta + inEconomyGoldDelta
		where id = varMatchHourlyID;
	END;
	END IF;
END;
END IF;

COMMIT;

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_getSettings` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `user_getSettings`(inUser varchar(200))
BEGIN
	declare varUser bigint;
	set varUser = findName(inUser);

	select Setting, Value from UserSettings where User = varUser;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `user_setSetting` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`sotaumuri`@`X.X.X.X` PROCEDURE `user_setSetting`(inUser varchar(200), inSetting varchar(200), inValue varchar(200))
BEGIN
	declare varUser bigint;
    declare varID bigint;
	set varUser = findName(inUser);

	select id from UserSettings where User = varUser and Setting = inSetting into varID;
    if ( varID is null ) THEN
    BEGIN
		insert into UserSettings(id,User,Setting,Value) values ( NULL, varUser, inSetting, inValue );
    END;
    ELSE
    BEGIN
		update UserSettings set Value = inValue where id = varID and User = varUser;
    END;
    END IF;
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

-- Dump completed on 2018-12-14 21:50:11
