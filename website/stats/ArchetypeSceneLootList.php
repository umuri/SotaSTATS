<?php

?>	
	
	<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">
							<?php include("sidebarStats.php"); ?>
						</div>
						<div class="10u 12u(mobile) important(mobile)">

									<section class="right-content">
									
									
									<div class="10u 12u(mobile) important(mobile)">

									<section class="right-content">
									
									<?php 
								
									$args = '';
									$result = c_mysqli_call($dbLink, "stats_archetype_ListBySceneLoot", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 1;
										echo '<BR><H2>Item Popularity by Loot in past week:</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Rank</th><th>Item</th><th>Scene</th><th>% of Total</th></tr>';
										
										$total = 0;
										foreach ( $data as $_row )
										{
											$total += $_row["Quantity"];
										}
										$halfMarker = $total / 2;
										foreach ( $data as $_row )
										{
											echo '<tr><td>' . $count . '</td><td>'; ?>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="Archetype" value="<?php echo $_row["Archetype"] ?>">
												  <input type="hidden" name="p" value="ItemStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["Archetype"]; ?>
												  </button>
											</form></td>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["SceneName"] ?>">
												  <input type="hidden" name="p" value="SceneStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["SceneName"]; ?>
												  </button>
											</form>
											<?php
											echo '</td><td>'. number_format($_row["Quantity"] / $total * 100 ,2) . '%</td></tr>';
											$count++;
											$halfMarker -= $_row["Quantity"];
											if ($halfMarker < 0 )
											{
												echo '<tr><td></td><td>-- 50% of all Loot ABOVE LINE --</td><td></td></tr>';
												$halfMarker = $total * 2;
											}
										}
										
										echo '</table></div>';
									}	
								?>
								<br><br>
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

