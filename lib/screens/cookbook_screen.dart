import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/cookbook_provider.dart';
import '../models/cookbook_model.dart'; 

class CookbookScreen extends StatefulWidget {
  const CookbookScreen({super.key});

  @override
  State<CookbookScreen> createState() => _CookbookScreenState();
}

class _CookbookScreenState extends State<CookbookScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<CookbookProvider>(context, listen: false).fetchCookbook();
    });
  }

  void _showRecipeDetail(BuildContext context, CookbookModel item) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(item.recipeName),
          content: SizedBox(
            width: double.maxFinite,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      item.imageUrl,
                      height: 160,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 80),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text('Tingkat Kesulitan: ${item.difficulty}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 4),
                  Text('Status: ${item.status}',
                      style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  const Text('Catatan Saya:',
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.orange)),
                  const SizedBox(height: 4),
                  Text(item.note.isNotEmpty ? item.note : 'Tidak ada catatan'),
                  const SizedBox(height: 12),
                  const Text(
                    'Instruksi Pembuatan:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    item.instructions.isNotEmpty ? item.instructions : 'Tidak ada instruksi tersedia.',
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Tutup'),
            ),
          ],
        );
      },
    );
  }

void _showEditDialog(BuildContext context, CookbookModel item) {
  final noteController = TextEditingController(text: item.note);
  String selectedStatus = item.status;
  String selectedDifficulty = item.difficulty;

  showDialog(
    context: context,
    builder: (context) => StatefulBuilder(
      builder: (context, setStateDialog) => AlertDialog(
        scrollable: true,
        insetPadding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 10.0), 
        title: const Text('Edit Buku Resep'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: noteController,
              decoration: const InputDecoration(
                labelText: 'Catatan Pribadi',
                border: OutlineInputBorder(),
              ),
              maxLines: 2,
            ),
            const SizedBox(height: 12),
            
            DropdownButtonFormField<String>(
              initialValue: selectedStatus,
              decoration: const InputDecoration(
                labelText: 'Status Resep',
                border: OutlineInputBorder(),
              ),
              items: ['Ingin Dicoba', 'Sudah Dicoba', 'Favorit'].map((status) {
                return DropdownMenuItem(value: status, child: Text(status));
              }).toList(),
              onChanged: (val) {
                if (val != null) setStateDialog(() => selectedStatus = val);
              },
            ),
            const SizedBox(height: 12),

            DropdownButtonFormField<String>(
              initialValue: selectedDifficulty,
              decoration: const InputDecoration(
                labelText: 'Tingkat Kesulitan',
                border: OutlineInputBorder(),
              ),
              items: ['Mudah', 'Sedang', 'Sulit'].map((diff) {
                return DropdownMenuItem(value: diff, child: Text(diff));
              }).toList(),
              onChanged: (val) {
                if (val != null) setStateDialog(() => selectedDifficulty = val);
              },
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Batal'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color.fromARGB(255, 255, 156, 43),
              foregroundColor: Colors.white,
            ),
            onPressed: () async {
              try {
                final provider = Provider.of<CookbookProvider>(context, listen: false);
                
                await provider.updateCookbookItem(item.id.toString(), {
                  'note': noteController.text,
                  'status': selectedStatus,
                  'difficulty': selectedDifficulty,
                });

                if (!context.mounted) return;
                Navigator.pop(context);

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Resep berhasil diperbarui!')),
                );
              } catch (e) {
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Gagal memperbarui: $e')),
                );
              }
            },
            child: const Text('Simpan'),
          ),
        ],
      ),
    ),
  );
}
void _showDeleteDialog(BuildContext context, CookbookModel item) {
  showDialog(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Hapus Resep'),
      content: Text('Apakah Anda yakin ingin menghapus "${item.recipeName}" dari buku resep?'),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Batal'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            foregroundColor: Colors.white,
          ),
          onPressed: () async {
            try {
              final provider = Provider.of<CookbookProvider>(context, listen: false);
              
              await provider.deleteCookbookItem(item.id.toString());

              if (!context.mounted) return;
              Navigator.pop(context); 

              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Resep berhasil dihapus!')),
              );
            } catch (e) {
              if (!context.mounted) return;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Gagal menghapus: $e')),
              );
            }
          },
          child: const Text('Hapus'),
        ),
      ],
    ),
  );
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Resep Saya'),
        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: Consumer<CookbookProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.cookbookItems.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.book_outlined,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Belum Ada Resep Tersimpan',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Resep favorit Anda akan muncul di halaman ini.',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
              itemCount: provider.cookbookItems.length,
              itemBuilder: (context, index) {
                  final item = provider.cookbookItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: ListTile(
                      leading: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Image.network(
                          item.imageUrl,
                          width: 50,
                          height: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                      title: Text(
                        item.recipeName,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text('Catatan: ${item.note}'),
                      onTap: () {
                        _showRecipeDetail(context, item);
                      },
                      trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                                IconButton(
                                  icon: const Icon(Icons.edit, color: Colors.orange),
                                  onPressed: () => _showEditDialog(context, item),
                                  tooltip: 'Edit Resep',
                                ),
                                IconButton(
                                  icon: const Icon(Icons.delete, color: Colors.red),
                                  onPressed: () => _showDeleteDialog(context, item),
                                  tooltip: 'Hapus Resep',
                                ),
                              ],
                            ),
                        ),
                    );
                },
            );
          },
        ),
      );
    }
}