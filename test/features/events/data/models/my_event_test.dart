import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockEvent extends Mock implements Event {}

void main() {
  group('MyEvent', () {
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
  });
}
