import 'package:fitwiz/data/models/nullable.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Nullable', () {
    test('should return valid type of data', () {
      final nullable = Nullable<int>(1);

      expect(nullable.value, 1);
    });

    test('should return null if no data', () {
      final nullable = Nullable<int>(null);

      expect(nullable.value, null);
    });
  });
}
