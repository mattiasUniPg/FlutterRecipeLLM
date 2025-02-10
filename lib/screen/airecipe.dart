import 'package:cookingnf/models/recipe.dart';
import 'package:flutter/material.dart';

import '../services/api.dart';

class AIRecipeGeneratorScreen extends StatefulWidget {
  @override
  _AIRecipeGeneratorScreenState createState() => _AIRecipeGeneratorScreenState();
}

class _AIRecipeGeneratorScreenState extends State<AIRecipeGeneratorScreen> {
  Recipe? _generatedRecipe;
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AI Recipe Generator'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            ElevatedButton(
              onPressed: _generateRecipe,
              child: Text('Generate New Recipe'),
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 16),
              ),
            ),
            SizedBox(height: 24),
            if (_isLoading)
              Center(child: CircularProgressIndicator())
            else if (_generatedRecipe != null)
              Expanded(
                child: SingleChildScrollView(
                  child: RecipeDisplay(recipe: _generatedRecipe!),
                ),
              )
            else
              Center(
                child: Text(
                  'Press the button to generate a new recipe!',
                  style: Theme.of(context).textTheme.titleMedium,
                  textAlign: TextAlign.center,
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _generateRecipe() async {
    setState(() {
      _isLoading = true;
    });

    try {
      final recipe = await ApiService().generateCreativeRecipe();
      setState(() {
        _generatedRecipe = recipe;
        _isLoading = false;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error generating recipe: $e')),
      );
      setState(() {
        _isLoading = false;
      });
    }
  }
}

class RecipeDisplay extends StatelessWidget {
  final Recipe recipe;

  const RecipeDisplay({Key? key, required this.recipe}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          recipe.title,
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 24),
        Text(
          'Ingredients:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        ...recipe.ingredients.map((ingredient) => Padding(
              padding: EdgeInsets.only(bottom: 4),
              child: Text('• $ingredient'),
            )),
        SizedBox(height: 24),
        Text(
          'Instructions:',
          style: Theme.of(context).textTheme.titleLarge,
        ),
        SizedBox(height: 8),
        ...recipe.instructions.asMap().entries.map(
              (entry) => Padding(
                padding: EdgeInsets.only(bottom: 8),
                child: Text('${entry.key + 1}. ${entry.value}'),
              ),
            ),
        SizedBox(height: 24),
        ElevatedButton(
          onPressed: () {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Recipe saved!')),
            );
          },
          child: Text('Save Recipe'),
          style: ElevatedButton.styleFrom(
            padding: EdgeInsets.symmetric(vertical: 16),
          ),
        ),
      ],
    );
  }
}

