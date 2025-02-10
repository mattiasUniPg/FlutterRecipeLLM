import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:cookingnf/models/recipe.dart';
import 'package:cookingnf/widgets/addrecipe.dart';
import 'package:cookingnf/widgets/navbar.dart';
import 'package:cookingnf/widgets/recipecard.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Recipe> _recipes = [];
  
  int _selectedIndex = 0;
  final List<Widget> _screens = [
    // Add your screens here
    Center(child: Text('Screen 1')),
    Center(child: Text('Screen 2')),
    Center(child: Text('Screen 3')),
  ];

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
            icon: Icon(Icons.login),
            onPressed: () => Navigator.pushNamed(context, '/login'),
          ),
          IconButton(
            icon: Icon(Icons.food_bank),
            onPressed: () => Navigator.pushNamed(context, '/p-recipes'),
          ),
          IconButton(
            icon: Icon(Icons.pages),
            onPressed: () => Navigator.pushNamed(context, '/mix-it'),
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: _recipes.length,
        itemBuilder: (context, index) {
          return RecipeCard(
            recipe: _recipes[index],
            onDelete: () => _removeRecipe(_recipes[index]), children: [],
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
