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
									$result = c_mysqli_call($dbLink, "stats_scene_ListByArchetypes", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 1;
										echo '<BR><H2>Scene Popularity by ItemDrops in past week:</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Rank</th><th>Scene</th></tr>';
										
										foreach ( $data as $_row )
										{
											?>
											<tr>
											<td><?php echo $count; ?></td>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["SceneName"] ?>">
												  <input type="hidden" name="p" value="SceneStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["SceneName"]; ?>
												  </button>
											</form>
											</td>
											
											</tr>
											
											<?php
											$count++;
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

