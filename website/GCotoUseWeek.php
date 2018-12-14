<?php
$cachepath = getcwd();
require_once('../ucfg/dbInclude.php');
$cacheName = "GCotoUseWeek";			
$cachepath = "" . $cachepath . "/cache/" . $cacheName . ".png";
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
require_once($_SERVER['DOCUMENT_ROOT'] . '/Includes/phpgraphlib_stacked.php'); 
$graph = new PHPGraphLibStacked(650,300);

	$args = '';
    $result = c_mysqli_call($dbLink, "stats_misc_CotoUseWeekly", $args);
	
	$BlankData = array();
	$GainedData = array();
	$OfferData = array();
	$LostData = array();
	$LostMerchantData = array();
	
	$max = 0;
	$min = 0;
	$count = 0;
	$total = 0;
	foreach ( $result as $_row)
	{
		$key = substr($_row["timestamp"],5);
		$key = substr($key,3,2) . '-' . substr($key,0,2);
		$value = $_row["Quantity"];
		switch( $_row["LocationEvent"] ) {
			case 'ItemGained_Crafting':
			case 'ItemGained_Loot':
			$GainedData[$key]+=$value;
			break;
			case 'ItemGained_Offer':
			$OfferData[$key]+=$value;
			break;
			case 'ItemDestroyed_Crafting':
			$LostData[$key]+=$value;
			$BlankData[$key]-=$value;
			break;
			case 'ItemDestroyed_CrownMerchant':
			$LostMerchantData[$key]+=$value;
			$BlankData[$key]-=$value;
			break;
			
		}
	}
	$GainedData['END'] = 0;
	//$OfferData['TEST'] = 100;
	//$LostData['TEST'] = 100;
	//$LostMerchantData['TEST'] = 300;
	//$BlankData['TEST'] = -400;
	foreach ($BlankData as $key=>$value)
	{
		if ($BlankData[$key] < $min ) { $min = $BlankData[$key] * 1.1; }
		if ($GainedData[$key] + $OfferData[$key] > $max ) { $max = ($GainedData[$key] + $OfferData[$key]); }
	}
	$max = (round($max/100)+1)*100;
	$min = (round($min/100)-1)*100;
	
//$graph->addData($BlankData, $LostData, $GainedData);
$graph->addData( $GainedData,$OfferData,$LostData,$LostMerchantData, $BlankData);
$graph->setRange($max,$min);
$graph->setTitle('GCotos Gain/Loss');
$graph->setTitleColor('gray');
$graph->setTitleLocation('left');
$graph->setGrid(false);
$graph->setGridColor('blue');
$graph->setBackgroundColor('#262626');
$graph->setBarColor('blue','green', 'red', '#dc7633','gray');
$graph->setupXAxis(35);
$graph->setXValuesInterval(3);
//$graph->setGoalLine(0);
//$graph->setGoalLineColor('yellow');
$graph->setLegend(true);
$graph->setLegendColor('#262626');
$graph->setLegendTitle('Gained', 'Bank Claimed', 'Spent', 'CrownMerchant', '');

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