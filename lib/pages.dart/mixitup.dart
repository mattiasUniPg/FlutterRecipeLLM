import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cookingnf/models/recipe.dart';
import 'package:cookingnf/widgets/recipecard.dart';

class MixItUpScreen extends StatefulWidget {
  const MixItUpScreen({super.key});

  @override
  _MixItUpScreenState createState() => _MixItUpScreenState();
}

class _MixItUpScreenState extends State<MixItUpScreen> {
  Recipe? _mixedRecipe;

  Future<void> _generateMixedRecipe() async {
    // This is a placeholder for the actual LLM-based recipe generation
    // In a real implementation, you would send the recipes to your backend
    // and use an LLM to generate a new recipe
    final response = await Supabase.instance.client
        .from('recipes')
        .select()
        .limit(5);
    final recipes = (response as List).map((data) => Recipe.fromJson(data)).toList();

    // Simulate recipe mixing
    final mixedIngredients = recipes.expand((r) => r.ingredients).toSet().toList();
    final mixedInstructions = recipes.expand((r) => r.instructions).toSet().toList();

    setState(() {
      _mixedRecipe = Recipe(
        id: 'mixed',
        title: 'Mixed Recipe',
        ingredients: mixedIngredients,
        instructions: mixedInstructions,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Mix It Up')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _generateMixedRecipe,
              child: Text('Generate Mixed Recipe'),
            ),
            SizedBox(height: 20),
            if (_mixedRecipe != null) RecipeCard(recipe: _mixedRecipe!, children: [],),
          ],
        ),
      ),
    );
  }
}

