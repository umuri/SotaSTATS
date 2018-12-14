<?php

	
	require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php');
	
	if ( isset($_POST["RESET"]) )
	{
		unset($_SESSION["Step2Login"]);
		unset($_SESSION["Snigol_Step2_PosX"]);
		unset($_SESSION["Snigol_Step2_PosY"]);
		unset($_SESSION["Snigol_Step2_PosZ"]);
		unset($_SESSION["Snigol_Step2_CharName"]);
		unset($_SESSION["Snigol_Step2_SceneName"]);
		unset($_SESSION["Snigol_Step2_SceneDisplayName"]);
	}
	if ( isset($_POST["CharName"]) && isset($_POST["LocPaste"]) )
	{
		$ip = $_SERVER['REMOTE_ADDR'];
		$LocPaste = $_POST["LocPaste"];
		//Area: Owl's Head (OwlsHead) Loc: (117.6, 87.1, 248.2)	
		$regexp = "#Area: ([^(]*) \(([^)]*)\) Loc: \(([\-0-9\.]*), ([\-0-9\.]*), ([\-0-9\.]*)\)#";
		preg_match_all($regexp,$LocPaste,$Matches);
		$CharName = $_POST["CharName"];
		$SceneDisplayName = $Matches[1][0];
		$SceneName = $Matches[2][0];
		$PosX = $Matches[3][0];
		$PosY = $Matches[4][0];
		$PosZ = $Matches[5][0];
		
		require_once($_SERVER['DOCUMENT_ROOT'] . '/fetchAuthAttempt.php');
		//echo $CharName ."|". $SceneDisplayName ."|". $SceneName ."|". $PosX ."|". $PosY ."|". $PosZ;
		$result = CheckAuthAttempt($dbLink, $PosX, $PosY, $PosZ, $CharName, $ip, $SceneName, $SceneDisplayName);
		
		//echo $result;
		if ( $result == "AUTH_CLEAN" )
		{
			$_SESSION["Step2Login"] = true;
			$_SESSION["Snigol_Step2_PosX"] = $PosX;
			$_SESSION["Snigol_Step2_PosY"] = $PosY;
			$_SESSION["Snigol_Step2_PosZ"] = $PosZ;
			$_SESSION["Snigol_Step2_CharName"] = $CharName;
			$_SESSION["Snigol_Step2_SceneName"] = $SceneName;
			$_SESSION["Snigol_Step2_SceneDisplayName"] = $SceneDisplayName;
			$ProceedWithStepDos = true;
		}
		else if ( $result == "AUTH_MATCH" )
		{
			$StuckTooRecent = true;
		}
		else if ( $result == "ATTEMPT_OVERLOAD")
		{
			$AttemptOverload = true;
		}
		
		
		
	}
	else if (( isset($_POST["StepTwo"]) ) && ( $_SESSION["Step2Login"] == true ))
	{
		require_once($_SERVER['DOCUMENT_ROOT'] . '/fetchAuthAttempt.php');
		
		
		$PosX = $_SESSION["Snigol_Step2_PosX"];
		$PosY = $_SESSION["Snigol_Step2_PosY"];
		$PosZ = $_SESSION["Snigol_Step2_PosZ"];
		$CharName = $_SESSION["Snigol_Step2_CharName"];
		$SceneName = $_SESSION["Snigol_Step2_SceneName"];
		$SceneDisplayName = $_SESSION["Snigol_Step2_SceneDisplayName"];
		$ip = $_SERVER['REMOTE_ADDR'];
		//echo $CharName ."|". $SceneDisplayName ."|". $SceneName ."|". $PosX ."|". $PosY ."|". $PosZ;
		$result = CheckAuthAttempt($dbLink, $PosX, $PosY, $PosZ, $CharName, $ip, $SceneName, $SceneDisplayName);
		
		//echo $result;
		if ( $result == "AUTH_MATCH" )
		{
			unset($_SESSION["Step2Login"]);
			unset($_SESSION["Snigol_Step2_PosX"]);
			unset($_SESSION["Snigol_Step2_PosY"]);
			unset($_SESSION["Snigol_Step2_PosZ"]);
			unset($_SESSION["Snigol_Step2_CharName"]);
			unset($_SESSION["Snigol_Step2_SceneName"]);
			unset($_SESSION["Snigol_Step2_SceneDisplayName"]);
			//Actually log the user in!
			$LoggedInUser = sotastats_login($dbLink, $CharName);
			$loggedIn = true;
		}
		else if ( $result == "ATTEMPT_OVERLOAD")
		{
			$AttemptOverload = true;
		}
		else if (( $result == "AUTH_CLEAN" )  || ( $result == "AUTH_THROTTLE" ))
		{
			$Retry = true;
			$ProceedWithStepDos = true;
		}
		else 
		{
			$StuckTooRecent = true;
		}
		
	}
	if ( isset($_POST["Logout"]) )
	{
		//Nope, clear it all!
		sotastats_logout($dbLink);
		$LoggedInUser = null;
		$loggedIn = false;
	}
	//Area: Owl's Head (OwlsHead) Loc: (117.6, 87.1, 248.2)	
	
	if ( session_status() == PHP_SESSION_ACTIVE ) {
		/*echo '<br>Session is active<br>';
		if ( $loggedIn == true )
			{ echo 'True login<br>'; } 
		else { echo 'False Login<br>';}
		echo $loggedIn . ' as login status<br>' . $LoggedInUser . ' as LoggedInUser<br>';
		*/
		}
