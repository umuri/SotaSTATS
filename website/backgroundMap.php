<?php
$cachepath = getcwd();
include '../ucfg/dbInclude.php';
$desired_map =  mysqli_real_escape_string($dbLink, $_GET["SceneName"]);
$cachepath = "" . $cachepath . "/backs/" . $desired_map . ".png";
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


	$desired_map =  mysqli_real_escape_string($dbLink, $_GET["SceneName"]);
	
        $desired_scheme = 36;
    
		
	if ( empty($desired_map) )
	{
		echo 'Map parameter missing';
		return;
	}
	
	
	
	//$query = "select xpos as '0', ypos as '2', zpos as '1' from LogEvent where SceneName = '" . $desired_map . "'and xpos is not null LIMIT 75000";
    $result = c_mysqli_call($dbLink, "generateMap", "'".$desired_map."'");
		
	$data = $result;
	
	$result = c_mysqli_call($dbLink, "getMapWidthHeight", "'".$desired_map."'");
	
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
  'r' => 25,
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