import 'package:supabase_flutter/supabase_flutter.dart';

class SupabaseTodoDataSource {
  final SupabaseClient client = Supabase.instance.client;
  Stream<List> getAll() {
    return client.from('todos').stream(primaryKey: ['id']);
  }

  Future<void> insert(String todo) async {
    await client.from('todos').insert([
      {'todo': todo}
    ]);
  }

  Future<void> delete(int id) async {
    await client.from('todos').delete().eq('id', id);
  }

  Future<void> update(int id, String todo) async {
    await client.from('todos').update({'todo': todo}).eq('id', id);
  }
}
