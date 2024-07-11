import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddRecipeScreen extends StatefulWidget {
  @override
  _AddRecipeScreenState createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _imageUrlController = TextEditingController();
  final _detailsController = TextEditingController();
  List<Map<String, dynamic>> _categories = [];
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() async {
    final categories = await ApiService.getCategories();
    setState(() {
      _categories = categories;
    });
  }

  void _addRecipe() async {
    final title = _titleController.text;
    final description = _descriptionController.text;
    final imageUrl = _imageUrlController.text;
    final details = _detailsController.text;
    final categoryId = _selectedCategory;

    if (categoryId != null && title.isNotEmpty && description.isNotEmpty && details.isNotEmpty) {
      final success = await ApiService.addRecipe(
        title,
        description,
        imageUrl,
        details,
        categoryId,
      );

      if (success) {
        // Clear text fields after successfully adding recipe
        _titleController.clear();
        _descriptionController.clear();
        _imageUrlController.clear();
        _detailsController.clear();

        // Show snackbar after adding recipe
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Recipe added successfully')),
        );

        // Navigate back to HomeScreen and pass the new recipe data
        Navigator.pop(context, true);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add recipe')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please fill all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Recipe')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: _imageUrlController,
              decoration: InputDecoration(labelText: 'Image URL'),
            ),
            TextField(
              controller: _detailsController,
              decoration: InputDecoration(labelText: 'Details'),
            ),
            DropdownButtonFormField<String>(
              value: _selectedCategory,
              hint: Text('Select Category'),
              items: _categories.map((category) {
                return DropdownMenuItem<String>(
                  value: category['id'].toString(),
                  child: Text(category['name']),
                );
              }).toList(),
              onChanged: (value) {
                setState(() {
                  _selectedCategory = value;
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addRecipe,
              child: Text('Add Recipe'),
            ),
          ],
        ),
      ),
    );
  }
}
