<?php
header('Content-Type: application/json');
include 'db.php';

$query = "SELECT r.id, r.title, r.description, r.image_url, c.name AS category 
          FROM recipes r 
          JOIN categories c ON r.category_id = c.id";

$result = $connection->query($query);

$recipes = [];
while ($row = $result->fetch_assoc()) {
    $recipes[] = $row;
}

echo json_encode($recipes);
?>
