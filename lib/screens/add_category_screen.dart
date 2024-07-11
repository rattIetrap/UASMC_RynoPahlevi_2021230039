import 'package:flutter/material.dart';
import '../services/api_service.dart';

class AddCategoryScreen extends StatefulWidget {
  @override
  _AddCategoryScreenState createState() => _AddCategoryScreenState();
}

class _AddCategoryScreenState extends State<AddCategoryScreen> {
  final _categoryController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  void _addCategory() async {
    final category = _categoryController.text.trim();

    if (category.isNotEmpty) {
      final success = await ApiService.addCategory(category);

      if (success) {
        // Clear text field after successfully adding category
        _categoryController.clear();

        // Show snackbar after adding category
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Category added successfully')),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Failed to add category')),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please enter a category name')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Add Category')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Category Name'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _addCategory,
              child: Text('Add Category'),
            ),
          ],
        ),
      ),
    );
  }
}
