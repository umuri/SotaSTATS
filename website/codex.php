<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<!DOCTYPE HTML>
<!--
	Minimaxing by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<?php
	$StartTimestamp =  mysqli_real_escape_string($dbLink, $_REQUEST["StartTimestamp"]);
	$EndTimestamp =  mysqli_real_escape_string($dbLink, $_REQUEST["EndTimestamp"]);
	$SceneName =  mysqli_real_escape_string($dbLink, $_REQUEST["SceneName"]);
	$Killer =  mysqli_real_escape_string($dbLink, $_REQUEST["Killer"]);
	$Victim =  mysqli_real_escape_string($dbLink, $_REQUEST["Victim"]);
	$PlayerName =  mysqli_real_escape_string($dbLink, $_REQUEST["PlayerName"]);
	$Archetype =  mysqli_real_escape_string($dbLink, $_REQUEST["Archetype"]);
	$ItemID =  mysqli_real_escape_string($dbLink, $_REQUEST["ItemID"]);
	$LocationEvent =  mysqli_real_escape_string($dbLink, $_REQUEST["LocationEvent"]);
	
	$DisplayStartTimestamp = htmlspecialchars($_REQUEST["StartTimestamp"]);
	$DisplayEndTimestamp = htmlspecialchars($_REQUEST["EndTimestamp"]);
	$DisplaySceneName = htmlspecialchars($_REQUEST["SceneName"]);
	$DisplayKiller = htmlspecialchars($_REQUEST["Killer"]);
	$DisplayVictim = htmlspecialchars($_REQUEST["Victim"]);
	$DisplayPlayerName = htmlspecialchars($_REQUEST["PlayerName"]);
	$DisplayArchetype = htmlspecialchars($_REQUEST["Archetype"]);
	$DisplayItemID = htmlspecialchars($_REQUEST["ItemID"]);
	$DisplayLocationEvent = htmlspecialchars($_REQUEST["LocationEvent"]);
	
	
