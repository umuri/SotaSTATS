<?php


require_once($_SERVER['DOCUMENT_ROOT'] . '/../ucfg/dbInclude.php'); 

$term = trim(strip_tags($_GET['term']));//retrieve the search term that autocomplete sends
if ( empty($term) )
{
	$term = "";
}


$result = c_mysqli_call($dbLink,"fsGetArchetypes","'".$term."'");

if( count($result) > 0) {
			  echo json_encode ($result);
		}
		else
		{
			$noMatch = array("value" => "", "label" => "no match",);
			
			echo json_encode($noMatch);
			
		}
		
  
?>