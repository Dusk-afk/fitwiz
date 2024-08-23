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

  test('should calculate valid metrics', () {
    final activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 10.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T11:00:00Z'),
    );

    expect(activity.duration, const Duration(hours: 1));
    expect(activity.pace, const Duration(minutes: 6));
  });

  test(
      'should format duration and pace correctly for 1 hr 5 min 21 sec duration',
      () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 10.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T11:05:21Z'),
    );

    expect(activity.formattedDuration, '1 hr 5 min 21 sec');
    expect(activity.formattedPace, '6 min 32 sec');
  });

  test('should format duration and pace correctly for exactly 1 hour', () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 10.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T11:00:00Z'),
    );

    expect(activity.formattedDuration, '1 hr');
    expect(activity.formattedPace, '6 min');
  });

  test('should format duration and pace correctly for zero duration', () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 10.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
    );

    expect(activity.formattedDuration, '0 sec');
    expect(activity.formattedPace, '0 sec');
  });

  test('should format duration and pace correctly for zero distance', () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 0.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T11:10:00Z'),
    );

    expect(activity.formattedDuration, '1 hr 10 min');
    expect(activity.formattedPace, '0 sec');
  });

  test('should format duration and pace correctly for 10 min duration', () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 1.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T10:10:00Z'),
    );

    expect(activity.formattedDuration, '10 min');
    expect(activity.formattedPace, '10 min');
  });

  test('should format duration and pace correctly for 10 sec duration', () {
    Activity activity = Activity(
      id: 1,
      activityType: 'Running',
      distanceKm: 1.00,
      startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
      endDateTime: DateTime.parse('2021-10-10T10:00:10Z'),
    );

    expect(activity.formattedDuration, '10 sec');
    expect(activity.formattedPace, '10 sec');
  });
}
