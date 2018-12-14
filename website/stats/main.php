<?php
	$SceneName = $_REQUEST["SceneName"];
?>	
	
	<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="12u 12u(mobile) important(mobile)">
							<section class="right-content">
							<div>
									<div class="row">
										<div class="3u 12u(mobile)">
											<ul class="link-list">
											<h2>Scenes</h2>
												<li><div>
													<form method="GET" action="stats.php" class="inline">
														<input id="SNL" type="text" name="SceneName" size="30" class="form-control" placeholder="Type Scene">
														<input type="hidden" name="p" value="SceneStats">
														<button type="submit" >
														Scene Stats </button>
													</form>
												</div>
												</li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="SceneItemsList">
												  <button type="submit"  class="link-button">
													Scene Ranking by Item Drops - 7 days
												  </button>
												</form>
												</li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="SceneKillsList">
												  <button type="submit"  class="link-button">
													Scene Ranking by Kills - 7 days
												  </button>
												</form>
												</li>
												
											</ul>
										</div>
										<div class="3u 12u(mobile)">
											<ul class="link-list">
												<h2>Monsters</h2>
												<li><div>
													<form method="GET" action="stats.php" class="inline">
														<input id="MNL" type="text" name="MonsterName" size="30" class="form-control" placeholder="Type Monster Name">
														<input type="hidden" name="p" value="MonsterStats">
														
														<button type="submit">
														Monster Stats </button>
													</form>
												</div></li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="MonsterKillsList">
												  <button type="submit"  class="link-button">
													Monster Ranking by Kills - 7 days
												  </button>
												</form>
												</li>
											
											</ul>
										</div>
										<div class="3u 12u(mobile)">
											<ul class="link-list">
												<h2>Economy</h2>
												<li><div>
													<form method="GET" action="stats.php" class="inline">
														<input type="hidden" name="p" value="VladPresets">
														
														<button type="submit" class="link-button">
														Economy Quick-Page</button>
													</form>
												</div></li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="RentCotos60EconStats">
												  <button type="submit"  class="link-button">
													GCoto Rent Usage - 60 days
												  </button>
												</form>
												</li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="RentCotosMonthlyEconStats">
												  <button type="submit"  class="link-button">
													GCoto Rent Usage - Monthly
												  </button>
												</form>
												</li>
											
											</ul>
										</div>
										<div class="3u 12u(mobile)">
											<ul class="link-list">
												<h2>Items</h2>
												<li><div>
													<form method="GET" action="stats.php" class="inline">
														<input id="INL" type="text" name="Archetype" size="30" class="form-control" placeholder="Type Item Name">
														<input type="hidden" name="p" value="ItemStats">
														
														<button type="submit">
														Item Stats </button>
													</form>
												</div></li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="ArchetypeLootList">
												  <button type="submit" class="link-button">
													Loot Ranking by Quantity - 7 days
												  </button>
												</form>
												</li>
												<li>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="p" value="ArchetypeSceneLootList">
												  <button type="submit" class="link-button">
													Loot Ranking by Quantity/Scene - 7 days
												  </button>
												</form>
												</li>
											</ul>
										</div>
											<div class="3u 12u(mobile)">
											<ul class="link-list">
												<h2>Misc</h2>
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
												
											</ul>
										</div>
									</div>
								</div>
								<script>
										$('#SNL').autocomplete({
											source: "afGetScenes.php",
											minLength: 3
										});
										$('#MNL').autocomplete({
											source: "afGetMonsterNames.php",
											minLength: 3
										});
										$('#INL').autocomplete({
											source: "afGetArchetypes.php",
											minLength: 3
										});
										jQuery.ui.autocomplete.prototype._resizeMenu = function () {
										  var ul = this.menu.element;
										  ul.outerWidth(this.element.outerWidth());
										}
										</script>
							</section>

						</div>
					</div>
				</div>
			</div>

