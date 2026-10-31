import '../models/recipe_model.dart';
import '../models/cookbook_model.dart';
import '../services/api_service.dart';
import '../services/supabase_service.dart';

class RecipeRepository {
  final ApiService _apiService = ApiService();
  final SupabaseService _supabaseService = SupabaseService();

  // Ambil data dari API TheMealDB
  Future<List<RecipeModel>> getRecipes(String query) async {
    return await _apiService.fetchRecipes(query);
  }

  // Operasi Database Supabase (My Cookbook)
  Future<List<CookbookModel>> getCookbook() async {
    return await _supabaseService.getCookbookItems();
  }

  Future<void> addRecipeToCookbook(CookbookModel item) async {
    await _supabaseService.addToCookbook(item);
  }

  Future<void> updateCookbook(int id, Map<String, dynamic> data) async {
    await _supabaseService.updateCookbookItem(id, data);
  }

  Future<void> deleteCookbook(int id) async {
    await _supabaseService.deleteCookbookItem(id);
  }
}