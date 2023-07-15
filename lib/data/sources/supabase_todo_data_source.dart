import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_todo_app/data/sources/todo_data_source.dart';

class SupabaseTodoDataSource implements TodoDataSource {
  final SupabaseClient client = Supabase.instance.client;

  @override
  Stream<List> getAll() {
    return client.from('todos').stream(primaryKey: ['id']);
  }

  @override
  Future<void> insert(String todo) async {
    await client.from('todos').insert([
      {'todo': todo}
    ]);
  }

  @override
  Future<void> delete(int id) async {
    await client.from('todos').delete().eq('id', id);
  }

  @override
  Future<void> update(int id, String todo) async {
    await client.from('todos').update({'todo': todo}).eq('id', id);
  }
}
