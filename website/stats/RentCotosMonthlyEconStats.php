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
									$result = c_mysqli_call($dbLink, "stats_misc_COTO_rent_monthly();", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 1;
										echo '<BR><H2>Cotos used to add rent credit, per month</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Month</th><th>Amount</th><th>% of Total</th></tr>';
										
										$total = 0;
										foreach ( $data as $_row )
										{
											$total += $_row["Amount"];
										}
										$halfMarker = $total / 2;
										foreach ( $data as $_row )
										{
											echo '<tr><td>' . $_row["date"] . '</td><td>' . $_row["Amount"] . '</td><td>'. number_format($_row["Amount"] / $total * 100 ,2) . '%</td></tr>';
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

