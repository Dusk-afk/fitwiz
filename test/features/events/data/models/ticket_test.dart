import 'package:fitwiz/features/event/data/models/ticket.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('Ticket', () {
    test('should return a valid model', () {
      final ticketJson = {
        'payment_id': 123,
        'ticket_number': '123456',
        'issued_at': '2021-10-10T10:00:00Z',
      };

      final ticket = Ticket.fromJson(ticketJson);

      expect(ticket.paymentId, 123);
      expect(ticket.ticketNumber, '123456');
      expect(ticket.issuedAt, DateTime.parse('2021-10-10T10:00:00Z'));
    });

    test('should return a valid model with null values', () {
      final ticketJson = {
        'ticket_number': '123456',
        'issued_at': '2021-10-10T10:00:00Z',
      };

      final ticket = Ticket.fromJson(ticketJson);

      expect(ticket.paymentId, null);
      expect(ticket.ticketNumber, '123456');
      expect(ticket.issuedAt, DateTime.parse('2021-10-10T10:00:00Z'));
    });
  });
}
