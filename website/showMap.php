<?php
$cachepath = getcwd();
require_once('../ucfg/dbInclude.php');
$desired_map =  mysqli_real_escape_string($dbLink, $_GET["SceneName"]);
$desired_scheme =  mysqli_real_escape_string($dbLink, $_GET["CS"]);
$cachepath = "" . $cachepath . "/cache/maps/" . $desired_map . "-" . $desired_scheme . ".png";
$CacheOff = $_GET['cacheoff'];
if ( $CacheOff != 1)
{
	if ( file_exists( $cachepath ) ) 
	{
		$FileModTime = filemtime($cachepath);
		$FileAge = time() - $FileModTime;
		
		//Map files never expire
		header("Content-type: image/png");
		readfile ( $cachepath );
		exit();
		
	}
}


//   if there is not a cached version start output buffering
ob_start();
?>
<?php
// This is a test script demonstrating the use of the gd-heatmap library.
require_once('Includes/gd_heatmap.php');


	$desired_map =  mysqli_real_escape_string($dbLink, $_GET["SceneName"]);
	$desired_scheme =  mysqli_real_escape_string($dbLink, $_GET["CS"]);
	
	switch ($desired_scheme) {
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
		
	if ( empty($desired_map) )
	{
		echo 'Map parameter missing';
		return;
	}
	
	//$query = "select xpos as '0', ypos as '2', zpos as '1' from LogEvent where SceneName = '" . $desired_map . "'and xpos is not null LIMIT 75000";
	$query = "select x as '0', Count(x) as '2',  z as '1' from LogEvent L 
	join SceneNames S 
	on L.SceneName = S.ID where S.DisplayName =  '" . $desired_map . "' and x is not null group by x,z LIMIT 75000";
    $result = mysql_query($query) or die ("Statistics Error: ".mysql_error());
		
		$sceneList = array(); 
		
	$xmax = 0;
	$xmin = 0;
	$zmax = 0;
	$zmin = 0;
	//this if makes sure there is information in the table. if there isn't, there will be no output.
		if (mysql_num_rows($result) > 0)
		{	
			$index = 0;
			while($row = mysql_fetch_assoc($result)){ // loop to store the data in an associative array.
				$sceneList[$index] = $row;
				if ( $sceneList[$index][0] > $xmax ) { $xmax = $sceneList[$index][0]; }
				if ( $sceneList[$index][0] < $xmin ) { $xmin = $sceneList[$index][0]; }
				if ( $sceneList[$index][1] > $zmax ) { $zmax = $sceneList[$index][1]; }
				if ( $sceneList[$index][1] < $zmin ) { $zmin = $sceneList[$index][1]; }
				$index++;
			}

		}		
		if ( $xmax > (-1*$xmin) )
		{
			$xradius = $xmax;
		}
		else 
		{
			$xradius = $xmin*-1;
		}
		if ( $zmax > (-1 * $zmin ))
		{
			$zradius = $zmax;
		}
		else 
		{
			$zradius = $zmin*-1;
		}
		
		$xoffset = $xradius;
		$zoffset = $zradius;
		
		foreach ($sceneList as &$entry)
		{
			$entry[0] += $xoffset;
			$entry[1] += $zoffset;
		}
		
		
		//TRANSFORMATION to make map point in the right f'ing direction:
		foreach ($sceneList as &$entry)
		{
			$temp = $entry[0];
			$entry[0] = $entry[1]+25;
			$entry[1] = (($xradius*2)-$temp)+25;
		}
		
		$data = $sceneList;
		//echo var_dump($data);		
		// Generate some test data using the static function provided for that purpose.
		//$data = gd_heatmap::get_test_data(1240, 600, 50, 10);
		//echo var_dump($data);
		//return;
		// Config array with all the available options. See the constructor's doc block
		// for explanations.
		
		
$config = array(
  'debug' => FALSE,
  'width' => ($zradius*2)+50,
  'height' => ($xradius*2)+50,
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