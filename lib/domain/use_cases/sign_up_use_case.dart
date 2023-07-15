import 'package:supabase_todo_app/data/sources/auth_data_source.dart';

class SignUpUseCase {
  final AuthDataSource _authDataSource;

  SignUpUseCase(this._authDataSource);

  Future<void> call(String email, String password) async {
    await _authDataSource.signup(email, password);
  }
}
