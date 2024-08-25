import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Society', () {
    test('should return valid model if valid json', () {
      final json = {
        'id': 1,
        'name': 'N',
      };

      final model = Society.fromJson(json);

      expect(
          model,
          const Society(
            id: 1,
            name: 'N',
          ));
    });
  });
}
