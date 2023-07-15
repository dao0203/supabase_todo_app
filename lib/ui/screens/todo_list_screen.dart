import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_todo_app/ui/viewmodel/todo_list_view_model.dart';

class TodoListScreen extends HookConsumerWidget {
  const TodoListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final todoController = useTextEditingController();
    final todoList = ref.watch(todoListViewModelProvider);
    final isWaiting = useState(false);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo List'),
      ),
      body: Column(
        children: [
          Expanded(
            child: todoList.when(
              data: (todos) => ListView.builder(
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  final todo = todos[index];
                  return ListTile(
                    title: Text(todo.todo),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await ref
                            .read(todoListViewModelProvider.notifier)
                            .delete(todo.id);
                      },
                    ),
                  );
                },
              ),
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, s) => Center(child: Text(e.toString())),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: todoController,
                    decoration: const InputDecoration(
                      hintText: 'Todo',
                    ),
                    readOnly: isWaiting.value,
                  ),
                ),
                IconButton(
                  icon: isWaiting.value
                      ? const CircularProgressIndicator()
                      : const Icon(Icons.add),
                  onPressed: () async {
                    isWaiting.value = true;
                    await ref
                        .read(todoListViewModelProvider.notifier)
                        .add(todoController.text)
                        .then((value) => isWaiting.value = false);
                    todoController.clear();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
