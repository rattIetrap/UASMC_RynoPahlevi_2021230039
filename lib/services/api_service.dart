import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import '../models/recipe.dart';

class ApiService {
  static const String baseUrl = 'http://mobilecomputing.my.id/api_ryno/api';

  static Future<bool> login(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/login.php'),
      body: {
        'username': username,
        'password': password,
      },
    );

    print('Login response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['message'] == 'Login successful') {
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString('username', username);
        return true;
      }
    }
    return false;
  }

  static Future<bool> register(String username, String password) async {
    final response = await http.post(
      Uri.parse('$baseUrl/register.php'),
      body: {
        'username': username,
        'password': password,
      },
    );

    print('Register response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'] == 'User registered successfully';
    }
    return false;
  }

  static Future<bool> addCategory(String name) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_category.php'),
      body: {
        'name': name,
      },
    );

    print('Add Category response: ${response.body}');

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return data['message'] == 'Category added successfully';
    }
    return false;
  }

  static Future<List<Map<String, dynamic>>> getCategories() async {
    final response = await http.get(Uri.parse('$baseUrl/categories.php'));

    if (response.statusCode == 200) {
      List categories = json.decode(response.body);
      return categories.map((category) => {
        'id': category['id'],
        'name': category['name']
      }).toList();
    } else {
      throw Exception('Failed to load categories');
    }
  }


  static Future<bool> addRecipe(String title, String description, String imageUrl, String details, String categoryId) async {
    final response = await http.post(
      Uri.parse('$baseUrl/add_recipe.php'),
      body: {
        'title': title,
        'description': description,
        'image_url': imageUrl,
        'details': details,
        'category_id': categoryId,
      },
    );

    print('Add Recipe response: ${response.body}'); // Tambahkan ini untuk debugging

    if (response.statusCode == 200) {
      return json.decode(response.body)['success'];
    } else {
      return false;
    }
  }


  static Future<Recipe?> getRecipeDetail(String recipeId) async {
    final response = await http.get(Uri.parse('$baseUrl/recipe_detail.php?id=$recipeId'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return Recipe.fromJson(data);
    } else {
      throw Exception('Failed to load recipe detail');
    }
  }



  static Future<List<Recipe>> getRecipes() async {
    final response = await http.get(Uri.parse('$baseUrl/recipes.php'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }
}
