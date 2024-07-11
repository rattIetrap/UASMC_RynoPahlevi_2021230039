<?php
header('Content-Type: application/json');
include 'db.php';

if ($_SERVER['REQUEST_METHOD'] == 'POST') {
    $title = $_POST['title'];
    $description = $_POST['description'];
    $image_url = $_POST['image_url'];
    $category_id = $_POST['category_id'];
    $details = $_POST['details'];

    $query = "INSERT INTO recipes (title, description, image_url, category_id, details) VALUES ('$title', '$description', '$image_url', '$category_id', '$details')";

    if ($connection->query($query) === TRUE) {
        echo json_encode(["message" => "Recipe added successfully"]);
    } else {
        echo json_encode(["message" => "Error: " . $query . "<br>" . $connection->error]);
    }
}
?>
