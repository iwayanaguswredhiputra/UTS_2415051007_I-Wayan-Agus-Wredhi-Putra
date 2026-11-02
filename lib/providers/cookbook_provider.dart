import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import '../models/cookbook_model.dart';
import '../repositories/recipe_repository.dart';

class CookbookProvider extends ChangeNotifier {
  final RecipeRepository repository;

  CookbookProvider(this.repository);

  List<CookbookModel> _cookbookItems = [];
  bool _isLoading = false;

  List<CookbookModel> get cookbookItems => _cookbookItems;
  bool get isLoading => _isLoading;

  Future<void> fetchCookbook() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cookbookItems = await repository.getCookbookItems();
    } catch (e) {
      debugPrint('Error fetching cookbook: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<bool> saveToCookbook(CookbookModel item) async {
    bool isExist = _cookbookItems.any((element) => element.recipeId == item.recipeId);
    if (isExist) {
      return false; 
    }

    try {
      await repository.addRecipeToCookbook(item);
      await fetchCookbook(); 
      return true;
    } catch (e) {
      debugPrint('Error saving recipe: $e');
      rethrow;
    }
  }

  Future<void> updateCookbookItem(String id, Map<String, dynamic> updatedData) async {
    try {
      await Supabase.instance.client
          .from('my_cookbook')
          .update(updatedData) 
          .eq('id', id);      

      await fetchCookbook();   
      notifyListeners();
    } catch (e) {
      debugPrint('Gagal memperbarui resep: $e');
      rethrow;
    }
  }
}