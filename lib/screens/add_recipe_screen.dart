import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cookbook_model.dart';
import '../providers/cookbook_provider.dart';

class AddRecipeScreen extends StatefulWidget {
  const AddRecipeScreen({super.key});

  @override
  State<AddRecipeScreen> createState() => _AddRecipeScreenState();
}

class _AddRecipeScreenState extends State<AddRecipeScreen> {
  final _recipeIdController = TextEditingController();
  final _titleController = TextEditingController();
  final _categoryController = TextEditingController(); 
  final _imageController = TextEditingController();
  final _instructionsController = TextEditingController();
  final _noteController = TextEditingController();
  
  String _selectedStatus = 'Ingin Dicoba';
  String _selectedDifficulty = 'Mudah';
  bool _isLoading = false;

  @override
  void dispose() {
    _recipeIdController.dispose();
    _titleController.dispose();
    _categoryController.dispose();
    _imageController.dispose();
    _instructionsController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  Future<void> _saveRecipe() async {
    if (_recipeIdController.text.isEmpty || _titleController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Recipe ID dan Judul Resep tidak boleh kosong!')),
      );
      return;
    }

    setState(() => _isLoading = true);

    try {
      final provider = Provider.of<CookbookProvider>(context, listen: false);
      
      final newItem = CookbookModel(
        recipeId: _recipeIdController.text,
        recipeName: _titleController.text,
        category: _categoryController.text.isEmpty ? 'Umum' : _categoryController.text,
        imageUrl: _imageController.text,
        instructions: _instructionsController.text,
        note: _noteController.text,
        status: _selectedStatus,
        difficulty: _selectedDifficulty,
      );

      bool isSaved = await provider.saveToCookbook(newItem);

      if (!mounted) return;

      if (isSaved) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resep berhasil disimpan ke Cookbook!')),
        );
      } else {
        setState(() => _isLoading = false);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Resep dengan Recipe ID tersebut sudah ada di Buku Resep Anda!')),
        );
      }
    } catch (e) {
      setState(() => _isLoading = false);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Gagal menyimpan resep: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tambah Resep Baru'),
        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _recipeIdController,
              decoration: const InputDecoration(
                labelText: 'Recipe ID (Contoh: rec_001)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Judul Resep',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _categoryController,
              decoration: const InputDecoration(
                labelText: 'Kategori (Contoh: Dessert/Beef/dll)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _imageController,
              decoration: const InputDecoration(
                labelText: 'URL Gambar Resep (Link Internet)',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instructionsController,
              maxLines: 3,
              decoration: const InputDecoration(
                labelText: 'Instruksi Pembuatan',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status Resep',
                border: OutlineInputBorder(),
              ),
              items: ['Ingin Dicoba', 'Sudah Dicoba', 'Favorit'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedStatus = val);
              },
            ),
            const SizedBox(height: 16),
            DropdownButtonFormField<String>(
              initialValue: _selectedDifficulty,
              decoration: const InputDecoration(
                labelText: 'Tingkat Kesulitan',
                border: OutlineInputBorder(),
              ),
              items: ['Mudah', 'Sedang', 'Sulit'].map((diff) {
                return DropdownMenuItem(value: diff, child: Text(diff));
              }).toList(),
              onChanged: (val) {
                if (val != null) setState(() => _selectedDifficulty = val);
              },
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _noteController,
              maxLines: 2,
              decoration: const InputDecoration(
                labelText: 'Catatan Pribadi',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 255, 156, 43),
                  foregroundColor: Colors.white,
                ),
                onPressed: _isLoading ? null : _saveRecipe,
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        'Simpan Resep',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}