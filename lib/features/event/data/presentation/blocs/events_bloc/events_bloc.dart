import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fitwiz/core/setup_locator.dart';
import 'package:fitwiz/features/event/data/models/event.dart';
import 'package:fitwiz/features/event/data/repositories/event_repository.dart';

part 'events_event.dart';
part 'events_state.dart';

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  late final EventRepository _eventRepository;

  EventsBloc([EventRepository? eventRepository])
      : super(const EventsSuccess()) {
    _eventRepository = eventRepository ?? locator<EventRepository>();

    on<FetchEvents>(_onFetchEvents);
  }

  void _onFetchEvents(FetchEvents event, Emitter<EventsState> emit) async {
    final EventsState loadingState;
    if (state is EventsSuccess) {
      loadingState = (state as EventsSuccess).copyWith(isLoading: true);
    } else {
      loadingState = const EventsSuccess(isLoading: true);
    }
    emit(loadingState);

    try {
      final events = await _eventRepository.getEvents();
      emit(EventsSuccess(events: events));
    } catch (e) {
      emit(EventsError(message: e.toString()));
    }
  }
}
