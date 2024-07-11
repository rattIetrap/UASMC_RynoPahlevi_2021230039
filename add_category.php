<?php
header('Content-Type: application/json');
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $name = $_POST['name'];

    $query = "INSERT INTO categories (name) VALUES ('$name')";

    if ($connection->query($query) === TRUE) {
        echo json_encode(["message" => "Category added successfully"]);
    } else {
        echo json_encode(["message" => "Error: " . $query . "<br>" . $connection->error]);
    }
}
?>
