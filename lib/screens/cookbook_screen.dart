import 'package:flutter/material.dart';

class CookbookScreen extends StatelessWidget {
  const CookbookScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buku Resepku'),
      ),
      body: const Center(
        child: Text('Tampilan Dasar Buku Resep'),
      ),
    );
  }
}