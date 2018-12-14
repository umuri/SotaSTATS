
<?php 


$args = dbsanitize($dbLink, $_SERVER['REMOTE_ADDR']);
$args .= "," . dbsanitize($dbLink, parse_url($_SERVER["REQUEST_URI"], PHP_URL_PATH));

$inArgs = "";
foreach ($_GET as $_ENTRY=>$_VALUE)
{
	$inArgs .= "," . $_ENTRY . ":" . $_VALUE;
}
$args .= "," . dbsanitize($dbLink, $inArgs);
$result = c_mysqli_call($dbLink, "record_pageload_start", $args);
$STAT_TIME_ID = $result[0]["ID"];
?>
<div id="header-wrapper">
				<div class="container">
					<div class="row">
						<div class="12u">

							<header id="header">
								<h1><a href="#" id="logo">SotaSTATS</a></h1>
								<nav id="nav">
									<a href="index.php" <?php if ($currentPage == "home" ) { echo 'class="current-page-item"'; } ?>>Homepage</a>
									<a href="maps.php" <?php if ($currentPage == "maps" ) { echo 'class="current-page-item"'; } ?>>Maps</a>
									<a href="stats.php" <?php if ($currentPage == "stats" ) { echo 'class="current-page-item"'; } ?>>Statistics</a>
									<a href="codex.php" <?php if ($currentPage == "codex" ) { echo 'class="current-page-item"'; } ?>>Browse the Codex</a>
									<?php if ($loggedIn == false ) { ?>
									<a href="login.php" >Login</a>
									<?php } else { ?>
									<a href="profile.php" >
									<?php echo 'Profile: ' . $LoggedInUser; ?>
									</a>
									<?php } ?>
									
								</nav>
							</header>

						</div>
					</div>
				</div>
			</div>