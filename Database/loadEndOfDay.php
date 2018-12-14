
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

	
	


	
	
	
	function dbsanitize($data)
	{
		if ( empty($data) )
		{return 'NULL';}
		else if ( is_numeric($data) )
		{	return mysql_real_escape_string($data); }
		else
		{ return "'" . mysql_real_escape_string($data) . "'"; }
	}
	
	function processData(mysqli $dbLink)
	{
		
	
		$SiteRequest = 'http://shroudoftheavatar.com:9200/_all/_search?size=2999&sort=@timestamp:asc';
		echo"<br>" . $SiteRequest . "<br>\r\n". "<br>\r\n";
		
		

		$options = array(
		'http'=>array(
		'method'=>"GET",
		'header'=>"Accept-language: en\r\n" .
				"User-Agent: Umuri SotaSTATS puller\r\n"
		)
		);

		$context = stream_context_create($options);	
		$id = fetchAPI($dbLink, $SiteRequest);
		
		$json = @file_get_contents($SiteRequest, false, $context);
		setSizeAPI($dbLink,$id,strlen($json));
		
			
		if ( $json === FALSE )
		{
			echo "PULL FAILED<BR>\r\n";
			return FALSE; //WE FAILED!
		}
		$obj = json_decode($json);
		
		$Locations = [];
		//echo var_dump($obj);
		$foundCount = 0;
			foreach ($obj->hits->hits as &$val)
			{ 
			
				if ( !empty($val->_id) )
				{
					//echo $val->_source->SceneName . "<br>";
					if  ( !in_array($val->_source->SceneName,$Locations) )
					{
						$Locations[] = $val->_source->SceneName;
						$foundCount++;
					}
				}
			}
			
			echo $foundCount . " locations found.<br>";
			
			//var_dump($Locations);
			echo "<br>";
			foreach($Locations as $key=>$val)
			{
				$query = "CALL process_SceneCheck(" .dbsanitize($val) . ")";

				//echo $val->_source->xpos . "," . $val->_source->ypos . "," . $val->_source->zpos . "<br>";
				
				//echo $query . "<br>";
				$result = mysql_query($query) or die ("Statistics Error: ".mysql_error());
			}
			
			
		return TRUE;
	}
	
	date_default_timezone_set('UTC');
	$PDresult = processData($dbLink);
	
	$query = "CALL process_DayEnd(null)";

	$result = mysql_query($query) or die ("Statistics Error: ".mysql_error());

	

	
	
	

	?>
