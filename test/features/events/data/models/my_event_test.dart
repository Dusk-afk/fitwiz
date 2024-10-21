import 'package:fitwiz/features/event/data/models/activity.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/data/models/ticket.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEvent extends Mock implements Event {}

class MockMyEvent extends Mock implements MyEvent {}

void main() {
  group('MyEvent', () {
    final event = MockEvent();
    final ticket = Ticket(
        paymentId: 123,
        ticketNumber: '123456',
        issuedAt: DateTime.parse('2021-10-10T10:00:00Z'));
    final activities = [
      Activity(
        id: 1,
        activityType: 'Running',
        distanceKm: 5.0,
        startDateTime: DateTime.parse('2021-10-10T10:00:00Z'),
        endDateTime: DateTime.parse('2021-10-10T10:30:00Z'),
      ),
      Activity(
        id: 2,
        activityType: 'Running',
        distanceKm: 10.0,
        startDateTime: DateTime.parse('2021-10-10T11:00:00Z'),
        endDateTime: DateTime.parse('2021-10-10T12:10:00Z'),
      ),
    ];

    test('should return a valid model', () {
      final myEventJson = {
        'event_id': 1,
        'activities': [],
        'ticket': {
          'payment_id': 123,
          'ticket_number': '123456',
          'issued_at': '2021-10-10T10:00:00Z',
        },
      };

      final mockEvent = MockEvent();
      when(() => mockEvent.id).thenReturn(1);

      final myEvent = MyEvent.fromJsonEvent(myEventJson, mockEvent);

      expect(myEvent.event.id, 1);
      expect(myEvent.activities, []);
      expect(myEvent.ticket.paymentId, 123);
      expect(myEvent.ticket.ticketNumber, '123456');
      expect(myEvent.ticket.issuedAt, DateTime.parse('2021-10-10T10:00:00Z'));
    });

    test('should calculate total distance correctly', () {
      final myEvent =
          MyEvent(event: event, activities: activities, ticket: ticket);

      expect(myEvent.getTotalDistanceKm(), 15.0);
    });

    test('should calculate total duration correctly', () {
      final myEvent =
          MyEvent(event: event, activities: activities, ticket: ticket);

      expect(myEvent.getTotalDuration(), const Duration(hours: 1, minutes: 40));
    });

    test('should calculate average pace correctly', () {
      final myEvent =
          MyEvent(event: event, activities: activities, ticket: ticket);

      expect(myEvent.getAveragePace(), const Duration(minutes: 6, seconds: 40));
    });

    test('should calculate number of days', () {
      final mockEvent = MockEvent();

      when(() => mockEvent.startDateTime).thenReturn(DateTime(2024, 01, 01));
      when(() => mockEvent.endDateTime).thenReturn(DateTime(2024, 01, 21));

      final myEvent = MyEvent(
        event: mockEvent,
        activities: const [],
        ticket: ticket,
      );

      expect(myEvent.getNumberOfDays(), 20);
    });

    test('should calculate number of days passed', () {
      final mockEvent = MockEvent();

      DateTime now = DateTime.now();

      when(() => mockEvent.startDateTime)
          .thenReturn(now.subtract(const Duration(days: 10)));

      final myEvent = MyEvent(
        event: mockEvent,
        activities: const [],
        ticket: ticket,
      );

      expect(myEvent.getNumberOfDaysPassed(), 10);
    });
  });
}
