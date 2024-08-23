// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ticket.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Ticket _$TicketFromJson(Map<String, dynamic> json) => Ticket(
      paymentId: (json['payment_id'] as num?)?.toInt(),
      ticketNumber: json['ticket_number'] as String,
      issuedAt: DateTime.parse(json['issued_at'] as String),
    );

Map<String, dynamic> _$TicketToJson(Ticket instance) => <String, dynamic>{
      'payment_id': instance.paymentId,
      'ticket_number': instance.ticketNumber,
      'issued_at': instance.issuedAt.toIso8601String(),
    };
