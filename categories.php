<?php
header('Content-Type: application/json');
include 'db.php';

$query = "SELECT * FROM categories";
$result = $connection->query($query);

if ($result) {
    $categories = [];
    while ($row = $result->fetch_assoc()) {
        $categories[] = $row;
    }
    echo json_encode($categories);
} else {
    echo json_encode(["message" => "Error fetching categories"]);
}
?>
