import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/cookbook_model.dart';

class SupabaseService {
  final SupabaseClient _client = Supabase.instance.client;

  Future<List<CookbookModel>> getCookbookItems() async {
    final response = await _client
        .from('my_cookbook')
        .select()
        .order('created_at', ascending: false);
    return (response as List).map((json) => CookbookModel.fromJson(json)).toList();
  }

  Future<void> addToCookbook(CookbookModel item) async {
    await _client.from('my_cookbook').insert(item.toJson());
  }

  Future<void> updateCookbookItem(int id, Map<String, dynamic> data) async {
    await _client.from('my_cookbook').update(data).eq('id', id);
  }

  Future<void> deleteCookbookItem(int id) async {
    await _client.from('my_cookbook').delete().eq('id', id);
  }
}