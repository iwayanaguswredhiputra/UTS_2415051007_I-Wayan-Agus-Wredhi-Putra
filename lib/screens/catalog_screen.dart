import 'package:flutter/material.dart';

class CatalogScreen extends StatelessWidget {
  const CatalogScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Katalog Resep Masakan'),
        backgroundColor: Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          return Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    isWide ? Icons.tablet_mac : Icons.phone_android,
                    size: 64,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    isWide ? 'Katalog - Mode Layar Lebar' : 'Katalog - Mode Ponsel',
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tata letak responsif diterapkan pada halaman katalog.',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}