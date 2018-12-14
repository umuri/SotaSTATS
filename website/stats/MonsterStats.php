<?php
	$Name = urldecode($_REQUEST["MonsterName"]);
	$SceneName = urldecode($_REQUEST["SceneName"]);
?>	
	<script>
	function EditEntry(p1, p2,MonsterName,SceneName) {
		var inputValue = prompt("Please enter new submission for " + p1, "");
		divTarget = "div" + p2;
		
		dataString = [ ['inputCategory',p1] , ['inputValue',inputValue], ['MonsterName', MonsterName] ,['SceneName', SceneName]];
		var result = $.ajax
                    ({
                    type: "POST",
                    url: "submitAlterationMonster.php",
					data: {'inputCategory': p1, 'inputValue': inputValue, 'MonsterName': MonsterName, 'SceneName': SceneName},
                    cache: false,
                    success: function(data)
                        {
                            document.getElementById(divTarget).innerHTML = data;
                        }
                    });
		
		
		return;
	}
	
	
	</script>
	

	
	<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile) important(mobile)">
							<?php
									$args = dbsanitize($dbLink, $Name) .',' . dbsanitize($dbLink,$SceneName);
									
										$result = c_mysqli_call($dbLink, "stats_monster_sheet", $args);
								
										$data = $result;	
									
										if ( $result )
										{	
										$countDivisor = 3;
										$count = 0;
										echo '<center><h2>Monster Sheet:</H2><div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{ 
											foreach ($_row as $_key=>$_value)
											{	
												
												echo '<tr><td>'.( $_key == "TamingLevel" ? 'MinTaming' : $_key ).':</td>';
												echo '<td><div style="min-width:70px" id="div' . $_key .'button">';
												if ($_value) 
												{ echo $_value ;}
												else
												{ 
													echo 'Unset  ';
													
												}
												if ($loggedIn)
													{
														echo '<input id="' . $_key .'button" type="image" src="\icons\edits.png" height="16" style="float: right;" value="+" onclick="EditEntry(' . "'" .$_key ."','"
																			. $_key . 'button' ."','"
																			. urlencode($Name) . "','"
																			. urlencode($SceneName) . "'" . ')">';
													}
													
												echo '<div></td>';
												echo '</tr>';
											}
										}
										
										echo '</table></div></center>';
										}	
										
										
							 include("sidebarStats.php"); ?>
						</div>
						<div class="10u 12u(mobile) (mobile)">

									<section class="right-content">
									<?php
									$args = dbsanitize($dbLink, $Name);
									
									$result = c_mysqli_call($dbLink, "stats_Monster_LocalizedNames", $args);
								
									$data = $result;

									if ( count($data) > 0 )
									{
										$countDivisor = 3;
										$count = 0;
										echo '<br>Localized Names:<br><div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<?php echo $_row["Name"]; ?>
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
									if ( !isset($_REQUEST["SceneName"] ) )
									{
										
										
										$args = dbsanitize($dbLink, $Name);
									
										$result = c_mysqli_call($dbLink, "stats_MonsterScenes", $args);
								
										$data = $result;	
									
										if ( $result )
										{	
										$countDivisor = 3;
										$count = 0;
										echo '<br>Scenes:<br><div style="overflow-x:auto;"><table class="bacon">';
										
										foreach ( $data as $_row )
										{
											if ( ($count % $countDivisor) == 0 )
											{
												echo '<tr>';
											}
											
											?>
											<td>
											<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="SceneName" value="<?php echo $_row["Scene"] ?>">
												  <input type="hidden" name="MonsterName" value="<?php echo $Name ?>">
												  <input type="hidden" name="p" value="MonsterStats">
												  <button type="submit" class="link-button">
													<?php echo $_row["Scene"]; ?>
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
									}	
									
									
									
									if ( isset($_REQUEST["MonsterName"]) )
									{ ?>
										
									<h2>Loot Table for <?php echo $Name;
									if ( isset($_REQUEST["SceneName"]) )
									{
										echo ' ('.$SceneName.')';
									}
									else
									{
										echo ' (All Scenes)';
									}?> </h2><BR>
									<?php
									
								
									$args = dbsanitize($dbLink, $Name).','.dbsanitize($dbLink, $SceneName);
									
									$result = c_mysqli_call($dbLink, "stats_LootTableMonster", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										echo '<div style="overflow-x:auto;"><table border="1" id="codex"><tr class="codex-tr">';
										foreach ( $data[0] as $_key => $_value )
										{
											 echo'<th> ' . $_key . ' </th>';
										}
										echo '</tr>';
										
										foreach ( $data as $_row )
										{
											echo '<tr>';
											
											foreach ($_row as $_key => $_value )
											{
												if ( $_key == "Item" )
												{?>
														<td>
												<form method="GET" action="stats.php" class="inline">
												  <input type="hidden" name="Archetype" value="<?php echo $_value ?>">
												  <input type="hidden" name="p" value="ItemStats">
												  <button type="submit" class="link-button">
													<?php echo $_value; ?>
												  </button>
												</form>
												</td>
												<?php }
												else
												{
												echo '<td class="codex-td">'. $_value . '</td>';
												}
											}
											echo '</tr>';
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



