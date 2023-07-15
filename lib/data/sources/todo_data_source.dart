interface class TodoDataSource {
  Stream<List> getAll() => throw UnimplementedError();
  Future<void> insert(String todo) => throw UnimplementedError();
  Future<void> delete(int id) => throw UnimplementedError();
  Future<void> update(int id, String todo) => throw UnimplementedError();
}
