import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        backgroundColor: Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          bool isWide = constraints.maxWidth > 600;
          return SafeArea(
            child: Center(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: isWide ? 60 : 50,
                      backgroundColor: Color.fromARGB(255, 255, 156, 43),
                      foregroundColor: Colors.white,
                      child: const Icon(Icons.person, size: 50),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'I Wayan Agus Wredhi Putra',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      'NIM: 2415051007',
                      style: TextStyle(fontSize: 16, color: Colors.grey),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'Pendidikan Teknik Informatika',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      isWide ? '(Tampilan Responsif: Layar Lebar)' : '(Tampilan Responsif: Ponsel)',
                      style: TextStyle(fontSize: 12, color: Theme.of(context).colorScheme.primary),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}