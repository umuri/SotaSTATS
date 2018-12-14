<?php
	require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php');
	$pageRequested =  $_REQUEST["p"];
    //$result = c_mysqli_call($dbLink, "getSceneDisplayName", "'".$desired_map."'");
	//$mapName = $result[0]["DisplayName"];
?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>SotaSTATS - Stats</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	</head>
	<body>
		<div id="page-wrapper">
			<?php $currentPage = "stats"; ?>
			<?php include("header.php"); ?>
			<? if ( ISSET($_REQUEST["p"] ) ) 
			{
					include("stats/" . $pageRequested . ".php" );
			}
			else
			{
				@include("stats/main.php");
			}
			?>
			<?php include("footer.php"); ?>
		</div>

		<!-- Scripts -->
			<script src="assets/js/jquery.min.js"></script>
			<script src="assets/js/skel.min.js"></script>
			<script src="assets/js/skel-viewport.min.js"></script>
			<script src="assets/js/util.js"></script>
			<!--[if lte IE 8]><script src="assets/js/ie/respond.min.js"></script><![endif]-->
			<script src="assets/js/main.js"></script>

	</body>
</html>