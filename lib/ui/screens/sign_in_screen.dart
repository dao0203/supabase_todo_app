import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:supabase_todo_app/ui/screens/sign_up_screen.dart';
import 'package:supabase_todo_app/ui/screens/todo_list_screen.dart';
import 'package:supabase_todo_app/ui/viewmodels/sign_in_view_model.dart';

class SignInScreen extends HookConsumerWidget {
  const SignInScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // emailとpasswordの状態を管理する
    final emailController = useTextEditingController();
    final passwordController = useTextEditingController();
    //簡易的ななログイン画面を実装する
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
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
                  context: context,
                  builder: (context) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                );
                await ref
                    .read(signInViewModelProvider.notifier)
                    .login(
                      emailController.text,
                      passwordController.text,
                    )
                    .then((value) {
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                    builder: (context) => const TodoListScreen(),
                  ));
                }).catchError((e) {
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
                });
              },
              child: const Text('Login'),
            ),
            ElevatedButton(
              onPressed: () {
                // 登録画面に遷移する
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const SignUpScreen(),
                  ),
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
