<?php
header('Content-Type: application/json');
include 'db.php';

if (isset($_GET['id'])) {
    $recipeId = $_GET['id'];

    $query = "SELECT r.id, r.title, r.description, r.image_url, r.details, c.name AS category
              FROM recipes r
              JOIN categories c ON r.category_id = c.id
              WHERE r.id = ?";

    $stmt = $connection->prepare($query);
    $stmt->bind_param('i', $recipeId);
    $stmt->execute();
    $result = $stmt->get_result();

    if ($result->num_rows > 0) {
        $recipe = $result->fetch_assoc();
        echo json_encode($recipe);
    } else {
        echo json_encode(['message' => 'Recipe not found']);
    }

    $stmt->close();
} else {
    echo json_encode(['message' => 'No recipe ID provided']);
}

$connection->close();
?>
