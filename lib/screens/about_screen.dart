import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profil'),
      ),
      body: const Center(
        child: Text('I Wayan Agus Wredhi Putra - 2415051007'),
      ),
    );
  }
}