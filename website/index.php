<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
	<head>
		<title>SotaSTATS</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
	</head>
	<body>
		<div id="page-wrapper">
			<?php $currentPage = "home"; ?>
			<?php include("header.php"); ?> 
			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="12u">

							<section>
								<h2>Welcome to SotaSTATS</h2>
								<p>Hopefully you will all find this useful. Inside you will find Maps, Frequency Data, as well as lots of search functions for displaying and diving into the API that Undone and Atos and the rest at Portalarium.</p>
								<br>
								Most of the nifty stuff you want is under the Stats tab.
								<br>
								<br>
								<h2>Logging in requires NO SIGNUP, NO REGISTRATION, NO PASSWORD, NO EMAIL, just an in-game account doing an in-game action, without revealing password, username, anything but character name.</h2>
								<p> Logging in lets you submit corrections/information updates (and <B><I>earn rewards</b></i> for them), participate in territory wars[NOT IMPLEMENTED] (and maybe earn rewards[NOT IMPLEMENTED]), get more results in the codex search, and control your preferences without having to reset them every time.</p>
								<p>
								<h2>Changelog:</h2>
								<br><h1>1.0.4</h1>
								-- NEW ECONOMY QUICK-PAGE -> Statistics -> Economy -> Economy Quick-Page that will allow quick economic data<br>
								-- -- This page courtesy of Vladamir Begemot, who used his donated time to specifically request it<br>
								-- Maps optimized and re-done<br>
								-- Load issues greatly reduced on some pages<br> 
								<br><h1>1.0.3</h1>
								-- Updated Item DisplayNames to remove needless category data until proper names can be put in<br> 
								-- Items such as recipes will now show what scenes contain npc vendors that sell them<br> 
								-- Updated the codex to "suggest" the most recent 48 hours when it opens as default.<br>
								-- Rewrote autocompletes because they became stupidly inefficient when we moved servers and wouldn't load. They should all work now<br>
								-- Added a [?] button to EventTypes on codex that lists event types - That took way longer than it should have, at a full hour and a half of messing with css and trying multiple things like tooltips/etc. I hate front-end work<br>
								<br><h1>1.0.2</h1>
								-- Updated all missing scenenames, nothing should be unknown until next release<br>
								-- Fixed what died on 12-12-2017 that stopped daily totals from running<br>
								-- Updated missing releases since last update<br>
								-- Added an economy section to stats, began populating with GCOTOS as rent usage<br>
								<br><h1>1.0.1</h1>
								-- Redid how the site handles errors and added an internal error catcher so i can diagnore user problems easier<br>
								-- Worked for a couple days with portalarium to figure out why the api wasn't feeding requests right, SSL errors due to their new setup was the culprit<br>
								<br><h1>1.0.0</h1>
								-- We're live!<br>
								-- LOTS of issues still left concerning load when lots of users are on. Working on it. :/<br>
								-- Yes it's ugly.<br>
								-- Codex map searches are the current worst offender and should get an upgrade next.<br>
								-- Whoever submits the most verified monster updates before version 1.1 receives a reward of GCOTOs.<br>
								<br><h1>0.9.6</h1>
								-- Fixed most of the major slowdowns, misc bugfixes. Primed for new systems added.<br>
								<br><h1>0.9.5</h1>
								-- Added a past lottery ticket section and code to do easier correlations by releases for other queries<br>
								-- Identified a big slowdown in most test users workflow, and reprogramming to work around (daily totals used for most things vs previous hourly and location(xyz) differentiated totals)<br>
								<br><h1>0.9.4.y</h1>
								-- Life decided to stop following Atos's lead of nonstop nerfs. <br>
								<br><h1>0.9.4</h1>
								-- Added profiling to start identifying slow page sections or requests<br>
								-- Default map coloring settable on Profile page (once logged in)<br>
								-- Settings subsystem added for storable user settings <br>
								-- Added map list to maps page for those who dislike typing<br>
								<br><h1>0.9.3</h1>
								-- Added Loot Ranking + Loot Scene Ranking stats under Items<br>
								-- Fixed display error on lottery ticket page thanks to feedback from Lazarus Long<br>
								-- Released to testers for initial feedback/load balance<br>
								-- Added changelog</p>
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