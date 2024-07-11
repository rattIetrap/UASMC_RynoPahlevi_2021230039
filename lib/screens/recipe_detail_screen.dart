import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';

class RecipeDetailScreen extends StatefulWidget {
  final String recipeId;

  RecipeDetailScreen({required this.recipeId});

  @override
  _RecipeDetailScreenState createState() => _RecipeDetailScreenState();
}

class _RecipeDetailScreenState extends State<RecipeDetailScreen> {
  late Future<Recipe?> _futureRecipe;

  @override
  void initState() {
    super.initState();
    _futureRecipe = ApiService.getRecipeDetail(widget.recipeId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Recipe Detail')),
      body: FutureBuilder<Recipe?>(
        future: _futureRecipe,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error loading recipe detail: ${snapshot.error}');
            return Center(child: Text('Failed to load recipe detail'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            print('Recipe detail not found');
            return Center(child: Text('Recipe not found'));
          } else {
            final recipe = snapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (recipe.imageUrl != null && recipe.imageUrl!.isNotEmpty)
                      Image.network(recipe.imageUrl!)
                    else
                      Container(
                        height: 200,
                        color: Colors.grey,
                      ),
                    SizedBox(height: 16),
                    Text(
                      recipe.title,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      recipe.description,
                      style: TextStyle(fontSize: 16),
                    ),
                    SizedBox(height: 16), // Add this line
                    Text(
                      'Details',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8), // Add this line
                    Text(
                      recipe.details,
                      style: TextStyle(fontSize: 16),
                    ),
                    // Add other recipe details here, like ingredients and steps
                  ],
                ),
              ),
            );
          }
        },
      ),
    );
  }
}
