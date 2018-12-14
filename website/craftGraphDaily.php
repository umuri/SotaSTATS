<?php
$cachepath = getcwd();
require_once('../ucfg/dbInclude.php');
$args = '' . dbsanitize($dbLink, $_GET["Archetype"]) . ',2';
$cacheName = preg_replace("/[^a-z0-9\_\.]/", "", strtolower($_GET["Archetype"]));			
$cachepath = "" . $cachepath . "/cache/" . $cacheName . "-daily.png";
$CacheOff = $_GET['cacheoff'];

if ( $CacheOff != 1)
{
if ( file_exists( $cachepath ) ) 
{
	$FileModTime = filemtime($cachepath);
	$FileAge = time() - $FileModTime;
	if ( $FileAge <= 86400 ) //Reloads only once per day
	{
		header("Content-type: image/png");
		readfile ( $cachepath );
		return;
	}
}
}


//   if there is not a cached version start output buffering
ob_start();

?><?php
require_once($_SERVER['DOCUMENT_ROOT'] . '/Includes/phpgraphlib.php'); 
$graph = new PHPGraphLib(650,200);


    $result = c_mysqli_call($dbLink, "stats_archetype_NetChange", $args);
	
	$data = array();
	$sumdata = array();
	$count = 0;
	$total = 0;
	foreach ( $result as $_row)
	{
		$key = substr($_row["timestamp"],5);
		$key = substr($key,3,2) . '-' . substr($key,0,2);
		$value = $_row["Quantity"];
		$total = $total + $value;
		$data[$key]=$value;
		$sumdata[$key]=$total;
	}
$graph->addData($data,$sumdata);
$graph->setTitle('Daily Net Quantity (Created/Crafted - Used/Destroyed)');
$graph->setTitleColor('gray');
$graph->setTitleLocation('left');
$graph->setGrid(false);
$graph->setGridColor('blue');
$graph->setBars(false);
$graph->setBackgroundColor('#262626');
$graph->setLine(true);
$graph->setLineColor('blue','green');
$graph->setupXAxis(35);
$graph->setXValuesInterval(3);
$graph->setDataPoints(false);
$graph->setDataPointColor('blue');
$graph->setDataValues(false);
$graph->setDataValueColor('blue');
$graph->setGoalLine(0);
$graph->setGoalLineColor('yellow');
$graph->setLegend(true);
$graph->setLegendColor('#262626');
$graph->setLegendTitle('Daily Net', 'Cumulative' );

$graph->createGraph();
?><?php
$bufferContent = ob_get_contents();
   //   get buffer content
ob_end_flush();
   //   clean and display buffer content in the browser
$fp = fopen( $cachepath , "w" ) or die("Error opening cache file");
   //  write buffer content to cache file
fwrite( $fp , $bufferContent );
fclose( $fp );
?>