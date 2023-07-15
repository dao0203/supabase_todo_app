import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_todo_app/ui/screens/sign_in_screen.dart';
import 'package:supabase_todo_app/ui/screens/todo_list_screen.dart';

class AuthGate extends StatefulWidget {
  const AuthGate({super.key});

  @override
  State<AuthGate> createState() => _AuthGateState();
}

class _AuthGateState extends State<AuthGate> {
  @override
  void initState() {
    super.initState();
    _redirect();
  }

  Future<void> _redirect() async {
    await Future.delayed(Duration.zero);
    if (!mounted) {
      return;
    }

    final session = Supabase.instance.client.auth.currentSession;
    if (session != null) {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const TodoListScreen(),
      ));
    } else {
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) => const SignInScreen(),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
