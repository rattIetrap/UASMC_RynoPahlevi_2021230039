import 'package:flutter/material.dart';
import 'login_screen.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import '../widgets/recipe_card.dart';
import 'recipe_detail_screen.dart'; // Import RecipeDetailScreen

class HomeScreenViewOnly extends StatefulWidget {
  @override
  _HomeScreenViewOnlyState createState() => _HomeScreenViewOnlyState();
}

class _HomeScreenViewOnlyState extends State<HomeScreenViewOnly> {
  late Future<List<Recipe>> _futureRecipes;

  @override
  void initState() {
    super.initState();
    _futureRecipes = ApiService.getRecipes();
  }

  void _navigateToLogin() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>
          RecipeDetailScreen(
              recipeId: recipe.id)), // Pass recipe.id as recipeId
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Catalog'),
        actions: [
          IconButton(
            icon: Icon(Icons.login),
            onPressed: _navigateToLogin,
          ),
        ],
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Text(
              'Welcome to the Recipe Catalog!',
              style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Explore our delicious collection of recipes. Please login to view more details.',
              style: TextStyle(fontSize: 16.0),
            ),
          ),
          Expanded(
            child: FutureBuilder<List<Recipe>>(
              future: _futureRecipes,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Failed to load recipes'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return Center(child: Text('No recipes available'));
                } else {
                  final recipes = snapshot.data!;
                  return ListView.builder(
                    itemCount: recipes.length,
                    itemBuilder: (context, index) {
                      final recipe = recipes[index];
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () => _navigateToRecipeDetail(recipe),
                          child: RecipeCard(recipe: recipe),
                        ),
                      );
                    },
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }

}
