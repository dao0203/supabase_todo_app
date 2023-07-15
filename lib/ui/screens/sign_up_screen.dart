import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_todo_app/ui/screens/todo_list_screen.dart';
import 'package:supabase_todo_app/ui/viewmodels/sign_up_view_model.dart';

class SignUpScreen extends HookConsumerWidget {
  const SignUpScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //簡易的な登録画面を実装
    // emailとpasswordとusernameの状態を管理する
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: emailController,
              decoration: const InputDecoration(
                hintText: 'email',
              ),
            ),
            TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                hintText: 'password',
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                await ref
                    .read(signUpViewModelProvider.notifier)
                    .signUp(
                      emailController.text,
                      passwordController.text,
                    )
                    .then((value) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const TodoListScreen()));
                }).catchError(
                  (e) {
                    Navigator.of(context).pop();
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Error'),
                          content: Text(e.toString()),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                              child: const Text('OK'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
              child: const Text('Sign up'),
            ),
          ],
        ),
      ),
    );
  }
}
