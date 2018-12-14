<?php require_once($_SERVER['DOCUMENT_ROOT'] . '/manageSession.php'); ?>
<?php
$MonsterName = urldecode($_REQUEST["MonsterName"]);
$InputValue = urldecode($_REQUEST["inputValue"]);
$SceneName = urldecode($_REQUEST["SceneName"]);
$InputCategory = urldecode($_REQUEST["inputCategory"]);



$args = dbsanitize($dbLink, $LoggedInUser) 
		.',' . dbsanitize($dbLink,$MonsterName)
		.',' . dbsanitize($dbLink,$SceneName)
		.',' . dbsanitize($dbLink,$InputCategory)
		.',' . dbsanitize($dbLink,$InputValue);
									
$result = c_mysqli_call($dbLink, "stats_submit_alteration_monster", $args);

$data = $result;	

echo $InputValue;
 ?>