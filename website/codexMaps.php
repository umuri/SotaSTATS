<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<?php
	require_once('../ucfg/dbInclude.php');
	$StartTimestamp =  mysqli_real_escape_string($dbLink, $_REQUEST["StartTimestamp"]);
	if ( empty($StartTimestamp) )
	{
		//24 hours ago
		$StartTimestamp = date('Y-m-d H:i:s', time() - ( 24 * 60 * 60));
	}
	$EndTimestamp =  mysqli_real_escape_string($dbLink, $_REQUEST["EndTimestamp"]);
	if ( empty($EndTimestamp)  )
	{
		$EndTimestamp = date('Y-m-d H:i:s', time());
	}
	$SceneName =  mysqli_real_escape_string($dbLink, $_REQUEST["SceneName"]);
	$Killer =  mysqli_real_escape_string($dbLink, $_REQUEST["Killer"]);
	$Victim =  mysqli_real_escape_string($dbLink, $_REQUEST["Victim"]);
	$PlayerName =  mysqli_real_escape_string($dbLink, $_REQUEST["PlayerName"]);
	$Archetype =  mysqli_real_escape_string($dbLink, $_REQUEST["Archetype"]);
	$ItemID =  mysqli_real_escape_string($dbLink, $_REQUEST["ItemID"]);
	$LocationEvent =  mysqli_real_escape_string($dbLink, $_REQUEST["LocationEvent"]);
	$CS =  mysqli_real_escape_string($dbLink, $_REQUEST["CS"]);
	
	
	
	if (empty($CS)) { 
	if ( isset($_SESSION["MapDefault"] ))
	{
		$CS = $_SESSION["MapDefault"];
	}
	else
	{
		$CS = 1; 
		}
	}
	
	$DisplayStartTimestamp = htmlspecialchars($_REQUEST["StartTimestamp"]);
	$DisplayEndTimestamp = htmlspecialchars($_REQUEST["EndTimestamp"]);
	$DisplaySceneName = htmlspecialchars($_REQUEST["SceneName"]);
	$DisplayKiller = htmlspecialchars($_REQUEST["Killer"]);
	$DisplayVictim = htmlspecialchars($_REQUEST["Victim"]);
	$DisplayPlayerName = htmlspecialchars($_REQUEST["PlayerName"]);
	$DisplayArchetype = htmlspecialchars($_REQUEST["Archetype"]);
	$DisplayItemID = htmlspecialchars($_REQUEST["ItemID"]);
	$DisplayLocationEvent = htmlspecialchars($_REQUEST["LocationEvent"]);
	
	
