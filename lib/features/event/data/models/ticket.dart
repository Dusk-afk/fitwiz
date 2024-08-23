import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ticket.g.dart';

@JsonSerializable()
class Ticket extends Equatable {
  @JsonKey(name: 'payment_id')
  final int? paymentId;

  @JsonKey(name: 'ticket_number')
  final String ticketNumber;

  @JsonKey(name: 'issued_at')
  final DateTime issuedAt;

  const Ticket({
    required this.paymentId,
    required this.ticketNumber,
    required this.issuedAt,
  });

  factory Ticket.fromJson(Map<String, dynamic> json) => _$TicketFromJson(json);

  Map<String, dynamic> toJson() => _$TicketToJson(this);

  @override
  List<Object?> get props => [paymentId, ticketNumber, issuedAt];
}
