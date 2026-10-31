import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:uts_2415051007_iwayanaguswredhiputra/screens/cookbook_screen.dart';
import 'providers/recipe_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uuccwwybyracekitklyl.supabase.co',
    publishableKey: 'sb_publishable_Mol0d8yFFNJCW89x8Rm1WA_643Mq0uk',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
      ],
      child: MaterialApp(
        title: 'RecipeBook ID',
        theme: ThemeData(
          primarySwatch: Colors.orange,
          useMaterial3: true,
        ),
        home: const CookbookScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}