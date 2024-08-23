import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:fitwiz/features/event/data/models/my_event.dart';
import 'package:fitwiz/features/event/data/presentation/blocs/events_bloc/events_bloc.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';

part 'my_events_event.dart';
part 'my_events_state.dart';

class MyEventsBloc extends Bloc<MyEventsEvent, MyEventsState> {
  final AuthBloc _authBloc;
  final EventsBloc _eventsBloc;
  final EventRepository _eventRepository;

  MyEventsBloc(this._authBloc, this._eventsBloc, this._eventRepository)
      : super(MyEventsInitial()) {
    on<FetchMyEvents>(_onFetchMyEvents);
  }

  void _onFetchMyEvents(
    FetchMyEvents event,
    Emitter<MyEventsState> emit,
  ) async {
    if (_authBloc.state is! AuthLoggedIn) {
      emit(const MyEventsError(message: 'Not logged in'));
      return;
    }

    if (_eventsBloc.state is! EventsSuccess ||
        (_eventsBloc.state as EventsSuccess).isLoading) {
      emit(const MyEventsError(message: 'Events not loaded'));
      return;
    }

    final MyEventsState loadingState;
    if (state is MyEventsSuccess) {
      loadingState = (state as MyEventsSuccess).copyWith(isLoading: true);
    } else {
      loadingState = const MyEventsSuccess(isLoading: true);
    }
    emit(loadingState);

    try {
      final myEvents = await _eventRepository.getMyEvents();
      emit(MyEventsSuccess(myEvents: myEvents));
    } catch (e) {
      emit(MyEventsError(message: e.toString()));
    }
  }
}
