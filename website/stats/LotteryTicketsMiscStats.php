<?php
function calcEV($ticketsSold, $ticketsBought, $prizes) {
    
	
	//Chance to win at least one
	$chance = (1 - pow(($ticketsSold / ($ticketsSold + $ticketsBought)),$prizes));
	//Multiply by prizes
	//echo "|" . $ticketsSold . "|" . $ticketsBought . "|" . $prizes . "|" . $chance . "|";
	return $chance;
	
}
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
									$result = c_mysqli_call($dbLink, "stats_misc_LotteryTickets", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$POTTickets = 0;
										$PATickets = 0;
										$countDivisor = 3;
										$count = 0;
										echo '<BR><H2>Lottery Tickets bought since 2016-08-31 11:00am (Release 45):</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Ticket Type</th><th>Quantity Sold</th></tr>';
										foreach ( $data as $_row )
										{
											echo '<tr>';
											if ($_row["DisplayName"] == "POT Lot Deed Lottery Ticket" ) {
												$POTTickets = $_row["Quantity"];
											}
											if ($_row["DisplayName"] == "Place Anywhere Lot Deed Lottery Ticket" ) {
												$PATickets = $_row["Quantity"];
											}
											foreach ($_row as $_key => $_value )
											{
												
											?>
											
											<td><?php echo  $_value ?> </td>
											
											<?php

											}												  
											echo '</tr>';
											
										}
										
										echo '</table></div>';
									}	
								?>
								<H2>Current Lottery Offerings:</H2>
								<h1>Place Anywhere Deeds (10):</H1>
								Row: 5   (280k)<br>
								Village: 3 (530k)<br>
								Town: 1 (1,050k)<br>
								City: 1 (1,700k)<br>
								Average Value of Win: 574k<br>
								Estimated Value of buying 1 additional ticket @ 10k: 
								<?php echo round((574 * calcEV($PATickets,1,10))-(1*10),2) . 'k<br>'; ?>
								Estimated Value of buying 10 additional ticket @ 10k: 
								<?php echo round((574 * calcEV($PATickets,10,10))-(10*10),2) . 'k<br>'; ?>
								Estimated Value of buying 50 additional ticket @ 10k: 
								<?php echo round((574 * calcEV($PATickets,50,10))-(50*10),2) . 'k<br>'; ?>
								<br>
								<h1>Player Owned Town Deeds (10):</h1>
								Row: 5 (90k)<br>
								Village: 3 (190k)<br>
								Town: 1(360k)<br>
								City: 1(700k)<br>
								Average Value of Win: 208k <br>
								Estimated Value of buying 1 additional ticket @ 5k:
								<?php echo round((208 * calcEV($POTTickets,1,10))-(1*5),2) . 'k<br>'; ?>
								Estimated Value of buying 10 additional tickets @ 5k:
								<?php echo round((208 * calcEV($POTTickets,10,10))-(10*5),2) . 'k<br>'; ?>
								Estimated Value of buying 50 additional tickets @ 5k:
								<?php echo round((208 * calcEV($POTTickets,50,10))-(50*5),2) . 'k<br>'; ?>
								<br><br>
								
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