?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->

<html>
	<head>
		<title>SotaSTATS - Login</title>
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
			<?php $currentPage = "login"; ?>
			<?php include("header.php"); ?>
			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">

							<section>
								<h2>Benefits of Logging in</h2>
								<ul class="small-image-list">
									<li>
										Get more results in codex searches.
									</li>
									<li>
										Feel Special
									</li>
									<li>
										Able to contribute corrections and earn rewards
									</li>
									<li>
										Flag yourself for territory battles(not implemented)
									</li>
									<li>
										NO SIGNUP/PASSWORD/USERNAME NEEDED. Authenticate IN-GAME!
									</li>
								</ul>
							</section>

							<section>
								<h2>Quick Options</h2>
								<div>
									You have no options.
								</div>
							</section>

						</div>
						<div class="10u 12u(mobile) important(mobile)">

							<section class="right-content">
							<?php 
							if ( $StuckTooRecent )
							{
								echo "<h2>LOGIN FAILED</h2>You've used /stuck too recently, please wait 15 minutes and try again<br>";
							}
							else if ( $AttemptOverload ) 
							{
								echo "<h2>LOGIN FAILED</h2>You've done too many attempts recently, please wait 15 minutes and try again<br>";
							}
							else if ( ( !$loggedIn ) && ( !$ProceedWithStepDos) ) 
							{ ?>
							<h2>Login</h2><BR>
							<form action="/login.php" method="POST">
												<div>
												Full Character Name<br>
												<input id="CharName" type="text" name="CharName" size="30" class="form-control" placeholder="In-game FULL Character Name" ><br>
												Paste /loc here<br>
												<input id="LocPaste" type="text" name="LocPaste" size="30" class="form-control" placeholder="Paste /loc output" >
												
												<input type="submit" value="Begin Login"><br>
												<br>
											</form>
											To login to SotaSTATS, we will need you to do some in-game steps.<br>
											<h1>Step #1. Login to Shroud of the Avatar</h1>
											<h1>Step #2. Make sure your name is visible on public stats </h1>
											To do this, right click your character name in the top left and make sure it says "Hide name from public stats". <br>
											If it looks like the picture below, you are <font color=red>NOT</font> visible and need to click on "Show name in public stats".<br>
											<img src="LoginStep1.png"><br>
											<h1> Step #3. Please do not move from this point on or your login may fail</h1>
											<h1> Step #4. In-game, type /loc</h1>
											<h1> Step #5. Type in your character name above in the first box</h1>
											<h1> Step #6. Paste your /loc into the second box. When you typed /loc it fills your clipboard automatically.</h1>
											<h1> Step #7. Click "Begin Login" to proceed</h1>
											</p>
											</div>
							<?php } else if (( $ProceedWithStepDos ) || ( $Retry ))  { ?>
											<h2>Login Part 2</h2><BR>
											<h1> Step #8. You are now pre-auth'd for the following location: </h1>
											Character: <?php echo $CharName?><br>
											Scene/DisplayName: <?php echo $SceneName ?>/<?php echo $SceneDisplayName?><br>
											X,Y,Z: <?php echo $PosX; ?>,<?php echo $PosY; ?>,<?php echo $PosZ; ?><br>
											<h1>Step #9. If this is correct, type /stuck in-game</h1>
											<h1>Step #10. Click proceed on the stuck dialog</h1>
											<img src="LoginStep2.png"><br>
											<h1>Step #11. WAIT FOR THE COUNTDOWN<h1>
											<h1>Step #12. Once the countdown has finished and you have gone back to the zone start, click "Verify Login" below. Clicking too early may invalidate your login.
											<form action="/login.php" method="POST">
												<input id="StepTwo" type="hidden" name="StepTwo" value="letsgo" >
												<input type="submit" value="Verify Login"><br>
											</form>
											<br><br>
											<form action="/login.php" method="POST">
												<input id="RESET" type="hidden" name="RESET" value="letsgo" >
												<input type="submit" value="Restart Login"><br>
											</form>
							<?php } else { ?>
											<h2>Congratulations! You're logged in!</h2><br>
											<h1> Step #13. If you don't want to keep reporting stats, it is now safe to DISABLE PUBLIC NAME REPORTING again.
											To do this, right click your character name in the top left and make sure it says "Show name from public stats". <br>
											If it looks like the picture below, you are <font color=red>NOT</font> reporting your name to public stats anymore.<br>
											But remember, the longer you leave your stats public, the more useful things you'll find on here about your play!<br>
											<img src="LoginStep1.png"><br>
											<form action="/login.php" method="POST">
												<div>
												<input id="Logout" type="hidden" name="Logout" size="30" class="form-control" value="true">
												</div>
												<input type="submit" value="LOGOUT"><br>
												<br>
											</form>
							<?php }	?>
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