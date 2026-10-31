class RecipeModel {
  final String idMeal;
  final String strMeal;
  final String strCategory;
  final String strMealThumb;
  final String strInstructions;

  RecipeModel({
    required this.idMeal,
    required this.strMeal,
    required this.strCategory,
    required this.strMealThumb,
    required this.strInstructions,
  });

  factory RecipeModel.fromJson(Map<String, dynamic> json) {
    return RecipeModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strCategory: json['strCategory'] ?? 'Umum',
      strMealThumb: json['strMealThumb'] ?? '',
      strInstructions: json['strInstructions'] ?? '',
    );
  }
}