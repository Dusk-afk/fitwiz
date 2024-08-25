class MockException implements Exception {
  final String message;

  MockException(this.message);

  @override
  String toString() => message;
}
