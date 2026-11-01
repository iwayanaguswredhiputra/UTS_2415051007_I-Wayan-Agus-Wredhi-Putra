import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/recipe_model.dart';
import '../providers/cookbook_provider.dart';

class DetailScreen extends StatelessWidget {
  final RecipeModel recipe;

  const DetailScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(recipe.strMeal),
        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              recipe.strMealThumb,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    recipe.strMeal,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text('Kategori: ${recipe.strCategory}'),
                    backgroundColor: const Color.fromARGB(255, 255, 230, 200),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Instruksi Pembuatan:',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    recipe.strInstructions,
                    style: const TextStyle(fontSize: 14, height: 1.5),
                  ),
                  const SizedBox(height: 24),
                  
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton.icon(
                      onPressed: () async {
                        try {
                          final provider = Provider.of<CookbookProvider>(context, listen: false);
                          
                          bool success = await provider.saveToCookbook(
                            recipe: recipe,
                            note: 'Resep favorit pilihan saya',
                            difficulty: 'Sedang',
                            status: 'Ingin Dicoba',
                          );

                          if (!context.mounted) return;

                          if (success) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(content: Text('Berhasil disimpan ke Buku Resep!')),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Resep ini sudah ada di Buku Resep Anda!'),
                                backgroundColor: Colors.orange,
                              ),
                            );
                          }
                        } catch (e) {
                          if (!context.mounted) return;
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('Gagal menyimpan resep: $e')),
                          );
                        }
                      },
                      icon: const Icon(Icons.bookmark_add),
                      label: const Text('Simpan ke Buku Resep'),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}