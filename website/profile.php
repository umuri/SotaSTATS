<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<?php

	if ( isset($_POST['SetMapDefault'] )  && (  $loggedIn ) )
	{
		$args = dbsanitize($dbLink,$LoggedInUser);
		$args .=  ",'MapDefault'";
		$args .=  "," . dbsanitize($dbLink,$_POST['SetMapDefault']);
		
		$result = c_mysqli_call($dbLink, "user_setSetting", $args);
								
		$data = $result;	
		$_SESSION['MapDefault'] = $_POST['SetMapDefault'];
	}
	
?>
<html>
	<head>
		<title>SotaSTATS - Profile</title>
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
			<?php $currentPage = "profile"; ?>
			<?php include("header.php"); 
			if (  $loggedIn )
			{?>			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">

							<section>
								<h2>Options</h2>
								<ul class="small-image-list">
									<li>
									<form action="/login.php" method="POST">
												<div>
												<input id="Logout" type="hidden" name="Logout" size="30" class="form-control" value="true">
												</div>
												<input type="submit" value="LOGOUT"><br>
												<br>
											</form>	
									</li>
								</ul>
							</section>

							

						</div>
						<div class="10u 12u(mobile) important(mobile)">

							<section class="right-content">
							<h2>Profile for <?php echo $LoggedInUser ?></h2>
							Map default colorscheme:<br>
											<form action="/profile.php" method="POST">
												
												<input type="radio" name="SetMapDefault" value="1" <?php if (( $_SESSION['MapDefault'] == 1 ) || ( empty($_SESSION['MapDefault'] )) ) { echo "checked"; } ?>> <img src="gradient-32.png" height="15">
												<input type="radio" name="SetMapDefault" value="2" <?php if ( $_SESSION['MapDefault'] == 2 ) { echo "checked"; } ?>> <img src="gradient-31.png" height="15"><br>
												<input type="radio" name="SetMapDefault" value="3" <?php if ( $_SESSION['MapDefault'] == 3 ) { echo "checked"; } ?>> <img src="gradient-35.png" height="15">
												<input type="radio" name="SetMapDefault" value="7" <?php if ( $_SESSION['MapDefault'] == 7 ) { echo "checked"; } ?>> <img src="gradient-37.png" height="15"><br>
												<input type="submit" value="Change Default"><br>
											</form>
							
							<h2>Kills (30 days)	</h2>
									<?php
									
								
									$args = dbsanitize($dbLink, $LoggedInUser);
									
									$result = c_mysqli_call($dbLink, "stats_player_kills_month", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Scene</th><th>Monster</th><th>Kills</th></tr>';
										foreach ( $data as $_row )
										{
											?>
											
											<tr>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["SceneName"] ?>">
												  <input type="hidden" name="p" value="SceneStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["SceneName"]; ?>
												  </button>
											</form>
											</td>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["SceneName"] ?>">
												  <input type="hidden" name="MonsterName" value="<?php echo $_row["Monster"] ?>">
												  <input type="hidden" name="p" value="MonsterStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["Monster"]; ?>
												  </button>
											</form>
											</td>
											<td>
											<?php echo $_row["Quantity"]; ?>
											</td>
											</tr>
											<?php
										}
										
										echo '</table></div>';
									}	
									?>
											
													
							</section>

						</div>
					</div>
				</div>
			</div>
			<?php }
			else {
				?>
				
				<div class="container">
					<div class="row main-row">
						<div class="12u 12u(mobile)">
							<H1>Please Login before using.</H1>
						</div>
					</div>
				</div>
				<?php
			}
			include("footer.php"); ?>
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