part of 'event_register_bloc.dart';

sealed class EventRegisterState extends Equatable {
  const EventRegisterState();

  @override
  List<Object> get props => [];
}

final class EventRegisterInitial extends EventRegisterState {}

final class EventRegisterLoading extends EventRegisterState {}

final class EventRegisterSuccess extends EventRegisterState {
  final String ticketNumber;
  const EventRegisterSuccess(this.ticketNumber);

  @override
  List<Object> get props => [ticketNumber];
}

final class EventRegisterError extends EventRegisterState {
  final String message;
  const EventRegisterError(this.message);

  @override
  List<Object> get props => [message];
}
