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
									$result = c_mysqli_call($dbLink, "stats_scene_ListByKills", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 1;
										echo '<BR><H2>Scene Popularity by Kills in past week:</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Rank</th><th>Scene</th><th>% of Total</th></tr>';
										
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
												echo '<tr><td></td><td>-- 50% of all kills ABOVE LINE --</td><td></td></tr>';
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