?>
<html>
	<head>
		<title>SotaSTATS - Codex</title>
		<meta charset="utf-8" />
		<meta name="viewport" content="width=device-width, initial-scale=1" />
		<!--[if lte IE 8]><script src="assets/js/ie/html5shiv.js"></script><![endif]-->
		<link rel="stylesheet" href="assets/css/main.css" />
		<!--[if lte IE 9]><link rel="stylesheet" href="assets/css/ie9.css" /><![endif]-->
		<script src="//code.jquery.com/jquery-1.10.2.js"></script>
		<script src="//code.jquery.com/ui/1.11.4/jquery-ui.js"></script>
	</head>
	<body>
		<div id="page-wrapper">
			<?php $currentPage = "codex"; ?>
			<?php include("header.php"); ?>
			<div id="main">
				<div class="container">
					<div class="row main-row">
						<div class="2u 12u(mobile)">

							<section>
								<h2>Options</h2>
								<ul class="small-image-list">
									<li>
										Codex Search:<br>
											<form id ="codexSearch" action="/codex.php" method="GET">
													<div>
													<input id="STSL" type="text" name="StartTimestamp" size="30" class="form-control" placeholder="Type Start Time" <?php if (!empty($StartTimestamp)) { echo 'value="'.$DisplayStartTimestamp.'"'; }
													else if ( empty($StartTimestamp) && empty(EndTimestamp) )
													{
															$now = new DateTime();
															$now->sub(new DateInterval('P2D'));
															echo 'value="' . $now->format('Y-m-d H:i:s') . '"';
													}	?>>
												</div>
												<div>
													<input id="ETSL" type="text" name="EndTimestamp" size="30" class="form-control" placeholder="Type End Time" <?php if (!empty($EndTimestamp)) { echo 'value="'.$DisplayEndTimestamp.'"'; }
													else if ( empty($StartTimestamp) && empty(EndTimestamp) )
													{
															$now = new DateTime();
															echo 'value="' . $now->format('Y-m-d H:i:s') . '"';
													}	?>>
												</div>
												<div>
													<input id="SNL" type="text" name="SceneName" size="30" class="form-control" placeholder="Type Scene" <?php if (!empty($SceneName)) { echo 'value="'.$DisplaySceneName.'"'; } ?>>
												</div>
												<div>
													<input id="ANL" type="text" name="Archetype" size="30" class="form-control" placeholder="Type Archetype" <?php if (!empty($Archetype)) { echo 'value="'.$DisplayArchetype.'"'; } ?>>
												</div>
												<div>
													<input id="IIDL" type="text" name="ItemID" size="30" class="form-control" placeholder="Type ItemID" <?php if (!empty($ItemID)) { echo 'value="'.$DisplayItemID.'"'; } ?>>
												</div>
												<div>
													<input id="PNL" type="text" name="PlayerName" size="30" class="form-control" placeholder="Type PlayerName" <?php if (!empty($PlayerName)) { echo 'value="'.$DisplayPlayerName.'"'; } ?>>
												</div>
												<div>
													<input id="KL" type="text" name="Killer" size="30" class="form-control" placeholder="Type Killer" <?php if (!empty($Killer)) { echo 'value="'.$DisplayKiller.'"'; } ?>>
												</div>
												<div>
													<input id="VL" type="text" name="Victim" size="30" class="form-control" placeholder="Type Victim" <?php if (!empty($Victim)) { echo 'value="'.$DisplayVictim.'"'; } ?>>
												</div>
												<div>
													<input id="LEL" type="text" name="LocationEvent" size="30" class="form-control" placeholder="Type EventType" <?php if (!empty($LocationEvent)) { echo 'value="'.$DisplayLocationEvent.'"'; } ?>>
														<a href="#codex-popup1">[?]</a>
													
													
													<div id="codex-popup1" class="codex-overlay">
													
														<div class="codex-popup">
															<h2>Location Event List</h2>
															<a class="codex-close" href="#">&times;</a>
															<div class="codex-content">
																<table>
																<tr>
																</td><td>AdventureExperienceGained
																</tr><tr>
																</td><td>ItemDestroyed_AddCreditToTaxAccount
																</td><td>ItemDestroyed_AuctionExpiration
																</tr><tr>
																</td><td>ItemDestroyed_BankUpgrade
																</td><td>ItemDestroyed_Crafting
																</tr><tr>
																</td><td>ItemDestroyed_CrownMerchant
																</td><td>ItemDestroyed_Merchant
																</tr><tr>
																</td><td>ItemDestroyed_PayPriceToSetCharacterAppearance
																</td><td>ItemDestroyed_User
																</tr><tr>
																</td><td>ItemGained_Crafting
																</td><td>ItemGained_CrownMerchant
																</tr><tr>
																</td><td>ItemGained_ExplodeItem_Merchant
																</td><td>ItemGained_HarvestPlant
																</tr><tr>
																</td><td>ItemGained_Loot
																</td><td>ItemGained_LootGold
																</tr><tr>
																</td><td>ItemGained_Merchant
																</td><td>ItemGained_Offer
																</tr><tr>
																</td><td>ItemGained_StartingChar
																</td><td>ItemGained_World
																</tr><tr>
																</td><td>LootGenerated
																</td><td>MonsterKilledByPlayer
																</tr><tr>
																</td><td>MonsterKilledBySelf
																</td><td>MonsterLeashed
																</tr><tr>
																</td><td>PlayerDeath
																</td><td>PlayerKilledByMonster
																</tr><tr>
																</td><td>PlayerKilledByPlayer
																</td><td>PlayerKilledBySelf
																</tr><tr>
																</td><td>PositionUpdate
																</td><td>StuckUsed
																</tr><tr>
																</td><td>UpdateItem_QuantityDestroyed
																</tr><tr>
																</table>
															</div>
														</div>
													</div>
												</div><br>
												<input onclick="return CheckTimestamp();" type="submit" value="GO"><br>
												
											</form>
										<script>
										$('#SNL').autocomplete({
											source: "afGetScenes.php",
											minLength: 3
										});
										$('#ANL').autocomplete({
											source: "afGetArchetypes.php",
											minLength: 3
										});
										$('#LEL').autocomplete({
											source: "afGetEventTypes.php",
											minLength: 3
										});
										$('#KL').autocomplete({
											source: "afGetMonsterNames.php",
											minLength: 3
										});
										$('#VL').autocomplete({
											source: "afGetMonsterNames.php",
											minLength: 3
										});
										jQuery.ui.autocomplete.prototype._resizeMenu = function () {
										  var ul = this.menu.element;
										  ul.outerWidth(this.element.outerWidth());
										}
										
									
										</script>
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
												
												<?php if ( !empty($SceneName) ) { ?>
												<li>
													<form method="GET" action="maps.php" class="inline">
														<input type="hidden" name="SceneName" value="<?php echo $SceneName ?>">
														<input type="hidden" name="CS" value="1">
														<button type="submit" name="submit_param" value="submit_value" class="link-button">
															Map - <?php echo $DisplaySceneName ?>
														</button>
													</form>
												</li>
												<li>
													<form method="get" action="codexMaps.php" class="inline">
														<input type="hidden" name="StartTimestamp" value="<?php echo $DisplayStartTimestamp ?>">
														<input type="hidden" name="EndTimestamp" value="<?php echo $DisplayEndTimestamp ?>">
														<input type="hidden" name="SceneName" value="<?php echo $DisplaySceneName ?>">
														<input type="hidden" name="Archetype" value="<?php echo $DisplayArchetype ?>">
														<input type="hidden" name="ItemID" value="<?php echo $DisplayItemID ?>">
														<input type="hidden" name="PlayerName" value="<?php echo $DisplayPlayerName ?>">
														<input type="hidden" name="Killer" value="<?php echo $DisplayKiller ?>">
														<input type="hidden" name="Victim" value="<?php echo $DisplayVictim ?>">
														<input type="hidden" name="LocationEvent" value="<?php echo $DisplayLocationEvent ?>">
														<button type="submit" name="submit_param" value="submit_value" class="link-button">
															Overlay Codex Search on Map - <?php echo $DisplaySceneName ?>
														</button>
													</form>
												</li>
												<?php } ?>
												
												
											</ul>
										</div>
									</div>
								</div>
							</section>

						</div>
						<div class="10u 12u(mobile) important(mobile)">

							<section class="right-content">
							<h2>A Page from the Codex</h2><BR>Click an entry to populate codex search.<br>
							<?php
							
							if ( empty($StartTimestamp) && empty($EndTimestamp) && empty($SceneName)
								&& empty($Killer) && empty($Victim)
								&& empty($PlayerName) && empty($Archetype)
								&& empty($ItemID) && empty($LocationEvent)
								)
								{
									$result = c_mysqli_call($dbLink, "getRandomCodex",  ( $loggedIn ? '1' : '0' ));
								}
								else if ( abs(strtotime($StartTimestamp) - strtotime($EndTimestamp)) > 172800 ) //Two Days
								{
									echo '<font color="red">Please use a start/end time within 48 hours of each other (two days) at most</font>';
								}
								else
								{
									$args = "" . ( empty($StartTimestamp) ? "NULL" : "'" . $StartTimestamp . "'" )
									. "," . ( empty($EndTimestamp) ? 'NULL' : "'" . $EndTimestamp . "'" )
									. "," . ( empty($SceneName) ? 'NULL' : "'" . $SceneName . "'" )
									. "," . ( empty($Killer) ? 'NULL' : "'" . $Killer . "'" )
									. "," . ( empty($Victim) ? 'NULL' : "'" . $Victim . "'" )
									. "," . ( empty($PlayerName) ? 'NULL' : "'" . $PlayerName . "'" )
									. "," . ( empty($Archetype) ? 'NULL' : "'" . $Archetype . "'" )
									. "," . ( empty($ItemID) ? 'NULL' : "'" . $ItemID . "'" )
									. "," . ( empty($LocationEvent) ? 'NULL' : "'" . $LocationEvent . "'" )
									. "," . ( $loggedIn ? '1' : '0' );
									$result = c_mysqli_call($dbLink, "getSpecificCodex", $args);
									
								}
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
									
									foreach ($_row as $_value )
									{
										echo '<td class="codex-td">'. $_value . '</td>';
										
									}
									echo '</tr>';
								}
								
								echo '</table></div>';
							}	
							?>
							
							<script>
								$(document).ready( function() {
									$('#codex').click( function(event) {
									  var target = $(event.target);
									  $td = target.closest('td');
									  
									  var col   = $td.index();
									  var row   = $td.closest('tr').index();
									
									  switch(col){
										case 0:
											$('#STSL').val($td.html());
											$('#ETSL').val($td.html());
											break;
										case 1:
											$('#SNL').val($td.html());
											break;
										case 2:
											$('#LEL').val($td.html());
											break;
										case 3:
											$('#PNL').val($td.html());
											break;
										case 4:
											$('#KL').val($td.html());
											break;
										case 5:
											$('#VL').val($td.html());
											break;
										case 6:
											$('#IIDL').val($td.html());
											break;
										case 7:
											$('#ANL').val($td.html());
											break;
										default:
											break;
									  }
									   
									});
								  });
							</script>						
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