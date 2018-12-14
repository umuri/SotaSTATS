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
									$result = c_mysqli_call($dbLink, "stats_misc_AuctionsExperied", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										echo '<BR><H2>Items Lost due to expired auctions in the past week:</H2><div style="overflow-x:auto;"><table class="bacon">';
										echo '<tr><th>Time Stamp</th><th>Scene</th><th>Item</th><th>Quantity</th><th>EconomyGoldDelta</th></tr>';
										foreach ( $data as $_row )
										{
											echo '<tr>';
											foreach ($_row as $_key => $_value )
											{
											?>
											
											<td><?php echo $_value ?> </td>
											
												  <?php

											}												  
											echo '</tr>';
											
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

