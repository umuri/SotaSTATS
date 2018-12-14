<?php 

	//FILL IN HERE
	$hostname = "";
	$username = "";
	$password = "";
	$database = "sotaapi";
	
	mysql_connect($hostname,$username,$password);
	mysql_select_db($database);
	date_default_timezone_set('UTC');
	
	$dbLink = new mysqli($hostname, $username, $password, $database);
	$GLOBALS['dblink'] = $dbLink;

	function c_mysqli_query(mysqli $dbLink, $query)
	{
		if(!$dbLink) {
			throw new Exception("The MySQLi connection is invalid.");
		}
		 else
		{
        // Execute the SQL command.
        // The multy_query method is used here to get the buffered results,
        // so they can be freeded later to avoid the out of sync error.
        $sql = "$query";
        
		
        if( $result = $dbLink->query($sql) )
        {
			
          
			
			$output = array();
			// Put the rows into the outpu array
			while($row = $result->fetch_assoc())
			{
				$output[] = $row;
			}
			
			//$result->close();
			$result->free();
			return $output;
			
        }
        else
        {
            throw new Exception("The call failed: " . $dbLink->error);
        }
    }
	}
	function c_mysqli_call(mysqli $dbLink, $procName, $params="")
	{
    if(!$dbLink) {
        throw new Exception("The MySQLi connection is invalid.");
    }
    else
    {
        // Execute the SQL command.
        // The multy_query method is used here to get the buffered results,
        // so they can be freeded later to avoid the out of sync error.
        $sql = "CALL {$procName}({$params});";
        $sqlSuccess = $dbLink->multi_query($sql);
        if($sqlSuccess)
        {
            if($dbLink->more_results())
            {
                // Get the first buffered result set, the one with our data.
                $result = $dbLink->use_result();
                $output = array();
                // Put the rows into the outpu array
                while($row = $result->fetch_assoc())
                {
                    $output[] = $row;
                }
                // Free the first result set.
                // If you forget this one, you will get the "out of sync" error.
                $result->free();
                // Go through each remaining buffered result and free them as well.
                // This removes all extra result sets returned, clearing the way
                // for the next SQL command.
                while($dbLink->more_results() && $dbLink->next_result())
                {
                    $extraResult = $dbLink->use_result();
                    if($extraResult instanceof mysqli_result){
                        $extraResult->free();
                    }
                }
                return $output;
            }
            else
            {
                return false;
            }
        }
        else
        {
            throw new Exception("The call failed: " . $dbLink->error);
        }
    }
}

	
	function checkLoad(mysqli $dbLink)
	{
		$result = c_mysqli_call($dbLink, 'checkLoadBalancer', "");
		//echo var_dump($result);
		if($result) {
			//echo "Output: \n";
			foreach($result as $_row) {
				return $_row['varTimeWait']; //echo " " . $_row['varTimeWait'] . "\n";
			}
		}
		
	}
	
	function fetchAPI(mysqli $dbLink, $SiteRequest)
	{
		
		
		
		
		$result = c_mysqli_call($dbLink, 'newLoadBalancerQuery', "'".mysql_real_escape_string($SiteRequest) . "'");
		if($result) {
			foreach($result as $_row) {
				return $_row['id'];
			}
		}
		
	}
	
	function setSizeAPI(mysqli $dbLink, $id, $querySize)
	{
		
		
		$result = c_mysqli_call($dbLink, 'setLoadBalancerQuerySize', $id ."," . $querySize);
		//echo var_dump($result);
		if($result) {
			//echo "Output: \n";
			foreach($result as $_row) {
				//echo " " . $_row['varTimeWait'] . "\n";
			}
		}
	
		
	}

	function better_error_handler($errno, $errstr, $errfile, $errline, $errcontext) {
		if (error_reporting() !== 0) {
			echo "[DIL:" . $errfile . "," . $errline . "] " . $errstr . "<br>";
		}
		$args = "'dbIncludeLoad','".mysql_real_escape_string($errstr) . "',"
		. mysql_real_escape_string($errno) . ",'"
		. mysql_real_escape_string($errfile) . "',"
		. mysql_real_escape_string($errline) . "";
		
		$result = c_mysqli_call($GLOBALS['dblink'] , 'log_error', $args);
		
		return true;
	}
	
	set_error_handler("better_error_handler");
	
	

	?>