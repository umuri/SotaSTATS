<div id="footer-wrapper">
	<div class="container">
		<div class="row">
			<div class="8u 12u(mobile)">

				<section>
					<h2>Dislike SotaSTATS? Try these other sites!</h2>
					<div>
						<div class="row">
							<div class="3u 12u(mobile)">
								<ul class="link-list">
									<li><a href="http://shroudoftheavatar.com">Shroud of the Avatar</a></li>
									<li><a href="https://www.shroudoftheavatar.com/forum/index.php?threads/chris-daily-work-blog.85584/page-999">Chris's Daily Blog</a></li>
									<li><a href="https://www.shroudoftheavatar.com/forum/index.php?threads/54410/">SotaHUD - A in-game HUD overlay for Shroud of the Avatar</a></li>
									<li><a href="http://www.nbnn.info">NBNN - New Britannia News Network</a></li>
									
								</ul>
							</div>
							<div class="3u 12u(mobile)">
								<ul class="link-list">
									
								</ul>
							</div>
							<div class="3u 12u(mobile)">
								<ul class="link-list">
									
								</ul>
							</div>
							<div class="3u 12u(mobile)">
								<ul class="link-list">
									
								</ul>
							</div>
						</div>
					</div>
				</section>

			</div>
			<div class="4u 12u(mobile)">

				<section>
					<h2>Current Stats</h2>
					<p><div><?php include("currentLoad.php")?></div></p>
					<footer class="controls">
						<a href="https://www.shroudoftheavatar.com/forum/index.php?threads/54410/" class="button">SotaHUD</a>
					</footer>
				</section>

			</div>
		</div>
		<div class="row">
			<div class="12u">

				<div id="copyright">
					&copy; Umuri 2017. All rights reserved. | Design: <a href="http://html5up.net">HTML5 UP</a>
				</div>

			</div>
		</div>
	</div>
</div>
<?php 
$args = dbsanitize($dbLink, $_SERVER['REMOTE_ADDR']) . "," . dbsanitize($dbLink, $STAT_TIME_ID);
$result = c_mysqli_call($dbLink, "record_pageload_end", $args);
?>