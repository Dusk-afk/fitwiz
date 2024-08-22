import 'package:fitwiz/features/event/data/models/event_activity.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('EventActivity', () {
    test('should return valid model if valid json', () {
      final eventActivityJson = {
        'activity_type': 'Running',
        'daily_target_km': 10.0,
      };

      final eventActivity = EventActivity.fromJson(eventActivityJson);

      expect(eventActivity.activityType, 'Running');
      expect(eventActivity.dailyTargetKm, 10.0);
    });
  });
}
