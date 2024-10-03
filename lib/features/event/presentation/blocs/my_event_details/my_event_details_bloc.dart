import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/data/models/nullable.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/models/event_team.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';
import 'package:fitwiz/features/event/presentation/blocs/events_bloc/events_bloc.dart';

part 'my_event_details_event.dart';
part 'my_event_details_state.dart';

class MyEventDetailsBloc
    extends Bloc<MyEventDetailsEvent, MyEventDetailsState> {
  final EventsBloc _eventsBloc;
  final EventRepository _eventRepository;

  MyEventDetailsBloc(
    this._eventsBloc,
    this._eventRepository, [
    MyEventDetailsState? initialState,
  ]) : super(initialState ?? const MyEventDetailsState(isLoading: true)) {
    on<FetchMyEventDetails>(_onFetchMyEventDetails);
    on<MyEventDetailsCreateTeam>(_onMyEventDetailsCreateTeam);
    on<MyEventDetailsJoinTeam>(_onMyEventDetailsJoinTeam);
  }

  void _onFetchMyEventDetails(
    FetchMyEventDetails event,
    Emitter<MyEventDetailsState> emit,
  ) async {
    try {
      if (_eventsBloc.state is! EventsSuccess ||
          (_eventsBloc.state as EventsSuccess).isLoading) {
        emit(const MyEventDetailsState(errorMessage: 'Events not loaded'));
        return;
      }

      final Event eventObj = (_eventsBloc.state as EventsSuccess)
          .events
          .firstWhere((element) => element.id == event.eventId);

      final EventTeam? eventTeam =
          await _eventRepository.getEventTeam(event.eventId);

      emit(MyEventDetailsState(event: eventObj, eventTeam: eventTeam));
    } catch (e) {
      emit(MyEventDetailsState(errorMessage: e.toString()));
    }
  }

  void _onMyEventDetailsCreateTeam(
    MyEventDetailsCreateTeam event,
    Emitter<MyEventDetailsState> emit,
  ) async {
    MyEventDetailsState oldState = state;
    if (state.event == null || state.isLoading || state.isUpdating) {
      // Events not loaded or already updating
      return emit(oldState);
    }

    try {
      emit(oldState.copyWith(
        isUpdating: true,
        updatingMessage: Nullable('Creating team'),
        errorMessage: Nullable(null),
      ));

      final EventTeam team = await _eventRepository.createEventTeam(
        event.event.id,
        event.teamName,
      );

      emit(oldState.copyWith(
        eventTeam: Nullable(team),
        updatingMessage: Nullable(null),
        errorMessage: Nullable(null),
      ));
    } catch (e) {
      emit(oldState.copyWith(
        updatingMessage: Nullable(null),
        errorMessage: Nullable(e.toString()),
      ));
    }
  }

  void _onMyEventDetailsJoinTeam(
    MyEventDetailsJoinTeam event,
    Emitter<MyEventDetailsState> emit,
  ) async {
    MyEventDetailsState oldState = state;
    if (state.event == null || state.isLoading || state.isUpdating) {
      // Events not loaded or already updating
      return emit(oldState);
    }

    try {
      emit(oldState.copyWith(
        isUpdating: true,
        updatingMessage: Nullable('Joining team'),
        errorMessage: Nullable(null),
      ));

      final EventTeam team = await _eventRepository.joinEventTeam(
        event.event.id,
        event.teamCode,
      );

      emit(oldState.copyWith(
        eventTeam: Nullable(team),
        updatingMessage: Nullable(null),
        errorMessage: Nullable(null),
      ));
    } catch (e) {
      emit(oldState.copyWith(
        updatingMessage: Nullable(null),
        errorMessage: Nullable(e.toString()),
      ));
    }
  }
}
