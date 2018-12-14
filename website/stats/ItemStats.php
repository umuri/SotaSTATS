<?php
	$Archetype = $_REQUEST["Archetype"];
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
									
									
									if ( isset($_REQUEST["Archetype"]) )
									{ ?>
										
									<h2>Item Stats for <?php echo $Archetype;
									if ( isset($_REQUEST["SceneName"]) )
									{
										echo ' ('.$SceneName.')';
									}
									else
									{
										echo ' (All Scenes)';
									}?> </h2><BR>
									<?php
									
									//SCENE DROPS FROM
									$args = dbsanitize($dbLink, $Archetype);
									
									$result = c_mysqli_call($dbLink, "stats_archetype_SceneDropsFrom", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<H2>Scenes found in:</H2><div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["SceneName"] ?>">
												  <input type="hidden" name="p" value="SceneStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["SceneName"]; ?>
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
									
									<?php
									$args = dbsanitize($dbLink, $Archetype);
									
									$result = c_mysqli_call($dbLink, "stats_archetype_MonsterDropsFrom", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<BR><H2>Monsters allegedly dropping:</H2><div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
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
									
									<?php
									$args = dbsanitize($dbLink, $Archetype);
									
									$result = c_mysqli_call($dbLink, "stats_archetype_PlaceToBuy", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										
										$count = 0;
										echo '<BR><H2>NPC Vendors allegedly selling:</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><td>Scene</td><td>Price</td><td>Approx X</td><td>Approx Y</td><td>Approx Z</td>';
										foreach ( $data as $_row )
										{
											?>
											<tr>
											<td><?php echo $_row["SceneDisplay"]; ?></td>
											<td><?php echo $_row["price"]; ?></td>
											<td><?php echo $_row["x"]; ?></td>
											<td><?php echo $_row["y"]; ?></td>
											<td><?php echo $_row["z"]; ?></td>
											</tr>

											<?
											$count += 1;
										}
										
										echo '</table></div>';
									}	
									?>
									
									
									
									
									
									<?php } ?>		
									<?php			function data_uri($file, $mime) 
								{  

								  $contents = file_get_contents($file);
								  $base64   = base64_encode($contents); 
								  return ('data:' . $mime . ';base64,' . $base64);
								}
								?>
								
								
								<?php If ( !empty($Archetype) ) {
									$imgSrc = 'http://www.sotastats.umuri.com/craftGraphDaily.php?Archetype=' . $Archetype;
									echo '<BR>Net change past 2 months<br>'; 
									//echo ' . $imgSrc . '<br>';
									
								?>
									<img  
									src="<?php echo data_uri($imgSrc,'image/png'); ?>"  
									alt="LOADING..." class="right" style="max-width:100%;height: auto;" />	
								<?php } ?>
								<br><br>
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

