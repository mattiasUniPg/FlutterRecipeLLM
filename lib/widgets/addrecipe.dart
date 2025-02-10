import 'dart:math';

import 'package:flutter/material.dart';
import '../models/recipe.dart';

class AddRecipeDialog extends StatefulWidget {
  @override
  _AddRecipeDialogState createState() => _AddRecipeDialogState();
}

class _AddRecipeDialogState extends State<AddRecipeDialog> {
  final _titleController = TextEditingController();
  final _ingredientsController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _authorController = TextEditingController();
  final _descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add New Recipe'),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _ingredientsController,
              decoration: InputDecoration(labelText: 'Ingredients (comma-separated)'),
              maxLines: 3,
            ),
            TextField(
              controller: _instructionsController,
              decoration: InputDecoration(labelText: 'Instructions (comma-separated)'),
              maxLines: 3,
            ),
            TextField(
              controller: _authorController,
              decoration: InputDecoration(labelText: 'Author (comma-separated)'),
              maxLines: 3,
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'description (comma-separated)'),
              maxLines: 3,
            )
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: () {
            final newRecipe = Recipe(
              id: '',
              title: _titleController.text,
              ingredients: _ingredientsController.text.split(',').map((e) => e.trim()).toList(),
              instructions: _instructionsController.text.split(',').map((e) => e.trim()).toList(),
            );
            Navigator.of(context).pop(newRecipe);
          },
          child: Text('Add'),
        ),
      ],
    );
  }
}

