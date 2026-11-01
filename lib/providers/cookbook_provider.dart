import 'package:flutter/foundation.dart';
import '../models/cookbook_model.dart';
import '../services/supabase_service.dart';
import '../models/recipe_model.dart';

class CookbookProvider with ChangeNotifier {
  final SupabaseService _supabaseService = SupabaseService();
  
  List<CookbookModel> _cookbookItems = [];
  bool _isLoading = false;

  List<CookbookModel> get cookbookItems => _cookbookItems;
  bool get isLoading => _isLoading;

  Future<void> fetchCookbook() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cookbookItems = await _supabaseService.getCookbookItems();
    } catch (e) {
      debugPrint('Error fetching cookbook: $e');
    }

    _isLoading = false;
    notifyListeners();
  }

  Future<bool> saveToCookbook({
    required RecipeModel recipe,
    String note = '',
    String difficulty = 'Sedang',
    String status = 'Ingin Dicoba',
  }) async {
    try {
      final isExist = _cookbookItems.any((item) => item.recipeId == recipe.idMeal);
      if (isExist) {
        return false; 
      }

      await _supabaseService.addRecipeFromApi(
        recipe: recipe,
        note: note,
        difficulty: difficulty,
        status: status,
      );
      
      await fetchCookbook();
      return true; 
    } catch (e) {
      debugPrint('Error saving recipe: $e');
      rethrow;
    }
  }
}