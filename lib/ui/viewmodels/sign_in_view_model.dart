import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_todo_app/di/data_source_providers.dart';

part 'sign_in_view_model.g.dart';

@riverpod
class SignInViewModel extends _$SignInViewModel {
  @override
  void build() {
    return;
  }

  Future<void> login(String email, String password) async {
    await ref.read(authDataSourceProvider).signIn(email, password);
  }
}
