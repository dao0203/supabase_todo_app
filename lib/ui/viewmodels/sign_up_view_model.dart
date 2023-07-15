import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:supabase_todo_app/di/data_source_providers.dart';

part 'sign_up_view_model.g.dart';

@riverpod
class SignUpViewModel extends _$SignUpViewModel {
  @override
  void build() {
    return;
  }

  Future<void> signUp(String email, String password) async {
    await ref.read(authDataSourceProvider).signup(email, password);
  }
}
