import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cookbook_model.dart';
import '../models/recipe_model.dart'; 

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<CookbookModel>> getCookbookItems() async {
    final response = await _client
        .from('my_cookbook')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => CookbookModel.fromJson(json)).toList();
  }

  Future<void> addToCookbook(CookbookModel item) async {
    await _client.from('my_cookbook').insert(item.toJson());
  }

  Future<void> addRecipeFromApi({
    required RecipeModel recipe,
    String note = '',
    String difficulty = 'Sedang',
    String status = 'Ingin Dicoba',
  }) async {
    final newItem = CookbookModel(
      recipeId: recipe.idMeal,
      recipeName: recipe.strMeal,
      category: recipe.strCategory,
      imageUrl: recipe.strMealThumb,
      note: note,
      difficulty: difficulty,
      status: status,
      instructions: recipe.strInstructions
    );
    await addToCookbook(newItem);
  }

}