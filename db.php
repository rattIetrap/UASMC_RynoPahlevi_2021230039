<?php
header('Content-Type: application/json');
$connection = new mysqli("localhost", "mobw7774_rynop", "tyaslintang", "mobw7774_api_ryno");

if ($connection->connect_error) {
    die("Connection failed: " . $connection->connect_error);
}
?>
