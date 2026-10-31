import 'package:flutter/material.dart';
import '../models/recipe_model.dart';

class RecipeProvider with ChangeNotifier {
  // Contoh daftar resep sementara (dummy data) sebelum terhubung ke database
  final List<RecipeModel> _recipes = [
    RecipeModel(
      idMeal: '1',
      strMeal: 'Ayam Betutu Khas Bali',
      strCategory: 'Makanan Utama',
      strMealThumb: 'https://images.unsplash.com/photo-1555939594-58d7cb561ad1',
      strInstructions: 'Lumuri ayam dengan bumbu genep khas Bali, bungkus dengan daun pisang, lalu panggang hingga matang.',
    ),
    RecipeModel(
      idMeal: '2',
      strMeal: 'Sate Lilit Ayam',
      strCategory: 'Makanan Utama',
      strMealThumb: 'https://images.unsplash.com/photo-1544025162-d76694265947',
      strInstructions: 'Campurkan daging ayam cincang dengan kelapa parut dan bumbu rempah, lilitkan pada tusuk sate, lalu bakar.',
    ),
  ];

  List<RecipeModel> get recipes => _recipes;

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  // Method untuk mengubah status loading saat mengambil data
  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  // Method untuk menambah resep baru ke state
  void addRecipe(RecipeModel recipe) {
    _recipes.add(recipe);
    notifyListeners();
  }
}