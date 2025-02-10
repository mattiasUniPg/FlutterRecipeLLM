class Recipe {
  final String id;
  final String title;
  final List<String> ingredients;
  final List<String> instructions;

  Recipe({
    required this.id,
    required this.title,
    required this.ingredients,
    required this.instructions,
  });

  factory Recipe.fromJson(Map<String, dynamic> json) {
    return Recipe(
      id: json['id'],
      title: json['title'],
      ingredients: List<String>.from(json['ingredients']),
      instructions: List<String>.from(json['instructions']),
    );
  }

    Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'ingredients': ingredients,
      'instructions': instructions,
    };
  }

  static Stream<List<Recipe>> fromMap(data, id) {
    // Implement your logic here to convert data to List<Recipe>
    // For now, returning an empty stream
    return Stream.value([]);
  }
}

