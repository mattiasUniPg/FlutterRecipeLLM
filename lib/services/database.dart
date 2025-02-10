import 'package:firebase_auth/firebase_auth.dart';
import 'package:cookingnf/models/recipe.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class DatabaseService {
  final Supabase _supabase = Supabase.instance.client as Supabase;
  final String uid = FirebaseAuth.instance.currentUser!.uid;
  
  static String url = '';
  
  static Map<String, String> headers = {};

  Stream<List<Recipe>> getUserRecipes() {
    return _supabase
        .collection('recipes')
        .where('author', isEqualTo: uid)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList());
  }

  Stream<List<Recipe>> getPublicRecipes() {
    return _supabase
        .collection('recipes')
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Recipe.fromMap(doc.data(), doc.id)).toList());
  }

  Future<void> addRecipe(String title) async {
    await _supabase.collection('recipes').add({
      'title': title,
      'author': uid,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> deleteRecipe(String recipeId) async {
    await _supabase.collection('recipes').doc(recipeId).delete();
  }
}

extension on SupabaseStorageClient {
  Supabase? get instance => null;
}

class FieldValue {
  static serverTimestamp() {}
}

extension on Supabase {
  collection(String s) {}
}
