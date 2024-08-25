import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:fitwiz/features/address/data/models/tower_short.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('TowerShort', () {
    test('should return valid model if valid json', () {
      final json = {
        'id': 1,
        'name': 'N',
      };

      final model = TowerShort.fromJson(json);

      expect(
          model,
          const TowerShort(
            id: 1,
            name: 'N',
          ));
    });

    test('should return valid model using tower', () {
      const tower = Tower(id: 1, name: 'T', society: Society(id: 1, name: 'S'));

      final model = TowerShort.fromTower(tower);

      expect(
          model,
          const TowerShort(
            id: 1,
            name: 'T',
          ));
    });
  });
}
