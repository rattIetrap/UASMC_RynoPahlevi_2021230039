import 'package:flutter/material.dart';
import '../models/recipe.dart';
import '../services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/recipe_card.dart';
import 'login_screen.dart';
import 'add_category_screen.dart';
import 'add_recipe_screen.dart';
import 'recipe_detail_screen.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Future<List<Recipe>> _futureRecipes;

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  void _loadRecipes() {
    setState(() {
      _futureRecipes = ApiService.getRecipes();
    });
  }

  void _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  void _openAddCategoryScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddCategoryScreen()),
    );
  }

  void _openAddRecipeScreen() async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => AddRecipeScreen()),
    );

    if (result != null && result is bool && result) {
      _loadRecipes();
    }
  }

  void _navigateToRecipeDetail(Recipe recipe) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecipeDetailScreen(recipeId: recipe.id)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Recipe Catalog'),
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: _openAddCategoryScreen,
            tooltip: 'Add Category',
          ),
          IconButton(
            icon: Icon(Icons.add_circle),
            onPressed: _openAddRecipeScreen,
            tooltip: 'Add Recipe',
          ),
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: _logout,
            tooltip: 'Logout',
          ),
        ],
      ),
      body: FutureBuilder<List<Recipe>>(
        future: _futureRecipes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            print('Error: ${snapshot.error}');
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
    );
  }
}
