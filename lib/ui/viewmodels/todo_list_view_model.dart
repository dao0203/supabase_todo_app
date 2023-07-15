import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_todo_app/di/data_source_providers.dart';
import 'package:supabase_todo_app/domain/models/todo.dart';

part 'todo_list_view_model.g.dart';

@riverpod
class TodoListViewModel extends _$TodoListViewModel {
  @override
  Stream<List<Todo>> build() {
    return ref
        .watch(todoDataSourceProvider)
        .getAll()
        .map((event) => event.map((e) {
              return Todo(
                id: e['id'],
                todo: e['todo'],
                createdAt: e['created_at'],
              );
            }).toList());
  }

  Future<void> add(String todo) async {
    await ref.watch(todoDataSourceProvider).insert(todo);
  }

  Future<void> delete(int id) async {
    await ref.watch(todoDataSourceProvider).delete(id);
  }

  Future<void> updateTodo(Todo todo) async {
    await ref.watch(todoDataSourceProvider).update(todo.id, todo.todo);
  }
}
