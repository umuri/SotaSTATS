<?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/../ucfg/dbInclude.php'); 

	function CheckAuthAttempt(mysqli $dbLink, $posX, $posY, $posZ, $charName, $ip, $sceneName, $displaySceneName)
	{
		
		$result = c_mysqli_call($dbLink, "snigol_checkAttempts", dbsanitize($dbLink, $ip));
		if ( count($result) >= 6 ) //We already have an attempt going, use that one.
		{
			return "ATTEMPT_OVERLOAD";
		}
		else
		{
		
		
		$args = dbsanitize($dbLink, $ip) . ',' . dbsanitize($dbLink, $charName)
			 . ',' . dbsanitize($dbLink, $posX) . ',' . dbsanitize($dbLink, $posY)
			  . ',' . dbsanitize($dbLink, $posZ) . ',' . dbsanitize($dbLink, $sceneName)
			   . ',' . dbsanitize($dbLink, $displaySceneName);
		//Add the login attempt!
		$result = c_mysqli_call($dbLink, "snigol_attempt", $args);	   
		$Snigol_ID = $result[0]["id"];
		
		$startTime = time();
		while ( checkLoad($dbLink) >= 1 )
		{
			sleep(1);
			if ( time() - $startTime > 60) //Almost a minute, timeout
			{
				echo "API Pull timed out, probably the rate limiter from Portalarium miscounting<br>Please Try Again<br>\n\r";
				return 'API_TIMEOUT';
			}
		}
			
		
		$options = array(
		'http'=>array(
			'method'=>"GET",
			'header'=>"Accept-language: en\r\n" .
					"User-Agent: Umuri SotaSTATS AuthSystem\r\n"
		)
		);
		//THIS IS HERE BECAUSE ELASTICSEARCH IS STUPID
		//The damn index/search ignores negatives, so we just treat everything as positive.
		$args = " AND PlayerName:" . urlencode($charName)
				. " AND xpos:>" . floor(abs($posX)-1)
				. " AND xpos:<" . ceil(abs($posX)+1)
				. " AND ypos:>" . floor(abs($posY)-1)
				. " AND ypos:<" . ceil(abs($posY)+1)
				. " AND zpos:>" . floor(abs($posZ)-1)
				. " AND zpos:<" . ceil(abs($posZ)+1);
				
		$SiteRequest = 'http://shroudoftheavatar.com:9200/_all/_search?q=LocationEvent:StuckUsed AND @timestamp:>now-15m' . $args . '&size=0';
		$SiteRequest = str_replace(' ', '%20', $SiteRequest);	
		
		$id = fetchAPI($dbLink, $SiteRequest);
		
		$context = stream_context_create($options);	
	
		$json = @file_get_contents($SiteRequest, false, $context);
		setSizeAPI($dbLink,$id,strlen($json));
		
		if ( $json === FALSE )
		{
			$result = c_mysqli_call($dbLink, "snigol_updateAttempt", dbsanitize($dbLink,$Snigol_ID) . ',-999');	   
			echo "PULL FAILED<BR>\r\n";
			return "AUTH_THROTTLED"; //WE FAILED!
		}
		$obj = json_decode($json);
		
		$Hits = $obj->hits->total;
			
		if ( $Hits === 0 ) //We have no hits
		{
			$result = c_mysqli_call($dbLink, "snigol_updateAttempt", dbsanitize($dbLink,$Snigol_ID) . ',1');	   
			return 'AUTH_CLEAN';
		}
		else if ( $Hits === 1 )
		{
			$result = c_mysqli_call($dbLink, "snigol_updateAttempt", dbsanitize($dbLink,$Snigol_ID) . ',2');	   
			return 'AUTH_MATCH';
		}
		else
		{
			$result = c_mysqli_call($dbLink, "snigol_updateAttempt", dbsanitize($dbLink,$Snigol_ID) . ',-1');	   
			return 'AUTH_FAILED';
		}
		}
	}
?>