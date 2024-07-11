import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;

  const RecipeCard({required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              recipe.title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: recipe.imageUrl != null
                  ? Image.network(
                recipe.imageUrl!, // Use ! to assert non-nullability
                fit: BoxFit.cover, // Adjust the fit according to your preference
                height: 200, // Set a fixed height if needed
              )
                  : Container(), // Placeholder or fallback widget when imageUrl is null
            ),
            SizedBox(height: 8),
            Text(recipe.description),
            SizedBox(height: 8),
            Text(recipe.details),
          ],
        ),
      ),
    );
  }
}
