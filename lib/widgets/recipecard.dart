import 'package:flutter/material.dart';
import '../models/recipe.dart';

class RecipeCard extends StatelessWidget {
  final Recipe recipe;
  final VoidCallback? onDelete;

  const RecipeCard({Key? key, required this.recipe, this.onDelete, required List<Expanded> children}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  recipe.title,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                if (onDelete != null)
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: onDelete,
                  ),
              ],
            ),
            SizedBox(height: 8),
            Text('Ingredients:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.ingredients.map((ingredient) => Text('• $ingredient')),
            SizedBox(height: 8),
            Text('Instructions:', style: TextStyle(fontWeight: FontWeight.bold)),
            ...recipe.instructions.map((instruction) => Text('${recipe.instructions.indexOf(instruction) + 1}. $instruction')),
          ],
        ),
      ),
    );
  }
}

