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
								<?php
								function data_uri($file, $mime) 
								{  

								  $contents = file_get_contents($file);
								  $base64   = base64_encode($contents); 
								  return ('data:' . $mime . ';base64,' . $base64);
								}
								
									$backgroundImage = 'http://www.sotastats.umuri.com/GCotoUseWeek.php';
									
									//$data = $result;	
								
									//echo $backgroundImage . "<br>";
									//echo $overlayImage . "<br>";
									?>
							
									<img src="<?php echo data_uri($backgroundImage,'image/png'); ?>"  
									alt="LOADING..." class="right" style="max-width:100%;height: auto;" />	
								<br>
								<h2>Legend</h2>
								Gained - These are GCotos dropped via kills, crafting, etc.<br>
								Bank Claimed - These are GCotos people initially claim in their bank via Claim Rewards. This includes GCotos from Pledges, Kickstarter, Add-on Store Purchases/Bundles, AND the 5 GCoto QA testing reward every release.  In addition, this is reported when they are -claimed-, meaning someone pushed the claim rewards button on their bank and got more GCotos.<br>
								Spent - These are GCotos that were spent on Taxes, Crafting, etc. Does not include Crown Merchant<br>
								CrownMerchant - These are GCotos that were spent at the Crown Merchant for items or other Cotos.<br>
								<br>
								</section>					
						

						</div>
					</div>
				</div>
			</div>

