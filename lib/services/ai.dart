import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe.dart';

class AIService {
  final String apiUrl = 'YOUR_AI_API_ENDPOINT';

  Future<Recipe> generateCreativeRecipe() async {
    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {'Content-Type': 'application/json'},
      body: json.encode({
        'prompt': 'Generate a creative recipe with title, description, ingredients, and instructions.',
      }),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Recipe(
        id: DateTime.now().toString(),
        title: data['title'],
        ingredients: List<String>.from(data['ingredients']),
        instructions: List<String>.from(data['instructions']),
      );
    } else {
      throw Exception('Failed to generate recipe');
    }
  }
}

