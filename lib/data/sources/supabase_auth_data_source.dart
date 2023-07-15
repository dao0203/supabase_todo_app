import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:supabase_todo_app/data/sources/auth_data_source.dart';

class SupabaseAuthDataSource implements AuthDataSource {
  final GoTrueClient _auth = Supabase.instance.client.auth;
  @override
  Future<void> signIn(String email, String password) async {
    await _auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  @override
  Future<void> signOut() async {
    await _auth.signOut();
  }

  @override
  Future<void> signup(String email, String password) async {
    await _auth.signUp(password: password, email: email);
  }
}
