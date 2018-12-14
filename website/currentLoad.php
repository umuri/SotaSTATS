<?php
$cachepath = getcwd();
$cachepath = "" . $cachepath . "/cache/" . basename(__FILE__, '.php') . ".html";
if ( isset($_GET['cacheoff']))
{
$CacheOff = $_GET['cacheoff'];
}
else
{
	$CacheOff = false;
}
	

if ( $CacheOff != 1)
{
if ( file_exists( $cachepath ) ) 
{
	$FileModTime = filemtime($cachepath);
	$FileAge = time() - $FileModTime;
	if ( $FileAge <= 600 ) //Reloads every 10 mintues
	{
		readfile ( $cachepath );
		return;
	}
}
}

require_once('../ucfg/dbInclude.php');
//   if there is not a cached version start output buffering
ob_start();
?>
<div>
Current Load in the past Hour:<br>
<?php

	$args = '0';
	$result = c_mysqli_call($dbLink, "stats_siteLoad", $args);

	$data = $result;	
    
	if ( $result )
	{	
		echo '<table border="1"><tr><th>API Calls</th><th>Data Size</th></tr>';
    //this creates a variable named $query_data and fills it with the information from the first row. using a	while statement, this will repeat for each row the table contains.
		foreach ( $result as $row) 
		{
			echo '<tr><td>'. $row['Count'] . '/600('. round($row['Count']/600*100,2).'%)</td><td>' . round((($row['Size']/1024)/1024),2)  . 'mb/120mb('.round((($row['Size']/1024)/1024)/120*100,2).'%)</td></tr>';
		}
		
		echo '</table><br>';
	}
	
	echo 'Current Load in the past 24 Hours:<br>';
	$args = '1';
	$result = c_mysqli_call($dbLink, "stats_siteLoad", $args);

	$data = $result;	
	if ( $result )
	{
		echo '<table border="1"><tr><th>API Calls</th><th>Data Size</th></tr>';
    //this creates a variable named $query_data and fills it with the information from the first row. using a	while statement, this will repeat for each row the table contains.
		foreach ( $result as $row) 
		{
			echo '<tr><td>'. $row['Count'] . '/14400('. round($row['Count']/14400*100,2).'%)</td><td>' . round((($row['Size']/1024)/1024),2)  . 'mb/2880mb('.round((($row['Size']/1024)/1024)/2880*100,2).'%)</td></tr>';
		}
		
		echo '</table>';
	}
	
	
	
	
	
	
?>
	
</div>

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