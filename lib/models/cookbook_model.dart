class CookbookModel {
  final int? id;
  final String recipeId;
  final String recipeName;
  final String category;
  final String imageUrl;
  final String note;
  final String difficulty;
  final String status;
  final DateTime? createdAt;

  CookbookModel({
    this.id,
    required this.recipeId,
    required this.recipeName,
    required this.category,
    required this.imageUrl,
    required this.note,
    required this.difficulty,
    required this.status,
    this.createdAt,
  });

  factory CookbookModel.fromJson(Map<String, dynamic> json) {
    return CookbookModel(
      id: json['id'],
      recipeId: json['recipe_id'] ?? '',
      recipeName: json['recipe_name'] ?? '',
      category: json['category'] ?? '',
      imageUrl: json['image_url'] ?? '',
      note: json['note'] ?? '',
      difficulty: json['difficulty'] ?? 'Sedang',
      status: json['status'] ?? 'Ingin Dicoba',
      createdAt: json['created_at'] != null 
          ? DateTime.parse(json['created_at']) 
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'recipe_id': recipeId,
      'recipe_name': recipeName,
      'category': category,
      'image_url': imageUrl,
      'note': note,
      'difficulty': difficulty,
      'status': status,
    };
  }
}