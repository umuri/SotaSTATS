<?php

require_once($_SERVER['DOCUMENT_ROOT'] . '/../ucfg/dbInclude.php'); 

function sec_session_start() {
    $session_name = 'SotaSTATSLogin';   // Set a custom session name
    /*Sets the session name. 
     *This must come before session_set_cookie_params due to an undocumented bug/feature in PHP. 
     */
    session_name($session_name);
 
    $secure = true;
    // This stops JavaScript being able to access the session id.
    $httponly = true;
    // Forces sessions to only use cookies.
    if (ini_set('session.use_only_cookies', 1) === FALSE) {
        header("Location: ../error.php?err=Could not initiate a safe session (ini_set)");
        exit();
    }
    session_set_cookie_params(18000,
        '/', 
        '', 
        true,
        true);
 
    session_start();            // Start the PHP session 
}

function validate_user_cookies(mysqli $dbLink, $series, $authToken)
{
	$token = hash('sha512',$authToken,false);
	
	 $result = c_mysqli_call($dbLink, "snigol_checkToken", "'" . mysqli_real_escape_string($dbLink,$series) . "','" . mysqli_real_escape_string($dbLink,$token) . "'");
	
	 if ( isset($result[0]["CharName"]) )
	 {
		 session_regenerate_id(true);    // regenerated the session, delete the old one. 
		 $token = openssl_random_pseudo_bytes(128);
		 $newToken = hash('sha512',$token,false);
		 setcookie('token', $token, time() + (86400 * 30), "/", "sotastats.umuri.com", true, true);
		  $updateResult = c_mysqli_call($dbLink, "snigol_updateToken", "'".mysqli_real_escape_string($dbLink,$series) ."','" . mysqli_real_escape_string($dbLink,$newToken) . "'");
		 //Successful Authentication
		
		 $_SESSION["userName"] = $result[0]["CharName"];
		 $_SESSION["loggedIn"] = true;
		 $loggedIn = true;
		$LoggedInUser = $_SESSION["userName"];
		 return true;
	 }
	 
	 return false;
}

function sotastats_login(mysqli $dbLink,$user)
{
	if ( !isset($_SESSION["userName"]) )
	{
		$result = c_mysqli_call($dbLink, "snigol_getSeries", "'" . mysqli_real_escape_string($dbLink,$user) . "'");
		$series = $result[0]["Series"];
		
		setcookie('series', $series, time() + (86400 * 30), "/", "sotastats.umuri.com", true, true);
		$_COOKIE['series'] = $series;
		$token = openssl_random_pseudo_bytes(128);
		$newToken = hash('sha512',$token,false);
		setcookie('token', $token, time() + (86400 * 30), "/", "sotastats.umuri.com", true, true);
		$_COOKIE['token'] = $token;
		$result = c_mysqli_call($dbLink, "snigol_updateToken", "'" . mysqli_real_escape_string($dbLink,$series) . "','" . mysqli_real_escape_string($dbLink,$newToken) . "'");
		
		
		//Successful Authentication
		session_regenerate_id(true);    // regenerated the session, delete the old one. 
		$_SESSION["userName"] = $user;
		$_SESSION["loggedIn"] = true;
		
		$result = c_mysqli_call($dbLink, "user_getSettings", "'" . mysqli_real_escape_string($dbLink,$user) . "'");
		
		foreach ($result as $_row)
		{
			$_SESSION[$_row["Setting"]] = $_row["Value"];
		}
		return $_SESSION["userName"];
	}
	else
	{
		return $_SESSION["userName"];
	}
}

function sotastats_logout(mysqli $dbLink)
{
	setcookie('series', $series, time() - 3600, "/", "sotastats.umuri.com", true, true);
	$_COOKIE['series'] = null;
	setcookie('token', $token, time() - 3600, "/", "sotastats.umuri.com", true, true);
	$_COOKIE['token'] = null;
	session_unset();
}

sec_session_start();

$loggedIn = false;


IF ((isset($_SESSION["loggedIn"])) && ( $_SESSION["loggedIn"] == true ))
{
	$loggedIn = true;
	$LoggedInUser = $_SESSION["userName"];
}

else
{
	
	if ( isset($_COOKIE['series']) && isset($_COOKIE['token']))
	{
		if ( validate_user_cookies($dbLink, $_COOKIE['series'], $_COOKIE['token']) )
		{
			$loggedIn = true;
			$LoggedInUser = $_SESSION["userName"];
		}
	}		
}





if ( session_status() == PHP_SESSION_ACTIVE ) {
  //echo '<br>Session is active<br>' . $loggedIn . ' as login status<br>' . $LoggedInUser . ' as LoggedInUser<br>';
}
?>