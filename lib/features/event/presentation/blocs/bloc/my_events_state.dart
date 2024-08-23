part of 'my_events_bloc.dart';

sealed class MyEventsState extends Equatable {
  const MyEventsState();

  @override
  List<Object> get props => [];
}

final class MyEventsInitial extends MyEventsState {}

final class MyEventsSuccess extends MyEventsState {
  final bool isLoading;
  final List<MyEvent> myEvents;

  const MyEventsSuccess({
    this.isLoading = false,
    this.myEvents = const [],
  });

  @override
  List<Object> get props => [isLoading, myEvents];

  MyEventsSuccess copyWith({
    bool? isLoading,
    List<MyEvent>? myEvents,
  }) {
    return MyEventsSuccess(
      isLoading: isLoading ?? this.isLoading,
      myEvents: myEvents ?? this.myEvents,
    );
  }
}

class MyEventsError extends MyEventsState {
  final String message;

  const MyEventsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}
