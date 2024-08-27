part of 'event_register_bloc.dart';

sealed class EventRegisterEvent extends Equatable {
  const EventRegisterEvent();

  @override
  List<Object> get props => [];
}

class RegisterEvent extends EventRegisterEvent {
  final int eventId;

  const RegisterEvent(this.eventId);

  @override
  List<Object> get props => [eventId];
}
