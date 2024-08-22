import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Event', () {
    test('should return valid event model from valid json', () {
      final eventJson = {
        'id': 1,
        'name': 'Event 1',
        'description': 'Event 1 description',
        'start_datetime': '2022-01-01T00:00:00Z',
        'end_datetime': '2022-01-02T00:00:00Z',
        'price': 100,
        'activities': [
          {
            'activity_type': 'Running',
            'daily_target_km': 10.0,
          },
        ],
        'goodies': [],
        'sessions': [],
      };

      final event = Event.fromJson(eventJson);

      expect(event.id, 1);
      expect(event.name, 'Event 1');
      expect(event.description, 'Event 1 description');
      expect(event.startDateTime, DateTime.utc(2022, 1, 1));
      expect(event.endDateTime, DateTime.utc(2022, 1, 2));
      expect(event.price, 100);
      expect(event.activities.length, 1);
      expect(event.goodies.length, 0);
      expect(event.sessions.length, 0);
    });
  });

  test('should return valid event model with null values', () {
    final eventJson = {
      'id': 1,
      'name': 'Event 1',
      'description': 'Event 1 description',
      'start_datetime': '2022-01-01T00:00:00Z',
      'end_datetime': '2022-01-02T00:00:00Z',
      'price': null,
      'goodies': [],
      'sessions': [],
    };

    final event = Event.fromJson(eventJson);

    expect(event.id, 1);
    expect(event.name, 'Event 1');
    expect(event.description, 'Event 1 description');
    expect(event.startDateTime, DateTime.utc(2022, 1, 1));
    expect(event.endDateTime, DateTime.utc(2022, 1, 2));
    expect(event.price, null);
    expect(event.activities.length, 0);
    expect(event.goodies.length, 0);
    expect(event.sessions.length, 0);
  });
}
