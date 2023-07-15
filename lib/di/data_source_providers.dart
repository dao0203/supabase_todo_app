import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_todo_app/data/sources/supabase_todo_data_source.dart';
import 'package:supabase_todo_app/data/sources/todo_data_source.dart';

final todoDataSourceProvider = Provider<TodoDataSource>((ref) {
  return SupabaseTodoDataSource();
});
