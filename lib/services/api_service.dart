import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/recipe_model.dart';

class ApiService {
  static const String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<RecipeModel>> fetchRecipes(String query) async {
    final response = await http.get(Uri.parse('$baseUrl/search.php?s=$query'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      if (data['meals'] != null) {
        final List meals = data['meals'];
        return meals.map((json) => RecipeModel.fromJson(json)).toList();
      }
      return [];
    } else {
      throw Exception('Gagal memuat data resep dari API');
    }
  }
}