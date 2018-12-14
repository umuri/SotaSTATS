<?php
	$Name = $_REQUEST["MonsterName"];
	$SceneName = $_REQUEST["SceneName"];
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
									
									if ( isset($_GET["SceneName"]) )
									{ ?>
										
									<h2>Monster List for <?php echo $SceneName;?>
									</h2><BR>
									<?php
									
								
									$args = dbsanitize($dbLink, $SceneName);
									
									$result = c_mysqli_call($dbLink, "stats_SceneMonsters", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"] ?>">
												  <input type="hidden" name="MonsterName" value="<?php echo $_row["Monster"] ?>">
												  <input type="hidden" name="p" value="MonsterStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["Monster"]; ?>
												  </button>
											</form>
											</td>
												  <?php												
											if ( ($count % $countDivisor) == ($countDivisor - 1) ) 
											{
											echo '</tr>';
											}
											$count += 1;
										}
										
										echo '</table></div>';
									}	
									?>
									
										
									<h2>World Drops for <?php echo $SceneName;?>
									</h2><BR>
									<?php
									
								
									$args = dbsanitize($dbLink, $SceneName);
									
									$result = c_mysqli_call($dbLink, "stats_scene_WorldDrops", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"] ?>">
												  <input type="hidden" name="Archetype" value="<?php echo $_row["DisplayName"] ?>">
												  <input type="hidden" name="p" value="ItemStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["DisplayName"] . ' - ' . $_row["Quantity"];  ?>
												  </button>
											</form>
											</td>
												  <?php												
											if ( ($count % $countDivisor) == ($countDivisor - 1) ) 
											{
											echo '</tr>';
											}
											$count += 1;
										}
										
										echo '</table></div>';
									}	
									?>
									
										
									<h2>Item Drops for <?php echo $SceneName;?>
									</h2><BR>
									<?php
									
								
									$args = dbsanitize($dbLink, $SceneName);
									
									$result = c_mysqli_call($dbLink, "stats_scene_LootDrops", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_REQUEST["SceneName"] ?>">
												  <input type="hidden" name="Archetype" value="<?php echo $_row["DisplayName"] ?>">
												  <input type="hidden" name="p" value="ItemStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["DisplayName"] . ' - ' . $_row["Quantity"];  ?>
												  </button>
											</form>
											</td>
												  <?php												
											if ( ($count % $countDivisor) == ($countDivisor - 1) ) 
											{
											echo '</tr>';
											}
											$count += 1;
										}
										
										echo '</table></div>';
									}	
									?>
									<?php } ?>			
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

