part of 'events_bloc.dart';

sealed class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object> get props => [];
}

final class EventsSuccess extends EventsState {
  final bool isLoading;
  final List<Event> events;

  const EventsSuccess({
    this.isLoading = false,
    this.events = const [],
  });

  @override
  List<Object> get props => [isLoading, events];

  EventsSuccess copyWith({
    bool? isLoading,
    List<Event>? events,
  }) {
    return EventsSuccess(
      isLoading: isLoading ?? this.isLoading,
      events: events ?? this.events,
    );
  }
}

final class EventsError extends EventsState {
  final String message;

  const EventsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
