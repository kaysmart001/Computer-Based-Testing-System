<?php
$servername = "sql105.epizy.com";
$dbusername = "epiz_33070717";
$dbpassword = "WBtcNlYDj3Y5qkD";
$dbname = "epiz_33070717_cbttest_db";

// Create connection
$conn = mysqli_connect($servername, $dbusername, $dbpassword, $dbname);
// Check connection
if ($conn->connect_error) {
    die("Connection failed: " . $conn->connect_error);
}
