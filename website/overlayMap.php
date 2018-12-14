<?php

$cachepath = getcwd();
require_once('../ucfg/dbInclude.php');
$args = '' . dbsanitize($dbLink, $_GET["StartTimestamp"])
			 . ',' . dbsanitize($dbLink, $_GET["EndTimestamp"])
			 . ',' . dbsanitize($dbLink, $_GET["SceneName"])
			. ',' . dbsanitize($dbLink, $_GET["Killer"])
			. ',' . dbsanitize($dbLink, $_GET["Victim"])
			. ',' . dbsanitize($dbLink, $_GET["PlayerName"])
			. ',' . dbsanitize($dbLink, $_GET["Archetype"])
			. ',' . dbsanitize($dbLink, $_GET["ItemID"])
			. ',' . dbsanitize($dbLink, $_GET["LocationEvent"]);
			
		
			
$SceneName =  mysqli_real_escape_string($dbLink, $_GET["SceneName"]);
$CS =  mysqli_real_escape_string($dbLink, $_GET["CS"]);
if ( empty($CS) ) { $CS = 1; }
$cachepath = "" . $cachepath . "/overlays/" . $SceneName . '-' . hash('sha256', $args) . '-' . $CS . ".png";
$CacheOff = $_GET['cacheoff'];

if ( $CacheOff != 1)
{
if ( file_exists( $cachepath ) ) 
{
	$FileModTime = filemtime($cachepath);
	$FileAge = time() - $FileModTime;
	if ( $FileAge <= 604800 ) //Reloads only once per week
	{
		header("Content-type: image/png");
		readfile ( $cachepath );
		return;
	}
}
}


//   if there is not a cached version start output buffering
ob_start();
?>
<?php
// This is a test script demonstrating the use of the gd-heatmap library.
require_once('Includes/gd_heatmap.php');

    
	switch ($CS) {
    case 1:
        $desired_scheme = 32;
		break;
    case 2:
        $desired_scheme = 31;
        break;
    case 3:
        $desired_scheme = 35;
        break;
	case 4:
        $desired_scheme = 34;
        break;
	case 5:
        $desired_scheme = 33;
        break;
	case 6:
        $desired_scheme = 36;
        break;
	case 7:
        $desired_scheme = 37;
        break;
	default:
	    $desired_scheme = 32;
		break;
	}
		
	if ( empty($SceneName) )
	{
		echo 'SceneName missing';
		return;
	}
	

	
    $result = c_mysqli_call($dbLink, "checkMapBackgroundMade", "'".$SceneName."'");
	while ( $result[0]["made"] == false )
	{
			sleep(5);
			$result = c_mysqli_call($dbLink, "checkMapBackgroundMade", "'".$SceneName."'");
	}		
	

			
	
	$result = c_mysqli_call($dbLink, "getCodexOverlay", $args);
									
	$data = $result;
	
	$result = c_mysqli_call($dbLink, "getMapWidthHeight", "'".$SceneName."'");
	
	$mapWidth = $result[0][width];
	$mapHeight = $result[0][height];
		//echo var_dump($data);		
		// Generate some test data using the static function provided for that purpose.
		//$data = gd_heatmap::get_test_data(1240, 600, 50, 10);
		//echo var_dump($data);
		//return;
		// Config array with all the available options. See the constructor's doc block
		// for explanations.
		
		
$config = array(
  'debug' => FALSE,
  'width' => $mapWidth,
  'height' => $mapHeight,
  'noc' => $desired_scheme,
  'r' => 20,
  'dither' => FALSE,
  'format' => 'png',
);

// Create a new heatmap based on the data and the config.
$heatmap = new gd_heatmap($data, $config);

// And print it out. If you're having trouble getting any images out of the
// library , comment this out to allow your browser to show you the error
// messages.
$heatmap->output();

// Or save it to a file. Don't forget to set correct file permissions in the
// target directory.
?>
<?php
$bufferContent = ob_get_contents();
   //   get buffer content
ob_end_flush();
   //   clean and display buffer content in the browser
$fp = fopen( $cachepath , "w" ) or die("Error opening cache file");
   //  write buffer content to cache file
fwrite( $fp , $bufferContent );
fclose( $fp );
?>