?>
<html>
	<head>
		<title>SotaSTATS - Codex</title>
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
			<?php $currentPage = "codex"; ?>
			<?php include("header.php"); ?>
			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">

							<section>
								<h2>Options</h2>
								<ul class="small-image-list">
									<li>
										Codex Map Overlay Search:<br>
											<form id ="codexSearch" action="/codexMaps.php" method="get">
												<div>
													<input id="STSL" type="text" name="StartTimestamp" size="30" class="form-control" placeholder="Type Start Time" <?php if (!empty($StartTimestamp)) { echo 'value="'.$DisplayStartTimestamp.'"'; } ?>>
												</div>
												<div>
													<input id="ETSL" type="text" name="EndTimestamp" size="30" class="form-control" placeholder="Type End Time" <?php if (!empty($EndTimestamp)) { echo 'value="'.$DisplayEndTimestamp.'"'; } ?>>
												</div>
												<div>
													<input id="SNL" type="text" name="SceneName" size="30" class="form-control" placeholder="Type Scene" <?php if (!empty($SceneName)) { echo 'value="'.$DisplaySceneName.'"'; } ?>>
												</div>
												<div>
													<input id="ANL" type="text" name="Archetype" size="30" class="form-control" placeholder="Type Archetype" <?php if (!empty($Archetype)) { echo 'value="'.$DisplayArchetype.'"'; } ?>>
												</div>
												<div>
													<input id="IIDL" type="text" name="ItemID" size="30" class="form-control" placeholder="Type ItemID" <?php if (!empty($ItemID)) { echo 'value="'.$DisplayItemID.'"'; } ?>>
												</div>
												<div>
													<input id="PNL" type="text" name="PlayerName" size="30" class="form-control" placeholder="Type PlayerName" <?php if (!empty($PlayerName)) { echo 'value="'.$DisplayPlayerName.'"'; } ?>>
												</div>
												<div>
													<input id="KL" type="text" name="Killer" size="30" class="form-control" placeholder="Type Killer" <?php if (!empty($Killer)) { echo 'value="'.$DisplayKiller.'"'; } ?>>
												</div>
												<div>
													<input id="VL" type="text" name="Victim" size="30" class="form-control" placeholder="Type Victim" <?php if (!empty($Victim)) { echo 'value="'.$DisplayVictim.'"'; } ?>>
												</div>
												<div>
													<input id="LEL" type="text" name="LocationEvent" size="30" class="form-control" placeholder="Type EventType" <?php if (!empty($LocationEvent)) { echo 'value="'.$DisplayLocationEvent.'"'; } ?>>
												</div><br>
												<input onclick="return CheckTimestamp();" type="submit" value="GO"><br>
												
											</form>
										<script>
										$('#SNL').autocomplete({
											source: "afGetScenes.php",
											minLength: 3
										});
										$('#ANL').autocomplete({
											source: "afGetArchetypes.php",
											minLength: 3
										});
										$('#LEL').autocomplete({
											source: "afGetEventTypes.php",
											minLength: 3
										});
										jQuery.ui.autocomplete.prototype._resizeMenu = function () {
										  var ul = this.menu.element;
										  ul.outerWidth(this.element.outerWidth());
										}
										
									
										</script>
									</li>
									<li>
										
									</li>
								</ul>
							</section>

							<section>
								<h2>Quick Options</h2>
								<div>
									<div class="row">
										<div class="12u 12u(mobile)">
											<ul class="link-list">
												
												<?php if ( !empty($SceneName) ) { ?>
												<li>
													<form method="get" action="maps.php" class="inline">
														<input type="hidden" name="SceneName" value="<?php echo $SceneName ?>">
														<input type="hidden" name="CS" value="1">
														<button type="submit" name="submit_param" value="submit_value" class="link-button">
															Map - <?php echo $DisplaySceneName ?>
														</button>
													</form>
												</li>
												<li>
													<form method="get" action="codex.php" class="inline">
														<input type="hidden" name="StartTimestamp" value="<?php echo $DisplayStartTimestamp ?>">
														<input type="hidden" name="EndTimestamp" value="<?php echo $DisplayEndTimestamp ?>">
														<input type="hidden" name="SceneName" value="<?php echo $DisplaySceneName ?>">
														<input type="hidden" name="Archetype" value="<?php echo $DisplayArchetype ?>">
														<input type="hidden" name="ItemID" value="<?php echo $DisplayItemID ?>">
														<input type="hidden" name="PlayerName" value="<?php echo $DisplayPlayerName ?>">
														<input type="hidden" name="Killer" value="<?php echo $DisplayKiller ?>">
														<input type="hidden" name="Victim" value="<?php echo $DisplayVictim ?>">
														<input type="hidden" name="LocationEvent" value="<?php echo $DisplayLocationEvent ?>">
														<input type="hidden" name="CS" value="1">
														<button type="submit" name="submit_param" value="submit_value" class="link-button">
															Codex Search - <?php echo $DisplaySceneName ?>
														</button>
													</form>
												</li>
												<?php } ?>
												
												
											</ul>
										</div>
									</div>
								</div>
							</section>

						</div>
						<div class="10u 12u(mobile) important(mobile)">

							<section class="right-content">
							<h2>Codex Overlay</h2>
							<?php
								function data_uri($file, $mime) 
								{  

								  $contents = file_get_contents($file);
								  $base64   = base64_encode($contents); 
								  return ('data:' . $mime . ';base64,' . $base64);
								}
									if ( empty($StartTimestamp) || empty($SceneName) || empty($LocationEvent) )
									{
										echo "You must fill in at least SceneName, Time, and EventType to use this";
									}
									else if ( abs(strtotime($StartTimestamp) - strtotime($EndTimestamp)) > 172800 ) //Two Days
									{
										echo '<font color="red">Please use a start/end time within 48 hours of each other (two days) at most</font>';
									}
									else
									{
									
										$args = "StartTimestamp=".urlencode($_REQUEST["StartTimestamp"])
										. "&EndTimestamp=" . urlencode($_REQUEST["EndTimestamp"])
										. "&SceneName=" . urlencode($_REQUEST["SceneName"])
										. "&Killer=" . urlencode($_REQUEST["Killer"])
										. "&Victim=" . urlencode($_REQUEST["Victim"])
										. "&PlayerName=" . urlencode($_REQUEST["PlayerName"])
										. "&Archetype=" . urlencode($_REQUEST["Archetype"])
										. "&ItemID=" . urlencode($_REQUEST["ItemID"])
										. "&LocationEvent=" . urlencode($_REQUEST["LocationEvent"]);
										
										
										
									//$result = c_mysqli_call($dbLink, "getSpecificCodex", $args);
									
									$backgroundImage = 'http://www.sotastats.umuri.com/backgroundMap.php?SceneName='.urlencode($DisplaySceneName);
									$overlayImage = 'http://www.sotastats.umuri.com/overlayMap.php?'.$args.'&CS='.$CS;
									//$data = $result;	
								
									//echo $backgroundImage . "<br>";
									//echo $overlayImage . "<br>";
							?>

								
								<h2><?php If (!empty($SceneName)) { echo $DisplaySceneName;} else { echo "Select a map"; } ?></h2>
								<?php If ( !empty($SceneName) ) { ?>
									<img style="background:url(<?php echo data_uri($backgroundImage,'image/png'); ?>" 
									src="<?php echo data_uri($overlayImage,'image/png'); ?>"  
									alt="LOADING..." class="right" style="max-width:100%;height: auto;" />	
								<br><br>
								<?php } ?>
							
									<?php } ?>	
							</section>

						</div>
					</div>
				</div>
			</div>
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