part of 'my_events_bloc.dart';

sealed class MyEventsEvent extends Equatable {
  const MyEventsEvent();

  @override
  List<Object> get props => [];
}

class FetchMyEvents extends MyEventsEvent {}
