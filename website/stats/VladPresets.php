<?php
if ( isset($_REQUEST["r"]) )
{
	$r = true;
	
	$Archetype = $_REQUEST["archetype"];
	$Event = $_REQUEST["event"];
	$Time = $_REQUEST["time"];
	$TimeBack = $_REQUEST["timeback"];
	$args = dbsanitize($dbLink, $Time) . "," . dbsanitize($dbLink, $TimeBack) . "," . dbsanitize($dbLink, $Event) . "," . dbsanitize($dbLink, $Archetype);
}
else
{
	$r = false;
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
									if ( !($r) )
									{
										?>
										
<h2>Welcome to the economy quick-set quick-sets.</h2>

<form>
How much data?<br>
<table>
  <tr>
  <td><input type="radio" name="time" value="2Days" > 2 days (Hourly)
  </td><td><input type="radio" name="time" value="7Days" checked> 7 days (Daily)
  </td><td><input type="radio" name="time" value="1Month"> 1 Month (Daily)
  </td><td><input type="radio" name="time" value="3Month"> 3 Months(weekly) 
  </td></tr>
</table></br>
<br>
Starting when?<br>
<table>
  <tr>
  <td><input type="radio" name="timeback" value="2Days" >Starting 2 Days ago
  </td><td><input type="radio" name="timeback" value="7Days" checked>Starting 1 Week ago
  </td><td><input type="radio" name="timeback" value="1Month"> Starting 1 Month ago
  </td></tr><tr>
  <td><input type="radio" name="timeback" value="3Month"> Starting 3 Months Ago
  </td><td><input type="radio" name="timeback" value="6Month"> Starting 6 Months Ago
  </td><td><input type="radio" name="timeback" value="12Month"> Starting 12 Months Ago
  </td></tr>
</table></br>
Event<br>
<table>
  <tr>
  <td><input type="radio" name="event" value="ItemDestroyed_Crafting" >ItemDestroyed_Crafting
  </td><td><input type="radio" name="event" value="ItemDestroyed_CrownMerchant">ItemDestroyed_CrownMerchant
  </td><td><input type="radio" name="event" value="ItemDestroyed_Merchant">ItemDestroyed_Merchant
  </td></tr><tr>
  <td><input type="radio" name="event" value="ItemGained_Crafting">ItemGained_Crafting
  </td><td><input type="radio" name="event" value="ItemGained_Loot" checked>ItemGained_Loot
  </td><td><input type="radio" name="event" value="ItemGained_HarvestPlant">ItemGained_HarvestPlant
  </td></tr><tr>
  <td><input type="radio" name="event" value="ItemGained_Merchant">ItemGained_Merchant
  </td><td><input type="radio" name="event" value="ItemDestroyed_AddCreditToTaxAccount">ItemDestroyed_AddCreditToTaxAccount	(Requires Gold COTO selection)								
  </td><td><input type="radio" name="event" value="Merchant_ItemPurchased">Merchant_ItemPurchased									
  </td></tr><tr>
  </td><td><input type="radio" name="event" value="Merchant_ItemRefunded">Merchant_ItemRefunded									
  </td></tr>
</table></br>

<br>
Items, click to expand the category:  <br>
DEFAULT: <input type="radio" name="archetype" value="CotO/CotO_Coin_Gold" checked>Gold COTO
<div id="collapse4">
<h2>Ores</h2><div>
<table>
  <tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Copper" >Copper Ore
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Iron">Iron Ore
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Gold">Gold Ore
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Silver">Silver Ore
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Iron_Catalyst02_Tungsten">Tungsten Ore
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Copper_Catalyst01_Tin">Tin Ore
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Ore_Iron_Catalyst01_Nickel">Nickel Ore
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Rock_Granite">Granite									
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Rock_Clay">Clay
  </td></tr>
</table></div></div>
<div id="collapse3">
<h2>Woods</h2><div>
<table>
  <tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Wood_Maple" >Maple Wood
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Wood_Pine">Pine Wood
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Wood_Maple_Catalyst01_SootyBark">Sooty Bark
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Wood_Pine_Catalyst01_PineResin">Pine Resin
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Refined/ItemRefinedMat_Scrap_Wood">Scrap Wood
  </td><td><input type="radio" name="archetype" value="Ingredients/Components_Raw/Bark/ItemRawMat_Bark_Maple">Maple Bark
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Components_Raw/Bark/ItemRawMat_Bark_Pine">Pine Bark
  </td></tr>
</table></div></div>

<div id="collapse2">
<h2>Tailoring</h2>
<div>
<table>
  <tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Textile_Leather_Catalyst01_Suet" >Suet
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Textile_Cotton_Catalyst01_Carapace">Beetle Carapace
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Textile_Cotton">Cotton
  </td><td><input type="radio" name="archetype" value=" Ingredients/Materials_Raw/ItemRawMat_Textile_Leather">Leather
  </tr>
  
 
  </td></tr>
</table></div></div>
<div id="collapse">
<h2>Uncut Gems</h2>
<div>
<table>
  <tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Sapphire" >Sapphire
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Ruby">Ruby
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Onyx">Onyx
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Garnet">Garnet
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Emerald">Emerald
  </td><td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Diamond">Diamond
  </td></tr><tr>
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Citrine">Citrine
  <td><input type="radio" name="archetype" value="Ingredients/Materials_Raw/ItemRawMat_Gem_Amethyst">Amethyst
  </td></tr>
</table>
</div></div>
</br>
<input type="hidden" name="r" value="true">
<input type="hidden" name="p" value="VladPresets">
<button type="submit">Collect Data</button>
</form> 

						<script>
$( "#collapse" ).accordion({
    collapsible: true,
    active: false
});
$( "#collapse2" ).accordion({
    collapsible: true,
    active: false
});
$( "#collapse3" ).accordion({
    collapsible: true,
    active: false
});
$( "#collapse4" ).accordion({
    collapsible: true,
    active: false
});
</script>				
										
										
										<?php
									}
									else
									{
										
									$result = c_mysqli_call($dbLink, "stats_vlad_presets", $args);
								
									$data = $result;	
									
									if ( $result )
									{	
										$countDivisor = 3;
										$count = 0;
										$total = 0;
										echo 'Results for ' . $Archetype . '<br>Event: ' . $Event. '<br>Amount:    ' . $Time . '<br>Starting how long ago: ' . $TimeBack. ' <table>';
										echo '<tr><td width=75>   Time Start    </td><td width=75>Time End</td><td width=75>Quantity</td><td>EGDelta</td></tr>';
										
										foreach ( $data as $_row )
										{
											?>
											<tr>
											<td> <?php echo $_row["time"]?> </td>
											<td> <?php echo $_row["timeend"]?> </td>
											<td> <center><?php echo $_row["quantity"]?></center> </td>
											<td> <?php echo $_row["economyGoldDelta"]?> </td>
											</tr><?php
											$total += $_row["quantity"];
										}
										
										echo '</table>Total: ' . $total . '<br>';
									}	
									}
									/*
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
								<?php } 
								
								
								*/?>
								<br><br>
									</section>					
							</section>

						</div>
					</div>
				</div>
			</div>

