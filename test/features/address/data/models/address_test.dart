import 'package:fitwiz/features/address/data/models/address.dart';
import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:fitwiz/features/address/data/models/society.dart';
import 'package:fitwiz/features/address/data/models/tower.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Address', () {
    test('should return valid model if valid json', () {
      const pincode = Pincode(pincode: 1, city: 'A', state: 'B', country: 'C');
      const tower = Tower(id: 1, name: 'T', society: Society(id: 1, name: 'S'));
      final json = {
        'name': 'N',
        'pincode': pincode.toJson(),
        'line_1': 'L1',
        'line_2': 'L2',
        'landmark': 'LM',
        'mobile': 'M',
        'tower': tower.toJson(),
      };

      final model = Address.fromJson(json);

      expect(
          model,
          const Address(
            name: 'N',
            pincode: pincode,
            line1: 'L1',
            line2: 'L2',
            landmark: 'LM',
            mobile: 'M',
            tower: tower,
          ));
    });
  });

  test('should return valid model from jsonPincodeTower', () {
    const pincode = Pincode(pincode: 1, city: 'A', state: 'B', country: 'C');
    const tower = Tower(id: 1, name: 'T', society: Society(id: 1, name: 'S'));

    final json = {
      'name': 'N',
      'line_1': 'L1',
      'line_2': 'L2',
      'landmark': 'LM',
      'mobile': 'M',
    };

    final model = Address.fromJsonPincodeTower(json, pincode, tower);

    expect(
        model,
        const Address(
          name: 'N',
          pincode: pincode,
          line1: 'L1',
          line2: 'L2',
          landmark: 'LM',
          mobile: 'M',
          tower: tower,
        ));
  });

  test('should return valid update json', () {
    const address = Address(
      name: 'N',
      pincode: Pincode(pincode: 1, city: 'A', state: 'B', country: 'C'),
      line1: 'L1',
      line2: 'L2',
      landmark: 'LM',
      mobile: 'M',
      tower: Tower(id: 1, name: 'T', society: Society(id: 1, name: 'S')),
    );

    final json = address.toUpdateJson();

    expect(json, {
      'name': 'N',
      'pincode': 1,
      'line_1': 'L1',
      'line_2': 'L2',
      'landmark': 'LM',
      'mobile': 'M',
      'tower_id': 1,
    });
  });
}
