import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Tower', () {
    test('should return valid model is valid json', () {
      final json = {
        'id': 1,
        'name': 'T',
        'society': {
          'id': 1,
          'name': 'S',
        },
      };

      final model = Tower.fromJson(json);

      expect(
          model,
          const Tower(
            id: 1,
            name: 'T',
            society: Society(id: 1, name: 'S'),
          ));
    });

    test('should return valid model from jsonSociety', () {
      const society = Society(id: 1, name: 'S');

      final json = {
        'id': 1,
        'name': 'T',
      };

      final model = Tower.fromJsonSociety(json, society);

      expect(
          model,
          const Tower(
            id: 1,
            name: 'T',
            society: Society(id: 1, name: 'S'),
          ));
    });
  });
}
