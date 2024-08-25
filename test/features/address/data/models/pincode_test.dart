import 'package:fitwiz/features/address/data/models/pincode.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Pincode', () {
    test('should return valid model if valid json', () {
      final json = {
        'pincode': 1,
        'city': 'A',
        'state': 'B',
        'country': 'C',
      };

      final model = Pincode.fromJson(json);

      expect(
          model,
          const Pincode(
            pincode: 1,
            city: 'A',
            state: 'B',
            country: 'C',
          ));
    });
  });
}
