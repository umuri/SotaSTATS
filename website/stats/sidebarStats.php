<section>
		<h2>Daily</h2>
		<ul class="link-list">
			<li>
				
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
				<?php if ( strpos($_REQUEST["p"], 'Misc') === false ) //We're not a misc page, use the sidebar queries
					{	?>
					<?php if ( isset($_REQUEST["SceneName"] ) || isset($_REQUEST["MonsterName"]) || isset($_REQUEST["Archetype"]) ) {
						$args = '';
					?>
						<li>
						<form method="GET" action="codex.php" class="inline">
						  <input type="hidden" name="p" value="SceneStats">
						  <?php if (isset($_REQUEST["SceneName"]) ) { $args = $args . $_REQUEST["SceneName"] . '|'; ?>
							<input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"]; ?>">
						  <?php } ?>
						  <?php if (isset($_REQUEST["MonsterName"]) ) {  $args = $args . $_REQUEST["MonsterName"] . '|'; ?>
							<input type="hidden" name="Victim" value="<?php echo $_REQUEST["MonsterName"]; ?>">
						  <?php } ?>
						  <?php if (isset($_REQUEST["Archetype"]) ) {  $args = $args . $_REQUEST["Archetype"] . '|'; ?>
							<input type="hidden" name="Archetype" value="<?php echo $_REQUEST["Archetype"]; ?>">
						  <?php } ?>
						  <button type="submit" class="link-button">
							Related Codex Entries |<?php echo $args; ?>
						  </button>
						</form>
						</li>
					<?php } ?>
					<?php if ( isset($_REQUEST["MonsterName"] ) ) {
					?>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="MonsterStats">
						  <input type="hidden" name="MonsterName" value="<?php echo $_REQUEST["MonsterName"]; ?>">
						  <button type="submit" class="link-button">
							Monster Statistics for <?php echo $_REQUEST["MonsterName"]; ?>
						  </button>
						</form>
						</li>
					<?php } ?>
					<?php if ( isset($_REQUEST["SceneName"] ) ) {
					?>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="SceneStats">
						  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"]; ?>">
						  <button type="submit" class="link-button">
							Scene Statistics for <?php echo $_REQUEST["SceneName"]; ?>
						  </button>
						</form>
						</li>
					<?php } ?>
						<?php if ( isset($_REQUEST["r"] ) ) {
					?>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="VladPresets">
						  <button type="submit" class="link-button">
							Another Quickset Query
						  </button>
						</form>
						</li>
					<?php } ?>
				<?php }
				else { //We're the misc sidebar!?>
					<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="AuctionExpiredMiscStats">
						  <button type="submit" class="link-button">
							Auction Expirations - 7 days
						  </button>
						</form>
						</li>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="LotteryTicketsMiscStats">
						  <button type="submit" class="link-button">
							Lottery Tickets this Release
						  </button>
						</form>
						</li>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="LotteryTicketsPastMiscStats">
						  <button type="submit" class="link-button">
							Lottery Tickets Past Releases
						  </button>
						</form>
						</li>
						<li>
						<form method="GET" action="stats.php" class="inline">
						  <input type="hidden" name="p" value="GCotoGainLossMiscStats">
						  <button type="submit" class="link-button">
							GCoto Creation/Destroy Rates - 7 days
						  </button>
						</form>
						</li>
				<?php }	?>
				</ul>
			</div>
		</div>
	</div>
</section>