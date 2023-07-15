interface class AuthDataSource {
  Future<void> signIn(String email, String password) =>
      throw UnimplementedError();
  Future<void> signup(String email, String password) =>
      throw UnimplementedError();
  Future<void> signOut() => throw UnimplementedError();
}
