import 'package:fitwiz/features/auth/data/models/register_user_data.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('RegisterUserData', () {
    test('should return a valid model', () {
      final data = {
        'name': 'Piyush',
        'email': 'piyush@fit-wiz.com',
        'password': 'password',
        'salutation': 'Mr',
        'gender': 'Male',
        'date_of_birth': '2000-01-02',
      };

      final model = RegisterUserData.fromJson(data);
      expect(
        model,
        RegisterUserData(
          salutation: 'Mr',
          name: 'Piyush',
          gender: 'Male',
          dateOfBirth: DateTime(2000, 1, 2),
          email: 'piyush@fit-wiz.com',
          password: 'password',
        ),
      );
    });

    test('should return a json from model', () {
      final model = RegisterUserData(
        salutation: 'Mr',
        name: 'Piyush',
        gender: 'Male',
        dateOfBirth: DateTime(2000, 1, 2),
        email: 'piyush@fit-wiz.com',
        password: 'password',
      );

      final json = model.toJson();

      expect(
        json,
        {
          'salutation': 'Mr',
          'name': 'Piyush',
          'gender': 'Male',
          'date_of_birth': '2000-01-02',
          'email': 'piyush@fit-wiz.com',
          'password': 'password',
        },
      );
    });
  });
}
