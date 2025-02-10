import 'dart:convert';
import 'package:http/http.dart' as http;

import '../models/recipe.dart';
import 'auth.dart';

class ApiService {
  final String baseUrl = 'http://localhost:3000/api'; // Change this to your backend URL

  Future<String> _getToken() async {
    return await AuthService().getIdToken();
  }

  Future<List<Recipe>> getUserRecipes() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/recipes'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load recipes');
    }
  }

  Future<void> addRecipe(String title) async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/recipes'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'title': title}),
    );

    if (response.statusCode != 201) {
      throw Exception('Failed to add recipe');
    }
  }

  Future<void> deleteRecipe(String id) async {
    final token = await _getToken();
    final response = await http.delete(
      Uri.parse('$baseUrl/recipes/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to delete recipe');
    }
  }

  Future<List<Recipe>> getPublicRecipes() async {
    final token = await _getToken();
    final response = await http.get(
      Uri.parse('$baseUrl/recipes/public'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Recipe.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load public recipes');
    }
  }

  Future<Recipe> generateCreativeRecipe() async {
    final token = await _getToken();
    final response = await http.post(
      Uri.parse('$baseUrl/recipes/generate'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Recipe.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to generate creative recipe');
    }
  }
}

