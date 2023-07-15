import 'package:supabase_flutter/supabase_flutter.dart';

class TodoDataSource {
  final SupabaseClient client = Supabase.instance.client;
  Stream<List> getTodoList() {
    return client.from('todos').stream(primaryKey: ['id']);
  }

  Future<void> addTodoItem(String todo) async {
    await client.from('todos').insert([
      {'todo': todo}
    ]);
  }

  Future<void> deleteTodoItem(int id) async {
    await client.from('todos').delete().eq('id', id);
  }

  Future<void> updateTodoItem(int id, String todo) async {
    await client.from('todos').update({'todo': todo}).eq('id', id);
  }
}
