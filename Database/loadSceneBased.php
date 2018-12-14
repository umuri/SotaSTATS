
<?php
//<meta http-equiv="refresh" content="5" />
	//fill in your mysql information here
	include 'dbIncludeLoad.php';

	//the tablename demo was used for this tutorial. change this to the actual name of the table.
	$table = "LogEvent";
	//LastUpdated
	//ItemGained_Loot
	
	
	//connects to mysql and selects the corresponding database.
	mysql_connect($hostname,$username,$password);
	mysql_select_db($database);

	
	

	
	function getScenes(mysqli $dbLink)
	{
			
	
	
	$query = "select SLU.SceneName, SLU.LastUpdated, S.ID from SceneLastUpdated SLU join SceneNames S
	on SLU.SceneName = S.SceneName  where now() > LastPolled + IntervaL UpdatePeriod Minute order by UpdatePeriod asc limit 80";
		return c_mysqli_query($dbLink, $query);
	}
	
	
	function dbsanitize($data)
	{
		if ( empty($data) )
		{return 'NULL';}
		else if ( is_numeric($data) )
		{	return mysql_real_escape_string($data); }
		else
		{ return "'" . mysql_real_escape_string($data) . "'"; }
	}
	
	function processData(mysqli $dbLink, $SiteRequest, $SceneName, $SceneID)
	{
		
	$SiteRequest = str_replace(' ', '%20', $SiteRequest);	
		$SiteRequest = 'http://shroudoftheavatar.com:9200/_all/_search?q=' . $SiteRequest . "&size=9999&sort=@timestamp:asc";
		echo"<br>" . $SiteRequest . "<br>\r\n". "<br>\r\n";
		
		

	$options = array(
	'http'=>array(
		'method'=>"GET",
		'header'=>"Accept-language: en\r\n" .
				"User-Agent: Umuri SotaSTATS puller\r\n"
	)
	);

	$currentCount=0;
	$context = stream_context_create($options);	
	$id = fetchAPI($dbLink, $SiteRequest);
	
	$json = @file_get_contents($SiteRequest, false, $context);
	setSizeAPI($dbLink,$id,strlen($json));
	
		
	if ( $json === FALSE )
	{
		echo "PULL FAILED<BR>\r\n";
		echo "REASON: ";
		
		return FALSE; //WE FAILED!
	}
	$obj = json_decode($json);
	
	    $queryLoad = "insert into DataLoader(ID, ypos, zpos, xpos, timestamp, SceneName, LocationEvent, PlayerName, Killer, Victim, ItemID, Archetype, Quantity, EconomyGoldDelta, PricePerUnit, Price)
		values ";
		
		$start = true;
		$bcount = 0;
		foreach ($obj->hits->hits as &$val)
		{
			if ( !empty($val->_id) )
			{
				if ( !$start)
				{
					$queryLoad = $queryLoad . ",";
				}
				else
				{
					$start = false;
				}
				$queryLoad = $queryLoad . "("
				. dbsanitize($val->_id)
				. "," . dbsanitize(isset($val->_source->ypos) ? $val->_source->ypos : "")
				. "," . dbsanitize(isset($val->_source->xpos) ? $val->_source->xpos : "")
				. "," . dbsanitize(isset($val->_source->zpos) ? $val->_source->zpos : "")
				. "," . dbsanitize($val->_source->{'@timestamp'})
				. "," . dbsanitize($val->_source->SceneName);
				
				if ( !empty($val->_source->LocationEvent) )
				{
					$queryLoad = $queryLoad . "," . dbsanitize($val->_source->LocationEvent);
				}
				else if ( !empty($val->_source->EconomyEvent))
				{
					$queryLoad = $queryLoad . "," . dbsanitize($val->_source->EconomyEvent);
				}
				else
				{
					$queryLoad = $queryLoad . ",NULL";
				}
				
				$parts = (isset($structure->parts) ? $structure->parts : false);
				$queryLoad = $queryLoad . "," . dbsanitize(isset($val->_source->PlayerName) ? $val->_source->PlayerName : "")
				. "," . dbsanitize(isset($val->_source->Killer) ? $val->_source->Killer : "")
				. "," . dbsanitize(isset($val->_source->Victim) ? $val->_source->Victim : "")
				. "," . dbsanitize(isset($val->_source->ItemId) ? $val->_source->ItemId : "")
				. "," . dbsanitize(isset($val->_source->Archetype) ? $val->_source->Archetype : "")
				. "," . dbsanitize(isset($val->_source->Quantity) ? $val->_source->Quantity : "")
				. "," . dbsanitize(isset($val->_source->EconomyGoldDelta) ? $val->_source->EconomyGoldDelta : "")
				. "," . dbsanitize(isset($val->_source->PricePerUnit) ? $val->_source->PricePerUnit : "")
				. "," . dbsanitize(isset($val->_source->Price) ? $val->_source->Price : "") 
				. ")";
				
				//echo $val->_source->xpos . "," . $val->_source->ypos . "," . $val->_source->zpos . "<br>";
			
				//echo $query . "<br>";
				
				$bcount++;
			}
		}
		if ($bcount > 0 )
		{
			$result = mysql_query($queryLoad) or die ("Batch Load Error: ".mysql_error() . "<br>\r\n" . $queryLoad);
			echo "Batch inserted: " . $bcount . "<br>\r\n";
		}
		
		$query = "CALL process_batches_storeData()";

		$result = mysql_query($query) or die ("Batch Process Error: ".mysql_error());
		
		$query = "select MAX(timestamp) from LogEvent where SceneName = '" . $SceneID . "'";
		//echo $query;
		$result = mysql_query($query) or die ("Timestamp Error: ".mysql_error());
		
		//this if makes sure there is information in the table. if there isn't, there will be no output.
		if (mysql_num_rows($result) > 0)
		{	
		//this creates a variable named $query_data and fills it with the information from the first row. using a	while statement, this will repeat for each row the table contains.
			while ($query_data = mysql_fetch_array($result))
			{
				$LastUpdated = $query_data['MAX(timestamp)'];	 
			}
		}
		
		$query = "update SceneLastUpdated set LastUpdated = '".$LastUpdated. "', LastPolled = now(), LastCountUpdated = ". $bcount . " where SceneName = '".$SceneName."'";		
			$result = mysql_query($query) or die ("SceneLastUpdate Error: ".mysql_error());
		echo $bcount . " records updated with " . $LastUpdated . " as the new last Update date for " . $SceneID . ":" . $SceneName . "<br>\r\n";
		
		return TRUE;
	}
	
	
	$sceneList = getScenes($dbLink);
	echo count($sceneList) . " scenes to process<br>";
	$startTime = time();
	$lastTime = time();
	foreach ($sceneList as &$currentScene)
	{
		$SiteRequest = 'SceneName:' . $currentScene["SceneName"];
		date_default_timezone_set('UTC');
		echo "<br>Loop begin: " . $date = date('m/d/Y h:i:s a', time()) . "<br>\r\n";
		$MaxUpdatedTimestamp = round((microtime(true) -  5400) * 1000) ; //Always 1 hour, 30 minutes behind to completely eclipse fudging
		$LastUpdatedTimestamp = strtotime($currentScene["LastUpdated"], 0);
		$LastUpdatedTimestamp = ($LastUpdatedTimestamp * 1000)+1000 ;
		
		if ( $LastUpdatedTimestamp < $MaxUpdatedTimestamp )
		{
			//echo var_dump($timestamps);
			$SiteRequest = $SiteRequest . "%20AND%20@timestamp:>" . $LastUpdatedTimestamp . "%20AND%20@timestamp:<" . $MaxUpdatedTimestamp;
		
			 $PDresult = processData($dbLink, $SiteRequest, $currentScene["SceneName"], $currentScene["ID"]);
			 echo "<br>Process finish: " . $date = date('m/d/Y h:i:s a', time()) . "<br>\r\n";
		}
		if (ob_get_length() !== FALSE)
		{
			ob_flush();
		}
		flush();
		if ( $PDresult === FALSE )
		{
			sleep(15);
			
		}
		sleep(3);
		while ( checkLoad($dbLink) >= 2 )
		{
			sleep(2);
		}
		$lastTime = time();
		if ( time() - $startTime > 550) //Almost 10 minutes, cut it off
		{
			echo "TIME CUTOFF<br>\n\r";
			return;
		}
	}
	
	

	

	
	
	

	?>