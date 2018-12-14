<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<?php


if (isset($_REQUEST['SceneName']) == true )
{
	$desired_map =  mysqli_real_escape_string($dbLink, $_REQUEST["SceneName"]);
    $result = c_mysqli_call($dbLink, "getSceneDisplayName", "'".$desired_map."'");
	$mapName = $result[0]["DisplayName"];
}
else
{
	$_REQUEST['SceneName']='';
}


if ( isset($_REQUEST['CS']) == true )
{
	$CS = $_REQUEST['CS'];
}
else
{
	$_REQUEST['CS']=1;
}

if ( isset($_SESSION["MapDefault"]) == true )
{
	$MapDefault = $_SESSION["MapDefault"];
}
else
{
	$_SESSION["MapDefault"]='';
}


?>
<html>
	<head>
		<title>SotaSTATS - Maps</title>
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
			<?php $currentPage = "maps"; ?>
			<?php include("header.php"); ?>
			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">

							<section>
								<h2>Select Map</h2>
								<ul class="small-image-list">
									<li>
										Maps:<br>
											<form action="/maps.php" method="get">
												<div>
												<input id="SNL" type="text" name="SceneName" size="30" class="form-control" placeholder="Type Scene" <?php if (!empty($_REQUEST['SceneName'])) { echo 'value="'.$_REQUEST['SceneName'].'"'; } ?>>
												</div>
												<input type="submit" value="GO"><br>
												<input type="radio" name="CS" value="1" <?php if (( $_REQUEST['CS'] == 1 ) || ( empty($_REQUEST['CS'] ) && $_SESSION["MapDefault"] == 1 ) ) { echo "checked"; } ?>> <img src="gradient-32.png"><br>
												<input type="radio" name="CS" value="2" <?php if (( $_REQUEST['CS'] == 2 ) || ( empty($_REQUEST['CS'] ) && $_SESSION["MapDefault"] == 2 )) { echo "checked"; } ?>> <img src="gradient-31.png"><br>
												<input type="radio" name="CS" value="3" <?php if (( $_REQUEST['CS'] == 3 ) || ( empty($_REQUEST['CS'] ) && $_SESSION["MapDefault"] == 3 )) { echo "checked"; } ?>> <img src="gradient-35.png"><br>
												<input type="radio" name="CS" value="7" <?php if (( $_REQUEST['CS'] == 7 ) || ( empty($_REQUEST['CS'] ) && $_SESSION["MapDefault"] == 7 )) { echo "checked"; } ?>> <img src="gradient-37.png"><br>
											</form>
										<script>
										$('#SNL').autocomplete({
											source: "afGetScenes.php",
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
												<li>
												<form method="get" action="maps.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"]?>">
												  <input type="hidden" name="CS" value="<?php echo $_REQUEST["CS"]?>">
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
													Reload Map
												  </button>
												</form>
												</li>
												<li>
													<form method="get" action="maps.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"]?>">
												  <input type="hidden" name="CS" value="<?php echo $_REQUEST["CS"]?>">
												  <button type="submit" name="submit_param" value="submit_value" class="link-button">
													Reload Map
												  </button></li>
												<li><a href="#">Quis accumsan lorem</a></li>
												<li><a href="#">Suspendisse varius ipsum</a></li>
												<li><a href="#">Eget et amet consequat</a></li>
											</ul>
										</div>
									</div>
								</div>
							</section>

						</div>
						<div class="10u 12u(mobile) important(mobile)">

							<section class="right-content">
							<?php
							
							function data_uri($file, $mime) 
							{  

							  $contents = file_get_contents($file);
							  $base64   = base64_encode($contents); 
							  return ('data:' . $mime . ';base64,' . $base64);
							}
							?>


								<h2><?php If (!empty($_REQUEST['SceneName'])) { echo $mapName;} else { echo "Select a map"; } ?></h2>
								<?php If ( ( !empty($_REQUEST['SceneName']) ) && ( $_REQUEST['SceneName'] != "") ) {?>
								<img src="<?php echo data_uri('http://sotastats.umuri.com/showMap.php?SceneName='.urlencode($_REQUEST['SceneName']).'&CS='.$_REQUEST['CS'],'image/png'); ?>" alt="LOADING..." class="right" style="max-width:100%;height: auto;" />
								<br><br>
								<?php }
								else //We have no map selected, display list.
								{
									$result = c_mysqli_call($dbLink,"fsGetSceneNames","''");
									if($result) {
	
									$countDivisor = 3;
									$count = 0;
									echo '<br>Maps:<br><div style="overflow-x:auto;"><table class="bacon">';
									
									foreach ( $result as $_row )
									{
										if ( ($count % $countDivisor) == 0 )
										{
											echo '<tr>';
										}
										
										?>
										<td>
										<form method="GET" action="maps.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["value"] ?>">
												  <?php if (isset($_SESSION["MapDefault"] ))
												  {?>
													  <input type="hidden" name="CS" value="<?php echo $_SESSION["MapDefault"] ?>">
												  <?php } ?>
												  <button type="submit" class="link-button">
													<?php echo $_row["label"]; ?>
												  </button>
										</form>
										
										</td>
											  <?php												
										if ( ($count % $countDivisor) == ($countDivisor - 1) ) 
										{
										echo '</tr>';
										}
										$count += 1;
									}
									
									echo '</table></div>';
									}
								}									?>
								
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