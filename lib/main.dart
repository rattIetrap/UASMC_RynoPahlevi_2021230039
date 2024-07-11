// main.dart
import 'package:flutter/material.dart';
import 'screens/home_screen_view_only.dart';
import 'screens/home_screen.dart';
import 'screens/add_recipe_screen.dart';
import 'screens/add_category_screen.dart';
import 'screens/recipe_detail_screen.dart';
import 'screens/login_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Recipe Catalog',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => HomeScreenViewOnly(),
        '/home': (context) => HomeScreen(),
        '/login': (context) => LoginScreen(),
        '/add_recipe': (context) => AddRecipeScreen(),
        '/add_category': (context) => AddCategoryScreen(),
        '/recipe_detail': (context) => RecipeDetailScreen(recipeId: ModalRoute.of(context)?.settings.arguments as String),
      },
    );
  }
}
