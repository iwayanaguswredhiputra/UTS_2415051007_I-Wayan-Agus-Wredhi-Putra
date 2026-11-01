import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:supabase_flutter/supabase_flutter.dart'; 
import 'providers/recipe_provider.dart';
import 'providers/cookbook_provider.dart'; 
import 'screens/home_screen.dart';
import 'repositories/recipe_repository.dart';
import 'services/recipe_api_service.dart';
import 'services/supabase_service.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://uuccwwybyracekitklyl.supabase.co',
    publishableKey: 'sb_publishable_Mol0d8yFFNJCW89x8Rm1WA_643Mq0uk',
  );
  runApp(const RecipeBookApp());
}

class RecipeBookApp extends StatelessWidget {
  const RecipeBookApp({super.key});

  @override
  Widget build(BuildContext context) {
    final apiService = ApiService();
    final supabaseService = SupabaseService();

    final recipeRepository = RecipeRepository(
      apiService: apiService,
      supabaseService: supabaseService,
    );

    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => RecipeProvider()),
        ChangeNotifierProvider(create: (_) => CookbookProvider(recipeRepository)),
      ],
      child: MaterialApp(
        title: 'RecipeBook ID',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color.fromARGB(255, 255, 156, 43),
          ),
          useMaterial3: true,
        ),
        home: const HomeScreen(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}