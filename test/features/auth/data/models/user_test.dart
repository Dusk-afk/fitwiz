import 'package:fitwiz/features/auth/data/models/user.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('User', () {
    test('should return a valid model when the JSON is valid', () {
      final Map<String, dynamic> jsonMap = {
        "salutation": "Mr",
        "name": "Piyush",
        "gender": "Male",
        "date_of_birth": "2004-06-12",
        "email": "piyush@fit-wiz.com",
        "is_admin": true,
      };

      expect(
        User.fromJson(jsonMap),
        User(
          salutation: "Mr",
          name: "Piyush",
          gender: "Male",
          dateOfBirth: DateTime(2004, 6, 12),
          email: "piyush@fit-wiz.com",
          isAdmin: true,
        ),
      );
    });

    test('should return a JSON map containing the proper data', () {
      final user = User(
        salutation: "Mr",
        name: "Piyush",
        gender: "Male",
        dateOfBirth: DateTime(2004, 6, 12),
        email: "piyush@fit-wiz.com",
        isAdmin: true,
      );

      final expectedJson = {
        "salutation": "Mr",
        "name": "Piyush",
        "gender": "Male",
        "date_of_birth": "2004-06-12",
        "email": "piyush@fit-wiz.com",
        "is_admin": true,
      };

      expect(user.toJson(), expectedJson);
    });
  });
}
