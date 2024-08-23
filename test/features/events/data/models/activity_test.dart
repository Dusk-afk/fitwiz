import 'package:fitwiz/features/event/data/models/activity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Activity', () {
    test('should return a valid model', () {
      final activityJson = {
        'id': 1,
        'activity_type': 'Running',
        'distance_km': 5.0,
        'start_datetime': '2021-10-10T10:00:00Z',
        'end_datetime': '2021-10-10T11:00:00Z',
      };

      final activity = Activity.fromJson(activityJson);

      expect(activity.id, 1);
      expect(activity.activityType, 'Running');
      expect(activity.distanceKm, 5.0);
      expect(activity.startDateTime, DateTime.parse('2021-10-10T10:00:00Z'));
      expect(activity.endDateTime, DateTime.parse('2021-10-10T11:00:00Z'));
    });
  });
}
