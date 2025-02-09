import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cookingnf/models/recipe.dart';
import 'package:cookingnf/widgets/recipecard.dart';
import 'package:cookingnf/widgets/addrecipe.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recipes = [];

  @override
  void initState() {
    super.initState();
    _loadRecipes();
  }

  Future<void> _loadRecipes() async {
    final userId = Supabase.instance.client.auth.currentUser!.id;
    final response = await Supabase.instance.client
        .from('recipes')
        .select()
        .eq('user_id', userId);
    setState(() {
      _recipes = (response as List).map((data) => Recipe.fromJson(data)).toList();
    });
  }

  Future<void> _addRecipe() async {
    final newRecipe = await showDialog<Recipe>(
      context: context,
      builder: (context) => AddRecipeDialog(),
    );

    if (newRecipe != null) {
      final userId = Supabase.instance.client.auth.currentUser!.id;
      await Supabase.instance.client.from('recipes').insert({
        'user_id': userId,
        'title': newRecipe.title,
        'ingredients': newRecipe.ingredients,
        'instructions': newRecipe.instructions,
      });
      _loadRecipes();
    }
  }

  Future<void> _removeRecipe(Recipe recipe) async {
    await Supabase.instance.client
        .from('recipes')
        .delete()
        .match({'id': recipe.id});
    _loadRecipes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My Recipes'),
        actions: [
          IconButton(
            icon: Icon(Icons.public),
            onPressed: () => Navigator.pushNamed(context, '/public'),
          ),
          IconButton(
            icon: Icon(Icons.shuffle),
            onPressed: () => Navigator.pushNamed(context, '/mix'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: _recipes[index],
            onDelete: () => _removeRecipe(_recipes[index]),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addRecipe,
        child: Icon(Icons.add),
      ),
    );
  }
}

