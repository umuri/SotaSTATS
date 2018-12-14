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
									
								<h1>Past Lotteries:</h1>
								<?php
									$args = '';
									$result = c_mysqli_call($dbLink, "stats_misc_LotteryTicketsPast", $args);
								
									$data = $result;	
									
									if ( $result )
									{
										echo '<table class="bacon">';
										echo '<tr><th>Release</th><th>Ticket Type</th><th>Quantity Sold</th></tr>';
										foreach ( $data as $_row )
										{
											echo '<tr>';
											
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
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

