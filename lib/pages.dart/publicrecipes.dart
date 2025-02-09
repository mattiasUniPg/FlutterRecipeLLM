import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/recipe.dart';
import '../widgets/recipecard.dart';

class PublicRecipesScreen extends StatefulWidget {
  @override
  _PublicRecipesScreenState createState() => _PublicRecipesScreenState();
}

class _PublicRecipesScreenState extends State<PublicRecipesScreen> {
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadPublicRecipes();
  }

  Future<void> _loadPublicRecipes() async {
    final response = await Supabase.instance.client
        .from('recipes')
        .select()
        .eq('is_public', true);
    setState(() {
      _recipes = (response as List).map((data) => Recipe.fromJson(data)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Public Recipes')),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(recipe: _recipes[index]);
        },
      ),
    );
  }
}

