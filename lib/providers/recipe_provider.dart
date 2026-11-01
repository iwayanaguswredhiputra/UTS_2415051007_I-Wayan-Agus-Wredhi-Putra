import 'package:flutter/material.dart';
import '../models/recipe_model.dart';
import '../services/recipe_api_service.dart'; 

class RecipeProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  List<RecipeModel> _recipes = [];
  bool _isLoading = false;
  String? _errorMessage;

  List<RecipeModel> get recipes => _recipes;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  Future<void> loadRecipes(String query) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    try {
      _recipes = await _apiService.fetchRecipes(query);
    } catch (e) {
      _errorMessage = e.toString();
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}