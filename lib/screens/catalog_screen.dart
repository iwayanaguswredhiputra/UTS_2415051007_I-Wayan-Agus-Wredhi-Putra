import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import 'detail_screen.dart';
import '../widgets/recipe_card.dart';
import '../widgets/empty_state_widget.dart';

class CatalogScreen extends StatefulWidget {
  const CatalogScreen({super.key});

  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      if (!mounted) return;
      Provider.of<RecipeProvider>(context, listen: false).loadRecipes('');
    });
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context);
    final allRecipes = recipeProvider.recipes;

    final filteredRecipes = allRecipes.where((recipe) {
      final nameLower = recipe.strMeal.toLowerCase();
      final categoryLower = recipe.strCategory.toLowerCase();
      final queryLower = _searchQuery.toLowerCase();
      return nameLower.contains(queryLower) || categoryLower.contains(queryLower);
    }).toList();

    final screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = 2; 
    if (screenWidth > 900) {
      crossAxisCount = 4; 
    } else if (screenWidth > 600) {
      crossAxisCount = 4; 
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Resep Masakan'),
        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Cari resep...',
                prefixIcon: const Icon(
                  Icons.search,
                  color: Color.fromARGB(255, 255, 156, 43),
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 156, 43),
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(
                    color: Color.fromARGB(255, 255, 156, 43),
                    width: 2,
                  ),
                ),
              ),
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
          
          Expanded(
            child: recipeProvider.isLoading
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Color.fromARGB(255, 255, 156, 43),
                    ),
                  )
                : filteredRecipes.isEmpty
                    ? const EmptyStateWidget(
                        message: 'Resep tidak ditemukan.',
                        icon: Icons.search_off,
                      )
                    : GridView.builder(
                        padding: const EdgeInsets.symmetric(horizontal: 16.0),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: crossAxisCount,  
                          crossAxisSpacing: 12.0,
                          mainAxisSpacing: 12.0,
                          childAspectRatio: 0.88, 
                        ),
                        itemCount: filteredRecipes.length,
                        itemBuilder: (context, index) {
                          final recipe = filteredRecipes[index];
                          
                          return RecipeCard(
                            title: recipe.strMeal,
                            category: recipe.strCategory,
                            imageUrl: recipe.strMealThumb,
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => DetailScreen(recipe: recipe),
                                ),
                              );
                            },
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}