import 'package:fitwiz/features/event/data/models/session.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Session', () {
    test('should return valid model if valid json', () {
      final sessionJson = {
        'id': 1,
        'name': 'Session 1',
        'description': 'Session 1 description',
        'start_datetime': '2022-01-01T00:00:00Z',
        'end_datetime': '2022-01-02T00:00:00Z',
        'goodies': [],
      };

      final session = Session.fromJson(sessionJson);

      expect(session.id, 1);
      expect(session.name, 'Session 1');
      expect(session.description, 'Session 1 description');
      expect(session.startDateTime, DateTime.utc(2022, 1, 1));
      expect(session.endDateTime, DateTime.utc(2022, 1, 2));
      expect(session.goodies.length, 0);
    });
  });
}
