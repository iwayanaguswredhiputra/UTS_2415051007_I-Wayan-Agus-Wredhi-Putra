import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../models/cookbook_model.dart';
import '../repositories/recipe_repository.dart';

class RecipeProvider with ChangeNotifier {
  final RecipeRepository _repository = RecipeRepository();

  List<RecipeModel> _apiRecipes = [];
  List<CookbookModel> _cookbookItems = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<RecipeModel> get apiRecipes => _apiRecipes;
  List<CookbookModel> get cookbookItems => _cookbookItems;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  // Fetch API Catalog
  Future<void> fetchApiRecipes(String query) async {
    _isLoading = true;
    _errorMessage = '';
    notifyListeners();

    try {
      _apiRecipes = await _repository.getRecipes(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Fetch Supabase Cookbook
  Future<void> fetchCookbook() async {
    _isLoading = true;
    notifyListeners();

    try {
      _cookbookItems = await _repository.getCookbook();
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  // Add to Cookbook
  Future<void> addCookbook(CookbookModel item) async {
    await _repository.addRecipeToCookbook(item);
    await fetchCookbook();
  }

  // Update Cookbook
  Future<void> updateCookbook(int id, Map<String, dynamic> data) async {
    await _repository.updateCookbook(id, data);
    await fetchCookbook();
  }

  // Delete from Cookbook
  Future<void> deleteCookbook(int id) async {
    await _repository.deleteCookbook(id);
    await fetchCookbook();
  }
}