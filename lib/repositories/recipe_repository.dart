import '../models/cookbook_model.dart';
import '../models/recipe_model.dart';
import '../services/recipe_api_service.dart';
import '../services/supabase_service.dart';
class RecipeRepository {
  final ApiService apiService;
  final SupabaseService supabaseService;

  RecipeRepository({
    required this.apiService,
    required this.supabaseService,
  });

  Future<List<RecipeModel>> getCatalogRecipes(String query) async {
    return await apiService.fetchRecipes(query);
  }

  Future<List<CookbookModel>> getCookbookItems() async {
    return await supabaseService.getCookbookItems();
  }

  Future<void> addRecipeToCookbook(CookbookModel item) async {
    await supabaseService.addToCookbook(item);
  }
}