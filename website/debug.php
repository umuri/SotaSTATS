<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<?php 


if ( $_SERVER['REMOTE_ADDR'] == '68.227.124.96' )
{
	//$LoggedInUser = sotastats_login($dbLink, 'Umuri Maxwell');
	//$loggedIn = true;
	//$_SESSION["loggedIn"]=0;
	echo $token = hash('sha512',$_COOKIE["token"],false);
	echo "<pre>" . print_r($_SESSION) . "</pre><br>";
	echo "<pre>" . print_r($_COOKIE) . "</pre><br>";
	echo "<pre>" . print_r($_REQUEST) . "</pre><br>";
	
	
}
echo $_SERVER['REMOTE_ADDR'] . '<br>';
?>