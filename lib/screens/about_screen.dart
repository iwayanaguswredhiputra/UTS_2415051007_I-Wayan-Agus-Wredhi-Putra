import 'package:flutter/material.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Saya'),
        backgroundColor: const Color.fromARGB(255, 255, 156, 43),
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 20),
            Container(
                          padding: const EdgeInsets.all(20),
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 255, 156, 43),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.person,
                            size: 72,
                            color: Color.fromARGB(255, 235, 231, 226),
                          ),
                        ),
            const SizedBox(height: 16),
            const Text(
              'I Wayan Agus Wredhi Putra',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            const Text(
              'Mahasiswa Kelas PTI 5B',
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 16),

            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'Identitas Pengguna',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color.fromARGB(255, 255, 156, 43),
                      ),
                    ),
                    SizedBox(height: 12),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.badge, color: Colors.orange),
                      title: Text('2415051007'),
                      subtitle: Text('NIM'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.school, color: Colors.orange),
                      title: Text('Pendidikan Teknik Informatika'),
                      subtitle: Text('Program Studi'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.business, color: Colors.orange),
                      title: Text('Fakultas Teknik dan Kejuruan'),
                      subtitle: Text('Fakultas'),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: Icon(Icons.account_balance, color: Colors.orange),
                      title: Text('Universitas Pendidikan Ganesha'),
                      subtitle: Text('Institusi'),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}