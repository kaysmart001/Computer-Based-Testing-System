<?php
$servername = "sql311.epizy.com";
$dbusername = "epiz_33459705";
$dbpassword = "hvZgW4p2guu7";
$dbname = "epiz_33070717_test_db";

// Create connection
$conn = mysqli_connect($servername, $dbusername, $dbpassword, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " .$conn->connect_error);
}
else{
    
}

?>
