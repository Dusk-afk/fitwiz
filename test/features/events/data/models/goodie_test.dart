import 'package:fitwiz/features/event/data/models/goodie.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Goodie', () {
    test('should return valid model if valid json', () {
      final goodieJson = {
        'id': 1,
        'name': 'Goodie 1',
        'description': 'Goodie 1 description',
        'quantity': 10,
      };

      final goodie = Goodie.fromJson(goodieJson);

      expect(goodie.id, 1);
      expect(goodie.name, 'Goodie 1');
      expect(goodie.description, 'Goodie 1 description');
      expect(goodie.quantity, 10);
    });
  });
}
