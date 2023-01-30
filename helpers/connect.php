<?php

// ERROR LOGS, BUT NO ERROR DISPLAYS

date_default_timezone_set("Africa/Lagos");

ini_set('display_errors', FALSE);

ini_set('log_errors', TRUE);

$conn=mysqli_connect('sql311.epizy.com','epiz_33459705','hvZgW4p2guu7','epiz_33459705_test_db') or die(mysqli_error($conn)); 

 $dsn = "mysql:host=sql311.epizy.com;dbname=epiz_33459705_test_db";

    try {

        $pdo = new PDO($dsn, 'epiz_33459705', 'hvZgW4p2guu7');

    }

    catch(PDOException $e) {

        echo $e->getMessage();

    }

$mysqli = new mysqli('sql311.epizy.com', 'epiz_33459705', 'hvZgW4p2guu7', 'epiz_33459705_test_db');

?>







