part of 'my_event_details_bloc.dart';

sealed class MyEventDetailsEvent extends Equatable {
  const MyEventDetailsEvent();

  @override
  List<Object> get props => [];
}

final class FetchMyEventDetails extends MyEventDetailsEvent {
  final int eventId;

  const FetchMyEventDetails({
    required this.eventId,
  });

  @override
  List<Object> get props => [eventId];
}

final class MyEventDetailsCreateTeam extends MyEventDetailsEvent {
  final Event event;
  final String teamName;

  const MyEventDetailsCreateTeam({
    required this.event,
    required this.teamName,
  });

  @override
  List<Object> get props => [event, teamName];
}

final class MyEventDetailsJoinTeam extends MyEventDetailsEvent {
  final Event event;
  final String teamCode;

  const MyEventDetailsJoinTeam({
    required this.event,
    required this.teamCode,
  });

  @override
  List<Object> get props => [event, teamCode];
}
