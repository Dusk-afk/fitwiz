import 'package:fitwiz/data/models/user_short.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('UserShort', () {
    test('should return valid model if valid json', () {
      final json = {
        'id': 1,
        'name': 'John Doe',
      };

      final model = UserShort.fromJson(json);

      expect(model, const UserShort(id: 1, name: 'John Doe'));
    });

    test('should return valid json if valid model', () {
      const model = UserShort(id: 1, name: 'John Doe');

      final json = model.toJson();

      expect(json, {
        'id': 1,
        'name': 'John Doe',
      });
    });
  });
}
